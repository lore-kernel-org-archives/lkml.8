Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D466C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BCF20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlXMrRW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgCERDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:03:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41915 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCERDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:03:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id v4so7928839wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hHPiLUd9Vqu0fARHM9kAYBclFZJwYelUs5zlBPCC7IA=;
        b=nlXMrRW9tAvk+bar6IoHNikZAQf0IRsrZVBd1w//XqEAzwP91n3kJZTZnP++BnGw9d
         wmCQdKXJSZRfTREui8ShtBwtabJ8sgfKMK/Jk7vU1utOyPerbmDzTqeLL3ip65O+fKgL
         Yp7oXX5vkiAHCdaeNrX7/h9FRai2fS9StwNAcRY17LG+wNiKG92mIU/vYiJEbbbMLq5D
         aWxinpBKw//krQs9BUgKxKqobm6PHKfPyNKYzEJk/ylmCq27mYRVdDQohdCDfN796tdP
         ht7GlkUjhj5pqmJH0R+bC332zPBSAqh0ZXayAYw/oeE2NEbOFWOYRIq6W7w0I9O8FGU8
         FM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hHPiLUd9Vqu0fARHM9kAYBclFZJwYelUs5zlBPCC7IA=;
        b=l/NtnMgLcCeNRCT0QmNjBkyHmcdZN/bTFP0M+Pvz9G9/0e9wtoP39Ycx/DvNkV8Wty
         bUbtVj8t3oLkB17dBc4c9BI09rGEhUaIP529SPzRkby3BDXFfzyvjV4M+8GjQibVPrp0
         p/uwU6p3CXFTizPFhlZ3hRKMVZu+h5CGdIRznbD69SHAaai0auOzVlo9yEWxZUV6Q9ck
         zD2lIJ/sK3eXIIJzDzHQfAJz/H7SVDlUwXfdrX44CYQKUjtbxnAgD2tlkejF2tupxcyk
         xFNixVFh2h5SYe1CXA1BO1Ti7J0urn+HR0ZcKTLegHhzq6056Xsukg2DNdgXk+yk6R4u
         /q8w==
X-Gm-Message-State: ANhLgQ11Yj4WUtH1yCuMpo7UIa4zQ8gd+K0ozg3lNnvwk6yroKrZGxPm
        CmRu0k5KCUlc1s/wmjbgrQHxLULuhMY=
X-Google-Smtp-Source: ADFU+vuJyYO4yt6HwG11Zm56RxBoyaZqq7thyZi/sX5lIWI48g1VsaxF2uKpSccjn2G1AgvghRkeDw==
X-Received: by 2002:adf:ec52:: with SMTP id w18mr11028719wrn.26.1583427793486;
        Thu, 05 Mar 2020 09:03:13 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r19sm9464829wmh.26.2020.03.05.09.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 09:03:12 -0800 (PST)
Subject: Re: [PATCH v2 1/3] nvmem: Add support for write-only instances
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
References: <PSXP216MB0438930B1FC30EF79F15FD1780E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b934ddde-702a-1731-034d-1682a9df23e2@linaro.org>
Date:   Thu, 5 Mar 2020 17:03:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0438930B1FC30EF79F15FD1780E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/03/2020 15:42, Nicholas Johnson wrote:
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
>   drivers/nvmem/core.c        |  2 ++
>   drivers/nvmem/nvmem-sysfs.c | 53 ++++++++++++++++++++++++++++++++-----
>   2 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ef326f243..27bd4c4e3 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -388,6 +388,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   			   config->read_only || !nvmem->reg_write;
>   
>   	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
> +	if (!nvmem->dev.groups)
> +		return NULL;
Returning here will be leaking in this function.

>   
>   	device_initialize(&nvmem->dev);
>   
> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> index 9e0c429cd..00d3259ea 100644
> --- a/drivers/nvmem/nvmem-sysfs.c
> +++ b/drivers/nvmem/nvmem-sysfs.c
> @@ -196,16 +196,50 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
>   	NULL,
>   };
>   
> +/* write only permission, root only */
> +static struct bin_attribute bin_attr_wo_root_nvmem = {

TBH, you would not need this patch once 2/3 patch is applied.
Unless there is a strong reason for you to have write only file.

If for any reasons you would want to add Write only file then it should 
be added for both with root and user privileges.

>   const struct attribute_group **nvmem_sysfs_get_groups(
>   					struct nvmem_device *nvmem,
>   					const struct nvmem_config *config)
>   {
> -	if (config->root_only)
> -		return nvmem->read_only ?
> -			nvmem_ro_root_dev_groups :
> -			nvmem_rw_root_dev_groups;
> -
> -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> +	/* Read-only */
> +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
> +		return config->root_only ?
> +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
> +
> +	/* Read-write */
> +	if (nvmem->reg_read && nvmem->reg_write)

read_only flag will override this assumption!

> +		return config->root_only ?
> +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
> +
> +	/* Write-only, do not honour request for global writable entry */
> +	if (!nvmem->reg_read && nvmem->reg_write)
> +		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
> +
> +	/* Neither reg_read nor reg_write are provided, abort */
This should not be the case anymore after this check in place

https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/commit/?h=for-next&id=f8f782f63bace8b08362e466747e648ca57b6c06

thanks,
srini

> +	return NULL;
>   }
>   
>   /*
> @@ -224,11 +258,16 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
>   	if (!config->base_dev)
>   		return -EINVAL;
>   
> -	if (nvmem->read_only) {
> +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only)) {
>   		if (config->root_only)
>   			nvmem->eeprom = bin_attr_ro_root_nvmem;
>   		else
>   			nvmem->eeprom = bin_attr_ro_nvmem;
> +	} else if (!nvmem->reg_read && nvmem->reg_write) {
> +		if (config->root_only)
> +			nvmem->eeprom = bin_attr_wo_root_nvmem;
> +		else
> +			return -EPERM;
>   	} else {
>   		if (config->root_only)
>   			nvmem->eeprom = bin_attr_rw_root_nvmem;
> 
