require 'json'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'digest'
require 'data_mapper'

configure :development do
  DataMapper.setup(:default, 'postgres://ubuntu:your_password@localhost/phoneinfo')
end

configure :production do
  DataMapper.setup(:default, 'postgres://enxftooxivmbtd:j9n8BPq5i5S-PTlMpQ57j2ibeP@ec2-54-227-240-164.compute-1.amazonaws.com:5432/daqgooo499gnl0')

end

class PhoneInfo
  include DataMapper::Resource
  
  property :id, Serial
  property :hash_name, String
  
	property :deviceModel, String
	property :deviceType, String
	property :deviceUniqueIdentifier, String
	property :graphicsDeviceID, Integer
	property :graphicsDeviceName, String
	property :graphicsDeviceVendor, String
	property :graphicsDeviceVendorID, Integer
	property :graphicsDeviceVersion, String
	property :graphicsMemorySize, Integer
	property :graphicsMultiThreaded, Boolean
	property :graphicsShaderLevel, Integer
	property :maxTextureSize, Integer
	property :npotSupport, String
	property :operatingSystem, String
	property :processorCount, Integer
	property :processorType, String
	property :supportedRenderTargetCount, Integer
	property :supports3DTextures, Boolean
	property :supportsAccelerometer, Boolean
	property :supportsComputeShaders, Boolean
	property :supportsGyroscope, Boolean
	property :supportsImageEffects, Boolean
	property :supportsInstancing, Boolean
	property :supportsLocationService, Boolean
	property :supportsRawShadowDepthSampling, Boolean
	property :supportsRenderTextures, Boolean
	property :supportsRenderToCubemap, Boolean
	property :supportsShadows, Boolean
	property :supportsSparseTextures, Boolean
	property :supportsStencil, Integer
	property :supportsVibration, Boolean
	property :systemMemorySize, Integer

	property :screenWidth, Integer
	property :screenHeight, Integer
	property :dpi, Float
	
	property :supportsRenderTextureFormat, Object
end

DataMapper.finalize
DataMapper.auto_upgrade!

# Commands to run
#
# Things to try
# * have the page display "Howdy!"
# * have the page display some HTML (paste some HTML in the string)
#
# Bonus
# * have the page display the current time (google "ruby current time")
# * have the page display the current time, formatted in a nicer way. (google "ruby strftime" which stands for string-format-time)

get '/' do
  "Hello World! Welcome to Ruby!"
end

post '/submit' do
  data = JSON.parse request.body.read
  hash_name = Digest::SHA256.base64digest data.to_s
  
  phone = PhoneInfo.first(:hash_name => hash_name)
  if phone == nil
    phone = PhoneInfo.new(:hash_name => hash_name)
  else
    puts '------ found'
    puts phone.inspect
  end
    
	phone.deviceModel = data['deviceModel']
	phone.deviceType = data['deviceType']
	phone.deviceUniqueIdentifier = data['deviceUniqueIdentifier']
	phone.graphicsDeviceID = data['graphicsDeviceID']
	phone.graphicsDeviceName = data['graphicsDeviceName']
	phone.graphicsDeviceVendor = data['graphicsDeviceVendor']
	phone.graphicsDeviceVendorID = data['graphicsDeviceVendorID']
	phone.graphicsDeviceVersion = data['graphicsDeviceVersion']
	phone.graphicsMemorySize = data['graphicsMemorySize']
	phone.graphicsMultiThreaded = data['graphicsMultiThreaded']
	phone.graphicsShaderLevel = data['graphicsShaderLevel']
	phone.maxTextureSize = data['maxTextureSize']
	phone.npotSupport = data['npotSupport']
	phone.operatingSystem = data['operatingSystem']
	phone.processorCount = data['processorCount']
	phone.processorType = data['processorType']
	phone.supportedRenderTargetCount = data['supportedRenderTargetCount']
	phone.supports3DTextures = data['supports3DTextures']
	phone.supportsAccelerometer = data['supportsAccelerometer']
	phone.supportsComputeShaders = data['supportsComputeShaders']
	phone.supportsGyroscope = data['supportsGyroscope']
	phone.supportsImageEffects = data['supportsImageEffects']
	phone.supportsInstancing = data['supportsInstancing']
	phone.supportsLocationService = data['supportsLocationService']
	phone.supportsRawShadowDepthSampling = data['supportsRawShadowDepthSampling']
	phone.supportsRenderTextures = data['supportsRenderTextures']
	phone.supportsRenderToCubemap = data['supportsRenderToCubemap']
	phone.supportsShadows = data['supportsShadows']
	phone.supportsSparseTextures = data['supportsSparseTextures']
	phone.supportsStencil = data['supportsStencil']
	phone.supportsVibration = data['supportsVibration']
	phone.systemMemorySize = data['systemMemorySize']

	phone.screenWidth = data['screenWidth']
	phone.screenHeight = data['screenHeight']
	phone.dpi = data['dpi']
	
  phone.supportsRenderTextureFormat = data['supportsRenderTextureFormat']
  if phone.save
    puts '------ saved'
  else
    puts '------ save failed'
  end
  
  'OK'
end	