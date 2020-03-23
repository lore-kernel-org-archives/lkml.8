Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1D620719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVp529FW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgCWXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:25:55 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:47101 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgCWXZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:25:55 -0400
Received: by mail-il1-f195.google.com with SMTP id e8so15019948ilc.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gh9vjwCy/n7eN7gQ+3EfFjdljWF4MHbtJSXf4X51/Mk=;
        b=mVp529FWKOATrbMF+7HQazoFSV8DrfiOgLLZ0GudwNuIOMxu9wgCidZRX5ytupBlHi
         +iWTvVEpRSvM9sf5KCy+ejgcg2Pb4aMQTSZQkxTHxDwUyTv9WNSzEfBFeJjqcSYzCZB2
         je85hcrUs/sDqq5hlWoThf1h1iZ3PZ3IfICqwP3xoiWC5X8tClIDZUuQIm1Huwri9+cP
         E72f0OMtUH1mfr+8jv/71CxYOH+SjyUhjtuU+jD6W1U0VSwDvHCZYJ1hDGb0mMO7nKDr
         D4bOiHyQsR1nLoHdez5KCtxDQCuqOswD7Te8VRb5EVOM7+ybc3iPmFMYu0d7+GY++PFu
         RwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gh9vjwCy/n7eN7gQ+3EfFjdljWF4MHbtJSXf4X51/Mk=;
        b=LnUxoPXsZHMmS4NObMeAKlh5+gx4QqcrvqiP5+U7VrjGzdIZArMYVmAdnPS2YKL83x
         JgZT+Q2rN0J78Dcyh0MT4+9QUmX8F4nmzs+lIlecORR+Vr62mNy2TrYKd5UOjbc3GrtI
         B2BVcaTClSbelOzl+3sNWxYFWFzvAZDRj38jcqx5DBd+02mKx4zr/LWJDodyMYDowBLE
         C9LUp/OAOslyCSupJfc2chBgs91HJMSLSbZoNOZolgsrSGoF24qsmQPuhyWmykOn7D1z
         KJCEYMdQAnmZDsTHPUBnjzL72ffu2zHbdPR4l6W+dt190KeaMuqmwC/FbQgA5t8GlnJF
         R/JA==
X-Gm-Message-State: ANhLgQ2SvFHgzKkrj5/2sYPGPEM8TPY1JX0PTY+K8WsDaGYKdQNLTAEc
        QFvnwQAVAeF3UYpKJgBqy0LeW2eSV2ZEu93yi6pcgg==
X-Google-Smtp-Source: ADFU+vuQF643mx42yg7Dif4Eg+OfFoR9j+RQNKH7PXwlKtXjgJRDp4CaT3IdnzCGtFb3ilzj6VJmt9vb0aSbtEx2g7M=
X-Received: by 2002:a92:5ccd:: with SMTP id d74mr22330140ilg.59.1585005953548;
 Mon, 23 Mar 2020 16:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200319224812.202013-1-kunyi@google.com> <20200319224812.202013-2-kunyi@google.com>
 <476e9c68-4532-ec07-8244-5a8aa2fbc599@roeck-us.net>
In-Reply-To: <476e9c68-4532-ec07-8244-5a8aa2fbc599@roeck-us.net>
From:   Kun Yi <kunyi@google.com>
Date:   Mon, 23 Mar 2020 16:25:25 -0700
Message-ID: <CAGMNF6V90KtzMXCvVk-BjRRqfR4Znfy-yPs-Ww4H_KFWuY1-vA@mail.gmail.com>
Subject: Re: [PATCH linux hwmon-next v1 1/3] hwmon: (sbtsi) Add basic support
 for SB-TSI sensors
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review comments!

On Thu, Mar 19, 2020 at 4:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/19/20 3:48 PM, Kun Yi wrote:
> > SB Temperature Sensor Interface (SB-TSI) is an SMBus compatible
> > interface that reports AMD SoC's Ttcl (normalized temperature),
> > and resembles a typical 8-pin remote temperature sensor's I2C interface
> > to BMC.
> >
> > This commit adds basic support using this interface to read CPU
> > temperature, and read/write high/low CPU temp thresholds.
> >
> > Test status: tested reading temp1_input, and reading/writing
> > temp1_max/min.
> >
>
> How do I instantiate this driver on a system with an AMD CPU
> (in other words, what is the i2c bus and the i2c address) ?

