Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4982084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOfkf3Dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgGBISa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgGBIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:18:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A442C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 01:18:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so18999698wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Goqsrb7Ce7t40vY/t5X6+0ye6+OAJeYDs4AAa/eOL7M=;
        b=EOfkf3Dq0/qSQcBte7Kp5ZdzPjUEc9vQk4vSMKSLpc2TSyuWMfTOgMK4lveup2EDNA
         CIwH02j0g+zm8o0FrQATYK/Rdc4zb+UeuxONwsd55Q0ss/wpqb/vjBaHzznquUZWxDH7
         t5G+XBrDVhOU0OzYQXdpJPhL/koIuoRj8p3rQ4nkR5oCcY1LGJcKDp6urhfzqaaqIgJf
         hfHHZgdlb5q4v3CMvqVD/ZCqh+TWIsT7pO35h/cVFbOMATAQohgUwWKpmfU+ZsCNiaJL
         JOfk8tZjjla+arEMcC60h1hMdOWCCSZWT3jq7beaxrhWxq0o+n2tJDZsYZelgO8ghY5K
         gE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Goqsrb7Ce7t40vY/t5X6+0ye6+OAJeYDs4AAa/eOL7M=;
        b=mH7ngRNHDL8iXEbKHUULGlvxxLKg4CV0h7K1NQIwAvCZOZ/MdzYBQ3xIWix1HgSFDy
         19IBqtTZfEzPdbaR8OV4UWCwLQvrPhPc7U+0JT7W54VdZulYJT9aFLPv4WUtee0PHIAU
         B6A5wkR4vQqQRGEuKI8LXqMKexzzrPRfWAfmANt3XdGyOeptXtKDbK6crLRMGh6ieMa7
         jcE6kMA5rQCrLMfR1SoGxnCBDrRYzvHSDU/qS32JfjOacVPMI04RFGOwE1gitSq/Dfii
         W+0/eeAfCtebUenr3JqYl7v/1Fzp8JYDNLi3R6ZoY+83FvjzkD6I6NZMmhMJ6mhzqsAF
         tkKg==
X-Gm-Message-State: AOAM531jc0nvlxBNfUeX4+6VR9vyNuuV6cgDhmfE1RNJQW89k/Np61g8
        V/lxVEw6s7MerDb+APw5xXzt9g==
X-Google-Smtp-Source: ABdhPJyhoozqr8pXX2+XxVRRaH1+WgKxWUYGGjE+Uok9lR8yH3q9c5OeYs2CAar76E0ZDpmZ1DEpPQ==
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr29831646wrt.159.1593677907893;
        Thu, 02 Jul 2020 01:18:27 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id v7sm10166211wrp.45.2020.07.02.01.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 01:18:27 -0700 (PDT)
Date:   Thu, 2 Jul 2020 09:18:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>, Wolfram Sang <wsa@kernel.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
Message-ID: <20200702081825.GR1179328@dell>
References: <20200622075145.1464020-1-lee.jones@linaro.org>
 <e436fd60bf0ebb6d72a76034d0fc35de@walle.cc>
 <f505c52d565ba7dbf05eef895782c410@walle.cc>
 <20200701070434.GP1179328@dell>
 <5d1d41504172d86d395b0135923f6f02@walle.cc>
 <20200702065412.GO1179328@dell>
 <c20e8009fadbdc032090a493074396c8@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c20e8009fadbdc032090a493074396c8@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020, Michael Walle wrote:

