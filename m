Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2E5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04DC206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584046215;
	bh=3owZskGdeD7GUKRiKLvODK9G/f3cdxg71TXQWjtskPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EQUWPg/bo5eumraDv6eBxJUpkmNTocU0U/aMnFpJL0g6MFtwUpDp2gvmxbYqdVyIY
	 cXMCYLKCKe/EtrQWFCyvVQYZmE8p+T9lwa5qW9I7x6HvWUFLpJYjW58InbGhmZHpxs
	 u8GdXv7McOoTUFXShC/Cz/xfmoCiSrISNANp37uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgCLUuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:50:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42420 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgCLUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:50:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so7783401otd.9;
        Thu, 12 Mar 2020 13:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54SQIsOq6jTtoYFq0ah9FTI+kR+4WkSQB/K3Tm3pXKg=;
        b=lSl3qHF37+AnFyZb0l81wKljHvWPU3pe69Nr8mjPkqsyMDbZ8qMx0NP0CW5cev5ogi
         mqPc6uZombvPqmXwQc6W/2QOnkIKO5Skwn6nxX94tPfTnGN7+Dd5t/yp9gyziWwXYwFa
         QCWg706xhWYyybho/4/WdirLkdxbG7i5BIKtJTg8vbHw+4EiARuLtJiZUOWcbZIC5rEn
         4ooaiqVpc1zc4O9fcnwkQrPF/TCr0+iBYYBwb4d2qANjNrrj2SZ9GSHJllsXe7vDw9sq
         dHNNzLPgJdPGVji2G9Fa/Y+K9hVmbqyXolcUgBg6liud1QmaX/PFa7x/vkoOVfy2NwFf
         E/jw==
X-Gm-Message-State: ANhLgQ3ca41d9/YfoV6oCyTz4rPvBylypfsitG2eaUx9/zM/vfhJeGzq
        GqfahrXfNce2G2/xFuudEA==
X-Google-Smtp-Source: ADFU+vtX/mxGBEX6bfmwnZs1NsucNTTS2Oeq0V4O1l0lzxGUpGPIfGTOAwtjklpt9+NqqWBdYayhcg==
X-Received: by 2002:a9d:a51:: with SMTP id 75mr7843593otg.112.1584046213127;
        Thu, 12 Mar 2020 13:50:13 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k17sm7162518oic.45.2020.03.12.13.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:50:12 -0700 (PDT)
Received: (nullmailer pid 16536 invoked by uid 1000);
        Thu, 12 Mar 2020 20:50:11 -0000
Date:   Thu, 12 Mar 2020 15:50:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: clk: Add Baikal-T1 AXI-bus CCU bindings
Message-ID: <20200312205011.GA10607@bogus>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130055.7F70E8030793@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130055.7F70E8030793@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:00:45PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> After being gained by the CCU PLLs the signals must be transformed to
> be suitable for the clock-consumers. This is done by a set of dividers
> embedded into the CCU. A first block of dividers is used to create
> reference clocks for AXI-bus of high-speed peripheral IP-cores of the
> chip. So the AXI-bus CCU dts-node is an ordinary clock-provider with
> standard set of properties supported. But in addition to that each
> AXI-bus clock divider provide a way to reset the corresponding clock
> domain. This makes the AXI-bus CCU dts-node to be also a reset-provider.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  .../bindings/clock/be,bt1-ccu-axi.yaml        | 151 ++++++++++++++++++
>  include/dt-bindings/clock/bt1-ccu.h           |  13 ++
>  include/dt-bindings/reset/bt1-ccu.h           |  23 +++
>  3 files changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
>  create mode 100644 include/dt-bindings/reset/bt1-ccu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml b/Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
> new file mode 100644
> index 000000000000..6b1eefdead27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +#
> +# Copyright (C) 2019 - 2020 BAIKAL ELECTRONICS, JSC
> +#
> +# Baikal-T1 AXI-bus Clocks Control Unit Device Tree Bindings.

As Stephen said, drop this. You can keep the copyright, just make it 
line 2.

