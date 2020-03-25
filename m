Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777DAC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F2320663
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rv6naWBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCYN6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:58:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41063 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgCYN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:58:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id z65so1071488pfz.8;
        Wed, 25 Mar 2020 06:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jc2Uda7VwDJvbIKlzSommWP6A5buVHnd0nGl7cJoVAQ=;
        b=rv6naWBIae+heyDeue+XszyMFr9ITxv2CmzI8HU59VsoZp6TzEhgAjFX+ct/vvsDSm
         8W7/O0qpUYexfgyX84uJJ7CjpNklNH52cqoWb0tuqMOtJ8R3ssMfdKwA3PVzJO8xxNg1
         IUAKjntVyB28J0SXDKg+k4u/YLxFtUpERJPjJehMDpcpjsnCHV5xdbrBNsGzpnEhuvFx
         8h6yMZ+joBxei1AikO+S+eXFrFVJxCqCs46prNoipDISkDoMbm0R2d+Fz9L3fhqMXX16
         JlSqkHW+rj96uEwvnicXLKQ3JnSldB4zGvQ8eh9jtb72HeoQp5j6DOHTLBMpl82zm9US
         gToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Jc2Uda7VwDJvbIKlzSommWP6A5buVHnd0nGl7cJoVAQ=;
        b=W9elt+D9yBoSEjsvNy0SjLi6soiOVvalj4sGiXU831tmnXBP3KJ9JUGZizYb9cJmaq
         kAYrj9sWCfamzXNPGAHNdCkqxQ9Z8XNyXhNSeZtFYJ+F9AnqAS72GoLbxZm2m+DdF/MG
         RvRgHVAjVTSdSe1yzWYyGjscDaaTS5sUp8jceUn/v2kQr/p3tpwnA5SWix4zOzR/HZ0f
         J+xf6NaMSflqhFX5n84w1yJaO/FgulnC3f93SJt4CfjPVdWwSX+lUv8IOpBuBNPR8fRo
         514LbmVX05i84/fEYL+zHvjfVUI8KVPXjPgoSvSZ78Iop1Px0iusduILx/NWieaMjjX0
         crcw==
X-Gm-Message-State: ANhLgQ351wrFQD6HiipI26N00UVfthN9a84X6zK1iHwfq40XZnv2oHqA
        AXgJTKxdgf2qgzNa/Y8Aoc8=
X-Google-Smtp-Source: ADFU+vt4LqBkbhIV++5Or3/744pUPbxjIL+Ong1wWQ5JSsVW1LA++AoaF0VZTn7YnEDSfA5/0QkRCA==
X-Received: by 2002:a63:a35a:: with SMTP id v26mr3491212pgn.40.1585144697197;
        Wed, 25 Mar 2020 06:58:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id hg20sm407909pjb.3.2020.03.25.06.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 06:58:16 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] hwmon: pmbus: adm1266: add support
To:     alexandru.tachici@analog.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20200325130605.2420-1-alexandru.tachici@analog.com>
 <20200325130605.2420-2-alexandru.tachici@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <742d3220-7a2c-d0a7-d286-7f71a5e78511@roeck-us.net>
Date:   Wed, 25 Mar 2020 06:58:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325130605.2420-2-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/25/20 6:06 AM, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add pmbus probing driver for the adm1266 Cascadable
> Super Sequencer with Margin Control and Fault Recording.
> Driver is using the pmbus_core, creating sysfs files
> under hwmon for inputs: vh1->vh4 and vp1->vp13.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

It looks like the driver is reduced to just standard functionality.
Can you try just adding the device ID to pmbus.c ?

Thanks,
Guenter

> ---
>  Documentation/hwmon/adm1266.rst | 35 +++++++++++++++++++
>  drivers/hwmon/pmbus/Kconfig     |  9 +++++
>  drivers/hwmon/pmbus/Makefile    |  1 +
>  drivers/hwmon/pmbus/adm1266.c   | 62 +++++++++++++++++++++++++++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 Documentation/hwmon/adm1266.rst
>  create mode 100644 drivers/hwmon/pmbus/adm1266.c
> 
> diff --git a/Documentation/hwmon/adm1266.rst b/Documentation/hwmon/adm1266.rst
> new file mode 100644
> index 000000000000..65662115750c
> --- /dev/null
> +++ b/Documentation/hwmon/adm1266.rst
> @@ -0,0 +1,35 @@
> +Kernel driver adm1266
> +=====================
> +
> +Supported chips:
> +  * Analog Devices ADM1266
> +    Prefix: 'adm1266'
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
> +ADM1266 is a sequencer that features voltage readback from 17 channels via an
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
> index a9ea06204767..3096e46e2212 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -26,6 +26,15 @@ config SENSORS_PMBUS
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pmbus.
>  
> +config SENSORS_ADM1266
> +	tristate "Analog Devices ADM1266"
> +	help
> +	  If you say yes here you get hardware monitoring support for Analog
> +	  Devices ADM1266 Cascadable Super Sequencer.
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
> index 000000000000..c1df21d564f3
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADM1266 - Cascadable Super Sequencer with Margin
> + * Control and Fault Recording
> + *
> + * Copyright 2020 Analog Devices Inc.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "pmbus.h"
> +
> +static int adm1266_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct pmbus_driver_info *info;
> +	u32 funcs;
> +	int i;
> +
> +	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
> +			    GFP_KERNEL);
> +
> +	info->pages = 17;
> +	info->format[PSC_VOLTAGE_OUT] = linear;
> +	funcs = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +	for (i = 0; i < info->pages; i++)
> +		info->func[i] = funcs;
> +
> +	return pmbus_do_probe(client, id, info);
> +}
> +
> +static const struct of_device_id adm1266_of_match[] = {
> +	{ .compatible = "adi,adm1266" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, adm1266_of_match);
> +
> +static const struct i2c_device_id adm1266_id[] = {
> +	{ "adm1266", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, adm1266_id);
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
> 

