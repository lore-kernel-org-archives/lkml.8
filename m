Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43B6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF9A2224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvfVIB+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgHGQF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:05:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD01C061756;
        Fri,  7 Aug 2020 09:05:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so1123838pgq.1;
        Fri, 07 Aug 2020 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9291qivNKpgVEDEE5X2wGA9mdOkciyzW4Rpmz8ZcwM=;
        b=uvfVIB+/KuUNAGP3AxUfi+nXVU/MJHf6qX7E7CWuZEik+pzyXwAcIPCnwE7UdNNCUb
         SM/v9rj6YkQ7ebms2ih66dVolWKXNIds/hiaxV3RDYBoiOj48bftndCnh38m+LFi/44q
         +mJGWYJiwbwd3Wta0PPuiJHLPZ1OeXEMRDNlaBSvcJaT1qffPWtNVoSjjlQhXpYmPXcX
         pxDdSu6DPD+XV0Fzf1mIjCcQsrTq1KM8xMwrZwBePMgwXv9YVMgvaPoIHVTE+nICDImV
         hPfoXj3fqcYqKY2Kl22Fp2oSfecPEZnfhrVA5hnDMWUHglruFLrKqki8sBiX9T2TBM7p
         TqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9291qivNKpgVEDEE5X2wGA9mdOkciyzW4Rpmz8ZcwM=;
        b=R47ixLDsuVtRsbnlSkvLLcTe8AfWhoCVQJfM06RndONVGnbF6wvV3Q/oPQLs5pylsR
         u4IRjX+x4uFFU03XpPAj7nV0gFXbZoLm9ybPnwjEUaeiI4wkuyQWDqn++Pp+WEIiOZy+
         VX+sJt8S0LG6y906/BauClu391ZjCk4EU1v1c/15fH84V3QFDTOHDt9CQTPVXObJfVY5
         lDG5zjd07+sfdzbFeKztpMDE5vfPJ3tncuE81tY1Ce667oe0T8SFW0QM6kkdDp40usUr
         tylVKMXLTNfbiYtoTDAtizWVgp70IZOnKG6U+tWfgVHOp03Tg1jlzBqrSeAsr5GBQh4r
         6AVA==
X-Gm-Message-State: AOAM530o7hfh9mb3XjmQ4n64XSh/Y3YPd31srpiV8dy3KzUAuM2SpUsp
        V94fIecQT/vi95ASNf0zep5e0ybk
X-Google-Smtp-Source: ABdhPJx8NcWrG1hGbAL0Au2ubddILAkB8LGuh3r6W9/dB5B5FlIivQTyXh2v35f/UupBp1R6AwOASw==
X-Received: by 2002:a63:e24d:: with SMTP id y13mr12483175pgj.248.1596816356844;
        Fri, 07 Aug 2020 09:05:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r134sm13526558pfc.1.2020.08.07.09.05.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 09:05:56 -0700 (PDT)
Date:   Fri, 7 Aug 2020 09:05:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v7 3/9] hwmon: pmbus: adm1266: Add support for GPIOs
Message-ID: <20200807160554.GA40857@roeck-us.net>
References: <20200727161928.14122-1-alexandru.tachici@analog.com>
 <20200727161928.14122-4-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727161928.14122-4-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:19:22PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Adm1266 exposes 9 GPIOs and 16 PDIOs which are currently read-only. They
> are controlled by the internal sequencing engine.
> 
> This patch makes adm1266 driver expose GPIOs and PDIOs to user-space
> using GPIO provider kernel api.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

This needs to add "select GPIOLIB" to the driver's Kconfig entry.