> +#
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/be,bt1-ccu-axi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Baikal-T1 AXI-bus Clock Control Unit
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description: |
> +  Clocks Control Unit is the core of Baikal-T1 SoC responsible for the chip
> +  subsystems clocking and resetting. The CCU is connected with an external
> +  fixed rate oscillator, which signal is transformed into clocks of various
> +  frequencies and then propagated to either individual IP-blocks or to groups
> +  of blocks (clock domains). The transformation is done by means of an embedded
> +  into CCU PLLs and gateable/non-gateable dividers. Each clock domain can be
> +  also individually reset by using the domain clocks divider configuration
> +  registers. Baikal-T1 CCU is logically divided into the next components:
> +  1) External oscillator (normally XTAL's 25 MHz crystal oscillator, but
> +     in general can provide any frequency supported by the CCU PLLs).
> +  2) PLLs clocks generators (PLLs).
> +  3) AXI-bus clock dividers (AXI) - described in this bindings file.
> +  4) System devices reference clock dividers (SYS).
> +  which are connected with each other as shown on the next figure:
> +          +---------------+
> +          | Baikal-T1 CCU |
> +          |   +----+------|- MIPS P5600 cores
> +          | +-|PLLs|------|- DDR controller
> +          | | +----+      |
> +  +----+  | |  |  |       |
> +  |XTAL|--|-+  |  | +---+-|
> +  +----+  | |  |  +-|AXI|-|- AXI-bus
> +          | |  |    +---+-|
> +          | |  |          |
> +          | |  +----+---+-|- APB-bus
> +          | +-------|SYS|-|- Low-speed Devices
> +          |         +---+-|- High-speed Devices
> +          +---------------+
> +  Each sub-block is represented as a separate dts-node and has an individual
> +  driver to be bound with.
> +
> +  In order to create signals of wide range frequencies the external oscillator
> +  output is primarily connected to a set of CCU PLLs. Some of PLLs CLKOUT are
> +  then passed over CCU dividers to create signals required for the target clock
> +  domain (like AXI-bus consumers). The dividers have the following structure:
> +          +--------------+
> +  CLKIN --|->+----+ 1|\  |
> +  SETCLK--|--|/DIV|->| | |
> +  CLKDIV--|--|    |  | |-|->CLKLOUT
> +  LOCK----|--+----+  | | |
> +          |          |/  |
> +          |           |  |
> +  EN------|-----------+  |
> +  RST-----|--------------|->RSTOUT
> +          +--------------+
> +  where CLKIN is the reference clock coming either from a CCU PLL, SETCLK - a
> +  command to update the output clock in accordance with a set divider,
> +  CLKDIV - clocks divider, LOCK - a signal of the output clock stabilization,
> +  EN - enable/disable the divider block, RST/RSTOUT - reset clocks domain
> +  signal. Depending on the consumer IP-core peculiarities the dividers may lack
> +  of some functionality depicted on the figure above (like EN,
> +  CLKDIV/LOCK/SETCLK). In this case the corresponding clock provider just
> +  doesn't expose either switching functions, or the rate configuration, or
> +  both of them.
> +
> +  The CCU AXI dts-node uses the common clock bindings [1] with no custom
> +  properties. The list of exported clocks and reset signals can be found in
> +  the files: 'dt-bindings/clock/bt1-ccu.h' and 'dt-bindings/reset/bt1-ccu.h'.
> +
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +allOf:
> +  - $ref: /schemas/clock/clock.yaml#

Drop this, not needed (clock.yaml is applied to every node).

> +
> +properties:
> +  compatible:
> +    const: be,bt1-ccu-axi
> +
> +  reg:
> +    description: AXI-bus CCU dividers sub-block base address.

Don't really need this.

