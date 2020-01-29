Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74056C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457C72070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgA2O7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:59:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:65398 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgA2O7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:59:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 06:59:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="222474171"
Received: from rnoffsin-mobl.amr.corp.intel.com (HELO [10.252.139.181]) ([10.252.139.181])
  by orsmga008.jf.intel.com with ESMTP; 29 Jan 2020 06:59:15 -0800
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200114060959.GA2818@vkoul-mobl>
 <6635bf0b-c20a-7561-bcbf-4a480a077ae4@linux.intel.com>
 <20200118071257.GY2818@vkoul-mobl>
 <73907607-0763-576d-b24e-4773dfb15f0b@linux.intel.com>
 <20200128105036.GO2841@vkoul-mobl>
 <d9478d9b-68a9-3d2c-338e-ca02e81e218e@linux.intel.com>
 <20200129050817.GW2841@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4c49c9d0-e7b7-6c9b-03b8-90a94bfd1407@linux.intel.com>
Date:   Wed, 29 Jan 2020 08:59:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129050817.GW2841@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

>>> If I look at the calling sequence of the code (looked up the sof code on
>>> github, topic/sof-dev-rebase), the sof code sound/soc/sof/intel/hda.c
>>> invokes the sdw_intel_startup() and sdw_intel_probe() based on hardware
>>> sequencing and further you call .init and .probe/startup of sdw_md_driver.
>>>
>>> I really do not see why we need a sdw_md_driver object to do that. You can
>>> easily have a another function exported by sdw_intel driver and you call
>>> these and do same functionality without having a sdw_md_driver in
>>> between.
>>
>> I must admit I am beyond my comfort zone: I introduced this
>> sdw_master_driver only based on Greg's recommendation to look at GreyBus.
> 
> Well the recommendation was to add a device, so adding sdw_master_device
> was the right approach. But we don't need to add driver as well.

I provided two reasons below why we need one
[1] ASoC use of dev->driver
[2] PM hooks.

I would kindly ask that you re-check these points and reply on each, 
thank you. I did not remove them from my reply so that you don't have to 
go back to the previous emails.

>> That said, I have two key points that I should explain further.
>>
>> When we started this work, we initially did not have a notion of 'master
>> driver' coupled with the 'master_device'. But we faced a number of issues
>> with ASoC registrations, which seemed to required a driver to be registered
>> and associated with the device. We kept this part as a separate commit to
>> make sure this requirement wasn't lost:
> 
> Yes ASoC does require the DAI driver as it holds a reference to it. That
> was the reason we have a platform device and a platform driver for
> "int-sdw".

no, it's not related to references, it's using the name, see [1]. And 
it's not related to the 'dai driver' which is a separate entity 
unrelated to devices.

> Would it make sense to keep this as is and then export the init and
> startup APIs which can be invoked by SOF part for hardware
> initialization. So driver loading is a separate step from hardware
> initialization and sequencing.
> 
> Also you continue with the benefit of parent-child relations for this
> device :) and pm should be simpler.

the parent-child relationship was used in all cases, I don't understand 
why things would be different, you still need to add hooks in the 
'driver' for the pm of the 'master' child device, be it a platform 
device or not.

> Btw this helps if ever in future you have a separate instance of sdw
> controller that can be just hooked to acpi/pci/whatever device part and
> driver works without big plumbing
> 
>> https://github.com/thesofproject/linux/commit/28b934ce9c165e095dac5cf71da5685768831337
>>

[1]

