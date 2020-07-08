Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875DBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6292D20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PzTSEm55";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="65dEmwFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGHJwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgGHJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB9BC08C5DC;
        Wed,  8 Jul 2020 02:51:50 -0700 (PDT)
Date:   Wed, 08 Jul 2020 09:51:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60Mezd46ktMquRB4XcWSZqZMrYevV8VbBsgfhyo6skg=;
        b=PzTSEm55UIYZE1pb4vqWLsBpZ3XoFIBKq5AaXB2AJdTvttJSMkZpjl8QshS5SWXHIVcGTz
        /j4VKeR3N2m1k1jLGUDCbe/fXC2xQFmwLs5JouyxuuNQeiaosuJbp6znkB2QltpSlTJ0uc
        A/k8RofLaVHcoCzyZzBXvPeA92U6rHuVJjUfx+zoIJWnd2RWXxaRHSuzEUxxCQibOplji+
        UNwfF9/HCMfL3xqOMczCpzbSZv25hwN0QdN4P49aBY31MBKUTrV8WsvlEgJhdGh2KrqnVy
        YkpK4ZUqJhYTZ2yunk48rzustQP1D5BsoWaTZBc7QWM0KFKQhm+uExviK8UXaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60Mezd46ktMquRB4XcWSZqZMrYevV8VbBsgfhyo6skg=;
        b=65dEmwFYU0ULU43XXf/lceT3wOeOngqvHdWpQ0JDAkEFo14EvJeqQN1wKnl2VOjINlK70w
        RBME2thJwHDTWrAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Factor out intel_pmu_store_lbr
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-14-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-14-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190885.4006.7883134629976777716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     631618a0dca31dc23dcce38cf345c6139bd8a1e9
Gitweb:        https://git.kernel.org/tip/631618a0dca31dc23dcce38cf345c6139bd8a1e9
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:19 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:54 +02:00

perf/x86/intel/lbr: Factor out intel_pmu_store_lbr

The way to store the LBR information from a PEBS LBR record can be
reused in Architecture LBR, because
- The LBR information is stored like a stack. Entry 0 is always the
  youngest branch.
- The layout of the LBR INFO MSR is similar.

The LBR information may be retrieved from either the LBR registers
(non-PEBS event) or a buffer (PEBS event). Extend rdlbr_*() to support
both methods.

Explicitly check the invalid entry (0s), which can avoid unnecessary MSR
access if using a non-PEBS event. For a PEBS event, the check should
slightly improve the performance as well. The invalid entries are cut.
The intel_pmu_lbr_filter() doesn't need to check and filter them out.

Cannot share the function with current model-specific LBR read, because
the direction of the LBR growth is opposite.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-14-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/lbr.c | 82 ++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index d3d129c..0d7a859 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -348,28 +348,37 @@ static __always_inline void wrlbr_info(unsigned int idx, u64 val)
 	wrmsrl(x86_pmu.lbr_info + idx, val);
 }
 
-static __always_inline u64 rdlbr_from(unsigned int idx)
+static __always_inline u64 rdlbr_from(unsigned int idx, struct lbr_entry *lbr)
 {
 	u64 val;
 
+	if (lbr)
+		return lbr->from;
+
 	rdmsrl(x86_pmu.lbr_from + idx, val);
 
 	return lbr_from_signext_quirk_rd(val);
 }
 
-static __always_inline u64 rdlbr_to(unsigned int idx)
+static __always_inline u64 rdlbr_to(unsigned int idx, struct lbr_entry *lbr)
 {
 	u64 val;
 
+	if (lbr)
+		return lbr->to;
+
 	rdmsrl(x86_pmu.lbr_to + idx, val);
 
 	return val;
 }
 
