Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03606C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68B421D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4CeBE11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgIHIOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbgIHIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:14:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD930C061757
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:14:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so16202458wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2l4ulTfYjNlFeRN+9AmUPudn6kXgV7e1zXVy9nKbsRk=;
        b=e4CeBE11o3dS4jh5WtgwHvX/aVsAUVjNuZFptYv0FYAuqO1K98mRcanGrEOjNjYNFj
         1B9gH057PfWPjo2QcMRrEZMg90NcPkJMcKVMvyDqhWkGR3PSfvFiGsld3X9Wck4HNBUv
         Uz1InBHYi4s1FbO7LIIYnsOElzCrPVjFJnvoARcO7gCqxYsS4kSDssOgt6yv3aOgFqUh
         bAQIDjH0Yi92yGMBsA0dpqV4vMOLuZy0WHY0SVfEuPK2ENzhsTbwoTlvongp9Gi2vvGK
         TEH1KHEHxZnKwqCzYbY46VsbpquCRbEqwMWCV9Z/tnC6T4PkLE5+QXW4TOkCDzT1t9Jr
         kDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2l4ulTfYjNlFeRN+9AmUPudn6kXgV7e1zXVy9nKbsRk=;
        b=QFdoBCOqK7YnWCczzIsJr6I/7dAGh1HV8gVUFXAOSOTgFLbpqAhY0d+btyiqGQP+Ve
         MqawuP2MN4g3yUS32Wo0x1IqaZf/HhdOiliP4yQFXUyv+6fpHZUKpx5dvuY/V2gcB+s2
         Bgk/JHgu+m6zcgJRTohWHrimFACszIRxcpFofGUIGfkPtknxDiQjgYEjzkzaqa8mwqE1
         PJmi4Iw/s1NJDksXrc4ftPAVSxvdwB3DEQd5vZvdbjxpcADLV3XNwtV1GU+FCP/xw9Mv
         +qtjlnkAzIud5I9lBYLzrtKDH9LXxj838gdSCcPAUM7C4GiQLJ2B36y6yRyPqhtEGxUz
         xZng==
X-Gm-Message-State: AOAM533ncJqn9DcMJAPVqTD58BuHwiESgUUpvA9r7cdicj65n2fRL5Gn
        uFP/b+5s5ZxctFHM5xErpE2cjA==
X-Google-Smtp-Source: ABdhPJxaRvhQRn53vo1Vi/7ljVTSvQijQ2hYfTSSvgSycwVb16Ba3bhMyPCw6FZ7G3YrfyGiH7odlg==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr3330505wmb.13.1599552888802;
        Tue, 08 Sep 2020 01:14:48 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id 71sm33594957wrm.23.2020.09.08.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:14:48 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:14:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 05/10] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20200908081445.GC4400@dell>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-6-j.neuschaefer@gmx.net>
 <CAHp75VdUHoOyM3bObzhdfiqpne0AmSK_UakteTZxnjqJVrNV9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdUHoOyM3bObzhdfiqpne0AmSK_UakteTZxnjqJVrNV9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Sep 2020, Andy Shevchenko wrote:

> On Saturday, September 5, 2020, Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> wrote:
> 
> > The Netronix EC provides a PWM output which is used for the backlight
> > on some ebook readers. This patches adds a driver for the PWM output.
> >
> > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> > ---
> >
> > v2:
> > - Various grammar and style improvements, as suggested by Uwe Kleine-König,
> >   Lee Jones, and Alexandre Belloni
> > - Switch to regmap
> > - Prefix registers with NTXEC_REG_
> > - Add help text to the Kconfig option
> > - Use the .apply callback instead of the old API
> > - Add a #define for the time base (125ns)
> > - Don't change device state in .probe; this avoids multiple problems
> > - Rework division and overflow check logic to perform divisions in 32 bits
> > - Avoid setting duty cycle to zero, to work around a hardware quirk
> > ---
> >  drivers/pwm/Kconfig     |   8 ++
> >  drivers/pwm/Makefile    |   1 +
> >  drivers/pwm/pwm-ntxec.c | 160 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 169 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-ntxec.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 7dbcf6973d335..7fd17c6cda95e 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -350,6 +350,14 @@ config PWM_MXS
> >           To compile this driver as a module, choose M here: the module
> >           will be called pwm-mxs.
> >
> > +config PWM_NTXEC
> > +       tristate "Netronix embedded controller PWM support"
> 
> 
> 
> 
> > +       depends on MFD_NTXEC && OF
> 
> 
> I don’t see need to reduce test coverage and use of the driver by sticking
> with OF. Actually it’s not used.

If the device is only known to boot with OF, then it's pointless
building it when !OF.  If you want to increase test coverage enable
COMPILE_TEST instead.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
