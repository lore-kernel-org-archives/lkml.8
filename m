Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD39C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB5F2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580208645;
	bh=xn/+wGx2wdvNYeHfEvNeO9WqRTrsPri3ACJFwmTconE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O/GhnTepnU7Npf4YWyk4q5rXvxC9OWl3+ef6ARE5Dtpdmwn5sM4Agt0zk+WfEXyCQ
	 GthYcwQpGdiWBkUtlxoBL/PDnasAJPKFwW3mG2ScwL1g1lwou4Lz/+NSn4MTy2CddR
	 RtCJ89o1fO8974QXNGjzA0IpTY9bM/90r/LGvNXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgA1Kuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgA1Kun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:50:43 -0500
Received: from localhost (unknown [223.226.101.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E9A24681;
        Tue, 28 Jan 2020 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580208643;
        bh=xn/+wGx2wdvNYeHfEvNeO9WqRTrsPri3ACJFwmTconE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8Xuor/XyPCcJ/eHtBuGVcURbPZfWcNDdBL71eqV6irDMNC+JnkPU37rKtXRpzmC+
         YZXjADJoa564vYuXQQ0ywV++HJOWuoWtvX/HHgl0bYwqIitAf6iloWvd1Wgxy6qVQf
         MmUBL3o691pKPKp857GVAyujlSeuqUTkEXYhXcpA=
Date:   Tue, 28 Jan 2020 16:20:36 +0530
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
Message-ID: <20200128105036.GO2841@vkoul-mobl>
References: <20200114060959.GA2818@vkoul-mobl>
 <6635bf0b-c20a-7561-bcbf-4a480a077ae4@linux.intel.com>
 <20200118071257.GY2818@vkoul-mobl>
 <73907607-0763-576d-b24e-4773dfb15f0b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73907607-0763-576d-b24e-4773dfb15f0b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

I took some time to look into the overall code and how this is fitting
into big picture and help recommend way forward.

On 21-01-20, 11:31, Pierre-Louis Bossart wrote:
> 
> 
> > A rename away from probe will certainly be very helpful as
> > you would also agree that terms 'probe' and 'remove' have a very
> > special meaning in kernel, so let us avoid these
> 
> ok, so would the following be ok with you?
> 
> /**
>  * struct sdw_md_driver - SoundWire 'Master Device' driver
>  *
>  * @init: allocations and initializations (hardware may not be enabled yet)
>  * @startup: initialization handled after the hardware is enabled, all
>  * clock/power dependencies are available
>  * @shutdown: cleanups before hardware is disabled (optional)
>  * @exit: free all remaining resources
>  * @autonomous_clock_stop_enable: enable/disable driver control while
>  * in clock-stop mode, typically in always-on/D0ix modes. When the driver
>  * yields control, another entity in the system (typically firmware
>  * running on an always-on microprocessor) is responsible to tracking
>  * Slave-initiated wakes
>  */
> struct sdw_md_driver {
> 	int (*init)(struct sdw_master_device *md, void *link_ctx);
> 	int (*startup)(struct sdw_master_device *md);
> 	int (*shutdown)(struct sdw_master_device *md);
> 	int (*exit)(struct sdw_master_device *md);
> 	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
> 					    bool state);
> };

So this is a soundwire core driver structure, but the modelling and
explanation provided here suggests the reasoning to be based on hardware
sequencing. I am not sure if we should follow this approach. Solving
hardware sequencing is fine but that should IMO be restricted to intel
code as that is intel issue which may or may not be present on other
controllers.

If I look at the calling sequence of the code (looked up the sof code on
github, topic/sof-dev-rebase), the sof code sound/soc/sof/intel/hda.c
invokes the sdw_intel_startup() and sdw_intel_probe() based on hardware
sequencing and further you call .init and .probe/startup of sdw_md_driver.

I really do not see why we need a sdw_md_driver object to do that. You can
easily have a another function exported by sdw_intel driver and you call
these and do same functionality without having a sdw_md_driver in
between.

Now, I am going to step back one more step and ask you why should we
have a sdw_md_driver? I am not seeing the driver object achieving
anything here expect adding wrappers which we can avoid. But we still
need to add the sdw_master_device() as a new device object and use that
for both sysfs representation as well as representing the master device
and do all the things we want, but it *can* come without having
accompanying sdw_md_driver.

This way you can retain you calling sequence and add the master device.

Stretching this one more step I would ask that maybe it is even better
idea that we should hide sdw_master_device_add() calling for soundwire
drivers and move that internal to bus as part of bus registration as
well, I don't see sdw_master_device calling back into the driver so it
should not impact your sequences as well.

Do you see a reason for sdw_md_driver which is must have? I couldn't
find that by looking at the code, let me know if I have missed anything
here.


So to summarize, my recommendation would be to drop sdw_md_driver, keep
sdw_master_device object and make sdw_master_device_add() hidden to
driver and call it from sdw_add_bus_master() and keep intel specific
startup/init routine which do same steps as they have now.

Thanks
-- 
~Vinod
