Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA30C54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05552072D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCVXwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:52:25 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33026 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCVXwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 19:52:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1147980307C7;
        Sun, 22 Mar 2020 23:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0ObeK70IGF8W; Mon, 23 Mar 2020 02:52:15 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC RESEND] Baikal-T1 SoC System Controller DT nodes
Date:   Mon, 23 Mar 2020 02:51:24 +0300
Message-ID: <20200322235124.10200-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200317221246.27303-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I've resent this RFC email message since we really need your comments to move
on with i2c, clock, ehb and syscon patchsets review. If you agree with changes
to the Baikal-T1 syscon dts nodes design proposed by us in this text, we'll
also need to update some other patchsets I've already sent. So the issue raised
in this message is kinds of blocking. I'll copy the message to the vger kernel
mailing list to extend the topic audience.

I've been addressed with a several questions from Rob, Arnd, Andy and Stephen
in replies to he i2c, clock, ehb (errors handler block) and syscon patchsets sent
by me in the framework of the Baikal-T1 SoC support integration into the kernel
[1 - 4]. Seeing the questions have similar nature it would be better to settle the
issues all at once, provide fixes for all of them and proceed with the
rest of review.

In general the questions are related with syscon, clocks, i2c0 and ehb DT nodes
residence. Some of them concern the memory mapped registers alignment
(clock/i2c0), some of them are of whether the corresponding device drivers
belong to the corresponding subsystem (ehb) or whether some device nodes should
be sub-nodes of the syscon or of anything else like root node. Anyway as I see
it the answers to all the questions are hidden in a way the Baikal-T1 System
Controller is structured. That's why I'll start from describing it first.
Then I'll provide the System Controller DT nodes structure currently implemented
for Baikal-T1 SoC and explain why we chose to develop it in favor of any other.
Finally I'll offer you an alternative structure, which we also had in mind,
but didn't implement it for reasons also given in the text below.

In accordance with Baikal-T1 SoC documentations there is a System Control
Module (we also call it System Controller), which contains two big subsystems:
Clocks Control Unit (CCU) and Boot Controller. But the System Controller
functionality isn't limited with just clocks control and boot procedure
execution. There are settings, which aren't directly connected with those
sub-blocks, but is still exposed through the System Controller registers space
just because, well, because either the system designers wanted them to be
exposed from there or they didn't find any better way to map them. We don't
know for sure. We just know the mapping as it is and can't do anything to
change it. So here is the System Controller structure implemented in the
Baikal-T1 SoC:

System Control Module
|
+--> Clock Control Unit + System-specific settings: 0x1F04D000 @ 4KB
|    |
|    +-> PLLs                   0x1F04D000 - 0x1F04D027
|    |
|    +-> System Devices Clocks: 0x1F04D028 - 0x1F04D02F (clock dividers)
|    |   (DDR clock gate + L2 WS/Data/Tag stall cycles configs)
|    +-> AXI-bus Clocks:        0x1F04D030 - 0x1F04D05F (clock dividers)
|    |
|    +-> System Devices Clocks: 0x1F04D060 - 0x1F04D09F (clock dividers)
|    |
|    +-> I2C0 Indirect Access:  0x1F04D100 - 0x1F04D10F (+ IRQ)
|    |   (Just three Command/Read/Write registers to access the DW APB I2C controller registers space)
|    +-> AXI-bus EHB Error Addr:0x1F04D110 - 0x1F04D117 (+ IRQ)
|    |
|    +-> CPU Debug register:    0x1F04D118 - 0x1F04D11B
|    |   (provide the CPU reset flag for 'syscon-reboot' driver)
|    +-> PCIe control block:    0x1F04D140 - 0x1F04D14F
|    |   (PCIe internal Clocks, Reset, PMU, LTSSM and custom settings)
|    +-> System Devices Clocks: 0x1F04D150 - 0x1F04D153 (clock divider)
|    |   (Just watchdog clock divider)
|    +-> Reset safe register:   0x1F04D154 - 0x1F04D157
|        (register preserved during a soft/watchdog resets for
|         'syscon-reboot-mode' driver)
|
+--> Boot Controller: 0x1F040000 @ 4KB, 0x1BFC0000 @ 4KB, 0x1C000000 @ 16MB,
|    |                0x1FC00000 @ 4MB
|    |
|    +-> Boot Controller settings:               0x1F040000 - 0x1F0400FF
|    |
|    +-> Synopsis DesignWare APB SSI controller: 0x1F040100 - 0x1F040FFF
|    |   (with very limited resources though: nor IRQ, no DMA, just 8 bytes FIFO)
|    +-> Physically mapped Internal ROM:         0x1BFC0000 - 0x1BFCFFFF
|    |
|    +-> Physically mapped SPI-flash ROM:        0x1C000000 - 0x1CFFFFFF
|    |   (This region access is multiplexed with DW APB SSI controller registers)
|    +-> Physically mapped Boot ROM:             0x1FC00000 - 0x1FFFFFFF
|        (mirror of either Internal or SPI-flash ROMs depending on the boot
|         mode)

