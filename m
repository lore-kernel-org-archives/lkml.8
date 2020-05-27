Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5342C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C3A20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgE0IMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgE0IL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA49C061A0F;
        Wed, 27 May 2020 01:11:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAI-0002ZD-K5; Wed, 27 May 2020 10:11:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CDA191C070D;
        Wed, 27 May 2020 10:11:52 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:52 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/irq: Use generic irq_regs implementation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202118.704169051@linutronix.de>
References: <20200521202118.704169051@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711273.17951.11969616264181835978.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     359763a015a4bc3ac9899bf8a3ea97dae91c8e2a
Gitweb:        https://git.kernel.org/tip/359763a015a4bc3ac9899bf8a3ea97dae91c8e2a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/irq: Use generic irq_regs implementation

The only difference is the name of the per-CPU variable: irq_regs
vs. __irq_regs, but the accessor functions are identical.

Remove the pointless copy and use the generic variant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202118.704169051@linutronix.de
---
 arch/x86/include/asm/irq_regs.h | 32 +--------------------------------
 arch/x86/kernel/irq.c           |  3 +---
 2 files changed, 35 deletions(-)
 delete mode 100644 arch/x86/include/asm/irq_regs.h

diff --git a/arch/x86/include/asm/irq_regs.h b/arch/x86/include/asm/irq_regs.h
deleted file mode 100644
index 187ce59..0000000
--- a/arch/x86/include/asm/irq_regs.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Per-cpu current frame pointer - the location of the last exception frame on
- * the stack, stored in the per-cpu area.
- *
- * Jeremy Fitzhardinge <jeremy@goop.org>
- */
-#ifndef _ASM_X86_IRQ_REGS_H
-#define _ASM_X86_IRQ_REGS_H
-
-#include <asm/percpu.h>
-
-#define ARCH_HAS_OWN_IRQ_REGS
-
-DECLARE_PER_CPU(struct pt_regs *, irq_regs);
-
-static inline struct pt_regs *get_irq_regs(void)
-{
-	return __this_cpu_read(irq_regs);
-}
-
-static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
-{
-	struct pt_regs *old_regs;
-
-	old_regs = get_irq_regs();
-	__this_cpu_write(irq_regs, new_regs);
-
-	return old_regs;
-}
-
-#endif /* _ASM_X86_IRQ_REGS_32_H */
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index c7965ff..252065d 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -26,9 +26,6 @@
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
-DEFINE_PER_CPU(struct pt_regs *, irq_regs);
-EXPORT_PER_CPU_SYMBOL(irq_regs);
-
 atomic_t irq_err_count;
 
 /*
