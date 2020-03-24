Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD5C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139ED20658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhro6EjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCXMX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:23:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37655 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCXMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:23:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id d1so3229672wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mufZG5/pHTT/BU7NPug772ycUZmf+Hdmb7Tdh23IbLY=;
        b=bhro6EjBkXlkItYYnrONWxE3yLRkV/9Ru6VZaTipS1qPzkuNggmuwscJyyu8h5wft6
         b2qsEVSp9WAnyERCJloIcZVaWF8TDPo8nRLMjOqGdwDILl+rjksMuxexUbiatQMb/4Rc
         UP8iU52IwEZLQoBXoCnqWXxsE0ednzM/Cj45c0DZlL/eE92BX2OKQdu7DRhWm9YWJ15I
         ZwpN/m3k9xjEpJxZVZ+zecJ0oMm6tqfyh1zBt59YnfrVNYJEU513pQ8f5pE8FkWNj8Up
         PpkrxwG+/5MP33bmcpQTFQS8mCtgypTKsnxhrq6cZDbOvSFRyPjq0knxitnSLtse8gqv
         IFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mufZG5/pHTT/BU7NPug772ycUZmf+Hdmb7Tdh23IbLY=;
        b=SvVGZ6zUql3gm7k7SyhQR/VR5LLPTBifYjq1A6v+nLCI2qOQY0xa2zeVHfg4l59HN6
         SgH4tgTT7gxKONmVpHAM/LAtW9xSNo5lcTR02Cd1BsQ5qNg73fqbevdwC2tfsA80wL6a
         EozP08E9PfQndrD5xwZ0hpMTJ5qyY828jO1AhTnhNMzC4ErVN1WsvEi394hzeJJvt/Cu
         1w+ELmyS0xzUVYZgGKrrJxObewiHcs3jCvnnF/2eXF752SNFK3NcO2Q5BPeT2E2WKm1a
         kR65SHEIryLSJdSguu8KAg76Jj2PCAatG34Ft6f+q9s6b90cGeSTU3EAuEQ8zHedJ5Vz
         W3fw==
X-Gm-Message-State: ANhLgQ3XTXGQbiNpM2ELKZqsZf2ktPHMct/UNCBg7H67r0Ier78NIUec
        vqC1GaMyAECJ6ATmtG0NqvraYw==
X-Google-Smtp-Source: ADFU+vtufQEdeZrQkE61849birJR56e2XJjUDfj0eArVmoszUWlXpy58ujbtCnw1lhwDO8qPSVZQIQ==
X-Received: by 2002:a7b:c359:: with SMTP id l25mr5369621wmj.149.1585052605119;
        Tue, 24 Mar 2020 05:23:25 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f9sm29463391wro.47.2020.03.24.05.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 05:23:24 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] nvmem: Add support for write-only instances
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <PSXP216MB0438D2F2D9B648BAF9A007A580F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2565d557-0425-1a80-18c9-bab34355364c@linaro.org>
Date:   Tue, 24 Mar 2020 12:23:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0438D2F2D9B648BAF9A007A580F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for such late review, but I did endup finding two new issues with 
this patch.

On 18/03/2020 15:20, Nicholas Johnson wrote:
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
>   drivers/nvmem/core.c        | 10 +++++--
>   drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
>   2 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 77d890d36..ddc7be514 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -381,6 +381,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->type = config->type;
>   	nvmem->reg_read = config->reg_read;
>   	nvmem->reg_write = config->reg_write;
> +	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> +	if (!nvmem->dev.groups) {
> +		ida_simple_remove(&nvmem_ida, nvmem->id);
> +		gpiod_put(nvmem->wp_gpio);
> +		kfree(nvmem);
> +		return ERR_PTR(-EINVAL);
> +	}

returning NULL is valid usecase here, consider it like not having 
CONFIG_NVMEM_SYSFS so no need to check the return value.

But a warning/error message from nvmem_sysfs_get_groups would help debug 
in case of invalid configurations.

> +
>   	if (!config->no_of_node)
>   		nvmem->dev.of_node = config->dev->of_node;
>   
> @@ -395,8 +403,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->read_only = device_property_present(config->dev, "read-only") ||
>   			   config->read_only || !nvmem->reg_write;
>   
> -	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> -
Moving this to before read_only flag is set would not work! as 
nvmem_sysfs_get_groups() is going to use read_only flag.

Ideally you do not need to change anything in core.c file and just 
update nvmem-sysfs.c should be enough.


>   	device_initialize(&nvmem->dev);
>   
>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
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
