Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4866C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B82206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581913196;
	bh=vSJhH4hRafpBeA3RpiwKl7g8fobMI6k5ZvEMdAV6M0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QVCyGRkflGPqp5SyOFf+TXYc9zOkSqvfr5c1LLiqEiM6dg5Q7IO48QppI6/nn+UKm
	 UqhWhwr1ZYhrPy94Jhkln3g7ePAKdCH1xYwOdiHljkH67OYyExB0s3iUc5v9/ggxYF
	 GkXCePPQ7gZ16rHFPJuQfEDRNRJ+dx33Oa0aj7JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBQETu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgBQETt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 23:19:49 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE99B20679;
        Mon, 17 Feb 2020 04:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581913188;
        bh=vSJhH4hRafpBeA3RpiwKl7g8fobMI6k5ZvEMdAV6M0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwbH4t9J6U6wr0FuZn6up3R2tTvlBCdv0J+FfeIGqeOdJQuev2GFB1wC3wIuGj9CH
         CL1msGCwJ7N+KUY+qLicZj16qmSLFHq0cIdb2lwl2H+Zu/xWqB1cJxyeHMh3cV2+BU
         e9n2Nuq5Wxk93gyLNelA+YurjPjyxEwSP9i46gOA=
Date:   Mon, 17 Feb 2020 12:19:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
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
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable drm imx support
Message-ID: <20200217041936.GH5395@dragon>
References: <20200124084359.16817-1-christian.gmeiner@gmail.com>
 <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com>
 <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
 <CAH9NwWdg5r1T9TkXAe4=3Zui2vMcnOc2UJ=e02NFbiPhb5n48w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWdg5r1T9TkXAe4=3Zui2vMcnOc2UJ=e02NFbiPhb5n48w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 02:30:12PM +0100, Christian Gmeiner wrote:
> Am Mo., 10. Feb. 2020 um 11:58 Uhr schrieb Krzysztof Kozlowski
> <krzk@kernel.org>:
> >
> > On Mon, 10 Feb 2020 at 11:54, Christian Gmeiner
> > <christian.gmeiner@gmail.com> wrote:
> > >
> > > Am Fr., 24. Jan. 2020 um 09:44 Uhr schrieb Christian Gmeiner
> > > <christian.gmeiner@gmail.com>:
> > > >
> > > > Makes it possible to multi v7 defconfig for stm32 and imx based devices with

What do you mean by stm32 based devices here?

Shawn

> > > > full drm support.
> > > >
> > > > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > > > ---
> > > >  arch/arm/configs/multi_v7_defconfig | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> > > > index 3f1b96dc7faa..d213a35557ed 100644
> > > > --- a/arch/arm/configs/multi_v7_defconfig
> > > > +++ b/arch/arm/configs/multi_v7_defconfig
> > > > @@ -637,6 +637,7 @@ CONFIG_CEC_PLATFORM_DRIVERS=y
> > > >  CONFIG_VIDEO_SAMSUNG_S5P_CEC=m
> > > >  CONFIG_VIDEO_ADV7180=m
> > > >  CONFIG_VIDEO_ML86V7667=m
> > > > +CONFIG_IMX_IPUV3_CORE=m
> > > >  CONFIG_DRM=y
> > > >  # CONFIG_DRM_I2C_CH7006 is not set
> > > >  # CONFIG_DRM_I2C_SIL164 is not set
> > > > @@ -652,6 +653,11 @@ CONFIG_ROCKCHIP_ANALOGIX_DP=y
> > > >  CONFIG_ROCKCHIP_DW_HDMI=y
> > > >  CONFIG_ROCKCHIP_DW_MIPI_DSI=y
> > > >  CONFIG_ROCKCHIP_INNO_HDMI=y
> > > > +CONFIG_DRM_IMX=m
> > > > +CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
> > > > +CONFIG_DRM_IMX_TVE=m
> > > > +CONFIG_DRM_IMX_LDB=m
> > > > +CONFIG_DRM_IMX_HDMI=m
> > > >  CONFIG_DRM_ATMEL_HLCDC=m
> > > >  CONFIG_DRM_RCAR_DU=m
> > > >  CONFIG_DRM_RCAR_LVDS=y
> > > > --
> > > > 2.24.1
> > > >
> > >
> > >
> > > ping
> >
> > Hi,
> >
> > It looks like you entirely skipped iMX maintainers in Cc/to list, so
> > whom are you pinging?
> >
> 
> I did use git send-email --cc-cmd='./scripts/get_maintainer.pl .. to
> send out this patch so I am not the one to blame here.
> 
> Adding some imx maintainers...
> 
> -- 
> Thanks
> --
> Christian Gmeiner, MSc
> 
> https://christian-gmeiner.info/privacypolicy
