Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE01BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A0F2076B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596450808;
	bh=LRK9PlCCJUkY85kcKEjE7dncwH1viAnaLVZaXzBQuvM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EQi3wUOe7hfCnFSgu6XyH2y76t5IT+eEw2X/zC3gZ9kyOdC5AA0Uc/roSA5jJdZK7
	 t38X3l7sBjhnGkFMC5LL1j8IY68uCH6Dy8WiFFRvuUr3xpQ49jF5iEKztdwabF0gYS
	 6UeTEnwTcNvuNOy7qAc/K4xkkX68ZNYdLLjQgJ7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgHCKd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgHCKd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:33:26 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 678D020719;
        Mon,  3 Aug 2020 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596450804;
        bh=LRK9PlCCJUkY85kcKEjE7dncwH1viAnaLVZaXzBQuvM=;
        h=From:To:Cc:Subject:Date:From;
        b=raRRFGHU/ieoo3j7kiXI4Tf2xZ1nUxwrxauVjI4KGHruaplPkIMsjSb8W/0REdlCN
         PiO8wPUEDcGaNI411auMKbrDwgciXcqynw00Kf8pV8GzZLs6JPke/G3t3JB1oz0UB/
         AGEc0CNnCWZmYqCExTIE6AkaR8VMIcTfTUNlNxsc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k2XmV-00H48f-HP; Mon, 03 Aug 2020 11:33:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hulk Robot <hulkci@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Joerg Roedel <joro@8bytes.org>,
        John Stultz <john.stultz@linaro.org>,
        Justin Chen <justinpopo6@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Oscar Carter <oscar.carter@gmx.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Todd Kjos <tkjos@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip updates for 5.9
Date:   Mon,  3 Aug 2020 11:33:12 +0100
Message-Id: <20200803103312.151801-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, alexandre.belloni@bootlin.com, alexandre.torgue@st.com, agross@kernel.org, bgolaszewski@baylibre.com, bjorn.andersson@linaro.org, claudiu.beznea@microchip.com, fabien.dessenne@st.com, f.fainelli@gmail.com, gregkh@linuxfoundation.org, grygorii.strashko@ti.com, gustavoars@kernel.org, hanks.chen@mediatek.com, chenhc@lemote.com, hulkci@huawei.com, jason@lakedaemon.net, lvjianmin@loongson.cn, jiaxun.yang@flygoat.com, qiangqing.zhang@nxp.com, joro@8bytes.org, john.stultz@linaro.org, justinpopo6@gmail.com, kdasu.kdev@gmail.com, lkp@intel.com, ilina@codeaurora.org, linus.walleij@linaro.org, masahiroy@kernel.org, mkshah@codeaurora.org, oscar.carter@gmx.com, rafael.j.wysocki@intel.com, rdunlap@infradead.org, saravanak@google.com, yangtiezhu@loongson.cn, tkjos@google.com, weiyongjun1@huawei.com, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the irqchip updates for 5.9. Although it is rather large this
time around, it is mostly a collection of random cleanups and minor
improvements. The most notable additions is a set of helpers for
platform irqchip drivers to be built as modules.

I may have a second pull request later if the TI folks can sort their
dependency nightmare, but don't hold your breath.

Please pull,

	M.

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.9

for you to fetch changes up to ac62460c24126eb2442e3653a266ebbf05b004d8:

  irqchip/loongson-pch-pic: Fix the misused irq flow handler (2020-07-30 12:58:17 +0100)

----------------------------------------------------------------
irqchip updates for Linux 5.9

- Add infrastructure to allow DT irqchip platform drivers to
  be built as modules
- Allow qcom-pdc, mtk-cirq and mtk-sysirq to be built as module
- Fix ACPI probing to avoid abusing function pointer casting
- Allow bcm7120-l2 and brcmstb-l2 to be used as wake-up sources
- Teach NXP's IMX INTMUX some power management
- Allow stm32-exti to be used as a hierarchical irqchip
- Let stm32-exti use the hw spinlock API in its full glory
- A couple of GICv4.1 fixes
- Tons of cleanups (mtk-sysirq, aic5, bcm7038-l1, imx-intmux,
  brcmstb-l2, ativic32, ti-sci-inta, lonsoon, MIPS GIC, GICv3)

----------------------------------------------------------------
Alexandre Torgue (1):
      irqchip/stm32-exti: Map direct event to irq parent

Bartosz Golaszewski (1):
      irqchip/irq-mtk-sysirq: Replace spinlock with raw_spinlock

Claudiu Beznea (1):
      irqchip/atmel-aic5: Add support for sam9x60 rtt fixup

Fabien Dessenne (1):
      irqchip/stm32-exti: Use the hwspin_lock_timeout_in_atomic() API

Florian Fainelli (5):
      dt-bindings: interrupt-controller: Document Broadcom STB HIF L2
      dt-bindings: interrupt-controller: Document UPG auxiliary L2
      irqchip/brcmstb-l2: Match UPG_AUX_AON_INTR2 compatible
      irqchip/irq-bcm7038-l1: Allow building on ARM 32-bit
      irqchip/irq-bcm7038-l1: Guard uses of cpu_logical_map

Gustavo A. R. Silva (1):
      irqchip/imx-intmux: Use struct_size() helper in devm_kzalloc()

