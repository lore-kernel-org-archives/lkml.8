Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA602C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BCC246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEaE/N0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgB1W6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:58:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37654 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1W6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:58:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so2451675pfn.4;
        Fri, 28 Feb 2020 14:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N91mHC3Bt7AbePUGl8T8wFHWJhz65RPFn9IhplJ/GvY=;
        b=KEaE/N0kpQAwTRCZvM3p4Cmz7GmkkPV9TrtT8cAIXF/HjyMaMAGT9H4PGrRdmQEAq3
         xZ9Jj/DeJN6aTikxNuXgLNl7Ap1C5LejfX7iGe+7yuDYKXgzbu9R1VliUNoWJVStlIKu
         Jyxownea2G3gEcXJM807BvkUs/qQq1KOpRHU2xkWP+AYYtKEXYPUg0NPujh0MQ2O0Fpf
         YrSfMqKpiwXsWaOsVS5+WJP3k+hCmUySkiBMwcvkCVIwxtWt+9orbGaI/z+ga8RZ6GiW
         j/pLOQFLEmdx4b3TSlIMOvE9oYA0KjTbFqoW7C6jtf4NLZ6p7MTinhlvjjL0KztV2R+U
         6phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N91mHC3Bt7AbePUGl8T8wFHWJhz65RPFn9IhplJ/GvY=;
        b=NOIciTCDExkTUys/dsuHQh5mwnO9++t96RFs+E9FcLnmWLU2VqJuly0eSQ81qc7f+s
         HKiWEuBd8AGA8YpKBP/5M2KM0+/cVUy0FsdmG5nom3wd5hLWbJQRjDIM8F57I72tQM+U
         2/XGDvpfA15tiEo2W5fRPRg7lf66tKorLC7Mvo3DV6c57i3oE8lDlTxXMQF2kXMffsZ9
         R0M2BMWFzslvMNaa9XbZAdb5I0mwYArfwVlSRZPveOs3LL58LM19mqoJSLLPwb7KahKz
         nJBYavLP/mIbEUFZIY+p9LJDw09y5g+vPdjWJpineMu1+CymTwQ3rs9/fDXbciW0YNBM
         TqPQ==
X-Gm-Message-State: APjAAAXP4sZtuAAUZKUNvr2o2TtTGPJoKQEw8e7uCAM1JcHCidk3+kS3
        JSSjtCbCYqh0Lw1LayNEBd35nTTt
X-Google-Smtp-Source: APXvYqxuUPtqxzs68YXsTg5WLXnpCk+Y6EghOQHc0O4lA1U30DArmWMxNqX/Ui446L8QCgBAL5C0jA==
X-Received: by 2002:a63:f311:: with SMTP id l17mr7014444pgh.142.1582930730325;
        Fri, 28 Feb 2020 14:58:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d1sm3864667pfc.3.2020.02.28.14.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 14:58:49 -0800 (PST)
Date:   Fri, 28 Feb 2020 14:58:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, adam.vaughn.xh@renesas.com,
        zaitsev@google.com
Subject: Re: [PATCH] hwmon: (pmbus) Add support for 2nd Gen Renesas digital
 multiphase
Message-ID: <20200228225848.GA14676@roeck-us.net>
References: <20200228212349.GA1929@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228212349.GA1929@raspberrypi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 03:23:49PM -0600, Grant Peltier wrote:
> Add a driver to support 2nd generation Renesas digital multiphase power
> regulators. The driver is meant to support a large family of part
> numbers spanning isl682xx, isl692xx, and some raa228/9 part designations.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
> ---
>  drivers/hwmon/pmbus/Kconfig    |   9 +
>  drivers/hwmon/pmbus/Makefile   |   1 +
>  drivers/hwmon/pmbus/isl692xx.c | 352 +++++++++++++++++++++++++++++++++

One of the supported chips should be selected as driver name. There is no
guarantee that there will never be any ISL692XX chips with different
functionality. Besides, the name is misleading anyway since the driver
already supports other chips besides those named isl692xx.

