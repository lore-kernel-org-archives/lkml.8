Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B365C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E414206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiyjWfmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgFJKud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgFJKua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:50:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F2AC03E96B;
        Wed, 10 Jun 2020 03:50:30 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l27so2069189ejc.1;
        Wed, 10 Jun 2020 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LOmMo1Zuovj+Zdo3Z6XAOGDBaVFrsQ/9KBjzRPBjkbw=;
        b=GiyjWfmI0+ptsGdFAbKzEtUr39pL6sas8NRHV1Xd76jZIF3Z6efJq7Am0xk+mtqecp
         RBzYkBejER5rqGdUF5FDTuPBmCTyJ8kfSY5VMCGvvBf1YHmBUOz96fwcdN60zmVn/Gtx
         AkJD1GtPY13pj7jSdVsUcoT8aPKiUESRq0v0Zc5Tm6sPQQmH37bd5TN4NIsjEmrAF2hq
         Gpa/NspwU58SfewG5TJpINBV/bVa4gmOkBu5wgZTT0fr0CgwUDNOJAxVlvDY62rP3N4e
         0jG5k0aNSlXNiifMNoZnk1YQMxWOJKO9Pjai7q6cvtjoLdLBL+YRfY5ITLPrL2nGrTaG
         gnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOmMo1Zuovj+Zdo3Z6XAOGDBaVFrsQ/9KBjzRPBjkbw=;
        b=YErf7uTy+H2j+rzvVHCKomjo4fBTuAXcHoi9eoVtpPRqP74INPZvFrbzSGyS2d8SMm
         Gba4NILSKt9qHsvIBNMg/VPYYJc90NFTypBGgY3RZX0a0bM+bs96Pb8iyPWlV0smTw8d
         wE1iyv8uHQlMCD/+82a34tFVNV/p+bn6DsOmkCn+KGZbRK/280f+wnLEyWguPSS9mvGg
         oepQIc0xvtNO/0o0AWjRPLh0rBtVD3v1UncmWpr+Ct6LHgMYioYoWZamOEH0lu4hf9of
         +mpM1UHcVg8QqfTkYlnTLOpJpdNwV6z5JYAM4rPXcHVVCs4mpGF1b5VwmNrgLDxTFNoO
         LT0A==
X-Gm-Message-State: AOAM532rQ4wv2yDgo4zFt1X2o5i+MyLfz1I1sF+PUlwqHzn8Zn3u6LTF
        su5Vgezqx0QPf4XCSZnUcBmsJ3NZ
X-Google-Smtp-Source: ABdhPJzn4MZoGhaJASFC13nnCPNyWmnoV1PGRcwEhafs4sNzzcFECzbBLrwZnlIYOAb/FnrC0G3zcA==
X-Received: by 2002:a17:906:fa03:: with SMTP id lo3mr2872150ejb.196.1591786228594;
        Wed, 10 Jun 2020 03:50:28 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q12sm15184929ejn.23.2020.06.10.03.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 03:50:27 -0700 (PDT)
Subject: Re: [PATCH v6 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND
 flash controller
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200609074020.23860-1-yifeng.zhao@rock-chips.com>
 <20200609074020.23860-2-yifeng.zhao@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <e805f6c2-26a2-8163-d061-ce43026d4d3f@gmail.com>
Date:   Wed, 10 Jun 2020 12:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609074020.23860-2-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Just a few more comments (part 1).

About the name of the dts patches.

Currently this is used:
Subject [PATCH v6 6/8] arm: dts: rockchip: Add nfc dts for RV1108 SOC
Add nfc(nand flash controller) node for RV1108 Soc.

Dts is more file related. The patch adds a node, so maybe change it to:
Subject [PATCH v7 6/8] arm: dts: rockchip: Add nfc node for RV1108 SoC
Add NAND FLASH Controller(NFC) node for RV1108 SoC.

Johan

On 6/9/20 9:40 AM, Yifeng Zhao wrote:
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

In the mainline kernel rk3326.dtsi gets the nodes defined by including
px30.dtsi, so if nothing changed we don't need a compatible string for
rk3326. Or else add an extra patch to this serie where this compatible
string is needed.

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
> +
> +  power-domains:

> +     maxItems: 1

       ^
Use 2 spaces instead of 3.

> +
> +patternProperties:
> +  "^nand@[a-f0-9]$":
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

         NFC v600 ECC 16, 24, 40, 60
           RK2928, RK3066, RK3188

         NFC v622 ECC 16, 24, 40, 60
           RK3036, RK3128

         NFC v800 ECC 16
           RK3308, RV1108

         NFC v900 ECC 16, 40, 60, 70
           PX30, RK3326

Make it more in alphabetically order, so later things can easier be
inserted.
Maybe don't use the character '-' at the start of a line in a yaml file?

> +
> +      nand-bus-width:
> +        const: 8
> +
> +      rockchip,boot-blks:
> +        minimum: 2
> +        default: 16
> +        allOf:
> +        - $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The NFC driver need this information to select ECC
> +          algorithms supported by the BOOTROM.

boot ROM

> +          Only used in combination with 'nand-is-boot-medium'.
> +
> +      rockchip,boot-ecc-strength:
> +        enum: [16, 24, 40, 60, 70]
> +        allOf:
> +        - $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          If specified it indicates that a different BCH/ECC setting is
> +          supported by the BOOTROM.

boot ROM

> +          - NFCv900(PX30 and RK3326) support ecc strength 16 and 70.

> +          - NFCv600(RK3066 and RK2928) support ecc strength 16, 24, 40 and 60.

Is ECC strength for rk3066 16, 24 correct?

> +          - NFCv622(RK3036 and RK3128) support ecc strength 16, 24, 40 and 60.
> +          - NFCv800(RK3308 and RV1108) support ecc strength 16.
         NFC v600 ECC 16, 24
           RK2928, RK3066, RK3188

         NFC v622 ECC 16, 24, 40, 60
           RK3036, RK3128

         NFC v800 ECC 16
           RK3308, RV1108

         NFC v900 ECC 16, 70
           PX30, RK3326

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

#include <dt-bindings/interrupt-controller/irq.h>

irq.h is included by arm-gic.h, however Heiko recently indicated that
both should be included.

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
> 