The i2c bus number would be the bus connected from BMC to the AMD CPU.
The i2c address is specified in the spec:
Section 6.3.1: The SB-TSI address is normally 98h for socket 0 and 90h
for socket 1, but it could vary based on hardware address select pins.

I will add this information to v2 commit message and the Documentation.

>
> > Signed-off-by: Kun Yi <kunyi@google.com>
> > ---
> >  drivers/hwmon/Kconfig      |  10 ++
> >  drivers/hwmon/Makefile     |   1 +
> >  drivers/hwmon/sbtsi_temp.c | 218 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 229 insertions(+)
> >  create mode 100644 drivers/hwmon/sbtsi_temp.c
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 05a30832c6ba..9585dcd01d1b 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1412,6 +1412,16 @@ config SENSORS_RASPBERRYPI_HWMON
> >         This driver can also be built as a module. If so, the module
> >         will be called raspberrypi-hwmon.
> >
> > +config SENSORS_SBTSI
> > +     tristate "Emulated SB-TSI temperature sensor"
> > +     depends on I2C
> > +     help
> > +       If you say yes here you get support for emulated temperature
> > +       sensors on AMD SoCs with SB-TSI interface connected to a BMC device.
> > +
> > +       This driver can also be built as a module. If so, the module will
> > +       be called sbtsi_temp.
> > +
> >  config SENSORS_SHT15
> >       tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
> >       depends on GPIOLIB || COMPILE_TEST
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index b0b9c8e57176..cd109f003ce4 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -152,6 +152,7 @@ obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
> >  obj-$(CONFIG_SENSORS_PWM_FAN)        += pwm-fan.o
> >  obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)      += raspberrypi-hwmon.o
> >  obj-$(CONFIG_SENSORS_S3C)    += s3c-hwmon.o
> > +obj-$(CONFIG_SENSORS_SBTSI)  += sbtsi_temp.o
> >  obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
> >  obj-$(CONFIG_SENSORS_SCH5627)        += sch5627.o
> >  obj-$(CONFIG_SENSORS_SCH5636)        += sch5636.o
> > diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
> > new file mode 100644
> > index 000000000000..f998d944a515
> > --- /dev/null
> > +++ b/drivers/hwmon/sbtsi_temp.c
> > @@ -0,0 +1,218 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * sbtsi_temp.c - hwmon driver for a SBI Temperature Sensor Interface (SB-TSI)
> > + *                compliant AMD SoC temperature device.
> > + *
> > + * Copyright (c) 2020, Google Inc.
> > + * Copyright (c) 2020, Kun Yi <kunyi@google.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +
> > +/*
> > + * SB-TSI registers only support SMBus byte data access. "_INT" registers are
> > + * the integer part of a temperature value or limit, and "_DEC" registers are
> > + * corresponding decimal parts.
> > + */
> > +#define SBTSI_REG_TEMP_INT           0x01 /* RO */
> > +#define SBTSI_REG_STATUS             0x02 /* RO */
> > +#define SBTSI_REG_CONFIG             0x03 /* RO */
> > +#define SBTSI_REG_TEMP_HIGH_INT              0x07 /* RW */
> > +#define SBTSI_REG_TEMP_LOW_INT               0x08 /* RW */
> > +#define SBTSI_REG_TEMP_DEC           0x10 /* RW */
> > +#define SBTSI_REG_TEMP_HIGH_DEC              0x13 /* RW */
> > +#define SBTSI_REG_TEMP_LOW_DEC               0x14 /* RW */
> > +#define SBTSI_REG_REV                        0xFF /* RO */
> > +
> > +#define SBTSI_CONFIG_READ_ORDER_SHIFT        5
> > +
> > +#define SBTSI_TEMP_MIN       (0)
> > +#define SBTSI_TEMP_MAX       (255875)
> > +#define SBTSI_REV_MAX_VALID_ID       (4)
>
> Unnecessary ( ) around literals.

Will fix in v2.

