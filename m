Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6CCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BF920792
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgHCVuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:50:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgHCVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:50:39 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MxUfn-1kvwZR1SMT-00xvcn for <linux-kernel@vger.kernel.org>; Mon, 03 Aug
 2020 23:50:36 +0200
Received: by mail-qv1-f42.google.com with SMTP id x7so1809850qvi.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:50:36 -0700 (PDT)
X-Gm-Message-State: AOAM5312+u+Ajm1g+CNebUDMFVIa0wQBcJE4wclWERxT4uvvludIMneb
        rcgY6vZgMFEojVCTK0xCBOq7W7MDiJ7SSJQD3lo=
X-Google-Smtp-Source: ABdhPJzHsoxIjaHacq62qezcpqMUuyqxJKIxMgpQ18UEM+jQbf2IsI5XuM1TLWBYhWRAdLCiCaTBTvVTFkVKjNeIJTY=
X-Received: by 2002:a0c:e604:: with SMTP id z4mr7218865qvm.222.1596491435202;
 Mon, 03 Aug 2020 14:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
In-Reply-To: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Aug 2020 23:50:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a09DTN6GO5FK0hygdCx-Fh5JM=jdOTubpM4jcLjgTsjCA@mail.gmail.com>
Message-ID: <CAK8P3a09DTN6GO5FK0hygdCx-Fh5JM=jdOTubpM4jcLjgTsjCA@mail.gmail.com>
Subject: [GIT PULL 5/5] ARM: new SoC support for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ldEPxMMBxEI5X5LfSiwCz8axowbn2yTBmyZe9CtyL63uem9kbuJ
 M5a0ceNGu7TwYD0/6yemAt4J9T4AFVhLT9oEWZ0PXCei6/V0Q625CIdWjMqQKcpHe0AsX13
 Ylnqx17etmaP2RxNauHJtyhaBlDm8UTV5e73SIs2etIBv0S3b7aOZtNxHtSEJQ0FWht0nJ2
 tF1X63l/tni+BygKw7UxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cx9QJdM1af0=:CDNT4lEoSYGu6CpXobGlFr
 zOgDvEsi8rq0LEEzjjnwL99I6VpsLK4er8xwd8vxepI4yLSrIe5sAs6ga+oILCv38JD1qNSOu
 Hgt3BTLq3vNlq5Mni674V4T+RYHIJZlUZgsuGUt4cyucaXEZ1lN0UadXrQTjVLreT1qC65bNs
 EwgWKdGY/QDzli+k3BWhw0MCNz1b1BPq42NbRpk+DlrjSj728krykb8QvNAZ2eNIbv1VDgFgt
 kkKWuj4FLGdiMyJrdd6rR7/k3iuZQI1GW5aSetvE8Cbm5nv+XBlZ7YP9NCWv3kt7LJGlJlOiH
 DQSEHW0rv9FZXsXu6OOAftE0hM1N9IGSpJkLN7i1IgctzFkvz156vbKC2+nplOKpt3fMZqBlM
 pdhIWwWwvpKpl13qa0N1xMfz82DRnIZb4uRo4a6O4ttEhxaxePXwj9Hv2mTeUh2XJuJga++YL
 u2Z8n8zrABGIa6Ww/ed5NFa715rcWR5bKJMBu0eXaIRW6nj5RvWYEbYOw/omOWCOnDObH5VeC
 L17lk2hpVk3N/SGmBEBV5jmtDSeZ34Ej3mBcJV9/zJ+sE0ATEE6fquwOzwLjF64vumBLsiiqU
 ypkhwlgxSlMSkq77qiieYn507890DJAQ6ojB6aDxjNJ2hxixZPJ+fGKaVin/XWKUevm/LiWmB
 kxW0yjyYisKFW76aZQQrvA3npB+AMprhnofsamsabKw85OzG08+Atx6Yd5JuwMQEYeMQi+iNg
 Ub+CuGcmpT+Z+hjxdSwQ5MBk5Eebk2nXx8vVHq/xJxGEx4jFb0g+wxJk7Vjphv14EyS6OKvdQ
 jmbDP7WXN66YwTwRGjTjdubk/DeqR8a3FxNHgI6NwlY80sBbTBD6CuvA+fuv3rvntnKkCwqCy
 hLUdR1xrshqnfEJhk99Sf7nTGNuwoV18gbaLQTLlU/N759un7qpRKjl+leKlU3U/SgDAloVNA
 nghsc50V3QijoeJUETJgZnRljm7OYVr16dR0ZyKDd9RoenRL3QWQK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-newsoc-5.9

