Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3313C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A678320661
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgELMTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:19:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:43213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbgELMT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:19:28 -0400
IronPort-SDR: YLRrKbbtkOK13ynb3DHyEWyrqmc5ROW7j64q3+Dw51rhM5nAq3bjRt3+25Rrf3fxv4h3PRWoqr
 xElQJC/njE5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:19:28 -0700
IronPort-SDR: oSkGybU74weqw8ylGEd3hPmVjtw4ez4pjQ96agdzDiFF+6y7qrg12z99k7+QXUfhhUmeomv+ht
 TV6P0ynqm0CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="250879266"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 05:19:24 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 05/15] perf/x86: Add perf text poke events for kprobes
Date:   Tue, 12 May 2020 15:19:12 +0300
Message-Id: <20200512121922.8997-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512121922.8997-1-adrian.hunter@intel.com>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/kprobes.h |  2 ++
 arch/x86/kernel/kprobes/core.c | 15 +++++++++++++-
 arch/x86/kernel/kprobes/opt.c  | 38 +++++++++++++++++++++++++++++-----
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 073eb7ad2f56..143bc9abe99c 100644
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
index 4d7022a740ab..6d8b58c84cbc 100644
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
index ea13f6888284..f86be31d37cc 100644
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
@@ -354,8 +355,15 @@ int arch_within_optimized_kprobe(struct optimized_kprobe *op,
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
@@ -426,8 +434,15 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
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
@@ -479,10 +494,23 @@ void arch_optimize_kprobes(struct list_head *oplist)
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
-- 
2.17.1