> ---
>  drivers/hwmon/pmbus/adm1266.c | 204 ++++++++++++++++++++++++++++++++++
>  1 file changed, 204 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index 63975eba34ad..be911de02cf6 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -6,18 +6,42 @@
>   * Copyright 2020 Analog Devices Inc.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/crc8.h>
> +#include <linux/debugfs.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/i2c.h>
> +#include <linux/i2c-smbus.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include "pmbus.h"
>  #include <linux/slab.h>
>  
> +#define ADM1266_PDIO_CONFIG	0xD4
> +#define ADM1266_GPIO_CONFIG	0xE1
> +#define ADM1266_PDIO_STATUS	0xE9
> +#define ADM1266_GPIO_STATUS	0xEA
> +
> +/* ADM1266 GPIO defines */
> +#define ADM1266_GPIO_NR			9
> +#define ADM1266_GPIO_FUNCTIONS(x)	FIELD_GET(BIT(0), x)
> +#define ADM1266_GPIO_INPUT_EN(x)	FIELD_GET(BIT(2), x)
> +#define ADM1266_GPIO_OUTPUT_EN(x)	FIELD_GET(BIT(3), x)
> +#define ADM1266_GPIO_OPEN_DRAIN(x)	FIELD_GET(BIT(4), x)
> +
> +/* ADM1266 PDIO defines */
> +#define ADM1266_PDIO_NR			16
> +#define ADM1266_PDIO_PIN_CFG(x)		FIELD_GET(GENMASK(15, 13), x)
> +#define ADM1266_PDIO_GLITCH_FILT(x)	FIELD_GET(GENMASK(12, 9), x)
> +#define ADM1266_PDIO_OUT_CFG(x)		FIELD_GET(GENMASK(2, 0), x)
> +
>  #define ADM1266_PMBUS_BLOCK_MAX		255
>  
>  struct adm1266_data {
>  	struct pmbus_driver_info info;
> +	struct gpio_chip gc;
> +	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
>  	struct i2c_client *client;
>  	struct mutex buf_mutex;
>  	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
> @@ -88,9 +112,185 @@ static int adm1266_pmbus_block_xfer(struct adm1266_data *data, u8 cmd, u8 w_len,
>  	return ret;
>  }
>  
> +static const unsigned int adm1266_gpio_mapping[ADM1266_GPIO_NR][2] = {
> +	{1, 0},
> +	{2, 1},
> +	{3, 2},
> +	{4, 8},
> +	{5, 9},
> +	{6, 10},
> +	{7, 11},
> +	{8, 6},
> +	{9, 7},
> +};
> +
> +static const char *adm1266_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR] = {
> +	"GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6", "GPIO7", "GPIO8",
> +	"GPIO9", "PDIO1", "PDIO2", "PDIO3", "PDIO4", "PDIO5", "PDIO6",
> +	"PDIO7", "PDIO8", "PDIO9", "PDIO10", "PDIO11", "PDIO12", "PDIO13",
> +	"PDIO14", "PDIO15", "PDIO16",
> +};
> +
> +static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct adm1266_data *data = gpiochip_get_data(chip);
> +	u8 read_buf[I2C_SMBUS_BLOCK_MAX + 1];
> +	unsigned long pins_status;
> +	unsigned int pmbus_cmd;
> +	int ret;
> +
> +	if (offset < ADM1266_GPIO_NR)
> +		pmbus_cmd = ADM1266_GPIO_STATUS;
> +	else
> +		pmbus_cmd = ADM1266_PDIO_STATUS;
> +
> +	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	pins_status = read_buf[0] + (read_buf[1] << 8);
> +	if (offset < ADM1266_GPIO_NR)
> +		return test_bit(adm1266_gpio_mapping[offset][1], &pins_status);
> +
> +	return test_bit(offset - ADM1266_GPIO_NR, &pins_status);
> +}
> +
> +static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
> +				     unsigned long *bits)
> +{
> +	struct adm1266_data *data = gpiochip_get_data(chip);
> +	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1];
> +	unsigned long status;
> +	unsigned int gpio_nr;
> +	int ret;
> +
> +	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	status = read_buf[0] + (read_buf[1] << 8);
> +
> +	*bits = 0;
> +	for_each_set_bit(gpio_nr, mask, ADM1266_GPIO_NR) {
> +		if (test_bit(adm1266_gpio_mapping[gpio_nr][1], &status))
> +			set_bit(gpio_nr, bits);
> +	}
> +
> +	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS, read_buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	status = read_buf[0] + (read_buf[1] << 8);
> +
> +	*bits = 0;
> +	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_STATUS) {
> +		if (test_bit(gpio_nr - ADM1266_GPIO_NR, &status))
> +			set_bit(gpio_nr, bits);
> +	}
> +
> +	return 0;
> +}
> +
> +static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
> +{
> +	struct adm1266_data *data = gpiochip_get_data(chip);
> +	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1];
> +	unsigned long gpio_config;
> +	unsigned long pdio_config;
> +	unsigned long pin_cfg;
> +	u8 write_cmd;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ADM1266_GPIO_NR; i++) {
> +		write_cmd = adm1266_gpio_mapping[i][1];
> +		ret = adm1266_pmbus_block_xfer(data, ADM1266_GPIO_CONFIG, 1, &write_cmd, read_buf);
> +		if (ret != 2)
> +			return;
> +
> +		gpio_config = read_buf[0];
> +		seq_puts(s, adm1266_names[i]);
> +
> +		seq_puts(s, " ( ");
> +		if (!ADM1266_GPIO_FUNCTIONS(gpio_config)) {
> +			seq_puts(s, "high-Z )\n");
> +			continue;
> +		}
> +		if (ADM1266_GPIO_INPUT_EN(gpio_config))
> +			seq_puts(s, "input ");
> +		if (ADM1266_GPIO_OUTPUT_EN(gpio_config))
> +			seq_puts(s, "output ");
> +		if (ADM1266_GPIO_OPEN_DRAIN(gpio_config))
> +			seq_puts(s, "open-drain )\n");
> +		else
> +			seq_puts(s, "push-pull )\n");
> +	}
> +
> +	write_cmd = 0xFF;
> +	ret = adm1266_pmbus_block_xfer(data, ADM1266_PDIO_CONFIG, 1, &write_cmd, read_buf);
> +	if (ret != 32)
> +		return;
> +
> +	for (i = 0; i < ADM1266_PDIO_NR; i++) {
> +		seq_puts(s, adm1266_names[ADM1266_GPIO_NR + i]);
> +
> +		pdio_config = read_buf[2 * i];
> +		pdio_config += (read_buf[2 * i + 1] << 8);
> +		pin_cfg = ADM1266_PDIO_PIN_CFG(pdio_config);
> +
> +		seq_puts(s, " ( ");
> +		if (!pin_cfg || pin_cfg > 5) {
> +			seq_puts(s, "high-Z )\n");
> +			continue;
> +		}
> +
> +		if (pin_cfg & BIT(0))
> +			seq_puts(s, "output ");
> +
> +		if (pin_cfg & BIT(1))
> +			seq_puts(s, "input ");
> +
> +		seq_puts(s, ")\n");
> +	}
> +}
> +
> +static int adm1266_config_gpio(struct adm1266_data *data)
> +{
> +	const char *name = dev_name(&data->client->dev);
> +	char *gpio_name;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(data->gpio_names); i++) {
> +		gpio_name = devm_kasprintf(&data->client->dev, GFP_KERNEL, "adm1266-%x-%s",
> +					   data->client->addr, adm1266_names[i]);
> +		if (!gpio_name)
> +			return -ENOMEM;
> +
> +		data->gpio_names[i] = gpio_name;
> +	}
> +
> +	data->gc.label = name;
> +	data->gc.parent = &data->client->dev;
> +	data->gc.owner = THIS_MODULE;
> +	data->gc.base = -1;
> +	data->gc.names = data->gpio_names;
> +	data->gc.ngpio = ARRAY_SIZE(data->gpio_names);
> +	data->gc.get = adm1266_gpio_get;
> +	data->gc.get_multiple = adm1266_gpio_get_multiple;
> +	data->gc.dbg_show = adm1266_gpio_dbg_show;
> +
> +	ret = devm_gpiochip_add_data(&data->client->dev, &data->gc, data);
> +	if (ret)
> +		dev_err(&data->client->dev, "GPIO registering failed (%d)\n", ret);
> +
> +	return ret;
> +}
> +
>  static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>  	struct adm1266_data *data;
> +	int ret;
>  	int i;
>  
>  	data = devm_kzalloc(&client->dev, sizeof(struct adm1266_data), GFP_KERNEL);
> @@ -106,6 +306,10 @@ static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *
>  	crc8_populate_msb(pmbus_crc_table, 0x7);
>  	mutex_init(&data->buf_mutex);
>  
> +	ret = adm1266_config_gpio(data);
> +	if (ret < 0)
> +		return ret;
> +
>  	return pmbus_do_probe(client, id, &data->info);
>  }
>  
