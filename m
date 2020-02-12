Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E264820714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBLMvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:51:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:63674 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLMvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:51:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 04:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="237702502"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 04:51:02 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/13] perf/x86: Add perf text poke events for kprobes
Date:   Wed, 12 Feb 2020 14:49:41 +0200
Message-Id: <20200212124949.3589-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212124949.3589-1-adrian.hunter@intel.com>
References: <20200212124949.3589-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf text poke events for kprobes. That includes:

 - the replaced instruction(s) which are executed out-of-line
   i.e. arch_copy_kprobe() and arch_remove_kprobe()

 - optimised kprobe function
   i.e. arch_prepare_optimized_kprobe() and
      __arch_remove_optimized_kprobe()

 - optimised kprobe
   i.e. arch_optimize_kprobes() and arch_unoptimize_kprobe()

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/include/asm/kprobes.h       |  4 ++++
 arch/x86/include/asm/text-patching.h |  2 ++
 arch/x86/kernel/alternative.c        | 35 +++++++++++++++++-----------
 arch/x86/kernel/kprobes/core.c       |  7 ++++++
 arch/x86/kernel/kprobes/opt.c        | 18 +++++++++++++-
 5 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 95b1f053bd96..542ce120a54d 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -65,11 +65,15 @@ struct arch_specific_insn {
 	 */
 	bool boostable;
 	bool if_modifier;
+	/* Number of bytes of text poked */
+	int tp_len;
 };
 
 struct arch_optimized_insn {
 	/* copy of the original instructions */
 	kprobe_opcode_t copied_insn[DISP32_SIZE];
+	/* Number of bytes of text poked */
+	int tp_len;
 	/* detour code buffer */
 	kprobe_opcode_t *insn;
 	/* the size of instructions copied to detour code buffer */
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 67315fa3956a..13bb51a7789c 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -45,6 +45,8 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
+extern void __text_poke_bp(void *addr, const void *opcode, size_t len,
+			   const void *emulate, const u8 *oldptr);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
 
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 737e7a842f85..c8cfc97abc9e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1075,6 +1075,7 @@ static int tp_vec_nr;
  * text_poke_bp_batch() -- update instructions on live kernel on SMP
  * @tp:			vector of instructions to patch
  * @nr_entries:		number of entries in the vector
+ * @oldptr:		pointer to original old insn byte
  *
  * Modify multi-byte instruction by using int3 breakpoint on SMP.
  * We completely avoid stop_machine() here, and achieve the
@@ -1092,7 +1093,8 @@ static int tp_vec_nr;
  *		  replacing opcode
  *	- sync cores
  */
-static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
+static void text_poke_bp_batch(struct text_poke_loc *tp,
+			       unsigned int nr_entries, const u8 *oldptr)
 {
 	struct bp_patching_desc desc = {
 		.vec = tp,
@@ -1117,7 +1119,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
 	for (i = 0; i < nr_entries; i++) {
-		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
+		tp[i].old = oldptr ? *oldptr : *(u8 *)text_poke_addr(&tp[i]);
 		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
 	}
 
@@ -1274,7 +1276,7 @@ static bool tp_order_fail(void *addr)
 static void text_poke_flush(void *addr)
 {
 	if (tp_vec_nr == TP_VEC_MAX || tp_order_fail(addr)) {
-		text_poke_bp_batch(tp_vec, tp_vec_nr);
+		text_poke_bp_batch(tp_vec, tp_vec_nr, NULL);
 		tp_vec_nr = 0;
 	}
 }
@@ -1299,6 +1301,20 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
 	text_poke_loc_init(tp, addr, opcode, len, emulate);
 }
 
+void __ref __text_poke_bp(void *addr, const void *opcode, size_t len,
+			  const void *emulate, const u8 *oldptr)
+{
+	struct text_poke_loc tp;
+
+	if (unlikely(system_state == SYSTEM_BOOTING)) {
+		text_poke_early(addr, opcode, len);
+		return;
+	}
+
+	text_poke_loc_init(&tp, addr, opcode, len, emulate);
+	text_poke_bp_batch(&tp, 1, oldptr);
+}
+
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
  * @addr:	address to patch
@@ -1310,15 +1326,8 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
  * dynamically allocated memory. This function should be used when it is
  * not possible to allocate memory.
  */
-void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
+void __ref text_poke_bp(void *addr, const void *opcode, size_t len,
+			const void *emulate)
 {
-	struct text_poke_loc tp;
-
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
-		text_poke_early(addr, opcode, len);
-		return;
-	}
-
-	text_poke_loc_init(&tp, addr, opcode, len, emulate);
-	text_poke_bp_batch(&tp, 1);
+	return __text_poke_bp(addr, opcode, len, emulate, NULL);
 }
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 579d30e91a36..12ea05d923ec 100644
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
@@ -470,6 +471,9 @@ static int arch_copy_kprobe(struct kprobe *p)
 	/* Also, displacement change doesn't affect the first byte */
 	p->opcode = buf[0];
 
+	p->ainsn.tp_len = len;
+	perf_event_text_poke(p->ainsn.insn, NULL, 0, buf, len);
+
 	/* OK, write back the instruction(s) into ROX insn buffer */
 	text_poke(p->ainsn.insn, buf, len);
 
@@ -514,6 +518,9 @@ void arch_disarm_kprobe(struct kprobe *p)
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
index 3f45b5c43a71..0f0b84b3f4b9 100644
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
@@ -332,6 +333,10 @@ static
 void __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
 {
 	if (op->optinsn.insn) {
+		/* Record the perf event before freeing the slot */
+		if (dirty)
+			perf_event_text_poke(op->optinsn.insn, op->optinsn.insn,
+					     op->optinsn.tp_len, NULL, 0);
 		free_optinsn_slot(op->optinsn.insn, dirty);
 		op->optinsn.insn = NULL;
 		op->optinsn.size = 0;
@@ -401,6 +406,9 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 			   (u8 *)op->kp.addr + op->optinsn.size);
 	len += JMP32_INSN_SIZE;
 
+	op->optinsn.tp_len = len;
+	perf_event_text_poke(slot, NULL, 0, buf, len);
+
 	/* We have to use text_poke() for instruction buffer because it is RO */
 	text_poke(slot, buf, len);
 	ret = 0;
@@ -439,7 +447,8 @@ void arch_optimize_kprobes(struct list_head *oplist)
 		insn_buff[0] = JMP32_INSN_OPCODE;
 		*(s32 *)(&insn_buff[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE, NULL);
+		__text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE, NULL,
+			       &op->kp.opcode);
 
 		list_del_init(&op->list);
 	}
@@ -454,9 +463,16 @@ void arch_optimize_kprobes(struct list_head *oplist)
  */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
+	u8 old[POKE_MAX_OPCODE_SIZE];
+	u8 new[POKE_MAX_OPCODE_SIZE] = { op->kp.opcode, };
+	size_t len = INT3_INSN_SIZE + DISP32_SIZE;
+
+	memcpy(old, op->kp.addr, len);
 	arch_arm_kprobe(&op->kp);
 	text_poke(op->kp.addr + INT3_INSN_SIZE,
 		  op->optinsn.copied_insn, DISP32_SIZE);
+	memcpy(new + INT3_INSN_SIZE, op->optinsn.copied_insn, DISP32_SIZE);
+	perf_event_text_poke(op->kp.addr, old, len, new, len);
 	text_poke_sync();
 }
 
-- 
2.17.1

