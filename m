Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D73C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3F8206D4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596561762;
	bh=Xoip3bOYIImGhy7ogd9kynyso6cxechck06IVDrtLW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BrUOzdKWSJ3jUpd7aBlYR9SmirtGJYGOrZer1g63xI3Y4zYN1gDjwphqSxeuaBEuf
	 n+NEtFzkwuMEYEyjNkTTGYlBnydYLLz4WuLPksPQKgqkGuyjOmshF2LUzBBZqj+rvP
	 c2fz5xbAMJA8l1B7fDgz0c9MAJxG5zVm7g9ngSQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgHDRWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgHDRWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:22:40 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E51121744;
        Tue,  4 Aug 2020 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596561759;
        bh=Xoip3bOYIImGhy7ogd9kynyso6cxechck06IVDrtLW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z+7sr2ZWgk+EKMuu+lTtzdVoIX9WLhXg2tgNLJo08WroVrlO10uHXblY4NKS/vZb1
         Q7vxKuyAMR8TACbBPMc23u8Qbpsli3avO2zBd5Vxdtt9f0QgBGe+kpYHhGtILJfg3c
         dhOJRJ2wdu/MsQRautvAfLtzmPJT7Dl9z802SUEg=
Received: by mail-oi1-f181.google.com with SMTP id u24so27146500oiv.7;
        Tue, 04 Aug 2020 10:22:39 -0700 (PDT)
X-Gm-Message-State: AOAM532R8LhVZuHggLcH5jGIeovghw0lk8PvOADfpVOvF/mDNOZlZsvW
        atCJEaxmsA+YfUuIT9ADWqcYC7Z0sCcquyRIyA==
X-Google-Smtp-Source: ABdhPJwkisncqagQYnRqj5kYxbVToGGengOKjQOWBvV6rwXKDIFKaESd49zyc6uwCxQY+hCjnV7BMm8OuxgHZCg7q+E=
X-Received: by 2002:aca:bb82:: with SMTP id l124mr4339078oif.106.1596561758805;
 Tue, 04 Aug 2020 10:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200804165555.75159-1-linux@fw-web.de> <20200804165555.75159-2-linux@fw-web.de>
 <trinity-aa434d4a-b151-4595-93cc-a222bf12522d-1596561528040@3c-app-gmx-bap28>
In-Reply-To: <trinity-aa434d4a-b151-4595-93cc-a222bf12522d-1596561528040@3c-app-gmx-bap28>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 4 Aug 2020 11:22:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+bQccA5u8ohh24oUSmhPA_+kE9Q_S_yUL-8nizVWK4-A@mail.gmail.com>
Message-ID: <CAL_Jsq+bQccA5u8ohh24oUSmhPA_+kE9Q_S_yUL-8nizVWK4-A@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: mediatek: add mt7623 display-nodes
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 11:19 AM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> CC Rob Herring and devicetree-list

Resend or it is not in my patchwork queue.

But this is simple enough:

Acked-by: Rob Herring <robh@kernel.org>

>
> > Gesendet: Dienstag, 04. August 2020 um 18:55 Uhr
> > Von: "Frank Wunderlich" <linux@fw-web.de>
> > An: linux-mediatek@lists.infradead.org
> > Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Chun-Kuang Hu" <chun=
kuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>, "David Airl=
ie" <airlied@linux.ie>, "Daniel Vetter" <daniel@ffwll.ch>, "Matthias Brugge=
r" <matthias.bgg@gmail.com>, dri-devel@lists.freedesktop.org, linux-arm-ker=
nel@lists.infradead.org, linux-kernel@vger.kernel.org
> > Betreff: [PATCH v4 1/6] dt-bindings: mediatek: add mt7623 display-nodes
> >
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > mt7623 uses mt2701/mt8173 for drm, but have own compatibles
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,disp.txt    | 2 +-
> >  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt     | 2 +-
> >  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt     | 4 ++--
> >  .../devicetree/bindings/display/mediatek/mediatek,hdmi.txt    | 4 ++++
> >  4 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,di=
sp.txt
> > index b91e709db7a4..121220745d46 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.=
txt
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.=
txt
> > @@ -43,7 +43,7 @@ Required properties (all function blocks):
> >       "mediatek,<chip>-dpi"                   - DPI controller, see med=
iatek,dpi.txt
> >       "mediatek,<chip>-disp-mutex"            - display mutex
> >       "mediatek,<chip>-disp-od"               - overdrive
> > -  the supported chips are mt2701, mt2712 and mt8173.
> > +  the supported chips are mt2701, mt7623, mt2712 and mt8173.
> >  - reg: Physical base address and length of the function block register=
 space
