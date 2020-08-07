Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E23FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F472075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRp6iVZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHGQAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHGQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:00:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE5FC061756;
        Fri,  7 Aug 2020 09:00:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so1197498pfx.13;
        Fri, 07 Aug 2020 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WPQQlSgEdI2Eagwa12liyv9Vg/vXkk+ke4oNOGSYqvM=;
        b=oRp6iVZjiclZ3tQtkyXp+pOlN1Xt/hHOeFJc7zz9kiG+w1RpnlOK1vaCorLa+GVoZc
         yoNdgE0dJewp5BukDmWT3Hfxo4m63LzsEvui5wytU7f4pwJ3eHDSFZUnlD0Tkg/liPLx
         zfH1wHOOWl+B/uDAOAjPbLMMiMhLspqpOrCTtFwHR6eMKdems8TlIHSKkb8Facd24+v6
         N6jNBLtvCWbZVZRE8n3J0hGJfOIiwOdu9IxZCXfFf44yzh5+Pq38F734m8nweOiV++Si
         2nH9M98HdFCDf7m3nkyLgEk8CG0cDfpjqgi4IpDRxojcjEF1o4Lbo/u9UFOcGhwp16GC
         pM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=WPQQlSgEdI2Eagwa12liyv9Vg/vXkk+ke4oNOGSYqvM=;
        b=bU4vYBA9ivWr0FOKhvxsYpGeOEfsd4UcOxnJ26csD15AOUGFQi0tLFKH3TjWCzojR7
         WBwiapoz0gPyJIAIarTL6rik68dCbQ9L7bJbPiOITRV52J8ZJLQoDk75QfCG1MU81Ykl
         K80l4MR8LN07ZA3zxWT2ZGWJgecvV7/OZfJyqlr04gaIPkm/boIHM2714svGxgtAyB6M
         QdBgBqJWrvyl5SYFFZ0m3YsFmdzuB44tTMeKNziihIBemtndToTuEtCvng/IovjUusSo
         +ahF1EkeOI7Xpq+tzRcFP1h/f76k4AyE5fIfF/7OZz2i85tX98nraUboBMxb7Lm4+iZ+
         rbPA==
X-Gm-Message-State: AOAM5331kl66kh79o4QhVeFesl/UpdVvo8pC8RWfXwgl4fAOYoxKo/b9
        SGRo+foilc/7hTBsXVQomxs=
X-Google-Smtp-Source: ABdhPJyUoNuSTCDVUJDJR+Rik5VFMf+3VlxkZ/J+FtOu2z9haZ5pRC6dABxqBugMSo+U3H3LAakcOA==
X-Received: by 2002:a65:6287:: with SMTP id f7mr12493062pgv.307.1596816005684;
        Fri, 07 Aug 2020 09:00:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b15sm10989133pjo.48.2020.08.07.09.00.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 09:00:05 -0700 (PDT)
