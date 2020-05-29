Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129EAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1499206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxOi735f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgE2Sgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Sg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:36:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3F2C03E969;
        Fri, 29 May 2020 11:36:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y11so1550663plt.12;
        Fri, 29 May 2020 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TBUJzwvxLKIj+N5jawvSsHj59zY5+19woKtlGEvpPC8=;
        b=RxOi735fuE7QuIST48ojRzMwMnLDIJZlVAbJpp5RNYeItQV7IsjO1RlRhBCBKLAFdQ
         PkfXbQgyqfH6mFEhFqHbdleqZCxbfyKMZH58j1K7kCn5DttzfHR0yAKJpkrNTAyqXkkm
         QqlWFDcSEzret+1pw/0N7sQ58aX9RDcWM2IA8ffqAzIJDReBZKH7EROoN8TJ+7GQZ1WX
         OjTHDxewqfU73LogLpBb3/GIyxSk2fk2zWKKRsXhKjglR1LUFJFPQj77qZznub1cjtX+
         mobqXpv0kGEW2L/0Df9GmGXUdaCDCQfZwbXin1hD5C7gZXcG/Z8x0/lF0YT7vMmN7s6T
         maFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TBUJzwvxLKIj+N5jawvSsHj59zY5+19woKtlGEvpPC8=;
        b=hsQO/8NCaNGpSpD6acDZ92Bp7LUajjmb9OyuzGPLxbVqKgaDkyAE8uUYrmoBVxTCoc
         cndtRKO1RhSyF4QXOIXC6ofHPyh/zA3FtyornRMgQAPh0rq68zLHODziFfWZlXZm0HiI
         WtkKOtgZIXAHMhcKtz/XQKU08IX1fubXfDGEDBJNsv60fRD32N6v4XgEqHm3JHcgH4d5
         XyKG72W+gRb0CtwO7dCcJTqXSEFUD9F7peNBo5suRcsECBBeckR9MG6Hbl+OPD9g3wb8
         g77WZv/K2HT5w1AaDI61XyUKa14TgRP1IMPXBxiPutRkiS5ageCbS2XFTgLE9AlNVLVv
         3RCA==
X-Gm-Message-State: AOAM5306Fx0xW5sKB4BCzD/kI9vNd6upzHLLslmsRHXU+zE8bG2Bp3Cc
        yYEjvtCc1X2nmXXuUkAhhMQ=
X-Google-Smtp-Source: ABdhPJweD5gWJvHRFhmr92UwFXq4KxFDnMAHyng4jV1Ksi+EA/E1XNPMlE71OlQEyV2b4z1kMaJmfw==
X-Received: by 2002:a17:902:6906:: with SMTP id j6mr10336825plk.261.1590777388234;
        Fri, 29 May 2020 11:36:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2sm145483pjl.45.2020.05.29.11.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 11:36:27 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] hwmon: pmbus: adm1266: Add support for GPIOs
To:     alexandru.tachici@analog.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20200529130506.73511-1-alexandru.tachici@analog.com>
 <20200529130506.73511-4-alexandru.tachici@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <711bf4ff-f907-6727-c4ad-c8c2270b3bc4@roeck-us.net>
Date:   Fri, 29 May 2020 11:36:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529130506.73511-4-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 6:05 AM, alexandru.tachici@analog.com wrote:
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
> index a7ef048a9a5c..190170300ef1 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -6,7 +6,11 @@
>   * Copyright 2020 Analog Devices Inc.
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/debugfs.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/i2c.h>
> +#include <linux/i2c-smbus.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -14,16 +18,243 @@
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
> +struct adm1266_data {
> +	struct pmbus_driver_info info;
> +	struct gpio_chip gc;
> +	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
> +	struct i2c_client *client;
> +};
> +
> +#if IS_ENABLED(CONFIG_GPIOLIB)

GPIOLIB is bool. IS_ENABLED suggests tristate, which won't happen. Just use #ifdef.

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
> +	u8 read_buf[PMBUS_BLOCK_MAX + 1];