for you to fetch changes up to 892900a70b6c6664fe9ce0d4e2a5b6b4c821c0e3:

  ARM: mstar: Correct the compatible string for pmsleep (2020-07-31
10:58:39 +0200)

----------------------------------------------------------------
ARM: new SoC support for v5.9

There are three SoC families newly dded to the 32-bit and
64-bit Arm architecture code in the kernel this time:

 - Daniel Palmer adds initial support for two chips made by MStar, a
   taiwanese SoC manufacturer that became part of Mediatek in 2012. For
   now, the added support is fairly minimal, with just two of its
   Cortex-A7 based 32-bit camera chips getting support for a limited
   set of on-chip peripherals.

 - Lars Povlsen from Microchip adds support for their new Sparx5
   family of ethernet switch chips using 64-bit Cortex-A53 cores.
   These are descended from earlier VSC7xxx SparX and Ocelot chips
   using 32-bit MIPS cores.

 - Daniele Alessandrelli from Intel adds support for the new Keem Bay
   SoC for computer vision, built around a Movidius VPU with Linux
   running on Arm Cortex-A53 cores.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Daniel Palmer (25):
      dt-bindings: vendor-prefixes: Add mstar vendor prefix
      dt-bindings: vendor-prefixes: Add sstar vendor prefix
      dt-bindings: vendor-prefixes: Add 70mai vendor prefix
      dt-bindings: vendor-prefixes: Add thingy.jp prefix
      dt-bindings: arm: Add mstar YAML schema
      ARM: mstar: Add machine for MStar/Sigmastar Armv7 SoCs
      ARM: mstar: Add binding details for mstar,l3bridge
      ARM: mstar: Add Armv7 base dtsi
      ARM: mstar: Add infinity/infinity3 family dtsis
      ARM: mstar: Add mercury5 series dtsis
      ARM: mstar: Add dts for msc313(e) based BreadBee boards
      ARM: mstar: Add dts for 70mai midrive d08
      ARM: mstar: Fix dts filename for 70mai midrive d08
      dt-bindings: arm: mstar: Add binding details for mstar, pmsleep
      dt-bindings: arm: mstar: Move existing MStar binding descriptions
      ARM: mstar: Add IMI SRAM region
      ARM: mstar: Adjust IMI size of infinity
      ARM: mstar: Adjust IMI size for mercury5
      ARM: mstar: Adjust IMI size for infinity3
      ARM: mstar: Add PMU
      ARM: mstar: Add "pmsleep" node to base dtsi
      ARM: mstar: Add reboot support
      dt-bindings: mfd: syscon: add compatible string for mstar,msc313-pmsleep
      dt-bindings: arm: mstar: remove the binding description for mstar,pmsleep
      ARM: mstar: Correct the compatible string for pmsleep

Daniele Alessandrelli (5):
      arm64: Add config for Keem Bay SoC
      dt-bindings: arm: Add Keem Bay bindings
      MAINTAINERS: Add maintainers for Keem Bay SoC
      arm64: dts: keembay: Add device tree for Keem Bay SoC
      arm64: dts: keembay: Add device tree for Keem Bay EVM board

