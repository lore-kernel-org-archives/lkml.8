Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F05422B3F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgG3RFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:05:20 -0400
Received: from foss.arm.com ([217.140.110.172]:42686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3RFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:05:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 062411FB;
        Thu, 30 Jul 2020 10:05:19 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02D283F66E;
        Thu, 30 Jul 2020 10:05:17 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: [PATCH v2 0/2] irqchip/gic-v2, v3: Enforce ACK/EOI pairing on IRQ retrigger
Date:   Thu, 30 Jul 2020 18:03:19 +0100
Message-Id: <20200730170321.31228-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 of:

  https://lkml.kernel.org/r/20200710145642.28978-1-valentin.schneider@arm.com

the TL;DR being: retriggering of IRQs marked with IRQS_PENDING breaks the
ACK/EOI pairing the GIC spec requires, and this is an attempt to clean it
up; details are in the changelogs.

Testing
=======

I briefly tested this on my Juno r0 by hackishly configuring the RTC
interrupt as edge-sensitive (level interrupts don't get retriggered) and
triggering a wakeup interrupt via

  $ rtcwake -d /dev/rtc0 -s 1 -m mem

along with sprinkling a few printks to make sure things go down the right
way. Note that wakeup from RTC is currently broken on Juno and requires
this patch from Sudeep:

 4df2ef85f0ef ("rtc: pl031: fix set_alarm by adding back call to alarm_irq_enable")

The RTC on my eMAG can't be set up as a wakeup alarm, so I didn't get to
test the retriggering side of things on GICv3 - the rest does seem to still
behave correctly.

Revisions
=========

v1 -> v2
--------

o Trimmed the changelog
o Fixed gic_retrigger() return value (Marc)
o (new patch) Added IRQD_HANDLE_ENFORCE_IRQCTX to all GIC IRQs

Valentin Schneider (2):
  irqchip/gic-v2, v3: Implement irq_chip->irq_retrigger()
  irqchip/gic-v2, v3: Prevent SW resends entirely

 drivers/irqchip/irq-gic-v3.c | 12 +++++++++++-
 drivers/irqchip/irq-gic.c    | 12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

--
2.27.0

