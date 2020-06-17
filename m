Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAFBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAE92088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592425330;
	bh=xNE9XSOvhghCOem7BB7ItlRidhpb63R/mvntoncsZiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A+H0DNdv6rzK8iBDlN1Gb1B0pnJdhMETpz3XBCCUvi71Ok7xn/auwD8q4JRBZaVzo
	 IGtw+0W4n32asn5QsuuRqXbP+qa/ArQHtvoU66dneUaaqf/2kH3lp/HQ3sRtZijA5u
	 nNH1RCkx2CMNFIoFKbUFmyndmhsEIpt8Nyg6strg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFQUWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQUWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:22:08 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3124E217D9;
        Wed, 17 Jun 2020 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592425327;
        bh=xNE9XSOvhghCOem7BB7ItlRidhpb63R/mvntoncsZiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cM/8adJS/CfoBabKgs5smCjZMrm8f4R2wBu/gfpLBZYw+kKE8o3U72M3S583OKTjP
         PCrAgGaKQQvjKKN85m9N2/+zEAPa/OWP+SnRpU8VVUEdGURnzSYRgx2brhjdwglSNO
         GbFlg7PGff1nb9Qr5CibEyTntz1Xma5RKY/dSU2Q=
Received: by mail-oi1-f171.google.com with SMTP id 25so2927693oiy.13;
        Wed, 17 Jun 2020 13:22:07 -0700 (PDT)
X-Gm-Message-State: AOAM532aiIXPZdMvtpJZ2gGovaCO6Dvwr0lJz/dCgRp7hh1IkL2a6Htm
        nUgm+B2EoEvxi43vRA4/vz3pfL8WZJ6k6ji05Q==
X-Google-Smtp-Source: ABdhPJzi4G/SG7UPJZAtkdxWsR+QkKnM2jLwSEKoazMNV1MrKFH3VVff+tCgS2ag5HdiA3cWgQIOgK9y06+Tn3frHYE=
X-Received: by 2002:aca:1e0b:: with SMTP id m11mr388478oic.147.1592425326440;
 Wed, 17 Jun 2020 13:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <2dc6384c945c7d35ab4f75464d3a77046dc125b3.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <2dc6384c945c7d35ab4f75464d3a77046dc125b3.1590594512.git-series.maxime@cerno.tech>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 17 Jun 2020 14:21:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+pZebUgG_fyQkhhbp2khVc+L-kJ2D2O8BiO6SyjfAK_Q@mail.gmail.com>
Message-ID: <CAL_Jsq+pZebUgG_fyQkhhbp2khVc+L-kJ2D2O8BiO6SyjfAK_Q@mail.gmail.com>
Subject: Re: [PATCH v3 006/105] dt-bindings: display: Convert VC4 bindings to schemas
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 9:49 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> The BCM283x SoCs have a display pipeline composed of several controllers
> with device tree bindings that are supported by Linux.
>
> Now that we have the DT validation in place, let's split into separate
> files and convert the device tree bindings for those controllers to
> schemas.
>
> This is just a 1:1 conversion though, and some bindings were incomplete so
> it results in example validation warnings that are going to be addressed in
> the following patches.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt              | 174 +------------------------------------------------------------------------
>  Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml         |  66 +++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml        |  73 ++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml        |  75 +++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml         |  37 +++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml |  40 +++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml         |  37 +++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml         |  42 +++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml         |  34 ++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml         |  44 ++++++++++++++++++-
>  MAINTAINERS                                                             |   2 +-
>  11 files changed, 449 insertions(+), 175 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml

Not sure why my checks didn't catch this, but now linux-next has these warnings:

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.example.dt.yaml:
panel: compatible: Additional items are not allowed ('simple-panel'
was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.example.dt.yaml:
panel: compatible: ['ontat,yx700wv03', 'simple-panel'] is too long
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.example.dt.yaml:
panel: 'power-supply' is a required property
