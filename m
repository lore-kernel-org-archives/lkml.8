Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BC4C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1686F208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZPaM3d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbgCCUyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:54:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40497 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730949AbgCCUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:54:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id l184so2088000pfl.7;
        Tue, 03 Mar 2020 12:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UX/p6aXlOkdE0HqTGI/eChI7fHEhvIV+uamRV9T61Jw=;
        b=XZPaM3d0asz3xLGxIu+6pobkL8CggEzWAqDq+8GAJQAkB3ktEUN1D716t4w3jx7087
         kBpQy2BjalNfGgHUP12xQkTZ9o1/wdOHTsX1TdzvrWldKsbcysPPBCIUDt7ihLK30ST0
         bfP3PTOEpgrJvKVwYy+7gVkH3LbVwGSxMf/Mf44lED2xQytclF/6BcjOuiW36P96Lppa
         YsKbEW2S0RPEmugcI9rL2IjgLn/9Q+NuzaVM/OSPfKrlaAPDja1rLhi96gBCLWb9yk1M
         +mVKxu4ITvI6XsFKXBdsKrZCqudwfa0TAkw8tUx7WBTKBF5kLrFAKJz7y6C/RoCzXhN1
         eC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UX/p6aXlOkdE0HqTGI/eChI7fHEhvIV+uamRV9T61Jw=;
        b=BvFJhyvB4TkqjkwwCaYZarsLHAulYUVVP9yObgKxOTE9wbTOMQE+5LZLBLP07goM9R
         amUz8y/lERbX8PwSomtYi204eo+YHqm9n2y4OlWmece11djtszQ56Te8PRYbRJ0n2NTl
         YBdCL3h1ObFe2k1nijzfBA9nb1LNGWqdNCieaGagdyF1umas0pSms/FjyYqYL/T5ebMr
         2Man+TRZO2tgFm+nckkZPY+60S6o85EWrBFMz6uXKW7lrP6CHPDujj/Doj0tLG0Dgp2D
         mi6cYtzdK524/pAU2ZQVNrAtSo6Cg6awhANhKPNYhG2B9fN1iXTaV66S3Rkt+CG7ssyI
         rwuA==
X-Gm-Message-State: ANhLgQ3CFQfqUJqUO9lYqL2yPX+ctxFtbCGWiF/kiBt+DfkoyuztBEkM
        ZDBBIqTd8aQ9wh+RyW2uLX0=
X-Google-Smtp-Source: ADFU+vtQrjsY5jOjAkIDA+M4KsUsE/SqVISk2jC+NRTrJtbGitg328vrILJx/ZX3Y6vigixSAU4Jww==
X-Received: by 2002:a63:4864:: with SMTP id x36mr5340075pgk.398.1583268850663;
        Tue, 03 Mar 2020 12:54:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w189sm25407790pfw.157.2020.03.03.12.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 12:54:09 -0800 (PST)
Date:   Tue, 3 Mar 2020 12:54:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH v5 3/3] hwmon: add Gateworks System Controller support
Message-ID: <20200303205408.GA19757@roeck-us.net>
References: <1582577665-13554-1-git-send-email-tharvey@gateworks.com>
 <1582577665-13554-4-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582577665-13554-4-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:54:25PM -0800, Tim Harvey wrote:
> The Gateworks System Controller has a hwmon sub-component that exposes
> up to 16 ADC's, some of which are temperature sensors, others which are
> voltage inputs. The ADC configuration (register mapping and name) is
> configured via device-tree and varies board to board.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Couple of minor comments, otherwise looks good from my perspective.

