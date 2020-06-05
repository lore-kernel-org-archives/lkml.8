Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F309C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0984A2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="BaYt+8sL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFENVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgFENVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:21:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A02DC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:21:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so11738340ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=npO6Xx111vYtSO61NgRog+dLyg7Zh/nU9iarUcpFEzo=;
        b=BaYt+8sLySFAo/AJdgsrU0i42aIMZuELEwCmtWYbAkMOR9MT3sfPHT/goQGqDX6u9N
         ujgFLYkOs9lnYHNPrnDmPviKxyRhPa3wAdfpzpnokUOr1nHduLp37/2VCzS3UewtTaH+
         9YMKCz069P3CEmOhLRACg8jpPvk5+zUFMjxup8UhoF4l4LxUCqslQAa/yzA42uZL4Iap
         UCKtjFnTdCgaSl2OunhW7CRgW/4nggaMlTMU+Tv0sgQj0L7CU+vPSDAX72XtnM7vIQxy
         Z9ihme+PD83mLeflboO9MDhhXmVoJvfUaR5RKNYqFubacLwfIrj+sKnDnQSXNYzo07n0
         Wz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=npO6Xx111vYtSO61NgRog+dLyg7Zh/nU9iarUcpFEzo=;
        b=C3iTTM0UIrFQ8TnsBHrsxuQmnd5+dFLvLgzGnber0YZo/fnfsViMO/vBzLR/86t8H1
         n8TwyVdY+p/Nh5VqvMoh9vNsetGFd4/HNRNwAgt6ieDE6xbY5FTYwOsBFlRXB05FvzHB
         dnOIYACXwZTUQ0URlaSuqcUYXO1Z0HIOvQFq0ehu+iUj+mDy4Gl6YfBYR2RlFfiQXDs3
         E3b0Mw4/cin9ufxWb/ryMWdrx0DLTMgbOPzOKVhMKE6YLulZJGn1YA3R+YVgH2Sk2Noi
         XRT8X7kgE2RzCXhc6Co8lSHzElFZilXt/SIEU5CUyhomFBHlMlTJ/w5cQdhq0vmVXIgS
         9emA==
X-Gm-Message-State: AOAM530KacErAzJYGVwif6fhcFUIuunAeIV/QQnw0X5iu9sGqv1q0EvQ
        9EaDYLQrsOAPO5lrGCtHOe6H9w==
X-Google-Smtp-Source: ABdhPJwCA5uqky+cVncXQ8y6SrBtfMTJs/nFlEH5EUPIWrkmswBKE9ncxkN1e4NHB18RN/s6Wrsj1g==
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr1210036ljk.44.1591363295925;
        Fri, 05 Jun 2020 06:21:35 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id x69sm920805lff.19.2020.06.05.06.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:21:34 -0700 (PDT)
Date:   Fri, 5 Jun 2020 15:21:34 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: irqchip: renesas-rza1-irqc: Convert to
 json-schema
Message-ID: <20200605132134.GA385628@oden.dyn.berto.se>
References: <20200528132853.1751-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528132853.1751-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2020-05-28 15:28:53 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas RZ/A1 Interrupt Controller Device Tree binding
> documentation to json-schema.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Validation depends on "[PATCH dt-schema] Fix interrupt controllers with
> interrupt-map".
> http://lore.kernel.org/r/20200528132323.30288-1-geert+renesas@glider.be
> ---
>  .../renesas,rza1-irqc.txt                     | 43 ----------
>  .../renesas,rza1-irqc.yaml                    | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
> deleted file mode 100644
> index 727b7e4cd6e01110..0000000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -DT bindings for the Renesas RZ/A1 Interrupt Controller
> -
> -The RZ/A1 Interrupt Controller is a front-end for the GIC found on Renesas
> -RZ/A1 and RZ/A2 SoCs:
> -  - IRQ sense select for 8 external interrupts, 1:1-mapped to 8 GIC SPI
> -    interrupts,
> -  - NMI edge select.
> -
> -Required properties:
> -  - compatible: Must be "renesas,<soctype>-irqc", and "renesas,rza1-irqc" as
> -		fallback.
> -		Examples with soctypes are:
> -		  - "renesas,r7s72100-irqc" (RZ/A1H)
> -		  - "renesas,r7s9210-irqc" (RZ/A2M)
> -  - #interrupt-cells: Must be 2 (an interrupt index and flags, as defined
> -				 in interrupts.txt in this directory)
> -  - #address-cells: Must be zero
> -  - interrupt-controller: Marks the device as an interrupt controller
> -  - reg: Base address and length of the memory resource used by the interrupt
> -         controller
> -  - interrupt-map: Specifies the mapping from external interrupts to GIC
> -		   interrupts
> -  - interrupt-map-mask: Must be <7 0>
> -
> -Example:
> -
> -	irqc: interrupt-controller@fcfef800 {
> -		compatible = "renesas,r7s72100-irqc", "renesas,rza1-irqc";
> -		#interrupt-cells = <2>;
> -		#address-cells = <0>;
> -		interrupt-controller;
> -		reg = <0xfcfef800 0x6>;
> -		interrupt-map =
> -			<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -			<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> -			<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -			<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -			<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -			<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -			<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -			<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-map-mask = <7 0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.yaml
> new file mode 100644
> index 0000000000000000..755cdfabfcd06c85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,rza1-irqc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/A1 Interrupt Controller
> +
> +maintainers:
> +  - Chris Brandt <chris.brandt@renesas.com>
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +description: |
> +  The RZ/A1 Interrupt Controller is a front-end for the GIC found on Renesas RZ/A1 and
> +  RZ/A2 SoCs:
> +    - IRQ sense select for 8 external interrupts, 1:1-mapped to 8 GIC SPI interrupts,
> +    - NMI edge select.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r7s72100-irqc # RZ/A1H
> +          - renesas,r7s9210-irqc  # RZ/A2M
> +      - const: renesas,rza1-irqc
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  '#address-cells':
> +    const: 0
> +
> +  interrupt-controller: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-map:
> +    maxItems: 8
> +    description: Specifies the mapping from external interrupts to GIC interrupts.
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 7
> +      - const: 0
> +
> +required:
> +  - compatible
> +  - '#interrupt-cells'
> +  - '#address-cells'
> +  - interrupt-controller
> +  - reg
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    irqc: interrupt-controller@fcfef800 {
> +            compatible = "renesas,r7s72100-irqc", "renesas,rza1-irqc";
> +            #interrupt-cells = <2>;
> +            #address-cells = <0>;
> +            interrupt-controller;
> +            reg = <0xfcfef800 0x6>;
> +            interrupt-map =
> +                    <0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                    <1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                    <2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                    <3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                    <4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                    <5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                    <6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                    <7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-map-mask = <7 0>;
> +    };
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
