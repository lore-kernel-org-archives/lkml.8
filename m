Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8B2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6558420768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvwuxmj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbgFXVKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388749AbgFXVKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:10:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA713C061573;
        Wed, 24 Jun 2020 14:10:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cm23so1766870pjb.5;
        Wed, 24 Jun 2020 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/eiwI1eGlw5Yv/W0V/S+2e3gbq80QMsr1vAJ9YkSwVk=;
        b=Xvwuxmj2iQDNUKKjDTIqIAu6fZ+stY6McugP2B54qu1N7oEoLEOCueH1Gsp801kIiD
         q6nsT96rBUvSj6fOUVDUU6nkt0JacEuQMAeQBWRfoT3DZK9KvAghar2F0u/FBZxhufvX
         2qiMPClEd6PGrpi+I2Imry5467U+ehY+z88sjuPbXavayx2Q7f58vjd+9hW6wRMLCvC1
         /duw0dNh7fqVh9b80es9Yk6noeCaD9GHLHsQBWYIDWtbEBGKSRG93+WvcQqckY3pNRyo
         jQkSLtXcu0TaJj6unTdwEMe/HziJ2RAShMb+5J+KXsUHbssx6KExaa+J1T7tBPtKXB40
         S7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/eiwI1eGlw5Yv/W0V/S+2e3gbq80QMsr1vAJ9YkSwVk=;
        b=rEHCmvslLizcJa1g30JK1ACE5S/5TVudp36WEtYDJZJiwCQZsE57Eo8t9e9RhByVXl
         ONCMA2SBLgBCuAJfHuaDYxziRtlOCAKQaof8RXCS8fRbOnQ0dtiDmItfWlVphx/zPtoA
         PYjVDk0PkIq6+eqQaaHbIcPOC+nZJBHw6oDHH8/DfSpf74F2iKyVmU3CwIPtXkWw+ddI
         HnDOYxnx079Hn8P87fZ/zpTRgVakvbKrOi2Tk12RTC0KTD3G095dK51jrR3U4UpUpYfu
         tjZShRQ+pMaNFhL2UUC7ZQxrbidy0K2SQvBwnof10J0UNNojOlZVx1WdGdEcgzeOTKlB
         NowQ==
X-Gm-Message-State: AOAM531Irt/0DkeLCtY2wbYk4yOUowBHFz1q8JrcRFkZa+MyhZZnDY82
        8G2aynbDBC/ZHwDEfCmQErE=
X-Google-Smtp-Source: ABdhPJybmXXFlZ8AhuIjBfTS+0JjnixQMHnBIuXtWZkkRNHD0uqvco3gh2AjNP+Xw9uTmHbVcCIRHw==
X-Received: by 2002:a17:902:bcc1:: with SMTP id o1mr26623226pls.246.1593033040342;
        Wed, 24 Jun 2020 14:10:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14sm2987858pfb.186.2020.06.24.14.10.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 14:10:39 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:10:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 3/3] hwmon: sparx5: Add Sparx5 SoC temperature driver
Message-ID: <20200624211038.GA72859@roeck-us.net>
References: <20200618135951.25441-1-lars.povlsen@microchip.com>
 <20200618135951.25441-4-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618135951.25441-4-lars.povlsen@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 03:59:51PM +0200, Lars Povlsen wrote:
> This patch adds a temperature sensor driver to the Sparx5 SoC.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

Sorry for the long delay.

We'll still need approval from DT for DT properties.

> ---
>  Documentation/hwmon/sparx5-temp.rst |  33 ++++++

Nitpick: The new file needs to be added to index.rst.

