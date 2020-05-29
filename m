Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233FBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6EB3207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0fGZRDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgE2SpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2SpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:45:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37CC03E969;
        Fri, 29 May 2020 11:45:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so315799pgv.8;
        Fri, 29 May 2020 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GxvhoaJ6/3DBa0iXuuNwBlmKU+YBFnrhHrRCI50bhKI=;
        b=U0fGZRDqhIxpb6n6bF3wCBPHwCI2RFKBy7m1bu7Vpw6C43I9vkbG9Pvwj/8YKWg0Qh
         tYemPGrBH506Haim9HDL95m2Wec/yWO3ufJj/C7pJn7+jrxI2/dc0dxbkJ9UditP6pk0
         VkHK0S7rM6MdCXvuAtvT2gqjC4RArW4p5S2cfY1QRE+JL9fp8rwBBDwSuuhtMR4Cvkr8
         iCVZxWYWfK4+vRbqtexsWq8cmIzcc5ifuihs00/HEAbGoBh8J7kuIG8EpqqPATlLLg7I
         r8Tufd7XY2HrOpMCKXTQTUxHN1x5QQ5JU4Myp0s/34uFC5FC0zupIIE77W9y0bdyfeLs
         jp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GxvhoaJ6/3DBa0iXuuNwBlmKU+YBFnrhHrRCI50bhKI=;
        b=HsOhzfZimgXDkEDpzgmZzoao7gRN41bwaMFEzUm4syTmVd/vHYgAaYOkgr2991+Gin
         YVI3zl3ug5VsVvnjelURupS2tsVfa4QjJjWm1BSi8X8cGmbcVgNkIxQFC0VhhF1kDodh
         j1YD9r4vtwBIem84pB4imHE8H6gaYsObFqj3CvMOcVHWketXfnpI6mLGMk+Wguesc76V
         Z9vx64F1uzU9TwdndBljHAUu8hFT181nkqbp1bZcHsMfzIZvyOl8SL96oBalJHeis0VK
         8ifDLgwcsKZdZkjebLbi7LcZR+GRcab1P+uIWjBMZCmfFYdkrp1iDkafXpbpxJDtmlSl
         j3Jw==
X-Gm-Message-State: AOAM532Z7d6IwbarasbfvFOUVikqUNm7NjloJCWdSSJvrX98/HSN2jIF
        I5jK9EH35s8/5w4bTt7/lLkO4LTZ
X-Google-Smtp-Source: ABdhPJyhnxd0muKu4wgiNp1MSmgOmKkGQ8z7O7hyTYFtM19FiI9B/WNi67AefVkUClaqdll5lnV+ig==
X-Received: by 2002:a63:da0e:: with SMTP id c14mr9365088pgh.377.1590777909749;
        Fri, 29 May 2020 11:45:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i22sm4946686pfo.92.2020.05.29.11.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 11:45:09 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] hwmon: pmbus: adm1266: read blackbox
To:     alexandru.tachici@analog.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20200529130506.73511-1-alexandru.tachici@analog.com>
 <20200529130506.73511-6-alexandru.tachici@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <80800d67-85ae-d6f1-b400-c230296e1eaf@roeck-us.net>
Date:   Fri, 29 May 2020 11:45:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529130506.73511-6-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 6:05 AM, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Use the nvmem kernel api to expose the black box
> chip functionality to userspace.
> 

This needs to be split into two functions: Add nvmem support, add
debugfs file.

Guenter

> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/hwmon/pmbus/adm1266.c | 160 ++++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index 85d6795b79d3..831156004087 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -14,14 +14,19 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/nvmem-provider.h>
>  #include <linux/slab.h>
>  
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
> @@ -38,12 +43,26 @@
>  #define ADM1266_PDIO_GLITCH_FILT(x)	FIELD_GET(GENMASK(12, 9), x)
>  #define ADM1266_PDIO_OUT_CFG(x)		FIELD_GET(GENMASK(2, 0), x)
>  
> +#define ADM1266_BLACKBOX_OFFSET		0x7F700
> +#define ADM1266_BLACKBOX_SIZE		64
> +
>  struct adm1266_data {
>  	struct pmbus_driver_info info;
>  	struct gpio_chip gc;
>  	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
>  	struct i2c_client *client;
>  	struct dentry *debugfs_dir;
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
>  #if IS_ENABLED(CONFIG_GPIOLIB)
> @@ -261,6 +280,28 @@ static int adm1266_set_go_command_op(void *pdata, u64 val)
>  	return i2c_smbus_write_word_data(data->client, ADM1266_GO_COMMAND, reg);
>  }
>  
> +static int adm1266_blackbox_information_read(struct seq_file *s, void *pdata)
> +{
> +	struct device *dev = s->private;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	u8 read_buf[PMBUS_BLOCK_MAX + 1];
> +	unsigned int latest_id;
> +	int ret;
> +
> +	ret = i2c_smbus_read_block_data(client, ADM1266_BLACKBOX_INFO,
> +					read_buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	seq_puts(s, "BLACKBOX_INFORMATION:\n");
> +	latest_id = read_buf[0] + (read_buf[1] << 8);
> +	seq_printf(s, "Black box ID: %x\n", latest_id);
> +	seq_printf(s, "Logic index: %x\n", read_buf[2]);
> +	seq_printf(s, "Record count: %x\n", read_buf[3]);
> +
> +	return 0;
> +}
> +
>  DEFINE_DEBUGFS_ATTRIBUTE(go_command_fops, NULL, adm1266_set_go_command_op,
>  			 "%llu\n");
>  DEFINE_DEBUGFS_ATTRIBUTE(read_state_fops, adm1266_get_state_op, NULL, "%llu\n");
> @@ -277,6 +318,121 @@ static void adm1266_debug_init(struct adm1266_data *data)
>  				   &go_command_fops);
>  	debugfs_create_file_unsafe("read_state", 0400, root, data,
>  				   &read_state_fops);
> +	debugfs_create_devm_seqfile(&data->client->dev, "blackbox_information",
> +				    root, adm1266_blackbox_information_read);
> +}
> +
> +static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *buf)
> +{
> +	u8 write_buf[PMBUS_BLOCK_MAX + 1];
> +	u8 read_buf[PMBUS_BLOCK_MAX + 1];
> +	int record_count;
> +	int ret;
> +	int i;
> +
> +	ret = i2c_smbus_read_block_data(data->client, ADM1266_BLACKBOX_INFO,
> +					read_buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	record_count = read_buf[3];
> +
> +	for (i = 0; i < record_count; i++) {
> +		write_buf[0] = i;
> +		ret = pmbus_block_wr(data->client, ADM1266_READ_BLACKBOX, 1,
> +				     write_buf, buf);
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
> +	if (IS_ERR(data->nvmem)) {
> +		dev_err(&data->client->dev, "Could not register nvmem!");
> +		return PTR_ERR(data->nvmem);
> +	}
> +
> +	data->dev_mem = devm_kzalloc(&data->client->dev,
> +				     data->nvmem_config.size,
> +				     GFP_KERNEL);
> +	if (!data->dev_mem)
> +		return -ENOMEM;
> +
> +	return 0;
>  }
>  
>  static int adm1266_probe(struct i2c_client *client,
> @@ -299,6 +455,10 @@ static int adm1266_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = adm1266_config_nvmem(data);
> +	if (ret < 0)
> +		return ret;
> +
>  	adm1266_debug_init(data);
>  
>  	info = &data->info;
> 

