Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9227C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE91620FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgFPMWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgFPMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45B9C08C5C2;
        Tue, 16 Jun 2020 05:22:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbC-0004ca-1f; Tue, 16 Jun 2020 14:21:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A057A1C0478;
        Tue, 16 Jun 2020 14:21:48 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:48 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add perf text poke events for kprobes
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512121922.8997-6-adrian.hunter@intel.com>
References: <20200512121922.8997-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <159231010843.16989.15335309797259291483.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3e46bb40af8c12947c093efb8af56e0e921cd39b
Gitweb:        https://git.kernel.org/tip/3e46bb40af8c12947c093efb8af56e0e921cd39b
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 12 May 2020 15:19:12 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:49 +02:00

perf/x86: Add perf text poke events for kprobes

Add perf text poke events for kprobes. That includes:

 - the replaced instruction(s) which are executed out-of-line
   i.e. arch_copy_kprobe() and arch_remove_kprobe()

 - the INT3 that activates the kprobe
   i.e. arch_arm_kprobe() and arch_disarm_kprobe()

 - optimised kprobe function
   i.e. arch_prepare_optimized_kprobe() and
      __arch_remove_optimized_kprobe()

 - optimised kprobe
   i.e. arch_optimize_kprobes() and arch_unoptimize_kprobe()

Resulting in 8 possible text_poke events:

 0:  NULL -> probe.ainsn.insn (if ainsn.boostable && !kp.post_handler)
					arch_copy_kprobe()

 1:  old0 -> INT3			arch_arm_kprobe()

 // boosted kprobe active

 2:  NULL -> optprobe_trampoline	arch_prepare_optimized_kprobe()

 3:  INT3,old1,old2,old3,old4 -> JMP32	arch_optimize_kprobes()

 // optprobe active

 4:  JMP32 -> INT3,old1,old2,old3,old4

 // optprobe disabled and kprobe active (this sometimes goes back to 3)
					arch_unoptimize_kprobe()

 5:  optprobe_trampoline -> NULL	arch_remove_optimized_kprobe()

 // boosted kprobe active

 6:  INT3 -> old0			arch_disarm_kprobe()

 7:  probe.ainsn.insn -> NULL (if ainsn.boostable && !kp.post_handler)
					arch_remove_kprobe()

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20200512121922.8997-6-adrian.hunter@intel.com
---
 arch/x86/include/asm/kprobes.h |  2 ++-
 arch/x86/kernel/kprobes/core.c | 15 ++++++++++++-
 arch/x86/kernel/kprobes/opt.c  | 38 ++++++++++++++++++++++++++++-----
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 073eb7a..143bc9a 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -66,6 +66,8 @@ struct arch_specific_insn {
 	 */
 	bool boostable;
 	bool if_modifier;
+	/* Number of bytes of text poked */
+	int tp_len;
 };
 
 struct arch_optimized_insn {
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 3bafe1b..bcc53c0 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -33,6 +33,7 @@
 #include <linux/hardirq.h>
 #include <linux/preempt.h>
 #include <linux/sched/debug.h>
+#include <linux/perf_event.h>
 #include <linux/extable.h>
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
@@ -471,6 +472,9 @@ static int arch_copy_kprobe(struct kprobe *p)
 	/* Also, displacement change doesn't affect the first byte */
 	p->opcode = buf[0];
 
+	p->ainsn.tp_len = len;
+	perf_event_text_poke(p->ainsn.insn, NULL, 0, buf, len);
+
 	/* OK, write back the instruction(s) into ROX insn buffer */
 	text_poke(p->ainsn.insn, buf, len);
 
@@ -502,12 +506,18 @@ int arch_prepare_kprobe(struct kprobe *p)
 
 void arch_arm_kprobe(struct kprobe *p)
 {
-	text_poke(p->addr, ((unsigned char []){INT3_INSN_OPCODE}), 1);
+	u8 int3 = INT3_INSN_OPCODE;
+
+	text_poke(p->addr, &int3, 1);
 	text_poke_sync();
+	perf_event_text_poke(p->addr, &p->opcode, 1, &int3, 1);
 }
 
 void arch_disarm_kprobe(struct kprobe *p)
 {
+	u8 int3 = INT3_INSN_OPCODE;
+
+	perf_event_text_poke(p->addr, &int3, 1, &p->opcode, 1);
 	text_poke(p->addr, &p->opcode, 1);
 	text_poke_sync();
 }
@@ -515,6 +525,9 @@ void arch_disarm_kprobe(struct kprobe *p)
 void arch_remove_kprobe(struct kprobe *p)
 {
 	if (p->ainsn.insn) {
+		/* Record the perf event before freeing the slot */
+		perf_event_text_poke(p->ainsn.insn, p->ainsn.insn,
+				     p->ainsn.tp_len, NULL, 0);
 		free_insn_slot(p->ainsn.insn, p->ainsn.boostable);
 		p->ainsn.insn = NULL;
 	}
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 321c199..3239b6a 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -6,6 +6,7 @@
  * Copyright (C) Hitachi Ltd., 2012
  */
 #include <linux/kprobes.h>
+#include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/string.h>
 #include <linux/slab.h>
@@ -352,8 +353,15 @@ int arch_within_optimized_kprobe(struct optimized_kprobe *op,
 static
 void __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
 {
-	if (op->optinsn.insn) {
-		free_optinsn_slot(op->optinsn.insn, dirty);
+	u8 *slot = op->optinsn.insn;
+	if (slot) {
+		int len = TMPL_END_IDX + op->optinsn.size + JMP32_INSN_SIZE;
+
+		/* Record the perf event before freeing the slot */
+		if (dirty)
+			perf_event_text_poke(slot, slot, len, NULL, 0);
+
+		free_optinsn_slot(slot, dirty);
 		op->optinsn.insn = NULL;
 		op->optinsn.size = 0;
 	}
@@ -424,8 +432,15 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 			   (u8 *)op->kp.addr + op->optinsn.size);
 	len += JMP32_INSN_SIZE;
 
+	/*
+	 * Note	len = TMPL_END_IDX + op->optinsn.size + JMP32_INSN_SIZE is also
+	 * used in __arch_remove_optimized_kprobe().
+	 */
+
 	/* We have to use text_poke() for instruction buffer because it is RO */
+	perf_event_text_poke(slot, NULL, 0, buf, len);
 	text_poke(slot, buf, len);
+
 	ret = 0;
 out:
 	kfree(buf);
@@ -477,10 +492,23 @@ void arch_optimize_kprobes(struct list_head *oplist)
  */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
-	arch_arm_kprobe(&op->kp);
-	text_poke(op->kp.addr + INT3_INSN_SIZE,
-		  op->optinsn.copied_insn, DISP32_SIZE);
+	u8 new[JMP32_INSN_SIZE] = { INT3_INSN_OPCODE, };
+	u8 old[JMP32_INSN_SIZE];
+	u8 *addr = op->kp.addr;
+
+	memcpy(old, op->kp.addr, JMP32_INSN_SIZE);
+	memcpy(new + INT3_INSN_SIZE,
+	       op->optinsn.copied_insn,
+	       JMP32_INSN_SIZE - INT3_INSN_SIZE);
+
+	text_poke(addr, new, INT3_INSN_SIZE);
 	text_poke_sync();
+	text_poke(addr + INT3_INSN_SIZE,
+		  new + INT3_INSN_SIZE,
+		  JMP32_INSN_SIZE - INT3_INSN_SIZE);
+	text_poke_sync();
+
+	perf_event_text_poke(op->kp.addr, old, JMP32_INSN_SIZE, new, JMP32_INSN_SIZE);
 }
 
 /*
