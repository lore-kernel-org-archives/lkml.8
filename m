Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 10:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C472145D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593255073;
	bh=umiL+bIyAhv5WPUElLkGd9quRRc7GdaO+xNAij4M1a0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=R766FRhjII7JDimq8elGFnctrQ3d2h9lhqMhXZ5fwtph4XN4wKzPJGr2aib18GDT8
	 A2jRU772t67SFesLsRe4fZnIEqHtkuIl45TzSm1Bf/oNi1HQt0ASbvOMoZ01KFGUfW
	 FLHLwSzIzFVs6yhTJ2D68CuPBw/3HXLLlrWeK6o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgF0KvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 06:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgF0KvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 06:51:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF2D20DD4;
        Sat, 27 Jun 2020 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593255069;
        bh=umiL+bIyAhv5WPUElLkGd9quRRc7GdaO+xNAij4M1a0=;
        h=From:To:Cc:Subject:Date:From;
        b=OaPFBRCuwgvChvQgh7N+rOWinph4on7EWiY9Pn6bkWzXDRT5RgNLOjo1AvMCJGapw
         Ro09IulRneXh/n/xwaBsK2wULRmqTsEAorIVpkkMaxotg0h6FPVRJnnRFBZm03RGe8
         WN8wwC9AaA9WMVpXEe799Tyh8M08NyDJKanBBmKE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jp8QN-006rmP-HW; Sat, 27 Jun 2020 11:51:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 5.8, take #1
Date:   Sat, 27 Jun 2020 11:51:03 +0100
Message-Id: <20200627105103.92465-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, jiaxun.yang@flygoat.com, palmerdabbelt@google.com, yuzenghui@huawei.com, jason@lakedaemon.net, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a small pull request for a few fixes that have accumulated over
the past few weeks. The most interesting one is an atomicity update in
the GIC set_affinity callback, which could race against the update of
another 3 adjacent interrupts (I broke it 4 years ago, and nobody
noticed...). The other bug is a nice GICv4.1 sleep-in-atomic found by
Zenghui.  The rest fixes a couple of typos.

Please pull,

	M.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.8-1

for you to fetch changes up to 005c34ae4b44f085120d7f371121ec7ded677761:

  irqchip/gic: Atomically update affinity (2020-06-21 15:24:46 +0100)

----------------------------------------------------------------
irqchip fixes for Linux 5.8, take #1

- Fix atomicity of affinity update in the GIC driver
- Don't sleep in atomic when waiting for a GICv4.1 RD to respond
- Fix a couple of typos in user-visible messages

----------------------------------------------------------------
Jiaxun Yang (1):
      irqchip/loongson-pci-msi: Fix a typo in Kconfig

Marc Zyngier (1):
      irqchip/gic: Atomically update affinity

Palmer Dabbelt (1):
      irqchip/riscv-intc: Fix a typo in a pr_warn()

Zenghui Yu (1):
      irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix sleep in atomic

 drivers/irqchip/Kconfig          |  2 +-
 drivers/irqchip/irq-gic-v3-its.c |  8 ++++----
 drivers/irqchip/irq-gic.c        | 14 +++-----------
 drivers/irqchip/irq-riscv-intc.c |  2 +-
 4 files changed, 9 insertions(+), 17 deletions(-)
