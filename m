Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41363C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADE22080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USB8V3we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgCXMYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:24:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36568 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCXMYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:24:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so3236830wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W3njDq++V0fnVaQjVuHrpdc6joRD8TioaAqU3Z2sPLY=;
        b=USB8V3weuqbifR7yNXoWhffMn6fiwIb3drdXdsnzYTyKd4rA6mFg5JftnxjHDnz6N0
         fCRjr3EZJFtH47dclBE6f3zQZW7zyPOQEH+saI28GeBce+04bQUyY7YBNPialhftDAB6
         Nm4ICy7Ptj9hzk+Yr1obgBWzKabE4l60yLwRCHTXOsFrn8kaZrMm7CExW8vk5DmCDuIX
         NG8H8XRkf9syM4TrRuPCdhRUu12hOuIoRrTv4TVsGpP0Cwp0IHDP1QDRaBJka2+cRqo8
         6sXz8N53bQ6A/vr92ijqIWD/s83R2TUHtW23IqnDVMxc+QFhhX+LgL3i7r9P3hsA3CDz
         yb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W3njDq++V0fnVaQjVuHrpdc6joRD8TioaAqU3Z2sPLY=;
        b=K02S2kxy8/YMt3Zn/twmE/+Rhr57TI6kKltlxH81uw2xVpamiapEYcpl2unVOO2YXK
         qzNIPsBv0rzW9fiFeCecAXuun8s5tXMXHWCPjSZhrKWS7tABPJ8pkj+yOjvRb884mC16
         yDC7r1/yp2l4JBKzd9x/DUwR+XUw8PmMZCE7OQYhGNe+7VIpo5j6gPsLO+4ZOpmazgXz
         dKwwGYDWBvPBFx9oniggPaHivbCodX7mJvs61tgKCVN/JAOzYwH/LpEmW1RkOmDufu3V
         kPF9AqcH4f6ngLQ+lH7JxlxGFEvMBBbngvJQwT3Reqc5JcdjwD8fQoulVKB7SQ8rXXcG
         EdzA==
X-Gm-Message-State: ANhLgQ3/UWFipcNlSef+LF2mKdLuNENZ0SctXWYpZ3Mp4jMHy/fL0tHW
        0PYsKv5RkoqyWlfVXqATVlPdTZtqUMs=
X-Google-Smtp-Source: ADFU+vu3ybeBolOOXfz1xv5f2iEmwLAxcHOu9NI+KxYBak67rz6XC15ZZUQjOn6GwuuN+OWLNQ+bew==
X-Received: by 2002:a1c:3241:: with SMTP id y62mr5640129wmy.66.1585052641418;
        Tue, 24 Mar 2020 05:24:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t10sm6006329wrx.38.2020.03.24.05.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 05:24:00 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     linux-kernel@vger.kernel.org
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
 <20200323190505.GB632476@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4820047d-9a99-749c-491d-dbb91a2f5447@linaro.org>
Date:   Tue, 24 Mar 2020 12:24:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200323190505.GB632476@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/03/2020 19:05, Greg KH wrote:
> On Mon, Mar 23, 2020 at 03:00:07PM +0000, Srinivas Kandagatla wrote:
>> From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
>>
>> There is at least one real-world use-case for write-only nvmem
>> instances. Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if
>> non-active NVMem file is read").
>>
>> Add support for write-only nvmem instances by adding attrs for 0200.
>>
>> Change nvmem_register() to abort if NULL group is returned from
>> nvmem_sysfs_get_groups().
>>
>> Return NULL from nvmem_sysfs_get_groups() in invalid cases.
>>
>> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/nvmem/core.c        | 10 +++++--
>>   drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
>>   2 files changed, 56 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 77d890d3623d..ddc7be5149d5 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -381,6 +381,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>   	nvmem->type = config->type;
>>   	nvmem->reg_read = config->reg_read;
>>   	nvmem->reg_write = config->reg_write;
>> +	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
>> +	if (!nvmem->dev.groups) {
>> +		ida_simple_remove(&nvmem_ida, nvmem->id);
>> +		gpiod_put(nvmem->wp_gpio);
>> +		kfree(nvmem);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>>   	if (!config->no_of_node)
>>   		nvmem->dev.of_node = config->dev->of_node;
>>   
>> @@ -395,8 +403,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>   	nvmem->read_only = device_property_present(config->dev, "read-only") ||
>>   			   config->read_only || !nvmem->reg_write;
>>   
>> -	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
>> -
>>   	device_initialize(&nvmem->dev);
>>   
>>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
>> index 8759c4470012..9728da948988 100644
>> --- a/drivers/nvmem/nvmem-sysfs.c
>> +++ b/drivers/nvmem/nvmem-sysfs.c
>> @@ -202,16 +202,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
>>   	NULL,
>>   };
>>   
>> +/* write only permission, root only */
>> +static struct bin_attribute bin_attr_wo_root_nvmem = {
>> +	.attr	= {
>> +		.name	= "nvmem",
>> +		.mode	= 0200,
>> +	},
>> +	.write	= bin_attr_nvmem_write,
>> +};
> 
> You are adding a new sysfs file without a Documentation/ABI/ new entry
> as well?

This is not a new file, we already have documentation for this file at
./Documentation/ABI/stable/sysfs-bus-nvmem

Thanks for dropping this patch, I did endup finding some issues with 
this patch.

replied to original patch on the list with CC.

> 
> 
>> +
>> +static struct bin_attribute *nvmem_bin_wo_root_attributes[] = {
>> +	&bin_attr_wo_root_nvmem,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group nvmem_bin_wo_root_group = {
>> +	.bin_attrs	= nvmem_bin_wo_root_attributes,
>> +	.attrs		= nvmem_attrs,
>> +};
>> +
>> +static const struct attribute_group *nvmem_wo_root_dev_groups[] = {
>> +	&nvmem_bin_wo_root_group,
>> +	NULL,
>> +};
>> +
>>   const struct attribute_group **nvmem_sysfs_get_groups(
>>   					struct nvmem_device *nvmem,
>>   					const struct nvmem_config *config)
>>   {
>> -	if (config->root_only)
>> -		return nvmem->read_only ?
>> -			nvmem_ro_root_dev_groups :
>> -			nvmem_rw_root_dev_groups;
>> +	/* Read-only */
>> +	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
>> +		return config->root_only ?
>> +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
>> +
>> +	/* Read-write */
>> +	if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
>> +		return config->root_only ?
>> +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
>> +
>> +	/* Write-only, do not honour request for global writable entry */
>> +	if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
>> +		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
> 
> 
> What is this supposed to be doing, I am totally lost.

I agree, its bit confusing to the reader, but it does work.

But the Idea here is :
We ended up with providing different options like read-only,root-only to 
nvmem providers combined with read/write callbacks.
With that, there are some cases which are totally invalid, existing code 
does very minimal check to ensure that before populating with correct 
attributes to sysfs file. One of such case is with thunderbolt provider 
which supports only write callback.

With this new checks in place these flags and callbacks are correctly 
validated, would result in correct file attributes.


thanks,
srini

> 
> greg k-h
> 
