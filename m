Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F53C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F2B206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588048310;
	bh=SVypUuySP3KVuH00k703NoSZ+VXSI11QixZYSNEUqLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MgsiUq573heSdkLi2QJZEQoFc9Kx94K50/TxzaQDGix8FR3LPzkAXjz+uEUqdMsN/
	 X3IVQJKKV4Jjwi6gX/rZEEKMSL9yPdo0UVROM2NOfcQzaqrJMQcG8+rtv1d8sAlbDa
	 lYSihDkxd/0rLhmghMvZGu/shjkDy1lC39Sbwe5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD1Ebu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgD1Ebt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:31:49 -0400
Received: from localhost (unknown [106.51.110.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3556A206A5;
        Tue, 28 Apr 2020 04:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588048309;
        bh=SVypUuySP3KVuH00k703NoSZ+VXSI11QixZYSNEUqLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ssgwx8oIB+vsDNG5polZmG/EJ9mfO1IKZdGznBt8pXrvTfBPI2fJP5wGqDkkkiiyp
         efthw7OHDQxEio0JkMilLD3cCg5znvxI6sC+B7KNMH2DlXonBM427/2vyBwDSUgh94
         7IEAv0cSNs5jq7jkzYbqo1uDtK34ZMwl5MpAd1yk=
Date:   Tue, 28 Apr 2020 10:01:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com
Subject: Re: [RFC 1/5] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200428043144.GU56386@vkoul-mobl.Dlink>
References: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
 <20200416205524.2043-2-yung-chuan.liao@linux.intel.com>
 <20200420072631.GW72691@vkoul-mobl>
 <20200423142451.GA4181720@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423142451.GA4181720@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 23-04-20, 16:24, Greg KH wrote:
> On Mon, Apr 20, 2020 at 12:56:31PM +0530, Vinod Koul wrote:
> > Hello Bard,
> > 
> > On 17-04-20, 04:55, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > 
> > > In the existing SoundWire code, Master Devices are not explicitly
> > > represented - only SoundWire Slave Devices are exposed (the use of
> > > capital letters follows the SoundWire specification conventions).
> > > 
> > > The SoundWire Master Device provides the clock, synchronization
> > > information and command/control channels. When multiple links are
> > > supported, a Controller may expose more than one Master Device; they
> > > are typically embedded inside a larger audio cluster (be it in an
> > > SOC/chipset or an external audio codec), and we need to describe it
> > > using the Linux device and driver model.  This will allow for
> > > configuration functions to account for external dependencies such as
> > > power rails, clock sources or wake-up mechanisms. This transition will
> > > also allow for better sysfs support without the reference count issues
> > > mentioned in the initial reviews.
> > 
> > Well the primary reason for doing sdw_master_device for creating a
> > adding sysfs representation.
> 
> -ENOPARSE :(

Oops, sorry!

> > It *also* helps some vendors due to
> > inherent model should not be constructed as the primary approach for the
> > sdw_master_device.
> 
> No, the PRIMARY reason is "it is the correct thing to do".  It's how to
> tie into the driver model correctly, without it, crazy things happen as
> we have seen.

I agree it is *the* right this to do!

> > > In this patch, we convert the existing code to use an explicit
> > > sdw_slave_type, then define a sdw_master_device structure.
> > 
> > Please split that up, we should do the conversions required first and
> > then do addition of new things.
> 
> Can you really do that in two different steps?

Looking at it, the move of existing types first and then adding the new
type

> 
> > > +struct device_type sdw_master_type = {
> > > +	.name =		"soundwire_master",
> > > +	.release =	sdw_master_device_release,
> > > +};
> > > +
> > > +/**
> > > + * sdw_master_device_add() - create a Linux Master Device representation.
> > > + * @parent: the parent Linux device (e.g. a PCI device)
> > > + * @fwnode: the parent fwnode (e.g. an ACPI companion device to the parent)
> > > + * @link_ops: link-specific ops (optional)
> > > + * @link_id: link index as defined by MIPI DisCo specification
> > > + * @pdata: private data (e.g. register base, offsets, platform quirks, etc).
> > > + *
> > > + * The link_ops argument can be NULL, it is only used when link-specific
> > > + * initializations and power-management are required.
> > > + */
> > > +struct sdw_master_device
> > > +*sdw_master_device_add(struct device *parent,
> > > +		       struct fwnode_handle *fwnode,
> > > +		       struct sdw_link_ops *link_ops,
> > > +		       int link_id,
> > > +		       void *pdata)
> > > +{
> > > +	struct sdw_master_device *md;
> > > +	int ret;
> > > +
> > > +	md = kzalloc(sizeof(*md), GFP_KERNEL);
> > > +	if (!md)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	md->link_id = link_id;
> > > +	md->pdata = pdata;
> > > +	md->link_ops = link_ops;
> > > +
> > > +	md->dev.parent = parent;
> > > +	md->dev.fwnode = fwnode;
> > > +	md->dev.bus = &sdw_bus_type;
> > > +	md->dev.type = &sdw_master_type;
> > > +	md->dev.dma_mask = md->dev.parent->dma_mask;
> > > +	dev_set_name(&md->dev, "sdw-master-%d", md->link_id);
> > > +
> > > +	if (link_ops && link_ops->driver) {
> > > +		/*
> > > +		 * A driver is only needed for ASoC integration (need
> > > +		 * driver->name) and for link-specific power management
> > > +		 * w/ a pm_dev_ops structure.
> > 
> > That is not true for everyone, it is only true for Intel, pls call that
> > out as well...
> 
> Why is it not true for everyone?  How else do you get the pm stuff back
> to your hardware?

The rest of the world would do using the real controller device. For
example the soundwire controller on Qualcomm devices is enumerated as a
DT device and is using these...

If Intel had a standalone controller or enumerated as individual
functions, it would have been a PCI device and would manage as such

Thanks
-- 
~Vinod
