Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B29C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC282080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDcGNIyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgBJNac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:30:32 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45015 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgBJNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:30:25 -0500
Received: by mail-vk1-f195.google.com with SMTP id y184so1755854vkc.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 05:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sO0fguFagfrBAk+2OocklHo8Sby77UFX4PPPfRWY+Sg=;
        b=pDcGNIyyG74kffYSd13ak5T2WdV80gj/oEhQHCoC0gwU8Yo3Iq57Lq6UWUwBgyA75i
         vO9M6EYQ0hD/hOkFODwFPSVnMs+nhETuACUNaf+J4c+9ZkMRHMc5VKLxyaG6EXrPUm1z
         hZIGkKFEKNBtSTt28VjEQSTe55Rri4qZPWiGPYdL5mkfGxFJNYzy9V4gvA5BKsOltCdR
         cRVIxSL8HwWiqSIkbF8ucpmbCe5qbOUY9eILJcQrMJdF2RAVt4qHO3aahY02rOvVMj1s
         sM063H069FdrgWf0tJq7XOl4N5hc/DsIkoSRZhoL7KrZHcgh2eZTtNScWiTuTGhdLymT
         XpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sO0fguFagfrBAk+2OocklHo8Sby77UFX4PPPfRWY+Sg=;
        b=jiqeKL4tbrGzuEjw54BrE1HgcZOlq25kmqP+SUIMZ79J1aZHnTxubSal0RdPcZnNYr
         o3Wsl6SzZ3D12HX6T1VWbelfdFXgr6m9jK5zf3cvJLS9H+frTN2f/1mzJSjjjm9ASbIG
         CYgtENvYa+zSTejMKC5DosvhpxGMpIfabyyRiXhjJE5/Cb/hdzDUFCrH6cFnFgl1IU55
         mKJExd4KvzW6BOHyPtLr4gNB7lMLnFEQ+NBWCPdPyl173UcGoY6Ya9g3IEnTNP2SCczj
         RSY8iRCeTpzUVJevS4t1ZhjivPAw5/QpWsocVxOctvWJFtD7xgcP3hzdQGJZKW5ormph
         oKAw==
X-Gm-Message-State: APjAAAVopUeaf55XdvzOqSCK2qaUysyYtJlHq3dmVHoGhVrAdaFEdmvv
        aPFgd8oAZnDU5LxdaYkPocaXlg31LK1xexQQBPE=
X-Google-Smtp-Source: APXvYqwbgoxZHBa7hZysysH6OEO9Yk7qehrcW3zDNqntpDwRKYKxVzP/J2e+W+eUD7/czD/dFuOyPxLUf6CQhEXvi2g=
X-Received: by 2002:a1f:9785:: with SMTP id z127mr645665vkd.48.1581341423785;
 Mon, 10 Feb 2020 05:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20200124084359.16817-1-christian.gmeiner@gmail.com>
 <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com> <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
In-Reply-To: <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 10 Feb 2020 14:30:12 +0100
Message-ID: <CAH9NwWdg5r1T9TkXAe4=3Zui2vMcnOc2UJ=e02NFbiPhb5n48w@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable drm imx support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 10. Feb. 2020 um 11:58 Uhr schrieb Krzysztof Kozlowski
<krzk@kernel.org>:
>
> On Mon, 10 Feb 2020 at 11:54, Christian Gmeiner
> <christian.gmeiner@gmail.com> wrote:
> >
> > Am Fr., 24. Jan. 2020 um 09:44 Uhr schrieb Christian Gmeiner
> > <christian.gmeiner@gmail.com>:
> > >
> > > Makes it possible to multi v7 defconfig for stm32 and imx based devices with
> > > full drm support.
> > >
> > > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > > ---
> > >  arch/arm/configs/multi_v7_defconfig | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> > > index 3f1b96dc7faa..d213a35557ed 100644
> > > --- a/arch/arm/configs/multi_v7_defconfig
> > > +++ b/arch/arm/configs/multi_v7_defconfig
> > > @@ -637,6 +637,7 @@ CONFIG_CEC_PLATFORM_DRIVERS=y
> > >  CONFIG_VIDEO_SAMSUNG_S5P_CEC=m
> > >  CONFIG_VIDEO_ADV7180=m
> > >  CONFIG_VIDEO_ML86V7667=m
> > > +CONFIG_IMX_IPUV3_CORE=m
> > >  CONFIG_DRM=y
> > >  # CONFIG_DRM_I2C_CH7006 is not set
> > >  # CONFIG_DRM_I2C_SIL164 is not set
> > > @@ -652,6 +653,11 @@ CONFIG_ROCKCHIP_ANALOGIX_DP=y
> > >  CONFIG_ROCKCHIP_DW_HDMI=y
> > >  CONFIG_ROCKCHIP_DW_MIPI_DSI=y
> > >  CONFIG_ROCKCHIP_INNO_HDMI=y
> > > +CONFIG_DRM_IMX=m
> > > +CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
> > > +CONFIG_DRM_IMX_TVE=m
> > > +CONFIG_DRM_IMX_LDB=m
> > > +CONFIG_DRM_IMX_HDMI=m
> > >  CONFIG_DRM_ATMEL_HLCDC=m
> > >  CONFIG_DRM_RCAR_DU=m
> > >  CONFIG_DRM_RCAR_LVDS=y
> > > --
> > > 2.24.1
> > >
> >
> >
> > ping
>
> Hi,
>
> It looks like you entirely skipped iMX maintainers in Cc/to list, so
> whom are you pinging?
>

I did use git send-email --cc-cmd='./scripts/get_maintainer.pl .. to
send out this patch so I am not the one to blame here.

Adding some imx maintainers...

-- 
Thanks
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
