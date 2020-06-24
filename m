Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D988C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A602081A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaZwWkWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405263AbgFXVvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405108AbgFXVvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:51:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5379EC061573;
        Wed, 24 Jun 2020 14:51:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s14so1686333plq.6;
        Wed, 24 Jun 2020 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L0MzlFLwm6T2ZxR+P/092PF/9NwClVuMD9gddMae/SQ=;
        b=EaZwWkWVfQYzJ8DhhQqvOX60x3+zTLOLDFVWN0oa1HjqF91L+WFmdSQ5vVWpFBFKd/
         U7Pp/WsgMf3kNYd62hCgTevHC9T2dYnAg/fW6OmFobKh0qxqkbpTaN63AeTjzwW6qHjM
         l0p6ypxbwNHJqTNhQyk4JlA7AMQMpnge9KScWaH2sH1dI+OclrV4eVRLD8uFsPZLvSJ9
         VfGNguFiqMEIGIYahLkXyq+yyy+sC4TvGrqJOn95lyCWBsbecNz1vJ+dGEvBzbSoxCbt
         tVCIpqYXc28hhR3OYnvOBQeu9PC62ga7DuKGwiGWCU/EKXBrSHsxYe8Zhhqb2uVmY36m
         BlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L0MzlFLwm6T2ZxR+P/092PF/9NwClVuMD9gddMae/SQ=;
        b=BsIOPs1K7ASLUdMddGCE06nIwLkTEwQlII45Z7H9KxddipfasBRN5GPTLwXpQiM5Gu
         PrqnYDkZ4nEPeW2akvuz+hfAXfWGeli3sRlTfNFA72MfMjozjNnpcc9luysCGiOFLUgQ
         VKa/NwDnFfIqaKMRZ+x6C2opzMXgKeXGd0I9gqKkSl2RUc6WixJd/QIOaRiQ4qUR85Fq
         61nbk8vjexuYdl7KvGpyUw8yJvJq/H6WyWPOo7Lfa2Jvv1XpPGfrihnHtg9Rs/PrKpOJ
         iS0KLyVi7s4/zHzDZ+9dAvKBf9bpccFl7XnNXjvn0VFyaWP0ZLUC+6peJ1xPoLqsj8n/
         cuUw==
X-Gm-Message-State: AOAM531bv3IZtLTUszzH4sjGdk6vqin27NEe1OLhbW9ktFdTJRuy0f3y
        FZnnUHXP2JR11TGEHW1zQ9o=
X-Google-Smtp-Source: ABdhPJw4GbQBZUNNPrxn7l9wL0I0uE+rrTzzLrxhnlUfRAtZykbjASDS6qI98okoEuSSidiRwkeLRg==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6mr29427251plb.329.1593035473819;
        Wed, 24 Jun 2020 14:51:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm6371191pjl.34.2020.06.24.14.51.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 14:51:13 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:51:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 5/7] hwmon: pmbus: adm1266: read blackbox
Message-ID: <20200624215112.GA75386@roeck-us.net>
References: <20200623173659.41358-1-alexandru.tachici@analog.com>
 <20200623173659.41358-6-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623173659.41358-6-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:36:57PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Use the nvmem kernel api to expose the black box
