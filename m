Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A9EC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9552051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584990312;
	bh=jdBtV9RPdFT7VwigIuuOLSzGDJeem2g/cmvpoZ/9w/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RQNfcJEussVxZYHN40fZKbpi7w7wlxSycEB8E3hWuRb8LdQsS6g6Fyfcm7u37IPlE
	 GO8JzHosQcK0vlOrPYMKlO/hjgsR5xRo+L9ZH4JLlIiQdTBll1UQORsmJ+rtt9y2JC
	 u9+dlYYp9z/XjrpciUHYof12q9P1884zRGCxXc3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgCWTFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbgCWTFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:05:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931232051A;
        Mon, 23 Mar 2020 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584990308;
        bh=jdBtV9RPdFT7VwigIuuOLSzGDJeem2g/cmvpoZ/9w/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKi/4laoKU1BkfSXlOiMXVtcTuH1DkfScCH4aJA2jnrewbHm9rfu5rw/+aCouSYPE
         B/KnXoFQ6d0/eo6nkJUQpCDzcytcRCuU6icCy/e5zvacYDiqOo/RjMjUQS0xyz+GLr
         eD6Kf2PGLnIXrfBGDT8TgLPE1T8ijg844JAmJohE=
Date:   Mon, 23 Mar 2020 20:05:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
Message-ID: <20200323190505.GB632476@kroah.com>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 03:00:07PM +0000, Srinivas Kandagatla wrote:
> From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> 
> There is at least one real-world use-case for write-only nvmem
> instances. Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if
> non-active NVMem file is read").
> 
> Add support for write-only nvmem instances by adding attrs for 0200.
> 
> Change nvmem_register() to abort if NULL group is returned from
> nvmem_sysfs_get_groups().
> 
> Return NULL from nvmem_sysfs_get_groups() in invalid cases.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/core.c        | 10 +++++--
>  drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
>  2 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 77d890d3623d..ddc7be5149d5 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -381,6 +381,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	nvmem->type = config->type;
>  	nvmem->reg_read = config->reg_read;
>  	nvmem->reg_write = config->reg_write;
> +	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> +	if (!nvmem->dev.groups) {
> +		ida_simple_remove(&nvmem_ida, nvmem->id);
> +		gpiod_put(nvmem->wp_gpio);
> +		kfree(nvmem);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	if (!config->no_of_node)
>  		nvmem->dev.of_node = config->dev->of_node;
>  
> @@ -395,8 +403,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	nvmem->read_only = device_property_present(config->dev, "read-only") ||
>  			   config->read_only || !nvmem->reg_write;
>  
> -	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> -
>  	device_initialize(&nvmem->dev);
>  
>  	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> index 8759c4470012..9728da948988 100644
> --- a/drivers/nvmem/nvmem-sysfs.c
> +++ b/drivers/nvmem/nvmem-sysfs.c
> @@ -202,16 +202,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
>  	NULL,
>  };
>  
> +/* write only permission, root only */
> +static struct bin_attribute bin_attr_wo_root_nvmem = {
> +	.attr	= {
> +		.name	= "nvmem",
> +		.mode	= 0200,
> +	},
> +	.write	= bin_attr_nvmem_write,
> +};

You are adding a new sysfs file without a Documentation/ABI/ new entry
as well?


> +
> +static struct bin_attribute *nvmem_bin_wo_root_attributes[] = {
> +	&bin_attr_wo_root_nvmem,
> +	NULL,
> +};
> +
> +static const struct attribute_group nvmem_bin_wo_root_group = {
> +	.bin_attrs	= nvmem_bin_wo_root_attributes,
> +	.attrs		= nvmem_attrs,
> +};
> +
> +static const struct attribute_group *nvmem_wo_root_dev_groups[] = {
> +	&nvmem_bin_wo_root_group,
> +	NULL,
> +};
> +
>  const struct attribute_group **nvmem_sysfs_get_groups(
>  					struct nvmem_device *nvmem,
>  					const struct nvmem_config *config)
>  {
> -	if (config->root_only)
> -		return nvmem->read_only ?
> -			nvmem_ro_root_dev_groups :
> -			nvmem_rw_root_dev_groups;
> +	/* Read-only */
> +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
> +		return config->root_only ?
> +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
> +
> +	/* Read-write */
> +	if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> +		return config->root_only ?
> +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
> +
> +	/* Write-only, do not honour request for global writable entry */
> +	if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
> +		return config->root_only ? nvmem_wo_root_dev_groups : NULL;


What is this supposed to be doing, I am totally lost.

greg k-h
