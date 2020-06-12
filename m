Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C22C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D71207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591947503;
	bh=gQR0Hp36iG2N2CS38e+FWKGQiB6L7dW7ADwZEH6dwXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZNGw7up6+8mZO3dj8ed4AXUsqk50h7KgfsxfYWztnSxdqy6ZAQOmNn2wK5K38Ptxq
	 EwF8S65V1Yo86Qxa7L2AkRQL5wIAI5rf3PAZTYMmJHH2rwZ/iFIX8qMNLJ88nN0A8f
	 /Gkn4Z+3/11IY0aPVE/C1ZmCDKdtd0fzxF3cyaQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgFLHiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:38:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34798 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgFLHiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:38:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id w7so5742161edt.1;
        Fri, 12 Jun 2020 00:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FWuaSFu9jX7IUIcDf07jPsuJOKsC8Mu741YqNeRzDzY=;
        b=BmauoYrzgwJWNsKuMqe+9Taildr/THIy1u33miJYOZZqfy42d2tpjNEhd445XpSFUO
         QTToK8/77TpPi4dl+pvSKGD3kQfMkkW08JxAdVtXkCILSYve0cBm/s8+jtA3CGbyIRM4
         voVgOCiYzWvh9jgg/6Q5deMHbhKQr/KvVTU0tHu2gtDFtpd85kww7rKIAsynr072wRTC
         dK1yp5lfGlBJf7Th9hhl6WW7fCzakWCmWXKel4/6T3+UFk88rxu0QDe0sV7nOM2XNOAv
         ByYy7jfG45ZSPrhIwERds19dVHPIOeSDSuoCrIQdC4iUKw3RkqF4I6HgXGkCANG1zPaR
         pH/A==
X-Gm-Message-State: AOAM532semBKqZ+kqtP+ii05Gy2xQEnUOGt/7QP/TkxV7xofQsEK+tPM
        r4/uVC7J+OQKM3jpwrHfXlA=
X-Google-Smtp-Source: ABdhPJweHlcdWuMQzdxB5rmfs8APfFi+GW/cMHAITZAvIdNpW9I9oqsv3gZnCkzDtnzKBrjZ0gnEKg==
X-Received: by 2002:a50:e1c5:: with SMTP id m5mr10470676edl.47.1591947498509;
        Fri, 12 Jun 2020 00:38:18 -0700 (PDT)
Received: from pi3 ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id i23sm3162911eja.37.2020.06.12.00.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:38:17 -0700 (PDT)
Date:   Fri, 12 Jun 2020 09:38:15 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Gao Pan <b54642@freescale.com>,
        Fugang Duan <B38611@freescale.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] i2c: imx: Fix external abort on early interrupt
Message-ID: <20200612073815.GA25803@pi3>
References: <1591796802-23504-1-git-send-email-krzk@kernel.org>
 <20200612055114.alhm2uakoze6epvf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200612055114.alhm2uakoze6epvf@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 07:51:14AM +0200, Oleksij Rempel wrote:
> Hi Krzysztof,
> 
> thank you for your patch.
> 
> On Wed, Jun 10, 2020 at 03:46:42PM +0200, Krzysztof Kozlowski wrote:
> > If interrupt comes early (could be triggered with CONFIG_DEBUG_SHIRQ),
> > the i2c_imx_isr() will access registers before the I2C hardware is
> > initialized.  This leads to external abort on non-linefetch on Toradex
> > Colibri VF50 module (with Vybrid VF5xx):
> > 
> >     Unhandled fault: external abort on non-linefetch (0x1008) at 0x8882d003
> >     Internal error: : 1008 [#1] ARM
> >     Modules linked in:
> >     CPU: 0 PID: 1 Comm: swapper Not tainted 5.7.0 #607
> >     Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
> >       (i2c_imx_isr) from [<8017009c>] (free_irq+0x25c/0x3b0)
> >       (free_irq) from [<805844ec>] (release_nodes+0x178/0x284)
> >       (release_nodes) from [<80580030>] (really_probe+0x10c/0x348)
> >       (really_probe) from [<80580380>] (driver_probe_device+0x60/0x170)
> >       (driver_probe_device) from [<80580630>] (device_driver_attach+0x58/0x60)
> >       (device_driver_attach) from [<805806bc>] (__driver_attach+0x84/0xc0)
> >       (__driver_attach) from [<8057e228>] (bus_for_each_dev+0x68/0xb4)
> >       (bus_for_each_dev) from [<8057f3ec>] (bus_add_driver+0x144/0x1ec)
> >       (bus_add_driver) from [<80581320>] (driver_register+0x78/0x110)
> >       (driver_register) from [<8010213c>] (do_one_initcall+0xa8/0x2f4)
> >       (do_one_initcall) from [<80c0100c>] (kernel_init_freeable+0x178/0x1dc)
> >       (kernel_init_freeable) from [<80807048>] (kernel_init+0x8/0x110)
> >       (kernel_init) from [<80100114>] (ret_from_fork+0x14/0x20)
> > 
> > Additionally, the i2c_imx_isr() could wake up the wait queue
> > (imx_i2c_struct->queue) before its initialization happens.
> > 
> > Fixes: 1c4b6c3bcf30 ("i2c: imx: implement bus recovery")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> 
> I assume register access is aborted, because the IP core clock is not
> enabled. In this case we have bigger problem then just probe.

If by IP core clock you mean the clock which driver is getting, then
answer is no. This clock is enabled.

> Since this driver support runtime power management, the clock will be
> disabled as soon as transfer is done. It means, on shared interrupt, we
> will get in trouble even if there is no active transfer.

The driver's runtime PM plays only with this one clock, so it seems
you meant i2c_imx->clk. It is not this problem.

> 
> So, probably the only way to fix it, is to check in i2c_imx_isr() if the
> HW is expected to be active and register access should be save.

Checking in every interrupt whether the interrupt should be serviced
based on some SW flag because HW might be disabled? That looks unusual,
like a hack.

No, the interrupt should be registered when the driver and some other
pieces of HW are ready to service it.

Best regards,
Krzysztof
