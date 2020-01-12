Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1451C33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88289214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbgALRs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:48:57 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:52504 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbgALRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:48:57 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id pVov210015USYZQ01Vov0H; Sun, 12 Jan 2020 18:48:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqhM7-0000EV-10; Sun, 12 Jan 2020 18:48:55 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqhM6-0000ik-Up; Sun, 12 Jan 2020 18:48:54 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Switch to asm-generic/hardirq.h
Date:   Sun, 12 Jan 2020 18:48:54 +0100
Message-Id: <20200112174854.2726-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Classic m68k with MMU was converted to generic hardirqs a long time ago,
and there are no longer include dependency issues preventing the direct
use of asm-generic/hardirq.h.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/Kbuild    |  1 +
 arch/m68k/include/asm/hardirq.h | 29 -----------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)
 delete mode 100644 arch/m68k/include/asm/hardirq.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 591d53b763b71b27..63f12afc48749c96 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -8,6 +8,7 @@ generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += futex.h
+generic-y += hardirq.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
diff --git a/arch/m68k/include/asm/hardirq.h b/arch/m68k/include/asm/hardirq.h
deleted file mode 100644
index 11793165445df45a..0000000000000000
--- a/arch/m68k/include/asm/hardirq.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __M68K_HARDIRQ_H
-#define __M68K_HARDIRQ_H
-
-#include <linux/threads.h>
-#include <linux/cache.h>
-#include <asm/irq.h>
-
-#ifdef CONFIG_MMU
-
-static inline void ack_bad_irq(unsigned int irq)
-{
-	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
-}
-
-/* entry.S is sensitive to the offsets of these fields */
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
-#else
-
-#include <asm-generic/hardirq.h>
-
-#endif /* !CONFIG_MMU */
-
-#endif
-- 
2.17.1

