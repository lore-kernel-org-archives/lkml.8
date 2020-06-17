Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE15AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4C121841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592428495;
	bh=XcA4xzYENQ6SANu6gC9NUhvy4ytunT2WsIxX9DUqD+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hu/nTh1p7cOWAd5f7UdyDfJLHtkCuf5o959NBNgwKIlbjRdIJWIjCZMRyo8MOT8cV
	 M2r4rkz8hq184yTpgx3YI2ABdLrc0s4JZRUMk0q5IXtU8vQgA4Va5Wy90nqUTK54dB
	 nbbtSxDLtrfU1vUSyMFtu5Tga9+OFwe1u5Hit3V4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgFQVOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:14:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33172 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:14:53 -0400
Received: by mail-io1-f66.google.com with SMTP id i25so4701932iog.0;
        Wed, 17 Jun 2020 14:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWO5LGmEg8Ig2cq5eIpV/Gm4FJwOWAH3M+GOgTvadrI=;
        b=gIvt3qwn7jOJ0kjjVOQFPUxPwME1hr18i1gRwCjeFEjOKAFVWc0RIyo/euoQYFkpsA
         ECFc9ERazE2vsYdEtMe/VTHGAP5ueqSIn+Abpit6f0iFoW1cimcUw3dvyTvtgpQWjkgs
         bEdGDx3zsbT5CWzXlxMH+xUKC5EwB1MA/O4xTLzubG0fBYlh7W+JYxpbPtLHEUCg3eMM
         YZhjs+QXSsQKlxAZ/v9L3UBF3ak7rHxGaGyur7m0jtwcbhF1QXPLteK/gKY9vtNSQ/gk
         M8zsRfYsjQ5nR7sWGGuyOpnYqpIGeoMBRZ+octLM3PUVQ7nGiJth6VKBl1Dhjppv6CKY
         08rw==
X-Gm-Message-State: AOAM530Cord29/cSNX3XfNFSqxJ/gjk0BjMj6h6zV9YkPnq8XuxDxD/p
        I58E4bD9xhOh+7/Z+Ug32hhETC8hXw==
X-Google-Smtp-Source: ABdhPJy7XP0pSsuCKM5EibaN3mFwRa16qdK+sQARWZ0lMWqklFY1HprY+VlevFhTg9YxT29C3724dQ==
X-Received: by 2002:a05:6602:809:: with SMTP id z9mr1454740iow.79.1592428491937;
        Wed, 17 Jun 2020 14:14:51 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w15sm430303ilj.21.2020.06.17.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:14:51 -0700 (PDT)
Received: (nullmailer pid 2834025 invoked by uid 1000);
        Wed, 17 Jun 2020 21:14:50 -0000
Date:   Wed, 17 Jun 2020 15:14:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND
 flash controller
Message-ID: <20200617211450.GA2811091@bogus>
References: <20200609074020.23860-1-yifeng.zhao@rock-chips.com>
 <20200609074020.23860-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609074020.23860-2-yifeng.zhao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 03:40:18PM +0800, Yifeng Zhao wrote:
> Documentation support for Rockchip RK3xxx NAND flash controllers
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v6:
> - Fix some wrong define
> - Modified the definition of compatible
> 
> Changes in v5:
> - Fix some wrong define
> - Add boot-medium define
> - Remove some compatible define
> 
> Changes in v4:
> - The compatible define with rkxx_nfc
> - Add assigned-clocks
> - Fix some wrong define
> 
> Changes in v3:
> - Change the title for the dt-bindings
> 
> Changes in v2: None
> 
>  .../mtd/rockchip,nand-controller.yaml         | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> new file mode 100644
> index 000000000000..f753fe8248aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/rockchip,nand-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip SoCs NAND FLASH Controller (NFC)
> +
> +allOf:
> +  - $ref: "nand-controller.yaml#"
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: rockchip,px30-nfc
> +      - const: rockchip,rk2928-nfc
> +      - const: rockchip,rv1108-nfc
> +      - items:
> +          - const: rockchip,rk3326-nfc
> +          - const: rockchip,px30-nfc
> +      - items:
> +          - const: rockchip,rk3036-nfc
> +          - const: rockchip,rk2928-nfc
> +      - items:
> +          - const: rockchip,rk3308-nfc
> +          - const: rockchip,rv1108-nfc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: ahb
> +      - const: nfc
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-rates:
> +    maxItems: 1
> +
> +  pinctrl-0:
> +    maxItems: 1
> +
> +  pinctrl-names:
> +    const: default