There is also APB EHB (APB bus Errors Handler Block), but according to the
Baikal-T1 documentation, it isn't part of the System Control Module (though as
for me it was a tech-writers mistake to represent it as a separate block).

+--> APB bus errors handler: 0x1F059000 @ 4KB, 0x1D000000 @ 32.25MB
     |
     +-> APB bus EHB registers: 0x1F059000 - 0x1F059FFF (+ IRQ)
     |   (Error address, type and timeout settings)
     +-> Unmapped space for errors injection: 0x1D000000 - 0x1F03FFFF


It's a mystery to me why the SoC designers couldn't create a separate registers
space for CCU (PLLs and Clock dividers) and for the system-specific settings,
while they managed to develop a separate Boot Controller and CCU registers
space. But we have to deal with what we currently have, since it can't be
changed.

We noticed that even though the CCU and system-specific settings are intermixed
in a single registers space, they belong to different registers, so we can just
redistribute the registers between the dedicated devices (DT nodes). In this
case we won't need to use the syscon interface to access the shared syscon
registers map. Instead the registers can read/write directly through IOMEM
accessors without  redundant spin-lock sync-primitive intended by the regmap
API. So I've decided to just redistribute the registers resources between the
corresponding DT nodes not necessarily being sub-nodes of the System Controller
node (I suppose most of your questions were raised due to this decision). This
made the nodes being unrelated to each other, but the nodes MMIO resources turned
to be size-unaligned. Here is a DT nodes structure we've currently implemented in
the framework of Baikal-T1 SoC support in the kernel.

/* System Controller DT Nodes I */
root {
    reboot {
        compatible = "syscon-reboot";
        regmap = <&cpu_ctl>;
    };

    reboot-mode {
        compatible = "syscon-reboot-mode";
        regmap = <&wdt_rcr>;
    };

    apb {
        compatible = "simple-bus";

        ccu_pll {
            compatible = "be,bt1-ccu-pll"; /* PLLs */
        };
        ccu_axi {
            compatible = "be,bt1-ccu-axi"; /* AXI-bus Clock */
            clocks = <&ccu_pll X>, <&ccu_pll Y>, ...;
        };
        ccu_sys {
            compatible = "be,bt1-ccu-sys"; /* System Devices Clock */
            clocks = <&ccu_pll X>, <&ccu_pll Y>, ...;
        };

        syscon {
            compatible = "simple-mfd";

            l2_ctl {
                compatible = "be,bt1-l2-ctl", "syscon";
            };

            ddr_ctl {
                compatible = "be,bt1-ddr-ctl", "syscon";
            };

            axi_ehb {
                compatible = "be,bt1-axi-ehb";
            };

            cpu_ctl {
                compatible = "be,bt1-cpu-ctl", "syscon";
            };

            pcie_ctl {
                compatible = "be,bt1-pcie-ctl", "syscon";
            };

            wdt_rcr {
                compatible = "be,bt1-wdt-rcr", "syscon";
            };
        };

        i2c0 {
            compatible = "be,bt1-i2c"; /* DW APB i2c with indirect registers access */
        };

        boot {
            compatible = "be,bt1-boot-ctl";

            int_rom {
                compatible = "be,bt1-int-rom", "mtd-rom";
            };

            spi_rom {
                compatible = "be,bt1-ssi-rom", "mtd-rom";
            };

            spi0 {
                compatible = "be,bt1-boot-ssi";
            };

            boot_rom {
                compatible = "be,bt1-boot-rom", "mtd-rom";
            };
        };

        apb_ehb {
            compatible = "be,bt1-apb-ehb";
        };
    };
};