> 
> v5:
> - fix various checkpatch issues
> - correct gsc-hwmon.rst in MAINTAINERS
> - switch to SENSOR_DEVICE_ATTR_{RW,RO}
> - use tmp value to avoid excessive pointer deference
> - simplify shift operation
> - scale voffset once
> - simplify is_visible function
> - remove empty line at end of file
> 
> v4:
> - adjust for uV offset from device-tree
> - remove unnecessary optional write function
> - remove register range check
> - change dev_err prints to use gsc dev
> - hard-code resolution/scaling for raw adcs
> - describe units of ADC resolution
> - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
> - ensure space before/after operators
> - remove unnecessary parens
> - remove more debugging
> - add default case and comment for type_voltage
> - remove unnecessary index bounds checks for channel
> - remove unnecessary clearing of struct fields
> - added Documentation/hwmon/gsc-hwmon.rst
> 
> v3:
> - add voltage_raw input type and supporting fields
> - add channel validation to is_visible function
> - remove unnecessary channel validation from read/write functions
> 
> v2:
> - change license comment style
> - remove DEBUG
> - simplify regmap_bulk_read err check
> - remove break after returns in switch statement
> - fix fan setpoint buffer address
> - remove unnecessary parens
> - consistently use struct device *dev pointer
> - change license/comment block
> - add validation for hwmon child node props
> - move parsing of of to own function
> - use strlcpy to ensure null termination
> - fix static array sizes and removed unnecessary initializers
> - dynamically allocate channels
> - fix fan input label
> - support platform data
> - fixed whitespace issues
> ---
>  Documentation/hwmon/gsc-hwmon.rst       |  53 +++++
>  Documentation/hwmon/index.rst           |   1 +
>  MAINTAINERS                             |   3 +
>  drivers/hwmon/Kconfig                   |   9 +
>  drivers/hwmon/Makefile                  |   1 +
>  drivers/hwmon/gsc-hwmon.c               | 371 ++++++++++++++++++++++++++++++++
>  include/linux/platform_data/gsc_hwmon.h |  44 ++++
>  7 files changed, 482 insertions(+)
>  create mode 100644 Documentation/hwmon/gsc-hwmon.rst
>  create mode 100644 drivers/hwmon/gsc-hwmon.c
>  create mode 100644 include/linux/platform_data/gsc_hwmon.h
> 
> diff --git a/Documentation/hwmon/gsc-hwmon.rst b/Documentation/hwmon/gsc-hwmon.rst
> new file mode 100644
> index 00000000..d34e508
> --- /dev/null
> +++ b/Documentation/hwmon/gsc-hwmon.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver gsc-hwmon
> +=======================
> +
> +Supported chips: Gateworks GSC
> +Datasheet: http://trac.gateworks.com/wiki/gsc
> +Author: Tim Harvey <tharvey@gateworks.com>
> +
> +Description:
> +------------
> +
> +This driver supports hardware monitoring for the temperature sensor,
> +various ADC's connected to the GSC, and optional FAN controller available
> +on some boards.
> +
> +
> +Voltage Monitoring
> +------------------
> +
> +The voltage inputs are scaled either internally or by the driver depending
> +on the GSC version and firmware. The values returned by the driver do not need
> +further scaling. The voltage input labels provide the voltage rail name:
> +
> +inX_input                  Measured voltage (mV).
> +inX_label                  Name of voltage rail.
> +
> +
> +Temperature Monitoring
> +----------------------
> +
> +Temperatures are measured with 12-bit or 10-bit resolution and are scaled
> +either internally or by the driver depending on the GSC version and firmware.
> +The values returned by the driver reflect millidegree Celcius:
> +
> +tempX_input                Measured temperature.
> +tempX_label                Name of temperature input.
> +
> +
> +PWM Output Control
> +------------------
> +
> +The GSC features 1 PWM output that operates in automatic mode where the
> +PWM value will be scalled depending on 6 temperature boundaries.
> +The tempeature boundaries are read-write and in millidegree Celcius and the
> +read-only PWM values range from 0 (off) to 255 (full speed).
> +Fan speed will be set to minimum (off) when the temperature sensor reads
> +less than pwm1_auto_point1_temp and maximum when the temperature sensor
> +equals or exceeds pwm1_auto_point6_temp.
> +
> +pwm1_auto_point1_pwm       PWM value.
> +pwm1_auto_point1_temp      Temperature boundary.

