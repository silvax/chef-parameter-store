
Chef::Log.info("******Installing aws-sdk prerequisite******")
gem_package 'aws-sdk' do
  action :install
end

Chef::Log.info("******Retrieving parameters from store.******")
ruby_block "load-parameters" do
  block do
    require 'aws-sdk'
    #stack = search("aws_opsworks_stack").first
    ssm = Aws::SSM::Client.new

    allparameters = ssm.describe_parameters({
      # filters: [
      #   {
      #     key: "Name", # accepts Name, Type, KeyId
      #     values: ["^ow_#{stack}"], # required
      #   },
      # ],
      # next_token: "NextToken",
    })

    for each_parameter in all_parameters

      # resp = ssm.get_parameters({
      #   names: ["ow_#{stack}"], # required
      #   with_decryption: false,
      # })
      puts "#{each_parameter}"

    end
  end
  action :run
end
