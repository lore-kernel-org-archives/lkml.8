Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E0FC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75113215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583871237;
	bh=e6QBBdmLL0bPzP6abAUC4vyQXBefzcwfedNDS+EB9kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tcu1llR7N5Kb+Z4DiAgKnzoC2b4McRtI/NKqUFVZwIDZYeRWm4feULV7jQ17sA2M/
	 wzOB6fVnrC7XCNvv4N9092uno1LLGI6CPCpycYViFhFXwLtwhR5pGEPYzkL3a85RI6
	 TM6jjCb7stFj4F9eEfY3ykEpR3lVxjBDkX7sAqn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCJUN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:13:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33149 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJUN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:13:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id g15so8388945otr.0;
        Tue, 10 Mar 2020 13:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Npzha+URNCMUvVufnAeaLU2EtIEQm+SEZnltN12bCwI=;
        b=HCTxXDyOzNpvQ/l3SH7QQ2BtqeAjgi/45dPLLhOMty3mBZ3bJtY0hJVTxoSnyoaXUx
         esxD5PEPv7wLFoqE0MDgQcGLj6Ujsg4PCIaTg0JXLPXr2kc3Veff35/MoR77nBFWW91Z
         pBfJNh2cE3frvV7UFQG0lB3aTexb2jop46XLbNYiktdmx85+SXwgpOh39qcwOw8iR9ER
         eBjXfHFnXyvTLE0mTgQ7DAlOJ/UkkbOapaksXifrMm1qca6uW8XWYc5Nai0B/e4Tqp8f
         k1TGRkcQmG0DXzFk3VbdEqsp1y3PrqN7HH94ze18C1ioBzqfwbjeaMoBqk8pbo+xDFNX
         azfg==
X-Gm-Message-State: ANhLgQ0WySSz1BBQeIMnQ25AP/LZf/Fk3IndHI0MEZb7Z6vVvsx/zNYu
        bkIEIgmg3bDsiDBtiWPlyw==
X-Google-Smtp-Source: ADFU+vvYWAow+kdNjMGNxoLFx+QNcGSseuUvf13MUEAv6JRHE9TFQeDVyR3podF9Q7abz8BcY4eRVw==
X-Received: by 2002:a9d:554a:: with SMTP id h10mr17459705oti.344.1583871233844;
        Tue, 10 Mar 2020 13:13:53 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r8sm3182898otp.7.2020.03.10.13.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 13:13:53 -0700 (PDT)
Received: (nullmailer pid 25277 invoked by uid 1000);
        Tue, 10 Mar 2020 20:13:52 -0000
Date:   Tue, 10 Mar 2020 15:13:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        od@zcrc.me, =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Subject: Re: [PATCH v2] dt-bindings: timer: Convert ingenic,tcu.txt to YAML
Message-ID: <20200310201352.GA28962@bogus>
References: <20200302200551.19845-1-paul@crapouillou.net>
 <1583247343.3.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1583247343.3.1@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 11:55:43AM -0300, Paul Cercueil wrote:
