Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCF6C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7318520733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSGI0U8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgBJKyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:54:38 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41948 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:54:38 -0500
Received: by mail-ua1-f65.google.com with SMTP id f7so2266503uaa.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 02:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OK+fNFVryzyVYrXPzyQztWsAjpXsP146XLj7YZxSTx4=;
        b=QSGI0U8vFm796piSvUhpAe6ARu7rVLdm9/fiJdocrploEvRsgJAUBxeAqMscpgLCKD
         Whf2qYJ34q9iWIwU4HbPmxaxbg7ZF5CBvA5syh7jkyl10en6EngKCrQHSD7XXU0wLFQE
         GSB2m+eREav6OFakiUAg35kk9bUaUyFmxH1ltE9MqK8Hq9U2cqs1gmeSAv/oBdLiS4H5
         OchwiFINF8FkU3+JQWPLNa+5JXqD//FiAgiUCXGfVIpfIZQEdQvl/aC3OV2thO90bAuW
         sDHJx/pHpAefGPcZo+EKLyAkdeu9VUbKcFMYD/Tk7V4yh1LA9Eel7S3V3U5AzoXPXwxS
         g8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OK+fNFVryzyVYrXPzyQztWsAjpXsP146XLj7YZxSTx4=;
        b=icNCNXpeD4j6wqAg/o30fcHDYUdFifLV5sQyZ5eYKuUg7Kzi/SctTwjSbYXWv8WV3P
         TOFq+NzDW2DFoimHLUT4rbXTpnhP3/FAt+BfeClW5pL/rB7Lkria1j482E32FRvL5eRQ
         O+i7GCO4Yx0mRdPB7Oopqa9WFWB49QvoEKZvKaXIelCdh3iUVwXkTys5jBkPIMy6eAcS
         1fAaNi+TXyuJzK9A1nNkp3pqfIQyZItim7/DeQVE70CXogniGV1cQIqTMK53opLr9yDe
         76QEy85bshQsYhGjHav1qLrkc73g1I+BxaVFEJ0YgZ9VsgSMgc1dm7W8lCOZElBhzDev
         N70A==
X-Gm-Message-State: APjAAAUeOAf2Sz0m+B30Tndx10j4c+QDtd8RDM1KtvQ2PvyHGowhKML6
        1qRJ0voZz7K6E+1dZWYqVTwPl/prNXa9pLzjudrnrw==
X-Google-Smtp-Source: APXvYqzRgzlxK2LxMt8GQqJ2lf4BDGBrcMUbWX1z7cPtuSuLR4JkFhJD/I054BzWJsQWRCbs+hE910M9cCBZfSnKYxs=
X-Received: by 2002:ab0:14ea:: with SMTP id f39mr336598uae.40.1581332075883;
 Mon, 10 Feb 2020 02:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20200124084359.16817-1-christian.gmeiner@gmail.com>
In-Reply-To: <20200124084359.16817-1-christian.gmeiner@gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 10 Feb 2020 11:54:24 +0100
Message-ID: <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable drm imx support
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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

Am Fr., 24. Jan. 2020 um 09:44 Uhr schrieb Christian Gmeiner
<christian.gmeiner@gmail.com>:
>
> Makes it possible to multi v7 defconfig for stm32 and imx based devices with
> full drm support.
>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 3f1b96dc7faa..d213a35557ed 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -637,6 +637,7 @@ CONFIG_CEC_PLATFORM_DRIVERS=y
>  CONFIG_VIDEO_SAMSUNG_S5P_CEC=m
>  CONFIG_VIDEO_ADV7180=m
>  CONFIG_VIDEO_ML86V7667=m
> +CONFIG_IMX_IPUV3_CORE=m
>  CONFIG_DRM=y
>  # CONFIG_DRM_I2C_CH7006 is not set
>  # CONFIG_DRM_I2C_SIL164 is not set
> @@ -652,6 +653,11 @@ CONFIG_ROCKCHIP_ANALOGIX_DP=y
>  CONFIG_ROCKCHIP_DW_HDMI=y
>  CONFIG_ROCKCHIP_DW_MIPI_DSI=y
>  CONFIG_ROCKCHIP_INNO_HDMI=y
> +CONFIG_DRM_IMX=m
> +CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
> +CONFIG_DRM_IMX_TVE=m
> +CONFIG_DRM_IMX_LDB=m
> +CONFIG_DRM_IMX_HDMI=m
>  CONFIG_DRM_ATMEL_HLCDC=m
>  CONFIG_DRM_RCAR_DU=m
>  CONFIG_DRM_RCAR_LVDS=y
> --
> 2.24.1
>


ping

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
