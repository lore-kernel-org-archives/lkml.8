Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1E2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D577D208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgGCP45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:56:57 -0400
Received: from foss.arm.com ([217.140.110.172]:46912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgGCP4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:56:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D4EA1042;
        Fri,  3 Jul 2020 08:56:55 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 12BC43F73C;
        Fri,  3 Jul 2020 08:56:53 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 0/2] genirq: Kill preflow handlers
Date:   Fri,  3 Jul 2020 16:56:43 +0100
Message-Id: <20200703155645.29703-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while strolling around the different flow handlers, I tried to make sense of
what preflow_handler() was about. Turns out no one uses those anymore, but the
genirq support has remained in place.

Unless we can see another user of those in the near future, this seems like as
good a time as any for a little housecleaning.

- Patch 1 simply deselects the (unexploited) preflow Kconfig for sparc64
- Patch 2 is the actual cleanup

Cheers,
Valentin

Valentin Schneider (2):
  sparc64: Deselect IRQ_PREFLOW_FASTEOI
  genirq: Remove preflow handler support

 arch/sparc/Kconfig         |  1 -
 include/linux/irqdesc.h    | 15 ---------------
 include/linux/irqhandler.h |  1 -
 kernel/irq/Kconfig         |  4 ----
 kernel/irq/chip.c          | 13 -------------
 5 files changed, 34 deletions(-)

--
2.27.0

