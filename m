Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504F4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BED32087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596231033;
	bh=NHsr3aFIVXcbgVNcABj+122r90mMVIkb6+W2zQXbddw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JmIhRV6pA927+8V4O5blsoQGf7KtF60pVvPH9TS/wW9yYsJuG1ZRC0yKQ78Sc3SA5
	 mV4JI4Cp9sHgM+KlOK8OiexICxQ2I7Q6J+Grq3lLfggJDkGdXkEcYgg0W07DSyTHRz
	 TzMgiL3iCd7Evb7iqKDBYBa3bK5vYw/XvjcJB4GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgGaVac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:30:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45066 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgGaVab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:30:31 -0400
Received: by mail-io1-f68.google.com with SMTP id e64so33030323iof.12;
        Fri, 31 Jul 2020 14:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1TGdSM7ebRYhzsfJccNqgk5kV9sG3dUDdM4DYu83Fw=;
        b=lsed4E8QbpJ03lvZjtNhqd5CJOiGre4CupwB1JlneF1/lcQcSXWktjaN3kWrZb+/OP
         79gp8QSW0irq1Xukqug4O9KndQKSVYTaetvHBaraNxMf5fQfctCM9z8XBE5sqklZh1Bm
         aUCj9GUBgChXoCf0v0n7rbbKBHW4X4GrKXxC69GlSk8kv09nIRo5qzXxH8c9RIEJXy0s
         hO8D7VtB7Y0cKGbyFmz+b3OgYRAJy8hPjyQMbS37ghx8lY8wRz6W26ZVp/1qFsUz7s36
         R7vzegyWiW3tIBOF4jIhYmPVAjL8K6ravpF/zUX7K23P12BNwgyY+rKtIumbXahoCgxb
         hf2w==
X-Gm-Message-State: AOAM530gqYkufbDbT24WD1x91hYpAWTuTihr/3ACx+/iYtL8IvbUXZ4+
        vKO1GlOqbpBS3WheREMDiQ==
X-Google-Smtp-Source: ABdhPJxXeVS0jZueBStQpy+cdWH/c/tpvRGzhw0OjxjNfquqY5ZbETuEj8pXTjXPXY5xHhqTIYPArg==
X-Received: by 2002:a02:84ac:: with SMTP id f41mr2890486jai.56.1596231030696;
        Fri, 31 Jul 2020 14:30:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i9sm5682020ile.48.2020.07.31.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:30:30 -0700 (PDT)
Received: (nullmailer pid 827984 invoked by uid 1000);
        Fri, 31 Jul 2020 21:30:28 -0000
Date:   Fri, 31 Jul 2020 15:30:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: add DT bindings for Microchip
 S/PDIF TX Controller
Message-ID: <20200731213028.GA824739@bogus>
References: <20200729101922.3033616-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729101922.3033616-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:19:21PM +0300, Codrin Ciubotariu wrote:
> This patch adds DT bindings for the new Microchip S/PDIF TX Controller
> embedded inside sama7g5 SoCs.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2:
>  - replaced https with http
>  - reworked example, included bindings;
> 
>  .../bindings/sound/mchp,spdiftx.yaml          | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
> new file mode 100644
> index 000000000000..2b7c27391f0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mchp,spdiftx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip S/PDIF Tx Controller Device Tree Bindings
> +
> +maintainers:
> +  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> +
> +description:
> +        The Microchip Sony/Philips Digital Interface Transmitter is a
> +        serial port compliant with the IEC-60958 standard.
> +
> +properties:
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  compatible:
> +    oneOf:
> +      - const: microchip,sama7g5-spdiftx

No need for 'oneOf' when only 1 entry.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Peripheral Bus Clock
> +      - description: Generic Clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: gclk
> +
> +  dmas:
> +    description: TX DMA Channel

How many? (maxItems: 1)

> +
> +  dma-names:
> +    const: tx
> +
> +  pinctrl-0: true
> +
> +  pinctrl-names:
> +    const: default

You can drop pinctrl props. They are always allowed.

> +
> +required:
> +  - "#sound-dai-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/dma/at91.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spdiftx@e1618000 {
> +        #sound-dai-cells = <0>;
> +        compatible = "microchip,sama7g5-spdiftx";
> +        reg = <0xe1618000 0x4000>;
> +        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas = <&dma0 AT91_XDMAC_DT_PERID(50)>;
> +        dma-names = "tx";
> +        clocks = <&pmc PMC_TYPE_PERIPHERAL 85>, <&pmc PMC_TYPE_GCK 85>;
> +        clock-names = "pclk", "gclk";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_spdiftx_default>;
> +    };
> -- 
> 2.25.1
> 
