Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D5CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B5824673
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583805751;
	bh=FvWmXhifLH28+e3wQQZPkBIUDs3JQQD15iI4K9wBkug=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=oIpvQT0s/iHGscMbfnFizT05TRt6COwKHbYWAfMkZAwQrpFsm8Hm1XJUeycjgX3JN
	 5WDc0eMQg5ARQFCfusKFa65tS0/jQllbGoFY+45qRjIZLL1SJVDraQ+Q8gylbmMMtN
	 iEcU9VhwVo5mPZ3z/v1g+bLZBCmdjycyscUaDvwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCJCCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgCJCCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:02:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F7A24649;
        Tue, 10 Mar 2020 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583805748;
        bh=FvWmXhifLH28+e3wQQZPkBIUDs3JQQD15iI4K9wBkug=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=b7pTicA8EG55D0rXerR1FsyxD4b5UzDLaQaUcbnNq+qm6jJ6MAyW71PglLqOa+9yw
         UxbHrq5QfI8VJ7+I68OSSnaY/vK3OaF7GRrAJBshUCxdIiY23z0rJ+J7gkDUtEyTmg
         IzCT7DVBBHVQAwEeYIsdVOghCobckv1ycklDo+pg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200306130054.8702F8030786@mail.baikalelectronics.ru>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru> <20200306130054.8702F8030786@mail.baikalelectronics.ru>
Subject: Re: [PATCH 1/5] dt-bindings: clk: Add Baikal-T1 CCU PLLs bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey.Semin@baikalelectronics.ru
Date:   Mon, 09 Mar 2020 19:02:27 -0700
Message-ID: <158380574777.149997.1766994748078874683@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey.Semin@baikalelectronics.ru (2020-03-06 05:00:44)
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>=20
> Baikal-T1 Clocks Control Unit is responsible for transformation of a
> signal coming from an external oscillator into clocks of various
> frequencies to propagate them then to the corresponding clocks
> consumers (either individual IP-blocks or clock domains). In order
> to create a set of high-frequency clocks the external signal is
> firstly handled by the embedded into CCU PLLs. So the corresponding
> dts-node is just a normal clock-provider node with standard set of
> properties.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>

SoB chain is backwards. Is Alexey the author? Or Co-developed-by?

> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  .../bindings/clock/be,bt1-ccu-pll.yaml        | 139 ++++++++++++++++++
>  include/dt-bindings/clock/bt1-ccu.h           |  17 +++
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-pl=
l.yaml
>  create mode 100644 include/dt-bindings/clock/bt1-ccu.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml =
b/Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml
> new file mode 100644
> index 000000000000..f2e397cc147b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2019 - 2020 BAIKAL ELECTRONICS, JSC
> +#
> +# Baikal-T1 Clocks Control Unit PLL Device Tree Bindings.
> +#

I don't think we need any of these comments besides the license
identifier line. Can you dual license this?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/be,bt1-ccu-pll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Baikal-T1 Clock Control Unit PLLs
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description: |
> +  Clocks Control Unit is the core of Baikal-T1 SoC responsible for the c=
hip
> +  subsystems clocking and resetting. The CCU is connected with an extern=
al
> +  fixed rate oscillator, which signal is transformed into clocks of vari=
ous
> +  frequencies and then propagated to either individual IP-blocks or to g=
roups
> +  of blocks (clock domains). The transformation is done by means of PLLs=
 and
> +  gateable/non-gateable dividers embedded into the CCU. It's logically d=
ivided
> +  into the next components:
> +  1) External oscillator (normally XTAL's 25 MHz crystal oscillator, but
> +     in general can provide any frequency supported by the CCU PLLs).
> +  2) PLLs clocks generators (PLLs) - described in this bindings file.
> +  3) AXI-bus clock dividers (AXI).
> +  4) System devices reference clock dividers (SYS).
> +  which are connected with each other as shown on the next figure:

Please add a newline here

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

And here.

