Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5DEC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056DF20842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fNi7g+22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgCBSZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:25:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48476 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583173497; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6lSOhMC/XBGtbtaKsJ1k7GLSbXNsMxEsiPalqyKXIc=;
        b=fNi7g+22XO1z3idiEMZnqTtahVH3g8pfVE9Vgrqjgor2TQSz518zoC4Lcmf5I0ek3N9YAI
        /oYZ+LTfPpkIEqiSU90NvHKX+jJa/nCS1MoWHGInZkFEwtOK8cAp3JQvOoZNewxvnahcM/
        Zi4z2X+tlh0hpoXxUwNopPBZDKvrRLw=
Date:   Mon, 02 Mar 2020 15:24:41 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/1] dt-bindings: timer: Convert ingenic,tcu.txt to YAML
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <1583173481.3.0@crapouillou.net>
In-Reply-To: <CAL_JsqKGzxdMj4_+i4ycKj6ZjiuGMY8F+yBzVPt_b2CLhrcdKg@mail.gmail.com>
References: <20200301174636.63446-1-paul@crapouillou.net>
        <20200301174636.63446-2-paul@crapouillou.net>
        <CAL_JsqKGzxdMj4_+i4ycKj6ZjiuGMY8F+yBzVPt_b2CLhrcdKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


Le lun., mars 2, 2020 at 11:06, Rob Herring <robh+dt@kernel.org> a=20
=E9crit :
> On Sun, Mar 1, 2020 at 11:47 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>=20
> Well, this flew into linux-next quickly and breaks 'make
> dt_binding_check'... Please drop, revert or fix quickly.

For my defense I said to merge "provided Rob acks it" ;)

>>  Convert the ingenic,tcu.txt file to YAML.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../devicetree/bindings/timer/ingenic,tcu.txt | 138 ----------
>>   .../bindings/timer/ingenic,tcu.yaml           | 235=20
>> ++++++++++++++++++
>>   2 files changed, 235 insertions(+), 138 deletions(-)
>>   delete mode 100644=20
>> Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>   create mode 100644=20
>> Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>=20
>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml=20
>> b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>>  new file mode 100644
>>  index 000000000000..1ded3b4762bb
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>>  @@ -0,0 +1,235 @@
>>  +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: http://devicetree.org/schemas/timer/ingenic,tcu.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Ingenic SoCs Timer/Counter Unit (TCU) devicetree bindings
>>  +
>>  +description: |
>>  +  For a description of the TCU hardware and drivers, have a look at
>>  +  Documentation/mips/ingenic-tcu.rst.
>>  +
>>  +maintainers:
>>  +  - Paul Cercueil <paul@crapouillou.net>
>>  +
>>  +properties:
>>  +  $nodename:
>>  +    pattern: "^timer@.*"
>=20
> '.*' is redundant.
>=20
>>  +
>>  +  "#address-cells":
>>  +    const: 1
>>  +
>>  +  "#size-cells":
>>  +    const: 1
>>  +
>>  +  "#clock-cells":
>>  +    const: 1
>>  +
>>  +  "#interrupt-cells":
>>  +    const: 1
>>  +
>>  +  interrupt-controller: true
>>  +
>>  +  ranges: true
>>  +
>>  +  compatible:
>>  +    items:
>>  +      - enum:
>>  +        - ingenic,jz4740-tcu
>>  +        - ingenic,jz4725b-tcu
>>  +        - ingenic,jz4770-tcu
>>  +        - ingenic,x1000-tcu
>>  +      - const: simple-mfd
>=20
> This breaks several examples in dt_binding_check because this schema
> will be applied to every 'simple-mfd' node. You need a custom select
> entry that excludes 'simple-mfd'. There should be several examples in
> tree to copy.

Why would it be applied to all 'single-mfd' nodes? Doesn't what I wrote=20
specify that it needs one of ingenic,*-tcu _and_ simple-mfd?

I'm not sure I understand what you mean.

I did grep for 'single-mfd' in all YAML files in Documentation/ and=20
nothing really stands out.

-Paul

