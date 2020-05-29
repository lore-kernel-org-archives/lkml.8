Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E66C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FD2207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590755563;
	bh=2XGAtRq37t05cU7U+HAj7jAY3VtVOcnv9gha4tS8m0c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=A332shTCFMFqDdEqh3o84DA01tbUQJp58Y7EuBplmiH7KNRcCUjJUVaRDt9d/Uncs
	 JMpoHcHlFylaM0z8rBthqcG9y4epdjYrhx4MkNkRiiMU0yusCqzhAHOTDdQz6NYZNr
	 HrCXBrSr1gpeVo8SYwCdJOu9qFmHMyK1ZWve4Oco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgE2Mcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2Mcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:32:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF732077D;
        Fri, 29 May 2020 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590755561;
        bh=2XGAtRq37t05cU7U+HAj7jAY3VtVOcnv9gha4tS8m0c=;
        h=From:To:Cc:Subject:Date:From;
        b=mnWeo3/Lbxa+C4PNDevwSPK10A5PXbagWuIH8x1tEOiWlULFFbKg5mExVk0oMREAu
         v6NmCg5HjCbQuZOABTHIQg+Jx8eBxjus/M7GNgwsq0+ciyrscA062JQVTRQa6LOAMF
         8hiUQ+MomYi7AuuacR5iqcRae3u8NqJPoz3o6mC0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jeeBj-00GGWx-Dw; Fri, 29 May 2020 13:32:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Rohloff <ingo.rohloff@lauterbach.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Rob Herring <robh@kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for Linux 5.8
Date:   Fri, 29 May 2020 13:32:29 +0100
Message-Id: <20200529123229.892699-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, andriy.shevchenko@linux.intel.com, anup.patel@wdc.com, atish.patra@wdc.com, bgolaszewski@baylibre.com, dan.carpenter@oracle.com, ingo.rohloff@lauterbach.com, jiaxun.yang@flygoat.com, john.garry@huawei.com, Jonathan.Cameron@huawei.com, linus.walleij@linaro.org, palmerdabbelt@google.com, robh@kernel.org, zhangshaokun@hisilicon.com, valentin.schneider@arm.com, wesley@sifive.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here is this merge window's crop of irqchip/irqdomain updates, a
pretty quiet one (which nobody will complain about).

On the menu this time, a handful of MIPS drivers, some welcome
cleanups for irqdomain and irq_sim, the long overdue fixes for GICv3
ITS LPI balancing and managed MSIs, a set of fixes for the rather
experimental multi-PLIC setup, and various cleanups.

Note that the irq_sim updates change files in the IIO and GPIO
subsystem, for which the respective maintainers have given their Ack.

Please pull,

	M.

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.8

for you to fetch changes up to da10a4b626657387845f32d37141fc7d48ebbdb3:

  dt-bindings: interrupt-controller: Add Loongson PCH MSI (2020-05-29 09:42:19 +0100)

----------------------------------------------------------------
irqchip updates for Linux 5.8:

- A few new drivers for the Loongson MIPS platform (HTVEC, PIC, MSI)
- A cleanup of the __irq_domain_add() API
- A cleanup of the IRQ simulator to actually use some of
  the irq infrastructure
- Some fixes for the Sifive PLIC when used in a multi-controller
  context
- Fixes for the GICv3 ITS to spread interrupts according to the
  load of each CPU, and to honor managed interrupts
- Numerous cleanups and documentation fixes

----------------------------------------------------------------
Andy Shevchenko (3):
      irqdomain: Make __irq_domain_add() less OF-dependent
      irqdomain: Get rid of special treatment for ACPI in __irq_domain_add()
      irqdomain: Allow software nodes for IRQ domain creation

Anup Patel (3):
      irqchip/sifive-plic: Set default irq affinity in plic_irqdomain_map()
      irqchip/sifive-plic: Setup cpuhp once after boot CPU handler is present
      irqchip/sifive-plic: Improve boot prints for multiple PLIC instances

Bartosz Golaszewski (2):
      irqdomain: Make irq_domain_reset_irq_data() available to  non-hierarchical users
      genirq/irq_sim: Simplify the API

Dan Carpenter (1):
      iio: dummy_evgen: Fix use after free on error in iio_dummy_evgen_create()

Ingo Rohloff (1):
      irqchip/gic-v3: Fix missing "__init" for gic_smp_init()

Jiaxun Yang (6):
      irqchip: Add Loongson HyperTransport Vector support
      dt-bindings: interrupt-controller: Add Loongson HTVEC
      irqchip: Add Loongson PCH PIC controller
      dt-bindings: interrupt-controller: Add Loongson PCH PIC
      irqchip: Add Loongson PCH MSI controller
      dt-bindings: interrupt-controller: Add Loongson PCH MSI

Marc Zyngier (2):
      irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
      irqchip/gic-v3-its: Balance initial LPI affinity across CPUs

Shaokun Zhang (1):
      platform-msi: Fix typos in comment

Valentin Schneider (1):
      irqchip/gic-v2, v3: Drop extra IRQ_NOAUTOEN setting for (E)PPIs

Wesley W. Terpstra (1):
      irqchip/sifive-plic: Remove incorrect requirement about number of irq contexts

 .../interrupt-controller/loongson,htvec.yaml       |  57 +++++
 .../interrupt-controller/loongson,pch-msi.yaml     |  62 +++++
 .../interrupt-controller/loongson,pch-pic.yaml     |  56 +++++
 drivers/base/platform-msi.c                        |   2 +-
 drivers/gpio/gpio-mockup.c                         |  53 +++-
 drivers/iio/dummy/iio_dummy_evgen.c                |  31 ++-
 drivers/irqchip/Kconfig                            |  27 +++
 drivers/irqchip/Makefile                           |   3 +
 drivers/irqchip/irq-gic-v3-its.c                   | 170 ++++++++++---
 drivers/irqchip/irq-gic-v3.c                       |   3 +-
 drivers/irqchip/irq-gic.c                          |   1 -
 drivers/irqchip/irq-loongson-htvec.c               | 214 +++++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c             | 255 ++++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-pic.c             | 243 +++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c                  |  23 +-
 include/linux/irq_sim.h                            |  33 +--
 include/linux/irqdomain.h                          |   2 +-
 kernel/irq/Kconfig                                 |   1 +
 kernel/irq/irq_sim.c                               | 267 +++++++++++++--------
 kernel/irq/irqdomain.c                             |  53 ++--
 20 files changed, 1336 insertions(+), 220 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
 create mode 100644 drivers/irqchip/irq-loongson-htvec.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-msi.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-pic.c