The corresponding dts-file hasn't been submitted so far. So if you don't like
the structure we've chosen to define the System Controller parts, please justify
why it isn't right and if it's possible point me out at some place of the kernel
documentation so to refer to in future developments. We don't refuse to change
the DT nodes structure, we'd just like to know what's wrong with it and how to
bypass the same problem in future.

On the other hand as an alternative, which you'd possibly like much more, if we
got used to the fact that syscon-interface converts the registers resource to
the spin-lock secured regmap object and in order to retain the system controller
structure, the next System Controller DT nodes tree could be implemented:

/* System Controller DT Nodes II */
root {
    axi {
        compatible = "be,bt1-axi", "simple-bus";
        syscon = <&syscon>;
        interrupts = <...>;
    };

    apb {
        compatible = "be,bt1-apb", "simple-bus";
        reg = <X>, <Y>;
        interrupts = <...>;

        syscon {
            compatible = "be,bt1-sys-con", "syscon", "simple-mfd";

            ccu_pll {
                compatible = "be,bt1-ccu-pll";
            };

            ccu_axi {
                compatible = "be,bt1-ccu-axi";
            };

            ccu_sys {
                compatible = "be,bt1-ccu-sys";
            };

            l2_ctl {
                compatible = "be,bt1-l2-ctl";
            };

            i2c0 {
                compatible = "be,bt1-sys-i2c";
            };

            reboot {
                compatible = "syscon-reboot";
            };

            reboot-mode {
                compatible = "syscon-reboot-mode";
            };

            boot {
                compatible = "be,bt1-boot-ctl";

                int_rom {
                    compatible = "be,bt1-int-rom", "mtd-rom";
                };

                spi_rom {
                    compatible = "be,bt1-ssi-rom", "mtd-rom";
                };

                spi0 {
                    compatible = "be,bt1-boot-ssi";
                };

                boot_rom {
                    compatible = "be,bt1-boot-rom", "mtd-rom";
                };
            };
        };
    };
};

I suppose you'd like it better than "DT Nodes I", since in accordance with
Arnd Bergmann suggestion [1] the APB/AXI EHB would be moved to the drivers/bus
subsystem. In the framework of the "be,bt1-sys-con" MFD driver I would have
to implement an extra regmap to provide the indirectly accessible i2c0
registers, which would satisfy the Andy Shevchenko comment [2] regarding our
DW APB i2c patchset. I wouldn't need to have the "syscon-reboot-mode"
patchset in order to be able to declare the reboot-mode node in any place of
the DTS tree, which Rob Herring already nacked [3]. Finally I wouldn't have
the unaligned registers space defined for Clock Control Unit nodes, but would
use the syscon-regmap to access them from the system clock drivers. This would
fix the issue raised by Stephen Boyd [4] in the framework of the Baikal-T1 CCU
drivers patchset.

So if you like the "DT Nodes II" structure better than the version I or have
any idea of how to improve it could you tell us in reply to this email while
it's still possible to change the System Controller nodes structure at this
point since we are at v1-v2 stages in each patchset and non of the drivers
have been fully accepted so far.

[1] soc: Add Baikal-T1 SoC APB/AXI EHB and L2-cache drivers
    https://lkml.org/lkml/2020/3/6/669
[2] i2c: designware: Add Baikal-T1 SoC DW I2C specifics support 
    https://lkml.org/lkml/2020/3/6/542
[3] dt-bindings: power: reset: Add regmap support to the SYSCON reboot-mode bindings
    https://lkml.org/lkml/2020/3/12/1010
[4] dt-bindings: clk: Add Baikal-T1 System Devices CCU bindings
    https://lkml.org/lkml/2020/3/9/1249

Regards,
-Sergey
