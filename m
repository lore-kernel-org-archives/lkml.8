Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F35C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9126F21556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583390212;
	bh=mENfDC//cVzCD446jCffk+9bpHw8jtpmF0r1yQBzLIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nuYpQJgiVUfrxDP/BbHXE8g1yLLDtyIcsosipHUiR4/urQGEyDcQCOG3eEESSb7P5
	 GcX34cb4NrUcnKFjDQT9TZo+vAddSqq2Am0i+mEzTfuNgNfDHbMtqUZvGjFCG3wAXa
	 LtPah9kpJJ7JGu7c7Jo5AEQwNomu/kZAT+QJwqis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgCEGgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCEGgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:36:51 -0500
Received: from localhost (unknown [106.201.121.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757A4208CD;
        Thu,  5 Mar 2020 06:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583390210;
        bh=mENfDC//cVzCD446jCffk+9bpHw8jtpmF0r1yQBzLIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOiuBqq9PTVb92B+SGXsdwbRQE9IOT1ihD9jN17oC+CnLtrtWBBTjY7sIsg/Kb0bs
         DN0cZlbyuE4YhGb75l+bNtZvww5znHGgkrvk4x4igwFuPi4dw20KGCn4JrZL+gD3uf
         9dMXy8H+BZbqEWU8ZPisZH2+Ssob8Auz27vvDQGA=
Date:   Thu, 5 Mar 2020 12:06:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
Message-ID: <20200305063646.GW4148@vkoul-mobl>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-2-pierre-louis.bossart@linux.intel.com>
 <20200303054136.GP4148@vkoul-mobl>
 <8a04eda6-cbcf-582f-c229-5d6e4557344b@linux.intel.com>
 <20200304095312.GT4148@vkoul-mobl>
 <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-03-20, 09:17, Pierre-Louis Bossart wrote:
> 
> 
> > Were the above lines agreed or not? Do you see driver for master devices
> > or not? Greg was okay with as well as these patches but I am not okay
> > with the driver part for master, so I would like to see that removed.
> > 
> > Different reviewers can have different reasons.. I have given bunch of
> > reasons here, BUT I have not seen a single technical reason why this
> > cannot be done.
> 
> With all due respect, I consider Greg as THE reviewer for device/driver
> questions. Your earlier proposal to use platform devices was rejected by
> Greg, and we've lost an entire month in the process, so I am somewhat
> dubious on your proposal not to use a driver.
> 
> If you want a technical objection, let me restate what I already mentioned:
> 
> If you look at the hierarchy, we have
> 
> PCI device -> PCI driver
>   soundwire_master_device0
>      soundwire_slave(s) -> codec driver
>   ...
>   soundwire_master_deviceN
>      soundwire_slave(s) -> codec driver
> 
> You have not explained how I could possibly deal with power management
> without having a driver for the master_device(s). The pm_ops need to be
> inserted in a driver structure, which means we need a driver. And if we need
> a driver, then we might as well have a real driver with .probe .remove
> support, driver_register(), etc.

Please read the emails sent to you completely, including the reply on
2nd patch of this series. I think i am repeating this 3rd or 4th time
now.  Am going to repeat this info here to help move things.

Why do you need a extra driver for this. Do you have another set of
device object and driver for DSP code? But you do manage that, right?
I am proposing to simplify the device model here and have only one
device (SOF PCI) and driver (SOF PCI driver), which is created by actual
bus (PCI here) as you have in rest of the driver like HDA, DSP etc.

I have already recommended is to make the int-sdw a module which is
invoked by SOF PCI driver code (thereby all code uses SOF PCI device and
SOF PCI driver) directly. The DSP in my time for skl was a separate
module but used the parent objects.

The SOF sdw init (the place where sdw routines are invoked after DSP
load) can call sdw_probe and startup. Based on DSP sequencing you can
call these functions directly without waiting for extra device to be
probed etc.

I feel your flows will be greatly simplified as a result of this.

Second issue of PM:
 You do manage the DSP PM right? Similar way.
So here I would expect you to add functions/callbacks from SOF driver to
this module and call PM routines from SOF PM routines allowing you to
suspend/resume. Similar way DSP used to be managed.  Something like:
.sdw_suspend .sdw_resume functions/callbacks which will do sdw specific
pm configurations. You do not need module specific pm_ops, you can do
the required steps in callbacks from SOF driver

Bonus, this can be tuned and called at the specific places in DSP
suspend/resume flow, which is something I suspect you would want.

For places which need dev/driver objects like sdw dai's please pass the
SOF PCI dev object.

Is there any other technical reason left unexplored/unexplained?

> I really don't see what's broken or unnecessary with these patches.

Adding a layer for Intel in common code is unnecessary IMO. As
demonstrated above you can use the intel specific callback to do the
same task in intel specific way. I would very much prefer that approach
to solve this

We definitely need a sdw_master_device for everyone, but I don't believe
we need a sdw_master_device for Intel or anyone else.

> I would also kindly ask that you stop using exclamation marks and what I
> consider as hostile language. I've asked you multiple times, it's not
> professional, sorry.

oops, i would apologise for that. I seem to have a habit of using that
which indicates my surprise and not hostile language, maybe it is
cultural thing, but I would try to refrain. thanks for letting me know.

-- 
~Vinod 
