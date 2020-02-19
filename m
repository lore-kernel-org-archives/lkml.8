Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B749C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3CB208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldh03lco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBSIsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:48:36 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36992 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgBSIsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:48:35 -0500
Received: by mail-vs1-f66.google.com with SMTP id x18so14931609vsq.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2V6V8Tth/AEs59J+YGgMnXxzDIW957+lx2uHMjqQCr0=;
        b=ldh03lcoR52qghNjM5H1Wivomk6M4SJSe2RNN6S/loI4EhRnlFP0DuKFKiDL12cCP0
         +g87PsyqwJqXvMybSBXpUOsjaqzo6DE5ga2LY2p4LrjZMFkJoP4XXBdyMAo4huL920Le
         Q8scHN4ZS8Or54BY/WIUXzVyBCH4xthQwueHxRybsNhYfi6NsXIOGpM/OmxR5P/5x/7T
         qvVS4OgVAWkklQdixBq2lQavhcZzWLd31eSl5BBF7lAGkPL9ZFzoA9KaXxH1AnQ+A2mQ
         Tvvx8YA6PiqBBv7qyXMYqzCWOeW7qWrfUwoRoiaRG/7Mzj4F6XwABlo36dPyxDn3BKAN
         BAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2V6V8Tth/AEs59J+YGgMnXxzDIW957+lx2uHMjqQCr0=;
        b=XoaCl++Pb3u2YAOyhPL5L9XUbMwLYcxPopTn1u4osKCCmnbIghW9PgTwVKSLQ2lMM1
         1ycVcQ1qv7l145wv3/zOWG57RYm8L5eLbl9VmQA5AcSZj0Y5XFAtZ3cGBqBppIJ+au3G
         Meuco3navgPO/Ld5DhvCwUT0b4ZeRNLAhzQwkklEaN1H8BZohJeb6Z6rP23BPreYqOtJ
         8BZ4VWKGYWjUpWCVvLpzp+vswUgtCyVpVHsd2aeuSIvAQEPkhKkUzpR3cimYtLolihhz
         drSUaFSefkUzcPVnarRW14U92eJgb4M6CGBfmUSMEU++8GhwoN/aC804BxXuOS1Qs3Bp
         q+jA==
X-Gm-Message-State: APjAAAXOb6xMo/OcivmCJ2UobZAtaIftogkso4ZW7ZL8Fm3mvo2XRnYE
        GVJy3k3Po+LcyD1tEi5JMW0oDlTfrTr2yntdwh8=
X-Google-Smtp-Source: APXvYqzAOL/FPk+knGzR1eBqUMmLKf19+kA7wViHwNZxANl3QsdiVCUIz8Uq3dpnoys1j8gFeE32O0FATF6a71Zr3YI=
X-Received: by 2002:a67:6341:: with SMTP id x62mr13158482vsb.88.1582102114853;
 Wed, 19 Feb 2020 00:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20200124084359.16817-1-christian.gmeiner@gmail.com>
 <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com>
 <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
 <CAH9NwWdg5r1T9TkXAe4=3Zui2vMcnOc2UJ=e02NFbiPhb5n48w@mail.gmail.com>
 <20200217041936.GH5395@dragon> <CAH9NwWeT=h=hPzDbwRggNYNx-mSdQkjUypPWk2nmsLDOfw8Zqw@mail.gmail.com>
 <20200218091409.GA6075@dragon>
In-Reply-To: <20200218091409.GA6075@dragon>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Wed, 19 Feb 2020 09:48:23 +0100
Message-ID: <CAH9NwWcNZzKt9gwYRRbgppeL9xqcK38z0ZP-5eGF9vXmg7T_=g@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable drm imx support
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Patrice Chotard <patrice.chotard@st.com>,
        Joel Stanley <joel@jms.id.au>,
        Tony Lindgren <tony@atomide.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 18. Feb. 2020 um 10:14 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
>
> On Mon, Feb 17, 2020 at 01:09:32PM +0100, Christian Gmeiner wrote:
> > Am Mo., 17. Feb. 2020 um 05:19 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
> > >
> > > On Mon, Feb 10, 2020 at 02:30:12PM +0100, Christian Gmeiner wrote:
> > > > Am Mo., 10. Feb. 2020 um 11:58 Uhr schrieb Krzysztof Kozlowski
> > > > <krzk@kernel.org>:
> > > > >
> > > > > On Mon, 10 Feb 2020 at 11:54, Christian Gmeiner
> > > > > <christian.gmeiner@gmail.com> wrote:
> > > > > >
> > > > > > Am Fr., 24. Jan. 2020 um 09:44 Uhr schrieb Christian Gmeiner
> > > > > > <christian.gmeiner@gmail.com>:
> > > > > > >
> > > > > > > Makes it possible to multi v7 defconfig for stm32 and imx based devices with
> > >
> > > What do you mean by stm32 based devices here?
> > >
> >
> > CONFIG_ARCH_STM32 - I have a STM32MP157C-DK2 in my board farm and
> > would love to use
> > multi_v7 for imx6 and stm32.
>
> The patch is all about enabling drm-imx driver support.  The commit log
> gives the impression that drm-imx driver also works on stm32 devices.
> Is that the case?
>

No - the common thing both share is etnaviv. The patch subject "ARM:
multi_v7_defconfig: enable drm imx support" is fine
I think but in the commit message I missed the verb so this should be
a better one:

--->8---
ARM: multi_v7_defconfig: enable drm imx support

Makes it possible to use multi v7 defconfig for stm32 and imx based devices with
full drm support.
--->8---

How shall I proceed to get this change in?

-- 
thanks
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