Please provide Documentation/hwmon/isl692xx (or whatever the final name is).
This needs to briefly explain what each of those chips actually is.

There is no public information available for several of the chips listed
in the driver. Without datasheets I can only accept support for chips
which are by some means confirmed to actually exist.

In this context, I have to admit that I _really_ dislike the secrecy
around those chips. I have seen several instances where I accepted
a driver which turned out to be buggy, simply because I did not have
access to a datasheet. In some cases, even if I know that there
may be a problem or missing support for something I can't talk
about it it because, say, I have seen an internal driver which
does things a bit differently and my employer didn't get permission
to publish the driver. Yes, I understand that this is becoming
more and more common in the industry, but that doesn't make it
better and ultimately just hurts everyone.

More comments inline.

Guenter

>  3 files changed, 362 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/isl692xx.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index a9ea06204767..fbe7bbc8b37c 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -100,6 +100,15 @@ config SENSORS_ISL68137
>  	  This driver can also be built as a module. If so, the module will
>  	  be called isl68137.
>  
> +config SENSORS_ISL692XX
> +        tristate "Renesas 2nd Gen Digital Multiphase"
						... Power Regulators
> +        help
> +          If you say yes here you get hardware monitoring support for Renesas
> +          2nd Generation Digital Multiphase power regulators.
> +
> +          This driver can also be built as a module. If so, the module will
> +          be called isl692xx.
> +
>  config SENSORS_LM25066
>  	tristate "National Semiconductor LM25066 and compatibles"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 5feb45806123..bf1ea99a6120 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
>  obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
>  obj-$(CONFIG_SENSORS_IRPS5401)	+= irps5401.o
>  obj-$(CONFIG_SENSORS_ISL68137)	+= isl68137.o
> +obj-$(CONFIG_SENSORS_ISL692XX)	+= isl692xx.o
>  obj-$(CONFIG_SENSORS_LM25066)	+= lm25066.o
>  obj-$(CONFIG_SENSORS_LTC2978)	+= ltc2978.o
>  obj-$(CONFIG_SENSORS_LTC3815)	+= ltc3815.o
> diff --git a/drivers/hwmon/pmbus/isl692xx.c b/drivers/hwmon/pmbus/isl692xx.c
> new file mode 100644
> index 000000000000..26f3d90a7ddc
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/isl692xx.c
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for Renesas Gen 2 Digital Multiphase Devices
> + *
> + * Copyright (c) 2020 Renesas Electronics America
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +
Alphabetic order please

