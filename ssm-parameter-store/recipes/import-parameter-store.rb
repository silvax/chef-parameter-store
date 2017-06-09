require 'aws-sdk'
require 'yaml'

stack = stack = search("aws_opsworks_stack").first
layer = layer = search("aws_opsworks_layer").first

ssm = Aws::SSM::Client.new(
  region: "us-east-1",
)
allparameters = {}
stackparameters = {}
allparameters[:all] = ssm.describe_parameters({filters: [{key: "Name", values: ["ow_#{stack['name']}_#{layer['shortname']}"]}]})

allparameters[:all][:parameters].each do |ssmparameter|
  resp = ssm.get_parameters({
    names: [ssmparameter[:name]],
    with_decryption: false,
  })
  node.default["#{resp[:parameters][0][:name]}"] = resp[:parameters][0][:value]
end
