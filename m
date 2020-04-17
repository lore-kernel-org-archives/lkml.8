Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CDEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63B521D95
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587111972;
	bh=QniDF0MNkCoLxAtiIxI8XaFZx0ywxBE2EDBpVkeaF98=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mX5l8gYBJZw+nYO7hJm+g4+fqa/2HgnLdm0OEWsM4Y9ylIT/w4Vn9U/XK34bJnmrl
	 Kuc0o55E6BIFroEj85gv7xPozAwAsN4W81aVT/yyHtzbhZmC4Qv/Xlnn/20+bdNQne
	 OS/sTxXhJbTVSo2pbOFB/T+51ZWuv6WU1qhbxnT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgDQI0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgDQI0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:26:11 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C532F207FC;
        Fri, 17 Apr 2020 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587111970;
        bh=QniDF0MNkCoLxAtiIxI8XaFZx0ywxBE2EDBpVkeaF98=;
        h=From:To:Cc:Subject:Date:From;
        b=kbUGBo6aVkgb2cElh3D/ENO3uZddr3QIF4c3F3Xui1fpZBhjq6PVNbAFIcwfw2tsm
         8pOzga8HTu1yk9XUPexeTq5vP9GSAD27YhF4i0KvKXebX2huLlavZye8F8UvNEWOYf
         NfoB+jj8f+Sfl1vfZdz0KAGPAnB6E8yAuNmVy9BM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jPMK9-0046yk-48; Fri, 17 Apr 2020 09:26:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Hulk Robot <hulkci@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 5.7, take 2
Date:   Fri, 17 Apr 2020 09:25:59 +0100
Message-Id: <20200417082559.3065907-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, atish.patra@wdc.com, grygorii.strashko@ti.com, hulkci@huawei.com, yanaijie@huawei.com, jbrunet@baylibre.com, lokeshvutla@ti.com, yuzenghui@huawei.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a handful of irqchip fixes for the next -rc. Nothing really
stands out this time (see the tag message for the gorry details).

Please pull,

       M.

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.7-2

for you to fetch changes up to 44a987d0a436d27ea5e3cf2ae7ae653de6e58327:

  Merge branch 'irq/gic-v4.1-fixes-5.7' into irq/irqchip-5.7 (2020-04-17 08:59:55 +0100)

----------------------------------------------------------------
irqchip fixes for Linux 5.7, take #2

- Fix the mbigen driver to properly free its MSI descriptors on teardown
- Fix the TI INTA driver to avoid handling spurious interrupts from masked interrupts
- Fix the SiFive PLIC driver to use the correct interrupt priority mask
- Fix the Amlogic Meson gpio driver creative locking
- Fix the GICv4.1 virtual SGI set_affinity callback to update the effective affinity
- Allow the GICv4.x driver to synchronize with the HW pending table parsing
- Fix a couple of missing static attributes

----------------------------------------------------------------
Atish Patra (1):
      irqchip/sifive-plic: Fix maximum priority threshold value

Grygorii Strashko (1):
      irqchip/ti-sci-inta: Fix processing of masked irqs

Jason Yan (2):
      irqchip/irq-mvebu-icu: Make legacy_bindings static
      irqchip/irq-bcm7038-l1: Make bcm7038_l1_of_init() static

Marc Zyngier (4):
      irqchip/gic-v4.1: Add support for VPENDBASER's Dirty+Valid signaling
      irqchip/gic-v4.1: Update effective affinity of virtual SGIs
      irqchip/meson-gpio: Fix HARDIRQ-safe -> HARDIRQ-unsafe lock order
      Merge branch 'irq/gic-v4.1-fixes-5.7' into irq/irqchip-5.7

Zenghui Yu (1):
      irqchip/mbigen: Free msi_desc on device teardown

 drivers/irqchip/irq-bcm7038-l1.c   |  2 +-
 drivers/irqchip/irq-gic-v3-its.c   | 20 ++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c       | 11 +++++++----
 drivers/irqchip/irq-mbigen.c       |  8 +++++++-
 drivers/irqchip/irq-meson-gpio.c   | 18 ++++++++++--------
 drivers/irqchip/irq-mvebu-icu.c    |  2 +-
 drivers/irqchip/irq-sifive-plic.c  |  2 +-
 drivers/irqchip/irq-ti-sci-inta.c  |  3 ++-
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 9 files changed, 51 insertions(+), 17 deletions(-)