>
> > +
> > +struct sbtsi_data {
> > +     struct device *dev;
> > +     struct i2c_client *client;
> > +     struct mutex lock;
> > +};
> > +
> > +/*
> > + * From SB-TSI spec: CPU temperature readings and limit registers encode the
> > + * temperature in increments of 0.125 from 0 to 255.875. The "high byte"
> > + * register encodes the base-2 of the integer portion, and the upper 3 bits of
> > + * the "low byte" encode in base-2 the decimal portion.
> > + *
> > + * e.g. INT=0x19, DEC=0x20 represents 25.125 degrees Celsius
> > + *
> > + * Therefore temperature in millidegree Celsius =
> > + *   (INT + DEC / 256) * 1000 = (INT * 8 + DEC / 32) * 125
> > + */
> > +static inline int SBTSI_REGS_TO_TEMP(s32 integer, s32 decimal)
> > +{
> > +     return (((u32)integer << 3) + ((u32)decimal >> 5)) * 125;
>
> Why pass s32 as parameter just to typecast to u32 ? The values
> are known to be between 0 and 255, and thus will never be negative,
> even with s32, so this is really unnecessary.

That's a good point, will fix in v2.

> > +}
> > +
> > +/*
> > + * Inversely, given temperature in millidegree Celsius
> > + *   INT = (TEMP / 125) / 8
> > + *   DEC = ((TEMP / 125) % 8) * 32
> > + * Caller have to make sure temp doesn't exceed 255875, the max valid value.
> > + */
> > +static inline void SBTSI_TEMP_TO_REGS(u32 temp, u8 *integer, u8 *decimal)
> > +{
> > +     temp /= 125;
> > +     *integer = temp >> 3;
> > +     *decimal = (temp & 0x7) << 5;
> > +}
> > +
> > +static ssize_t sbtsi_show_temp(struct device *dev,
> > +                            struct device_attribute *attr, char *buf)
> > +{
> > +     struct sbtsi_data *data = dev_get_drvdata(dev);
> > +     struct i2c_client *client = data->client;
> > +     s32 err, temp_int, temp_dec;
> > +     u8 read_order;
> > +
> > +     /*
> > +      * ReadOrder bit specifies the reading order of integer and decimal
> > +      * part of CPU temp for atomic reads. If bit == 0, reading integer part
> > +      * triggers latching of the decimal part, so integer part should be read
> > +      * first. If bit == 1, read order should be reversed.
> > +      */
> > +     err = i2c_smbus_read_byte_data(client, SBTSI_REG_CONFIG);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     read_order = (u8)err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT);
> > +
> > +     if (read_order == 0) {
> > +             temp_int = i2c_smbus_read_byte_data(client, SBTSI_REG_TEMP_INT);
> > +             temp_dec = i2c_smbus_read_byte_data(client, SBTSI_REG_TEMP_DEC);
> > +     } else {
> > +             temp_dec = i2c_smbus_read_byte_data(client, SBTSI_REG_TEMP_DEC);
> > +             temp_int = i2c_smbus_read_byte_data(client, SBTSI_REG_TEMP_INT);
> > +     }
> > +
> > +     if (temp_int < 0)
> > +             return temp_int;
> > +     if (temp_dec < 0)
> > +             return temp_dec;
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%d\n",
> > +                      SBTSI_REGS_TO_TEMP(temp_int, temp_dec));
> > +}
> > +
> > +#define sbtsi_show_temp_limit(name, REG) \
> > +static ssize_t sbtsi_show_##name(struct device *dev, \
> > +                              struct device_attribute *attr, char *buf) \
> > +{ \
> > +     struct sbtsi_data *data = dev_get_drvdata(dev); \
> > +     struct i2c_client *client = data->client; \
> > +     s32 temp_int, temp_dec; \
> > +\
> > +     temp_int = i2c_smbus_read_byte_data(client, REG##_INT); \
> > +     temp_dec = i2c_smbus_read_byte_data(client, REG##_DEC); \
> > +\
> > +     if (temp_int < 0) \
> > +             return temp_int; \
> > +     if (temp_dec < 0) \
> > +             return temp_dec; \
> > +\
> > +     return scnprintf(buf, PAGE_SIZE, "%d\n", \
> > +                      SBTSI_REGS_TO_TEMP(temp_int, temp_dec)); \
> > +}
> > +
> > +sbtsi_show_temp_limit(temp1_min, SBTSI_REG_TEMP_LOW);
> > +sbtsi_show_temp_limit(temp1_max, SBTSI_REG_TEMP_HIGH);
> > +
> > +#define sbtsi_set_temp_limit(name, REG) \
> > +static ssize_t sbtsi_set_##name(struct device *dev, \
> > +                             struct device_attribute *attr, \
> > +                             const char *buf, size_t count) \
> > +{ \
> > +     struct sbtsi_data *data = dev_get_drvdata(dev); \
> > +     struct i2c_client *client = data->client; \
> > +     long val; \
> > +     u8 temp_int, temp_dec; \
> > +     int err = kstrtol(buf, 10, &val); \
> > +     if (err) \
> > +             return err; \
> > +\
> > +     val = clamp_val(val, SBTSI_TEMP_MIN, SBTSI_TEMP_MAX); \
> > +     mutex_lock(&data->lock); \
> > +     SBTSI_TEMP_TO_REGS(val, &temp_int, &temp_dec); \
> > +     i2c_smbus_write_byte_data(client, REG##_INT, temp_int); \
> > +     i2c_smbus_write_byte_data(client, REG##_DEC, temp_dec); \
> > +     mutex_unlock(&data->lock); \
> > +\
> > +     return count; \
> > +}
> > +
> > +sbtsi_set_temp_limit(temp1_min, SBTSI_REG_TEMP_LOW);
> > +sbtsi_set_temp_limit(temp1_max, SBTSI_REG_TEMP_HIGH);
> > +
> > +static SENSOR_DEVICE_ATTR(temp1_input, 0444, sbtsi_show_temp, NULL, 0);
> > +static SENSOR_DEVICE_ATTR(temp1_min, 0644, sbtsi_show_temp1_min,
> > +                       sbtsi_set_temp1_min, 1);
> > +static SENSOR_DEVICE_ATTR(temp1_max, 0644, sbtsi_show_temp1_max,
> > +                       sbtsi_set_temp1_max, 2);
> > +
> > +static struct attribute *sbtsi_attrs[] = {
> > +     &sensor_dev_attr_temp1_input.dev_attr.attr,
> > +     &sensor_dev_attr_temp1_min.dev_attr.attr,
> > +     &sensor_dev_attr_temp1_max.dev_attr.attr,
> > +     NULL,
> > +};
> > +ATTRIBUTE_GROUPS(sbtsi);
> > +
> > +static int sbtsi_probe(struct i2c_client *client,
> > +                    const struct i2c_device_id *id)
> > +{
> > +     struct device *dev = &client->dev;
> > +     struct device *hwmon_dev;
> > +     struct sbtsi_data *data;
> > +
> > +     data = devm_kzalloc(dev, sizeof(struct sbtsi_data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     data->client = client;
> > +     mutex_init(&data->lock);
> > +
> > +     hwmon_dev =
> > +             devm_hwmon_device_register_with_groups(dev, client->name, data,
> > +                                                    sbtsi_groups);
>
> Please rewrite to use the devm_hwmon_device_register_with_info() API.

Done in v2.

>
> > +     if (IS_ERR(hwmon_dev))
> > +             return PTR_ERR(hwmon_dev);
> > +
> > +     dev_info(dev, "sensor '%s'\n", client->name);
>
> Is that really valuable / necessary ?

Removed in v2.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct i2c_device_id sbtsi_id[] = {
> > +     {"sbtsi", 0},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sbtsi_id);
> > +
> > +static struct i2c_driver sbtsi_driver = {
> > +     .class = I2C_CLASS_HWMON,
> > +     .driver = {
> > +             .name = "sbtsi",
> > +     },
> > +     .probe = sbtsi_probe,
> > +     .id_table = sbtsi_id,
> > +};
> > +
> > +module_i2c_driver(sbtsi_driver);
> > +
> > +MODULE_AUTHOR("Kun Yi <kunyi@google.com>");
> > +MODULE_DESCRIPTION("Hwmon driver for AMD SB-TSI emulated sensor");
> > +MODULE_LICENSE("GPL");
> >
>


--
Regards,
Kun