>> Looking back at my notes, this came from this piece of code:
>>
>> static char *fmt_single_name(struct device *dev, int *id)
>> {
>> 	char *found, name[NAME_SIZE];
>> 	int id1, id2;
>>
>> 	if (dev_name(dev) == NULL)
>> 		return NULL;
>>
>> 	strlcpy(name, dev_name(dev), NAME_SIZE);
>>
>> 	/* are we a "%s.%d" name (platform and SPI components) */
>> 	found = strstr(name, dev->driver->name); <<< oops
>>
>> so for ASoC, there is an expectation that each device does have a driver
>> associated with it. Just for fun I reverted the commit above and that
>> immediately trigger an kernel oops.

[2]

>> The other point that we came across is that PM support is only enabled
>> thanks to a hook in the driver structure:
>>
>> static const struct dev_pm_ops intel_pm = {
>> 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
>> 	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
>> };
>>
>> struct sdw_master_driver intel_sdw_driver = {
>> 	.driver = {
>> 		.name = "intel-sdw",
>> 		.owner = THIS_MODULE,
>> 		.bus = &sdw_bus_type,
>> 		.pm = &intel_pm, <<<<
>> 	},
>> 	.probe = intel_master_probe,
>> 	.startup = intel_master_startup,
>> 	.process_wake_event = intel_master_process_wakeen_event,
>> 	.remove = intel_master_remove,
>> };
>>
>> I am not aware of any other way to do this.

I suggested a minimal way of using the 'device_driver' directly in 
https://github.com/thesofproject/linux/pull/1755

>>> So to summarize, my recommendation would be to drop sdw_md_driver, keep
>>> sdw_master_device object and make sdw_master_device_add() hidden to
>>> driver and call it from sdw_add_bus_master() and keep intel specific
>>> startup/init routine which do same steps as they have now.
>>
>> I am afraid the sequence you suggest is not technically possible:
>> sdw_add_bus_master() requires a device to be created already, see e.g. how
>> it's used by Qualcomm:
>>
>> https://github.com/thesofproject/linux/blob/4026efd12ac983d363fb43c37a8af741a2c90dc8/drivers/soundwire/qcom.c#L811
>>
>> sdw_add_bus_master() is called from the platform device probe.
>> I cannot insert a device creation in this code.
> 
> So there are two things, lets discuss them independently. One is the
> device behind the controller object. I think I have given a
> recommendation above to keep the existing platform device for "int-sdw".
> This device can be PCI/ACPI/OF/Platform, we typically should not worry
> about it.

I don't understand how a platform device can be PCI/ACPI/OF? what did 
you mean here?

> Second is we create the bus instance and that also create the
> sdw_master_device to represent the soundwire master device in sysfs,
> since this would be done by soundwire core (as I suggested), it would be
> independent of which type of driver is invoking this. In fact this needs
> to be completely independent of the driver calling this.
> 
> Intel code will call sdw_add_bus_master() and we would create a
> sdw_master_device for it and add the representation. So would the qcom
> code (btw with this, we wont need to do anything on qc code and it
> 'should just work (tm)'.
> 
>> It'd actually be counter productive to add device management at the bus
>> level, since we'd soon have incompatibilities between Intel, Qualcomm and
>> others. What is platform-specific should be handled outside of the bus
>> layer.
> 
> The vision I am thinking is that sdw_master_device is a representation
> of master for everyone independent of the platform it is being used.
> 
> Let me know if this helps

Sorry no, your reply just confused me completely.

The recommendation from Greg was "remove platform devices". Here's the 
quote from his May 9, 2019 reply:

"So soundwire is creating platform devices?  Ick, no!  Don't do that,
create a "real" device that is the root of your bus and attach that to
the platform/pci/whatever device that is the parent of that device's
resources."

If your suggestion is to keep platform devices as currently done, then I 
will kindly ask that you speak with Greg and let me know what the 
agreement is.

The second part of your reply gets more confusing, you are suggesting 
that "Intel code will call sdw_add_bus_master() and we would create a 
sdw_master_device for it and add the representation". That is in direct 
contradiction with the notion of using platform devices. And it would by 
construction break the Qualcomm controller code just merged weeks ago. 
Are you suggesting I start changing Qualcomm code? Or that we add a new 
function that does device creation+bus addition in one shot?

And last you didn't acknowledge my two technical points as to why a 
driver is needed for this sdw_master_device.

So I am back to scratching my head on what the direction is? I just do 
not understand your line of thought.

Maybe we need to stop the long sentences and use this decision flow:

a) is the master device a platform device (Yes/No)?
b) if No for a) then
b.1) is the master device created within sdw_add_bus_master()
b.2) is the master device created before calling sdw_add_bus_master()

Can you please clarify what your desired choices are on this last paragraph?

Thanks
-Pierre