> chip functionality to userspace.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/hwmon/pmbus/adm1266.c | 134 ++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index 0960ead8d96a..b9e92ab1e39a 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -15,6 +15,8 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/nvmem-provider.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> @@ -22,10 +24,13 @@
>  #include <linux/adm1266.h>
>  #include "pmbus.h"
>  
> +#define ADM1266_BLACKBOX_CONFIG	0xD3
>  #define ADM1266_PDIO_CONFIG	0xD4
>  #define ADM1266_GO_COMMAND	0xD8
>  #define ADM1266_READ_STATE	0xD9
> +#define ADM1266_READ_BLACKBOX	0xDE
>  #define ADM1266_GPIO_CONFIG	0xE1
> +#define ADM1266_BLACKBOX_INFO	0xE6
>  #define ADM1266_PDIO_STATUS	0xE9
>  #define ADM1266_GPIO_STATUS	0xEA
>  
> @@ -42,6 +47,9 @@
>  #define ADM1266_PDIO_GLITCH_FILT(x)	FIELD_GET(GENMASK(12, 9), x)
>  #define ADM1266_PDIO_OUT_CFG(x)		FIELD_GET(GENMASK(2, 0), x)
>  
> +#define ADM1266_BLACKBOX_OFFSET		0x7F700
> +#define ADM1266_BLACKBOX_SIZE		64
> +
>  #define ADM1266_PMBUS_BLOCK_MAX		255
>  
>  DECLARE_CRC8_TABLE(pmbus_crc_table);
> @@ -52,6 +60,17 @@ struct adm1266_data {
>  	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
>  	struct i2c_client *client;
>  	struct mutex ioctl_mutex; /* lock ioctl access */
> +	struct nvmem_config nvmem_config;
> +	struct nvmem_device *nvmem;
> +	u8 *dev_mem;
> +};
> +
> +static const struct nvmem_cell_info adm1266_nvmem_cells[] = {
> +	{
> +		.name           = "blackbox",
> +		.offset         = ADM1266_BLACKBOX_OFFSET,
> +		.bytes          = 2048,
> +	},
>  };
>  
>  /* Different from Block Read as it sends data and waits for the slave to
> @@ -404,6 +423,117 @@ static int adm1266_init_procfs(struct adm1266_data *data)
>  	return 0;
>  }
>  
> +static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *buf)
> +{
> +	u8 read_buf[5];
> +	char index;
> +	int record_count;
> +	int ret;
> +
> +	ret = i2c_smbus_read_block_data(data->client, ADM1266_BLACKBOX_INFO,
> +					read_buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	record_count = read_buf[3];
> +
> +	for (index = 0; index < record_count; index++) {
> +		ret = pmbus_block_xfer(data->client, ADM1266_READ_BLACKBOX, 1,
> +				       &index, buf);
> +		if (ret < 0)
> +			return ret;
> +
> +		buf += ADM1266_BLACKBOX_SIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool adm1266_cell_is_accessed(const struct nvmem_cell_info *mem_cell,
> +				     unsigned int offset, size_t bytes)
> +{
> +	unsigned int start_addr = offset;
> +	unsigned int end_addr = offset + bytes;
> +	unsigned int cell_start = mem_cell->offset;
> +	unsigned int cell_end = mem_cell->offset + mem_cell->bytes;
> +
> +	if (start_addr <= cell_end && cell_start <= end_addr)
> +		return true;
> +
> +	return false;

	return start_addr <= cell_end && cell_start <= end_add;

does the same.

> +}
> +
> +static int adm1266_read_mem_cell(struct adm1266_data *data,
> +				 const struct nvmem_cell_info *mem_cell)
> +{
> +	u8 *mem_offset;
> +	int ret;
> +
> +	switch (mem_cell->offset) {
> +	case ADM1266_BLACKBOX_OFFSET:

How would this ever have a different value ?

> +		mem_offset = data->dev_mem + mem_cell->offset;
> +		ret = adm1266_nvmem_read_blackbox(data, mem_offset);
> +		if (ret)
> +			dev_err(&data->client->dev, "Could not read blackbox!");
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adm1266_nvmem_read(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)
> +{
> +	const struct nvmem_cell_info *mem_cell;
> +	struct adm1266_data *data = priv;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < data->nvmem_config.ncells; i++) {
> +		mem_cell = &adm1266_nvmem_cells[i];
> +		if (!adm1266_cell_is_accessed(mem_cell, offset, bytes))
> +			continue;
> +
> +		ret = adm1266_read_mem_cell(data, mem_cell);
> +		if (ret < 0)
> +			return ret;
> +	}

I am a bit puzzled about the complexity of this code.
Is there reason to believe that there will ever be more than one cell ?
If that is not the case, I don't see the value in the complexity.
If there is a plan to add more nvram cells later, it should be
mentioned somewhere. As it is, the code is difficult to understand,
and I really only want to spend time analyzing it if it is really
necessary.

> +
> +	memcpy(val, data->dev_mem + offset, bytes);
> +
> +	return 0;
> +}
> +
> +static int adm1266_config_nvmem(struct adm1266_data *data)
> +{
> +	data->nvmem_config.name = dev_name(&data->client->dev);
> +	data->nvmem_config.dev = &data->client->dev;
> +	data->nvmem_config.root_only = true;
> +	data->nvmem_config.read_only = true;
> +	data->nvmem_config.owner = THIS_MODULE;
> +	data->nvmem_config.reg_read = adm1266_nvmem_read;
> +	data->nvmem_config.cells = adm1266_nvmem_cells;
> +	data->nvmem_config.ncells = ARRAY_SIZE(adm1266_nvmem_cells);
> +	data->nvmem_config.priv = data;
> +	data->nvmem_config.stride = 1;
> +	data->nvmem_config.word_size = 1;
> +	data->nvmem_config.size = 0x80000;
> +
> +	data->nvmem = nvmem_register(&data->nvmem_config);

If CONFIG_NVMEM is not enabled, this function will return -EOPNOTSUPP,
and the driver will fail to load. I don't think that is acceptable.

Also, this should really use devm_nvmem_register().

> +	if (IS_ERR(data->nvmem)) {
> +		dev_err(&data->client->dev, "Could not register nvmem!");
> +		return PTR_ERR(data->nvmem);
> +	}
> +
> +	data->dev_mem = devm_kzalloc(&data->client->dev,
> +				     data->nvmem_config.size,
> +				     GFP_KERNEL);

This is at least potentially racy. Presumably nvram can be accessed right
after the call to nvmem_register(). If that happens, dev_mem is not yet
set, and the system will crash.

> +	if (!data->dev_mem)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static int adm1266_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -430,6 +560,10 @@ static int adm1266_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = adm1266_config_nvmem(data);
> +	if (ret < 0)
> +		return ret;
> +
>  	info = &data->info;
>  	info->pages = 17;
>  	info->format[PSC_VOLTAGE_OUT] = linear;
