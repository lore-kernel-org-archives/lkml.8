Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0866DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD9A206BE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDqlQvdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGBH1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgGBH1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:27:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D20C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 00:27:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so25550960wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7b1tr/YyHCmwp2+o1uDBijrmKA9zlZnOStRHRfWKMQU=;
        b=CDqlQvdl/A8mBV1IC1Jn584KimECzuSlTi7t4L2yCZ6KwHWq/nL33nqHtenl8D6tYQ
         aUyYiNCgeJVoz1PVbSwtIPySXXZc3xtOvC5S14dICu6pUCziiuC/YPod+Pp4pWpoqAsC
         rlc5VBzk5aS3UC10+FwtXhl9FEFsmrZrAh3KGzALRf4GEx7cfPUWXiGR6x/ixElREHhM
         d3iCHBnAnkJ+1dAWKMIOl9gXmsnqHJJPocdh1hVk1+j+ORaTqQs6Kt3AguuUZU0FxXOV
         Qzmz7u/mLrqoqxMBpX5k7jrwWtIVYgh8HvzM+SKtmz83IpOOiamEcSngNB29Vcj+ANz0
         de5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7b1tr/YyHCmwp2+o1uDBijrmKA9zlZnOStRHRfWKMQU=;
        b=QJpbhtx9UKIBoKhd+6QA85VdFJ48Crj9Mf4wCXf0mY5NICHfkbdrOLa/hoA+M0xz+/
         VZNlk8Fk0YUhN93m9+rD4C3vjY1VpNXe9cCRSF/Sb2n41h7bwVNMVQApVHL2WdYeX+Vi
         9Q/wL3hMR8OCYRupJemzfdVWyaVrM2iIQjXDzgjs68hi1gDsbm2U7YQP4doickf90JVa
         XHKUeRMKrlJpeGQlRCxnVWHZRFLr+7wdZjf6ok5QH5eGUGESH8Njlg5KL7TrgfA4Ckw7
         RSzPz4ErhGnVW7u7YRFAS2HE7GazpAsGvzehu285A7Vu+tE9gtaG8kPT9k5RxD6XmGc/
         9j0g==
X-Gm-Message-State: AOAM533bTDUX4UPIsSejtw7PzqGtNzeoJs5zcvfkTTMTZULBFQccelbh
        8Bsy6O2kJMShGjw9kYnbp7uxug==
X-Google-Smtp-Source: ABdhPJx2VFf+GlmIZM8WrPHYsa0GQ70iQe9LRgZoBd+5ZiD4N1Rlt5fqDS4tiHF8UYtrXykEtU80fA==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr29427621wmg.153.1593674842790;
        Thu, 02 Jul 2020 00:27:22 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm9982766wrq.15.2020.07.02.00.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:27:22 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:27:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        arnd@arndb.de, bgolaszewski@baylibre.com
Subject: Re: [RFC PATCH] mfd: add simple regmap based I2C driver
Message-ID: <20200702072720.GQ1179328@dell>
References: <20200701212100.6020-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701212100.6020-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020, Michael Walle wrote:

> There are I2C devices which contain several different functions but
> doesn't require any special access functions. For these kind of drivers
> an I2C regmap should be enough.
> 
> Create an I2C driver which creates an I2C regmap and enumerates its
> children. If a device wants to use this as its MFD core driver, it has
> to add an individual compatible string. It may provide its own regmap
> configuration and a .pre_probe hook. The latter allows simple checks
> and abort probing, for example a version check.
> 
> Subdevices can use dev_get_regmap() on the parent to get their regmap
> instance.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> 
> I don't think the syscon-i2c is the way to go:
> 
>    "TBC, while fine for a driver to bind on 'simple-mfd', a
>     DT compatible with that alone is not fine." [1]
> 
>    "Yes, this is why specific compatible strings are
>     required." [1]
> 
>    "No. I'd like to just kill off syscon and simple-mfd really. Those are
> 	just hints meaning a specific compatible is still needed, but I see
> 	them all the time alone (or combined like above). 'syscon' just serves
> 	to create a regmap. This could be accomplished just with a list of
> 	compatibles to register a regmap for. That might be a longish list, but
> 	wanting a regmap is really a kernel implementation detail and
> 	decision." [2]

