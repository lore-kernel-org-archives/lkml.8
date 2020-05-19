Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C43C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F98F20674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cy8IB+wN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgESKti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgESKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:49:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3328BC05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:49:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 50so15301516wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zGP5tEQ1OkU8JSSgdBVIVX+qSm1Zs7MjZp8KBwy75eY=;
        b=cy8IB+wNa4YE7h0M5DCPOALL3MSVIIWF4XKXmC1IK558sICk3+SOA3hF7ixMULJoCK
         1xT6zbFC7bp01v+fNypMnBnqt0xgAbjy7x748L3uyiqnbeEKQSS2jpcZr/u0tH286uzK
         th3lNlH/GhOIs+djo16fbG0z2xZZrncUxqfzlVHTKJBYphhdfoimPx3tvNzqsMvHSUvs
         tDiW+9AV8P8QleSzk2bEh8eUMcP1XR4j0OnP+H6vx21hBBqSbE7CtpP98Kl0mCPC3Wvd
         0MA4dnyJ9msfKkZvesLnKxLhA7gLvaSbrxokOpKRRX7tbv1ernotIyeZof5tMUEu5/gl
         EyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zGP5tEQ1OkU8JSSgdBVIVX+qSm1Zs7MjZp8KBwy75eY=;
        b=jGi1ME/knG9hBn/7tTmMLoITWMVuZhRxK1xJQMkXXR1n5fObgRILzgngb3BDnhuCmY
         1KLDnh0Ka263OMI88tRwMbB4uCmVxHuDnHpr5XjNeJhkoHPW8ndVvlrI866CTJ8bs/jP
         O30/9TKapK1K7loSDuNCjk4xrmvxud95t+CcNBM3osC/Jlq1ZzpW3EwsHn1rds+QkQQb
         fG3EuxNLExEg7EjKzdfqkYrNU2riTCnqZEktQip+NRkrTBu4TfDrfycV3ovTj10Cn6fp
         J79aWo1S8ndBENk8gyTgdXI6oQpvwO5BCIE5/fIpJOoZ78EytUWjeeVv4f5dXVwc5Ik0
         1x2g==
X-Gm-Message-State: AOAM531P6P3j0RVWkl7PkqxFjrOKSDBDQY7q0UO1rqdncrmIW/rkqZg9
        C1TyUZVPZylZwzTrQiMl6Py3Hw==
X-Google-Smtp-Source: ABdhPJy7z0MRl8N3VBeMdtwoJUOZbkWGmvSKI5OiuZ3QGxtvBdzlpSVa1AEhqIw+7Y+f6p1zlJeXqA==
X-Received: by 2002:a5d:4801:: with SMTP id l1mr24180884wrq.235.1589885375807;
        Tue, 19 May 2020 03:49:35 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id u23sm3607795wmu.20.2020.05.19.03.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:49:35 -0700 (PDT)
Date:   Tue, 19 May 2020 11:49:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: ene-kb3930: Add driver for ENE KB3930
 Embedded Controller
Message-ID: <20200519104933.GX271301@dell>
References: <20200424221123.106527-1-lkundrak@v3.sk>
 <20200424221123.106527-3-lkundrak@v3.sk>
 <20200429060037.GT3559@dell>
 <20200504192354.GA414543@furthur.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504192354.GA414543@furthur.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 May 2020, Lubomir Rintel wrote:

