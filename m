Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC375C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68252076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XaqIR5YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgFHSpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgFHSpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:45:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D11C08C5C7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 11:45:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so18567319wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ySspVCbCwHhpHyThSAZlpsL4E+rejtUqHxn7Z7vlWxo=;
        b=XaqIR5YYixt9BOP0z0KEUXloA92HRuoRKrairYtC9RkYMC9IpeWZNFhdtm3Ew0S0ik
         23GSnPKbcQ0iLuaO471GEgonjcDLwGaP8Kz5RZsF4qDAQJYhxfHq+SDj1wQnRnQsuPdk
         cRlIG+/OaEkp5nBrighVcnPHmVE9LKqgwSYhcc/FBr6yOKQxY1fsLjRZLIKWqRlMxgFK
         FBCq5icjXeGFENyFVicmG3XnbNL2HRcP8U3PYSH+QTyH+qDr5UGNuKjp33ymGS9uNwRR
         NsYdveDqU59LDwexizMe7iEdZ45qmTF7FMjUFX8k1NOHb97L6aRezBMZUufezBduirpN
         Wctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ySspVCbCwHhpHyThSAZlpsL4E+rejtUqHxn7Z7vlWxo=;
        b=PLPGzOHHl5baWdlVlEKRUNwWgGH/Y7TqnmYZhclUhLChPy5wSIsJ0uxphKOUPhT2Gn
         vRXV2WItZ2aqoI6kDueDvowE68w021XDCJZKAMMfMQ07koiYB56g2MARTC60KYolHVQB
         0zw7E9K60bmfTQDDi6JOPYk8wilBY9XsJVJ+fMnXUX4zRK5YRodhCUQyXI8UAZkYR7W+
         4t5Ru8qUGiSLLUBhC5WBnnO2hwXyVtZYaKjpFT6WjU9A77aLCdPHfrnX1AmisB8y8XFI
         kXlu+pcuI9UjpPOGwxyv11GuTSMMXBQL2AX5IJnH3Zu0JWEZ+4UWeMEXm0NLwcfIbgQi
         5ihg==
X-Gm-Message-State: AOAM531e3cnF7xdcnDI35h309kKXKqaXLopFc99F4L0edL3a+mZ8EWlS
        NtnUdVM+2T04W6axt5byHgepZA==
X-Google-Smtp-Source: ABdhPJwJkROAZGlSnvebAmkphxhPvdl6ye0SyhN4iF5a2R8kuYku/y1mSAp6OBUwhp5UgMqFn2jP+w==
X-Received: by 2002:adf:d851:: with SMTP id k17mr216774wrl.30.1591641910077;
        Mon, 08 Jun 2020 11:45:10 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id u12sm576259wrq.90.2020.06.08.11.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 11:45:09 -0700 (PDT)
Date:   Mon, 8 Jun 2020 19:45:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/16] mfd: mfd-core: match device tree node against
 reg property
Message-ID: <20200608184507.GC4106@dell>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
 <67e90dafd67c285158c2c6f67f92edb7@walle.cc>
 <20200515102848.GH271301@dell>
 <159e68b4ce53630ef906b2fcbca925bd@walle.cc>
 <20200608142413.GA4106@dell>
 <7566ef30fea9740f427f392aabde0eac@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7566ef30fea9740f427f392aabde0eac@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jun 2020, Michael Walle wrote:

> Am 2020-06-08 16:24, schrieb Lee Jones:
> > On Mon, 25 May 2020, Michael Walle wrote:
> > > Am 2020-05-15 12:28, schrieb Lee Jones:
> > > > On Thu, 30 Apr 2020, Michael Walle wrote:
> > > >
> > > > > Hi Lee,
> > > > >
> > > > > Am 2020-04-23 19:45, schrieb Michael Walle:
> > > > > > There might be multiple children with the device tree compatible, for
> > > > > > example if a MFD has multiple instances of the same function. In this
> > > > > > case only the first is matched and the other children get a wrong
> > > > > > of_node reference.
> > > > > > Add a new option to match also against the unit address of the child
> > > > > > node. Additonally, a new helper OF_MFD_CELL_REG is added.
> > 
> > [...]
> > 
> > > > > > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> > > > > > index d01d1299e49d..c2c0ad6b14f3 100644
> > > > > > --- a/include/linux/mfd/core.h
> > > > > > +++ b/include/linux/mfd/core.h
> > > > > > @@ -13,8 +13,11 @@
> > > > > >  #include <linux/plataorm_device.h>
> > > > > >
> > > > > >  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
> > > > > > +#define MFD_OF_REG_VALID	BIT(31)
> > > >
> > > > What about 64bit platforms?
> > > 
> > > The idea was to have this as a logical number. I.e. for now you may
> > > only
> > > have one subdevice per unique compatible string. In fact, if you
> > > have a
> > > look at the ab8500.c, there are multiple "stericsson,ab8500-pwm"
> > > subdevices. But there is only one DT node for all three of it. I guess
> > > this works as long as you don't use phandles to reference the pwm node
> > > in the device tree. Or you don't want to use device tree properties
> > > per subdevice (for example the "timeout-sec" of a watchdog device).
> > 
> > This is not a good example, as the "stericsson,ab8500-pwm" is
> > legitimate.  Here we are registering 3 potential devices, but only
> > instantiating 1 of them.
> 
> Mh?
> 
> static const struct mfd_cell ab8500_devs[] = {
> ..
>        OF_MFD_CELL("ab8500-pwm",
>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
>         OF_MFD_CELL("ab8500-pwm",
>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
>         OF_MFD_CELL("ab8500-pwm",
>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
> ..
> }
> 
> And in pwm-ab8500.c there are three offsets based on the pdev->id.
> 
> Am I missing something here?

Scrap what I said above.

For some reason I had of_platform_populate() in my head.

This will register and enumerate 3 devices.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
