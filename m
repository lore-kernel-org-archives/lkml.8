Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862D9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660BD221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA+KBoks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHTELn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgHTELm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 00:11:42 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F08C061757;
        Wed, 19 Aug 2020 21:11:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r25so274653lfe.5;
        Wed, 19 Aug 2020 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0nvDXpUHYyrFXqiJEgVmctUAZQeXchyr8nPgGxgcWW4=;
        b=AA+KBoksk+3bdhNPirXE5NVQMpFgmxwgFd1rIFteGs//isYAsnnmOKhahi1tt1cW3w
         oImLAOdfjZfYOAvm70WmD9pg1aOWsk/uAdv0ZsdE34CyFMnYb5LLA/ku4Zijgw1iYZfs
         2V3uCqSZ5/lpshylygLh2WpLZ6myiVHqjbf+/zjERcKKZQDAPfA4/S0Qi7aJjFuAy3NF
         BBMz6BN+1AxsPgzSbWgRALE5DED7UYYXzm/FyLJ4kx7fSympj0XjiCIDdspg95Ps9zck
         4MeVwi9a1yTMZ5t6I/E7qUM+XF7t5H/h5G9FPYnBQBDpxu078ibwtJnDPeuIeLf9+69f
         7eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0nvDXpUHYyrFXqiJEgVmctUAZQeXchyr8nPgGxgcWW4=;
        b=MmH3rDllL3zSRYPCUerE8neSjFrhMz0ydU9G+i+TfWudH2WyFXQmLWlzgzU62Fn/MX
         SND9JGFxhDt+81O0BUcSEfgk1N4yYMx88olrn76kZvwet5k4fXILHRtegZ2RWm4GZL/c
         iA1hvVLgveMWc6hH0dsMi0XjHrmVBHN6ie67pvakp40/FQRI9c4zty6JdGPgGMLOoaZ8
         grifKH3PJJuMuw2clSkPmXT/jLBJYiXMwPt9SUVoIIcIkgekmECkS1561o+z/1hv8FdU
         nGnOBU4qq/pdH4TiGEIQokqmUGkSm3QZ4U08v8+cicPsdzoJK3eiqvQI2AKpbnNi6N6Q
         tBng==
X-Gm-Message-State: AOAM531Q08Wx9GTCJEb/WeWd3OIZuhlaM27FMbKytNa68Cwr9/XRi0eX
        xymUtK8DYhM0zoJCo9/fgyTgv/56FGfb1PedJWQ=
X-Google-Smtp-Source: ABdhPJy2/GeHjbpEQW5WLqhwV8Q1aByRAXrNwdzw3GOo2jSoOuRHDsnzsIVlpgW45YpR851BOuVbIVgaLv4O/9whFRY=
X-Received: by 2002:a05:6512:3156:: with SMTP id s22mr642666lfi.140.1597896700160;
 Wed, 19 Aug 2020 21:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596025057.git.agx@sigxcpu.org> <a98acb7a0ed2ee6af78ba08354740d69b63b8c53.1596025057.git.agx@sigxcpu.org>
In-Reply-To: <a98acb7a0ed2ee6af78ba08354740d69b63b8c53.1596025057.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 20 Aug 2020 01:11:28 -0300
Message-ID: <CAOMZO5Dg5NGpJ0SQkYny04Kv3ky0619J7YwT-0eE1dsK19o1-w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] arm64: defconfig: Enable imx8mq-librem5-devkit
 display stack
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Wed, Jul 29, 2020 at 9:19 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Enable the panel, NWL DSI host controller and dphy. This
> also needs the reset controller.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> ---
>  arch/arm64/configs/defconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e0f33826819f..608019f6408d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -640,10 +640,12 @@ CONFIG_DRM_MSM=3Dm
>  CONFIG_DRM_TEGRA=3Dm
>  CONFIG_DRM_PANEL_LVDS=3Dm
>  CONFIG_DRM_PANEL_SIMPLE=3Dm
> -CONFIG_DRM_SIMPLE_BRIDGE=3Dm
> +CONFIG_DRM_PANEL_SITRONIX_ST7703=3Dm
>  CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=3Dm
>  CONFIG_DRM_DISPLAY_CONNECTOR=3Dm
> +CONFIG_DRM_NWL_MIPI_DSI=3Dm
>  CONFIG_DRM_SII902X=3Dm
> +CONFIG_DRM_SIMPLE_BRIDGE=3Dm

One nit: I suppose the CONFIG_DRM_SIMPLE_BRIDGE=3Dm move comes from a
defconfig re-sync.

Maybe this re-sync could be part of a separate patch?

Thanks for adding these options to the defconfig so that we could have
MIPI DSI working by default on i.MX8M:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
