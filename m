Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EA9C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DDA214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580274504;
	bh=/PLex+OFymlSkARh7sOyMq7vMo+atm/8sFb12khc8cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lYlN8qVMstI3Cj8Ao1m6seaVg8Po7+GrzbSe3vYdoslw4Aqo2o6wkXSz93SX0HdvZ
	 0crK/C1MPF+VJLkN6pFxVyo3iu317UBMPj2KUaD8BWg6yFx2WKYQ5xC/V/FvNrioCB
	 UjFSjpqVQPTGAUavwAmiIqRumDJsJw4cVIMzTxBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2FIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgA2FIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:08:23 -0500
Received: from localhost (unknown [122.178.253.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7967E207FD;
        Wed, 29 Jan 2020 05:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580274502;
        bh=/PLex+OFymlSkARh7sOyMq7vMo+atm/8sFb12khc8cU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aABCTxf+ruTPFd6e/EXVNol45p6MZ9wbfocHd1fbf1OZujHNjV4SdO2/3oVs3PRlv
         3azH2nx1SdT+XA3y1VPuqojabEYsfyvOKvaXWLnhd26KTLvKUBrLeMI/zGkHHDInjP
         yTtMZiBgvonohszTUpxQhoBxKmN/TPTSxznnloM0=
Date:   Wed, 29 Jan 2020 10:38:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
Message-ID: <20200129050817.GW2841@vkoul-mobl>
References: <20200114060959.GA2818@vkoul-mobl>
 <6635bf0b-c20a-7561-bcbf-4a480a077ae4@linux.intel.com>
 <20200118071257.GY2818@vkoul-mobl>
 <73907607-0763-576d-b24e-4773dfb15f0b@linux.intel.com>
 <20200128105036.GO2841@vkoul-mobl>
 <d9478d9b-68a9-3d2c-338e-ca02e81e218e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9478d9b-68a9-3d2c-338e-ca02e81e218e@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 28-01-20, 10:02, Pierre-Louis Bossart wrote:

> > > struct sdw_md_driver {
> > > 	int (*init)(struct sdw_master_device *md, void *link_ctx);
> > > 	int (*startup)(struct sdw_master_device *md);
> > > 	int (*shutdown)(struct sdw_master_device *md);
> > > 	int (*exit)(struct sdw_master_device *md);
> > > 	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
> > > 					    bool state);
> > > };
> > 
> > So this is a soundwire core driver structure, but the modelling and
> > explanation provided here suggests the reasoning to be based on hardware
> > sequencing. I am not sure if we should follow this approach. Solving
> > hardware sequencing is fine but that should IMO be restricted to intel
> > code as that is intel issue which may or may not be present on other
> > controllers.
> 
> I agree the directions are Intel-specific, there was no intention of
> requiring anyone to implement all these callbacks.
> 
> > If I look at the calling sequence of the code (looked up the sof code on
> > github, topic/sof-dev-rebase), the sof code sound/soc/sof/intel/hda.c
> > invokes the sdw_intel_startup() and sdw_intel_probe() based on hardware
> > sequencing and further you call .init and .probe/startup of sdw_md_driver.
> > 
> > I really do not see why we need a sdw_md_driver object to do that. You can
> > easily have a another function exported by sdw_intel driver and you call
> > these and do same functionality without having a sdw_md_driver in
> > between.
> 
> I must admit I am beyond my comfort zone: I introduced this
> sdw_master_driver only based on Greg's recommendation to look at GreyBus.

Well the recommendation was to add a device, so adding sdw_master_device
was the right approach. But we don't need to add driver as well.

> All I care about are the three steps of
> a. creating a device (needed because the ACPI description does not model the
> master hardware)
> b. doing the required initializations and allocations
> c. exposing a startup callback, and provide room for expansion for future
> evolutions.
> 
> If there's a better way to do this I don't mind at all. The value-added of
> these patches is not in how the device/driver model is used but rather the
> hardware sequencing and power management.
> 
> That said, I have two key points that I should explain further.
> 
> When we started this work, we initially did not have a notion of 'master
> driver' coupled with the 'master_device'. But we faced a number of issues
> with ASoC registrations, which seemed to required a driver to be registered
> and associated with the device. We kept this part as a separate commit to
> make sure this requirement wasn't lost:

Yes ASoC does require the DAI driver as it holds a reference to it. That
was the reason we have a platform device and a platform driver for
"int-sdw".

Would it make sense to keep this as is and then export the init and
startup APIs which can be invoked by SOF part for hardware
initialization. So driver loading is a separate step from hardware
initialization and sequencing.

Also you continue with the benefit of parent-child relations for this
device :) and pm should be simpler.

Btw this helps if ever in future you have a separate instance of sdw
controller that can be just hooked to acpi/pci/whatever device part and
driver works without big plumbing

