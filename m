Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2506CC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1063923126
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgELWXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731690AbgELWXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdIP-0004qB-Ah; Wed, 13 May 2020 00:22:42 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CEB48100605;
        Wed, 13 May 2020 00:22:40 +0200 (CEST)
Message-Id: <20200512213811.213646521@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V5 18/38] x86/irq: Use generic irq_regs implementation
References: <20200512210059.056244513@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only difference is the name of the per-CPU variable: irq_regs
vs. __irq_regs, but the accessor functions are identical.

Remove the pointless copy and use the generic variant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch.
---
 arch/x86/include/asm/irq_regs.h |   32 --------------------------------
 arch/x86/kernel/irq.c           |    3 ---
 2 files changed, 35 deletions(-)

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

