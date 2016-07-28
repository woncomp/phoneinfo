using UnityEngine;
using System.Collections.Generic;
using LitJson;
using System.Net;

public class PhoneInfoTest : MonoBehaviour
{

	// Update is called once per frame
	void OnGUI()
	{
		if (GUI.Button(new Rect(10, 10, 400, 240), "Send"))
		{
			var url = "http://phone7.herokuapp.com";
			//var url = "http://phoneinfo-woncomp.c9users.io";
			 PhoneInfo.Send(url);
		}
	}
}

class PhoneInfo
{
	public string deviceModel;
	public string deviceType;
	public string deviceUniqueIdentifier;
	public int graphicsDeviceID;
	public string graphicsDeviceName;
	public string graphicsDeviceVendor;
	public int graphicsDeviceVendorID;
	public string graphicsDeviceVersion;
	public int graphicsMemorySize;
	public bool graphicsMultiThreaded;
	public int graphicsShaderLevel;
	public int maxTextureSize;
	public string npotSupport;
	public string operatingSystem;
	public int processorCount;
	public string processorType;
	public int supportedRenderTargetCount;
	public bool supports3DTextures;
	public bool supportsAccelerometer;
	public bool supportsComputeShaders;
	public bool supportsGyroscope;
	public bool supportsImageEffects;
	public bool supportsInstancing;
	public bool supportsLocationService;
	public bool supportsRawShadowDepthSampling;
	public bool supportsRenderTextures;
	public bool supportsRenderToCubemap;
	public bool supportsShadows;
	public bool supportsSparseTextures;
	public int supportsStencil;
	public bool supportsVibration;
	public int systemMemorySize;

	public int screenWidth;
	public int screenHeight;
	public double dpi;

	//public Dictionary<string, bool> supportsTextureFormat = new Dictionary<string, bool>();
	public Dictionary<string, bool> supportsRenderTextureFormat = new Dictionary<string, bool>();

	public static void Send(string url)
	{
		var info = new PhoneInfo();
		info.deviceModel = SystemInfo.deviceModel;
		info.deviceType = SystemInfo.deviceType.ToString();
		info.graphicsDeviceID = SystemInfo.graphicsDeviceID;
		info.graphicsDeviceName = SystemInfo.graphicsDeviceName;
		info.graphicsDeviceVendor = SystemInfo.graphicsDeviceVendor;
		info.graphicsDeviceVendorID = SystemInfo.graphicsDeviceVendorID;
		info.graphicsDeviceVersion = SystemInfo.graphicsDeviceVersion;
		info.graphicsMemorySize = SystemInfo.graphicsMemorySize;
		info.graphicsShaderLevel = SystemInfo.graphicsShaderLevel;
		info.maxTextureSize = SystemInfo.maxTextureSize;
		info.npotSupport = SystemInfo.npotSupport.ToString();
		info.operatingSystem = SystemInfo.operatingSystem;
		info.processorCount = SystemInfo.processorCount;
		info.processorType = SystemInfo.processorType;
		info.supportedRenderTargetCount = SystemInfo.supportedRenderTargetCount;
		info.supports3DTextures = SystemInfo.supports3DTextures;
		info.supportsAccelerometer = SystemInfo.supportsAccelerometer;
		info.supportsComputeShaders = SystemInfo.supportsComputeShaders;
		info.supportsGyroscope = SystemInfo.supportsGyroscope;
		info.supportsImageEffects = SystemInfo.supportsImageEffects;
		info.supportsInstancing = SystemInfo.supportsInstancing;
		info.supportsLocationService = SystemInfo.supportsLocationService;
		info.supportsRenderTextures = SystemInfo.supportsRenderTextures;
		info.supportsRenderToCubemap = SystemInfo.supportsRenderToCubemap;
		info.supportsShadows = SystemInfo.supportsShadows;
		info.supportsSparseTextures = SystemInfo.supportsSparseTextures;
		info.supportsStencil = SystemInfo.supportsStencil;
		info.supportsVibration = SystemInfo.supportsVibration;
		info.systemMemorySize = SystemInfo.systemMemorySize;

		info.screenWidth = Screen.width;
		info.screenHeight = Screen.height;
		info.dpi = Screen.dpi;

		// foreach (TextureFormat textureFormat in System.Enum.GetValues(typeof(TextureFormat)))
		// {
		// 	info.supportsTextureFormat[textureFormat.ToString()] = SystemInfo.SupportsTextureFormat(textureFormat);
		// }
		foreach (RenderTextureFormat textureFormat in System.Enum.GetValues(typeof(RenderTextureFormat)))
		{
			info.supportsRenderTextureFormat[textureFormat.ToString()] = SystemInfo.SupportsRenderTextureFormat(textureFormat);
		}

		url += "/submit";
		var jsonString = JsonMapper.ToJson(info);
		var bytes = System.Text.Encoding.ASCII.GetBytes(jsonString.ToCharArray());

		var request = WebRequest.Create(url) as HttpWebRequest;
		request.Method = "POST";
		request.ContentType = "application/json";
		request.UserAgent = "UnityPlayer/4.6.3f4 (http://unity3d.com)";
		using (var s = request.GetRequestStream())
		{
			s.Write(bytes, 0, bytes.Length);
		}
		request.BeginGetResponse(null, null);
	}
}