> @Rob:
> 
> 
> Le lun., mars 2, 2020 at 17:05, Paul Cercueil <paul@crapouillou.net> a écrit
> :
> > Convert the ingenic,tcu.txt file to YAML.
> > 
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> > 
> > @Daniel:
> > 
> > As for v1, if Rob acks it, please take this patch to your tree, since
> > the .txt file was modified there. Going through your tree would avoid a
> > merge conflict.
> > 
> > Thanks,
> > -Paul
> > 
> > Changelog:
> >     v2:	- Add missing 'reg' properties to child nodes
> >     	- Removed 'additionalProperties: false' on child objects which
> >     	  included external YAML
> >     	- Add description of interrupts
> >     	- Fix pattern regex
> >     	- Add missing ingenic,jz4780-tcu compatible string (which requires
> >     	  fallback to ingenic,jz4770-tcu)
> >     	- Add 'select' to fix matching of schema
> > 
> >  .../devicetree/bindings/timer/ingenic,tcu.txt | 138 ---------
> >  .../bindings/timer/ingenic,tcu.yaml           | 269 ++++++++++++++++++
> >  2 files changed, 269 insertions(+), 138 deletions(-)
> >  delete mode 100644
> > Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> > b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> > deleted file mode 100644
> > index 91f704951845..000000000000
> > --- a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> > +++ /dev/null
> > @@ -1,138 +0,0 @@
> > -Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
> > -==========================================================
> > -
> > -For a description of the TCU hardware and drivers, have a look at
> > -Documentation/mips/ingenic-tcu.rst.
> > -
> > -Required properties:
> > -
> > -- compatible: Must be one of:
> > -  * ingenic,jz4740-tcu
> > -  * ingenic,jz4725b-tcu
> > -  * ingenic,jz4770-tcu
> > -  * ingenic,x1000-tcu
> > -  followed by "simple-mfd".
> > -- reg: Should be the offset/length value corresponding to the TCU
> > registers
> > -- clocks: List of phandle & clock specifiers for clocks external to the
> > TCU.
> > -  The "pclk", "rtc" and "ext" clocks should be provided. The "tcu"
> > clock
> > -  should be provided if the SoC has it.
> > -- clock-names: List of name strings for the external clocks.
> > -- #clock-cells: Should be <1>;
> > -  Clock consumers specify this argument to identify a clock. The valid
> > values
> > -  may be found in <dt-bindings/clock/ingenic,tcu.h>.
> > -- interrupt-controller : Identifies the node as an interrupt controller
> > -- #interrupt-cells : Specifies the number of cells needed to encode an
> > -  interrupt source. The value should be 1.
> > -- interrupts : Specifies the interrupt the controller is connected to.
> > -
> > -Optional properties:
> > -
> > -- ingenic,pwm-channels-mask: Bitmask of TCU channels reserved for PWM
> > use.
> > -  Default value is 0xfc.
> > -
> > -
> > -Children nodes
> > -==========================================================
> > -
> > -
> > -PWM node:
> > ----------
> > -
> > -Required properties:
> > -
> > -- compatible: Must be one of:
> > -  * ingenic,jz4740-pwm
> > -  * ingenic,jz4725b-pwm
> > -- #pwm-cells: Should be 3. See ../pwm/pwm.yaml for a description of the
> > cell
> > -  format.
> > -- clocks: List of phandle & clock specifiers for the TCU clocks.
> > -- clock-names: List of name strings for the TCU clocks.
> > -
> > -
> > -Watchdog node:
> > ---------------
> > -
> > -Required properties:
> > -
> > -- compatible: Must be "ingenic,jz4740-watchdog"
> > -- clocks: phandle to the WDT clock
> > -- clock-names: should be "wdt"
> > -
> > -
> > -OS Timer node:
> > ----------
> > -
> > -Required properties:
> > -
> > -- compatible: Must be one of:
> > -  * ingenic,jz4725b-ost
> > -  * ingenic,jz4770-ost
> > -- clocks: phandle to the OST clock
> > -- clock-names: should be "ost"
> > -- interrupts : Specifies the interrupt the OST is connected to.
> > -
> > -
> > -Example
> > -==========================================================
> > -
> > -#include <dt-bindings/clock/jz4770-cgu.h>
> > -#include <dt-bindings/clock/ingenic,tcu.h>
> > -
> > -/ {
> > -	tcu: timer@10002000 {
> > -		compatible = "ingenic,jz4770-tcu", "simple-mfd";
> > -		reg = <0x10002000 0x1000>;
> > -		#address-cells = <1>;
> > -		#size-cells = <1>;
> > -		ranges = <0x0 0x10002000 0x1000>;
> > -
> > -		#clock-cells = <1>;
> > -
> > -		clocks = <&cgu JZ4770_CLK_RTC
> > -			  &cgu JZ4770_CLK_EXT
> > -			  &cgu JZ4770_CLK_PCLK>;
> > -		clock-names = "rtc", "ext", "pclk";
> > -
> > -		interrupt-controller;
> > -		#interrupt-cells = <1>;
> > -
> > -		interrupt-parent = <&intc>;
> > -		interrupts = <27 26 25>;
> > -
> > -		watchdog: watchdog@0 {
> > -			compatible = "ingenic,jz4740-watchdog";
> > -			reg = <0x0 0xc>;
> > -
> > -			clocks = <&tcu TCU_CLK_WDT>;
> > -			clock-names = "wdt";
> > -		};
> > -
> > -		pwm: pwm@40 {
> > -			compatible = "ingenic,jz4740-pwm";
> > -			reg = <0x40 0x80>;
> > -
> > -			#pwm-cells = <3>;
> > -
> > -			clocks = <&tcu TCU_CLK_TIMER0
> > -				  &tcu TCU_CLK_TIMER1
> > -				  &tcu TCU_CLK_TIMER2
> > -				  &tcu TCU_CLK_TIMER3
> > -				  &tcu TCU_CLK_TIMER4
> > -				  &tcu TCU_CLK_TIMER5
> > -				  &tcu TCU_CLK_TIMER6
> > -				  &tcu TCU_CLK_TIMER7>;
> > -			clock-names = "timer0", "timer1", "timer2", "timer3",
> > -				      "timer4", "timer5", "timer6", "timer7";
> > -		};
> > -
> > -		ost: timer@e0 {
> > -			compatible = "ingenic,jz4770-ost";
> > -			reg = <0xe0 0x20>;
> > -
> > -			clocks = <&tcu TCU_CLK_OST>;
> > -			clock-names = "ost";
> > -
> > -			interrupts = <15>;
> > -		};
> > -	};
> > -};
> > diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> > b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> > new file mode 100644
> > index 000000000000..14b68c87319f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> > @@ -0,0 +1,269 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/ingenic,tcu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ingenic SoCs Timer/Counter Unit (TCU) devicetree bindings
> > +
> > +description: |
> > +  For a description of the TCU hardware and drivers, have a look at
> > +  Documentation/mips/ingenic-tcu.rst.
> > +
> > +maintainers:
> > +  - Paul Cercueil <paul@crapouillou.net>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - ingenic,jz4740-tcu
> > +          - ingenic,jz4725b-tcu
> > +          - ingenic,jz4770-tcu
> > +          - ingenic,jz4780-tcu
> > +          - ingenic,x1000-tcu
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^timer@[0-9a-f]+$"
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  ranges: true
> > +
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +          - ingenic,jz4740-tcu
> > +          - ingenic,jz4725b-tcu
> > +          - ingenic,jz4770-tcu
> > +          - ingenic,x1000-tcu
> > +        - const: simple-mfd
> > +      - items:
> > +        - const: ingenic,jz4780-tcu
> > +        - const: ingenic,jz4770-tcu
> > +        - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: RTC clock
> > +      - description: EXT clock
> > +      - description: PCLK clock
> > +      - description: TCU clock
> > +    minItems: 3
> > +
> > +  clock-names:
> > +    items:
> > +      - const: rtc
> > +      - const: ext
> > +      - const: pclk
> > +      - const: tcu
> > +    minItems: 3
> > +
> > +  interrupts:
> > +    items:
> > +      - description: TCU0 interrupt
> > +      - description: TCU1 interrupt
> > +      - description: TCU2 interrupt
> > +    minItems: 1
> > +
> > +  ingenic,pwm-channels-mask:
> > +    description: Bitmask of TCU channels reserved for PWM use.
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - minimum: 0x00
> > +      - maximum: 0xff
> > +      - default: 0xfc
> > +
> > +patternProperties:
> > +  "^watchdog@[a-f0-9]+$":
> > +    type: object
> > +    allOf: [ $ref: ../watchdog/watchdog.yaml# ]
> > +    properties:
> > +      compatible:
> > +        oneOf:
> > +          - enum:
> > +            - ingenic,jz4740-watchdog
> > +            - ingenic,jz4780-watchdog
> > +          - items:
> > +            - const: ingenic,jz4770-watchdog
> > +            - const: ingenic,jz4740-watchdog
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        maxItems: 1
> > +
> > +      clock-names:
> > +        const: wdt
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - clocks
> > +      - clock-names
> > +
> > +  "^pwm@[a-f0-9]+$":
> > +    type: object
> > +    allOf: [ $ref: ../pwm/pwm.yaml# ]
> > +    properties:
> > +      compatible:
> > +        oneOf:
> > +          - enum:
> > +            - ingenic,jz4740-pwm
> > +          - items:
> > +            - enum:
> > +              - ingenic,jz4770-pwm
> > +              - ingenic,jz4780-pwm
> > +            - const: ingenic,jz4740-pwm
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        minItems: 6
> > +        maxItems: 8
> > +
> > +      clock-names:
> > +        items:
> > +          - const: timer0
> > +          - const: timer1
> > +          - const: timer2
> > +          - const: timer3
> > +          - const: timer4
> > +          - const: timer5
> > +          - const: timer6
> > +          - const: timer7
> > +        minItems: 6
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - clocks
> > +      - clock-names
> > +
> > +  "^timer@[a-f0-9]+$":
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        oneOf:
> > +          - enum:
> > +            - ingenic,jz4725b-ost
> > +            - ingenic,jz4770-ost
> > +          - items:
> > +            - const: ingenic,jz4780-ost
> > +            - const: ingenic,jz4770-ost
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        maxItems: 1
> > +
> > +      clock-names:
> > +        const: ost
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - clocks
> > +      - clock-names
> > +      - interrupts
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - "#clock-cells"
> > +  - "#interrupt-cells"
> > +  - interrupt-controller
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +
> > +additionalProperties: false
> 
> Actually this prevents the 'assigned-clock' properties from being added. I
> was expecting these to be always accepted, akin to the 'pinctrl-*'
> properties.
> 
> Should I add entries for these here?

Yes, I think so. The assigned-clocks properties are a lot less common 
than pinctrl and I think it's good to define how many entries they have.

Otherwise, this looks fine.

Rob