> +    maxItems: 1
> +
> +  "#clock-cells":
> +    description: |
> +      Clocks are referenced by the node phandle and an unique identifier
> +      from 'dt-bindings/clock/bt1-ccu.h'.
> +    const: 1
> +
> +  "#reset-cells":
> +    description: |
> +      AXI-bus CCU sub-block provides a reset signal for each clock domain,
> +      which unique identifiers are in 'dt-bindings/reset/bt1-ccu.h'.
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: CCU SATA PLL output clock.
> +      - description: CCU PCIe PLL output clock.
> +      - description: CCU Ethernet PLL output clock.
> +
> +  clock-names:
> +    items:
> +      - const: sata_clk
> +      - const: pcie_clk
> +      - const: eth_clk
> +
> +  clock-output-names: true
> +
> +  assigned-clocks: true
> +
> +  assigned-clock-rates: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bt1-ccu.h>
> +
> +    ccu_axi: ccu_axi@1F04D030 {

clock-controller@1f04d030

> +      compatible = "be,bt1-ccu-axi";
> +      reg = <0x1F04D030 0x030>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +
> +      clocks = <&ccu_pll CCU_SATA_PLL>,
> +               <&ccu_pll CCU_PCIE_PLL>,
> +               <&ccu_pll CCU_ETH_PLL>;
> +      clock-names = "sata_clk", "pcie_clk", "eth_clk";
> +
> +      clock-output-names = "axi_main_clk", "axi_ddr_clk",
> +                           "axi_sata_clk", "axi_gmac0_clk",
> +                           "axi_gmac1_clk", "axi_xgmac_clk",
> +                           "axi_pcie_m_clk", "axi_pcie_s_clk",
> +                           "axi_usb_clk", "axi_hwa_clk",
> +                           "axi_sram_clk";
> +    };
> +...
> diff --git a/include/dt-bindings/clock/bt1-ccu.h b/include/dt-bindings/clock/bt1-ccu.h
> index 86e63162ade0..ebe723c6e0a8 100644
> --- a/include/dt-bindings/clock/bt1-ccu.h
> +++ b/include/dt-bindings/clock/bt1-ccu.h
> @@ -14,4 +14,17 @@
>  #define CCU_PCIE_PLL			3
>  #define CCU_ETH_PLL			4
>  
> +/* Baikal-T1 AXI-bus CCU Clocks indeces. */
> +#define CCU_AXI_MAIN_CLK		0
> +#define CCU_AXI_DDR_CLK			1
> +#define CCU_AXI_SATA_CLK		2
> +#define CCU_AXI_GMAC0_CLK		3
> +#define CCU_AXI_GMAC1_CLK		4
> +#define CCU_AXI_XGMAC_CLK		5
> +#define CCU_AXI_PCIE_M_CLK		6
> +#define CCU_AXI_PCIE_S_CLK		7
> +#define CCU_AXI_USB_CLK			8
> +#define CCU_AXI_HWA_CLK			9
> +#define CCU_AXI_SRAM_CLK		10
> +
>  #endif /* __DT_BINDINGS_CLOCK_BT1_CCU_H */
> diff --git a/include/dt-bindings/reset/bt1-ccu.h b/include/dt-bindings/reset/bt1-ccu.h
> new file mode 100644
> index 000000000000..4de5b6bcd433
> --- /dev/null
> +++ b/include/dt-bindings/reset/bt1-ccu.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> + *
> + * Baikal-T1 CCU reset indeces.
> + */
> +#ifndef __DT_BINDINGS_RESET_BT1_CCU_H
> +#define __DT_BINDINGS_RESET_BT1_CCU_H
> +
> +/* Baikal-T1 AXI-bus CCU Reset indeces. */
> +#define CCU_AXI_MAIN_RST		0
> +#define CCU_AXI_DDR_RST			1
> +#define CCU_AXI_SATA_RST		2
> +#define CCU_AXI_GMAC0_RST		3
> +#define CCU_AXI_GMAC1_RST		4
> +#define CCU_AXI_XGMAC_RST		5
> +#define CCU_AXI_PCIE_M_RST		6
> +#define CCU_AXI_PCIE_S_RST		7
> +#define CCU_AXI_USB_RST			8
> +#define CCU_AXI_HWA_RST			9
> +#define CCU_AXI_SRAM_RST		10
> +
> +#endif /* __DT_BINDINGS_RESET_BT1_CCU_H */
> -- 
> 2.25.1
> 