> +#include "pmbus.h"
> +
> +#define ISL692XX_READ_VMON        0xc8
> +
> +enum parts {
> +        isl68220,
> +        isl68221,
> +        isl68222,
> +        isl68223,
> +        isl68224,
> +        isl68225,
> +        isl68226,
> +        isl68227,
> +        isl68229,
> +        isl68233,
> +        isl68239,
> +        isl69222,
> +        isl69223,
> +        isl69224,
> +        isl69225,
> +        isl69227,
> +        isl69228,
> +        isl69234,
> +        isl69236,
> +        isl69239,
> +        isl69242,
> +        isl69243,
> +        isl69247,
> +        isl69248,
> +        isl69254,
> +        isl69255,
> +        isl69256,
> +        isl69259,
> +        isl69260,
> +        isl69268,
> +        isl69269,
> +        isl69298,
> +        raa228000,
> +        raa228004,
> +        raa228006,
> +        raa228228,
> +        raa229001,
> +        raa229004,
> +};
> +
> +enum rail_configs { high_voltage, one_rail, two_rail, three_rail };
> +
> +static const struct  i2c_device_id isl692xx_id[] = {
> +        { "isl68220", isl68220 },
> +        { "isl68221", isl68221 },
> +        { "isl68222", isl68222 },
> +        { "isl68223", isl68223 },
> +        { "isl68224", isl68224 },
> +        { "isl68225", isl68225 },
> +        { "isl68226", isl68226 },
> +        { "isl68227", isl68227 },
> +        { "isl68229", isl68229 },
> +        { "isl68233", isl68233 },
> +        { "isl68239", isl68239 },
> +        { "isl69222", isl69222 },
> +        { "isl69223", isl69223 },
> +        { "isl69224", isl69224 },
> +        { "isl69225", isl69225 },
> +        { "isl69227", isl69227 },
> +        { "isl69228", isl69228 },
> +        { "isl69234", isl69234 },
> +        { "isl69236", isl69236 },
> +        { "isl69239", isl69239 },
> +        { "isl69242", isl69242 },
> +        { "isl69243", isl69243 },
> +        { "isl69247", isl69247 },
> +        { "isl69248", isl69248 },
> +        { "isl69254", isl69254 },
> +        { "isl69255", isl69255 },
> +        { "isl69256", isl69256 },
> +        { "isl69259", isl69259 },
> +        { "isl69260", isl69260 },
> +        { "isl69268", isl69268 },
> +        { "isl69269", isl69269 },
> +        { "isl69298", isl69298 },
> +        { "raa228000", raa228000 },
> +        { "raa228004", raa228004 },
> +        { "raa228006", raa228006 },
> +        { "raa228228", raa228228 },
> +        { "raa229001", raa229001 },
> +        { "raa229004", raa229004 },

It would be much simpler to just specify high_voltage, one_rail, two_rail,
and three_rail as parameters. I don't see value in the code translating
chip types to enum rail_configs (nor in enum parts).

> +        { },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, isl692xx_id);
> +
> +static int isl692xx_read_word_data(struct i2c_client *client, int page, int reg)
> +{
> +        int ret;
> +
> +        switch (reg) {
> +        case PMBUS_VIRT_READ_VMON:
> +                ret = pmbus_read_word_data(client, page, ISL692XX_READ_VMON);
> +                break;
> +        default:
> +                ret = -ENODATA;
> +                break;
> +        }
> +        
> +        return ret;
> +}
> +
> +static struct pmbus_driver_info isl692xx_info[] = {
> +        [high_voltage] = {
> +                .pages = 1,
> +                .format[PSC_VOLTAGE_IN] = direct,
> +                .format[PSC_VOLTAGE_OUT] = direct,
> +                .format[PSC_CURRENT_IN] = direct,
> +                .format[PSC_CURRENT_OUT] = direct,
> +                .format[PSC_POWER] = direct,
> +                .format[PSC_TEMPERATURE] = direct,
> +                .m[PSC_VOLTAGE_IN] = 1,
> +                .b[PSC_VOLTAGE_IN] = 0,
> +                .R[PSC_VOLTAGE_IN] = 1,
> +                .m[PSC_VOLTAGE_OUT] = 2,
> +                .b[PSC_VOLTAGE_OUT] = 0,
> +                .R[PSC_VOLTAGE_OUT] = 2,
> +                .m[PSC_CURRENT_IN] = 2,
> +                .b[PSC_CURRENT_IN] = 0,
> +                .R[PSC_CURRENT_IN] = 2,
> +                .m[PSC_CURRENT_OUT] = 1,
> +                .b[PSC_CURRENT_OUT] = 0,
> +                .R[PSC_CURRENT_OUT] = 1,
> +                .m[PSC_POWER] = 2,
> +                .b[PSC_POWER] = 0,
> +                .R[PSC_POWER] = -1,
> +                .m[PSC_TEMPERATURE] = 1,
> +                .b[PSC_TEMPERATURE] = 0,
> +                .R[PSC_TEMPERATURE] = 0,
> +                .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN |
> +                        PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
> +                        PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +                        PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +                        PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +                        PMBUS_HAVE_VMON,
> +                .read_word_data = isl692xx_read_word_data,
> +        },
> +        [one_rail] = {
> +                .pages = 1,
> +                .format[PSC_VOLTAGE_IN] = direct,
> +                .format[PSC_VOLTAGE_OUT] = direct,
> +                .format[PSC_CURRENT_IN] = direct,
> +                .format[PSC_CURRENT_OUT] = direct,
> +                .format[PSC_POWER] = direct,
> +                .format[PSC_TEMPERATURE] = direct,
> +                .m[PSC_VOLTAGE_IN] = 1,
> +                .b[PSC_VOLTAGE_IN] = 0,
> +                .R[PSC_VOLTAGE_IN] = 2,
> +                .m[PSC_VOLTAGE_OUT] = 1,
> +                .b[PSC_VOLTAGE_OUT] = 0,
> +                .R[PSC_VOLTAGE_OUT] = 3,
> +                .m[PSC_CURRENT_IN] = 1,
> +                .b[PSC_CURRENT_IN] = 0,
> +                .R[PSC_CURRENT_IN] = 2,
> +                .m[PSC_CURRENT_OUT] = 1,
> +                .b[PSC_CURRENT_OUT] = 0,
> +                .R[PSC_CURRENT_OUT] = 1,
> +                .m[PSC_POWER] = 1,
> +                .b[PSC_POWER] = 0,
> +                .R[PSC_POWER] = 0,
> +                .m[PSC_TEMPERATURE] = 1,
> +                .b[PSC_TEMPERATURE] = 0,
> +                .R[PSC_TEMPERATURE] = 0,
> +                .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN |
> +                        PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
> +                        PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +                        PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +                        PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +                        PMBUS_HAVE_VMON,
> +                .read_word_data = isl692xx_read_word_data,
> +        },
> +        [two_rail] = {
> +                .pages = 2,
> +                .format[PSC_VOLTAGE_IN] = direct,
> +                .format[PSC_VOLTAGE_OUT] = direct,
> +                .format[PSC_CURRENT_IN] = direct,
> +                .format[PSC_CURRENT_OUT] = direct,
> +                .format[PSC_POWER] = direct,
> +                .format[PSC_TEMPERATURE] = direct,
> +                .m[PSC_VOLTAGE_IN] = 1,
> +                .b[PSC_VOLTAGE_IN] = 0,
> +                .R[PSC_VOLTAGE_IN] = 2,
> +                .m[PSC_VOLTAGE_OUT] = 1,
> +                .b[PSC_VOLTAGE_OUT] = 0,
> +                .R[PSC_VOLTAGE_OUT] = 3,
> +                .m[PSC_CURRENT_IN] = 1,
> +                .b[PSC_CURRENT_IN] = 0,
> +                .R[PSC_CURRENT_IN] = 2,
> +                .m[PSC_CURRENT_OUT] = 1,
> +                .b[PSC_CURRENT_OUT] = 0,
> +                .R[PSC_CURRENT_OUT] = 1,
> +                .m[PSC_POWER] = 1,
> +                .b[PSC_POWER] = 0,
> +                .R[PSC_POWER] = 0,
> +                .m[PSC_TEMPERATURE] = 1,
> +                .b[PSC_TEMPERATURE] = 0,
> +                .R[PSC_TEMPERATURE] = 0,
> +                .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN |
> +                        PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
> +                        PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +                        PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +                        PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +                        PMBUS_HAVE_VMON,
> +                .func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN |
> +                        PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
> +                        PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +                        PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +                        PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +                        PMBUS_HAVE_VMON,
> +                .read_word_data = isl692xx_read_word_data,
> +        },
> +        [three_rail] = {
> +                .pages = 3,
> +                .format[PSC_VOLTAGE_IN] = direct,
> +                .format[PSC_VOLTAGE_OUT] = direct,
> +                .format[PSC_CURRENT_IN] = direct,
> +                .format[PSC_CURRENT_OUT] = direct,
> +                .format[PSC_POWER] = direct,
> +                .format[PSC_TEMPERATURE] = direct,
> +                .m[PSC_VOLTAGE_IN] = 1,
> +                .b[PSC_VOLTAGE_IN] = 0,
> +                .R[PSC_VOLTAGE_IN] = 2,
> +                .m[PSC_VOLTAGE_OUT] = 1,
> +                .b[PSC_VOLTAGE_OUT] = 0,
> +                .R[PSC_VOLTAGE_OUT] = 3,
> +                .m[PSC_CURRENT_IN] = 1,
> +                .b[PSC_CURRENT_IN] = 0,
> +                .R[PSC_CURRENT_IN] = 2,
> +                .m[PSC_CURRENT_OUT] = 1,
> +                .b[PSC_CURRENT_OUT] = 0,
> +                .R[PSC_CURRENT_OUT] = 1,
> +                .m[PSC_POWER] = 1,
> +                .b[PSC_POWER] = 0,
> +                .R[PSC_POWER] = 0,
> +                .m[PSC_TEMPERATURE] = 1,
> +                .b[PSC_TEMPERATURE] = 0,
> +                .R[PSC_TEMPERATURE] = 0,
> +                .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN |
> +                        PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
> +                        PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +                        PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +                        PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +                        PMBUS_HAVE_VMON,
> +                .func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN |
> +                        PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
> +                        PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +                        PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +                        PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +                        PMBUS_HAVE_VMON,
> +                .func[2] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN |
> +                        PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
> +                        PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +                        PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +                        PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +                        PMBUS_HAVE_VMON,
> +                .read_word_data = isl692xx_read_word_data,
> +        },
> +};
> +
> +static int isl692xx_probe(struct i2c_client *client,
> +                          const struct i2c_device_id *id)
> +{
> +        int ret;
> +
> +        switch (id->driver_data) {
> +        case raa228000:
> +        case raa228004:
> +        case raa228006:
> +                ret = pmbus_do_probe(client, id, &isl692xx_info[high_voltage]);
> +                break;
> +        case isl68227:
> +        case isl69243:
> +                ret = pmbus_do_probe(client, id, &isl692xx_info[one_rail]);
> +                break;
> +        case isl68220:
> +        case isl68222:
> +        case isl68223:
> +        case isl68225:
> +        case isl68233:
> +        case isl69222:
> +        case isl69224:
> +        case isl69225:
> +        case isl69234:
> +        case isl69236:
> +        case isl69242:
> +        case isl69247:
> +        case isl69248:
> +        case isl69254:
> +        case isl69255:
> +        case isl69256:
> +        case isl69259:
> +        case isl69260:
> +        case isl69268:
> +        case isl69298:
> +        case raa228228:
> +        case raa229001:
> +        case raa229004:
> +                ret = pmbus_do_probe(client, id, &isl692xx_info[two_rail]);
> +                break;
> +        case isl68221:
> +        case isl68224:
> +        case isl68226:
> +        case isl68229:
> +        case isl68239:
> +        case isl69223:
> +        case isl69227:
> +        case isl69228:
> +        case isl69239:
> +        case isl69269:
> +                ret = pmbus_do_probe(client, id, &isl692xx_info[three_rail]);
> +                break;
> +        default:
> +                ret = -ENODEV;
> +        }
> +
> +        return ret;
> +}
> +
> +static struct i2c_driver isl692xx_driver = {
> +        .driver = {
> +                .name = "isl692xx",
> +        },
> +        .probe = isl692xx_probe,
> +        .remove = pmbus_do_remove,
> +        .id_table = isl692xx_id,
> +};
> +
> +module_i2c_driver(isl692xx_driver);
> +
> +MODULE_AUTHOR("Grant Peltier");
> +MODULE_DESCRIPTION("PMBus driver for 2nd Gen Renesas digital multiphase "
> +                   "devices");
> +MODULE_LICENSE("GPL");
> +
> -- 
> 2.20.1
> 
