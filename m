Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72D7C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BF9222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583168822;
	bh=DlxhdDbwmcjRP6QjOcArCb8H5bEOdUDJ1ap3lRdnAbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eVmxr6w/1GoSRxIVlGVWIMDJAMSOawEfGIv5t6Rikx0RPy2B3BoDbsbU8nOGFPvb4
	 zpGVGHjDUnvJDzc0R/+LpI/fxZR9RcZPgYCQgGlAjZ/KjK0u1czy5Zgh23V8gQ0ISE
	 0x3hyQN8KkOu+MDpHboXYSee/fnzpb8Pj5wBrwFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCBRHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:07:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgCBRHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:07:01 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB35522B48;
        Mon,  2 Mar 2020 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583168819;
        bh=DlxhdDbwmcjRP6QjOcArCb8H5bEOdUDJ1ap3lRdnAbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0wbc7QsdAo1gkBI0+mwJ5aqPpPeduUoyPAsLzTeZ0a7KfLM0nRcwDrGNHSHVSe15/
         R2ROcZMcv4q6v+fwHoMq2dNlB9nxVGys8P5QWyJqiNTsP9+Ur0NUhFh4bOCyUkgzME
         E2oe2LTAvlhVWSfYiK/pjMMcf27YKWmo2eQachJA=
Received: by mail-qv1-f43.google.com with SMTP id m2so184140qvu.13;
        Mon, 02 Mar 2020 09:06:59 -0800 (PST)
X-Gm-Message-State: ANhLgQ23PRlI3W6IXw7BA7RB6eXG516fFpNkygfdkPlfj5PEHqQWqeyO
        KIMkx3G5vZoSBNSZD2wVUrzGz+yu+AFIFt2c2A==
X-Google-Smtp-Source: ADFU+vuVlnuw3JWPcAVckKfonP5eYDpaQbLOuv1/LfLPClAQsa0L4ylsum+rSPBRq1t4V6zW50x9mQ9HLOnNVI+7U2o=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr345263qvn.79.1583168818774;
 Mon, 02 Mar 2020 09:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20200301174636.63446-1-paul@crapouillou.net> <20200301174636.63446-2-paul@crapouillou.net>
In-Reply-To: <20200301174636.63446-2-paul@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 2 Mar 2020 11:06:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKGzxdMj4_+i4ycKj6ZjiuGMY8F+yBzVPt_b2CLhrcdKg@mail.gmail.com>
Message-ID: <CAL_JsqKGzxdMj4_+i4ycKj6ZjiuGMY8F+yBzVPt_b2CLhrcdKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: timer: Convert ingenic,tcu.txt to YAML
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 11:47 AM Paul Cercueil <paul@crapouillou.net> wrote:
>

Well, this flew into linux-next quickly and breaks 'make
dt_binding_check'... Please drop, revert or fix quickly.

> Convert the ingenic,tcu.txt file to YAML.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/timer/ingenic,tcu.txt | 138 ----------
>  .../bindings/timer/ingenic,tcu.yaml           | 235 ++++++++++++++++++
>  2 files changed, 235 insertions(+), 138 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml


> diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> new file mode 100644
> index 000000000000..1ded3b4762bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> @@ -0,0 +1,235 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/ingenic,tcu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic SoCs Timer/Counter Unit (TCU) devicetree bindings
> +
> +description: |
> +  For a description of the TCU hardware and drivers, have a look at
> +  Documentation/mips/ingenic-tcu.rst.
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +properties:
> +  $nodename:
> +    pattern: "^timer@.*"

'.*' is redundant.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-controller: true
> +
> +  ranges: true
> +
> +  compatible:
> +    items:
> +      - enum:
> +        - ingenic,jz4740-tcu
> +        - ingenic,jz4725b-tcu
> +        - ingenic,jz4770-tcu
> +        - ingenic,x1000-tcu
> +      - const: simple-mfd

This breaks several examples in dt_binding_check because this schema
will be applied to every 'simple-mfd' node. You need a custom select
entry that excludes 'simple-mfd'. There should be several examples in
tree to copy.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: RTC clock
> +      - description: EXT clock
> +      - description: PCLK clock
> +      - description: TCU clock
> +    minItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: rtc
> +      - const: ext
> +      - const: pclk
> +      - const: tcu
> +    minItems: 3
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 3

