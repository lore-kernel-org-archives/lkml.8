Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A1DC47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536A720A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p3hf9Zli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgEJBsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 21:48:32 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:13612 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgEJBsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 21:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589075309; x=1620611309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TfCbh6Ws4bPSN17KqjjWMeKKKnG2rMNi9Ev0fkWczFs=;
  b=p3hf9Zli3AD5jJIbFADutUxHA5r4ry1fuCPsZ8+9vI1ocu4bwAkRpoD+
   pIY4JPuTSPN3LbL1umkwX5ylsNijZIEVtjdBXb+IS9MIrB5BQEkfK0hfj
   1+uou/LyH5AoUZHruxR/Hrn+q1mbbr1tOZ/RomN3D9YdpJ74+KrCrYKIr
   Q=;
IronPort-SDR: cuA/kqCtr1mXVxwbcnhhByUY5S2q9JXtBxskxvB0VRjIPI99fWMxzFC9XXQBrSCK2jrgdHZl8f
 Awo8q+hnss3Q==
X-IronPort-AV: E=Sophos;i="5.73,373,1583193600"; 
   d="scan'208";a="30835695"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 May 2020 01:48:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 5290BA2368;
        Sun, 10 May 2020 01:48:17 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 01:48:16 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 01:48:16 +0000
Received: from localhost (10.85.6.121) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 10 May 2020 01:48:15 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v6 3/6] arch/x86/mm: Refactor cond_ibpb() to support other use cases
Date:   Sun, 10 May 2020 11:48:00 +1000
Message-ID: <20200510014803.12190-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510014803.12190-1-sblbir@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cond_ibpb() has the necessary bits required to track the
previous mm in switch_mm_irqs_off(). This can be reused for
other use cases like L1D flushing (on context switch out).

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/tlbflush.h |  2 +-
 arch/x86/mm/tlb.c               | 43 +++++++++++++++++----------------
 2 files changed, 23 insertions(+), 22 deletions(-)

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
index cf81902e6992..10056b8d8f01 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -43,10 +43,11 @@
  */
 
 /*
- * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
- * stored in cpu_tlb_state.last_user_mm_ibpb.
+ * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
 
 /*
  * The x86 feature is called PCID (Process Context IDentifier). It is similar
@@ -345,19 +346,24 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 	}
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
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
@@ -368,8 +374,6 @@ static void cond_ibpb(struct task_struct *next)
 	 * exposed data is not really interesting.
 	 */
 	if (static_branch_likely(&switch_mm_cond_ibpb)) {
-		unsigned long prev_mm, next_mm;
-
 		/*
 		 * This is a bit more complex than the always mode because
 		 * it has to handle two cases:
@@ -399,20 +403,14 @@ static void cond_ibpb(struct task_struct *next)
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
@@ -421,11 +419,12 @@ static void cond_ibpb(struct task_struct *next)
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
@@ -550,8 +549,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * Avoid user/user BTB poisoning by flushing the branch
 		 * predictor when switching between processes. This stops
 		 * one process from doing Spectre-v2 attacks on another.
+		 * The hook can also be used for mitigations that rely
+		 * on switch_mm for hooks.
 		 */
-		cond_ibpb(tsk);
+		cond_mitigation(tsk);
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
@@ -677,7 +678,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_IBPB);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
-- 
2.17.1

