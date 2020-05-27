Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99937C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811CF208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590606736;
	bh=hlQl/x2jvrjp/1keBpISAGM26d0xgeTYrKjSpkurpCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bFtUsAXeLg16L0cRUA0BbX5pbv1FG1SsztD310ywk0SVA7sEYYrK93lebKHGqLQrt
	 2hPu2f7CiMcyw97znNdq5ApA1E2FdBP9BlfpwzRKHvBGEg1aIxxWyKHFw6lqG+cJ8X
	 z7J54ujSfOPweu/sHOtAXJvSXu+vEJ3MTkWAb1/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgE0TMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:12:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35131 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE0TMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:12:15 -0400
Received: by mail-io1-f65.google.com with SMTP id s18so13374729ioe.2;
        Wed, 27 May 2020 12:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bcgn8vintUmn/KLNjY166boSuempda8GQiMOp/S9kfA=;
        b=areBso00ykwIV9rOohsu8RM6rRdm6IxweVOecJl4iOlovX+sC6F5ONKhSTDWTuS3Eg
         tN0gUAofwKXlTw4picWW8OIdbvPKgSogoCv4U205x9R31ReztGC0qy3d4vxwB6hmq1AC
         8TUApBUeYqAdiWw9OuLcKj8t7nohuCi+kV+AwgmTwM3FpTNjxwulLipiIj0O1oYUn0f9
         b07ek0h27YH06gLrKLrlpC6vDVPfBNY/ggMmdv4fYn9ylVv6GMvmuPp6y6zkSjFPPg3Y
         iaHe/23tu2pxamDoeCyHRcPFsmwVj0Uay8KxJXtCXS20BR40IDkbIpipo8EdNM7lD7ui
         0d5Q==
X-Gm-Message-State: AOAM530YU5NCR8NeaYsCuWglZgsyKPGRIxiRDMGtbrT1hhsbFAdoLF7c
        0zR+khmSucg6dnz2PNi04PDstBM=
X-Google-Smtp-Source: ABdhPJz3OUlhVOntgWTwiyD9K0iT6Dx6LzGlpf8nvq36l0+6hwUoaK1G46ggh/RhOEPZ+ELiB1RfTQ==
X-Received: by 2002:a5e:aa14:: with SMTP id s20mr10199282ioe.58.1590606733230;
        Wed, 27 May 2020 12:12:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v15sm2083078ila.57.2020.05.27.12.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:12:12 -0700 (PDT)
Received: (nullmailer pid 2570767 invoked by uid 1000);
        Wed, 27 May 2020 19:12:11 -0000
Date:   Wed, 27 May 2020 13:12:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 006/105] dt-bindings: display: Convert VC4 bindings to
 schemas
Message-ID: <20200527191211.GA2559189@bogus>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <2dc6384c945c7d35ab4f75464d3a77046dc125b3.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dc6384c945c7d35ab4f75464d3a77046dc125b3.1590594512.git-series.maxime@cerno.tech>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 05:47:36PM +0200, Maxime Ripard wrote:
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


> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> new file mode 100644
> index 000000000000..3887675f844e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/brcm,bcm2835-dsi0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom VC4 (VideoCore4) DSI Controller
> +
> +maintainers:
> +  - Eric Anholt <eric@anholt.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2835-dsi0
> +      - brcm,bcm2835-dsi1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: The DSI PLL clock feeding the DSI analog PHY
> +      - description: The DSI ESC clock
> +      - description: The DSI pixel clock
> +
> +  clock-output-names: true
> +    # FIXME: The meta-schemas don't seem to allow it for now
> +    # items:
> +    #   - description: The DSI byte clock for the PHY
> +    #   - description: The DSI DDR2 clock
> +    #   - description: The DSI DDR clock

Doesn't pattern work for you?

pattern: '^dsi[0-1]_byte$'

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