You need to define what each one is.

> +
> +  ingenic,pwm-channels-mask:
> +    description: Bitmask of TCU channels reserved for PWM use.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0x00
> +      - maximum: 0xff
> +      - default: 0xfc
> +
> +patternProperties:
> +  "^watchdog@[a-f0-9]+$":
> +    type: object
> +    allOf: [ $ref: ../watchdog/watchdog.yaml# ]
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +            - ingenic,jz4740-watchdog
> +            - ingenic,jz4780-watchdog
> +          - items:
> +            - const: ingenic,jz4770-watchdog
> +            - const: ingenic,jz4740-watchdog
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        const: wdt
> +
> +    required:
> +      - compatible
> +      - clocks
> +      - clock-names
> +
> +  "^pwm@[a-f0-9]+$":
> +    type: object
> +    allOf: [ $ref: ../pwm/pwm.yaml# ]
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +            - ingenic,jz4740-pwm
> +          - items:
> +            - enum:
> +              - ingenic,jz4770-pwm
> +              - ingenic,jz4780-pwm
> +            - const: ingenic,jz4740-pwm
> +
> +      clocks:
> +        minItems: 6
> +        maxItems: 8
> +
> +      clock-names:
> +        items:
> +          - const: timer0
> +          - const: timer1
> +          - const: timer2
> +          - const: timer3
> +          - const: timer4
> +          - const: timer5
> +          - const: timer6
> +          - const: timer7
> +        minItems: 6
> +
> +    required:
> +      - compatible
> +      - clocks
> +      - clock-names
> +
> +  "^timer@[a-f0-9]+":
> +    type: object
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +            - ingenic,jz4725b-ost
> +            - ingenic,jz4770-ost
> +          - items:
> +            - const: ingenic,jz4780-ost
> +            - const: ingenic,jz4770-ost
> +
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        const: ost
> +
> +      interrupts:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - clocks
> +      - clock-names
> +      - interrupts
> +
> +required:
> +  - "#clock-cells"
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/jz4770-cgu.h>
> +    #include <dt-bindings/clock/ingenic,tcu.h>
> +    tcu: timer@10002000 {
> +      compatible = "ingenic,jz4770-tcu", "simple-mfd";
> +      reg = <0x10002000 0x1000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0x0 0x10002000 0x1000>;
> +
> +      #clock-cells = <1>;
> +
> +      clocks = <&cgu JZ4770_CLK_RTC>,
> +               <&cgu JZ4770_CLK_EXT>,
> +               <&cgu JZ4770_CLK_PCLK>;
> +      clock-names = "rtc", "ext", "pclk";
> +
> +      interrupt-controller;
> +      #interrupt-cells = <1>;
> +
> +      interrupt-parent = <&intc>;
> +      interrupts = <27 26 25>;
> +
> +      watchdog: watchdog@0 {
> +        compatible = "ingenic,jz4770-watchdog", "ingenic,jz4740-watchdog";
> +        reg = <0x0 0xc>;
> +
> +        clocks = <&tcu TCU_CLK_WDT>;
> +        clock-names = "wdt";
> +      };
> +
> +      pwm: pwm@40 {
> +        compatible = "ingenic,jz4770-pwm", "ingenic,jz4740-pwm";
> +        reg = <0x40 0x80>;
> +
> +        #pwm-cells = <3>;
> +
> +        clocks = <&tcu TCU_CLK_TIMER0>,
> +                 <&tcu TCU_CLK_TIMER1>,
> +                 <&tcu TCU_CLK_TIMER2>,
> +                 <&tcu TCU_CLK_TIMER3>,
> +                 <&tcu TCU_CLK_TIMER4>,
> +                 <&tcu TCU_CLK_TIMER5>,
> +                 <&tcu TCU_CLK_TIMER6>,
> +                 <&tcu TCU_CLK_TIMER7>;
> +        clock-names = "timer0", "timer1", "timer2", "timer3",
> +                "timer4", "timer5", "timer6", "timer7";
> +      };
> +
> +      ost: timer@e0 {
> +        compatible = "ingenic,jz4770-ost";
> +        reg = <0xe0 0x20>;
> +
> +        clocks = <&tcu TCU_CLK_OST>;
> +        clock-names = "ost";
> +
> +        interrupts = <15>;
> +      };
> +    };
> --
> 2.25.1
>
