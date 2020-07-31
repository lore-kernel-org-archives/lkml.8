Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA12CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9019D22B43
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596219800;
	bh=VilWmQr2X1SanUoBwQNINfW0/u66qIbc1N367v/dd9E=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=h1Lc41FvURREiYn35qSlSOBC3T8vM99GQXfXOa9fRvKQN8EjE4vTz1x0iESMM/rYB
	 uYMIvCzMwb7qdmTs4t6EzhlX4jcsH2UMC6z+DzhfEHh8L+sz6NnJf64yAeuJVptoDi
	 JwUhebUdsjl3iYm4gKZIwbdStWVQIrXhlpA9x1gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbgGaSXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:23:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33695 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:23:19 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so32581674ion.0;
        Fri, 31 Jul 2020 11:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CGQZVvC23cLLHBAeXjXhXvK/cZaKYxFm+51RJfCopiY=;
        b=VqM981brEZeVC8IC8dwOc7i7CZ+vDyMIX6M2jDx8gOHERNUy61tqRhbtKrAVKELzj1
         Wqqy53QOHyjndZ5NKMzls9YEnWtEJcniKlepBUwtomMXzRKKTKJ1KY2RbvlJwEvLjtz4
         3iKvYJnUMUv9NfitJ5Mj3gI3jkoJkgOqWP+iPVHGdcQipfpGqYhT/56DT0DxAkvIxbaq
         jqquGOQrGeo83Kes/bOoOnftA3ssnZL4DjDJEl0mISqD59meVj4iHIMUF/kyxlm2TQR2
         fLc/YTkVrqnp5m2wADK/lV3XMEsTVUN2Tenycev5x+OlK6/9KoM8KhU4whVIli8SN1yS
         3jBQ==
X-Gm-Message-State: AOAM530RERUVVbuZQ4KbeCalaGLXlktWDGOQ6Uw++SpoYHU70SxNawMK
        B3QvoFQJDI372+H34disjw==
X-Google-Smtp-Source: ABdhPJyB17kdNJCzKqL7LcUJRwq/TbwNChek1YnLnnrYRCa2lwkMkKZ9/m5XIVReH7azH6UeAQdNOg==
X-Received: by 2002:a5e:c316:: with SMTP id a22mr4763149iok.57.1596219797902;
        Fri, 31 Jul 2020 11:23:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u3sm5145028ilq.37.2020.07.31.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:23:17 -0700 (PDT)
Received: (nullmailer pid 525392 invoked by uid 1000);
        Fri, 31 Jul 2020 18:23:16 -0000
Date:   Fri, 31 Jul 2020 12:23:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@armlinux.org.uk, w@1wt.eu
Subject: Re: [RFC PATCH 1/3] dt: bindings: interrupt-controller: Add binding
 description for msc313-intc
Message-ID: <20200731182316.GB520811@bogus>
References: <20200730130044.2037509-1-daniel@0x0f.com>
 <20200730130044.2037509-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730130044.2037509-2-daniel@0x0f.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:00:42PM +0900, Daniel Palmer wrote:
> Adds a YAML description of the binding for the msc313-intc.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Tested-by: Willy Tarreau <w@1wt.eu>
> ---
>  .../mstar,msc313-intc.yaml                    | 79 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml
> new file mode 100644
> index 000000000000..e87c72d452c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 thingy.jp.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/interrupt-controller/mstar,msc313-intc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MStar/SigmaStar ARMv7 SoC Interrupt Controller Device Tree Bindings
> +
> +maintainers:
> +  - Daniel Palmer <daniel@thingy.jp>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  "#interrupt-cells":
> +    const: 2
> +
> +  compatible:
> +    enum:
> +      - mstar,msc313-intc-irq
> +      - mstar,msc313-intc-fiq
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  mstar,gic-offset:
> +    description:
> +      Offset added to the intc irq number to get the parent GIC irq.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 255
> +
> +  mstar,nr-interrupts:
> +    description:
> +      Number of interrupt lines this intc has.

Generally, no other interrupt controller needs this type of property, 
why do you?

Can't this be implied by the compatible string? Same question for 
mstar,gic-offset.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 255
> +
> +required:
> +  - "#interrupt-cells"
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - mstar,gic-offset
> +  - mstar,nr-interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    intc_fiq: intc@201310 {
> +        compatible = "mstar,msc313-intc-fiq";
> +        interrupt-controller;
> +        reg = <0x201310 0x40>;
> +        #interrupt-cells = <2>;
> +        interrupt-parent = <&gic>;
> +        mstar,gic-offset = <96>;
> +        mstar,nr-interrupts = <32>;
> +    };
> +
> +  - |
> +    intc_irq: intc@201350 {
> +        compatible = "mstar,msc313-intc-irq";
> +        interrupt-controller;
> +        reg = <0x201350 0x40>;
> +        #interrupt-cells = <2>;
> +        interrupt-parent = <&gic>;
> +        mstar,gic-offset = <32>;
> +        mstar,nr-interrupts = <64>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b35edac7ef7..cf64b4b90222 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2140,6 +2140,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  W:	http://linux-chenxing.org/
>  F:	Documentation/devicetree/bindings/arm/mstar/*
> +F:	Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml
>  F:	arch/arm/boot/dts/infinity*.dtsi
>  F:	arch/arm/boot/dts/mercury*.dtsi
>  F:	arch/arm/boot/dts/mstar-v7.dtsi
> -- 
> 2.27.0
> 