Huacai Chen (4):
      dt-bindings: interrupt-controller: Update Loongson HTVEC description
      irqchip/loongson-liointc: Fix misuse of gc->mask_cache
      irqchip/loongson-htvec: Support 8 groups of HT vectors
      irqchip/loongson-pch-pic: Fix the misused irq flow handler

Joakim Zhang (1):
      irqchip/imx-intmux: Implement intmux runtime power management

John Stultz (3):
      irqdomain: Export irq_domain_update_bus_token
      genirq: Export irq_chip_retrigger_hierarchy and irq_chip_set_vcpu_affinity_parent
      irqchip/qcom-pdc: Allow QCOM_PDC to be loadable as a permanent module

Justin Chen (2):
      irqchip/bcm7120-l2: Set controller as wake-up source
      irqchip/brcmstb-l2: Set controller as wake-up source

Kamal Dasu (1):
      irqchip/brcmstb-l2: Match HIF_SPI_INTR2 compatible

Linus Walleij (2):
      irqchip/vic: Drop cascaded intialization call
      irqchip/vic: Cut down the external API

Marc Zyngier (1):
      irqchip: Fix IRQCHIP_PLATFORM_DRIVER_* compilation by including module.h

Masahiro Yamada (1):
      irqchip/ativic32: Constify irq_domain_ops

Oscar Carter (3):
      drivers/acpi: Add new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
      drivers/irqchip: Use new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
      drivers/acpi: Remove function cast

Randy Dunlap (1):
      irqchip: irq-bcm2836.h: drop a duplicated word

Saravana Kannan (4):
      irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros
      irqchip/qcom-pdc: Switch to using IRQCHIP_PLATFORM_DRIVER helper macros
      irqchip/mtk-sysirq: Convert to a platform driver
      irqchip/mtk-cirq: Convert to a platform driver

Tiezhu Yang (10):
      irqchip/ti-sci-inta: Remove dead code in ti_sci_inta_set_type()
      irqchip/ti-sci-inta: Fix return value about devm_ioremap_resource()
      irqchip/ti-sci-inta: Fix typo about MODULE_AUTHOR
      irqchip/loongson-htpic: Remove redundant kfree operation
      irqchip/loongson-htpic: Remove unneeded select of I8259
      irqchip/loongson-htvec: Fix potential resource leak
      irqchip/loongson-htvec: Check return value of irq_domain_translate_onecell()
      irqchip/loongson-pch-pic: Check return value of irq_domain_translate_twocell()
      irqchip/loongson-pch-msi: Remove unneeded variable
      irqchip/loongson-liointc: Fix potential dead lock

Wei Yongjun (2):
      irqchip/mips-gic: Make local symbols static
      irqchip/imx-intmux: Fix irqdata regs save in imx_intmux_runtime_suspend()

Zenghui Yu (4):
      genirq/irqdomain: Remove redundant NULL pointer check on fwnode
      irqchip/gic-v3: Remove unused register definition
      irqchip/gic-v4.1: Ensure accessing the correct RD when writing INVALLR
      irqchip/gic-v4.1: Use GFP_ATOMIC flag in allocate_vpe_l1_table()

 .../bindings/interrupt-controller/brcm,l2-intc.txt |   5 +-
 .../interrupt-controller/loongson,htvec.yaml       |   4 +-
 drivers/irqchip/Kconfig                            |   3 +-
 drivers/irqchip/irq-ativic32.c                     |   2 +-
 drivers/irqchip/irq-atmel-aic5.c                   |   8 +-
 drivers/irqchip/irq-bcm7038-l1.c                   |  11 ++
 drivers/irqchip/irq-bcm7120-l2.c                   |   8 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |   5 +
 drivers/irqchip/irq-gic-v3-its.c                   |  14 +-
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 drivers/irqchip/irq-gic.c                          |   2 +-
 drivers/irqchip/irq-imx-intmux.c                   |  70 ++++++++-
 drivers/irqchip/irq-loongson-htpic.c               |   6 +-
 drivers/irqchip/irq-loongson-htvec.c               |  32 ++--
 drivers/irqchip/irq-loongson-liointc.c             |  11 +-
 drivers/irqchip/irq-loongson-pch-msi.c             |   7 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |  30 ++--
 drivers/irqchip/irq-mips-gic.c                     |  10 +-
 drivers/irqchip/irq-mtk-cirq.c                     |   4 +-
 drivers/irqchip/irq-mtk-sysirq.c                   |  12 +-
 drivers/irqchip/irq-stm32-exti.c                   | 166 +++++++++++----------
 drivers/irqchip/irq-ti-sci-inta.c                  |   6 +-
 drivers/irqchip/irq-vic.c                          |  26 +---
 drivers/irqchip/irqchip.c                          |  29 ++++
 drivers/irqchip/qcom-pdc.c                         |   8 +-
 include/linux/acpi.h                               |  23 ++-
 include/linux/irqchip.h                            |  29 +++-
 include/linux/irqchip/arm-gic-v3.h                 |   4 -
 include/linux/irqchip/arm-vic.h                    |  11 --
 include/linux/irqchip/irq-bcm2836.h                |   2 +-
 kernel/irq/chip.c                                  |   3 +-
 kernel/irq/irqdomain.c                             |   3 +-
 32 files changed, 346 insertions(+), 210 deletions(-)
