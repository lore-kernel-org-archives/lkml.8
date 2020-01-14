Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB0FC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2012467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srdw0Lwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgANONJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:13:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46095 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:13:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so6434379pgb.13;
        Tue, 14 Jan 2020 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gz2Q5JzFGkNu1hervo2lbpap8sHfT1IZZnHTluOTPP4=;
        b=Srdw0Lwx6gYAew51PYarCpEWgAzkkMR3zQVhVVIB4eR/BbkOYDELIi1RObiMLkpuBT
         /FhFNwrNhobQf1aY2cVoLmdXZrT9uV4nV4ULK96MsroEzxJPEGod6MaBJqcv6imuZpJQ
         1OQkwoKiJvKsOd1yqdOuKlqbHciRruyH6xhoVWp3fAka/FGMq79vwSA+sBc0CtwnPfMZ
         r4/Ahf/PuZTT2rp+/8d01+4BRwNEgWLDkzJK77nJ4/tLvURvxzKsXZwcuKLsU+uZL4ol
         7CC0a5bx4B9i1yR08AQoR3Y9nie3sFFrJdXebOAgaXeOanxxEx10wKIxFBXC1P+tZAt2
         7aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gz2Q5JzFGkNu1hervo2lbpap8sHfT1IZZnHTluOTPP4=;
        b=Cf1j1v7n7raDDeIPabOXpRp9QfzXDN+X0oKeqn/3MEgKDr9F1pjCJizMZ9NwNFhFF6
         +3pXQuCVd9CQB+pQPGStfkb5tPRvVgSYLo//uUhMqHr+e+xZpecPWxU/YEogp7FIgwOo
         83ksVjLeHna86vFrCmvsLO1UrLnHgCJJ3I8jhOsMs2UQ8s2WlhPwgbJKFcWVKGP3mytX
         UVpPvpg3vqDPcG83T8TLCCVyOGskUgiVOQoQzsm7HIQYVT//nuW44ulZFv9tuHRFzuQ9
         GUdzbC0j5RGCzYoS0Snvs0hFiXJM7vQmq08jiovvhwx61hbKgWaTj6uzi0SPHoVWa903
         TOSw==
X-Gm-Message-State: APjAAAXFw9g7sKhGb5bR6C7GpCVZT4/esVOd3bvjoL3okte4UD0rAhKF
        k2HnFdKa5R8Fv1tfst/hST8=
X-Google-Smtp-Source: APXvYqw3kLMVP0iAnASzWaYC67aA3lka/yXyu52dlrxPinckKw3L26g6ERIDclukl1Odz//HVj/UmA==
X-Received: by 2002:a62:a515:: with SMTP id v21mr25760023pfm.128.1579011187652;
        Tue, 14 Jan 2020 06:13:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u18sm17625542pgn.9.2020.01.14.06.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 06:13:07 -0800 (PST)
Date:   Tue, 14 Jan 2020 06:13:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     linux-hwmon@vger.kernel.org, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, biabeniamin@outlook.com
Subject: Re: [PATCH v4 1/3] hwmon: (adm1177) Add ADM1177 Hot Swap Controller
 and Digital Power Monitor driver
Message-ID: <20200114141306.GA11752@roeck-us.net>
References: <20200114112159.25998-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114112159.25998-1-beniamin.bia@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 01:21:57PM +0200, Beniamin Bia wrote:
> ADM1177 is a Hot Swap Controller and Digital Power Monitor with
> Soft Start Pin.
> 
> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

