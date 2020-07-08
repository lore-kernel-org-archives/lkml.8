Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E61C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC16620775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xbH8dE5j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gl6dvV6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgGHJwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgGHJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:54 -0400
Date:   Wed, 08 Jul 2020 09:51:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1iSalFTrDw3ZKuyvXG//lzZKJHHIcGTU4xMZYFFC1rg=;
        b=xbH8dE5je3t91RXzoOhD5UXwyUFxKXeQwgdYbVKrBYmvrr2FdZjiwn5oEhItj1+sIxDY/a
        /gfhZkGsZUoZSigZkR3Iblis1QyzkfcTSSG6lKKdUeuO4QIUMudDd/epjroGOtGKyU6MKo
        rh9IZ64eO3vXQ3Ut1gJUEm/FQceXLqrs/277KgrXrmXwTO8KMW2OZGZwK+YutBoIPEttQS
        2r8jI/zkPPM1aFmhTDhBjJscXHF7js4mhW1OPF9AOvbF+CipmGWd4envdfMi5efytLI/Lq
        SDjVTF5rq9Tkzb88a3F+VzgboGBYtdVKRghuYCSCovLZQVwJr4LnmQHDmjJMlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1iSalFTrDw3ZKuyvXG//lzZKJHHIcGTU4xMZYFFC1rg=;
        b=gl6dvV6kBzU9HokbSv9taL02fzFYDML4EvyCFJEgs2tqb6HAhofJbabWlPgWXT7mKNujGl
        9tCZTbYjZE6BXSDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Unify the stored format of LBR
 information
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-11-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-11-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191062.4006.3064418714677249662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5624986dc61b81a77fb6136bc232593483d1c254
Gitweb:        https://git.kernel.org/tip/5624986dc61b81a77fb6136bc232593483d1c254
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:53 +02:00

perf/x86/intel/lbr: Unify the stored format of LBR information

Current LBR information in the structure x86_perf_task_context is stored
in a different format from the PEBS LBR record and Architecture LBR,
which prevents the sharing of the common codes.

Use the format of the PEBS LBR record as a unified format. Use a generic
name lbr_entry to replace pebs_lbr_entry.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-11-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c        |  6 +++---
 arch/x86/events/intel/lbr.c       | 20 ++++++++++----------
 arch/x86/events/perf_event.h      |  6 ++----
 arch/x86/include/asm/perf_event.h |  6 +-----
 4 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index dc43cc1..86848c5 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -954,7 +954,7 @@ static void adaptive_pebs_record_size_update(void)
 	if (pebs_data_cfg & PEBS_DATACFG_XMMS)
 		sz += sizeof(struct pebs_xmm);
 	if (pebs_data_cfg & PEBS_DATACFG_LBRS)
-		sz += x86_pmu.lbr_nr * sizeof(struct pebs_lbr_entry);
+		sz += x86_pmu.lbr_nr * sizeof(struct lbr_entry);
 
 	cpuc->pebs_record_size = sz;
 }
@@ -1595,10 +1595,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	}
 
 	if (format_size & PEBS_DATACFG_LBRS) {
-		struct pebs_lbr *lbr = next_record;
+		struct lbr_entry *lbr = next_record;
 		int num_lbr = ((format_size >> PEBS_DATACFG_LBR_SHIFT)
 					& 0xff) + 1;
-		next_record = next_record + num_lbr*sizeof(struct pebs_lbr_entry);
+		next_record = next_record + num_lbr * sizeof(struct lbr_entry);
 
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7742562..b8baaf1 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -372,11 +372,11 @@ void intel_pmu_lbr_restore(void *ctx)
 	mask = x86_pmu.lbr_nr - 1;
 	for (i = 0; i < task_ctx->valid_lbrs; i++) {
 		lbr_idx = (tos - i) & mask;
-		wrlbr_from(lbr_idx, task_ctx->lbr_from[i]);
-		wrlbr_to  (lbr_idx, task_ctx->lbr_to[i]);
+		wrlbr_from(lbr_idx, task_ctx->lbr[i].from);
+		wrlbr_to(lbr_idx, task_ctx->lbr[i].to);
 
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
+			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr[i].info);
 	}
 
 	for (; i < x86_pmu.lbr_nr; i++) {
@@ -440,10 +440,10 @@ void intel_pmu_lbr_save(void *ctx)
 		from = rdlbr_from(lbr_idx);
 		if (!from)
 			break;
-		task_ctx->lbr_from[i] = from;
-		task_ctx->lbr_to[i]   = rdlbr_to(lbr_idx);
+		task_ctx->lbr[i].from = from;
+		task_ctx->lbr[i].to = rdlbr_to(lbr_idx);
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
+			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr[i].info);
 	}
 	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
@@ -1179,7 +1179,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	}
 }
 
-void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
+void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int i;
@@ -1193,11 +1193,11 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
-		u64 info = lbr->lbr[i].info;
+		u64 info = lbr[i].info;
 		struct perf_branch_entry *e = &cpuc->lbr_entries[i];
 
-		e->from		= lbr->lbr[i].from;
-		e->to		= lbr->lbr[i].to;
+		e->from		= lbr[i].from;
+		e->to		= lbr[i].to;
 		e->mispred	= !!(info & LBR_INFO_MISPRED);
 		e->predicted	= !(info & LBR_INFO_MISPRED);
 		e->in_tx	= !!(info & LBR_INFO_IN_TX);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ba89e56..aaa426d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -765,13 +765,11 @@ struct x86_perf_task_context_opt {
 };
 
 struct x86_perf_task_context {
-	u64 lbr_from[MAX_LBR_ENTRIES];
-	u64 lbr_to[MAX_LBR_ENTRIES];
-	u64 lbr_info[MAX_LBR_ENTRIES];
 	u64 lbr_sel;
 	int tos;
 	int valid_lbrs;
 	struct x86_perf_task_context_opt opt;
+	struct lbr_entry lbr[MAX_LBR_ENTRIES];
 };
 
 #define x86_add_quirk(func_)						\
@@ -1092,7 +1090,7 @@ void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in);
 
 void intel_pmu_auto_reload_read(struct perf_event *event);
 
-void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr);
+void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_ds_init(void);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 9ffce7d..2e29558 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -282,14 +282,10 @@ struct pebs_xmm {
 	u64 xmm[16*2];	/* two entries for each register */
 };
 
-struct pebs_lbr_entry {
+struct lbr_entry {
 	u64 from, to, info;
 };
 
-struct pebs_lbr {
-	struct pebs_lbr_entry lbr[0]; /* Variable length */
-};
-
 /*
  * IBS cpuid feature detection
  */
