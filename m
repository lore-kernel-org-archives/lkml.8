Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C408C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79A522522
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583215555;
	bh=S8mRHdtcW2CXVVq2rYjFsKgVi7tBbhv5KMqD9VK25js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jAwWyG6VwBsGQ7dnd3DqFe78Ubiq2+ahV3A6PQ+cfu6Mn6JoJAAo/034vV5L+EG1P
	 mxtgZVTC3PTwlg38POG67YOBPo/u91rT1nmdv58OdVi2BNtF3Wp0Jz1k2ahsOvQ7oq
	 qreY9z2S4jGZxzItY875k2OaYGdcp93Wn1vWKMas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCCGFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:05:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgCCGFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:05:53 -0500
Received: from localhost (unknown [122.167.124.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C71CF206D7;
        Tue,  3 Mar 2020 06:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583215551;
        bh=S8mRHdtcW2CXVVq2rYjFsKgVi7tBbhv5KMqD9VK25js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zXbvHkeNudXpT0j/NTjtfAAKBZDRWp3CDwuLB7ZwzE2aJUneNKzbHGshEe/fafpGY
         FLcCGUP25MOXBS/80qUhiGBFTpOJ8C9Wy+8RrgFYjSxJShz/Bjb3k5R92A6AjFJ4QZ
         94QGhWFZ0+beEMHyKUCEXB26Pr/OSUuyIvzEe5xk=
Date:   Tue, 3 Mar 2020 11:35:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 2/8] soundwire: intel: transition to
 sdw_master_device/driver support
Message-ID: <20200303060547.GQ4148@vkoul-mobl>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227223206.5020-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-02-20, 16:32, Pierre-Louis Bossart wrote:

> +static struct sdw_intel_ctx
> +*sdw_intel_probe_controller(struct sdw_intel_res *res)
> +{
> +	struct sdw_intel_link_res *link;
> +	struct sdw_intel_ctx *ctx;
> +	struct acpi_device *adev;
> +	struct sdw_master_device *md;
> +	unsigned long time;
> +	u32 link_mask;
> +	int count;
> +	int i;
> +
> +	if (!res)
> +		return NULL;
> +
> +	if (acpi_bus_get_device(res->handle, &adev))
> +		return NULL;
> +
> +	if (!res->count)
> +		return NULL;
> +
> +	count = res->count;
>  	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
>  
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return NULL;
>  
> -	ctx->count = count;
> -	ctx->links = kcalloc(ctx->count, sizeof(*ctx->links), GFP_KERNEL);
> +	ctx->links = kcalloc(count, sizeof(*ctx->links), GFP_KERNEL);
>  	if (!ctx->links)
>  		goto link_err;
>  
> +	ctx->count = count;
> +	ctx->mmio_base = res->mmio_base;
> +	ctx->link_mask = res->link_mask;
> +	ctx->handle = res->handle;
> +
>  	link = ctx->links;
> +	link_mask = ctx->link_mask;
>  
>  	/* Create SDW Master devices */
> -	for (i = 0; i < count; i++) {
> -		if (link_mask && !(link_mask & BIT(i))) {
> -			dev_dbg(&adev->dev,
> -				"Link %d masked, will not be enabled\n", i);
> -			link++;
> +	for (i = 0; i < count; i++, link++) {
> +		if (link_mask && !(link_mask & BIT(i)))
>  			continue;
> -		}
>  
> +		link->mmio_base = res->mmio_base;
>  		link->registers = res->mmio_base + SDW_LINK_BASE
> -					+ (SDW_LINK_SIZE * i);
> +			+ (SDW_LINK_SIZE * i);
>  		link->shim = res->mmio_base + SDW_SHIM_BASE;
>  		link->alh = res->mmio_base + SDW_ALH_BASE;
> -
> +		link->irq = res->irq;
>  		link->ops = res->ops;
>  		link->dev = res->dev;
> +		link->clock_stop_quirks = res->clock_stop_quirks;
>  
> -		memset(&pdevinfo, 0, sizeof(pdevinfo));
> +		md = sdw_master_device_add("intel-master",
> +					   res->parent,
> +					   acpi_fwnode_handle(adev),
> +					   i,
> +					   link);

So we add the device in intel layer

>  
> -		pdevinfo.parent = res->parent;
> -		pdevinfo.name = "int-sdw";
> -		pdevinfo.id = i;
> -		pdevinfo.fwnode = acpi_fwnode_handle(adev);
> +		if (IS_ERR(md)) {
> +			dev_err(&adev->dev, "Could not create link %d\n", i);
> +			goto err;
> +		}
>  
> -		pdev = platform_device_register_full(&pdevinfo);
> -		if (IS_ERR(pdev)) {
> -			dev_err(&adev->dev,
> -				"platform device creation failed: %ld\n",
> -				PTR_ERR(pdev));
> -			goto pdev_err;
> +		/*
> +		 * we need to wait for the bus to be probed so that we
> +		 * can report ACPI information to the upper layers
> +		 */
> +		time = wait_for_completion_timeout(&md->probe_complete,
> +				msecs_to_jiffies(SDW_INTEL_MASTER_PROBE_TIMEOUT));

Then wait for probe to complete..

> +static int
> +sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
> +{
> +	struct acpi_device *adev;
> +	struct sdw_intel_link_res *link;
> +	struct sdw_master_device *md;
> +	u32 caps;
> +	u32 link_mask;
> +	int i;
> +
> +	if (acpi_bus_get_device(ctx->handle, &adev))
> +		return -EINVAL;
> +
> +	/* Check SNDWLCAP.LCOUNT */
> +	caps = ioread32(ctx->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
> +	caps &= GENMASK(2, 0);
> +
> +	/* Check HW supported vs property value */
> +	if (caps < ctx->count) {
> +		dev_err(&adev->dev,
> +			"BIOS master count is larger than hardware capabilities\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!ctx->links)
> +		return -EINVAL;
> +
> +	link = ctx->links;
> +	link_mask = ctx->link_mask;
> +
> +	/* Startup SDW Master devices */
> +	for (i = 0; i < ctx->count; i++, link++) {
> +		if (link_mask && !(link_mask & BIT(i)))
> +			continue;
> +
> +		md = link->md;
> +
> +		sdw_master_device_startup(md);

And finally start the device.

If i look at bigger picture:

PCI SOF driver scans the capabilities and finds SoundWire supported:
 - Invokes sdw_intel_probe_controller() 
        - This adds sdw_master_device and waits till the probe is
          complete.
 - Invokes sdw_intel_startup_controller()
        - It starts up the controller by calling
          sdw_master_device_startup()

Now, I guess at the peril of repeating myself again:

Why not do:

- PCI SOF driver scans the capabilities and finds SoundWire supported:
  - Invokes sdw_intel_probe_controller()
        - This adds sdw_master_device
        - Does rest of device init and context init
  - Invoked sdw_intel_startup_controller()
        - Calls sdw_master_device_startup() to start

You will get more fine grained control of the sequencing, no need to
wait for dummy probe to be over. The device for these would be parent
PCI SOF device and driver PCI SOF driver.

So in summary I do not see a reason for even Intel to have a dummy
soundwire_master_driver.

-- 
~Vinod