> >  - interrupts: The interrupt signal from the function block (required, =
except for
> >    merge and split function blocks).
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi=
.txt
> > index 77def4456706..dc1ebd13cc88 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.t=
xt
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.t=
xt
> > @@ -7,7 +7,7 @@ output bus.
> >
> >  Required properties:
> >  - compatible: "mediatek,<chip>-dpi"
> > -  the supported chips are mt2701 , mt8173 and mt8183.
> > +  the supported chips are mt2701, mt7623, mt8173 and mt8183.
> >  - reg: Physical base address and length of the controller's registers
> >  - interrupts: The interrupt signal from the function block.
> >  - clocks: device clocks
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi=
.txt
> > index 8e4729de8c85..f06f24d405a5 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> > @@ -7,7 +7,7 @@ channel output.
> >
> >  Required properties:
> >  - compatible: "mediatek,<chip>-dsi"
> > -  the supported chips are mt2701, mt8173 and mt8183.
> > +- the supported chips are mt2701, mt7623, mt8173 and mt8183.
> >  - reg: Physical base address and length of the controller's registers
> >  - interrupts: The interrupt signal from the function block.
> >  - clocks: device clocks
> > @@ -26,7 +26,7 @@ The MIPI TX configuration module controls the MIPI D-=
PHY.
> >
> >  Required properties:
> >  - compatible: "mediatek,<chip>-mipi-tx"
> > -  the supported chips are mt2701, mt8173 and mt8183.
> > +- the supported chips are mt2701, 7623, mt8173 and mt8183.
> >  - reg: Physical base address and length of the controller's registers
> >  - clocks: PLL reference clock
> >  - clock-output-names: name of the output clock line to the DSI encoder
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,hdmi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,hd=
mi.txt
> > index 7b124242b0c5..6b1c586403e4 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.=
txt
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.=
txt
> > @@ -6,6 +6,7 @@ its parallel input.
> >
> >  Required properties:
> >  - compatible: Should be "mediatek,<chip>-hdmi".
> > +- the supported chips are mt2701, mt7623 and mt8173
> >  - reg: Physical base address and length of the controller's registers
> >  - interrupts: The interrupt signal from the function block.
> >  - clocks: device clocks
> > @@ -32,6 +33,7 @@ The HDMI CEC controller handles hotplug detection and=
 CEC communication.
> >
> >  Required properties:
> >  - compatible: Should be "mediatek,<chip>-cec"
> > +- the supported chips are mt7623 and mt8173
> >  - reg: Physical base address and length of the controller's registers
> >  - interrupts: The interrupt signal from the function block.
> >  - clocks: device clock
> > @@ -44,6 +46,7 @@ The Mediatek's I2C controller is used to interface wi=
th I2C devices.
> >
> >  Required properties:
> >  - compatible: Should be "mediatek,<chip>-hdmi-ddc"
> > +- the supported chips are mt7623 and mt8173
> >  - reg: Physical base address and length of the controller's registers
> >  - clocks: device clock
> >  - clock-names: Should be "ddc-i2c".
> > @@ -56,6 +59,7 @@ output and drives the HDMI pads.
> >
> >  Required properties:
> >  - compatible: "mediatek,<chip>-hdmi-phy"
> > +- the supported chips are mt2701, mt7623 and mt8173
> >  - reg: Physical base address and length of the module's registers
> >  - clocks: PLL reference clock
> >  - clock-names: must contain "pll_ref"
> > --
> > 2.25.1
> >
> >
