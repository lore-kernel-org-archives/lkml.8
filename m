Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD10C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63CE2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mx/bBt+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgCZKQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:16:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33951 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgCZKQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:16:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so7054321wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0jv7aTAQt4PtlIzMdsxP/46wwXr8QNQT/7lw7aX9Xgo=;
        b=mx/bBt+B3myaRbIL/NgUzsfyjQXBQQU1bNVAFaQWleq6IYuny40MQufhDZf3jsUvSH
         wMnOmTCazwHuhXBEUGeHoHCipVXJaY56sMYZuWGigSL8gF2O6QJC5JdQeG4pAtlisbgc
         sbcEPA53kg+Ih4aC4I2SH2CA21Vr94p7ZAiG3yzHXXvmmtnA3/hT0vWUIN9yWFaBjldW
         FPGNij2fqvflOW5tM6xFtN5qfnAQLTKbB8L/9mLyFRIV9LpdiIXep4MGeSgoEWFw1r0u
         NpA3QCgPsLgIV/4NTB7LB0MZiyNizMrJfl93ckvkFUnbLpaisK6cGoHCHBIJ7MTPB2C7
         JQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0jv7aTAQt4PtlIzMdsxP/46wwXr8QNQT/7lw7aX9Xgo=;
        b=HLHjNpylKc8wQshrc8GQOStKXwmGsgu4CYi0dSUAmtAMEkFsaTPLxQcURa9WydFhed
         CgHPWJzQ30S0RyoEy7IYi5AwNVjLEulFDHGPsbPt0J9f4GoWEPahHFESLBFTa1r15bX9
         x0pHST2wnrGRXXflpSuJ70k/cWpdlO56wr0h2V4/loutd6u4D0RHdkF1jPwKCYdqkMBl
         +lYni2Dj6reOxx7ZF2tBUE+WnYfkV+S6u1y7juBQlS9E4rh5CTGauyuJlctOWfr/efeQ
         czgQic4l+yyI5KVrdzRu4yON+w+Au7nC8lI9f6SAWqL7GjIe5v+gxTl/t6bnxyzhw2N3
         rFfg==
X-Gm-Message-State: ANhLgQ1FzM2MtArafSbs0li5vG9MFoiU4DGs4+m1mc8gzRvT7saHaJ0k
        qWlsa8GS5zCR8IeANi53WmlYkg==
X-Google-Smtp-Source: ADFU+vtqzxwwJ06lGVwTKd7nfcAtX+3y4FhBLYHXAU0fnj+sVSvjhv31D1NPuJhLDxpAaazaysuI0g==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5mr8108919wrt.136.1585217773352;
        Thu, 26 Mar 2020 03:16:13 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id n2sm3183524wro.25.2020.03.26.03.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 03:16:12 -0700 (PDT)
Date:   Thu, 26 Mar 2020 10:17:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 2/3] mfd: add Gateworks System Controller core driver
Message-ID: <20200326101702.GD603801@dell>
References: <1584736550-7520-1-git-send-email-tharvey@gateworks.com>
 <1584736550-7520-3-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1584736550-7520-3-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020, Tim Harvey wrote:

> The Gateworks System Controller (GSC) is an I2C slave controller
> implemented with an MSP430 micro-controller whose firmware embeds the
> following features:
>  - I/O expander (16 GPIO's) using PCA955x protocol
>  - Real Time Clock using DS1672 protocol
>  - User EEPROM using AT24 protocol
>  - HWMON using custom protocol
>  - Interrupt controller with tamper detect, user pushbotton
>  - Watchdog controller capable of full board power-cycle
>  - Power Control capable of full board power-cycle
> 
> see http://trac.gateworks.com/wiki/gsc for more details
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v7:
> - remove irq from private data struct
> 
> v6:
> - remove duplicate signature and fix commit log
> 
> v5:
> - simplify powerdown function
> 
> v4:
> - remove hwmon max reg check/define
> - fix powerdown function
> 
> v3:
> - rename gsc->gateworks-gsc
> - remove uncecessary include for linux/mfd/core.h
> - upercase I2C in comments
> - remove i2c debug
> - remove uncecessary comments
> - don't use KBUILD_MODNAME for name
> - remove unnecessary v1/v2/v3 tracking
> - unregister hwmon i2c adapter on remove
> 
> v2:
> - change license comment block style
> - remove COMPILE_TEST (Randy)
> - fixed whitespace issues
> - replaced a printk with dev_err
> ---
>  MAINTAINERS                 |   8 ++
>  drivers/mfd/Kconfig         |  10 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/gateworks-gsc.c | 291 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/gsc.h     |  71 +++++++++++
>  5 files changed, 381 insertions(+)
>  create mode 100644 drivers/mfd/gateworks-gsc.c
>  create mode 100644 include/linux/mfd/gsc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56765f5..bb79b60 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6839,6 +6839,14 @@ F:	tools/testing/selftests/futex/
>  F:	tools/perf/bench/futex*
>  F:	Documentation/*futex*
>  
> +GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
> +M:	Tim Harvey <tharvey@gateworks.com>
> +M:	Robert Jones <rjones@gateworks.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> +F:	drivers/mfd/gateworks-gsc.c
> +F:	include/linux/mfd/gsc.h
> +
>  GCC PLUGINS
>  M:	Kees Cook <keescook@chromium.org>
>  R:	Emese Revfy <re.emese@gmail.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 4209008..d84725a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -407,6 +407,16 @@ config MFD_EXYNOS_LPASS
>  	  Select this option to enable support for Samsung Exynos Low Power
>  	  Audio Subsystem.
>  
> +config MFD_GATEWORKS_GSC
> +	tristate "Gateworks System Controller"
> +	depends on (I2C && OF)
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Enable support for the Gateworks System Controller found
> +	  on Gateworks Single Board Computers.

Please describe which sub-devices are attached.

>  config MFD_MC13XXX
>  	tristate
>  	depends on (SPI_MASTER || I2C)
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index aed99f0..c82b442 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
>  obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
>  obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
> +obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
>  
>  obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
>  obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
> diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
> new file mode 100644
> index 00000000..8566123
> --- /dev/null
> +++ b/drivers/mfd/gateworks-gsc.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The Gateworks System Controller (GSC) is a multi-function
> + * device designed for use in Gateworks Single Board Computers.
> + * The control interface is I2C, with an interrupt. The device supports
> + * system functions such as pushbutton monitoring, multiple ADC's for
> + * voltage and temperature, fan controller, and watchdog monitor.

When are you planning on adding support for the other devices?

> + * Copyright (C) 2020 Gateworks Corporation
> + *

Superfluous '\n'.

> + */
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/gsc.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * The GSC suffers from an errata where occasionally during
> + * ADC cycles the chip can NAK I2C transactions. To ensure we have reliable
> + * register access we place retries around register access.
> + */
> +#define I2C_RETRIES	3
> +
> +static int gsc_regmap_regwrite(void *context, unsigned int reg,
> +			       unsigned int val)
> +{
> +	struct i2c_client *client = context;
> +	int retry, ret;
> +
> +	for (retry = 0; retry < I2C_RETRIES; retry++) {
> +		ret = i2c_smbus_write_byte_data(client, reg, val);
> +		/*
> +		 * -EAGAIN returned when the i2c host controller is busy
> +		 * -EIO returned when i2c device is busy
> +		 */
> +		if (ret != -EAGAIN && ret != -EIO)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gsc_regmap_regread(void *context, unsigned int reg,
> +			      unsigned int *val)
> +{
> +	struct i2c_client *client = context;
> +	int retry, ret;
> +
> +	for (retry = 0; retry < I2C_RETRIES; retry++) {
> +		ret = i2c_smbus_read_byte_data(client, reg);
> +		/*
> +		 * -EAGAIN returned when the i2c host controller is busy
> +		 * -EIO returned when i2c device is busy
> +		 */
> +		if (ret != -EAGAIN && ret != -EIO)
> +			break;
> +	}
> +	*val = ret & 0xff;
> +
> +	return 0;
> +}
> +
> +static struct regmap_bus regmap_gsc = {
> +	.reg_write = gsc_regmap_regwrite,
> +	.reg_read = gsc_regmap_regread,
> +};
> +
> +/*
> + * gsc_powerdown - API to use GSC to power down board for a specific time
> + *
> + * secs - number of seconds to remain powered off
> + */
> +static int gsc_powerdown(struct gsc_dev *gsc, unsigned long secs)
> +{
> +	int ret;
> +	unsigned char regs[4];

No error checking?  Could be down for a very long time.

> +	dev_info(&gsc->i2c->dev, "GSC powerdown for %ld seconds\n",
> +		 secs);

Nit: '\n' here.

> +	regs[0] = secs & 0xff;
> +	regs[1] = (secs >> 8) & 0xff;
> +	regs[2] = (secs >> 16) & 0xff;
> +	regs[3] = (secs >> 24) & 0xff;

Nit: '\n' here.

> +	ret = regmap_bulk_write(gsc->regmap, GSC_TIME_ADD, regs, 4);
> +	if (ret)
> +		return ret;

Nit: '\n' here.

> +	regs[0] = 1 << GSC_CTRL_1_LATCH_SLEEP_ADD;

Nit: '\n' here.

> +	ret = regmap_update_bits(gsc->regmap, GSC_CTRL_1, regs[0], regs[0]);
> +	if (ret)
> +		return ret;

Nit: '\n' here.

> +	regs[0] = (1 << GSC_CTRL_1_ACTIVATE_SLEEP) |
> +		(1 << GSC_CTRL_1_SLEEP_ENABLE);

Nit: '\n' here.

> +	ret = regmap_update_bits(gsc->regmap, GSC_CTRL_1, regs[0], regs[0]);
> +
> +	return ret;
> +}
> +
> +static ssize_t gsc_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct gsc_dev *gsc = dev_get_drvdata(dev);
> +	const char *name = attr->attr.name;
> +	int rz = 0;
> +
> +	if (strcasecmp(name, "fw_version") == 0)
> +		rz = sprintf(buf, "%d\n", gsc->fwver);
> +	else if (strcasecmp(name, "fw_crc") == 0)
> +		rz = sprintf(buf, "0x%04x\n", gsc->fwcrc);

No error message for non-matched commands?

> +	return rz;
> +}
> +
> +static ssize_t gsc_store(struct device *dev, struct device_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	struct gsc_dev *gsc = dev_get_drvdata(dev);
> +	const char *name = attr->attr.name;
> +	long value;
> +
> +	if (strcasecmp(name, "powerdown") == 0) {
> +		if (kstrtol(buf, 0, &value) == 0)
> +			gsc_powerdown(gsc, value);
> +	} else {
> +		dev_err(dev, "invalid name '%s\n", name);
> +	}

Name?  Isn't it more of a command?

> +	return count;
> +}
> +
> +static struct device_attribute attr_fwver =
> +	__ATTR(fw_version, 0440, gsc_show, NULL);
> +static struct device_attribute attr_fwcrc =
> +	__ATTR(fw_crc, 0440, gsc_show, NULL);
> +static struct device_attribute attr_pwrdown =
> +	__ATTR(powerdown, 0220, NULL, gsc_store);
> +
> +static struct attribute *gsc_attrs[] = {
> +	&attr_fwver.attr,
> +	&attr_fwcrc.attr,
> +	&attr_pwrdown.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group attr_group = {
> +	.attrs = gsc_attrs,
> +};
> +
> +static const struct of_device_id gsc_of_match[] = {
> +	{ .compatible = "gw,gsc", },
> +	{ }
> +};
> +
> +static const struct regmap_config gsc_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_NONE,
> +	.max_register = 0xf,
> +};
> +
> +static const struct regmap_config gsc_regmap_hwmon_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static const struct regmap_irq gsc_irqs[] = {
> +	REGMAP_IRQ_REG(GSC_IRQ_PB, 0, BIT(GSC_IRQ_PB)),
> +	REGMAP_IRQ_REG(GSC_IRQ_KEY_ERASED, 0, BIT(GSC_IRQ_KEY_ERASED)),
> +	REGMAP_IRQ_REG(GSC_IRQ_EEPROM_WP, 0, BIT(GSC_IRQ_EEPROM_WP)),
> +	REGMAP_IRQ_REG(GSC_IRQ_RESV, 0, BIT(GSC_IRQ_RESV)),
> +	REGMAP_IRQ_REG(GSC_IRQ_GPIO, 0, BIT(GSC_IRQ_GPIO)),
> +	REGMAP_IRQ_REG(GSC_IRQ_TAMPER, 0, BIT(GSC_IRQ_TAMPER)),
> +	REGMAP_IRQ_REG(GSC_IRQ_WDT_TIMEOUT, 0, BIT(GSC_IRQ_WDT_TIMEOUT)),
> +	REGMAP_IRQ_REG(GSC_IRQ_SWITCH_HOLD, 0, BIT(GSC_IRQ_SWITCH_HOLD)),
> +};
> +
> +static const struct regmap_irq_chip gsc_irq_chip = {
> +	.name = "gateworks-gsc",
> +	.irqs = gsc_irqs,
> +	.num_irqs = ARRAY_SIZE(gsc_irqs),
> +	.num_regs = 1,
> +	.status_base = GSC_IRQ_STATUS,
> +	.mask_base = GSC_IRQ_ENABLE,
> +	.mask_invert = true,
> +	.ack_base = GSC_IRQ_STATUS,
> +	.ack_invert = true,
> +};
> +
> +static int

Break the arguments instead.

> +gsc_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct gsc_dev *gsc;
> +	int ret;
> +	unsigned int reg;
> +
> +	gsc = devm_kzalloc(dev, sizeof(*gsc), GFP_KERNEL);
> +	if (!gsc)
> +		return -ENOMEM;
> +
> +	gsc->dev = &client->dev;
> +	gsc->i2c = client;
> +	i2c_set_clientdata(client, gsc);
> +
> +	gsc->regmap = devm_regmap_init(dev, &regmap_gsc, client,
> +				       &gsc_regmap_config);
> +	if (IS_ERR(gsc->regmap))
> +		return PTR_ERR(gsc->regmap);
> +
> +	if (regmap_read(gsc->regmap, GSC_FW_VER, &reg))
> +		return -EIO;
> +	gsc->fwver = reg;

You not checking this for a valid value?

> +	regmap_read(gsc->regmap, GSC_FW_CRC, &reg);
> +	gsc->fwcrc = reg;
> +	regmap_read(gsc->regmap, GSC_FW_CRC + 1, &reg);
> +	gsc->fwcrc |= reg << 8;
> +
> +	gsc->i2c_hwmon = i2c_new_dummy_device(client->adapter, GSC_HWMON);
> +	if (!gsc->i2c_hwmon) {
> +		dev_err(dev, "Failed to allocate I2C device for HWMON\n");
> +		return -ENODEV;
> +	}
> +	i2c_set_clientdata(gsc->i2c_hwmon, gsc);
> +
> +	gsc->regmap_hwmon = devm_regmap_init(dev, &regmap_gsc, gsc->i2c_hwmon,
> +					     &gsc_regmap_hwmon_config);
> +	if (IS_ERR(gsc->regmap_hwmon)) {
> +		ret = PTR_ERR(gsc->regmap_hwmon);
> +		dev_err(dev, "failed to allocate register map: %d\n", ret);
> +		goto err_regmap;
> +	}

Why can't the HWMON driver fetch its own Regmap?

> +	ret = devm_regmap_add_irq_chip(dev, gsc->regmap, client->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED |
> +				       IRQF_TRIGGER_FALLING, 0,
> +				       &gsc_irq_chip, &gsc->irq_chip_data);
> +	if (ret)
> +		goto err_regmap;
> +
> +	dev_info(dev, "Gateworks System Controller v%d: fw 0x%04x\n",
> +		 gsc->fwver, gsc->fwcrc);
> +
> +	ret = sysfs_create_group(&dev->kobj, &attr_group);
> +	if (ret)
> +		dev_err(dev, "failed to create sysfs attrs\n");
> +
> +	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);

devm_*?

> +	if (ret)
> +		goto err_sysfs;
> +
> +	return 0;
> +
> +err_sysfs:
> +	sysfs_remove_group(&dev->kobj, &attr_group);
> +err_regmap:
> +	i2c_unregister_device(gsc->i2c_hwmon);
> +
> +	return ret;
> +}
> +
> +static int gsc_remove(struct i2c_client *client)
> +{
> +	struct gsc_dev *gsc = i2c_get_clientdata(client);
> +
> +	sysfs_remove_group(&client->dev.kobj, &attr_group);
> +	i2c_unregister_device(gsc->i2c_hwmon);
> +
> +	return 0;
> +}
> +
> +static struct i2c_driver gsc_driver = {
> +	.driver = {
> +		.name	= "gateworks-gsc",
> +		.of_match_table = of_match_ptr(gsc_of_match),
> +	},
> +	.probe		= gsc_probe,

I think you need to use .probe_new OR supply an I2C device table.  Not
sure why/how this is working for you currently.

> +	.remove		= gsc_remove,
> +};
> +
> +module_i2c_driver(gsc_driver);
> +
> +MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
> +MODULE_DESCRIPTION("I2C Core interface for GSC");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/gsc.h b/include/linux/mfd/gsc.h
> new file mode 100644
> index 00000000..a04e613
> --- /dev/null
> +++ b/include/linux/mfd/gsc.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2018 Gateworks Corporation

