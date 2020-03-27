Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF98FC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6EE20705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgC0Ig4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:36:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:3912 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgC0Ig4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:36:56 -0400
IronPort-SDR: a6aLNG1nV0c1z3dj2VXyhm/eLEP7+ZGz37pO711TBLMLkD/VqerrQ8ufeYMcSX5h10U+HFOWGJ
 oA+K5OtIzz7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:36:56 -0700
IronPort-SDR: r+j7kpjQNN5jKzVLqgUYcwO7YIajvFnRHuJUeCRPOkzFwjcXg5HZ/pTfMKxBjfzXsnbkd6ExDJ
 MiJFXW7JTZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="251076918"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga006.jf.intel.com with ESMTP; 27 Mar 2020 01:36:52 -0700
Subject: [PATCH V5 05/13] perf/x86: Add perf text poke events for kprobes
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20200304090633.420-1-adrian.hunter@intel.com>
 <20200304090633.420-6-adrian.hunter@intel.com>
 <20200324122150.GN20696@hirez.programming.kicks-ass.net>
 <20200326105805.0723cd10325ad301de061743@kernel.org>
 <07415abd-5084-f16c-cc62-6c9a237951f3@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8eb2a113-f90d-856d-8e14-509d690a2989@intel.com>
Date:   Fri, 27 Mar 2020 10:36:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <07415abd-5084-f16c-cc62-6c9a237951f3@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


Changes in V5:

	Simplify optimized kprobes events (Peter)


 arch/x86/include/asm/kprobes.h |  2 ++
 arch/x86/kernel/kprobes/core.c | 15 +++++++++++++-
 arch/x86/kernel/kprobes/opt.c  | 38 +++++++++++++++++++++++++++++-----
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 95b1f053bd96..ee669cdb5709 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -65,6 +65,8 @@ struct arch_specific_insn {
 	 */
 	bool boostable;
 	bool if_modifier;
+	/* Number of bytes of text poked */
+	int tp_len;
 };
 
 struct arch_optimized_insn {
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 579d30e91a36..8513594bfed1 100644
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
 
@@ -501,12 +505,18 @@ int arch_prepare_kprobe(struct kprobe *p)
 
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
@@ -514,6 +524,9 @@ void arch_disarm_kprobe(struct kprobe *p)
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
index 3f45b5c43a71..b1072c47b595 100644
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
@@ -331,8 +332,15 @@ int arch_within_optimized_kprobe(struct optimized_kprobe *op,
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
@@ -401,8 +409,15 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
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
@@ -454,10 +469,23 @@ void arch_optimize_kprobes(struct list_head *oplist)
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

