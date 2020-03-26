Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0076C2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E0420722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585244624;
	bh=TtDZckahdL5AL8VJ+LexPxv3PKEAendO/YOSxSYS9hI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tWLCZBp4qdJqE6WHqYkUKnUCdazIOjBsH8Xi7uPpeCUjWsZumXpxScRoBuu/ZhzY8
	 9dEEOkROjeKxYvT4thGJBz1oIHT8cJCANeKNcJ/wCXrQ5AH4RUfPm9rMvkHrlL3IxQ
	 91flwQgiANHru/CHbH/FPyXMvI/Dhg3TjCLvx734=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgCZRnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCZRnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:43:43 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857AD2076A;
        Thu, 26 Mar 2020 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585244622;
        bh=TtDZckahdL5AL8VJ+LexPxv3PKEAendO/YOSxSYS9hI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xNILAGIv5MuMdSImancNklOv7SOyS09TkRoRiqaH6rObrD0NBNlnNVxSbsVmW6nbt
         DwVSGNl2I4fwZHC0E7oY7mCl1azh3XoyyRjc/IxH/eLjV+6qn01+qnKf6++syYTbrt
         CQIQy8HjiKmP/U6T9WVpgsZLO2Lf7bs6yAGt8ATE=
Received: by mail-qk1-f169.google.com with SMTP id l25so7656082qki.7;
        Thu, 26 Mar 2020 10:43:42 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3QNAzxNtQ0+dmwNKlOk260F2gqmSulqjV2/bm6Yl4uOAQeu+LQ
        2XFMWfg6i9Wlf5qRtC1XyO0GPc/A2EgDCWN6cw==
X-Google-Smtp-Source: ADFU+vtf2XhmNFBVx50neTxjqOw5fD1AsqJiGjXVRkhMvvW6Y7txmJDcvFY1yKz2kN3K27Mfq/CGdMT+LjDQtbnvmRo=
X-Received: by 2002:a37:634d:: with SMTP id x74mr9617823qkb.254.1585244621536;
 Thu, 26 Mar 2020 10:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com> <1585128694-13881-2-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1585128694-13881-2-git-send-email-hanks.chen@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 26 Mar 2020 11:43:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Znnk=L=ztTyVrs4i0tiN0TrWwcaujAm_Lp1wd9pWiZQ@mail.gmail.com>
Message-ID: <CAL_Jsq+Znnk=L=ztTyVrs4i0tiN0TrWwcaujAm_Lp1wd9pWiZQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: pinctrl: add bindings for MediaTek
 MT6779 SoC
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 3:31 AM Hanks Chen <hanks.chen@mediatek.com> wrote:
>
> From: Andy Teng <andy.teng@mediatek.com>
>
> Add devicetree bindings for MediaTek MT6779 pinctrl driver.
>
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> ---
>  .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |  208 ++++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml

The header belongs in this patch so that 'make dt_binding_check' works.

>
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> new file mode 100644
> index 0000000..5f9bbf1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> @@ -0,0 +1,208 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mediatek,mt6779-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6779 Pin Controller Device Tree Bindings
> +
> +maintainers:
> +  - Andy Teng <andy.teng@mediatek.com>
> +
> +description: |+
> +  The pin controller node should be the child of a syscon node with the
> +  required property:
> +  - compatible: "syscon"
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6779-pinctrl
> +
> +  reg:
> +    minItems: 9
> +    maxItems: 9
> +    description: |
> +      physical address base for gpio-related control registers.
> +
> +  reg-names:
> +    description: |
> +      GPIO base register names.

Need to define what the names are and the order.

> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: |
> +      Number of cells in GPIO specifier. Since the generic GPIO
> +      binding is used, the amount of cells must be specified as 2. See the below
> +      mentioned gpio binding representation for description of particular cells.
> +
> +  gpio-ranges:
> +    minItems: 1
> +    maxItems: 5
> +    description: |
> +      GPIO valid number range.
> +
> +  interrupt-controller: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 4

Need to define what the interrupts are.

> +    description: |
> +      The interrupt outputs to sysirq.
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - gpio-controller
> +  - "#gpio-cells"
> +  - gpio-ranges
> +  - interrupt-controller
> +  - interrupts
> +  - "#interrupt-cells"
> +
> +patternProperties:
> +  '^pins*$':

'-pins$' would be preferred.

