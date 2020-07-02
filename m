Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1217AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07CC2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uue4Ct1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGBGyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgGBGyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:54:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3137C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 23:54:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so26755195wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 23:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jkGYYfe2hXwlfT92r1IHKv+smCrZ9H0RHjhvrcwG6RM=;
        b=uue4Ct1O77dMDRlgPX47t639kQvvOkI806ekC1sY2KMQm/rN7jIHuIYUIwwRir6yGN
         FC6aKbB50VTkvX/qj9HCtX/WgTnlI0Qp1Sfx0c+wMQI6cqxxg+h/1ZA8o9wiBgrJyKkC
         qxQuGj0uCmb8q8EApRFYhieNgy0As6sq3kAmVyE1CRzMf4CgbINob/Ndo4KO176Y3NAF
         PqlrE0ZpDDMIbmOI/qz+kDgDBslJmDVn9fcfn08kikjRMVB7gihB+3/zHA+GcFLp8pwE
         PXHjdf20mEY55LmI0dUCXScOKEzMJIIIy7rBi6ouF1p15hFPiPsIQIv4OsVTLg6dk3Yy
         dI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jkGYYfe2hXwlfT92r1IHKv+smCrZ9H0RHjhvrcwG6RM=;
        b=noibAu5lMklCIwRKcgPN3HVMBDfkFe6VHiEV0CGQIGWiUZb1x2zfWRR0hbeVXrCoWJ
         wQSRgY2s2wca+oclQ72aJsK+5+By4GF4LvawyRJFC1S5yV9ovCCgKOWn3EeOYnC7ggi1
         85Nym0hHlVw7QBbyw//5xEZtWB4lL9qKrLYgFVmm4DPYvgTf5BRPESMSXXgxUoAvvxSL
         57hUN99DldlK0wPgI23bawdViiWsU6f2arfut8rX+9TRA42fKhurGCCA6DDLdrxFQBqH
         /HuXWrx/8vmXma4Pw2FUkX0mZ8jK+e+9E9OGTaiSPSE+3TAasYxQ3lD+peTAIbDA94qk
         2zLw==
X-Gm-Message-State: AOAM532fnxMxTCPWNFwYWGhezLaT31V+luiqW38WMsMikdve98aXmdDP
        AZIZ9Xs8QGa+UmXS73VAfNhyGTUj2Pg=
X-Google-Smtp-Source: ABdhPJydX7owlhIb52/jlcBSck3LcH0Z4kO4QGJwnzYSBGCkzFe4tct2dW83VZ6L2kb1EOVAkOxFBg==
X-Received: by 2002:adf:f20a:: with SMTP id p10mr31837380wro.41.1593672854471;
        Wed, 01 Jul 2020 23:54:14 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id k11sm10540596wrd.23.2020.07.01.23.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 23:54:13 -0700 (PDT)
Date:   Thu, 2 Jul 2020 07:54:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     robh+dt@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
Message-ID: <20200702065412.GO1179328@dell>
References: <20200622075145.1464020-1-lee.jones@linaro.org>
 <e436fd60bf0ebb6d72a76034d0fc35de@walle.cc>
 <f505c52d565ba7dbf05eef895782c410@walle.cc>
 <20200701070434.GP1179328@dell>
 <5d1d41504172d86d395b0135923f6f02@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d1d41504172d86d395b0135923f6f02@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020, Michael Walle wrote:

> Am 2020-07-01 09:04, schrieb Lee Jones:
> > On Wed, 01 Jul 2020, Michael Walle wrote:
> > 
> > > Hi Lee,
> > > 
> > > Am 2020-06-30 11:16, schrieb Michael Walle:
> > > > I'm just trying to use this for my sl28 driver. Some remarks, see below.
> > > >
> > > > Am 2020-06-22 09:51, schrieb Lee Jones:
> > > > > The existing SYSCON implementation only supports MMIO (memory mapped)
> > > > > accesses, facilitated by Regmap.  This extends support for registers
> > > > > held behind I2C busses.
> > > > >
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > > Changelog:
> > > > >
> > > > > v3 => v4
> > > > >   - Add ability to provide a non-default Regmap configuration
> > > > >
> > > > > v2 => v3
> > > > >   - Change 'is CONFIG' present check to include loadable modules
> > > > >     - s/#ifdef CONFIG_MFD_SYSCON_I2C/#if
> > > > > IS_ENABLED(CONFIG_MFD_SYSCON_I2C)/
> > > > >
> > > > > v1 => v2
> > > > >   - Remove legacy references to OF
> > > > >   - Allow building as a module (fixes h8300 0-day issue)
> > > > >
> > > > > drivers/mfd/Kconfig            |   7 +++
> > > > >  drivers/mfd/Makefile           |   1 +
> > > > >  drivers/mfd/syscon-i2c.c       | 104
> > > > > +++++++++++++++++++++++++++++++++
> > > > >  include/linux/mfd/syscon-i2c.h |  36 ++++++++++++
> > > > >  4 files changed, 148 insertions(+)
> > > > >  create mode 100644 drivers/mfd/syscon-i2c.c
> > > > >  create mode 100644 include/linux/mfd/syscon-i2c.h

[...]

> > > > This way, (a) a driver doesn't have to use "#include <linux/i2c.h>" just
> > > > to call to_i2c_client() (or i2c_verify_client()) and (b) you won't do it
> > > > all over again in all sub drivers.
> > > >
> > > > So you could just do a
> > > >   regmap = syscon_i2c_to_regmap(pdev->dev.parent);
> > > >
> > > > I've also noticed that the mmio syscon uses device_node as parameter.
> > > > What
> > > > was the reason to divert from that? Just curious.
> > > 
> > > How is this supposed to be used?
> > > 
> > > I had something like the following in mind:
> > > 
> > > &i2c {
> > >   cpld@4a {
> > >     compatible = "simple-mfd";
> > >     reg = <0x4a>;
> > > 
> > >     gpio@4 {
> > >       compatible = "vendor,gpio";
> > >       reg = <0x4>;
> > >     };
> > >   };
> > > };
> > 
> > Yes, that was the idea.
> > 
> > > But I think the childen are not enumerated if its an I2C device. And
> > > the actual i2c driver is also missing.
> > 
> > What do you mean?  Can you elaborate?
> 
> There is no i2c_driver instance who would create the regmap.

The regmap is created by the first caller of:

 syscon_i2c_to_regmap{_config}()

> If I'm
> reading the I2C code correctly, it won't probe any i2c device of a
> bus if there is no i2c_driver with an associated .probe() or
> .probe_new().

Why wouldn't the children be registered using i2c_driver?

> And even if it is probed, its subnodes won't be
> enumerated; the "simple-mfd" code only works for MMIO busses, right?
> Or I'm getting something really wrong here..

Then how are these I2C based devices able to call of_platform_populate()?

 drivers/mfd/gateworks-gsc.c
 drivers/mfd/lochnagar-i2c.c
 drivers/mfd/palmas.c
 drivers/mfd/smsc-ece1099.c
 drivers/mfd/stpmic1.c
 drivers/mfd/twl-core.c

Might require some more research into where your use-case is breaking
down.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
