Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3813C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB84A24654
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgCJAWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:22:21 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44378 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgCJAWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:22:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id DF8F280307C8;
        Tue, 10 Mar 2020 00:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Aq4rEG-i_zou; Tue, 10 Mar 2020 03:22:17 +0300 (MSK)
Date:   Tue, 10 Mar 2020 03:21:26 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] clk: Add Baikal-T1 SoC Clock Control Unit support
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200310002218.DF8F280307C8@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:00:43PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> Clocks Control Unit is the core of Baikal-T1 SoC responsible for the chip
> subsystems clocking and resetting. The CCU is connected with an external
> fixed rate oscillator, which signal is transformed into clocks of various
> frequencies and then propagated to either individual IP-blocks or to groups
> of blocks (clock domains). The transformation is done by means of PLLs and
> gateable/non-gateable, fixed/variable dividers embedded into the CCU. There
> are five PLLs to create a clock for the MIPS P5600 cores, the embedded DDR
> controller, SATA, Ethernet and PCIe domains. The last three PLLs CLKOUT are
> then passed over CCU dividers to create signals required for the target clock
> domains: individual AXI and APB bus clocks, SoC devices reference clocks.
> The CCU divider registers may also provide a way to reset the target devices
> state.
> 
> So this patchset introduces the Baikal-T1 clock and reset drivers of CCU
> PLLs, AXI-bus clock dividers and system devices clock dividers.
> 
> This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> commit 98d54f81e36b ("Linux 5.6-rc4").
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (5):
>   dt-bindings: clk: Add Baikal-T1 CCU PLLs bindings
>   dt-bindings: clk: Add Baikal-T1 AXI-bus CCU bindings
>   dt-bindings: clk: Add Baikal-T1 System Devices CCU bindings
>   clk: Add Baikal-T1 CCU PLLs driver
>   clk: Add Baikal-T1 CCU dividers driver
> 
>  .../bindings/clock/be,bt1-ccu-axi.yaml        | 151 +++++
>  .../bindings/clock/be,bt1-ccu-pll.yaml        | 139 +++++
>  .../bindings/clock/be,bt1-ccu-sys.yaml        | 169 ++++++
>  drivers/clk/Kconfig                           |   1 +
>  drivers/clk/Makefile                          |   1 +
>  drivers/clk/baikal-t1/Kconfig                 |  46 ++
>  drivers/clk/baikal-t1/Makefile                |   3 +
>  drivers/clk/baikal-t1/ccu-div.c               | 531 ++++++++++++++++++
>  drivers/clk/baikal-t1/ccu-div.h               | 114 ++++
>  drivers/clk/baikal-t1/ccu-pll.c               | 474 ++++++++++++++++
>  drivers/clk/baikal-t1/ccu-pll.h               |  73 +++
>  drivers/clk/baikal-t1/clk-ccu-div.c           | 522 +++++++++++++++++
>  drivers/clk/baikal-t1/clk-ccu-pll.c           | 217 +++++++
>  drivers/clk/baikal-t1/common.h                |  51 ++
>  include/dt-bindings/clock/bt1-ccu.h           |  54 ++
>  include/dt-bindings/reset/bt1-ccu.h           |  27 +
>  16 files changed, 2573 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-axi.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-pll.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml
>  create mode 100644 drivers/clk/baikal-t1/Kconfig
>  create mode 100644 drivers/clk/baikal-t1/Makefile
>  create mode 100644 drivers/clk/baikal-t1/ccu-div.c
>  create mode 100644 drivers/clk/baikal-t1/ccu-div.h
>  create mode 100644 drivers/clk/baikal-t1/ccu-pll.c
>  create mode 100644 drivers/clk/baikal-t1/ccu-pll.h
>  create mode 100644 drivers/clk/baikal-t1/clk-ccu-div.c
>  create mode 100644 drivers/clk/baikal-t1/clk-ccu-pll.c
>  create mode 100644 drivers/clk/baikal-t1/common.h
>  create mode 100644 include/dt-bindings/clock/bt1-ccu.h
>  create mode 100644 include/dt-bindings/reset/bt1-ccu.h
> 
> -- 
> 2.25.1
> 

Folks,

It appears our corporate email server changes the Message-Id field of 
messages passing through it. Due to that the emails threading gets to be
broken. I'll resubmit the properly structured patchset as soon as our system
administrator fixes the problem. Sorry for the inconvenience caused by it.

Regards,
-Sergey