Lars Povlsen (8):
      dt-bindings: arm: sparx5: Add documentation for Microchip Sparx5 SoC
      arm64: sparx5: Add support for Microchip 2xA53 SoC
      arm64: dts: sparx5: Add basic cpu support
      arm64: dts: sparx5: Add pinctrl support
      dt-bindings: clock: sparx5: Add Sparx5 SoC DPLL clock
      dt-bindings: clock: sparx5: Add bindings include file
      arm64: dts: sparx5: Add Sparx5 SoC DPLL clock
      arm64: dts: sparx5: Add i2c devices, i2c muxes

 .../devicetree/bindings/arm/intel,keembay.yaml     |  19 ++
 .../devicetree/bindings/arm/microchip,sparx5.yaml  |  65 ++++++
 .../bindings/arm/mstar/mstar,l3bridge.yaml         |  44 ++++
 .../devicetree/bindings/arm/mstar/mstar.yaml       |  33 +++
 .../bindings/clock/microchip,sparx5-dpll.yaml      |  52 +++++
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   8 +
 MAINTAINERS                                        |  28 +++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   4 +
 .../boot/dts/infinity-msc313-breadbee_crust.dts    |  25 ++
 arch/arm/boot/dts/infinity-msc313.dtsi             |  14 ++
 arch/arm/boot/dts/infinity.dtsi                    |  11 +
 arch/arm/boot/dts/infinity3-msc313e-breadbee.dts   |  25 ++
 arch/arm/boot/dts/infinity3-msc313e.dtsi           |  14 ++
 arch/arm/boot/dts/infinity3.dtsi                   |  11 +
 arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts |  25 ++
 arch/arm/boot/dts/mercury5-ssc8336n.dtsi           |  14 ++
 arch/arm/boot/dts/mercury5.dtsi                    |  11 +
 arch/arm/boot/dts/mstar-v7.dtsi                    | 107 +++++++++
 arch/arm/mach-mstar/Kconfig                        |  26 +++
 arch/arm/mach-mstar/Makefile                       |   1 +
 arch/arm/mach-mstar/mstarv7.c                      |  80 +++++++
 arch/arm64/Kconfig.platforms                       |  19 ++
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/intel/Makefile                 |   1 +
 arch/arm64/boot/dts/intel/keembay-evm.dts          |  37 +++
 arch/arm64/boot/dts/intel/keembay-soc.dtsi         | 123 ++++++++++
 arch/arm64/boot/dts/microchip/Makefile             |   4 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi          | 213 +++++++++++++++++
 arch/arm64/boot/dts/microchip/sparx5_pcb125.dts    |  21 ++
 arch/arm64/boot/dts/microchip/sparx5_pcb134.dts    |  17 ++
 .../boot/dts/microchip/sparx5_pcb134_board.dtsi    | 252 +++++++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb134_emmc.dts      |  17 ++
 arch/arm64/boot/dts/microchip/sparx5_pcb135.dts    |  17 ++
 .../boot/dts/microchip/sparx5_pcb135_board.dtsi    |  92 ++++++++
 .../boot/dts/microchip/sparx5_pcb135_emmc.dts      |  17 ++
 .../boot/dts/microchip/sparx5_pcb_common.dtsi      |  19 ++
 include/dt-bindings/clock/microchip,sparx5.h       |  23 ++
 40 files changed, 1495 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/intel,keembay.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/microchip,sparx5.yaml
 create mode 100644
Documentation/devicetree/bindings/arm/mstar/mstar,l3bridge.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mstar/mstar.yaml
 create mode 100644
Documentation/devicetree/bindings/clock/microchip,sparx5-dpll.yaml
 create mode 100644 arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts
 create mode 100644 arch/arm/boot/dts/infinity-msc313.dtsi
 create mode 100644 arch/arm/boot/dts/infinity.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3.dtsi
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n.dtsi
 create mode 100644 arch/arm/boot/dts/mercury5.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-v7.dtsi
 create mode 100644 arch/arm/mach-mstar/Kconfig
 create mode 100644 arch/arm/mach-mstar/Makefile
 create mode 100644 arch/arm/mach-mstar/mstarv7.c
 create mode 100644 arch/arm64/boot/dts/intel/keembay-evm.dts
 create mode 100644 arch/arm64/boot/dts/intel/keembay-soc.dtsi
 create mode 100644 arch/arm64/boot/dts/microchip/Makefile
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5.dtsi
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_pcb134.dts
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dts
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_pcb135.dts
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_pcb135_emmc.dts
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
 create mode 100644 include/dt-bindings/clock/microchip,sparx5.h