Date:   Fri, 7 Aug 2020 09:00:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v7 5/9] hwmon: pmbus: adm1266: read blackbox
Message-ID: <20200807160004.GA39964@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:19:24PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Use the nvmem kernel api to expose the black box
> chip functionality to userspace.
> 
> Using this feature, the device is capable of recording
> to nonvolatile flash memory the vital data about the
> system status that caused the system to perform a
> black box write.
> 
> A blackbox is 64 bytes of data containing all the
> status registers, last two states of the sequencer,
> timestamp and counters. The mapping of this data is
> described in the adm1266 datasheet.
> 
> On power-up the driver sets the unix time to
> the adm1266 using the SET_RTC command. This value
> is incremented by an internal clock and it is used
> as timestamp for the black box feature.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/hwmon/pmbus/adm1266.c | 165 ++++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index 0ea016b7e113..b61a968d67f9 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -15,12 +15,19 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/nvmem-provider.h>
>  #include "pmbus.h"
>  #include <linux/slab.h>
> +#include <linux/timekeeping.h>
>  
> +#define ADM1266_BLACKBOX_CONFIG	0xD3
>  #define ADM1266_PDIO_CONFIG	0xD4
>  #define ADM1266_READ_STATE	0xD9
> +#define ADM1266_READ_BLACKBOX	0xDE
> +#define ADM1266_SET_RTC		0xDF
>  #define ADM1266_GPIO_CONFIG	0xE1
> +#define ADM1266_BLACKBOX_INFO	0xE6
>  #define ADM1266_PDIO_STATUS	0xE9
>  #define ADM1266_GPIO_STATUS	0xEA
>  
> @@ -37,6 +44,9 @@
>  #define ADM1266_PDIO_GLITCH_FILT(x)	FIELD_GET(GENMASK(12, 9), x)
>  #define ADM1266_PDIO_OUT_CFG(x)		FIELD_GET(GENMASK(2, 0), x)
>  
> +#define ADM1266_BLACKBOX_OFFSET		0x7F700
> +#define ADM1266_BLACKBOX_SIZE		64
> +
>  #define ADM1266_PMBUS_BLOCK_MAX		255
>  
>  struct adm1266_data {
> @@ -45,11 +55,22 @@ struct adm1266_data {
>  	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
>  	struct i2c_client *client;
>  	struct dentry *debugfs_dir;
> +	struct nvmem_config nvmem_config;
> +	struct nvmem_device *nvmem;
> +	u8 *dev_mem;
>  	struct mutex buf_mutex;
>  	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
>  	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
>  };
>  
> +static const struct nvmem_cell_info adm1266_nvmem_cells[] = {
> +	{
> +		.name           = "blackbox",
> +		.offset         = ADM1266_BLACKBOX_OFFSET,
> +		.bytes          = 2048,
> +	},
> +};
> +
>  DECLARE_CRC8_TABLE(pmbus_crc_table);
>  
>  /*
> @@ -320,6 +341,142 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
>  				    adm1266_state_read);
>  }
>  
> +#if IS_ENABLED(CONFIG_NVMEM)

Other drivers don't make this conditional, and I am not a friend of conditional
code either if it can be avoided.

The nvmem core supports dummy functions if NVMEM is not enabled.
Either this is needed or not. If it is not needed, it should ignore nvmem
registration errors. If it is, and only then, it should return an error.
If it is mandatory, either select or depend on NVMEM in the Kconfig file.

Thanks,
Guenter

> +static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
> +{
> +	int record_count;
> +	char index;
> +	u8 buf[5];
> +	int ret;
> +
> +	ret = i2c_smbus_read_block_data(data->client, ADM1266_BLACKBOX_INFO, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != 4)
> +		return -EIO;
> +
> +	record_count = buf[3];
> +
> +	for (index = 0; index < record_count; index++) {
> +		ret = adm1266_pmbus_block_xfer(data, ADM1266_READ_BLACKBOX, 1, &index, read_buff);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret != ADM1266_BLACKBOX_SIZE)
> +			return -EIO;
> +
> +		read_buff += ADM1266_BLACKBOX_SIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool adm1266_cell_is_accessed(const struct nvmem_cell_info *mem_cell, unsigned int offset,
> +				     size_t bytes)
> +{
> +	unsigned int start_addr = offset;
> +	unsigned int end_addr = offset + bytes;
> +	unsigned int cell_start = mem_cell->offset;
> +	unsigned int cell_end = mem_cell->offset + mem_cell->bytes;
> +
> +	return start_addr <= cell_end && cell_start <= end_addr;
> +}
> +
> +static int adm1266_read_mem_cell(struct adm1266_data *data, const struct nvmem_cell_info *mem_cell)
> +{
> +	u8 *mem_offset;
> +	int ret;
> +
> +	switch (mem_cell->offset) {
> +	case ADM1266_BLACKBOX_OFFSET:
> +		mem_offset = data->dev_mem + mem_cell->offset;
> +
> +		memset(mem_offset, 0, ADM1266_BLACKBOX_SIZE);
> +
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
> +	data->dev_mem = devm_kzalloc(&data->client->dev, data->nvmem_config.size, GFP_KERNEL);
> +	if (!data->dev_mem)
> +		return -ENOMEM;
> +
> +	data->nvmem = devm_nvmem_register(&data->client->dev, &data->nvmem_config);
> +	if (IS_ERR(data->nvmem)) {
> +		dev_err(&data->client->dev, "Could not register nvmem!");
> +		return PTR_ERR(data->nvmem);
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int adm1266_config_nvmem(struct adm1266_data *data)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_NVMEM */
> +
> +static int adm1266_set_rtc(struct adm1266_data *data)
> +{
> +	time64_t kt;
> +	char write_buf[6];
> +	int i;
> +
> +	kt = ktime_get_seconds();
> +
> +	memset(write_buf, 0, sizeof(write_buf));
> +
> +	for (i = 0; i < 4; i++)
> +		write_buf[2 + i] = (kt >> (i * 8)) & 0xFF;
> +
> +	return i2c_smbus_write_block_data(data->client, ADM1266_SET_RTC, sizeof(write_buf),
> +					  write_buf);
> +}
> +
>  static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>  	struct adm1266_data *data;
> @@ -343,6 +500,14 @@ static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = adm1266_set_rtc(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adm1266_config_nvmem(data);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = pmbus_do_probe(client, id, &data->info);
>  	if (ret)
>  		return ret;
