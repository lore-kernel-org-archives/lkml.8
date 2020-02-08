Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E37AC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6252A21775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581162763;
	bh=bfKeYqeFjbamCdmJFN/iOPEtcVzfb0kuXOFdangMKr0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lbS5tLAwJXta50k8u7fJpwKCu4TQlIGRv2E0NlVsOFFPmbDPdgmRYgzwBgbKetTAy
	 jgLwosQCP1Q9oaBOrnlDGGV/XMRTIFZ8QSJvQGJdPq9yjcqerDCPaKuYvRLbw4xKLT
	 JWjckLfuFyrIXhQz/ISUDC/8uWP913q7v2mGp8Y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBHLwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 06:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgBHLwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 06:52:42 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622852082E;
        Sat,  8 Feb 2020 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581162761;
        bh=bfKeYqeFjbamCdmJFN/iOPEtcVzfb0kuXOFdangMKr0=;
        h=From:To:Cc:Subject:Date:From;
        b=RxgTcQa6U+omrrFnTtGtxOYJFMcLdy93jwbPv+ip+T28pJIb0UA78+OW6SgPnvYbK
         C1AaPRoH82wD02kUecCn2cDTiWFrUCzNeTIH7gJy6btAt+yAurGYkJjAEXgwpNcICx
         vIv6eTRlvrPu9Ahc4Ki8CCLhnUZfhIljtTqJCyfM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j0Of9-003gyD-7A; Sat, 08 Feb 2020 11:52:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guo Ren <guoren@kernel.org>, Heyi Guo <guoheyi@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 5.6, take #1
Date:   Sat,  8 Feb 2020 11:52:21 +0000
Message-Id: <20200208115221.1894-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, guoren@kernel.org, guoheyi@huawei.com, rdunlap@infradead.org, yuzenghui@huawei.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a set of fixes that I've collected during the merge window. most
of it being the work of Zenghui Yu who contributed a bunch of fixes and
cleanups for GICv3/4/4.1. We also have a small fix for unusual ACPI
configurations, and a KConfig cleanup.

Please pull,

       M.

The following changes since commit f4a81f5a853e0b7c38bfad3afd6d0365d654e777:

  irqchip/gic-v4.1: Allow direct invalidation of VLPIs (2020-01-22 14:22:21 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.6-1

for you to fetch changes up to 5186a6cc3ef5a3fa327c258924ef098b0de77006:

  irqchip/gic-v3-its: Rename VPENDBASER/VPROPBASER accessors (2020-02-08 10:01:33 +0000)

----------------------------------------------------------------
irqchip fixes for 5.6, take #1

- Guarantee allocation of L2 vPE table for GICv4.1
- Fix GICv4.1 VPROPBASER programming
- Numerous GICv4.1 tidy ups
- Fix disabled GICv3 redistributor provisioning with ACPI
- KConfig cleanup for C-SKY

----------------------------------------------------------------
Marc Zyngier (1):
      irqchip/gic-v3: Only provision redistributors that are enabled in ACPI

Randy Dunlap (1):
      irqchip: Some Kconfig cleanup for C-SKY

Zenghui Yu (7):
      irqchip/gic-v3-its: Reference to its_invall_cmd descriptor when building INVALL
      irqchip/gic-v4.1: Fix programming of GICR_VPROPBASER_4_1_SIZE
      irqchip/gic-v4.1: Set vpe_l1_base for all redistributors
      irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level
      irqchip/gic-v4.1: Drop 'tmp' in inherit_vpe_l1_table_from_rd()
      irqchip/gic-v3-its: Remove superfluous WARN_ON
      irqchip/gic-v3-its: Rename VPENDBASER/VPROPBASER accessors

 arch/arm/include/asm/arch_gicv3.h   |  12 ++--
 arch/arm64/include/asm/arch_gicv3.h |   8 +--
 drivers/irqchip/Kconfig             |   4 +-
 drivers/irqchip/irq-gic-v3-its.c    | 120 ++++++++++++++++++++++++++++++------
 drivers/irqchip/irq-gic-v3.c        |   9 ++-
 include/linux/irqchip/arm-gic-v3.h  |   2 +-
 6 files changed, 120 insertions(+), 35 deletions(-)