> https://github.com/thesofproject/linux/commit/28b934ce9c165e095dac5cf71da5685768831337
> 
> Looking back at my notes, this came from this piece of code:
> 
> static char *fmt_single_name(struct device *dev, int *id)
> {
> 	char *found, name[NAME_SIZE];
> 	int id1, id2;
> 
> 	if (dev_name(dev) == NULL)
> 		return NULL;
> 
> 	strlcpy(name, dev_name(dev), NAME_SIZE);
> 
> 	/* are we a "%s.%d" name (platform and SPI components) */
> 	found = strstr(name, dev->driver->name); <<< oops
> 
> so for ASoC, there is an expectation that each device does have a driver
> associated with it. Just for fun I reverted the commit above and that
> immediately trigger an kernel oops.
> 
> The other point that we came across is that PM support is only enabled
> thanks to a hook in the driver structure:
> 
> static const struct dev_pm_ops intel_pm = {
> 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
> 	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
> };
> 
> struct sdw_master_driver intel_sdw_driver = {
> 	.driver = {
> 		.name = "intel-sdw",
> 		.owner = THIS_MODULE,
> 		.bus = &sdw_bus_type,
> 		.pm = &intel_pm, <<<<
> 	},
> 	.probe = intel_master_probe,
> 	.startup = intel_master_startup,
> 	.process_wake_event = intel_master_process_wakeen_event,
> 	.remove = intel_master_remove,
> };
> 
> I am not aware of any other way to do this.
> 
> In short, I have two technical reasons we came across that made us rely on
> this 'master driver' object. I agree that the solution I suggested may not
> be very elegant or can be seen as overkill, but it does provide support for
> two integration requirements.
> 
> > Now, I am going to step back one more step and ask you why should we
> > have a sdw_md_driver? I am not seeing the driver object achieving
> > anything here expect adding wrappers which we can avoid. But we still
> > need to add the sdw_master_device() as a new device object and use that
> > for both sysfs representation as well as representing the master device
> > and do all the things we want, but it *can* come without having
> > accompanying sdw_md_driver.
> > 
> > This way you can retain you calling sequence and add the master device.
> > 
> > Stretching this one more step I would ask that maybe it is even better
> > idea that we should hide sdw_master_device_add() calling for soundwire
> > drivers and move that internal to bus as part of bus registration as
> > well, I don't see sdw_master_device calling back into the driver so it
> > should not impact your sequences as well.
> > 
> > Do you see a reason for sdw_md_driver which is must have? I couldn't
> > find that by looking at the code, let me know if I have missed anything
> > here.
> 
> Yes, the two reasons explained above.
> 
> That said, one possible compromize would be to remove those callbacks and
> indirections, such md->driver->remove(md);
> 
> we could perfectly export something like
> 
> intel_device_remove(md)
> 
> which would directly call the relevant functions. that would essentially
> remove the notion of 'sdw_master_driver' but keep the bare minimal driver
> structure that's needed.
> 
> Note that the removal of platform devices is not something I wanted to
> enforce across the board. If Qualcomm are happy with the platform devices,
> that's fine with me. I only want to work around the two limitations I
> mentioned (ACPI does not support masters, only controllers, and power rail
> dependencies).
> 
> > So to summarize, my recommendation would be to drop sdw_md_driver, keep
> > sdw_master_device object and make sdw_master_device_add() hidden to
> > driver and call it from sdw_add_bus_master() and keep intel specific
> > startup/init routine which do same steps as they have now.
> 
> I am afraid the sequence you suggest is not technically possible:
> sdw_add_bus_master() requires a device to be created already, see e.g. how
> it's used by Qualcomm:
> 
> https://github.com/thesofproject/linux/blob/4026efd12ac983d363fb43c37a8af741a2c90dc8/drivers/soundwire/qcom.c#L811
> 
> sdw_add_bus_master() is called from the platform device probe.
> I cannot insert a device creation in this code.

So there are two things, lets discuss them independently. One is the
device behind the controller object. I think I have given a
recommendation above to keep the existing platform device for "int-sdw".
This device can be PCI/ACPI/OF/Platform, we typically should not worry
about it.

Second is we create the bus instance and that also create the
sdw_master_device to represent the soundwire master device in sysfs,
since this would be done by soundwire core (as I suggested), it would be
independent of which type of driver is invoking this. In fact this needs
to be completely independent of the driver calling this.

Intel code will call sdw_add_bus_master() and we would create a
sdw_master_device for it and add the representation. So would the qcom
code (btw with this, we wont need to do anything on qc code and it
'should just work (tm)'.

> It'd actually be counter productive to add device management at the bus
> level, since we'd soon have incompatibilities between Intel, Qualcomm and
> others. What is platform-specific should be handled outside of the bus
> layer.

The vision I am thinking is that sdw_master_device is a representation
of master for everyone independent of the platform it is being used.

Let me know if this helps

Thanks
-- 
~Vinod
