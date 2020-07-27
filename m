Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B69206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Bc+X9WBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgG0ImW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:42:22 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48503 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0ImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595839340; x=1627375340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WYr258yzTXpeZq4ZS7iWdQCOwZdWx5s0U0DJNipkAO0=;
  b=Bc+X9WBpeHmo+CrCXdXuZym1azvlpIUAbqr7ggO5wZdo0J8EXcZIZiwH
   dsiUaIamy6a2CF0VgM0RfctgXtxnRnkdhJIxX89YaQRkdCTmAfU+yjROF
   Hk2GEs9cjpf9H4bpk2BMrYn0r7M1mWTmPUcS+KXAAEnkDhcEaFbQLrhec
   DNkxuscPDPnvBjMw5zjHaxf73sRfj6iFNA36f8bZmd4oPXirfoZ2datjs
   yxSs34/nT/4zd/telN8V8MBIViDJd4j2/RQg9fthKADs+5eQ9KYQgkx5E
   jJBgDw1AwuROnvJzg16Ti/SU84cNYAxJfdsfmq//QgkCX1bPEhm1cA4UU
   g==;
IronPort-SDR: 7h+9mPFX5+fDfqKRYGq7zEXieHZTt7NsmJTke6/7L715Muuz3SfkdXhHVnM66DkEqccEEj+ukp
 NDKib/nWZE7FFABEM/h32SH09RBkARXxwLVFhHz9VUek5B99VQUJTwzEDPTUcgC63PwQ0/gilH
 nGJWJ62R47lNOW5hWQo/WXLZJeRSYWfXcAqTr0xtpeNO7JlNJMbxnQ2oJFjaw0Gx3x3yxBTjD7
 wYr9FHE612T+jn6UOrH4frPAqAaJ69C/HugGSAfq3cwXjvIA1IVNduSMzLp54NYdOmVvlqB4zc
 sIQ=
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="85470205"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2020 01:42:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 01:42:18 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 27 Jul 2020 01:42:14 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
To:     SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Olof Johansson <olof@lixom.net>,
        "Michael Turquette" <mturquette@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 00/10] Adding support for Microchip Sparx5 SoC
Date:   Mon, 27 Jul 2020 10:42:01 +0200
Message-ID: <20200727084211.6632-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Microchip Sparx5 SoC, the CPU
system of a advanced, TSN capable gigabit switch. The CPU is an armv8
x 2 CPU core (A53).

Although this is an ARM core, it shares some peripherals with the
Microsemi Ocelot MIPS SoC.

NB: This version *only* updates the drivers/clk/clk-sparx5.c driver

Changes in v4:
- Updates to the clock driver per Stephen Boyd <sboyd@kernel.org>
 - Remove unused include of of_address.h
 - Remove unused member in s5_hw_clk struct
 - Changed type (to unsigned long) for freq in s5_pll_conf struct
 - Use .parent_data instead of looking up parent name
 - Use devm_of_clk_add_hw_provider
 - Some minor comsmetics

Changes in v3:
- a "gpio-restart" node has been added to the pcb134/pcb135 DT files.
- pinctrl-ocelot.c: ENOTSUPP replaced by EOPNOTSUPP. Fixed non-static
  ocelot_pinconf_set(), Fixed ocelot_hw_get_value() not returning proper
  read value.
- Rebased on v5.8-rc1

Changes in v2:
- Misc fixes to bindings/arm/microchip,sparx5.yaml
- Changed clock driver to platform driver, using bitfields, recalc
  properly implented, using proper clock parent.
- arch/arm64/boot/dts/microchip/sparx5.dtsi:
 - Added pmu and psci node, using PSCI
 - Updates to GICv3 register spaces (GICV/GICH)
 - Updated timer interrupt specifiers
- pinctrl: ocelot: Fixed symbol clashes from powerpc

Lars Povlsen (10):
  dt-bindings: arm: sparx5: Add documentation for Microchip Sparx5 SoC
  arm64: sparx5: Add support for Microchip 2xA53 SoC
  arm64: dts: sparx5: Add basic cpu support
  arm64: dts: sparx5: Add pinctrl support
  pinctrl: ocelot: Add Sparx5 SoC support
  dt-bindings: clock: sparx5: Add Sparx5 SoC DPLL clock
  dt-bindings: clock: sparx5: Add bindings include file
  clk: sparx5: Add Sparx5 SoC DPLL clock driver
  arm64: dts: sparx5: Add Sparx5 SoC DPLL clock
  arm64: dts: sparx5: Add i2c devices, i2c muxes

 .../bindings/arm/microchip,sparx5.yaml        |  65 +++
 .../bindings/clock/microchip,sparx5-dpll.yaml |  52 +++
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 MAINTAINERS                                   |   9 +
 arch/arm64/Kconfig.platforms                  |  14 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/microchip/Makefile        |   4 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi     | 213 +++++++++
 .../boot/dts/microchip/sparx5_pcb125.dts      |  21 +
 .../boot/dts/microchip/sparx5_pcb134.dts      |  17 +
 .../dts/microchip/sparx5_pcb134_board.dtsi    | 252 ++++++++++
 .../boot/dts/microchip/sparx5_pcb134_emmc.dts |  17 +
 .../boot/dts/microchip/sparx5_pcb135.dts      |  17 +
 .../dts/microchip/sparx5_pcb135_board.dtsi    |  92 ++++
 .../boot/dts/microchip/sparx5_pcb135_emmc.dts |  17 +
 .../boot/dts/microchip/sparx5_pcb_common.dtsi |  19 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-sparx5.c                      | 295 ++++++++++++
 drivers/pinctrl/pinctrl-ocelot.c              | 430 +++++++++++++++++-
 include/dt-bindings/clock/microchip,sparx5.h  |  23 +
 20 files changed, 1559 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/microchip,sparx5.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,sparx5-dpll.yaml
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
 create mode 100644 drivers/clk/clk-sparx5.c
 create mode 100644 include/dt-bindings/clock/microchip,sparx5.h

--
2.27.0
