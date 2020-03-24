Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A06C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D162070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585052984;
	bh=rLxiOcqOkRsSAHjoD3lA2Lf9MiRMaREGfMhws5KUdow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GevO5vL/mtVlY1ASX756FJ7u2q4tMwuS0cgcgTBMSXv9ZgUTuZdY9eeVFP/WYq5Vd
	 bPIKMDTH+EAu78e5WXhHafbzP9f+CMAwgrFAmhj60o14dGoPqQAjGR/BOvdQWv7sj0
	 E+E2DcjljBxRVXg/gE7jMC2VmpHu9zndOgXXu1fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCXM3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgCXM3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:29:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC2A2070A;
        Tue, 24 Mar 2020 12:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585052981;
        bh=rLxiOcqOkRsSAHjoD3lA2Lf9MiRMaREGfMhws5KUdow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmDh34MPa5SNKf2udh4/NXWRtTSAjQoGI9Hh3b8R2u7vPZtpwUbaLKEdOUpyFGowj
         BN5yAHZWjj30ZkmOWsLHxJsEE0vdfnF/9UcvzzLvunndm3iFfcvJIs4NSaMaP1Cujq
         ppvU9fgUs4EGFMmmEKd8TWdJKxDceg0KBfZihKnw=
Date:   Tue, 24 Mar 2020 13:29:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
Message-ID: <20200324122939.GA2348009@kroah.com>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
 <20200323190505.GB632476@kroah.com>
 <4820047d-9a99-749c-491d-dbb91a2f5447@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4820047d-9a99-749c-491d-dbb91a2f5447@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 12:24:00PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 23/03/2020 19:05, Greg KH wrote:
> > On Mon, Mar 23, 2020 at 03:00:07PM +0000, Srinivas Kandagatla wrote:
> > > From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > 
> > > There is at least one real-world use-case for write-only nvmem
> > > instances. Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if
> > > non-active NVMem file is read").
> > > 
> > > Add support for write-only nvmem instances by adding attrs for 0200.
> > > 
> > > Change nvmem_register() to abort if NULL group is returned from
> > > nvmem_sysfs_get_groups().
> > > 
> > > Return NULL from nvmem_sysfs_get_groups() in invalid cases.
> > > 
> > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   drivers/nvmem/core.c        | 10 +++++--
> > >   drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
> > >   2 files changed, 56 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > > index 77d890d3623d..ddc7be5149d5 100644
> > > --- a/drivers/nvmem/core.c
> > > +++ b/drivers/nvmem/core.c
> > > @@ -381,6 +381,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> > >   	nvmem->type = config->type;
> > >   	nvmem->reg_read = config->reg_read;
> > >   	nvmem->reg_write = config->reg_write;
> > > +	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> > > +	if (!nvmem->dev.groups) {
> > > +		ida_simple_remove(&nvmem_ida, nvmem->id);
> > > +		gpiod_put(nvmem->wp_gpio);
> > > +		kfree(nvmem);
> > > +		return ERR_PTR(-EINVAL);
> > > +	}
> > > +
> > >   	if (!config->no_of_node)
> > >   		nvmem->dev.of_node = config->dev->of_node;
> > > @@ -395,8 +403,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> > >   	nvmem->read_only = device_property_present(config->dev, "read-only") ||
> > >   			   config->read_only || !nvmem->reg_write;
> > > -	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> > > -
> > >   	device_initialize(&nvmem->dev);
> > >   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> > > diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> > > index 8759c4470012..9728da948988 100644
> > > --- a/drivers/nvmem/nvmem-sysfs.c
> > > +++ b/drivers/nvmem/nvmem-sysfs.c
> > > @@ -202,16 +202,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
> > >   	NULL,
> > >   };
> > > +/* write only permission, root only */
> > > +static struct bin_attribute bin_attr_wo_root_nvmem = {
> > > +	.attr	= {
> > > +		.name	= "nvmem",
> > > +		.mode	= 0200,
> > > +	},
> > > +	.write	= bin_attr_nvmem_write,
> > > +};
> > 
> > You are adding a new sysfs file without a Documentation/ABI/ new entry
> > as well?
> 
> This is not a new file, we already have documentation for this file at
> ./Documentation/ABI/stable/sysfs-bus-nvmem
> 
> Thanks for dropping this patch, I did endup finding some issues with this
> patch.
> 
> replied to original patch on the list with CC.
> 
> > 
> > 
> > > +
> > > +static struct bin_attribute *nvmem_bin_wo_root_attributes[] = {
> > > +	&bin_attr_wo_root_nvmem,
> > > +	NULL,
> > > +};
> > > +
> > > +static const struct attribute_group nvmem_bin_wo_root_group = {
> > > +	.bin_attrs	= nvmem_bin_wo_root_attributes,
> > > +	.attrs		= nvmem_attrs,
> > > +};
> > > +
> > > +static const struct attribute_group *nvmem_wo_root_dev_groups[] = {
> > > +	&nvmem_bin_wo_root_group,
> > > +	NULL,
> > > +};
> > > +
> > >   const struct attribute_group **nvmem_sysfs_get_groups(
> > >   					struct nvmem_device *nvmem,
> > >   					const struct nvmem_config *config)
> > >   {
> > > -	if (config->root_only)
> > > -		return nvmem->read_only ?
> > > -			nvmem_ro_root_dev_groups :
> > > -			nvmem_rw_root_dev_groups;
> > > +	/* Read-only */
> > > +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
> > > +		return config->root_only ?
> > > +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
> > > +
> > > +	/* Read-write */
> > > +	if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> > > +		return config->root_only ?
> > > +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
> > > +
> > > +	/* Write-only, do not honour request for global writable entry */
> > > +	if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> > > +		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
> > 
> > 
> > What is this supposed to be doing, I am totally lost.
> 
> I agree, its bit confusing to the reader, but it does work.
> 
> But the Idea here is :
> We ended up with providing different options like read-only,root-only to
> nvmem providers combined with read/write callbacks.
> With that, there are some cases which are totally invalid, existing code
> does very minimal check to ensure that before populating with correct
> attributes to sysfs file. One of such case is with thunderbolt provider
> which supports only write callback.
> 
> With this new checks in place these flags and callbacks are correctly
> validated, would result in correct file attributes.

Why this crazy set of different groups?  You can set the mode of a sysfs
file in the callback for when the file is about to be created, that's so
much simpler and is what it is for.  This feels really hacky and almost
impossible to follow :(

thanks,

greg k-h