>>  +
>>  +  reg:
>>  +    maxItems: 1
>>  +
>>  +  clocks:
>>  +    items:
>>  +      - description: RTC clock
>>  +      - description: EXT clock
>>  +      - description: PCLK clock
>>  +      - description: TCU clock
>>  +    minItems: 3
>>  +
>>  +  clock-names:
>>  +    items:
>>  +      - const: rtc
>>  +      - const: ext
>>  +      - const: pclk
>>  +      - const: tcu
>>  +    minItems: 3
>>  +
>>  +  interrupts:
>>  +    minItems: 1
>>  +    maxItems: 3
>=20
> You need to define what each one is.
>=20
>>  +
>>  +  ingenic,pwm-channels-mask:
>>  +    description: Bitmask of TCU channels reserved for PWM use.
>>  +    allOf:
>>  +      - $ref: /schemas/types.yaml#/definitions/uint32
>>  +      - minimum: 0x00
>>  +      - maximum: 0xff
>>  +      - default: 0xfc
>>  +
>>  +patternProperties:
>>  +  "^watchdog@[a-f0-9]+$":
>>  +    type: object
>>  +    allOf: [ $ref: ../watchdog/watchdog.yaml# ]
>>  +    properties:
>>  +      compatible:
>>  +        oneOf:
>>  +          - enum:
>>  +            - ingenic,jz4740-watchdog
>>  +            - ingenic,jz4780-watchdog
>>  +          - items:
>>  +            - const: ingenic,jz4770-watchdog
>>  +            - const: ingenic,jz4740-watchdog
>>  +
>>  +      clocks:
>>  +        maxItems: 1
>>  +
>>  +      clock-names:
>>  +        const: wdt
>>  +
>>  +    required:
>>  +      - compatible
>>  +      - clocks
>>  +      - clock-names
>>  +
>>  +  "^pwm@[a-f0-9]+$":
>>  +    type: object
>>  +    allOf: [ $ref: ../pwm/pwm.yaml# ]
>>  +    properties:
>>  +      compatible:
>>  +        oneOf:
>>  +          - enum:
>>  +            - ingenic,jz4740-pwm
>>  +          - items:
>>  +            - enum:
>>  +              - ingenic,jz4770-pwm
>>  +              - ingenic,jz4780-pwm
>>  +            - const: ingenic,jz4740-pwm
>>  +
>>  +      clocks:
>>  +        minItems: 6
>>  +        maxItems: 8
>>  +
>>  +      clock-names:
>>  +        items:
>>  +          - const: timer0
>>  +          - const: timer1
>>  +          - const: timer2
>>  +          - const: timer3
>>  +          - const: timer4
>>  +          - const: timer5
>>  +          - const: timer6
>>  +          - const: timer7
>>  +        minItems: 6
>>  +
>>  +    required:
>>  +      - compatible
>>  +      - clocks
>>  +      - clock-names
>>  +
>>  +  "^timer@[a-f0-9]+":
>>  +    type: object
>>  +    properties:
>>  +      compatible:
>>  +        oneOf:
>>  +          - enum:
>>  +            - ingenic,jz4725b-ost
>>  +            - ingenic,jz4770-ost
>>  +          - items:
>>  +            - const: ingenic,jz4780-ost
>>  +            - const: ingenic,jz4770-ost
>>  +
>>  +
>>  +      clocks:
>>  +        maxItems: 1
>>  +
>>  +      clock-names:
>>  +        const: ost
>>  +
>>  +      interrupts:
>>  +        maxItems: 1
>>  +
>>  +    required:
>>  +      - compatible
>>  +      - clocks
>>  +      - clock-names
>>  +      - interrupts
>>  +
>>  +required:
>>  +  - "#clock-cells"
>>  +  - "#interrupt-cells"
>>  +  - interrupt-controller
>>  +  - compatible
>>  +  - reg
>>  +  - clocks
>>  +  - clock-names
>>  +  - interrupts
>>  +
>>  +additionalProperties: false
>>  +
>>  +examples:
>>  +  - |
>>  +    #include <dt-bindings/clock/jz4770-cgu.h>
>>  +    #include <dt-bindings/clock/ingenic,tcu.h>
>>  +    tcu: timer@10002000 {
>>  +      compatible =3D "ingenic,jz4770-tcu", "simple-mfd";
>>  +      reg =3D <0x10002000 0x1000>;
>>  +      #address-cells =3D <1>;
>>  +      #size-cells =3D <1>;
>>  +      ranges =3D <0x0 0x10002000 0x1000>;
>>  +
>>  +      #clock-cells =3D <1>;
>>  +
>>  +      clocks =3D <&cgu JZ4770_CLK_RTC>,
>>  +               <&cgu JZ4770_CLK_EXT>,
>>  +               <&cgu JZ4770_CLK_PCLK>;
>>  +      clock-names =3D "rtc", "ext", "pclk";
>>  +
>>  +      interrupt-controller;
>>  +      #interrupt-cells =3D <1>;
>>  +
>>  +      interrupt-parent =3D <&intc>;
>>  +      interrupts =3D <27 26 25>;
>>  +
>>  +      watchdog: watchdog@0 {
>>  +        compatible =3D "ingenic,jz4770-watchdog",=20
>> "ingenic,jz4740-watchdog";
>>  +        reg =3D <0x0 0xc>;
>>  +
>>  +        clocks =3D <&tcu TCU_CLK_WDT>;
>>  +        clock-names =3D "wdt";
>>  +      };
>>  +
>>  +      pwm: pwm@40 {
>>  +        compatible =3D "ingenic,jz4770-pwm", "ingenic,jz4740-pwm";
>>  +        reg =3D <0x40 0x80>;
>>  +
>>  +        #pwm-cells =3D <3>;
>>  +
>>  +        clocks =3D <&tcu TCU_CLK_TIMER0>,
>>  +                 <&tcu TCU_CLK_TIMER1>,
>>  +                 <&tcu TCU_CLK_TIMER2>,
>>  +                 <&tcu TCU_CLK_TIMER3>,
>>  +                 <&tcu TCU_CLK_TIMER4>,
>>  +                 <&tcu TCU_CLK_TIMER5>,
>>  +                 <&tcu TCU_CLK_TIMER6>,
>>  +                 <&tcu TCU_CLK_TIMER7>;
>>  +        clock-names =3D "timer0", "timer1", "timer2", "timer3",
>>  +                "timer4", "timer5", "timer6", "timer7";
>>  +      };
>>  +
>>  +      ost: timer@e0 {
>>  +        compatible =3D "ingenic,jz4770-ost";
>>  +        reg =3D <0xe0 0x20>;
>>  +
>>  +        clocks =3D <&tcu TCU_CLK_OST>;
>>  +        clock-names =3D "ost";
>>  +
>>  +        interrupts =3D <15>;
>>  +      };
>>  +    };
>>  --
>>  2.25.1
>>=20

=