You can drop pinctrl-*. They are automatically supported.

> +
> +  power-domains:
> +     maxItems: 1
> +
> +patternProperties:
> +  "^nand@[a-f0-9]$":

'[0-7]' is correct here.

Out of bounds nodes and other unknown properties should be prevented 
with 'unevaluatedProperties: false' (though not yet until the tooling 
supports it).

> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 7
> +
> +      nand-ecc-mode:
> +        const: hw
> +
> +      nand-ecc-step-size:
> +        const: 1024
> +
> +      nand-ecc-strength:
> +        enum: [16, 24, 40, 60, 70]
> +        description:
> +          The ECC configurations that can be supported are as follows.
> +          - NFCv900(PX30 and RK3326) support ecc strength 16, 40, 60 and 70.
> +          - NFCv600(RK3066 and RK2928) support ecc strength 16, 24, 40 and 60.
> +          - NFCv622(RK3036 and RK3128) support ecc strength 16, 24, 40 and 60.
> +          - NFCv800(RK3308 and RV1108) support ecc strength 16.
> +
> +      nand-bus-width:
> +        const: 8
> +
> +      rockchip,boot-blks:
> +        minimum: 2
> +        default: 16
> +        allOf:
> +        - $ref: /schemas/types.yaml#/definitions/uint32

You can drop 'allOf' now.

> +        description:
> +          The NFC driver need this information to select ECC
> +          algorithms supported by the BOOTROM.
> +          Only used in combination with 'nand-is-boot-medium'.
> +
> +      rockchip,boot-ecc-strength:
> +        enum: [16, 24, 40, 60, 70]
> +        allOf:
> +        - $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          If specified it indicates that a different BCH/ECC setting is
> +          supported by the BOOTROM.
> +          - NFCv900(PX30 and RK3326) support ecc strength 16 and 70.
> +          - NFCv600(RK3066 and RK2928) support ecc strength 16, 24, 40 and 60.
> +          - NFCv622(RK3036 and RK3128) support ecc strength 16, 24, 40 and 60.
> +          - NFCv800(RK3308 and RV1108) support ecc strength 16.
> +          Only used in combination with 'nand-is-boot-medium'.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3308-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    nfc: nand-controller@ff4b0000 {
> +      compatible = "rockchip,rk3308-nfc",
> +                   "rockchip,rv1108-nfc";
> +      reg = <0x0 0xff4b0000 0x0 0x4000>;
> +      interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
> +      clock-names = "ahb", "nfc";
> +      assigned-clocks = <&clks SCLK_NANDC>;
> +      assigned-clock-rates = <150000000>;
> +
> +      pinctrl-0 = <&flash_ale &flash_bus8 &flash_cle &flash_csn0
> +                   &flash_rdn &flash_rdy &flash_wrn>;
> +      pinctrl-names = "default";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      nand@0 {
> +        reg = <0>;
> +        label = "rk-nand";
> +        nand-bus-width = <8>;
> +        nand-ecc-mode = "hw";
> +        nand-ecc-step-size = <1024>;
> +        nand-ecc-strength = <16>;
> +        nand-is-boot-medium;
> +        rockchip,boot-blks = <8>;
> +        rockchip,boot-ecc-strength = <16>;
> +      };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
> 
> 