This is taken out of context.  Rob is suggesting that 'simple-mfd'
and/or 'syscon' shouldn't be used as separate entities.  Instead they
should be coupled with a real and descriptive compatible string.
Either 'simple-mfd' nor 'syscon' is going away.

> So I don't get it why we would now add another syscon type. Instead, here
> is a new try to generalize the idea to just have a simple driver which just
> have a bunch of compatible strings for supported devices (and thus can be
> added quirks to it without changing the DT) and just creates a regmap. A
> simple device can just add itself to the list of compatible strings. If
> quirks are needed later, they can either be added right to simple-mfd-i2c.c
> or split off to an own file, but time will tell.
> 
> Right now, there is just a .pre_probe() hook which can be used to cancel
> the probing of the device or print some useful info to the kernel log. Yes,
> this is for "my" version check. And TBH I don't see a problem with adding
> that to this generic driver.
> 
> [1] https://lore.kernel.org/linux-devicetree/CAL_JsqKr1aDVzgAMjwwK8E8O_f29vSrx1HXk81FF+rd3sEe==w@mail.gmail.com/
> [2] https://lore.kernel.org/linux-devicetree/20200609165401.GB1019634@bogus/
> 
>  drivers/mfd/Kconfig          |  9 ++++++
>  drivers/mfd/Makefile         |  1 +
>  drivers/mfd/simple-mfd-i2c.c | 57 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>  create mode 100644 drivers/mfd/simple-mfd-i2c.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 7e72ed3441f1..96055c7e5c55 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1162,6 +1162,15 @@ config MFD_SI476X_CORE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called si476x-core.
>  
> +config MFD_SIMPLE_MFD_I2C
> +	tristate "Simple regmap based I2C devices"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  This is a consolidated driver for all MFD devices which are
> +	  basically just a regmap bus driver.
> +
>  config MFD_SM501
>  	tristate "Silicon Motion SM501"
>  	depends on HAS_DMA
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 7e26e7f98ac2..fa3a621a5a21 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -265,4 +265,5 @@ obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  
> +obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>  obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> new file mode 100644
> index 000000000000..60708e95f1a0
> --- /dev/null
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +
> +struct simple_mfd_i2c_config {
> +	int (*pre_probe)(struct i2c_client *i2c, struct regmap *regmap);

This has the potential to get out of control.

> +	const struct regmap_config *regmap_config;
> +};
> +
> +static const struct regmap_config simple_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int simple_mfd_i2c_probe(struct i2c_client *i2c)
> +{
> +	const struct regmap_config *regmap_config = &simple_regmap_config;
> +	const struct simple_mfd_i2c_config *config;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	config = device_get_match_data(&i2c->dev);
> +
> +	if (config && config->regmap_config)
> +		regmap_config = config->regmap_config;
> +
> +	regmap = devm_regmap_init_i2c(i2c, regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	if (config && config->pre_probe) {
> +		ret = config->pre_probe(i2c, regmap);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_of_platform_populate(&i2c->dev);
> +}
> +
> +static const struct of_device_id simple_mfd_i2c_of_match[] = {
> +	{}
> +};
> +
> +static struct i2c_driver simple_mfd_i2c_driver = {
> +	.probe_new = simple_mfd_i2c_probe,
> +	.driver = {
> +		.name = "simple-mfd-i2c",
> +		.of_match_table = simple_mfd_i2c_of_match,
> +	},
> +};
> +builtin_i2c_driver(simple_mfd_i2c_driver);

I'm not completely adverse to this idea.  There are a few things in
here I'd change, but the template is reasonable enough, despite the
opportunity for abuse.

However, before exploring this I'd like to properly see out the I2C
syscon conversation.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
