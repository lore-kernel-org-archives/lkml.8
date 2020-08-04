Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1348C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B576720842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596583683;
	bh=rJGKAU6a1vzNuxXQY0o9qKI5eBpyPrG8L2if9FYJihk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JTmFOkmMWRWA5YNFK2GWnBCi11rs0KaE5PqZ71ZI87NsEOfgZNSqcKrFMAs1dcxCv
	 SHDx6DweB9i7HJV9j7fBsAMUh5aRVUF/93bGF3hpns0HTGeP4Yr3JXBBsE6XE3K7rD
	 XtBrOmwnPajNCPtoj+atLllZJ9WlbMW85IBmJrpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgHDX2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgHDX2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:28:01 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC9E2177B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 23:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596583681;
        bh=rJGKAU6a1vzNuxXQY0o9qKI5eBpyPrG8L2if9FYJihk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WntteR60Vu4o3yv/DQqCFvGs/UkMiveYHDMpO2/We1IMPK/3hJ36Scc+gCYNHO2Sg
         PoASieKQP3pkJyerhWvKIJzI0OBOdMjGV7P2IvfXaBRRWWh6B49LvyFf2Qjgqe7Xc7
         FCAN7uOU4sMdbMwZxLc5h6AlyoRc3LBokhADh/EU=
Received: by mail-ej1-f42.google.com with SMTP id g19so30496798ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 16:28:00 -0700 (PDT)
X-Gm-Message-State: AOAM530ia4SJPuYsqNTM1391lN+LDOZzaGiHA3ER25TekZoE9V1l6s5D
        WZf2JfrhDh4Xay6iI+3sLY2qR3au/HIyZ1GlEg==
X-Google-Smtp-Source: ABdhPJxhbuNd1k98tAHaLGm0Jd5RqlzV6OlBiVekuIBcntzql1W1cBK2/N+vIybzOkyo7GJwfzhqcUft9Dq8+VB6xZM=
X-Received: by 2002:a17:906:f14f:: with SMTP id gw15mr466293ejb.245.1596583679325;
 Tue, 04 Aug 2020 16:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200804165555.75159-1-linux@fw-web.de> <20200804165555.75159-2-linux@fw-web.de>
In-Reply-To: <20200804165555.75159-2-linux@fw-web.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 5 Aug 2020 07:27:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-zetZmpTjHJuEr-qrQWP8Rykj3s=Kx6M+U3TO44MNr2Q@mail.gmail.com>
Message-ID: <CAAOTY_-zetZmpTjHJuEr-qrQWP8Rykj3s=Kx6M+U3TO44MNr2Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: mediatek: add mt7623 display-nodes
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Wunderlich <linux@fw-web.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> mt7623 uses mt2701/mt8173 for drm, but have own compatibles

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt    | 2 +-
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt     | 2 +-
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt     | 4 ++--
>  .../devicetree/bindings/display/mediatek/mediatek,hdmi.txt    | 4 ++++
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index b91e709db7a4..121220745d46 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -43,7 +43,7 @@ Required properties (all function blocks):
>         "mediatek,<chip>-dpi"                   - DPI controller, see med=
iatek,dpi.txt
>         "mediatek,<chip>-disp-mutex"            - display mutex
>         "mediatek,<chip>-disp-od"               - overdrive
> -  the supported chips are mt2701, mt2712 and mt8173.
> +  the supported chips are mt2701, mt7623, mt2712 and mt8173.
>  - reg: Physical base address and length of the function block register s=
pace
>  - interrupts: The interrupt signal from the function block (required, ex=
cept for
>    merge and split function blocks).
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.t=
xt
> index 77def4456706..dc1ebd13cc88 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> @@ -7,7 +7,7 @@ output bus.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-dpi"
> -  the supported chips are mt2701 , mt8173 and mt8183.
> +  the supported chips are mt2701, mt7623, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - interrupts: The interrupt signal from the function block.
>  - clocks: device clocks
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> index 8e4729de8c85..f06f24d405a5 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -7,7 +7,7 @@ channel output.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-dsi"
> -  the supported chips are mt2701, mt8173 and mt8183.
> +- the supported chips are mt2701, mt7623, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - interrupts: The interrupt signal from the function block.
>  - clocks: device clocks
> @@ -26,7 +26,7 @@ The MIPI TX configuration module controls the MIPI D-PH=
Y.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-mipi-tx"
> -  the supported chips are mt2701, mt8173 and mt8183.
> +- the supported chips are mt2701, 7623, mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - clocks: PLL reference clock
>  - clock-output-names: name of the output clock line to the DSI encoder
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
hdmi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi=
.txt
> index 7b124242b0c5..6b1c586403e4 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.tx=
t
> @@ -6,6 +6,7 @@ its parallel input.
>
>  Required properties:
>  - compatible: Should be "mediatek,<chip>-hdmi".
> +- the supported chips are mt2701, mt7623 and mt8173
>  - reg: Physical base address and length of the controller's registers
>  - interrupts: The interrupt signal from the function block.
>  - clocks: device clocks
> @@ -32,6 +33,7 @@ The HDMI CEC controller handles hotplug detection and C=
EC communication.
>
>  Required properties:
>  - compatible: Should be "mediatek,<chip>-cec"
> +- the supported chips are mt7623 and mt8173
>  - reg: Physical base address and length of the controller's registers
>  - interrupts: The interrupt signal from the function block.
>  - clocks: device clock
> @@ -44,6 +46,7 @@ The Mediatek's I2C controller is used to interface with=
 I2C devices.
>
>  Required properties:
>  - compatible: Should be "mediatek,<chip>-hdmi-ddc"
> +- the supported chips are mt7623 and mt8173
>  - reg: Physical base address and length of the controller's registers
>  - clocks: device clock
>  - clock-names: Should be "ddc-i2c".
> @@ -56,6 +59,7 @@ output and drives the HDMI pads.
>
>  Required properties:
>  - compatible: "mediatek,<chip>-hdmi-phy"
> +- the supported chips are mt2701, mt7623 and mt8173
>  - reg: Physical base address and length of the module's registers
>  - clocks: PLL reference clock
>  - clock-names: must contain "pll_ref"
> --
> 2.25.1
>