> +  Each CCU sub-block is represented as a separate dts-node and has an
> +  individual driver to be bound with.
> +
> +  In order to create signals of wide range frequencies the external osci=
llator
> +  output is primarily connected to a set of CCU PLLs. There are five PLLs
> +  to create a clock for the MIPS P5600 cores, the embedded DDR controlle=
r,
> +  SATA, Ethernet and PCIe domains. The last three domains though named b=
y the
> +  biggest system interfaces in fact include nearly all of the rest SoC
> +  peripherals. Each of the PLLs is based on True Circuits TSMC CLN28HPM =
core
> +  with an interface wrapper (so called safe PLL' clocks switcher) to sim=
plify
> +  the PLL configuration procedure. The PLLs work as depicted on the next
> +  diagram:

Same, space out the diagrams.

> +      +--------------------------+
> +      |                          |
> +      +-->+---+    +---+   +---+ |  +---+   0|\
> +  CLKF--->|/NF|--->|PFD|...|VCO|-+->|/OD|--->| |
> +          +---+ +->+---+   +---+ /->+---+    | |--->CLKOUT
> +  CLKOD---------C----------------+          1| |
> +       +--------C--------------------------->|/
> +       |        |                             ^
> +  Rclk-+->+---+ |                             |
> +  CLKR--->|/NR|-+                             |
> +          +---+                               |
> +  BYPASS--------------------------------------+
> +  BWADJ--->
> +  where Rclk is the reference clock coming  from XTAL, NR - reference cl=
ock
> +  divider, NF - PLL clock multiplier, OD - VCO output clock divider, CLK=
OUT -
> +  output clock, BWADJ is the PLL bandwidth adjustment parameter. At this=
 moment
> +  the binding supports the PLL dividers configuration in accordance with=
 a
> +  requested rate, while bypassing and bandwidth adjustment settings can =
be
> +  added in future if it gets to be necessary.
> +
> +  The PLLs CLKOUT is then either directly connected with the correspondi=
ng
> +  clocks consumer (like P5600 cores or DDR controller) or passed over a =
CCU
> +  divider to create a signal required for the clock domain.
> +
> +  The CCU PLL dts-node uses the common clock bindings [1] with no custom
> +  parameters. The list of exported clocks can be found in
> +  'dt-bindings/clock/bt1-ccu.h'.
> +
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt

Don't think we need to mention this binding anymore. But it's good that
we know what exported clock ids are.

> +
> +allOf:
> +  - $ref: /schemas/clock/clock.yaml#
> +
> +properties:
> +  compatible:
> +    const: be,bt1-ccu-pll
> +
> +  reg:
> +    description: CCU PLLs sub-block base address.
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    description: |
> +      Clocks are referenced by the node phandle and an unique identifier
> +      from 'dt-bindings/clock/bt1-ccu.h'.

Don't think we need this description.

> +    const: 1
> +
> +  clocks:
> +    description: Phandle of CCU External reference clock.
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ref_clk

Can we drop _clk? It's redundant.

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
> +    ccu_pll: ccu_pll@1F04D000 {

Drop the phandle unless it's actually used.

> +      compatible =3D "be,bt1-ccu-pll";
> +      reg =3D <0x1F04D000 0x028>;

Lowercase hex please. That size is oddly small.

> +      #clock-cells =3D <1>;
> +
> +      clocks =3D <&osc25>;
> +      clock-names =3D "ref_clk";
> +
> +      clock-output-names =3D "cpu_pll", "sata_pll", "ddr_pll",
> +                           "pcie_pll", "eth_pll";
> +    };
> +...
> diff --git a/include/dt-bindings/clock/bt1-ccu.h b/include/dt-bindings/cl=
ock/bt1-ccu.h
> new file mode 100644
> index 000000000000..86e63162ade0
> --- /dev/null
> +++ b/include/dt-bindings/clock/bt1-ccu.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> + *
> + * Baikal-T1 CCU clock indeces.
> + */
> +#ifndef __DT_BINDINGS_CLOCK_BT1_CCU_H
> +#define __DT_BINDINGS_CLOCK_BT1_CCU_H
> +
> +/* Baikal-T1 CCU PLL indeces. */

Please drop this comment. It's not useful.

> +#define CCU_CPU_PLL                    0
> +#define CCU_SATA_PLL                   1
> +#define CCU_DDR_PLL                    2
> +#define CCU_PCIE_PLL                   3
> +#define CCU_ETH_PLL                    4
> +
> +#endif /* __DT_BINDINGS_CLOCK_BT1_CCU_H */
> --=20
> 2.25.1
>
