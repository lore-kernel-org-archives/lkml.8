Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46499C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 15:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CC520659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 15:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgDEPet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:34:49 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39772 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgDEPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 11:34:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D93AD80045F3;
        Sun,  5 Apr 2020 15:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x37euBZrnQIW; Sun,  5 Apr 2020 18:34:44 +0300 (MSK)
Date:   Sun, 5 Apr 2020 18:35:05 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: clk: Add Baikal-T1 System Devices CCU
 bindings
Message-ID: <20200405153505.5u2fi3orbgbxitav@ubsrv2.baikal.int>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130056.7434E80307C4@mail.baikalelectronics.ru>
 <20200310021915.8A0E7803087C@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200310021915.8A0E7803087C@mail.baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 07:19:12PM -0700, Stephen Boyd wrote:
> Quoting Sergey.Semin@baikalelectronics.ru (2020-03-06 05:00:46)
> > diff --git a/Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml b/Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml
> > new file mode 100644
> > index 000000000000..aea09fbafc89
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml
> > @@ -0,0 +1,169 @@
> [..]
> > +  assigned-clock-rates: true
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#clock-cells"
> > +  - clocks
> > +  - clock-names
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/bt1-ccu.h>
> > +
> > +    ccu_sys: ccu_sys@1F04D060 {
> 
> Node name should be clock-controller@1f04d060.

Ok.

> 
> Also, binding looks wrong because that address isn't aligned. Most
> likely it's one hardware block that has many different functionalities
> so splitting it up into different regions isn't doing anything besides
> logically splitting up the register space for software benefits.

As I said in RFC: https://lkml.org/lkml/2020/3/22/393 , CCU (Clock
Control Unit) is part of the Baikal-T1 System Control Module (simply
speaking the system controller). In details why I split the system
controller registers space up, I described in the text. Alternatively I
also suggested there to make the CCU nodes being sub-nodes of the System
Control Module DT node. This would better reflect the hardware blocks,
but instead of having an independent registers MMIO in driver I would
have to use the syscon regmap handler.

As I also said in the RFC, in accordance with the Baikal-T1 CCU documentation
CCU is split up into three blocks: PLLs, AXI-bus clocks and System devices
clocks. That's why the CCU driver expects to find three DT nodes:
CCU PLL (be,bt1-ccu-pll), CCU AXI (be,bt1-ccu-axi) and CCU Sys
(be,bt1-ccu-sys).

> 
> > +      compatible = "be,bt1-ccu-sys";
> > +      reg = <0x1F04D060 0x0A0>,
> > +            <0x1F04D150 0x004>;
> > +      #clock-cells = <1>;
> > +      #reset-cells = <1>;
> > +
> > +      clocks = <&osc25>,
> > +               <&ccu_pll CCU_SATA_PLL>,
> > +               <&ccu_pll CCU_PCIE_PLL>,
> > +               <&ccu_pll CCU_ETH_PLL>;
> > +      clock-names = "ref_clk", "sata_clk", "pcie_clk",
> > +                    "eth_clk";
> > +
> > +      clock-output-names = "sys_sata_ref_clk", "sys_apb_clk",
> > +                           "sys_gmac0_csr_clk", "sys_gmac0_tx_clk",
> > +                           "sys_gmac0_ptp_clk", "sys_gmac1_csr_clk",
> > +                           "sys_gmac1_tx_clk", "sys_gmac1_ptp_clk",
> > +                           "sys_xgmac_ref_clk", "sys_xgmac_ptp_clk",
> > +                           "sys_usb_clk", "sys_pvt_clk",
> > +                           "sys_hwa_clk", "sys_uart_clk",
> > +                           "sys_spi_clk", "sys_i2c1_clk",
> > +                           "sys_i2c2_clk", "sys_gpio_clk",
> > +                           "sys_timer0_clk", "sys_timer1_clk",
> > +                           "sys_timer2_clk", "sys_wdt_clk";
> > +      };
> > +...
> > diff --git a/include/dt-bindings/reset/bt1-ccu.h b/include/dt-bindings/reset/bt1-ccu.h
> > index 4de5b6bcd433..0bd8fd0edb41 100644
> > --- a/include/dt-bindings/reset/bt1-ccu.h
> > +++ b/include/dt-bindings/reset/bt1-ccu.h
> > @@ -20,4 +20,8 @@
> >  #define CCU_AXI_HWA_RST                        9
> >  #define CCU_AXI_SRAM_RST               10
> >  
> > +/* Baikal-T1 System Devices CCU Reset indeces. */
> 
> indeces is not a word.

Yeah, it was supposed to be "indices". I'll remove this comment anyway.

Regards,
-Sergey

> 
> > +#define CCU_SYS_SATA_REF_RST           0
> > +#define CCU_SYS_APB_RST                        1
> > +
