Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B91C10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C68A20866
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrTKsjXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgCFN6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:58:44 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46901 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCFN6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:58:43 -0500
Received: by mail-vs1-f65.google.com with SMTP id s9so740713vsi.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LQTxqk+dVkcgHEpsAvnNL6hiqy7/nef8xEXr/Gx0Rk=;
        b=LrTKsjXgh8+22tuGjDJDwxBAkV54NOa0/DYM/zU3lPwBhaeSvKclFFa9cJsdi1S052
         gz6iM8mJdmO8I8/9x8TSwBctsRrd+KdBNtb8w9Rb7BRq+rErVVaVTqjTGY2WSIU712VK
         xIVbEnKyV5rSa+AP/lZg0rvrYDgYH288dvkTxu+xihGLiVRp6NgSkXUplj+v+Fcl2Ga6
         VNOqWUaH1YptoeNXuop+pEaEpJWVZZMOIigXCgPkgGjVpSQk8wdJA0a5hfvmNOLYPy00
         tNASLJpLzNW963BuOWfCvOLu5am5HnTI4nI0D1k0O4/q2NieyYEENnamNcZBFsnHr+iR
         s4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LQTxqk+dVkcgHEpsAvnNL6hiqy7/nef8xEXr/Gx0Rk=;
        b=mOnQsk9h7D1/qC5hbuO6ndJqJKxFKs6tzOnaUBMrV7CZNqdzyPNoDyVUhsZOhxnqfj
         bTsJxu9fwGnfhzHoEXX3JG9uEn9PWqlFOpkydpnrW2TFWU/IBUyLz+Pn51RrJQeT7wn+
         lsDQUPoLqYkyDXC7RmuKAQVtELkxB0wC7snpg5VRkXaOY6Hc4Ah23MlWai6QAjbfT9EN
         fgylVvm+xuHQLMU/PXmu0qwsR9R+nyt2xFkkWOyGWuNtFd32JVlLMTYaVnxJenUWut34
         yRnUB2tcBSc0MPm5ofsA8WIyCS22rv2i04C3ACAeWAoGL5LHX9i1SNmEJ9tZwgRvEk1O
         UJnQ==
X-Gm-Message-State: ANhLgQ2IrGweLKgqb6M5XXjQZ26dZYB+yVMwsiq52dRkKI92g+Qf7pbD
        vsKhjNePK5ADMmochNcrisIkIXXp2yMEiQh9WKc=
X-Google-Smtp-Source: ADFU+vtN4vHHDoCKUmfGb09n+EZ1fiD42trzmLlrpYF4QumAG78dslKt2JOc0OmEMTXHL4cDJGxH5RtITh87Oft9jsQ=
X-Received: by 2002:a67:2f8a:: with SMTP id v132mr2022888vsv.95.1583503122419;
 Fri, 06 Mar 2020 05:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20200124084359.16817-1-christian.gmeiner@gmail.com>
 <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com>
 <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
 <CAH9NwWdg5r1T9TkXAe4=3Zui2vMcnOc2UJ=e02NFbiPhb5n48w@mail.gmail.com>
 <20200217041936.GH5395@dragon> <CAH9NwWeT=h=hPzDbwRggNYNx-mSdQkjUypPWk2nmsLDOfw8Zqw@mail.gmail.com>
 <20200218091409.GA6075@dragon> <CAH9NwWcNZzKt9gwYRRbgppeL9xqcK38z0ZP-5eGF9vXmg7T_=g@mail.gmail.com>
 <20200219091138.GA12803@dragon>
In-Reply-To: <20200219091138.GA12803@dragon>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 6 Mar 2020 14:58:30 +0100
Message-ID: <CAH9NwWfgJvPDE4_gjMhKaRSxJm-yJkzxOSDbU-HaQkcHuTL76w@mail.gmail.com>
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

Hi

Sorry for the delay.. totally forgot about the mail.

Am Mi., 19. Feb. 2020 um 10:11 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
>
> On Wed, Feb 19, 2020 at 09:48:23AM +0100, Christian Gmeiner wrote:
> > Am Di., 18. Feb. 2020 um 10:14 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
> > >
> > > On Mon, Feb 17, 2020 at 01:09:32PM +0100, Christian Gmeiner wrote:
> > > > Am Mo., 17. Feb. 2020 um 05:19 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
> > > > >
> > > > > On Mon, Feb 10, 2020 at 02:30:12PM +0100, Christian Gmeiner wrote:
> > > > > > Am Mo., 10. Feb. 2020 um 11:58 Uhr schrieb Krzysztof Kozlowski
> > > > > > <krzk@kernel.org>:
> > > > > > >
> > > > > > > On Mon, 10 Feb 2020 at 11:54, Christian Gmeiner
> > > > > > > <christian.gmeiner@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Am Fr., 24. Jan. 2020 um 09:44 Uhr schrieb Christian Gmeiner
> > > > > > > > <christian.gmeiner@gmail.com>:
> > > > > > > > >
> > > > > > > > > Makes it possible to multi v7 defconfig for stm32 and imx based devices with
> > > > >
> > > > > What do you mean by stm32 based devices here?
> > > > >
> > > >
> > > > CONFIG_ARCH_STM32 - I have a STM32MP157C-DK2 in my board farm and
> > > > would love to use
> > > > multi_v7 for imx6 and stm32.
> > >
> > > The patch is all about enabling drm-imx driver support.  The commit log
> > > gives the impression that drm-imx driver also works on stm32 devices.
> > > Is that the case?
> > >
> >
> > No - the common thing both share is etnaviv.
>
> I did not know that before, and thanks for the information.  But looking
> at the code change, there is nothing about etnaviv driver, and it's all
> about drm-imx driver.  So I'm still questioning why stm32 needs to be
> mentioned in the commit log at all.
>
> > The patch subject "ARM:
> > multi_v7_defconfig: enable drm imx support" is fine
>
> Agreed.  It's perfect.
>
> > I think but in the commit message I missed the verb so this should be
> > a better one:
> >
> > --->8---
> > ARM: multi_v7_defconfig: enable drm imx support
> >
> > Makes it possible to use multi v7 defconfig for stm32 and imx based devices with
> > full drm support.
> > --->8---
>
> I don't think 'stm32' should be there, as the code change in this commit
> has nothing to do with stm32, if I understand it correctly.
>

Okay.. what about:
--->8---
ARM: multi_v7_defconfig: enable drm imx support

It will be useful to have it enabled for KernelCI boot and runtime testing.
--->8---

> > How shall I proceed to get this change in?
>
> I can edit the commit log when applying.  But we need to agree on what
> it should be first.
>

Great!

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