Should be something like

pwm1_auto_point[1-6]_pwm       PWM value.
pwm1_auto_point[1-6]_temp      Temperature boundary.

> +
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 43cc605..a4fab69 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -58,6 +58,7 @@ Hardware Monitoring Kernel Drivers
>     ftsteutates
>     g760a
>     g762
> +   gsc-hwmon
>     gl518sm
>     hih6130
>     ibmaem
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bb79b60..3f15542 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6846,6 +6846,9 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
>  F:	drivers/mfd/gateworks-gsc.c
>  F:	include/linux/mfd/gsc.h
> +F:	Documentation/hwmon/gsc-hwmon.rst
> +F:	drivers/hwmon/gsc-hwmon.c
> +F:	include/linux/platform_data/gsc_hwmon.h
>  
>  GCC PLUGINS
>  M:	Kees Cook <keescook@chromium.org>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 23dfe84..99dae13 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -494,6 +494,15 @@ config SENSORS_F75375S
>  	  This driver can also be built as a module. If so, the module
>  	  will be called f75375s.
>  
> +config SENSORS_GSC
> +        tristate "Gateworks System Controller ADC"
> +        depends on MFD_GATEWORKS_GSC
> +        help
> +          Support for the Gateworks System Controller A/D converters.
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called gsc-hwmon.
> +
>  config SENSORS_MC13783_ADC
>          tristate "Freescale MC13783/MC13892 ADC"
>          depends on MFD_MC13XXX
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 6db5db9..259cba7 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
>  obj-$(CONFIG_SENSORS_G762)	+= g762.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
> +obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
>  obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
>  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> new file mode 100644
> index 00000000..d9164a6
> --- /dev/null
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Gateworks System Controller Hardware Monitor module
> + *
> + * Copyright (C) 2020 Gateworks Corporation
> + */
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/mfd/gsc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <linux/platform_data/gsc_hwmon.h>
> +
> +#define GSC_HWMON_MAX_TEMP_CH	16
> +#define GSC_HWMON_MAX_IN_CH	16
> +
> +#define GSC_HWMON_RESOLUTION	12
> +#define GSC_HWMON_VREF		2500
> +
> +struct gsc_hwmon_data {
> +	struct gsc_dev *gsc;
> +	struct device *dev;
> +	struct gsc_hwmon_platform_data *pdata;
> +	const struct gsc_hwmon_channel *temp_ch[GSC_HWMON_MAX_TEMP_CH];
> +	const struct gsc_hwmon_channel *in_ch[GSC_HWMON_MAX_IN_CH];
> +	u32 temp_config[GSC_HWMON_MAX_TEMP_CH + 1];
> +	u32 in_config[GSC_HWMON_MAX_IN_CH + 1];
> +	struct hwmon_channel_info temp_info;
> +	struct hwmon_channel_info in_info;
> +	const struct hwmon_channel_info *info[4];

Unless I am missing something, info[3] should be sufficient.

> +	struct hwmon_chip_info chip;
> +};
> +
> +static ssize_t pwm_auto_point_temp_show(struct device *dev,
> +					struct device_attribute *devattr,
> +					char *buf)
> +{
> +	struct gsc_hwmon_data *hwmon = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	u8 reg = hwmon->pdata->fan_base + (2 * attr->index);
> +	u8 regs[2];
> +	int ret;
> +
> +	ret = regmap_bulk_read(hwmon->gsc->regmap_hwmon, reg, regs, 2);
> +	if (ret)
> +		return ret;
> +
> +	ret = regs[0] | regs[1] << 8;
> +	return sprintf(buf, "%d\n", ret * 10);
> +}
> +
> +static ssize_t pwm_auto_point_temp_store(struct device *dev,
> +					 struct device_attribute *devattr,
> +					 const char *buf, size_t count)
> +{
> +	struct gsc_hwmon_data *hwmon = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	u8 reg = hwmon->pdata->fan_base + (2 * attr->index);
> +	u8 regs[2];
> +	long temp;
> +	int err;
> +
> +	if (kstrtol(buf, 10, &temp))
> +		return -EINVAL;
> +
> +	temp = clamp_val(temp, 0, 10000);
> +	temp = DIV_ROUND_CLOSEST(temp, 10);
> +
> +	regs[0] = temp & 0xff;
> +	regs[1] = (temp >> 8) & 0xff;
> +	err = regmap_bulk_write(hwmon->gsc->regmap_hwmon, reg, regs, 2);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static ssize_t pwm_auto_point_pwm_show(struct device *dev,
> +				       struct device_attribute *devattr,
> +				       char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +
> +	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)) / 100);
> +}
> +
> +static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm_auto_point_pwm, 0);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_temp, pwm_auto_point_temp, 0);
> +
> +static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point2_pwm, pwm_auto_point_pwm, 1);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_temp, pwm_auto_point_temp, 1);
> +
> +static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point3_pwm, pwm_auto_point_pwm, 2);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_auto_point_temp, 2);
> +
> +static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point4_pwm, pwm_auto_point_pwm, 3);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_auto_point_temp, 3);
> +
> +static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point5_pwm, pwm_auto_point_pwm, 4);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_auto_point_temp, 4);
> +
> +static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point6_pwm, pwm_auto_point_pwm, 5);
> +static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point6_temp, pwm_auto_point_temp, 5);
> +
> +static struct attribute *gsc_hwmon_attributes[] = {
> +	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point6_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point6_temp.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group gsc_hwmon_group = {
> +	.attrs = gsc_hwmon_attributes,
> +};
> +__ATTRIBUTE_GROUPS(gsc_hwmon);
> +
> +static int
> +gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +	       int channel, long *val)
> +{
> +	struct gsc_hwmon_data *hwmon = dev_get_drvdata(dev);
> +	const struct gsc_hwmon_channel *ch;
> +	int sz, ret;
> +	long tmp;
> +	u8 buf[3];
> +
> +	switch (type) {
> +	case hwmon_in:
> +		ch = hwmon->in_ch[channel];
> +		break;
> +	case hwmon_temp:
> +		ch = hwmon->temp_ch[channel];
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	sz = (ch->type == type_voltage) ? 3 : 2;
> +	ret = regmap_bulk_read(hwmon->gsc->regmap_hwmon, ch->reg, buf, sz);
> +	if (ret)
> +		return ret;
> +
> +	tmp = 0;
> +	while (sz-- > 0)
> +		tmp |= (buf[sz] << (8 * sz));
> +
> +	switch (ch->type) {
> +	case type_temperature:
> +		if (tmp > 0x8000)
> +			tmp -= 0xffff;
> +		break;
> +	case type_voltage_raw:
> +		tmp = clamp_val(tmp, 0, BIT(GSC_HWMON_RESOLUTION));
> +		/* scale based on ref voltage and ADC resolution */
> +		tmp *= GSC_HWMON_VREF;
> +		tmp >>= GSC_HWMON_RESOLUTION;
> +		/* scale based on optional voltage divider */
> +		if (ch->vdiv[0] && ch->vdiv[1]) {
> +			tmp *= (ch->vdiv[0] + ch->vdiv[1]);
> +			tmp /= ch->vdiv[1];
> +		}
> +		/* adjust by uV offset */
> +		tmp += ch->mvoffset;
> +		break;
> +	case type_voltage:
> +		/* no adjustment needed */
> +		break;
> +	}
> +
> +	*val = tmp;
> +
> +	return 0;
> +}
> +
> +static int
> +gsc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> +		      u32 attr, int channel, const char **buf)
> +{
> +	struct gsc_hwmon_data *hwmon = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_in:
> +		*buf = hwmon->in_ch[channel]->name;
> +		break;
> +	case hwmon_temp:
> +		*buf = hwmon->temp_ch[channel]->name;
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static umode_t
> +gsc_hwmon_is_visible(const void *_data, enum hwmon_sensor_types type, u32 attr,
> +		     int ch)
> +{
> +	return 0444;
> +}
> +
> +static const struct hwmon_ops gsc_hwmon_ops = {
> +	.is_visible = gsc_hwmon_is_visible,
> +	.read = gsc_hwmon_read,
> +	.read_string = gsc_hwmon_read_string,
> +};
> +
> +static struct gsc_hwmon_platform_data *
> +gsc_hwmon_get_devtree_pdata(struct device *dev)
> +{
> +	struct gsc_hwmon_platform_data *pdata;
> +	struct gsc_hwmon_channel *ch;
> +	struct fwnode_handle *child;
> +	const char *type;
> +	int nchannels;
> +
> +	nchannels = device_get_child_node_count(dev);
> +	if (nchannels == 0)
> +		return ERR_PTR(-ENODEV);
> +
> +	pdata = devm_kzalloc(dev,
> +			     sizeof(*pdata) + nchannels * sizeof(*ch),
> +			     GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +	ch = (struct gsc_hwmon_channel *)(pdata + 1);
> +	pdata->channels = ch;
> +	pdata->nchannels = nchannels;
> +
> +	device_property_read_u32(dev, "gw,fan-base", &pdata->fan_base);
> +
> +	/* allocate structures for channels and count instances of each type */
> +	device_for_each_child_node(dev, child) {
> +		if (fwnode_property_read_string(child, "label", &ch->name)) {
> +			dev_err(dev, "channel without label\n");
> +			fwnode_handle_put(child);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		if (fwnode_property_read_u32(child, "reg", &ch->reg)) {
> +			dev_err(dev, "channel without reg\n");
> +			fwnode_handle_put(child);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		if (fwnode_property_read_string(child, "type", &type)) {
> +			dev_err(dev, "channel without type\n");
> +			fwnode_handle_put(child);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		if (!strcasecmp(type, "temperature")) {
> +			ch->type = type_temperature;
> +		} else if (!strcasecmp(type, "voltage")) {
> +			ch->type = type_voltage;
> +		} else if (!strcasecmp(type, "voltage-raw")) {
> +			ch->type = type_voltage_raw;
> +		} else {
> +			dev_err(dev, "channel without type\n");
> +			fwnode_handle_put(child);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		if (fwnode_property_read_u32(child, "gw,voltage-offset",
> +					     &ch->mvoffset))
> +			ch->mvoffset /= 1000;
> +		fwnode_property_read_u32_array(child, "gw,voltage-divider",
> +					       ch->vdiv, ARRAY_SIZE(ch->vdiv));
> +		ch++;
> +	}
> +
> +	return pdata;
> +}
> +
> +static int gsc_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct gsc_dev *gsc = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct gsc_hwmon_platform_data *pdata = dev_get_platdata(dev);
> +	struct gsc_hwmon_data *hwmon;
> +	const struct attribute_group **groups;
> +	int i, i_in, i_temp;
> +
> +	if (!pdata) {
> +		pdata = gsc_hwmon_get_devtree_pdata(dev);
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);
> +	}
> +
> +	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +	hwmon->gsc = gsc;
> +	hwmon->pdata = pdata;
> +
> +	for (i = 0, i_in = 0, i_temp = 0; i < hwmon->pdata->nchannels; i++) {
> +		const struct gsc_hwmon_channel *ch = &pdata->channels[i];
> +
> +		switch (ch->type) {
> +		case type_temperature:
> +			if (i_temp == GSC_HWMON_MAX_TEMP_CH) {
> +				dev_err(gsc->dev, "too many temp channels\n");
> +				return -EINVAL;
> +			}
> +			hwmon->temp_ch[i_temp] = ch;
> +			hwmon->temp_config[i_temp] = HWMON_T_INPUT |
> +						     HWMON_T_LABEL;
> +			i_temp++;
> +			break;
> +		case type_voltage:
> +		case type_voltage_raw:
> +			if (i_in == GSC_HWMON_MAX_IN_CH) {
> +				dev_err(gsc->dev, "too many input channels\n");
> +				return -EINVAL;
> +			}
> +			hwmon->in_ch[i_in] = ch;
> +			hwmon->in_config[i_in] =
> +				HWMON_I_INPUT | HWMON_I_LABEL;
> +			i_in++;
> +			break;
> +		default:
> +			dev_err(gsc->dev, "invalid type: %d\n", ch->type);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* setup config structures */
> +	hwmon->chip.ops = &gsc_hwmon_ops;
> +	hwmon->chip.info = hwmon->info;
> +	hwmon->info[0] = &hwmon->temp_info;
> +	hwmon->info[1] = &hwmon->in_info;
> +	hwmon->temp_info.type = hwmon_temp;
> +	hwmon->temp_info.config = hwmon->temp_config;
> +	hwmon->in_info.type = hwmon_in;
> +	hwmon->in_info.config = hwmon->in_config;
> +
> +	groups = pdata->fan_base ? gsc_hwmon_groups : NULL;
> +	hwmon->dev = devm_hwmon_device_register_with_info(dev,
> +							  KBUILD_MODNAME, hwmon,
> +							  &hwmon->chip, groups);
> +	return PTR_ERR_OR_ZERO(hwmon->dev);
> +}
> +
> +static const struct of_device_id gsc_hwmon_of_match[] = {
> +	{ .compatible = "gw,gsc-hwmon", },
> +	{}
> +};
> +
> +static struct platform_driver gsc_hwmon_driver = {
> +	.driver = {
> +		.name = "gsc-hwmon",
> +		.of_match_table = gsc_hwmon_of_match,
> +	},
> +	.probe = gsc_hwmon_probe,
> +};
> +
> +module_platform_driver(gsc_hwmon_driver);
> +
> +MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
> +MODULE_DESCRIPTION("GSC hardware monitor driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/platform_data/gsc_hwmon.h b/include/linux/platform_data/gsc_hwmon.h
> new file mode 100644
> index 00000000..09465f8
> --- /dev/null
> +++ b/include/linux/platform_data/gsc_hwmon.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _GSC_HWMON_H
> +#define _GSC_HWMON_H
> +
> +enum gsc_hwmon_type {
> +	type_temperature,
> +	type_voltage,
> +	type_voltage_raw,
> +	type_fan,
> +};
> +
> +/**
> + * struct gsc_hwmon_channel - configuration parameters
> + * @reg:  I2C register offset
> + * @type: channel type
> + * @name: channel name
> + * @mvoffset: voltage offset
> + * @vdiv: voltage divider array (2 resistor values in ohms)
> + */
> +struct gsc_hwmon_channel {
> +	unsigned int reg;
> +	unsigned int type;
> +	const char *name;
> +	unsigned int mvoffset;
> +	unsigned int vdiv[2];
> +};
> +
> +/**
> + * struct gsc_hwmon_platform_data - platform data for gsc_hwmon driver
> + * @channels:	pointer to array of gsc_hwmon_channel structures
> + *		describing channels
> + * @nchannels:	number of elements in @channels array
> + * @vreference: voltage reference (mV)
> + * @resolution: ADC bit resolution
> + * @fan_base: register base for FAN controller
> + */
> +struct gsc_hwmon_platform_data {
> +	const struct gsc_hwmon_channel *channels;
> +	int nchannels;
> +	unsigned int resolution;
> +	unsigned int vreference;
> +	unsigned int fan_base;
> +};
> +#endif