> Am 2020-07-02 08:54, schrieb Lee Jones:
> > On Wed, 01 Jul 2020, Michael Walle wrote:
> > 
> > > Am 2020-07-01 09:04, schrieb Lee Jones:
> > > > On Wed, 01 Jul 2020, Michael Walle wrote:
> > > >
> > > > > Hi Lee,
> > > > >
> > > > > Am 2020-06-30 11:16, schrieb Michael Walle:
> > > > > > I'm just trying to use this for my sl28 driver. Some remarks, see below.
> > > > > >
> > > > > > Am 2020-06-22 09:51, schrieb Lee Jones:
> > > > > > > The existing SYSCON implementation only supports MMIO (memory mapped)
> > > > > > > accesses, facilitated by Regmap.  This extends support for registers
> > > > > > > held behind I2C busses.
> > > > > > >
> > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > ---
> > > > > > > Changelog:
> > > > > > >
> > > > > > > v3 => v4
> > > > > > >   - Add ability to provide a non-default Regmap configuration
> > > > > > >
> > > > > > > v2 => v3
> > > > > > >   - Change 'is CONFIG' present check to include loadable modules
> > > > > > >     - s/#ifdef CONFIG_MFD_SYSCON_I2C/#if
> > > > > > > IS_ENABLED(CONFIG_MFD_SYSCON_I2C)/
> > > > > > >
> > > > > > > v1 => v2
> > > > > > >   - Remove legacy references to OF
> > > > > > >   - Allow building as a module (fixes h8300 0-day issue)
> > > > > > >
> > > > > > > drivers/mfd/Kconfig            |   7 +++
> > > > > > >  drivers/mfd/Makefile           |   1 +
> > > > > > >  drivers/mfd/syscon-i2c.c       | 104
> > > > > > > +++++++++++++++++++++++++++++++++
> > > > > > >  include/linux/mfd/syscon-i2c.h |  36 ++++++++++++
> > > > > > >  4 files changed, 148 insertions(+)
> > > > > > >  create mode 100644 drivers/mfd/syscon-i2c.c
> > > > > > >  create mode 100644 include/linux/mfd/syscon-i2c.h
> > 
> > [...]
> > 
> > > > > > This way, (a) a driver doesn't have to use "#include <linux/i2c.h>" just
> > > > > > to call to_i2c_client() (or i2c_verify_client()) and (b) you won't do it
> > > > > > all over again in all sub drivers.
> > > > > >
> > > > > > So you could just do a
> > > > > >   regmap = syscon_i2c_to_regmap(pdev->dev.parent);
> > > > > >
> > > > > > I've also noticed that the mmio syscon uses device_node as parameter.
> > > > > > What
> > > > > > was the reason to divert from that? Just curious.
> > > > >
> > > > > How is this supposed to be used?
> > > > >
> > > > > I had something like the following in mind:
> > > > >
> > > > > &i2c {
> > > > >   cpld@4a {
> > > > >     compatible = "simple-mfd";
> > > > >     reg = <0x4a>;
> > > > >
> > > > >     gpio@4 {
> > > > >       compatible = "vendor,gpio";
> > > > >       reg = <0x4>;
> > > > >     };
> > > > >   };
> > > > > };
> > > >
> > > > Yes, that was the idea.
> > > >
> > > > > But I think the childen are not enumerated if its an I2C device. And
> > > > > the actual i2c driver is also missing.
> > > >
> > > > What do you mean?  Can you elaborate?
> > > 
> > > There is no i2c_driver instance who would create the regmap.
> > 
> > The regmap is created by the first caller of:
> > 
> >  syscon_i2c_to_regmap{_config}()
> 
> But which one is an i2c_driver? All the sub devices are platform drivers
> and there should be no need for them to know that they are behind an
> i2c driver (or spi driver or just mmio). All they have to know is how
> to access the registers.
> 
> > > If I'm
> > > reading the I2C code correctly, it won't probe any i2c device of a
> > > bus if there is no i2c_driver with an associated .probe() or
> > > .probe_new().
> > 
> > Why wouldn't the children be registered using i2c_driver?
> 
> Where is the code which enumerates the children?

Yes, I see the problem now.  So I2C devices depend on a device
registering with the i2c_driver framework, which then probes the
device accordingly.  Thus a physical driver is required to convert I2C
devices to platform devices.  So this stops being an MFD problem and
starts being a 'simple-i2c' issue. :)

(not a genuine suggestion by the way)

Wolfram, do we have this correct?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
