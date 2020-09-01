Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B0FC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E70F21D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971427;
	bh=GHG8Q5LGBd/C87oXVQh9+PpSYGYMCoE7jrDiu2FaKCI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e78D8oRAv6s6LJhBGpx2WdAkc5lUbdkJFUWycttPGkejhfHlB+GwK7cj95KhRwmkp
	 8UFpDQLNthvdbt4eTURvkIEUJt62WjnJ0bV3EIdA80P5/vUyq9EmdYFxxyTgGIM4xw
	 /wnnkWhJzxfxeFAOBQ1nik+xGZ/TDtu/CJbMvJG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgIAOnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbgIAOna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:43:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D08F4206EB;
        Tue,  1 Sep 2020 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971410;
        bh=GHG8Q5LGBd/C87oXVQh9+PpSYGYMCoE7jrDiu2FaKCI=;
        h=From:To:Cc:Subject:Date:From;
        b=aKYNGwPX5beYzRHU1P28m+loKhvDs9jL8wUyf/QDaLeZK/iFj9NllUfoyVSQdB8ZT
         7ZEFTATUtFMGri7nhESL4aljhdXeu1AJYUY+HGpHswdBWeHYBJX31OcihTLhm/EVVC
         4M6ZPySIR0NH9bFwUZ5XCbaOs9zWU6vBZl9VNCUA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7VQ-008IQP-5n; Tue, 01 Sep 2020 15:43:28 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: [PATCH v3 00/16] arm/arm64: Turning IPIs into normal interrupts
Date:   Tue,  1 Sep 2020 15:43:08 +0100
Message-Id: <20200901144324.1071694-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For as long as SMP ARM has existed, IPIs have been handled as
something special. The arch code and the interrupt controller exchange
a couple of hooks (one to generate an IPI, another to handle it).

Although this is perfectly manageable, it prevents the use of features
that we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It
also means that each interrupt controller driver has to follow an
architecture-specific interface instead of just implementing the base
irqchip functionalities. The arch code also duplicates a number of
things that the core irq code already does (such as calling
set_irq_regs(), irq_enter()...).

This series tries to remedy this on arm/arm64 by offering a new
registration interface where the irqchip gives the arch code a range
of interrupts to use for IPIs. The arch code requests these as normal
per-cpu interrupts.

The bulk of the work is at the interrupt controller level, where all 5
irqchips used on arm+SMP/arm64 get converted.

Finally, we drop the legacy registration interface as well as the
custom statistics accounting.

Note that I have had a look at providing a "generic" interface by
expanding the kernel/irq/ipi.c bag of helpers, but so far all
irqchips have very different requirements, so there is hardly anything
to consolidate for now. Maybe some as hip04 and the Marvell horror get
cleaned up (the latter certainly could do with a good dusting).

This has been tested on a bunch of 32 and 64bit guests (GICv2, GICv3),
as well as 64bit bare metal (GICv3). The RPi part has only been tested
in QEMU as a 64bit guest, while the HiSi and Marvell parts have only
been compile-tested.

I'm aiming for 5.10 for this, so any comment would be appreciated.

* From v2:
  - Tidied up the arch code (__read_mostly for the IPI handling data,
    WARN_ON_ONCE on setup and teardown), dropped spurious prototype
    on 32bit
  - Prevent IPIs from being forwarded to VCPUs
  - Merged the GIC affinity fix, hence one less patch
  - Added RBs from Valentin

* From v1:
  - Clarified the effect of nesting irq_enter/exit (Russell)
  - Changed the point where we tear IPIs down on (Valentin)
  - IPIs are no longer accessible from DT
  - HIP04 and Armada 370-XP have been converted, but are untested
  - arch-specific kstat accounting is removed
  - ARM's legacy interface is dropped

Marc Zyngier (16):
  genirq: Add fasteoi IPI flow
  genirq: Allow interrupts to be excluded from /proc/interrupts
  arm64: Allow IPIs to be handled as normal interrupts
  ARM: Allow IPIs to be handled as normal interrupts
  irqchip/gic-v3: Describe the SGI range
  irqchip/gic-v3: Configure SGIs as standard interrupts
  irqchip/gic: Refactor SMP configuration
  irqchip/gic: Configure SGIs as standard interrupts
  irqchip/gic-common: Don't enable SGIs by default
  irqchip/bcm2836: Configure mailbox interrupts as standard interrupts
  irqchip/hip04: Configure IPIs as standard interrupts
  irqchip/armada-370-xp: Configure IPIs as standard interrupts
  arm64: Kill __smp_cross_call and co
  arm64: Remove custom IRQ stat accounting
  ARM: Kill __smp_cross_call and co
  ARM: Remove custom IRQ stat accounting

 arch/arm/Kconfig                    |   1 +
 arch/arm/include/asm/hardirq.h      |  17 --
 arch/arm/include/asm/smp.h          |   5 +-
 arch/arm/kernel/smp.c               | 135 +++++++++-----
 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/hardirq.h    |   9 -
 arch/arm64/include/asm/irq_work.h   |   4 +-
 arch/arm64/include/asm/smp.h        |   6 +-
 arch/arm64/kernel/smp.c             | 121 ++++++++-----
 drivers/irqchip/irq-armada-370-xp.c | 262 +++++++++++++++++++---------
 drivers/irqchip/irq-bcm2836.c       | 151 +++++++++++++---
 drivers/irqchip/irq-gic-common.c    |   3 -
 drivers/irqchip/irq-gic-v3.c        | 104 ++++++-----
 drivers/irqchip/irq-gic.c           | 177 +++++++++++--------
 drivers/irqchip/irq-hip04.c         |  89 +++++-----
 include/linux/irq.h                 |   5 +-
 kernel/irq/chip.c                   |  27 +++
 kernel/irq/debugfs.c                |   1 +
 kernel/irq/proc.c                   |   2 +-
 kernel/irq/settings.h               |   7 +
 20 files changed, 720 insertions(+), 407 deletions(-)

-- 
2.27.0

