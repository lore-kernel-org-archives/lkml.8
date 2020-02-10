Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511BEC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DD4208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581332296;
	bh=sMBmPw/UXQNv3crzYTzb1AduPLQC6IwfbkcUeJC658Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fc1bl9rG//UkGY2uapIwvNUYqtKRVz5RbCTdtbqSp4hKn4i0H5Oe1lrLGJ6hrJYSr
	 +JzAek8BihA+XRZwCpcCm62tlRCcTTfH3GFZvKtDgEIMDqIgh0wq39ebjpRVlw7099
	 hLBWFftjLhy/rD9Qzis5MNfcZ1z0O5le+27PmFxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBJK6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:58:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgBJK6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:58:15 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56EF7208C3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 10:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581332294;
        bh=sMBmPw/UXQNv3crzYTzb1AduPLQC6IwfbkcUeJC658Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WHGSa13+iF+Ry0ouJdd5ppIly5RqeNvKBpr/m26phwePHyTys2PWCrKkm1IUca7Ol
         ozG8VESk84Qptu3GrAJu7G98/Ev12PQjo5oX5kzd3e/dSH/ZLtSddtVLd9i7K521G8
         0l33MVmundeJLlGhSzEepUzzjZy/gy0TF/x6Dols=
Received: by mail-lj1-f169.google.com with SMTP id o15so6596477ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 02:58:14 -0800 (PST)
X-Gm-Message-State: APjAAAXHBr7s34sr+cCCvjvOGsV5zoqC6h9D1uHIDMmtMW4MtUXyBkno
        WiCfZJjWr7pxN8QgxlyWbOLuPJvPJpLFF/JwZcE=
X-Google-Smtp-Source: APXvYqzmjwYhPpLhq8/nerP7eXgAypNzhiayrqIPJNCmgdqFOaK+1G29gpKsqBE6HJ82xfZb2Gd5V9Wdef8o/1yEWIk=
X-Received: by 2002:a2e:9705:: with SMTP id r5mr556812lji.114.1581332292498;
 Mon, 10 Feb 2020 02:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20200124084359.16817-1-christian.gmeiner@gmail.com> <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com>
In-Reply-To: <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 10 Feb 2020 11:58:01 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
Message-ID: <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable drm imx support
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
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
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 at 11:54, Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
>
> Am Fr., 24. Jan. 2020 um 09:44 Uhr schrieb Christian Gmeiner
> <christian.gmeiner@gmail.com>:
> >
> > Makes it possible to multi v7 defconfig for stm32 and imx based devices with
> > full drm support.
> >
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> > index 3f1b96dc7faa..d213a35557ed 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -637,6 +637,7 @@ CONFIG_CEC_PLATFORM_DRIVERS=y
> >  CONFIG_VIDEO_SAMSUNG_S5P_CEC=m
> >  CONFIG_VIDEO_ADV7180=m
> >  CONFIG_VIDEO_ML86V7667=m
> > +CONFIG_IMX_IPUV3_CORE=m
> >  CONFIG_DRM=y
> >  # CONFIG_DRM_I2C_CH7006 is not set
> >  # CONFIG_DRM_I2C_SIL164 is not set
> > @@ -652,6 +653,11 @@ CONFIG_ROCKCHIP_ANALOGIX_DP=y
> >  CONFIG_ROCKCHIP_DW_HDMI=y
> >  CONFIG_ROCKCHIP_DW_MIPI_DSI=y
> >  CONFIG_ROCKCHIP_INNO_HDMI=y
> > +CONFIG_DRM_IMX=m
> > +CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
> > +CONFIG_DRM_IMX_TVE=m
> > +CONFIG_DRM_IMX_LDB=m
> > +CONFIG_DRM_IMX_HDMI=m
> >  CONFIG_DRM_ATMEL_HLCDC=m
> >  CONFIG_DRM_RCAR_DU=m
> >  CONFIG_DRM_RCAR_LVDS=y
> > --
> > 2.24.1
> >
>
>
> ping

Hi,

It looks like you entirely skipped iMX maintainers in Cc/to list, so
whom are you pinging?

Best regards,
Krzysztof
