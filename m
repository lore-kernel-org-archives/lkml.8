Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8514C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE91205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239075;
	bh=v/BIpono7KiN65njbhpyzD6YUHHqq6MPMBpfxTeCkxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hS8Hq8AXosU8lNV7wv/oQIhcllckbA6T0SpurIoOEkY61Fws4r5Uf+kbOt/2UVn5d
	 25wOZ+2tGUXBkTXQMbI+ohoT9AL1wuFBpV0QSNnjMB6nabtIhjXtjFCctPyLf4ynnS
	 XJyW9eJ2naKuAn7Xmi2p9tFRoQ66tb7SsryFP1S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgCOCYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgCOCYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:15 -0400
Received: from localhost (unknown [122.167.115.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E14172067C;
        Sat, 14 Mar 2020 09:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584179360;
        bh=v/BIpono7KiN65njbhpyzD6YUHHqq6MPMBpfxTeCkxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8IP+h2ck8IZ1vzFPOldGPkKumAuPBqQUUYbQ4MKsVi4+pQFaWq79msrSgW8AvoVG
         /v8dLT2amXXi1mnLKJoLwScsvzpGZjmIPZidMhrz6G/UYJLkwJz3ENlCgGr/LVbzG1
         vnIET1GKYX+GnUzO4PcKDM3kpzO3vZt6CipWP39g=
Date:   Sat, 14 Mar 2020 15:19:04 +0530
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
Message-ID: <20200314094904.GP4885@vkoul-mobl>
References: <20200304095312.GT4148@vkoul-mobl>
 <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
 <20200305063646.GW4148@vkoul-mobl>
 <eb30ac49-788f-b856-6fcf-84ae580eb3c8@linux.intel.com>
 <20200306050115.GC4148@vkoul-mobl>
 <4fabb135-6fbb-106f-44fd-8155ea716c00@linux.intel.com>
 <20200311063645.GH4885@vkoul-mobl>
 <0fafb567-10e5-a1ea-4a6d-b3c53afb215e@linux.intel.com>
 <20200313115011.GD4885@vkoul-mobl>
 <4cb16467-87d0-ef99-e471-9eafa9e669d2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb16467-87d0-ef99-e471-9eafa9e669d2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-03-20, 11:54, Pierre-Louis Bossart wrote:
> 
> > > > > the ASoC layer does require a driver with a 'name' for the components
> > > > > registered with the master device. So if you don't have a driver for the
> > > > > master device, the DAIs will be associated with the PCI device.
> > > > > 
> > > > > But the ASoC core does make pm_runtime calls on its own,
> > > > > 
> > > > > soc_pcm_open(struct snd_pcm_substream *substream)
> > > > > {
> > > > > ...
> > > > > 	for_each_rtd_components(rtd, i, component)
> > > > > 		pm_runtime_get_sync(component->dev);
> > > > > 
> > > > > and if the device that's associated with the DAI is the PCI device, then
> > > > > that will not result in the relevant master IP being activated, only the PCI
> > > > > device refcount will be increased - meaning there is no hook that would tell
> > > > > the PCI layer to turn on a specific link.
> > > > > 
> > > > > What you are recommending would be an all-or-nothing solution with all links
> > > > > on or all links off, which beats the purpose of having independent
> > > > > link-level power management.
> > > > 
> > > > Why can't you use dai .startup callback for this?
> > > > 
> > > > The ASoC core will do pm_runtime calls that will ensure PCI device is
> > > > up, DSP firmware downloaded and running.
> > > > 
> > > > You can use .startup() to turn on your link and .shutdown to turn off
> > > > the link.
> > > 
> > > There are multiple dais per link, and multiple Slave per link, so we would
> > > have to refcount and track active dais to understand when the link needs to
> > > be turned on/off. It's a duplication of what the pm framework can do at the
> > > device/link level, and will likely introduce race conditions.
> > > 
> > > Not to mention that we'd need to introduce workqueues to turn the link off
> > > with a delay, with pm_runtime_put_autosuspend() does for free.
> > 
> > Yes sure, that seems to be the cost unfortunately. While it might feel I
> > am blocking but the real block here is the hw design which gives you a
> > monolith whereas it should have been different devices. If you have a
> > 'device' for sdw or a standalone controller we would not be debating
> > this..
> 
> The hardware is what it is. The ACPI spec is what it is.
> 
> I am just pragmatic and making platforms work with that's available *today*,
> and I don't have time or interest in revisiting what might have been.
> 
> > > Linux is all about frameworks. For power management, we shall use the power
> > > management framework, not reinvent it.
> > 
> > This reminds me, please talk to Mika and Rafael, they had similar
> > problems with lpss etc and IIRC they were working on splices to solve
> > this.. Its been some time (few years now) so maybe they have a
> > solution..
> 
> We've been discussing this since October, I don't really have any appetite
> for looking into new concepts when the existing framework just does what we
> need.

yes they do but add an intrusive platform specific change into soundwire
core, something I would not like to add.

You should really be willing to talk to your colleagues to see if there
is something you can reuse.

> It's really down to your objection to the use of 'struct driver'... For ASoC
> support we only need the .name and .pm_ops, so there's really no possible
> path forward otherwise.

It means that we cannot have a solution which is Intel specific into
core. If you has a standalone controller you do not need this.

> Like I said, we have 3 options

Repeating the already discussed doesn't help. I have already told you the
constraint to work is not to add Intel specific change into core.

I have already said that expect the driver part I dont have objections
to rest of this series and am ready to merge

> a) stay with platform devices for now. You will need to have a conversation
> with Greg on this.
> 
> b) use a minimal sdw_master_device with a minimal 'struct driver' use.
> 
> c) use a more elaborate solution suggested in this patchset and yes that
> means the Qualcomm driver would need to change a bit.
> 
> Pick one or suggest something that is implementable. The first version of
> the patches was provided in October, the last RFC was provided on January
> 31, time's up. At the moment you are preventing ASoC integration from moving
> forward.

In opensource review we go back and forth and we debate and come to a
common conclusion. Choosing a specific set of solutions and constraining
yourself to pick one does not help.

I have only _one_ constraint no platform specific change in core. If that
is satisfied I will go with it. Sorry but this is non-negotiable for me.

Ask yourself, do you need this intrusive core change if you had this
exact same controller(s) but only as standalone one... 

-- 
~Vinod