This is out of date.

> + */
> +#ifndef __LINUX_MFD_GSC_H_
> +#define __LINUX_MFD_GSC_H_
> +
> +/* Device Addresses */
> +#define GSC_MISC	0x20
> +#define GSC_UPDATE	0x21
> +#define GSC_GPIO	0x23
> +#define GSC_HWMON	0x29
> +#define GSC_EEPROM0	0x50
> +#define GSC_EEPROM1	0x51
> +#define GSC_EEPROM2	0x52
> +#define GSC_EEPROM3	0x53
> +#define GSC_RTC		0x68
> +
> +/* Register offsets */
> +#define GSC_CTRL_0	0x00
> +#define GSC_CTRL_1	0x01
> +#define GSC_TIME	0x02
> +#define GSC_TIME_ADD	0x06
> +#define GSC_IRQ_STATUS	0x0A
> +#define GSC_IRQ_ENABLE	0x0B
> +#define GSC_FW_CRC	0x0C
> +#define GSC_FW_VER	0x0E
> +#define GSC_WP		0x0F
> +
> +/* Bit definitions */
> +#define GSC_CTRL_0_PB_HARD_RESET	0
> +#define GSC_CTRL_0_PB_CLEAR_SECURE_KEY	1
> +#define GSC_CTRL_0_PB_SOFT_POWER_DOWN	2
> +#define GSC_CTRL_0_PB_BOOT_ALTERNATE	3
> +#define GSC_CTRL_0_PERFORM_CRC		4
> +#define GSC_CTRL_0_TAMPER_DETECT	5
> +#define GSC_CTRL_0_SWITCH_HOLD		6
> +
> +#define GSC_CTRL_1_SLEEP_ENABLE		0
> +#define GSC_CTRL_1_ACTIVATE_SLEEP	1
> +#define GSC_CTRL_1_LATCH_SLEEP_ADD	2
> +#define GSC_CTRL_1_SLEEP_NOWAKEPB	3
> +#define GSC_CTRL_1_WDT_TIME		4
> +#define GSC_CTRL_1_WDT_ENABLE		5
> +#define GSC_CTRL_1_SWITCH_BOOT_ENABLE	6
> +#define GSC_CTRL_1_SWITCH_BOOT_CLEAR	7
> +
> +#define GSC_IRQ_PB			0
> +#define GSC_IRQ_KEY_ERASED		1
> +#define GSC_IRQ_EEPROM_WP		2
> +#define GSC_IRQ_RESV			3
> +#define GSC_IRQ_GPIO			4
> +#define GSC_IRQ_TAMPER			5
> +#define GSC_IRQ_WDT_TIMEOUT		6
> +#define GSC_IRQ_SWITCH_HOLD		7
> +
> +struct gsc_dev {
> +	struct device *dev;
> +
> +	struct i2c_client *i2c;		/* 0x20: interrupt controller, WDT */
> +	struct i2c_client *i2c_hwmon;	/* 0x29: hwmon, fan controller */
> +
> +	struct regmap *regmap;
> +	struct regmap *regmap_hwmon;
> +	struct regmap_irq_chip_data *irq_chip_data;
> +
> +	unsigned int fwver;
> +	unsigned short fwcrc;
> +};
> +
> +#endif /* __LINUX_MFD_GSC_H_ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