Other than that, for my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>  drivers/hwmon/Kconfig               |  10 ++
>  drivers/hwmon/Makefile              |   1 +
>  drivers/hwmon/sparx5-temp.c         | 168 ++++++++++++++++++++++++++++
>  4 files changed, 212 insertions(+)
>  create mode 100644 Documentation/hwmon/sparx5-temp.rst
>  create mode 100644 drivers/hwmon/sparx5-temp.c
> 
> diff --git a/Documentation/hwmon/sparx5-temp.rst b/Documentation/hwmon/sparx5-temp.rst
> new file mode 100644
> index 0000000000000..0140809089542
> --- /dev/null
> +++ b/Documentation/hwmon/sparx5-temp.rst
> @@ -0,0 +1,33 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Microchip SparX-5 SoC
> +=====================
> +
> +Supported chips:
> +
> +  * VSC7546, VSC7549, VSC755, VSC7556, and VSC7558 (Sparx5 series)
> +
> +    Prefix: 'sparx5-temp'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: Provided by Microchip upon request and under NDA
> +
> +Author: Lars Povlsen <lars.povlsen@microchip.com>
> +
> +Description
> +-----------
> +
> +The Sparx5 SoC contains a temperature sensor based on the MR74060
> +Moortec IP.
> +
> +The sensor has a range of -40°C to +125°C and an accuracy of +/-5°C.
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported.
> +
> +======================= ========================================================
> +temp1_input		Die temperature (in millidegree Celsius.)
> +======================= ========================================================
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 288ae9f63588c..7fb5e0c6c6306 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -515,6 +515,16 @@ config SENSORS_I5K_AMB
>  	  This driver can also be built as a module. If so, the module
>  	  will be called i5k_amb.
>  
> +config SENSORS_SPARX5
> +	tristate "Sparx5 SoC temperature sensor"
> +	depends on ARCH_SPARX5 || COMPILE_TEST
> +	help
> +	  If you say yes here you get support for temperature monitoring
> +	  with the Microchip Sparx5 SoC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called sparx5-temp.
> +
>  config SENSORS_F71805F
>  	tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
>  	depends on !PPC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 3e32c21f5efe3..857293f650412 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -167,6 +167,7 @@ obj-$(CONFIG_SENSORS_SMM665)	+= smm665.o
>  obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
>  obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>  obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
> +obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>  obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
>  obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>  obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
> diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
> new file mode 100644
> index 0000000000000..7d7a060259a80
> --- /dev/null
> +++ b/drivers/hwmon/sparx5-temp.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Sparx5 SoC temperature sensor driver
> + *
> + * Copyright (C) 2020 Lars Povlsen <lars.povlsen@microchip.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/hwmon.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define TEMP_CTRL		0
> +#define TEMP_CFG		4
> +#define  TEMP_CFG_CYCLES	GENMASK(24, 15)
> +#define  TEMP_CFG_ENA		BIT(0)
> +#define TEMP_STAT		8
> +#define  TEMP_STAT_VALID	BIT(12)
> +#define  TEMP_STAT_TEMP		GENMASK(11, 0)
> +
> +struct s5_hwmon {
> +	void __iomem *base;
> +	struct clk *clk;
> +};
> +
> +static void s5_temp_clk_disable(void *data)
> +{
> +	struct clk *clk = data;
> +
> +	clk_disable_unprepare(clk);
> +}
> +
> +static void s5_temp_enable(struct s5_hwmon *hwmon)
> +{
> +	u32 val = readl(hwmon->base + TEMP_CFG);
> +	u32 clk = clk_get_rate(hwmon->clk) / USEC_PER_SEC;
> +
> +	val &= ~TEMP_CFG_CYCLES;
> +	val |= FIELD_PREP(TEMP_CFG_CYCLES, clk);
> +	val |= TEMP_CFG_ENA;
> +
> +	writel(val, hwmon->base + TEMP_CFG);
> +}
> +
> +static int s5_read(struct device *dev, enum hwmon_sensor_types type,
> +		   u32 attr, int channel, long *temp)
> +{
> +	struct s5_hwmon *hwmon = dev_get_drvdata(dev);
> +	int rc = 0, value;
> +	u32 stat;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		stat = readl_relaxed(hwmon->base + TEMP_STAT);
> +		if (!(stat & TEMP_STAT_VALID))
> +			return -EIO;
> +		value = stat & TEMP_STAT_TEMP;
> +		/*
> +		 * From register documentation:
> +		 * Temp(C) = TEMP_SENSOR_STAT.TEMP / 4096 * 352.2 - 109.4
> +		 */
> +		value = DIV_ROUND_CLOSEST(value * 3522, 4096) - 1094;
> +		/*
> +		 * Scale down by 10 from above and multiply by 1000 to
> +		 * have millidegrees as specified by the hwmon sysfs
> +		 * interface.
> +		 */
> +		value *= 100;
> +		*temp = value;
> +		break;
> +	default:
> +		rc = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static umode_t s5_is_visible(const void *_data, enum hwmon_sensor_types type,
> +			     u32 attr, int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct hwmon_channel_info *s5_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops s5_hwmon_ops = {
> +	.is_visible = s5_is_visible,
> +	.read = s5_read,
> +};
> +
> +static const struct hwmon_chip_info s5_chip_info = {
> +	.ops = &s5_hwmon_ops,
> +	.info = s5_info,
> +};
> +
> +static int s5_temp_probe(struct platform_device *pdev)
> +{
> +	struct device *hwmon_dev;
> +	struct s5_hwmon *hwmon;
> +	int ret;
> +
> +	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	hwmon->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(hwmon->base))
> +		return PTR_ERR(hwmon->base);
> +
> +	hwmon->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(hwmon->clk))
> +		return PTR_ERR(hwmon->clk);
> +
> +	ret = clk_prepare_enable(hwmon->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, s5_temp_clk_disable,
> +				       hwmon->clk);
> +	if (ret)
> +		return ret;
> +
> +	s5_temp_enable(hwmon);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +							 "s5_temp",
> +							 hwmon,
> +							 &s5_chip_info,
> +							 NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +const struct of_device_id s5_temp_match[] = {
> +	{ .compatible = "microchip,sparx5-temp" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, s5_temp_match);
> +
> +static struct platform_driver s5_temp_driver = {
> +	.probe = s5_temp_probe,
> +	.driver = {
> +		.name = "sparx5-temp",
> +		.of_match_table = s5_temp_match,
> +	},
> +};
> +
> +module_platform_driver(s5_temp_driver);
> +
> +MODULE_AUTHOR("Lars Povlsen <lars.povlsen@microchip.com>");
> +MODULE_DESCRIPTION("Sparx5 SoC temperature sensor driver");
> +MODULE_LICENSE("GPL");
