Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4630C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C5F2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0ARKMu9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgERJ57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:57:59 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39155 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgERJ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589795876; x=1621331876;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=4OvW5X7lQPqJSj1FDeUtnvAV3jtnCoqzvXyXeZaCI54=;
  b=0ARKMu9iS8R62Zz+9ZqxNXGoSzrPKhjLgdz1nwbZqUd/0mSGfwpO5PoO
   019di04vAbsizqwncfkIai4qL3r5HDKd/WY4VDUTVxv7DsZobUkyoKoVH
   r15ST0tfYuRhCnlVj3GW7r1nYeMiOZrTtQjQUQf1v7Y3FjMegokUJ6lM5
   PeD2Ba8p7aJ6IekdtNRylopJVYfECwoXMhemtQkGu27ZU/I2V/Dnt4SAl
   8s3CPLxQLkT2WtnbaGE/Dz/+f/aHYf1BzvBqYFWEBnwQMnlDI4HJ9AryN
   XlW4bYXPHbY9110GpEbnX/6TMqdnRv28wRX2sWDUqwp8Vy8lB+Xc7V7lA
   A==;
IronPort-SDR: r0o8fdMe+VRF7ORwmBrvsAcdfvtRYnk8GiP5A9+ii5LNqYTJ+ndORuwVonnHoR66E/kRLQNAmi
 hncaM9Bdzc+n3Jf2/uoxitOac1o/YmAQZ0UUK32JhMKflNJ1sNNILeLNzc6TQWoeCYyiRZJ11l
 3+5Ipj3LglaavQejVzEBbALtZYVF3r6JwPBIocdSxORNpqUmGtgOvLFEAx1uVK3q1uSnGC/5Cu
 GHWrvvb9/nSa8LcPmvFsactJGnHYrC+0AjVS4PG2U+R8g/fVaRQ+eu3043TYu1sp4cBQ9KEzNL
 rpA=
X-IronPort-AV: E=Sophos;i="5.73,406,1583218800"; 
   d="scan'208";a="73754448"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2020 02:57:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 May 2020 02:57:55 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 18 May 2020 02:57:54 -0700
References: <20200513134140.25357-1-lars.povlsen@microchip.com> <20200513134140.25357-4-lars.povlsen@microchip.com> <20200513152018.GA60367@roeck-us.net>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
List-Id: <soc.lore.kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        SoC Team <soc@kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 3/3] hwmon: sparx5: Add Sparx5 SoC temperature driver
In-Reply-To: <20200513152018.GA60367@roeck-us.net>
Date:   Mon, 18 May 2020 11:57:52 +0200
Message-ID: <87tv0do99b.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guenter Roeck writes:

> On Wed, May 13, 2020 at 03:41:40PM +0200, Lars Povlsen wrote:
>> This patch adds a temperature sensor driver to the Sparx5 SoC.
>>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  drivers/hwmon/Kconfig       |  10 +++
>>  drivers/hwmon/Makefile      |   2 +-
>>  drivers/hwmon/sparx5-temp.c | 154 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 165 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/hwmon/sparx5-temp.c
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 4c62f900bf7e8..130cb1f1748ff 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -480,6 +480,16 @@ config SENSORS_I5K_AMB
>>         This driver can also be built as a module. If so, the module
>>         will be called i5k_amb.
>>
>> +config SENSORS_SPARX5
>> +     tristate "Sparx5 SoC temperature sensor"
>> +     depends on ARCH_SPARX5
>> +     help
>> +       If you say yes here you get support for temperature monitoring
>> +       with the Microchip Sparx5 SoC.
>> +
>> +       This driver can also be built as a module. If so, the module
>> +       will be called sparx5-temp.
>> +
>>  config SENSORS_F71805F
>>       tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
>>       depends on !PPC
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index b0b9c8e571762..28a09986b7a62 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -64,6 +64,7 @@ obj-$(CONFIG_SENSORS_DS1621)        += ds1621.o
>>  obj-$(CONFIG_SENSORS_EMC1403)        += emc1403.o
>>  obj-$(CONFIG_SENSORS_EMC2103)        += emc2103.o
>>  obj-$(CONFIG_SENSORS_EMC6W201)       += emc6w201.o
>> +obj-$(CONFIG_SENSORS_SPARX5) += sparx5-temp.o
>>  obj-$(CONFIG_SENSORS_F71805F)        += f71805f.o
>>  obj-$(CONFIG_SENSORS_F71882FG)       += f71882fg.o
>>  obj-$(CONFIG_SENSORS_F75375S)        += f75375s.o
>> @@ -190,4 +191,3 @@ obj-$(CONFIG_SENSORS_OCC) += occ/
>>  obj-$(CONFIG_PMBUS)          += pmbus/
>>
>>  ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>> -
>> diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
>> new file mode 100644
>> index 0000000000000..bf9dd102a9825
>> --- /dev/null
>> +++ b/drivers/hwmon/sparx5-temp.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/* Sparx5 SoC temperature sensor driver
>> + *
>> + * Copyright (C) 2020 Lars Povlsen <lars.povlsen@microchip.com>
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>
> Unnecessary include

Ack.

>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +
>> +#define TEMP_CTRL            0
>> +#define TEMP_CFG             4
>> +#define  TEMP_CFG_CYCLES     GENMASK(24, 15)
>> +#define  TEMP_CFG_CYCLES_OFF 15
>> +#define  TEMP_CFG_ENA                BIT(0)
>> +#define TEMP_STAT            8
>> +#define  TEMP_STAT_VALID     BIT(12)
>> +#define  TEMP_STAT_TEMP              GENMASK(11, 0)
>> +
>> +struct s5_hwmon {
>> +     void __iomem *base;
>> +};
>> +
>> +static void s5_temp_enable(struct s5_hwmon *hwmon)
>> +{
>> +     u32 val = readl(hwmon->base + TEMP_CFG);
>> +     u32 clk = 250;
>> +
>> +     val &= ~TEMP_CFG_CYCLES;
>> +     val |= (clk << TEMP_CFG_CYCLES_OFF);
>> +     val |= TEMP_CFG_ENA;
>> +
>> +     writel(val, hwmon->base + TEMP_CFG);
>> +}
>> +
>> +static void s5_temp_disable(void *data)
>> +{
>> +     struct s5_hwmon *hwmon = data;
>> +     u32 val = readl(hwmon->base + TEMP_CFG);
>> +
>> +     val &= ~TEMP_CFG_ENA;
>> +
>> +     writel(val, hwmon->base + TEMP_CFG);
>> +}
>> +
>> +static int s5_read(struct device *dev, enum hwmon_sensor_types type,
>> +                u32 attr, int channel, long *temp)
>> +{
>> +     struct s5_hwmon *hwmon = dev_get_drvdata(dev);
>> +     int rc = 0, value;
>> +     u32 stat;
>> +
>> +     switch (attr) {
>> +     case hwmon_temp_input:
>> +             stat = readl_relaxed(hwmon->base + TEMP_STAT);
>> +             if (stat & TEMP_STAT_VALID) {
>> +                     value = (stat & TEMP_STAT_TEMP);
>
> Unnecessary ( )

Removed.

>
>> +                     value = DIV_ROUND_CLOSEST(value * 3522, 4096) - 1094;
>> +                     value *= 100;
>> +                     *temp = value;
>> +             } else
>> +                     rc = -EINVAL;
>
> -EINVAL is for bad used input. -EIO, maybe, unless there is a better error.
> Also,
>
>                 if (!(stat & TEMP_STAT_VALID))
>                         return -EIO;

Ok, changed.

>                 ...
>
> would be easier to read (and not result in a checkpatch warning).
>
>> +             break;
>> +     default:
>> +             rc = -EOPNOTSUPP;
>
>                 break;
>

Added.

>> +     }
>> +
>> +     return rc;
>> +}
>> +
>> +static umode_t s5_is_visible(const void *_data, enum hwmon_sensor_types type,
>> +                          u32 attr, int channel)
>> +{
>> +     if (type != hwmon_temp)
>> +             return 0;
>> +
>> +     switch (attr) {
>> +     case hwmon_temp_input:
>> +             return 0444;
>> +     default:
>> +             return 0;
>> +     }
>> +}
>> +
>> +static const struct hwmon_channel_info *s5_info[] = {
>> +     HWMON_CHANNEL_INFO(chip,
>> +                        HWMON_C_REGISTER_TZ),
>> +     HWMON_CHANNEL_INFO(temp,
>> +                        HWMON_T_INPUT),
>> +     NULL
>> +};
>> +
>> +static const struct hwmon_ops s5_hwmon_ops = {
>> +     .is_visible = s5_is_visible,
>> +     .read = s5_read,
>> +};
>> +
>> +static const struct hwmon_chip_info s5_chip_info = {
>> +     .ops = &s5_hwmon_ops,
>> +     .info = s5_info,
>> +};
>> +
>> +static int s5_temp_probe(struct platform_device *pdev)
>> +{
>> +     struct device *hwmon_dev;
>> +     struct s5_hwmon *hwmon;
>> +     int err = 0;
>
> Unnecessary initialization
>

Removed

>> +
>> +     hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
>> +     if (!hwmon)
>> +             return -ENOMEM;
>> +
>> +     hwmon->base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(hwmon->base))
>> +             return PTR_ERR(hwmon->base);
>> +
>> +     err = devm_add_action(&pdev->dev, s5_temp_disable, hwmon);
>> +     if (err)
>> +             return err;
>> +
>> +     s5_temp_enable(hwmon);
>> +
>> +     hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
>> +                                                      "s5_temp",
>> +                                                      hwmon,
>> +                                                      &s5_chip_info,
>> +                                                      NULL);
>> +
>> +     return PTR_ERR_OR_ZERO(hwmon_dev);
>> +}
>> +
>> +const struct of_device_id s5_temp_match[] = {
>> +     { .compatible = "microchip,sparx5-temp" },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, s5_temp_match);
>> +
>> +static struct platform_driver s5_temp_driver = {
>> +     .probe = s5_temp_probe,
>> +     .driver = {
>> +             .name = "sparx5-temp",
>> +             .of_match_table = s5_temp_match,
>> +     },
>> +};
>> +
>> +module_platform_driver(s5_temp_driver);
>> +
>> +MODULE_AUTHOR("Lars Povlsen <lars.povlsen@microchip.com>");
>> +MODULE_DESCRIPTION("Sparx5 SoC temperature sensor driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.26.2

Thank you for your input, I will submit anew asap.

---Lars

-- 
Lars Povlsen,
Microchip
