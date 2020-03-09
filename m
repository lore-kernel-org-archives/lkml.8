Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C140C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061A62464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8+vMVHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgCIQT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:19:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38916 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgCIQT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:19:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id w65so4484051pfb.6;
        Mon, 09 Mar 2020 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xdiddIrquBM++dxA7ozflVD7rHVm1Bq7xzQea6imiPc=;
        b=r8+vMVHT1yGSoVtnbfZPvV0kCfa8GroBwKSUmQY93a3COg8sq4/N7dM2VKZAqeqUuW
         w9jAA8mD0pfnYpp2m2KTkQPFtrdqItgRqQdQ6lAJdP9WFMlC8se9459Gu77TDoymaskH
         R+uCIwSGmH00Fp6SpcHZNlP6C3mWQvGtfOL4sWxkI5wXSIEvrNl9DEdEOmWSwm2s6vqQ
         P0ceiXcKV1NgcISvCt/5+H5jNk9HNIyCaJDCygiJD+H+iQafAg6u/hrCI79RrOdBrwvW
         6J+5A446uU1jRQxE6aqLv8bjNGRGhv61AV81sPVWWkOLW129GgIGsbFL+pyECsP8RIjU
         RPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xdiddIrquBM++dxA7ozflVD7rHVm1Bq7xzQea6imiPc=;
        b=KtgK77NhavrGvwFwVw+qoJuGhjczo75uKPkCEoQzf1I+znARZdj+lObLTH3Z4fNEek
         tGWxRWATArAvRxMm0mc97wodPrWUfWjnApyHJHr7zyOCk8H/vZ+f164VULe+IT08a0Xi
         7FxCqqrDcLWnzltKfdlD6IP9oNnWXcMWM7QGswQqD7V640FycP/WmIYTvAPfGezDOJSu
         e8+GUbabGwMi/6wTBmaqOmhyxiWSjfh0Tf2fpl0UkqhYepnQShz5yS3k8trPY1/2I3xr
         n65YTudadlLsKnz4rFFA/gBp41QmoHfLyISQPAXLTEHCn8cya3CSj6MUz21HGRfljk9R
         zd+Q==
X-Gm-Message-State: ANhLgQ1MchunFVjeuFeWiCobLZiVynSS4zM4hf2irZk9CtoPZcOOERPw
        6NyHBu5X2+Sdmq1mdBwo8MtLnlyx
X-Google-Smtp-Source: ADFU+vuk9yrgF9LTm02844oK4pRSSB0bumCNNi8NKbNAvMYrOI282h2kO4yhjPlE2/fW3kC4cFCDow==
X-Received: by 2002:a62:7786:: with SMTP id s128mr17258676pfc.34.1583770766326;
        Mon, 09 Mar 2020 09:19:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4sm2629833pfo.87.2020.03.09.09.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 09:19:25 -0700 (PDT)
Date:   Mon, 9 Mar 2020 09:19:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: pmbus: adm1266: add initial support
Message-ID: <20200309161923.GA22193@roeck-us.net>
References: <20200309141422.10999-1-alexandru.tachici@analog.com>
 <20200309141422.10999-2-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200309141422.10999-2-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 04:14:21PM +0200, Alexandru Tachici wrote:
> Add initial pmbus probing driver for the adm1266 Cascadable

Does "initial" suggest planned further enhancements ? If yes, please
describe, and explain why this support is omitted at this time.
If no, there is no reason for "initial".

> Super Sequencer with Margin Control and Fault Recording.
> Driver is currently using the pmbus_core, creating sysfs

Why "currently" ?

> files under hwmon for inputs: vh1->vh4 and vp1->vp13.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  Documentation/hwmon/adm1266   |  34 ++++++++
>  drivers/hwmon/pmbus/Kconfig   |  10 +++
>  drivers/hwmon/pmbus/Makefile  |   1 +
>  drivers/hwmon/pmbus/adm1266.c | 146 ++++++++++++++++++++++++++++++++++
>  4 files changed, 191 insertions(+)
>  create mode 100644 Documentation/hwmon/adm1266
>  create mode 100644 drivers/hwmon/pmbus/adm1266.c
> 
> diff --git a/Documentation/hwmon/adm1266 b/Documentation/hwmon/adm1266
> new file mode 100644
> index 000000000000..64651b5086a7
> --- /dev/null
> +++ b/Documentation/hwmon/adm1266
> @@ -0,0 +1,34 @@
> +Kernel driver adm1266
> +=====================
> +
> +Supported chips:
> +  * Analog Devices ADM1266
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1266.pdf
> +
> +Author: Alexandru Tachici <alexandru.tachici@analog.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for Analog Devices ADM1266 sequencer.
> +
> +ADM1266 is a sequencer that feature voltage readback from 17 channels via an
> +integrated 12 bit SAR ADC, accessed using a PMBus interface.
> +
> +The driver is a client driver to the core PMBus driver. Please see
> +Documentation/hwmon/pmbus for details on PMBus client drivers.
> +
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported. Limits are read-write, history reset
> +attributes are write-only, all other attributes are read-only.
> +
> +inX_label		"voutx"
> +inX_input		Measured voltage.
> +inX_min			Minimum Voltage.
> +inX_max			Maximum voltage.
> +inX_min_alarm		Voltage low alarm.
> +inX_max_alarm		Voltage high alarm.
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index a9ea06204767..153e64febe98 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -26,6 +26,16 @@ config SENSORS_PMBUS
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pmbus.
>  
> +config SENSORS_ADM1266
> +	tristate "Analog Devices ADM1266"
> +	default n