> +    type: object
> +    description: |
> +      A pinctrl node should contain at least one subnodes representing the
> +      pinctrl groups available on the machine. Each subnode will list the
> +      pins it needs, and how they should be configured, with regard to muxer
> +      configuration, pullups, drive strength, input enable/disable and input schmitt.
> +
> +    properties:
> +      pinmux:

There's a common schema for all these properties. You need to
reference it (with $ref) and only define which properties you are
using and any additional constraints.

> +        description:
> +          integer array, represents gpio pin number and mux setting.
> +          Supported pin number and mux varies for different SoCs, and are defined
> +          as macros in boot/dts/<soc>-pinfunc.h directly.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      bias-disable:
> +        type: boolean
> +
> +      bias-pull-up:
> +        oneOf:
> +          - type: boolean
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      bias-pull-down:
> +        oneOf:
> +          - type: boolean
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      input-enable:
> +        type: boolean
> +
> +      input-disable:
> +        type: boolean
> +
> +      output-low:
> +        type: boolean
> +
> +      output-high:
> +        type: boolean
> +
> +      input-schmitt-enable:
> +        type: boolean
> +
> +      input-schmitt-disable:
> +        type: boolean
> +
> +      mediatek,pull-up-adv:
> +        description: |
> +          Pull up setings for 2 pull resistors, R0 and R1. User can
> +          configure those special pins. Valid arguments are described as below:
> +          0: (R1, R0) = (0, 0) which means R1 disabled and R0 disable.
> +          1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
> +          2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
> +          3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 1, 2, 3]
> +
> +      mediatek,pull-down-adv:
> +        description: |
> +          Pull down settings for 2 pull resistors, R0 and R1. User can
> +          configure those special pins. Valid arguments are described as below:
> +          0: (R1, R0) = (0, 0) which means R1 disabled and R0 disable.
> +          1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
> +          2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
> +          3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 1, 2, 3]
> +
> +      drive-strength:
> +        description: |
> +          Selects the drive strength for the specified pins in mA.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +
> +    required:
> +      - pinmux

Add:

    additionalProperties: false

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/pinctrl/mt6779-pinfunc.h>
> +
> +    pio: pinctrl@10005000 {
> +        compatible = "mediatek,mt6779-pinctrl";
> +        reg = <0 0x10005000 0 0x1000>,
> +            <0 0x11c20000 0 0x1000>,
> +            <0 0x11d10000 0 0x1000>,
> +            <0 0x11e20000 0 0x1000>,
> +            <0 0x11e70000 0 0x1000>,
> +            <0 0x11ea0000 0 0x1000>,
> +            <0 0x11f20000 0 0x1000>,
> +            <0 0x11f30000 0 0x1000>,
> +            <0 0x1000b000 0 0x1000>;
> +        reg-names = "gpio", "iocfg_rm",
> +          "iocfg_br", "iocfg_lm",
> +          "iocfg_lb", "iocfg_rt",
> +          "iocfg_lt", "iocfg_tl",
> +          "eint";
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&pio 0 0 210>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        mmc0_pins_default: mmc0default {
> +            pins_cmd_dat {

The 2 levels of nodes here doesn't match your schema.

Also, don't use '_' in node names.

> +                pinmux = <PINMUX_GPIO168__FUNC_MSDC0_DAT0>,
> +                    <PINMUX_GPIO172__FUNC_MSDC0_DAT1>,
> +                    <PINMUX_GPIO169__FUNC_MSDC0_DAT2>,
> +                    <PINMUX_GPIO177__FUNC_MSDC0_DAT3>,
> +                    <PINMUX_GPIO170__FUNC_MSDC0_DAT4>,
> +                    <PINMUX_GPIO173__FUNC_MSDC0_DAT5>,
> +                    <PINMUX_GPIO171__FUNC_MSDC0_DAT6>,
> +                    <PINMUX_GPIO174__FUNC_MSDC0_DAT7>,
> +                    <PINMUX_GPIO167__FUNC_MSDC0_CMD>;
> +                input-enable;
> +                mediatek,pull-up-adv = <1>;
> +            };
> +            pins_clk {
> +                pinmux = <PINMUX_GPIO176__FUNC_MSDC0_CLK>;
> +                mediatek,pull-down-adv = <2>;
> +            };
> +            pins_rst {
> +                pinmux = <PINMUX_GPIO178__FUNC_MSDC0_RSTB>;
> +                mediatek,pull-up-adv = <0>;
> +            };
> +        };
> +
> +        mmc0 {
> +          pinctrl-0 = <&mmc0_pins_default>;
> +          pinctrl-names = "default";
> +        };
> +    };
> +
> --
> 1.7.9.5
