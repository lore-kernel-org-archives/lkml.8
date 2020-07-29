Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DB6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779EF207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bJ/9L8VJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgG2ALj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:11:39 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:34595 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbgG2ALe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595981493; x=1627517493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FiCbRd+M79ICvIiGK2Bhw6HoBX1o4pvTNwYNWqWdNCI=;
  b=bJ/9L8VJwIFapVMkyYDlBZWvfO9VVpMgPh5p0Tk1ReX6Y9mGPmikWl1V
   gvkVoDzEKpl58C9pdC3bO5KKJc4zK1EX8mVMW+JC6CZ+MHCCYQXP2t6Pz
   xQqaMsZdk6dDVRmQ8NEdqnCI13Ly8NvyC7GuvRe/t5EuL2/nHNgRCZMAE
   w=;
IronPort-SDR: lBBOrYQtv0+DRdVCD5YJSJERLcX3yluxPodcLPS0M1rfVi1lpkqa8pHed9zyrQCHNOrXNP3fMU
 ie5TmVK+QwUA==
X-IronPort-AV: E=Sophos;i="5.75,408,1589241600"; 
   d="scan'208";a="55578792"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 29 Jul 2020 00:11:31 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 33CA7A123C;
        Wed, 29 Jul 2020 00:11:27 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:27 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:27 +0000
Received: from localhost (10.143.192.232) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 00:11:26 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        <mingo@kernel.org>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v2 2/5] x86/mm: Refactor cond_ibpb() to support other use cases
Date:   Wed, 29 Jul 2020 10:11:00 +1000
Message-ID: <20200729001103.6450-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729001103.6450-1-sblbir@amazon.com>
References: <20200729001103.6450-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cond_ibpb() has the necessary bits required to track the previous mm in
switch_mm_irqs_off(). This can be reused for other use cases like L1D
flushing on context switch.

[ tglx: Moved comment, added a separate define for state (re)initialization ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200510014803.12190-4-sblbir@amazon.com
---
 arch/x86/include/asm/tlbflush.h |  2 +-
 arch/x86/mm/tlb.c               | 53 ++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c87a2e0b660..a927d40664df 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -83,7 +83,7 @@ struct tlb_state {
 	/* Last user mm for optimizing IBPB */
 	union {
 		struct mm_struct	*last_user_mm;
-		unsigned long		last_user_mm_ibpb;
+		unsigned long		last_user_mm_spec;
 	};
 
 	u16 loaded_mm_asid;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1a3569b43aa5..e031b324c704 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -43,10 +43,14 @@
  */
 
 /*
- * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
- * stored in cpu_tlb_state.last_user_mm_ibpb.
+ * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
+
+/* Bits to set when tlbstate and flush is (re)initialized */
+#define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
 
 /*
  * The x86 feature is called PCID (Process Context IDentifier). It is similar
@@ -317,20 +321,29 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
-static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
-	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
+	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
-	return (unsigned long)next->mm | ibpb;
+	return (unsigned long)next->mm | spec_bits;
 }
 
-static void cond_ibpb(struct task_struct *next)
+static void cond_mitigation(struct task_struct *next)
 {
+	unsigned long prev_mm, next_mm;
+
 	if (!next || !next->mm)
 		return;
 
+	next_mm = mm_mangle_tif_spec_bits(next);
+	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
+
 	/*
+	 * Avoid user/user BTB poisoning by flushing the branch predictor
+	 * when switching between processes. This stops one process from
+	 * doing Spectre-v2 attacks on another.
+	 *
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
 	 * same process. Using the mm pointer instead of mm->context.ctx_id
@@ -340,8 +353,6 @@ static void cond_ibpb(struct task_struct *next)
 	 * exposed data is not really interesting.
 	 */
 	if (static_branch_likely(&switch_mm_cond_ibpb)) {
-		unsigned long prev_mm, next_mm;
-
 		/*
 		 * This is a bit more complex than the always mode because
 		 * it has to handle two cases:
@@ -371,20 +382,14 @@ static void cond_ibpb(struct task_struct *next)
 		 * Optimize this with reasonably small overhead for the
 		 * above cases. Mangle the TIF_SPEC_IB bit into the mm
 		 * pointer of the incoming task which is stored in
-		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
-		 */
-		next_mm = mm_mangle_tif_spec_ib(next);
-		prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
-
-		/*
+		 * cpu_tlbstate.last_user_mm_spec for comparison.
+		 *
 		 * Issue IBPB only if the mm's are different and one or
 		 * both have the IBPB bit set.
 		 */
 		if (next_mm != prev_mm &&
 		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
 			indirect_branch_prediction_barrier();
-
-		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
 	}
 
 	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
@@ -393,11 +398,12 @@ static void cond_ibpb(struct task_struct *next)
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if (this_cpu_read(cpu_tlbstate.last_user_mm) != next->mm) {
+		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) !=
+					(unsigned long)next->mm)
 			indirect_branch_prediction_barrier();
-			this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
-		}
 	}
+
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -519,11 +525,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		need_flush = true;
 	} else {
 		/*
-		 * Avoid user/user BTB poisoning by flushing the branch
-		 * predictor when switching between processes. This stops
-		 * one process from doing Spectre-v2 attacks on another.
+		 * Apply process to process speculation vulnerability
+		 * mitigations if applicable.
 		 */
-		cond_ibpb(tsk);
+		cond_mitigation(tsk);
 
 		/*
 		 * Stop remote flushes for the previous mm.
@@ -640,7 +645,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
-- 
2.17.1

