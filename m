Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7BBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A0420872
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598571109;
	bh=BjPccaFPfwZJ/MfjC8dMfdnImTr+XTKV9scKCJijFtI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UMLJgsl+UcmcQbcAOrMWPF5Unc//KTJzcA35aQJLdakgwKPJtjj1cl5VVzKxGjpJt
	 wnefji1DJaciL5FjvCz2qYRumiCCLyoNlqQppspn0rZdU98tSDSqV7xXQr/iSLX/T+
	 2a/T4WYMqJbgZnn7tR2dm1RAgHeiNUveUzKJsvYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgH0Xbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH0Xbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 19:31:47 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89967208C9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598571106;
        bh=BjPccaFPfwZJ/MfjC8dMfdnImTr+XTKV9scKCJijFtI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YOG/7ZrlaZzzJgTtYvJi+bJ8f7TpYeE6YlVE2ZVzHig0mrFIstP1vejUeEOctYoVI
         K7ms6V5EOE9EftV0AeMleQE0JXeGx4lOD9feJSEixNhhy0hdNNqX8UOrzJQLbJDYtr
         Zeu5bRnXS0cKiDIKCgVqkjcz1mz2k2UQNQIMOCz8=
Received: by mail-ej1-f54.google.com with SMTP id m22so9908405eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:31:46 -0700 (PDT)
X-Gm-Message-State: AOAM5310LlizvIWirXdwugq9Al1nI56BrZNR3FHYploFHPYTGgPb6j5x
        1UNuvWWOLyrY/0BVKT/pbZK2knmHTfv4HSiRoA==
X-Google-Smtp-Source: ABdhPJz7iGlzoSU0rP3TYayWIZDMjV8NBQSzqq+G0LfQWQ1CD7evxQy7VbZ+S3BaM8YPgtqNIvuZPCDMLtC9cTBqLPs=
X-Received: by 2002:a17:906:15cc:: with SMTP id l12mr24291379ejd.7.1598571105087;
 Thu, 27 Aug 2020 16:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200819081752.4805-1-linux@fw-web.de> <20200819081752.4805-2-linux@fw-web.de>
In-Reply-To: <20200819081752.4805-2-linux@fw-web.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 28 Aug 2020 07:31:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9+yamENvGDHTDHd8Jvy_2hbko2YaBEcdetsZHD5+FVrA@mail.gmail.com>
Message-ID: <CAAOTY_9+yamENvGDHTDHd8Jvy_2hbko2YaBEcdetsZHD5+FVrA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: mediatek: add mt7623 display-nodes
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <linux@fw-web.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> mt7623 uses mt2701/mt8173 for drm, but have own compatibles
>

For this patch, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
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
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
