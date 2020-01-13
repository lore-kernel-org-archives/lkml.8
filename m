Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CB5C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3567720CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578949824;
	bh=+f5qL836/JPP3ORqY8xkX7xhHl+dfga58+SLP9NnIPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V3N0HAes01VY0tTddXR/ZerpteEkw22+78qMF7AxI3UCQumO2jQOP3358X7x/Jhc0
	 r50j9Qxk0qbIrhFrpAEED8xsuhYPmAIOmkdwy0n/gFMtRnqxXxPkpIDVNyA/Q0mdT5
	 l+VDbIPA56dQGAnkOXqaVqjd3ukzN6/NcKctUPzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAMVKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:10:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38582 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMVKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:10:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so9705557oii.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 13:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MBFiDoGwJ4OcLk5EAnsqRbkOjyupomEYDWpcUs8IlxQ=;
        b=sWYQz1aVXayGvEf+W/waM5XRP5BfA8i6hYDln+TXbE0q86oKiEx5XNEAX4Wm/wEF++
         q5zo2b2GgknnyxZ2iG+hG0fvbn8948YurXtw1s5dKrNnFqT89ItuqWJYYCY2gZp3yvK6
         zzEDED5jEzAU7UOxIWPH6YvBoeEX+fi7K1vh5k3Xgtplv7uOcJ82ARuw3Q4xIcpf2xV5
         BXXEFVD1lOKFGrjWC9ZjdtHFrDPj+xAH1bGCdnGLDr4uq9wIabbT98kkWBNpRmqml2HE
         g4lhVrfv99lGVKgI2BjnJdCdEk+Y1a9p1n7FUTSLnhTV7IeGSsYPU1KjsacMUsgQcU3V
         1fww==
X-Gm-Message-State: APjAAAUo9EVQUBsJ6t2czN6UowfyIIEOfV0UpkbuWoqswerOdN2fqrIe
        A+vwYEzLMGUjQwgWkyxebjgEm0w=
X-Google-Smtp-Source: APXvYqxff9jVdulUwxunvyj0FWdh9ACQC/2wRhV/dZHYMgffFfVOS0ZYJv41FLYPzJyVlHw1KDdQtw==
X-Received: by 2002:aca:b1d5:: with SMTP id a204mr13865533oif.82.1578949821691;
        Mon, 13 Jan 2020 13:10:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w201sm3907202oif.29.2020.01.13.13.10.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:10:20 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220d32
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 15:10:20 -0600
Date:   Mon, 13 Jan 2020 15:10:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: Document the Amlogic Meson SDHC
 MMC host controller
Message-ID: <20200113211020.GA12476@bogus>
References: <20200112002459.2124850-1-martin.blumenstingl@googlemail.com>
 <20200112002459.2124850-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112002459.2124850-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 01:24:57AM +0100, Martin Blumenstingl wrote:
> This documents the devicetree bindings for the SDHC MMC host controller
> found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
> bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
> HS200 mode (up to 100MHz clock). It embeds an internal clock controller
> which outputs four clocks (mod_clk, sd_clk, tx_clk and rx_clk) and is
> fed by four external input clocks (clkin[0-3]). "pclk" is the module
> register clock, it has to be enabled to access the registers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 83 +++++++++++++++++++
>  .../dt-bindings/clock/meson-mx-sdhc-clkc.h    |  8 ++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
>  create mode 100644 include/dt-bindings/clock/meson-mx-sdhc-clkc.h

Fails 'make dt_binding_check':

Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.example.dts:17:53: 
warning: extra tokens at end of #include directive
 #include <dt-bindings/clock/meson-mx-sdhc-clkc.yaml>;
                                                     ^
Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.example.dts:17:10: 
fatal error: dt-bindings/clock/meson-mx-sdhc-clkc.yaml: No such file or directory
 #include <dt-bindings/clock/meson-mx-sdhc-clkc.yaml>;
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> 
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> new file mode 100644
> index 000000000000..74632692ce26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson SDHC controller Device Tree Bindings
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +description: |
> +  The SDHC MMC host controller on Amlogic SoCs provides an eMMC and MMC
> +  card interface with 1/4/8-bit bus width.
> +  It supports eMMC spec 4.4x/4.5x including HS200 (up to 100MHz clock).
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - amlogic,meson8-sdhc
> +        - amlogic,meson8b-sdhc
> +        - amlogic,meson8m2-sdhc
> +      - const: amlogic,meson-mx-sdhc
> +
> +  reg:
> +    minItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    minItems: 9
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: mod_clk
> +      - const: sd_clk
> +      - const: rx_clk
> +      - const: tx_clk
> +      - const: clkin0
> +      - const: clkin1
> +      - const: clkin2
> +      - const: clkin3

Kind of odd to put the output clocks in the middle of the list.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/meson-mx-sdhc-clkc.yaml>;
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    sdhc: mmc@8e00 {
> +      compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
> +      reg = <0x8e00 0x42>;
> +      interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
> +      #clock-cells = <1>;
> +      clocks = <&sdhc_pclk>,
> +               <&sdhc SDHC_CLKID_MOD_CLK>,
> +               <&sdhc SDHC_CLKID_SD_CLK>,
> +               <&sdhc SDHC_CLKID_TX_CLK>,
> +               <&sdhc SDHC_CLKID_RX_CLK>,
> +               <&xtal>,
> +               <&fclk_div4>,
> +               <&fclk_div3>,
> +               <&fclk_div5>;
> +      clock-names = "pclk", "mod_clk", "sd_clk", "tx_clk", "rx_clk",
> +                    "clkin0", "clkin1", "clkin2", "clkin3";
> +    };
> diff --git a/include/dt-bindings/clock/meson-mx-sdhc-clkc.h b/include/dt-bindings/clock/meson-mx-sdhc-clkc.h
> new file mode 100644
> index 000000000000..ad9f6e4dc426
> --- /dev/null
> +++ b/include/dt-bindings/clock/meson-mx-sdhc-clkc.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#define SDHC_CLKID_SRC_SEL	0
> +#define SDHC_CLKID_DIV		1
> +#define SDHC_CLKID_MOD_CLK	2
> +#define SDHC_CLKID_SD_CLK	3
> +#define SDHC_CLKID_TX_CLK	4
> +#define SDHC_CLKID_RX_CLK	5
> -- 
> 2.24.1
> 