Unnecessarily large. SMBUS_BLOCK_MAX is sufficient here.

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
> +	if (ret < 0)
> +		return ret;
> +
> +	pins_status = read_buf[0] + (read_buf[1] << 8);
> +	if (offset < ADM1266_GPIO_NR)
> +		return test_bit(adm1266_gpio_mapping[offset][1], &pins_status);
> +	else

else after return is unnecessary.

> +		return test_bit(offset - ADM1266_GPIO_NR, &pins_status);
> +}
> +
> +static int adm1266_gpio_get_multiple(struct gpio_chip *chip,
> +				     unsigned long *mask,
> +				     unsigned long *bits)
> +{
> +	struct adm1266_data *data = gpiochip_get_data(chip);
> +	u8 gpio_data[PMBUS_BLOCK_MAX + 1];
> +	u8 pdio_data[PMBUS_BLOCK_MAX + 1];

This is quite some strain on the stack. I would suggest to use only
one buffer and handle gpio completely first, then pdio.

> +	unsigned long gpio_status;
> +	unsigned long pdio_status;
> +	unsigned int gpio_nr;
> +	int ret;
> +
> +	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS,
> +					gpio_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS,
> +					pdio_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	gpio_status = gpio_data[0] + (gpio_data[1] << 8);
> +	pdio_status = pdio_data[0] + (pdio_data[1] << 8);
> +	*bits = 0;
> +	for_each_set_bit(gpio_nr, mask, ADM1266_GPIO_NR) {
> +		if (test_bit(adm1266_gpio_mapping[gpio_nr][1], &gpio_status))
> +			set_bit(gpio_nr, bits);
> +	}
> +
> +	for_each_set_bit_from(gpio_nr, mask,
> +			      ADM1266_GPIO_NR + ADM1266_PDIO_STATUS) {
> +		if (test_bit(gpio_nr - ADM1266_GPIO_NR, &pdio_status))
> +			set_bit(gpio_nr, bits);
> +	}
> +
> +	return 0;
> +}
> +
> +static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
> +{
> +	struct adm1266_data *data = gpiochip_get_data(chip);
> +	u8 write_buf[PMBUS_BLOCK_MAX + 1];

We know how much data we are going to write. Allocating more is a waste.
Given that it is only going to be one byte, you might as well just point
to it directly or use an u8 variable and point to that.

> +	u8 read_buf[PMBUS_BLOCK_MAX + 1];
> +	unsigned long gpio_config;
> +	unsigned long pdio_config;
> +	unsigned long pin_cfg;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ADM1266_GPIO_NR; i++) {
> +		write_buf[0] = adm1266_gpio_mapping[i][1];
> +		ret = pmbus_block_wr(data->client, ADM1266_GPIO_CONFIG, 1,
> +				     write_buf, read_buf);
> +		if (ret < 0)
> +			dev_err(&data->client->dev, "GPIOs scan failed(%d).\n",
> +				ret);
> +
So there was an error ...

> +		gpio_config = read_buf[0];

... and then happily report (random) data anyway ?

Besides, we are having logging noise again, this time on top of
the logging noise in pmbus_block_wr().

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
> +	write_buf[0] = 0xFF;
> +	ret = pmbus_block_wr(data->client, ADM1266_PDIO_CONFIG, 1, write_buf,
> +			     read_buf);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "PDIOs scan failed(%d).\n", ret);
> +

Again: error followed by reporting (non-received) data anyway.
On top of that, 'ret' is not compared against ADM1266_PDIO_NR.
If less data is received than expected, the resulting output
will be random.

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
> +static inline int adm1266_config_gpio(struct adm1266_data *data)

inline is unnecessary. Let the compiler do its job.

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
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +
> +	ret = adm1266_config_gpio(data);
> +	if (ret < 0)
> +		return ret;
>  
> +	info = &data->info;
>  	info->pages = 17;
>  	info->format[PSC_VOLTAGE_OUT] = linear;
>  	funcs = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> 