Unnecessary.

> +	help
> +	  If you say yes here you get hardware monitoring support for Analog
> +	  Devices ADM1266.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called adm1266.
> +
>  config SENSORS_ADM1275
>  	tristate "Analog Devices ADM1275 and compatibles"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 5feb45806123..ed38f6d6f845 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>  obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
> +obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> new file mode 100644
> index 000000000000..3aa8262f9bd6
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADM1266 - Cascadable Super Sequencer with Margin
> + * Control and Fault Recording
> + *
> + * Copyright 2020 Analog Devices Inc.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/fwnode.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "pmbus.h"
> +
> +enum chips { adm1266 };

Is this driver ever expected to support another chip ? If no, this is
unnecessary.

> +
> +struct adm1266_data {
> +	enum chips id;
> +	struct pmbus_driver_info info;
> +};
> +
> +static int adm1266_block_wr(struct i2c_client *client, u8 cmd, u8 wr_len,
> +			    u8 *data_w, u8 *data_r)
> +{
> +	union i2c_smbus_data smbus_data;
> +	int ret;
> +
> +	smbus_data.block[0] = wr_len;
> +	memcpy(smbus_data.block + 1, data_w, wr_len);
> +	ret = i2c_smbus_xfer(client->adapter, client->addr,
> +			     client->flags, I2C_SMBUS_READ, cmd,
> +			     I2C_SMBUS_BLOCK_PROC_CALL, &smbus_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	memcpy(data_r, &smbus_data.block[1], smbus_data.block[0]);
> +
> +	return 0;
> +}
> +
> +static int adm1266_config(struct pmbus_driver_info *info)
> +{
> +	u32 funcs;
> +	int i;
> +
> +	info->pages = 17;
> +	info->format[PSC_VOLTAGE_OUT] = linear;
> +
> +	funcs = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +	for (i = 0; i < info->pages; i++)
> +		info->func[i] = funcs;
> +
> +	return 0;
> +}

I don't immediately see the benefit of allocating this dynamically.
Please consider using a static structure.

> +
> +static const struct i2c_device_id adm1266_id[] = {
> +	{ "adm1266", adm1266 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, adm1266_id);
> +
> +static int adm1266_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
> +	u8 wr_buffer[I2C_SMBUS_BLOCK_MAX + 1];
> +	const struct i2c_device_id *mid;
> +	struct adm1266_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	wr_buffer[0] = 32;
> +	ret = adm1266_block_wr(client, PMBUS_MFR_ID, 1, wr_buffer,
> +			       block_buffer);

Please replace with standard SMBus block read commands. If that doesn't
work, please explain.

Note that according to the datasheet, the MFR commands are writeable.
You might want to consider checking 0xAD—IC_DEVICE_ID instead.

> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
> +		return ret;
> +	}
> +
> +	if (strncmp(block_buffer, "Analog Devices, Inc", 19)) {
> +		dev_err(&client->dev, "Unsupported Manufacturer ID\n");
> +		return -ENODEV;
> +	}
> +
> +	wr_buffer[0] = 32;
> +	ret = adm1266_block_wr(client, PMBUS_MFR_MODEL, 1, wr_buffer,
> +			       block_buffer);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read Manufacturer Model\n");
> +		return ret;
> +	}
> +
> +	for (mid = adm1266_id; mid->name[0]; mid++) {
> +		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
> +			break;
> +	}
> +	if (!mid->name[0]) {
> +		dev_err(&client->dev, "Unsupported device\n");
> +		return -ENODEV;
> +	}
> +
Unless there is reason to believe that the driver will in the future support
other chips, this is unnecessarily complex.

> +	data = devm_kzalloc(&client->dev, sizeof(struct adm1266_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	data->id = mid->driver_data;
> +
> +	ret = adm1266_config(&data->info);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Could not configure device.");
> +		return ret;
> +	}
> +
> +	return pmbus_do_probe(client, id, &data->info);
> +}
> +
> +static const struct of_device_id adm1266_of_match[] = {
> +	{ .compatible = "adi,adm1266" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, adm1266_of_match);
> +
> +static struct i2c_driver adm1266_driver = {
> +	.driver = {
> +		   .name = "adm1266",
> +		   .of_match_table = adm1266_of_match,
> +		  },
> +	.probe = adm1266_probe,
> +	.remove = pmbus_do_remove,
> +	.id_table = adm1266_id,
> +};
> +
> +module_i2c_driver(adm1266_driver);
> +
> +MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
> +MODULE_DESCRIPTION("PMBus driver for Analog Devices ADM1266");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.20.1
> 
