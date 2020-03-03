Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CDAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013D620828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tq4sEZTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgCCO4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:56:02 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:34252 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgCCO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583247359; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAy3IlmrAFK3a4+aHxpmQgIRzKexr2F5y/1Lp8D2ueY=;
        b=tq4sEZTR3RFAdnpBmCvnwzCqpbOuft58rLDOSI8pTIVRjOpQTX7yaAu57rHLBshX6u81Vk
        CC244tv8KOI8w2WFpUdPrJ4R5+PldarVItVDvzUTTRAHVqN1/rcd7GDVOiMyuCmYOg85Ob
        61bUBN0/sWwjTon26z5RJqeFYkC+kEk=
Date:   Tue, 03 Mar 2020 11:55:43 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] dt-bindings: timer: Convert ingenic,tcu.txt to YAML
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        od@zcrc.me, =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Message-Id: <1583247343.3.1@crapouillou.net>
In-Reply-To: <20200302200551.19845-1-paul@crapouillou.net>
References: <20200302200551.19845-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Rob:


Le lun., mars 2, 2020 at 17:05, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> Convert the ingenic,tcu.txt file to YAML.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> @Daniel:
>=20
> As for v1, if Rob acks it, please take this patch to your tree, since
> the .txt file was modified there. Going through your tree would avoid=20
> a
> merge conflict.
>=20
> Thanks,
> -Paul
>=20
> Changelog:
>     v2:	- Add missing 'reg' properties to child nodes
>     	- Removed 'additionalProperties: false' on child objects which
>     	  included external YAML
>     	- Add description of interrupts
>     	- Fix pattern regex
>     	- Add missing ingenic,jz4780-tcu compatible string (which=20
> requires
>     	  fallback to ingenic,jz4770-tcu)
>     	- Add 'select' to fix matching of schema
>=20
>  .../devicetree/bindings/timer/ingenic,tcu.txt | 138 ---------
>  .../bindings/timer/ingenic,tcu.yaml           | 269=20
> ++++++++++++++++++
>  2 files changed, 269 insertions(+), 138 deletions(-)
>  delete mode 100644=20
> Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>  create mode 100644=20
> Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt=20
> b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> deleted file mode 100644
> index 91f704951845..000000000000
> --- a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> +++ /dev/null
> @@ -1,138 +0,0 @@
> -Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -For a description of the TCU hardware and drivers, have a look at
> -Documentation/mips/ingenic-tcu.rst.
> -
> -Required properties:
> -
> -- compatible: Must be one of:
> -  * ingenic,jz4740-tcu
> -  * ingenic,jz4725b-tcu
> -  * ingenic,jz4770-tcu
> -  * ingenic,x1000-tcu
> -  followed by "simple-mfd".
> -- reg: Should be the offset/length value corresponding to the TCU=20
> registers
> -- clocks: List of phandle & clock specifiers for clocks external to=20
> the TCU.
> -  The "pclk", "rtc" and "ext" clocks should be provided. The "tcu"=20
> clock
> -  should be provided if the SoC has it.
> -- clock-names: List of name strings for the external clocks.
> -- #clock-cells: Should be <1>;
> -  Clock consumers specify this argument to identify a clock. The=20
> valid values
> -  may be found in <dt-bindings/clock/ingenic,tcu.h>.
> -- interrupt-controller : Identifies the node as an interrupt=20
> controller
> -- #interrupt-cells : Specifies the number of cells needed to encode=20
> an
> -  interrupt source. The value should be 1.
> -- interrupts : Specifies the interrupt the controller is connected=20
> to.
> -
> -Optional properties:
> -
> -- ingenic,pwm-channels-mask: Bitmask of TCU channels reserved for=20
> PWM use.
> -  Default value is 0xfc.
> -
> -
> -Children nodes
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -
> -PWM node:
> ----------
> -
> -Required properties:
> -
> -- compatible: Must be one of:
> -  * ingenic,jz4740-pwm
> -  * ingenic,jz4725b-pwm
> -- #pwm-cells: Should be 3. See ../pwm/pwm.yaml for a description of=20
> the cell
> -  format.
> -- clocks: List of phandle & clock specifiers for the TCU clocks.
> -- clock-names: List of name strings for the TCU clocks.
> -
> -
> -Watchdog node:
> ---------------
> -
> -Required properties:
> -
> -- compatible: Must be "ingenic,jz4740-watchdog"
> -- clocks: phandle to the WDT clock
> -- clock-names: should be "wdt"
> -
> -
> -OS Timer node:
> ----------
> -
> -Required properties:
> -
> -- compatible: Must be one of:
> -  * ingenic,jz4725b-ost
> -  * ingenic,jz4770-ost
> -- clocks: phandle to the OST clock
> -- clock-names: should be "ost"
> -- interrupts : Specifies the interrupt the OST is connected to.
> -
> -
> -Example
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#include <dt-bindings/clock/jz4770-cgu.h>
> -#include <dt-bindings/clock/ingenic,tcu.h>
> -
> -/ {
> -	tcu: timer@10002000 {
> -		compatible =3D "ingenic,jz4770-tcu", "simple-mfd";
> -		reg =3D <0x10002000 0x1000>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		ranges =3D <0x0 0x10002000 0x1000>;
> -
> -		#clock-cells =3D <1>;
> -
> -		clocks =3D <&cgu JZ4770_CLK_RTC
> -			  &cgu JZ4770_CLK_EXT
> -			  &cgu JZ4770_CLK_PCLK>;
> -		clock-names =3D "rtc", "ext", "pclk";
> -
> -		interrupt-controller;
> -		#interrupt-cells =3D <1>;
> -
> -		interrupt-parent =3D <&intc>;
> -		interrupts =3D <27 26 25>;
> -
> -		watchdog: watchdog@0 {
> -			compatible =3D "ingenic,jz4740-watchdog";
> -			reg =3D <0x0 0xc>;
> -
> -			clocks =3D <&tcu TCU_CLK_WDT>;
> -			clock-names =3D "wdt";
> -		};
> -
> -		pwm: pwm@40 {
> -			compatible =3D "ingenic,jz4740-pwm";
> -			reg =3D <0x40 0x80>;
> -
> -			#pwm-cells =3D <3>;
> -
> -			clocks =3D <&tcu TCU_CLK_TIMER0
> -				  &tcu TCU_CLK_TIMER1
> -				  &tcu TCU_CLK_TIMER2
> -				  &tcu TCU_CLK_TIMER3
> -				  &tcu TCU_CLK_TIMER4
> -				  &tcu TCU_CLK_TIMER5
> -				  &tcu TCU_CLK_TIMER6
> -				  &tcu TCU_CLK_TIMER7>;
> -			clock-names =3D "timer0", "timer1", "timer2", "timer3",
> -				      "timer4", "timer5", "timer6", "timer7";
> -		};
> -
> -		ost: timer@e0 {
> -			compatible =3D "ingenic,jz4770-ost";
> -			reg =3D <0xe0 0x20>;
> -
> -			clocks =3D <&tcu TCU_CLK_OST>;
> -			clock-names =3D "ost";
> -
> -			interrupts =3D <15>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml=20
> b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> new file mode 100644
> index 000000000000..14b68c87319f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> @@ -0,0 +1,269 @@
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
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ingenic,jz4740-tcu
> +          - ingenic,jz4725b-tcu
> +          - ingenic,jz4770-tcu
> +          - ingenic,jz4780-tcu
> +          - ingenic,x1000-tcu
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^timer@[0-9a-f]+$"
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
> +    oneOf:
> +      - items:
> +        - enum:
> +          - ingenic,jz4740-tcu
> +          - ingenic,jz4725b-tcu
> +          - ingenic,jz4770-tcu
> +          - ingenic,x1000-tcu
> +        - const: simple-mfd
> +      - items:
> +        - const: ingenic,jz4780-tcu
> +        - const: ingenic,jz4770-tcu
> +        - const: simple-mfd
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
> +    items:
> +      - description: TCU0 interrupt
> +      - description: TCU1 interrupt
> +      - description: TCU2 interrupt
> +    minItems: 1
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
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        const: wdt
> +
> +    required:
> +      - compatible
> +      - reg
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
> +      reg:
> +        maxItems: 1
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
> +      - reg
> +      - clocks
> +      - clock-names
> +
> +  "^timer@[a-f0-9]+$":
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
> +      reg:
> +        maxItems: 1
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
> +      - reg
> +      - clocks
> +      - clock-names
> +      - interrupts
> +
> +    additionalProperties: false
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

Actually this prevents the 'assigned-clock' properties from being=20
added. I was expecting these to be always accepted, akin to the=20
'pinctrl-*' properties.

Should I add entries for these here?

-Paul

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/jz4770-cgu.h>
> +    #include <dt-bindings/clock/ingenic,tcu.h>
> +    tcu: timer@10002000 {
> +      compatible =3D "ingenic,jz4770-tcu", "simple-mfd";
> +      reg =3D <0x10002000 0x1000>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <1>;
> +      ranges =3D <0x0 0x10002000 0x1000>;
> +
> +      #clock-cells =3D <1>;
> +
> +      clocks =3D <&cgu JZ4770_CLK_RTC>,
> +               <&cgu JZ4770_CLK_EXT>,
> +               <&cgu JZ4770_CLK_PCLK>;
> +      clock-names =3D "rtc", "ext", "pclk";
> +
> +      interrupt-controller;
> +      #interrupt-cells =3D <1>;
> +
> +      interrupt-parent =3D <&intc>;
> +      interrupts =3D <27 26 25>;
> +
> +      watchdog: watchdog@0 {
> +        compatible =3D "ingenic,jz4770-watchdog",=20
> "ingenic,jz4740-watchdog";
> +        reg =3D <0x0 0xc>;
> +
> +        clocks =3D <&tcu TCU_CLK_WDT>;
> +        clock-names =3D "wdt";
> +      };
> +
> +      pwm: pwm@40 {
> +        compatible =3D "ingenic,jz4770-pwm", "ingenic,jz4740-pwm";
> +        reg =3D <0x40 0x80>;
> +
> +        #pwm-cells =3D <3>;
> +
> +        clocks =3D <&tcu TCU_CLK_TIMER0>,
> +                 <&tcu TCU_CLK_TIMER1>,
> +                 <&tcu TCU_CLK_TIMER2>,
> +                 <&tcu TCU_CLK_TIMER3>,
> +                 <&tcu TCU_CLK_TIMER4>,
> +                 <&tcu TCU_CLK_TIMER5>,
> +                 <&tcu TCU_CLK_TIMER6>,
> +                 <&tcu TCU_CLK_TIMER7>;
> +        clock-names =3D "timer0", "timer1", "timer2", "timer3",
> +                "timer4", "timer5", "timer6", "timer7";
> +      };
> +
> +      ost: timer@e0 {
> +        compatible =3D "ingenic,jz4770-ost";
> +        reg =3D <0xe0 0x20>;
> +
> +        clocks =3D <&tcu TCU_CLK_OST>;
> +        clock-names =3D "ost";
> +
> +        interrupts =3D <15>;
> +      };
> +    };
> --
> 2.25.1
>=20

=