> ---
> Changes in v4:
> -reverse condition in adm1177_write_alert_thr fixed
> 
>  Documentation/hwmon/adm1177.rst |  36 ++++
>  Documentation/hwmon/index.rst   |   1 +
>  drivers/hwmon/Kconfig           |  10 ++
>  drivers/hwmon/Makefile          |   1 +
>  drivers/hwmon/adm1177.c         | 288 ++++++++++++++++++++++++++++++++
>  5 files changed, 336 insertions(+)
>  create mode 100644 Documentation/hwmon/adm1177.rst
>  create mode 100644 drivers/hwmon/adm1177.c
> 
> diff --git a/Documentation/hwmon/adm1177.rst b/Documentation/hwmon/adm1177.rst
> new file mode 100644
> index 000000000000..c81e0b4abd28
> --- /dev/null
> +++ b/Documentation/hwmon/adm1177.rst
> @@ -0,0 +1,36 @@
> +Kernel driver adm1177
> +=====================
> +
> +Supported chips:
> +  * Analog Devices ADM1177
> +    Prefix: 'adm1177'
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> +
> +Author: Beniamin Bia <beniamin.bia@analog.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for Analog Devices ADM1177
> +Hot-Swap Controller and Digital Power Monitors with Soft Start Pin.
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices for
> +details.
> +
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported. Current maxim attribute
> +is read-write, all other attributes are read-only.
> +
> +in0_input		Measured voltage in microvolts.
> +
> +curr1_input		Measured current in microamperes.
> +curr1_max_alarm		Overcurrent alarm in microamperes.
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 682ef4dda89c..cc7000593a73 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -29,6 +29,7 @@ Hardware Monitoring Kernel Drivers
>     adm1025
>     adm1026
>     adm1031
> +   adm1177
>     adm1275
>     adm9240
>     ads7828
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 7ea61648ad16..47ac20aee06f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -164,6 +164,16 @@ config SENSORS_ADM1031
>  	  This driver can also be built as a module. If so, the module
>  	  will be called adm1031.
>  
> +config SENSORS_ADM1177
> +	tristate "Analog Devices ADM1177 and compatibles"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Analog Devices ADM1177
> +	  sensor chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called adm1177.
> +
>  config SENSORS_ADM9240
>  	tristate "Analog Devices ADM9240 and compatibles"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index f0f514f9cf24..613f50987965 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
>  obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
>  obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
>  obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
> +obj-$(CONFIG_SENSORS_ADM1177)	+= adm1177.o
>  obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
>  obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
>  obj-$(CONFIG_SENSORS_ADS7871)	+= ads7871.o
> diff --git a/drivers/hwmon/adm1177.c b/drivers/hwmon/adm1177.c
> new file mode 100644
> index 000000000000..d314223a404a
> --- /dev/null
> +++ b/drivers/hwmon/adm1177.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADM1177 Hot Swap Controller and Digital Power Monitor with Soft Start Pin
> + *
> + * Copyright 2015-2019 Analog Devices Inc.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +
> +/*  Command Byte Operations */
> +#define ADM1177_CMD_V_CONT	BIT(0)
> +#define ADM1177_CMD_I_CONT	BIT(2)
> +#define ADM1177_CMD_VRANGE	BIT(4)
> +
> +/* Extended Register */
> +#define ADM1177_REG_ALERT_TH	2
> +
> +#define ADM1177_BITS		12
> +
> +/**
> + * struct adm1177_state - driver instance specific data
> + * @client		pointer to i2c client
> + * @reg			regulator info for the the power supply of the device
> + * @r_sense_uohm	current sense resistor value
> + * @alert_threshold_ua	current limit for shutdown
> + * @vrange_high		internal voltage divider
> + */
> +struct adm1177_state {
> +	struct i2c_client	*client;
> +	struct regulator	*reg;
> +	u32			r_sense_uohm;
> +	u32			alert_threshold_ua;
> +	bool			vrange_high;
> +};
> +
> +static int adm1177_read_raw(struct adm1177_state *st, u8 num, u8 *data)
> +{
> +	return i2c_master_recv(st->client, data, num);
> +}
> +
> +static int adm1177_write_cmd(struct adm1177_state *st, u8 cmd)
> +{
> +	return i2c_smbus_write_byte(st->client, cmd);
> +}
> +
> +static int adm1177_write_alert_thr(struct adm1177_state *st,
> +				   u32 alert_threshold_ua)
> +{
> +	u64 val;
> +	int ret;
> +
> +	val = 0xFFULL * alert_threshold_ua * st->r_sense_uohm;
> +	val = div_u64(val, 105840000U);
> +	val = div_u64(val, 1000U);
> +	if (val > 0xFF)
> +		val = 0xFF;
> +
> +	ret = i2c_smbus_write_byte_data(st->client, ADM1177_REG_ALERT_TH,
> +					val);
> +	if (ret)
> +		return ret;
> +
> +	st->alert_threshold_ua = alert_threshold_ua;
> +	return 0;
> +}
> +
> +static int adm1177_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct adm1177_state *st = dev_get_drvdata(dev);
> +	u8 data[3];
> +	long dummy;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			ret = adm1177_read_raw(st, 3, data);
> +			if (ret < 0)
> +				return ret;
> +			dummy = (data[1] << 4) | (data[2] & 0xF);
> +			/*
> +			 * convert to milliamperes
> +			 * ((105.84mV / 4096) x raw) / senseResistor(ohm)
> +			 */
> +			*val = div_u64((105840000ull * dummy),
> +				       4096 * st->r_sense_uohm);
> +			return 0;
> +		case hwmon_curr_max_alarm:
> +			*val = st->alert_threshold_ua;
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	case hwmon_in:
> +		ret = adm1177_read_raw(st, 3, data);
> +		if (ret < 0)
> +			return ret;
> +		dummy = (data[0] << 4) | (data[2] >> 4);
> +		/*
> +		 * convert to millivolts based on resistor devision
> +		 * (V_fullscale / 4096) * raw
> +		 */
> +		if (st->vrange_high)
> +			dummy *= 26350;
> +		else
> +			dummy *= 6650;
> +
> +		*val = DIV_ROUND_CLOSEST(dummy, 4096);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int adm1177_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	struct adm1177_state *st = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_max_alarm:
> +			adm1177_write_alert_thr(st, val);
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t adm1177_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	const struct adm1177_state *st = data;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			return 0444;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			if (st->r_sense_uohm)
> +				return 0444;
> +			return 0;
> +		case hwmon_curr_max_alarm:
> +			if (st->r_sense_uohm)
> +				return 0644;
> +			return 0;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *adm1177_info[] = {
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_MAX_ALARM),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops adm1177_hwmon_ops = {
> +	.is_visible = adm1177_is_visible,
> +	.read = adm1177_read,
> +	.write = adm1177_write,
> +};
> +
> +static const struct hwmon_chip_info adm1177_chip_info = {
> +	.ops = &adm1177_hwmon_ops,
> +	.info = adm1177_info,
> +};
> +
> +static void adm1177_remove(void *data)
> +{
> +	struct adm1177_state *st = data;
> +
> +	regulator_disable(st->reg);
> +}
> +
> +static int adm1177_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct adm1177_state *st;
> +	u32 alert_threshold_ua;
> +	int ret;
> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	st->client = client;
> +
> +	st->reg = devm_regulator_get_optional(&client->dev, "vref");
> +	if (IS_ERR(st->reg)) {
> +		if (PTR_ERR(st->reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		st->reg = NULL;
> +	} else {
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			return ret;
> +		ret = devm_add_action_or_reset(&client->dev, adm1177_remove,
> +					       st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				     &st->r_sense_uohm))
> +		st->r_sense_uohm = 0;
> +	if (device_property_read_u32(dev, "adi,shutdown-threshold-microamp",
> +				     &alert_threshold_ua)) {
> +		if (st->r_sense_uohm)
> +			/*
> +			 * set maximum default value from datasheet based on
> +			 * shunt-resistor
> +			 */
> +			alert_threshold_ua = div_u64(105840000000,
> +						     st->r_sense_uohm);
> +		else
> +			alert_threshold_ua = 0;
> +	}
> +	st->vrange_high = device_property_read_bool(dev,
> +						    "adi,vrange-high-enable");
> +	if (alert_threshold_ua && st->r_sense_uohm)
> +		adm1177_write_alert_thr(st, alert_threshold_ua);
> +
> +	ret = adm1177_write_cmd(st, ADM1177_CMD_V_CONT |
> +				    ADM1177_CMD_I_CONT |
> +				    (st->vrange_high ? 0 : ADM1177_CMD_VRANGE));
> +	if (ret)
> +		return ret;
> +
> +	hwmon_dev =
> +		devm_hwmon_device_register_with_info(dev, client->name, st,
> +						     &adm1177_chip_info, NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct i2c_device_id adm1177_id[] = {
> +	{"adm1177", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, adm1177_id);
> +
> +static const struct of_device_id adm1177_dt_ids[] = {
> +	{ .compatible = "adi,adm1177" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, adm1177_dt_ids);
> +
> +static struct i2c_driver adm1177_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "adm1177",
> +		.of_match_table = adm1177_dt_ids,
> +	},
> +	.probe = adm1177_probe,
> +	.id_table = adm1177_id,
> +};
> +module_i2c_driver(adm1177_driver);
> +
> +MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADM1177 ADC driver");
> +MODULE_LICENSE("GPL v2");
