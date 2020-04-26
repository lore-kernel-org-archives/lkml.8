Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C323CC55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38D3208FE
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgDZGSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 02:18:34 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57056 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDZGSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 02:18:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C7E908030790;
        Sun, 26 Apr 2020 06:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n4AzBeZ1jlz2; Sun, 26 Apr 2020 09:18:25 +0300 (MSK)
Date:   Sun, 26 Apr 2020 09:18:24 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <fancer.lancer@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: clk: Add Baikal-T1 CCU PLLs bindings
Message-ID: <20200426061824.sg2knhgncdheci4v@mobilestation>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130054.8702F8030786@mail.baikalelectronics.ru>
 <20200310021052.2E40F80307C5@mail.baikalelectronics.ru>
 <20200405095925.6vwclimnba7lefe4@ubsrv2.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200405095925.6vwclimnba7lefe4@ubsrv2.baikal.int>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,
It has been a while since I responded with a few backward questions. Do you
have anything to answer? I am going to send v2 soon, so I need to have those
questions cleared before that.

Regards,
-Sergey

On Sun, Apr 05, 2020 at 12:59:25PM +0300, Sergey Semin wrote:
> Hello Stephen,
> 
> Sorry for a delayed response. My answers to your comments are below.
> 
> On Mon, Mar 09, 2020 at 07:02:27PM -0700, Stephen Boyd wrote:
> > Quoting Sergey.Semin@baikalelectronics.ru (2020-03-06 05:00:44)
> > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > Baikal-T1 Clocks Control Unit is responsible for transformation of a
> > > signal coming from an external oscillator into clocks of various
> > > frequencies to propagate them then to the corresponding clocks
> > > consumers (either individual IP-blocks or clock domains). In order
> > > to create a set of high-frequency clocks the external signal is
> > > firstly handled by the embedded into CCU PLLs. So the corresponding
> > > dts-node is just a normal clock-provider node with standard set of
> > > properties.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > 
> > SoB chain is backwards. Is Alexey the author? Or Co-developed-by?
> 
> Thanks for noticing this. I'll rearrange the SoB's in v2.
> 
> > 
> > > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > Cc: Paul Burton <paulburton@kernel.org>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > ---
> > >  .../bindings/clock/be,bt1-ccu-pll.yaml        | 139 ++++++++++++++++++
> > >  include/dt-bindings/clock/bt1-ccu.h           |  17 +++
> > >  2 files changed, 156 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml
> > >  create mode 100644 include/dt-bindings/clock/bt1-ccu.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml b/Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml
> > > new file mode 100644
> > > index 000000000000..f2e397cc147b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml
> > > @@ -0,0 +1,139 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Copyright (C) 2019 - 2020 BAIKAL ELECTRONICS, JSC
> > > +#
> > > +# Baikal-T1 Clocks Control Unit PLL Device Tree Bindings.
> > > +#
> > 
> > I don't think we need any of these comments besides the license
> > identifier line. Can you dual license this?
> > 
> 
> It's normal to have a copyright here, but in a single-lined form.
> I'll do this in v2 and also dual license the binding file.
> 
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/be,bt1-ccu-pll.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Baikal-T1 Clock Control Unit PLLs
> > > +
> > > +maintainers:
> > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > +
> > > +description: |
> > > +  Clocks Control Unit is the core of Baikal-T1 SoC responsible for the chip
> > > +  subsystems clocking and resetting. The CCU is connected with an external
> > > +  fixed rate oscillator, which signal is transformed into clocks of various
> > > +  frequencies and then propagated to either individual IP-blocks or to groups
> > > +  of blocks (clock domains). The transformation is done by means of PLLs and
> > > +  gateable/non-gateable dividers embedded into the CCU. It's logically divided
> > > +  into the next components:
> > > +  1) External oscillator (normally XTAL's 25 MHz crystal oscillator, but
> > > +     in general can provide any frequency supported by the CCU PLLs).
> > > +  2) PLLs clocks generators (PLLs) - described in this bindings file.
> > > +  3) AXI-bus clock dividers (AXI).
> > > +  4) System devices reference clock dividers (SYS).
> > > +  which are connected with each other as shown on the next figure:
> > 
> > Please add a newline here
> 
> Ok.
> 
> > 
> > > +          +---------------+
> > > +          | Baikal-T1 CCU |
> > > +          |   +----+------|- MIPS P5600 cores
> > > +          | +-|PLLs|------|- DDR controller
> > > +          | | +----+      |
> > > +  +----+  | |  |  |       |
> > > +  |XTAL|--|-+  |  | +---+-|
> > > +  +----+  | |  |  +-|AXI|-|- AXI-bus
> > > +          | |  |    +---+-|
> > > +          | |  |          |
> > > +          | |  +----+---+-|- APB-bus
> > > +          | +-------|SYS|-|- Low-speed Devices
> > > +          |         +---+-|- High-speed Devices
> > > +          +---------------+
> > 
> > And here.
> > 
> 
> Ok
> 
> > > +  Each CCU sub-block is represented as a separate dts-node and has an
> > > +  individual driver to be bound with.
> > > +
> > > +  In order to create signals of wide range frequencies the external oscillator
> > > +  output is primarily connected to a set of CCU PLLs. There are five PLLs
> > > +  to create a clock for the MIPS P5600 cores, the embedded DDR controller,
> > > +  SATA, Ethernet and PCIe domains. The last three domains though named by the
> > > +  biggest system interfaces in fact include nearly all of the rest SoC
> > > +  peripherals. Each of the PLLs is based on True Circuits TSMC CLN28HPM core
> > > +  with an interface wrapper (so called safe PLL' clocks switcher) to simplify
> > > +  the PLL configuration procedure. The PLLs work as depicted on the next
> > > +  diagram:
> > 
> > Same, space out the diagrams.
> > 
> 
> Ok
> 
> > > +      +--------------------------+
> > > +      |                          |
> > > +      +-->+---+    +---+   +---+ |  +---+   0|\
> > > +  CLKF--->|/NF|--->|PFD|...|VCO|-+->|/OD|--->| |
> > > +          +---+ +->+---+   +---+ /->+---+    | |--->CLKOUT
> > > +  CLKOD---------C----------------+          1| |
> > > +       +--------C--------------------------->|/
> > > +       |        |                             ^
> > > +  Rclk-+->+---+ |                             |
> > > +  CLKR--->|/NR|-+                             |
> > > +          +---+                               |
> > > +  BYPASS--------------------------------------+
> > > +  BWADJ--->
> > > +  where Rclk is the reference clock coming  from XTAL, NR - reference clock
> > > +  divider, NF - PLL clock multiplier, OD - VCO output clock divider, CLKOUT -
> > > +  output clock, BWADJ is the PLL bandwidth adjustment parameter. At this moment
> > > +  the binding supports the PLL dividers configuration in accordance with a
> > > +  requested rate, while bypassing and bandwidth adjustment settings can be
> > > +  added in future if it gets to be necessary.
> > > +
> > > +  The PLLs CLKOUT is then either directly connected with the corresponding
> > > +  clocks consumer (like P5600 cores or DDR controller) or passed over a CCU
> > > +  divider to create a signal required for the clock domain.
> > > +
> > > +  The CCU PLL dts-node uses the common clock bindings [1] with no custom
> > > +  parameters. The list of exported clocks can be found in
> > > +  'dt-bindings/clock/bt1-ccu.h'.
> > > +
> > > +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > 
> > Don't think we need to mention this binding anymore. But it's good that
> > we know what exported clock ids are.
> > 
> 
> Ok. I'll remove the legacy text binding file mention here and retain the
> reference to the header file with the clock IDs defined. The similar
> thing will be done for the others bindings in the patchset.
> 
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/clock/clock.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: be,bt1-ccu-pll
> > > +
> 
> > > +  reg:
> > > +    description: CCU PLLs sub-block base address.
> > > +    maxItems: 1
> > > +
> 
> Sometime ago I sent a RFC to Rob and you being in Cc there:
> https://lkml.org/lkml/2020/3/22/393
> Simply speaking there are several issues raised in comments to different
> patchsets, which are indirectly connected with the Baikal-T1 System Controller
> DT node design I've initially chosen. In accordance with that I've spread its
> functional blocks into different DT nodes with no reference to being related
> to the System Controller. Clock Control Unit nodes are amongst these blocks.
> Seeing such design caused these issues I suggested an alternative solution
> of having a single System Controller node and multiple functional sub-nodes.
> These sub-nodes will include the Clock Control Unit PLLs, AXI-bus and System
> Device blocks. I thoroughly described the solution in the RFC. So if no
> arguments against it pop up soon in the RFC comments, I'll implement it in
> v2 of this patchset as well. This solution cause the reg-property removal
> from this binding. Instead the drivers shall refer to the parental syscon
> node to get a regmap with CCU registers from it.
> 
> > > +  "#clock-cells":
> > > +    description: |
> > > +      Clocks are referenced by the node phandle and an unique identifier
> > > +      from 'dt-bindings/clock/bt1-ccu.h'.
> > 
> > Don't think we need this description.
> 
> Agreed.
> 
> > 
> > > +    const: 1
> > > +
> > > +  clocks:
> > > +    description: Phandle of CCU External reference clock.
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    const: ref_clk
> > 
> > Can we drop _clk? It's redundant.
> 
> I would leave this and "pcie_clk", "sata_clk", "eth_clk" declared in the
> next two bindings as is, since this way they would exactly match the names
> used in the documentation. The same thing is with the clock-output-names
> property values.
> 
> I've seen such names in many other drivers/bindings including the
> bindings in the clock subsystem even submitted rather recently, not to
> mention the names like "aclk", "pclk", etc used all over the dt nodes.
> Are there any requirements in naming the clocks? Should I avoid using the
> '_clk' clock names suffix in accordance with them? If so, please point
> me out to that requirement in docs for future reference.
> 
> Normally If I don't find something in the requirements documented in the kernel,
> I use either a commonly utilized practice seen in other similar drivers, or
> select a solution which seems better to me like providing a better readability
> and code understanding. 
> 
> > 
> > > +
> > > +  clock-output-names: true
> > > +
> > > +  assigned-clocks: true
> > > +
> > > +  assigned-clock-rates: true
> > > +
> > > +additionalProperties: false
> > > +
> 
> I'll also replace these four properties with a single
> "unevaluatedProperties: false". In the framework of other patchset
> review Rob said this property is more suitable in such situations and
> will get to be supported by the dt_binding_check script eventually.
> 
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#clock-cells"
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +examples:
> > > +  - |
> > > +    ccu_pll: ccu_pll@1F04D000 {
> > 
> > Drop the phandle unless it's actually used.
> 
> Do you mean the label definition? If so, Ok. I'll remove it.
> 
> Unit-address will be also lowercased if I don't remove the reg property
> from here. As I said in RFC in accordance with the alternative solution
> this node will be a sub-node of the system controller, which regmap will
> be used instead of the individual reg-property definition. So if the
> reg-property is removed from the node, the unit-address will be also
> discarded from here.
> 
> > 
> > > +      compatible = "be,bt1-ccu-pll";
> > > +      reg = <0x1F04D000 0x028>;
> > 
> > Lowercase hex please. That size is oddly small.
> 
> It's small due to be range being part of the system controller registers
> set. I've briefly described this above and thoroughly - in the RFC.
> Please see the RFC text and send your comments regarding an alternative
> solution there shall you have any.
> 
> Anyway if no comments are received there soon, I'll remove the reg
> property from here. The PLL driver will refer to the parental system
> controller to get the registers regmap handler.
> 
> > 
> > > +      #clock-cells = <1>;
> > > +
> > > +      clocks = <&osc25>;
> > > +      clock-names = "ref_clk";
> > > +
> > > +      clock-output-names = "cpu_pll", "sata_pll", "ddr_pll",
> > > +                           "pcie_pll", "eth_pll";
> > > +    };
> > > +...
> > > diff --git a/include/dt-bindings/clock/bt1-ccu.h b/include/dt-bindings/clock/bt1-ccu.h
> > > new file mode 100644
> > > index 000000000000..86e63162ade0
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/bt1-ccu.h
> > > @@ -0,0 +1,17 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> > > + *
> > > + * Baikal-T1 CCU clock indeces.
> > > + */
> > > +#ifndef __DT_BINDINGS_CLOCK_BT1_CCU_H
> > > +#define __DT_BINDINGS_CLOCK_BT1_CCU_H
> > > +
> > > +/* Baikal-T1 CCU PLL indeces. */
> > 
> > Please drop this comment. It's not useful.
> 
> Ok.
> 
> Regards,
> -Sergey
> 
> > 
> > > +#define CCU_CPU_PLL                    0
> > > +#define CCU_SATA_PLL                   1
> > > +#define CCU_DDR_PLL                    2
> > > +#define CCU_PCIE_PLL                   3
> > > +#define CCU_ETH_PLL                    4
> > > +
> > > +#endif /* __DT_BINDINGS_CLOCK_BT1_CCU_H */
> > > -- 
> > > 2.25.1
> > >
