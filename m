Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E946CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE08207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNP05xCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404377AbgFXVgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403996AbgFXVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:36:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD30C061573;
        Wed, 24 Jun 2020 14:35:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so1831484pfp.9;
        Wed, 24 Jun 2020 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/S7z+VHkpiSU9UTj23FPiFf5ijzh85CT4lj/9PJvsG8=;
        b=rNP05xChMMIpyiWLadavSpeUvyQpfINtuO1FDvAr1B7xVAtFD5CTillGO6E0umKl9/
         sdJoFgSURmecmLcRhPrDmYBcvJiLBSKgxgtGjA9XJBMsQFEOaWqek+VnTPwbHT+WcgjF
         AgX7HRaTL0D6B8RP0H/4relb4IYoQOpO3Lz+vYlf98AZ0/pztk5vL6jcgtQ+xsoLD2ul
         +/owAn3EbJfFLemk6np0YglNuHyQKsJhlaWzSyUyQTnTBw/4FTODBKNlJIO1eTwHXHt6
         oxv++BmAUD6WapldYond0ZVjMbG9c236wvG5A5umPB0sSFOqMqdAJT5uUwNcXyH5KaiL
         uexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/S7z+VHkpiSU9UTj23FPiFf5ijzh85CT4lj/9PJvsG8=;
        b=syv3L6kkAXrvBpRH/vvFd5nYkYdXilW74kg4ObI89yDcF00guOPhbuSFF2X+aWm3fw
         qGXnTasHuUYMEgVOB9EAAsRR/JJbhhNleIf0hNudI1v+BmdUUJBxFhikE8KH23tzWeOw
         JGKdxIusW3uVjC1bAAlkTGzlbwbb08s+vT9+8gYb1aeup42Jp2rTDLjYVGletOf/Sbm4
         0Xcs2LF/j0L/K4ZPdul5ARP+VOyZbgdDHmbXXydv8pzjPKwXA+IS8/vJzWBRQ5dxQPju
         kRMdjqWzVu5V/IGSljDv1ymcxSNXx9ARk/o7548iiEepaiuT3j4PHtfE1LMEVKHNLxai
         fS+A==
X-Gm-Message-State: AOAM533lNrbu5xcm8Xne5AvTdtnCaP/gSirNMBDHDnBoI7d4n8JwLHos
        dFwtO8kTpjq7N+kRHuJrvnr8zlFL
X-Google-Smtp-Source: ABdhPJya9bEtxAeLDIM7u3nt1FfvxTkshkwGeNY8Vhgo0puwi/ifu6A+sdAsGHL5EAHE5ufVEaoM4g==
X-Received: by 2002:a63:4c48:: with SMTP id m8mr23994264pgl.290.1593034559205;
        Wed, 24 Jun 2020 14:35:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y187sm21274402pfb.46.2020.06.24.14.35.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 14:35:58 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:35:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 3/7] hwmon: pmbus: adm1266: Add support for GPIOs
Message-ID: <20200624213557.GA74535@roeck-us.net>
References: <20200623173659.41358-1-alexandru.tachici@analog.com>
 <20200623173659.41358-4-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623173659.41358-4-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:36:55PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Adm1266 exposes 9 GPIOs and 16 PDIOs which are currently read-only. They
> are controlled by the internal sequencing engine.
> 
> This patch makes adm1266 driver expose GPIOs and PDIOs to user-space
> using GPIO provider kernel api.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/hwmon/pmbus/adm1266.c | 233 +++++++++++++++++++++++++++++++++-
>  1 file changed, 232 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index 381d89a8569f..76bf2c78e737 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -6,8 +6,12 @@
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
> @@ -15,10 +19,35 @@
>  
>  #include "pmbus.h"
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
>  DECLARE_CRC8_TABLE(pmbus_crc_table);
>  
> +struct adm1266_data {
> +	struct pmbus_driver_info info;
> +	struct gpio_chip gc;
> +	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
> +	struct i2c_client *client;
> +};
> +
>  /* Different from Block Read as it sends data and waits for the slave to

Please use standard multi-line comment (yes, I know, part of previous patch).

>   * return a value dependent on that data. The protocol is simply a Write Block
>   * followed by a Read Block without the Read-Block command field and the
> @@ -91,18 +120,220 @@ int pmbus_block_xfer(struct i2c_client *client, u8 cmd, u8 w_len,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_GPIOLIB

It is customary to use "select GPIOLIB" in Kconfig. I would suggest to do
that here as well.

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
> +	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd,
> +					read_buf);

Maximum line length is now 100 columns.

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
> +static int adm1266_gpio_get_multiple(struct gpio_chip *chip,
> +				     unsigned long *mask,
> +				     unsigned long *bits)
> +{
> +	struct adm1266_data *data = gpiochip_get_data(chip);
> +	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1];
> +	unsigned long status;
> +	unsigned int gpio_nr;
> +	int ret;
> +
> +	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS,
> +					read_buf);

Line length again. Applies everywhere.

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
> +	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS,
> +					read_buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	status = read_buf[0] + (read_buf[1] << 8);
> +
> +	*bits = 0;
> +	for_each_set_bit_from(gpio_nr, mask,
> +			      ADM1266_GPIO_NR + ADM1266_PDIO_STATUS) {
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
> +		ret = pmbus_block_xfer(data->client, ADM1266_GPIO_CONFIG, 1,
> +				       &write_cmd, read_buf);
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
> +	ret = pmbus_block_xfer(data->client, ADM1266_PDIO_CONFIG, 1, &write_cmd,
> +			       read_buf);
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
> +		gpio_name = devm_kasprintf(&data->client->dev, GFP_KERNEL,
> +					   "adm1266-%x-%s", data->client->addr,
> +					   adm1266_names[i]);
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
> +		dev_err(&data->client->dev, "GPIO registering failed (%d)\n",
> +			ret);
> +
> +	return ret;
> +}
> +#else
> +static int adm1266_config_gpio(struct adm1266_data *data)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int adm1266_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct pmbus_driver_info *info;
> +	struct adm1266_data *data;
>  	u32 funcs;
> +	int ret;
>  	int i;
>  
> -	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
> +	data = devm_kzalloc(&client->dev, sizeof(struct adm1266_data),
>  			    GFP_KERNEL);

It might be a bit cleaner to create struct adm1266_data in the first patch
of the series, even if it only includes the "info" field. This would reduce
the size of the diffs here, as it would not be necessary to change this
code.

> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +
> +	ret = adm1266_config_gpio(data);
> +	if (ret < 0)
> +		return ret;
>  
>  	crc8_populate_msb(pmbus_crc_table, 0x7);
>  
> +	info = &data->info;
>  	info->pages = 17;
>  	info->format[PSC_VOLTAGE_OUT] = linear;
>  	funcs = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
