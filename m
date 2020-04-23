Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556ACC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2072098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587651897;
	bh=awxfurzkZKl16SHw8EPTwq6LCLWkAhmyRFGAWg9HM+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JiPPfFa3huU/0kb8EgmAWDAN0Sgzranp+MwpGyd35x1KBPVxdxKQffpC4qb9fzsCm
	 0MsxnGLAjLBwkDS51uVfFijRsinn2ePm6MvxbEX/ZtmNwOwoc13QL2NTBatJ3uBbKl
	 cjpugjX/jnQ1OmUk0WKDbGN1qHRciNtnl31AefwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgDWOY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgDWOYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:24:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D8E206ED;
        Thu, 23 Apr 2020 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587651893;
        bh=awxfurzkZKl16SHw8EPTwq6LCLWkAhmyRFGAWg9HM+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3E7jg7rCQPRXXyLoWBrL+nLpl6Km3V7EQZa8kwvrj1fNCwKIy0VPUqRALSsweR8F
         i14bZXIdzDyEMKEWDPbMDOHxTeXY1pJ94cSEF3fcCF/JCdmrAB9zO5HykffjRDFeQQ
         mKee7wkv+VngA16l4t72zDfQzJQOdnGVr1CbuTgA=
Date:   Thu, 23 Apr 2020 16:24:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com
Subject: Re: [RFC 1/5] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200423142451.GA4181720@kroah.com>
References: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
 <20200416205524.2043-2-yung-chuan.liao@linux.intel.com>
 <20200420072631.GW72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420072631.GW72691@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:56:31PM +0530, Vinod Koul wrote:
> Hello Bard,
> 
> On 17-04-20, 04:55, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > In the existing SoundWire code, Master Devices are not explicitly
> > represented - only SoundWire Slave Devices are exposed (the use of
> > capital letters follows the SoundWire specification conventions).
> > 
> > The SoundWire Master Device provides the clock, synchronization
> > information and command/control channels. When multiple links are
> > supported, a Controller may expose more than one Master Device; they
> > are typically embedded inside a larger audio cluster (be it in an
> > SOC/chipset or an external audio codec), and we need to describe it
> > using the Linux device and driver model.  This will allow for
> > configuration functions to account for external dependencies such as
> > power rails, clock sources or wake-up mechanisms. This transition will
> > also allow for better sysfs support without the reference count issues
> > mentioned in the initial reviews.
> 
> Well the primary reason for doing sdw_master_device for creating a
> adding sysfs representation.

-ENOPARSE :(

> It *also* helps some vendors due to
> inherent model should not be constructed as the primary approach for the
> sdw_master_device.

No, the PRIMARY reason is "it is the correct thing to do".  It's how to
tie into the driver model correctly, without it, crazy things happen as
we have seen.

> > In this patch, we convert the existing code to use an explicit
> > sdw_slave_type, then define a sdw_master_device structure.
> 
> Please split that up, we should do the conversions required first and
> then do addition of new things.

Can you really do that in two different steps?

> > +struct device_type sdw_master_type = {
> > +	.name =		"soundwire_master",
> > +	.release =	sdw_master_device_release,
> > +};
> > +
> > +/**
> > + * sdw_master_device_add() - create a Linux Master Device representation.
> > + * @parent: the parent Linux device (e.g. a PCI device)
> > + * @fwnode: the parent fwnode (e.g. an ACPI companion device to the parent)
> > + * @link_ops: link-specific ops (optional)
> > + * @link_id: link index as defined by MIPI DisCo specification
> > + * @pdata: private data (e.g. register base, offsets, platform quirks, etc).
> > + *
> > + * The link_ops argument can be NULL, it is only used when link-specific
> > + * initializations and power-management are required.
> > + */
> > +struct sdw_master_device
> > +*sdw_master_device_add(struct device *parent,
> > +		       struct fwnode_handle *fwnode,
> > +		       struct sdw_link_ops *link_ops,
> > +		       int link_id,
> > +		       void *pdata)
> > +{
> > +	struct sdw_master_device *md;
> > +	int ret;
> > +
> > +	md = kzalloc(sizeof(*md), GFP_KERNEL);
> > +	if (!md)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	md->link_id = link_id;
> > +	md->pdata = pdata;
> > +	md->link_ops = link_ops;
> > +
> > +	md->dev.parent = parent;
> > +	md->dev.fwnode = fwnode;
> > +	md->dev.bus = &sdw_bus_type;
> > +	md->dev.type = &sdw_master_type;
> > +	md->dev.dma_mask = md->dev.parent->dma_mask;
> > +	dev_set_name(&md->dev, "sdw-master-%d", md->link_id);
> > +
> > +	if (link_ops && link_ops->driver) {
> > +		/*
> > +		 * A driver is only needed for ASoC integration (need
> > +		 * driver->name) and for link-specific power management
> > +		 * w/ a pm_dev_ops structure.
> 
> That is not true for everyone, it is only true for Intel, pls call that
> out as well...

Why is it not true for everyone?  How else do you get the pm stuff back
to your hardware?

thanks,

greg k-h
