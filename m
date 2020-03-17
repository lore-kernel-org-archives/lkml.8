Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379CEC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E6C206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4DWL9i7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCQOfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:35:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52346 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgCQOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:35:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so21695946wmo.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gSJRbIVgX8i+xZAk9lQluiv5blj7VYyYSjV8cumfsus=;
        b=p4DWL9i70bOxhaj+mK8PQPcixvgMkxC88MZbakHIg8W6nhAlsyKQXp2OnAzKFKy56i
         ZDXNfx7mnkgcnFWj9UL9Ic/h8H2JpHMsON56UTX2hnnCEjDb6xXVPF9woNqD7LH1TiEN
         WdzhTYrX4aB1uXvHsO2dLF+CMYEhtmCtuTxYWgvJUYgw5AFTsQiqA09JpUMVchLG+EXY
         VfsuApHfiZklRHXLbslqf3+V79Qvzp4sGZv06ke73JpukrO9Q8Fo/gz+FvoRCsUmkEiS
         8Eco4oF6597u5L+0mj/l3AMPKUOgCP4VMZn1UxanEzVBHbm+NaZ33d3MLgS3DoQexvEY
         Ba5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gSJRbIVgX8i+xZAk9lQluiv5blj7VYyYSjV8cumfsus=;
        b=bs6B4eX/qI2aNEQ4njiL96HmLPOtl/6ayVmAql5+kMm9oGsMmfoLgyfqHtFmkxsiF6
         I4UI9kUyzf+Vdw95hFXHgQAsjuVutjBPBu+RDGjOdEZ41phREMl/tMV1jan68b/MddYX
         4iPdYQfAoSpywJn7znCcL4Q6ddmcMafndelhlzIg3NqhTkVFFsKLcTYPWQOu8j9WBYJF
         +VMbwMSZYJ30E4I3SK5Kp/t7hqDuxzWpHY04mwZbvPF7ehyzVQ695+kHP3GqySGveBIG
         YKnaDBrEYXYa3pHRQuP3CRmKGWv2UYFmKlQ2LXW+eYf0vHK3BDoQsHVbVz26rI+xFPAx
         mQ9g==
X-Gm-Message-State: ANhLgQ18wnfaK2ssXDRarXmXGdTpzibhUCcQ9X5X6XpNvnd0axNjGJ44
        XtTwO1qaZXjlMm7gax+JcaiVoA==
X-Google-Smtp-Source: ADFU+vubuaVHM2UNrgxyyswhPCmERd985Vu/webqpNC2Sifcs6g86WUqMUSFygKl0e6cbm9kKrFMlw==
X-Received: by 2002:a1c:5505:: with SMTP id j5mr5662208wmb.170.1584455747763;
        Tue, 17 Mar 2020 07:35:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b15sm4864658wru.70.2020.03.17.07.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 07:35:45 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] nvmem: Add support for write-only instances
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
References: <PSXP216MB0438A934627303A4A0E2D96280F60@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <74d0c4a6-a056-ad45-529e-97b117d4e60b@linaro.org>
Date:   Tue, 17 Mar 2020 14:35:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0438A934627303A4A0E2D96280F60@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2020 01:01, Nicholas Johnson wrote:
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
> ---
>   drivers/nvmem/core.c        |  9 ++++--
>   drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
>   2 files changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ef326f243..95ea9a3b2 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -373,6 +373,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->type = config->type;
>   	nvmem->reg_read = config->reg_read;
>   	nvmem->reg_write = config->reg_write;
> +	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> +	if (!nvmem->dev.groups) {
> +		kfree(nvmem);
> +		return ERR_PTR(-EINVAL);

When I meant leaking here, not just memory but other resources like idr 
and gpio.

You should do something like this:

if (!nvmem->dev.groups) {
	ida_simple_remove(&nvmem_ida, nvmem->id);
	gpiod_put(nvmem->wp_gpio);
	kfree(nvmem);
	return ERR_PTR(-EINVAL);
}

> +	}
> +
>   	if (!config->no_of_node)
>   		nvmem->dev.of_node = config->dev->of_node;
>   
> @@ -387,8 +393,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->read_only = device_property_present(config->dev, "read-only") ||
>   			   config->read_only || !nvmem->reg_write;
>   
> -	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> -
>   	device_initialize(&nvmem->dev);
>   
>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> @@ -430,7 +434,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	device_del(&nvmem->dev);
>   err_put_device:
>   	put_device(&nvmem->dev);
> -
unnecessary cleanup here!

Other than that every thing looks good to me!


--srini

>   	return ERR_PTR(rval);
>   }
>   EXPORT_SYMBOL_GPL(nvmem_register);
> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> index 9e0c429cd..4ceac8680 100644
> --- a/drivers/nvmem/nvmem-sysfs.c
> +++ b/drivers/nvmem/nvmem-sysfs.c
> @@ -196,16 +196,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
>   	NULL,
>   };
>   
> +/* write only permission, root only */
> +static struct bin_attribute bin_attr_wo_root_nvmem = {
> +	.attr	= {
> +		.name	= "nvmem",
> +		.mode	= 0200,
> +	},
> +	.write	= bin_attr_nvmem_write,
> +};
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
>   const struct attribute_group **nvmem_sysfs_get_groups(
>   					struct nvmem_device *nvmem,
>   					const struct nvmem_config *config)
>   {
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
>   
> -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> +	return NULL;
>   }
>   
>   /*
> @@ -224,17 +257,24 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
>   	if (!config->base_dev)
>   		return -EINVAL;
>   
> -	if (nvmem->read_only) {
> +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only)) {
>   		if (config->root_only)
>   			nvmem->eeprom = bin_attr_ro_root_nvmem;
>   		else
>   			nvmem->eeprom = bin_attr_ro_nvmem;
> -	} else {
> +	} else if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
> +		if (config->root_only)
> +			nvmem->eeprom = bin_attr_wo_root_nvmem;
> +		else
> +			return -EINVAL;
> +	} else if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
>   		if (config->root_only)
>   			nvmem->eeprom = bin_attr_rw_root_nvmem;
>   		else
>   			nvmem->eeprom = bin_attr_rw_nvmem;
> -	}
> +	} else
> +		return -EINVAL;
> +
>   	nvmem->eeprom.attr.name = "eeprom";
>   	nvmem->eeprom.size = nvmem->size;
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> 
