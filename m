Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479DDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2016E20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C1fB/+eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgFKJ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgFKJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:58:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E873C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:58:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so2145720plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2Od4RPoy3QKGp+dnzd4aF9qRJSfueENgUATI+IJ7EOQ=;
        b=C1fB/+ehBCIfy+Cw7OARJj7r0ZtWVP26Xm1aqT/BGrMFUp4kXcVKMOdyHEDXydfWUs
         etKTuVNkUtH4m59MYngZWgW96he1xiDs02Q0nn6BK3Ba9ODztvpnH/aHtf9X1KjxFuiP
         3tj9XvByF/IGfO6sCMMjVIF0MI1PyBaLC2L04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2Od4RPoy3QKGp+dnzd4aF9qRJSfueENgUATI+IJ7EOQ=;
        b=uBXDOQyVncmlKM7+yphwsF7Si+4j45BRkbhWIZzZmmTvk9uxQU2qXAf/SX4N0r4qNB
         PMn+hzkJRWYA7McrEW7xtOsLxHp9yCAzuTrcaJnOxx67yXZcQQuqjVIvrjAeUTKX8WbL
         K0y0EetKw9uSEs9rOzk9anhTsVSsQP6y4wycBXOtZcySEtpigKbcW3uLPeKbLB1rb8KU
         579IZRxYD2xVO16bIvLp3lqutXNqDNp/lOb3Een3t99+V8GLmrtAs2AfrQx3M3P1PrRD
         QB4G6dyP9GeaC/lc+7MrsrxH/N/ZctQvLodXWsay+moWglnvKs+eMg+wb0GJCZIbhaJY
         /UHw==
X-Gm-Message-State: AOAM532721cpRsqckRN081w3cuA6llIAqKP7uZalXbE8WNd0bzEWzJQF
        IQK7j4yyT+gENatbNVtDOnh0sw==
X-Google-Smtp-Source: ABdhPJzw0lDTAqGGWpNRk2DktUonsIF2tysXh92/1xtLg01onVMOBI4W4nLWCtLW7mmD3S4whQ9BMg==
X-Received: by 2002:a17:90a:34cc:: with SMTP id m12mr7338528pjf.123.1591869505598;
        Thu, 11 Jun 2020 02:58:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id iq19sm2188545pjb.48.2020.06.11.02.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 02:58:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200608104832.4.Ia4376fd88cdc6e8f8b43c65548458305f82f1d61@changeid>
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid> <20200608104832.4.Ia4376fd88cdc6e8f8b43c65548458305f82f1d61@changeid>
Subject: Re: [PATCH 4/4] drm/bridge: ti-sn65dsi86: Check the regmap return value when setting a GPIO
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@chromium.org, bjorn.andersson@linaro.org,
        spanda@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>, a.hajda@samsung.com,
        narmstrong@baylibre.com, sam@ravnborg.org
Date:   Thu, 11 Jun 2020 02:58:24 -0700
Message-ID: <159186950406.242598.11120838219466948342@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-06-08 10:48:35)
> The ti_sn_bridge_gpio_set() got the return value of
> regmap_update_bits() but didn't check it.  The function can't return
> an error value, but we should at least print a warning if it didn't
> work.
>=20
> This fixes a compiler warning about setting "ret" but not using it.
>=20
> Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Li=
nux")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 1080e4f9df96..526add27dc03 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -999,6 +999,9 @@ static void ti_sn_bridge_gpio_set(struct gpio_chip *c=
hip, unsigned int offset,
>         ret =3D regmap_update_bits(pdata->regmap, SN_GPIO_IO_REG,
>                                  BIT(SN_GPIO_OUTPUT_SHIFT + offset),
>                                  val << (SN_GPIO_OUTPUT_SHIFT + offset));
> +       if (ret)
> +               dev_warn(pdata->dev,
> +                        "Failed to set bridge GPIO %d: %d\n", offset, re=
t);

GPIO %u because it's unsigned?
