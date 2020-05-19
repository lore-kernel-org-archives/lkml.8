Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D59C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE4A20842
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589905104;
	bh=43ce4nit21Yc0x0JFx+LHp0qLH0ptaBXuqqPGTS36WI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0u3GUG87HURzB4W8BKsHOLHy1XohjqNjjkFe38VLsdJBtkt0a3saD+9I4SFsTrdYB
	 RPin2wNrav6QuOS0Ro9T4OePQ2kI1RYs5qa4kda4A/hTxsRuqEfmbiIvJp6TYuwggE
	 zvD60CpDr3jvPNlqsptKJzNCJgLVOlou0wQNnLaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgESQSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgESQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:18:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6562075F;
        Tue, 19 May 2020 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905102;
        bh=43ce4nit21Yc0x0JFx+LHp0qLH0ptaBXuqqPGTS36WI=;
        h=From:To:Cc:Subject:Date:From;
        b=GSE28+0qDdPvn+rf3b26ijIH0PB2Tb3q5+F9sWRssg3xdF9sv0lalo/qRKmykHxeS
         KhFU+4/8EXjTGXmWxw9JicapnJA+T0/JffZjGLCZYinV+FFgX9jps8soazjO50Hnlw
         GZw95knVh1mAm0+XEU3AEGvckgqiyCxvDllzvipE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jb4we-00Decy-9b; Tue, 19 May 2020 17:18:20 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: [PATCH 00/11] arm/arm64: Turning IPIs into normal interrupts
Date:   Tue, 19 May 2020 17:17:44 +0100
Message-Id: <20200519161755.209565-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, kernel-team@android.com
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
irqchip functionnalities. The arch code also duplicates a number of
things that the core irq code already does (such as calling
set_irq_regs(), irq_enter()...).

This series tries to remedy this on arm/arm64 by offering a new
registration interface where the irqchip gives the arch code a range
of interrupts to use for IPIs. The arch code requests these as normal
interrupts.

The bulk of the work is at the interrupt controller level, where all 3
irqchips used on arm64 get converted.

Finally, the arm64 code drops the legacy registration interface. The
same thing could be done on 32bit as well once the two remaining
irqchips using that interface get converted.

There is probably more that could be done: statistics are still
architecture-private code, for example, and no attempt is made to
solve that (apart from hidding the IRQs from /proc/interrupt).

This has been tested on a bunch of 32 and 64bit guests.

Marc Zyngier (11):
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
  arm64: Kill __smp_cross_call and co

 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/smp.h        |   5 +
 arch/arm/kernel/smp.c             |  97 +++++++++++---
 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/irq_work.h |   4 +-
 arch/arm64/include/asm/smp.h      |   6 +-
 arch/arm64/kernel/smp.c           |  98 +++++++++++----
 drivers/irqchip/irq-bcm2836.c     | 151 ++++++++++++++++++----
 drivers/irqchip/irq-gic-common.c  |   3 -
 drivers/irqchip/irq-gic-v3.c      | 109 ++++++++++------
 drivers/irqchip/irq-gic.c         | 203 ++++++++++++++++++------------
 include/linux/irq.h               |   4 +-
 kernel/irq/chip.c                 |  26 ++++
 kernel/irq/debugfs.c              |   1 +
 kernel/irq/proc.c                 |   2 +-
 kernel/irq/settings.h             |   7 ++
 16 files changed, 515 insertions(+), 203 deletions(-)

-- 
2.26.2

