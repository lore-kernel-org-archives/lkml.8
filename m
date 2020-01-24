Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74602C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A522075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579887802;
	bh=eHeEdx5jYIbll54hbcQuNIrY4e29kvcMCG5gyr7lF5M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GOOqc3vg+5q+Zcl57pKRvsKGfXKrgoFjPz3NXRZf8rOWJoTTVKjooulE1nu0T83Ec
	 FW7veC8875kCxOH4JY+mBFu66L1BpkIfH5eVEV7lJcehXeRLM7xwG+qpRUOgHFthu+
	 s3J2Yaw1NDeC3C9kdSKTB394WC8uc1xOiqyM9U/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390767AbgAXRnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389575AbgAXRnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:43:19 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16762071A;
        Fri, 24 Jan 2020 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579887798;
        bh=eHeEdx5jYIbll54hbcQuNIrY4e29kvcMCG5gyr7lF5M=;
        h=From:To:Cc:Subject:Date:From;
        b=UuEj8UUAwe6jO9TxGz8ClbfJOs3YuLHCLCts2CpLl35FQ1e0+XzwpfZ71Dqmujfcj
         Fx7ZK5oolZ7mpyqV0azbhbp3MR/XpmB3WcaNp+fDJO1KzNCtivKE+AWH3glsz68C2s
         /EitGk9auozt+AoERW4IWcFLCDJfNDzRvjxkYpNw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1iv2zE-001FmX-3n; Fri, 24 Jan 2020 17:43:16 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Atish Patra <atish.patra@wdc.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Eddie James <eajames@linux.ibm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Hyunki Koo <hyunki00.koo@samsung.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Kevin Hao <haokexin@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Rob Herring <robh@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for Linux 5.6
Date:   Fri, 24 Jan 2020 17:42:48 +0000
Message-Id: <20200124174248.25708-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, andrew@aj.id.au, atish.patra@wdc.com, bgolaszewski@baylibre.com, eajames@linux.ibm.com, guohanjun@huawei.com, hyunki00.koo@samsung.com, qiangqing.zhang@nxp.com, john.garry@huawei.com, haokexin@gmail.com, krzk@kernel.org, linus.walleij@linaro.org, qianggui.song@amlogic.com, robh@kernel.org, shengjiu.wang@nxp.com, wesley@sifive.com, yash.shah@sifive.com, yuzenghui@huawei.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a bunch of updates from the irqchip dept. On the menu this
time around, three new drivers (SiFive, Aspeed and NXP), a fairly
large update on the GIC side (and it is only the first half, I'm
keeping the juicy bits for 5.7), additional support for the AmLogic
Meson A1 platform, and a bunch of semi-random fixes.

Please pull.

	M.

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.6

for you to fetch changes up to f4a81f5a853e0b7c38bfad3afd6d0365d654e777:

  irqchip/gic-v4.1: Allow direct invalidation of VLPIs (2020-01-22 14:22:21 +0000)

----------------------------------------------------------------
irqchip updates for Linux 5.6:

- Conversion of the SiFive PLIC to hierarchical domains
- New SiFive GPIO irqchip driver
- New Aspeed SCI irqchip driver
- New NXP INTMUX irqchip driver
- Additional support for the Meson A1 GPIO irqchip
- First part of the GICv4.1 support
- Assorted fixes

----------------------------------------------------------------
Eddie James (2):
      dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
      irqchip: Add Aspeed SCU interrupt controller

Hyunki Koo (1):
      irqchip: Define EXYNOS_IRQ_COMBINER

Joakim Zhang (2):
      dt-bindings: interrupt-controller: Add binding for NXP INTMUX interrupt multiplexer
      irqchip: Add NXP INTMUX interrupt multiplexer support

John Garry (1):
      irqchip/mbigen: Set driver .suppress_bind_attrs to avoid remove problems

Kevin Hao (1):
      irqdomain: Fix a memory leak in irq_domain_push_irq()

Marc Zyngier (14):
      irqchip/gic-v3-its: Fix get_vlpi_map() breakage with doorbells
      irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
      irqchip/gic-v3: Add GICv4.1 VPEID size discovery
      irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER) allocation
      irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP
      irqchip/gic-v4.1: Don't use the VPE proxy if RVPEID is set
      irqchip/gic-v4.1: Implement the v4.1 flavour of VMOVP
      irqchip/gic-v4.1: Plumb skeletal VPE irqchip
      irqchip/gic-v4.1: Add mask/unmask doorbell callbacks
      irqchip/gic-v4.1: Add VPE residency callback
      irqchip/gic-v4.1: Add VPE eviction callback
      irqchip/gic-v4.1: Add VPE INVALL callback
      irqchip/gic-v4.1: Suppress per-VLPI doorbell
      irqchip/gic-v4.1: Allow direct invalidation of VLPIs

Qianggui Song (3):
      dt-bindings: interrupt-controller: New binding for Meson-A1 SoCs
      irqchip/meson-gpio: Rework meson irqchip driver to support meson-A1 SoCs
      irqchip/meson-gpio: Add support for meson a1 SoCs

Yash Shah (5):
      genirq: Introduce irq_domain_translate_onecell
      irqchip/nvic: Use irq_domain_translate_onecell instead of custom func
      irqchip/sifive-plic: Support irq domain hierarchy
      gpio/sifive: Add DT documentation for SiFive GPIO
      gpio/sifive: Add GPIO driver for SiFive SoCs

 .../devicetree/bindings/gpio/sifive,gpio.yaml      |  68 ++
 .../amlogic,meson-gpio-intc.txt                    |   1 +
 .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt |  23 +
 .../bindings/interrupt-controller/fsl,intmux.yaml  |  68 ++
 MAINTAINERS                                        |   8 +
 arch/arm/include/asm/arch_gicv3.h                  |   2 +
 arch/arm/mach-exynos/Kconfig                       |   1 +
 arch/arm64/include/asm/arch_gicv3.h                |   1 +
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sifive.c                         | 252 ++++++++
 drivers/irqchip/Kconfig                            |  14 +
 drivers/irqchip/Makefile                           |   5 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                | 239 +++++++
 drivers/irqchip/irq-gic-v3-its.c                   | 698 +++++++++++++++++++--
 drivers/irqchip/irq-gic-v3.c                       |  24 +-
 drivers/irqchip/irq-imx-intmux.c                   | 309 +++++++++
 drivers/irqchip/irq-mbigen.c                       |   1 +
 drivers/irqchip/irq-meson-gpio.c                   | 137 +++-
 drivers/irqchip/irq-nvic.c                         |  15 +-
 drivers/irqchip/irq-sifive-plic.c                  |  30 +-
 .../interrupt-controller/aspeed-scu-ic.h           |  23 +
 include/linux/irqchip/arm-gic-v3.h                 |  59 +-
 include/linux/irqchip/arm-gic-v4.h                 |  23 +-
 include/linux/irqdomain.h                          |   5 +
 kernel/irq/irqdomain.c                             |  18 +
 26 files changed, 1930 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
 create mode 100644 drivers/gpio/gpio-sifive.c
 create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
 create mode 100644 drivers/irqchip/irq-imx-intmux.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
