Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86649C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EC12078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587420968;
	bh=f3G9ZD0BbBmUxjgcsAaQZrv1GckThsWsVO10nCYR9aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QvFkjBAxU+8LW5TjPPoaX/70nvh0tMu7/ehvdQ+ko5Sz3023/BVsKfMQv/GV7l+bN
	 EhOv7cg/lhnknYWXehj+CcDnWEzk7nnjTz0JtiiflcPhAywR0YNITGyDGt0gGJS7bL
	 uZCIXVONAyMdaD/jR82HRxbw58f1gw9Qd40YhBxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgDTWQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45606 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:16:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id k133so10284711oih.12;
        Mon, 20 Apr 2020 15:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JYtg5xrBOGCVcUTxh0ymA9TaxmbBLhyf6qoSVd2F73E=;
        b=kulcwv4Mi7Zj2ogVF+m3Qu7xAzvBW5oCD8tN2/bM+TQU8lhq5TQAaKdAMCu+LEuO/K
         JDQ85p6FloliVIVld9wRdyCp+iNqbO3RypzSmK7JgOy84M1jaRRxGP3gUA6gjglAEwjj
         KCxA3kLF/h2kGlvoggvU2/u2FxHhnMqNhf/mn9cB1MQPuuHuduyi3z39RN+cfdQ6J8az
         TnCLTvnLONPwYY1rqeplpwCUq0jqmMnpJ7SYyn3XzMiPhlC00CIOnhs+qxImYJ4YxQy2
         +J4XD+6IlhNjI3mTTF1MxJ+NLyYI22Z4JWALt2NGAsa8zPYW799XzEIMpY9W44vONc1v
         e4cQ==
X-Gm-Message-State: AGi0PuY2YIDs64b7+8Vz6d3Pbhhmcma7WiqtAdyZ4Wd4KpTfGTf4XF6+
        PDxTbqO2pl5SbCHp7k1mhw==
X-Google-Smtp-Source: APiQypKICII+0PHypwX7Hpq54IHND8wbdav+jw6nlsx5L3hOszMErjRYDSlzSnc1bh+fmsVDx+cyhw==
X-Received: by 2002:aca:fc0a:: with SMTP id a10mr1160884oii.77.1587420965163;
        Mon, 20 Apr 2020 15:16:05 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v3sm254197ote.39.2020.04.20.15.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:16:04 -0700 (PDT)
Received: (nullmailer pid 28057 invoked by uid 1000);
        Mon, 20 Apr 2020 22:16:03 -0000
Date:   Mon, 20 Apr 2020 17:16:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: atmel-tcb: convert bindings to
 json-schema
Message-ID: <20200420221603.GA10035@bogus>
References: <20200415094826.132562-1-alexandre.belloni@bootlin.com>
 <20200415094826.132562-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415094826.132562-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:48:18AM +0200, Alexandre Belloni wrote:
> Convert Atmel Timer Counter Blocks bindings to DT schema format using
> json-schema.
> 
> Also move it out of mfd as it is not and has never been related to mfd.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> 
> Changes in v2:
>  - Rebased on v5.7-rc1
>  - Moved the binding documentation to its proper place
>  - Added back the atmel,tcb-timer child node documentation
> 
>  .../devicetree/bindings/mfd/atmel-tcb.txt     | 56 ------------
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 89 +++++++++++++++++++
>  .../bindings/timer/atmel,tcb-timer.yaml       | 51 +++++++++++
>  3 files changed, 140 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
>  create mode 100644 Documentation/devicetree/bindings/timer/atmel,tcb-timer.yaml


> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> new file mode 100644
> index 000000000000..2522fb1f4ce4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/microchip/atmel,at91rm9200-tcb.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Atmel Timer Counter Block
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +description: |
> +  The Atmel (now Microchip) SoCs have timers named Timer Counter Block. Each
> +  timer has three channels with two counters each.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - atmel,at91rm9200-tcb
> +          - atmel,at91sam9x5-tcb
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      List of interrupts. One interrupt per TCB channel if available or one
> +      interrupt for the TC block
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    description:
> +      List of clock names. Always includes t0_clk and slow clk. Also includes
> +      t1_clk and t2_clk if a clock per channel is available.

This description can be expressed as:

allOf:
  - contains: 
      const: t0_clk
  - contains: 
      const: slow_clk

However, if there's only 2 combinations to support with either 2 clocks 
or 4 clocks, then a 'oneOf' listing the 2 exact items lists would be 
better.

> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      enum:
> +        - t0_clk
> +        - t1_clk
> +        - t2_clk
> +        - slow_clk
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 4
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - '#address-cells'
> +  - '#size-cells'

additionalProperties: false

> +
> +examples:
> +  - |
> +    /* One interrupt per TC block: */
> +        tcb0: timer@fff7c000 {
> +                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";

A simple-mfd without child nodes?

> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0xfff7c000 0x100>;
> +                interrupts = <18 4>;
> +                clocks = <&tcb0_clk>, <&clk32k>;
> +                clock-names = "t0_clk", "slow_clk";
> +        };
> +
> +    /* One interrupt per TC channel in a TC block: */
> +        tcb1: timer@fffdc000 {
> +                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0xfffdc000 0x100>;
> +                interrupts = <26 4>, <27 4>, <28 4>;
> +                clocks = <&tcb1_clk>, <&clk32k>;
> +                clock-names = "t0_clk", "slow_clk";
> +        };
> diff --git a/Documentation/devicetree/bindings/timer/atmel,tcb-timer.yaml b/Documentation/devicetree/bindings/timer/atmel,tcb-timer.yaml
> new file mode 100644
> index 000000000000..a6173ceab6be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/atmel,tcb-timer.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/timer/atmel,tcb-timer.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Atmel Timer Counter Block timer channel
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +description: |
> +  The Atmel (now Microchip) Timer Counter Block have multiple channels that can
> +  be used as timers.
> +
> +properties:
> +  compatible:
> +    const: atmel,tcb-timer
> +  reg:
> +    description:
> +      List of channels to use for this particular timer.
> +    minItems: 1
> +    maxItems: 3
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

This should just be merged into the 1st schema with this being 
defined as child nodes.

> +
> +examples:
> +  - |
> +        timer@fff7c000 {
> +                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0xfff7c000 0x100>;
> +                interrupts = <18 4>;
> +                clocks = <&tcb0_clk>, <&clk32k>;
> +                clock-names = "t0_clk", "slow_clk";
> +
> +                timer@0 {
> +                        compatible = "atmel,tcb-timer";
> +                        reg = <0>, <1>;
> +                };
> +
> +                timer@2 {
> +                        compatible = "atmel,tcb-timer";
> +                        reg = <2>;
> +                };
> +        };
> -- 
> 2.25.2
> 