-static __always_inline u64 rdlbr_info(unsigned int idx)
+static __always_inline u64 rdlbr_info(unsigned int idx, struct lbr_entry *lbr)
 {
 	u64 val;
 
+	if (lbr)
+		return lbr->info;
+
 	rdmsrl(x86_pmu.lbr_info + idx, val);
 
 	return val;
@@ -387,16 +396,16 @@ wrlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
 static inline bool
 rdlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
 {
-	u64 from = rdlbr_from(idx);
+	u64 from = rdlbr_from(idx, NULL);
 
 	/* Don't read invalid entry */
 	if (!from)
 		return false;
 
 	lbr->from = from;
-	lbr->to = rdlbr_to(idx);
+	lbr->to = rdlbr_to(idx, NULL);
 	if (need_info)
-		lbr->info = rdlbr_info(idx);
+		lbr->info = rdlbr_info(idx, NULL);
 
 	return true;
 }
@@ -432,7 +441,7 @@ void intel_pmu_lbr_restore(void *ctx)
 
 static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
 {
-	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos);
+	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos, NULL);
 }
 
 static void __intel_pmu_lbr_restore(void *ctx)
@@ -709,8 +718,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		u16 cycles = 0;
 		int lbr_flags = lbr_desc[lbr_format];
 
-		from = rdlbr_from(lbr_idx);
-		to   = rdlbr_to(lbr_idx);
+		from = rdlbr_from(lbr_idx, NULL);
+		to   = rdlbr_to(lbr_idx, NULL);
 
 		/*
 		 * Read LBR call stack entries
@@ -722,7 +731,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (lbr_format == LBR_FORMAT_INFO && need_info) {
 			u64 info;
 
-			info = rdlbr_info(lbr_idx);
+			info = rdlbr_info(lbr_idx, NULL);
 			mis = !!(info & LBR_INFO_MISPRED);
 			pred = !mis;
 			in_tx = !!(info & LBR_INFO_IN_TX);
@@ -777,6 +786,42 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 	cpuc->lbr_stack.hw_idx = tos;
 }
 
+static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
+				struct lbr_entry *entries)
+{
+	struct perf_branch_entry *e;
+	struct lbr_entry *lbr;
+	u64 from, to, info;
+	int i;
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		lbr = entries ? &entries[i] : NULL;
+		e = &cpuc->lbr_entries[i];
+
+		from = rdlbr_from(i, lbr);
+		/*
+		 * Read LBR entries until invalid entry (0s) is detected.
+		 */
+		if (!from)
+			break;
+
+		to = rdlbr_to(i, lbr);
+		info = rdlbr_info(i, lbr);
+
+		e->from		= from;
+		e->to		= to;
+		e->mispred	= !!(info & LBR_INFO_MISPRED);
+		e->predicted	= !(info & LBR_INFO_MISPRED);
+		e->in_tx	= !!(info & LBR_INFO_IN_TX);
+		e->abort	= !!(info & LBR_INFO_ABORT);
+		e->cycles	= info & LBR_INFO_CYCLES;
+		e->type		= 0;
+		e->reserved	= 0;
+	}
+
+	cpuc->lbr_stack.nr = i;
+}
+
 void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1215,9 +1260,6 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int i;
-
-	cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
 
 	/* Cannot get TOS for large PEBS */
 	if (cpuc->n_pebs == cpuc->n_large_pebs)
@@ -1225,19 +1267,7 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	else
 		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
 
-	for (i = 0; i < x86_pmu.lbr_nr; i++) {
-		u64 info = lbr[i].info;
-		struct perf_branch_entry *e = &cpuc->lbr_entries[i];
-
-		e->from		= lbr[i].from;
-		e->to		= lbr[i].to;
-		e->mispred	= !!(info & LBR_INFO_MISPRED);
-		e->predicted	= !(info & LBR_INFO_MISPRED);
-		e->in_tx	= !!(info & LBR_INFO_IN_TX);
-		e->abort	= !!(info & LBR_INFO_ABORT);
-		e->cycles	= info & LBR_INFO_CYCLES;
-		e->reserved	= 0;
-	}
+	intel_pmu_store_lbr(cpuc, lbr);
 	intel_pmu_lbr_filter(cpuc);
 }
 