> Hi,
> 
> thanks for your review. There are some inline responses below. Where I'm not
> responding it means that I'll be just fixing what you've pointed out.
> 
> On Wed, Apr 29, 2020 at 07:00:37AM +0100, Lee Jones wrote:
> > On Sat, 25 Apr 2020, Lubomir Rintel wrote:
> > 
> > > This driver provides access to the EC RAM of said embedded controller
> > > attached to the I2C bus as well as optionally supporting its slightly weird
> > > power-off/restart protocol.
> > > 
> > > A particular implementation of the EC firmware can be identified by a
> > > model byte. If this driver identifies the Dell Ariel platform, it
> > > registers the appropriate cells.
> > > 
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > ---
> > >  drivers/mfd/Kconfig      |  10 ++
> > >  drivers/mfd/Makefile     |   1 +
> > >  drivers/mfd/ene-kb3930.c | 209 +++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 220 insertions(+)
> > >  create mode 100644 drivers/mfd/ene-kb3930.c
> > > 
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 0a59249198d3..dae18a2beab5 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -398,6 +398,16 @@ config MFD_DLN2
> > >  	  etc. must be enabled in order to use the functionality of
> > >  	  the device.
> > >  
> > > +config MFD_ENE_KB3930
> > > +	tristate "ENE KB3930 Embedded Controller support"
> > > +	depends on I2C
> > > +	depends on MACH_MMP3_DT || COMPILE_TEST
> > > +	select MFD_CORE
> > > +	help
> > > +	  This adds support for accessing the registers on ENE KB3930, Embedded
> > > +	  Controller. Additional drivers such as LEDS_ARIEL must be enabled in
> > > +	  order to use the functionality of the device.
> > > +
> > >  config MFD_EXYNOS_LPASS
> > >  	tristate "Samsung Exynos SoC Low Power Audio Subsystem"
> > >  	depends on ARCH_EXYNOS || COMPILE_TEST
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index f935d10cbf0f..2d2f5bc12841 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
> > >  obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
> > >  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
> > >  obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
> > > +obj-$(CONFIG_MFD_ENE_KB3930)	+= ene-kb3930.o
> > >  obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
> > >  
> > >  obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
> > > diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
> > > new file mode 100644
> > > index 000000000000..1123f3a1c816
> > > --- /dev/null
> > > +++ b/drivers/mfd/ene-kb3930.c
> > > @@ -0,0 +1,209 @@
> > > +// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0-or-later
> > > +/*
> > > + * ENE KB3930 Embedded Controller Driver
> > > + *
> > > + * Copyright (C) 2020 Lubomir Rintel
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/reboot.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/mfd/core.h>
> > 
> > Alphabetical.
> > 
> > > +enum {
> > > +	EC_DATA_IN	= 0x00,
> > > +	EC_RAM_OUT	= 0x80,
> > > +	EC_RAM_IN	= 0x81,
> > > +};
> > 
> > Are these registers?
> 
> These are I2C registers that are multiplexing access to the EC RAM.
> Should I add a comment or make it clearer in some other way?

A comment sounds good.

> > > +enum {
> > > +	EC_MODEL_ID	= 0x30,
> > > +	EC_VERSION_MAJ	= 0x31,
> > > +	EC_VERSION_MIN	= 0x32,
> > > +};
> > 
> > As above?
> 
> These are the locations in EC RAM, multiplexed via EC_DATA_IN and
> EC_RAM_IN/OUT.

As above.

> > > +struct kb3930 {
> > > +	struct i2c_client *client;
> > > +	struct regmap *ec_ram;
> > 
> > This is usually called 'regmap'.
> 
> Yes. But the device has a set of registers directly on the I2C bus as
> well as another set of registers in the RAM access to which is
> multiplexed via a pair of I2C registers.
> 
> This regmap is for the latter register block which is the only one
> exposed currently. I believe it still makes sense to make it obvious
> this is not the I2C registers in case the driver is extended to expose
> those in future.

ram_regmap or similar.

> > > +	struct gpio_descs *off_gpios; 
> > > +};
> > > +
> > > +struct kb3930 *global_kb3930;
> > 
> > Globals are massively frowned upon.  Please move it.
> 
> This is necessary for the pm_power_off hook that takes no argument. All
> other MFD drivers that implement power off use a global:

Ah, it's one of those:

  static struct kb3920_power_off

>   ab8500-sysctrl.c: static struct device *sysctrl_dev;
>   axp20x.c:         static struct axp20x_dev *axp20x_pm_power_off;
>   dm355evm_msp.c:   static struct i2c_client *msp430;
>   max77620.c:       static struct max77620_chip *max77620_scratch;
>   max8907.c:        static struct max8907 *max8907_pm_off;
>   palmas.c:         static struct palmas *palmas_dev;
>   retu-mfd.c:       static struct retu_dev *retu_pm_power_off;
>   rk808.c:          static struct i2c_client *rk808_i2c_client;
>   rn5t618.c:        static struct rn5t618 *rn5t618_pm_power_off;
>   tps6586x.c:       static struct device *tps6586x_dev;
>   tps65910.c:       static struct i2c_client *tps65910_i2c_client;
>   tps80031.c:       static struct tps80031 *tps80031_power_off_dev;
>   twl-core.c:       static struct twl_private *twl_priv;

[...]

> > > +					   ariel_ec_cells,
> > > +					   ARRAY_SIZE(ariel_ec_cells),
> > > +					   NULL, 0, NULL);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +	} else {
> > > +		dev_err(dev, "unknown board model: %02x\n", model_id);
> > > +		return -ENODEV;
> > 
> > If you reverse the logic here, you can put this in the if() and omit
> > the else.
> 
> It is intentionally structured this way.
> 
> Though the driver currently only supports the 'J' version of the EC
> firmware, other versions are possible, with different cells exposed via
> the EC RAM registers.

It's difficult to review based on whatifs.

I think it's worth doing it right for the current situation and adapt
it *if* things change in the future.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
