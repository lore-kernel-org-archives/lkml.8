Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735BDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473652088E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="po7Dt3Pr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B2OLE4wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgGHJv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:51:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbgGHJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:52 -0400
Date:   Wed, 08 Jul 2020 09:51:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ub6lVeNU6kxx9i8CuVM+1lEDMtGGDSiUtFP/a8xpms0=;
        b=po7Dt3Pr+Mozu7NOWn7AQAZyGkoGtjDmu4G1TXVvQNkk25NZViSiMEYjpWVvVsU1Phvcdk
        eetR/lIwjI9RGUj8KwVK397EaKCZWcMf4F+s7dV48mrI4Tyxf3q4fvNwxq+1vZcHs4HVsG
        VhuNCkHBHl6PP8e0cf/s0uwI5IpSbSaaeEJOVPVJNlPS/caNKm3AiYwFmISmvmUGyqwKK1
        mBUeGuEa3pcgaudz6dCv1dAZXGX2Ufow1CbBaG3bl/0XjgKFc3/kTw+D8BedsUXGEqMP5V
        9tiemYLbSBEsBgZQ2wdbL6k+nDocBeiUpzggmvwVJbLhnUkCJ8aVMoDH6jsbvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ub6lVeNU6kxx9i8CuVM+1lEDMtGGDSiUtFP/a8xpms0=;
        b=B2OLE4wHAr/AbGg1jt33V3KSyfujmSySTJ5u1yLZggegxNBF+RfcnO6T4NYNfV7GNj+3qW
        LiGD+7NkRX4DyeBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Factor out rdlbr_all() and wrlbr_all()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-13-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-13-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190945.4006.11664320269777950684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fda1f99f34a8f0975086bcfef34da865009995c1
Gitweb:        https://git.kernel.org/tip/fda1f99f34a8f0975086bcfef34da865009995c1
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:18 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:54 +02:00

perf/x86/intel/lbr: Factor out rdlbr_all() and wrlbr_all()

The previous model-specific LBR and Architecture LBR (legacy way) use a
similar method to save/restore the LBR information, which directly
accesses the LBR registers. The codes which read/write a set of LBR
registers can be shared between them.

Factor out two functions which are used to read/write a set of LBR
registers.

Add lbr_info into structure x86_pmu, and use it to replace the hardcoded
LBR INFO MSR, because the LBR INFO MSR address of the previous
model-specific LBR is different from Architecture LBR. The MSR address
should be assigned at boot time. For now, only Sky Lake and later
platforms have the LBR INFO MSR.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-13-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/lbr.c  | 66 ++++++++++++++++++++++++++---------
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 21f4f07..d3d129c 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -237,7 +237,7 @@ void intel_pmu_lbr_reset_64(void)
 		wrmsrl(x86_pmu.lbr_from + i, 0);
 		wrmsrl(x86_pmu.lbr_to   + i, 0);
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + i, 0);
+			wrmsrl(x86_pmu.lbr_info + i, 0);
 	}
 }
 
@@ -343,6 +343,11 @@ static __always_inline void wrlbr_to(unsigned int idx, u64 val)
 	wrmsrl(x86_pmu.lbr_to + idx, val);
 }
 
+static __always_inline void wrlbr_info(unsigned int idx, u64 val)
+{
+	wrmsrl(x86_pmu.lbr_info + idx, val);
+}
+
 static __always_inline u64 rdlbr_from(unsigned int idx)
 {
 	u64 val;
@@ -361,8 +366,44 @@ static __always_inline u64 rdlbr_to(unsigned int idx)
 	return val;
 }
 
+static __always_inline u64 rdlbr_info(unsigned int idx)
+{
+	u64 val;
+
+	rdmsrl(x86_pmu.lbr_info + idx, val);
+
+	return val;
+}
+
+static inline void
+wrlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
+{
+	wrlbr_from(idx, lbr->from);
+	wrlbr_to(idx, lbr->to);
+	if (need_info)
+		wrlbr_info(idx, lbr->info);
+}
+
+static inline bool
+rdlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
+{
+	u64 from = rdlbr_from(idx);
+
+	/* Don't read invalid entry */
+	if (!from)
+		return false;
+
+	lbr->from = from;
+	lbr->to = rdlbr_to(idx);
+	if (need_info)
+		lbr->info = rdlbr_info(idx);
+
+	return true;
+}
+
 void intel_pmu_lbr_restore(void *ctx)
 {
+	bool need_info = x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx = ctx;
 	int i;
@@ -372,11 +413,7 @@ void intel_pmu_lbr_restore(void *ctx)
 	mask = x86_pmu.lbr_nr - 1;
 	for (i = 0; i < task_ctx->valid_lbrs; i++) {
 		lbr_idx = (tos - i) & mask;
-		wrlbr_from(lbr_idx, task_ctx->lbr[i].from);
-		wrlbr_to(lbr_idx, task_ctx->lbr[i].to);
-
-		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr[i].info);
+		wrlbr_all(&task_ctx->lbr[i], lbr_idx, need_info);
 	}
 
 	for (; i < x86_pmu.lbr_nr; i++) {
@@ -384,7 +421,7 @@ void intel_pmu_lbr_restore(void *ctx)
 		wrlbr_from(lbr_idx, 0);
 		wrlbr_to(lbr_idx, 0);
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, 0);
+			wrlbr_info(lbr_idx, 0);
 	}
 
 	wrmsrl(x86_pmu.lbr_tos, tos);
@@ -427,23 +464,19 @@ static void __intel_pmu_lbr_restore(void *ctx)
 
 void intel_pmu_lbr_save(void *ctx)
 {
+	bool need_info = x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx = ctx;
 	unsigned lbr_idx, mask;
-	u64 tos, from;
+	u64 tos;
 	int i;
 
 	mask = x86_pmu.lbr_nr - 1;
 	tos = intel_pmu_lbr_tos();
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		lbr_idx = (tos - i) & mask;
-		from = rdlbr_from(lbr_idx);
-		if (!from)
+		if (!rdlbr_all(&task_ctx->lbr[i], lbr_idx, need_info))
 			break;
-		task_ctx->lbr[i].from = from;
-		task_ctx->lbr[i].to = rdlbr_to(lbr_idx);
-		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr[i].info);
 	}
 	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
@@ -689,7 +722,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (lbr_format == LBR_FORMAT_INFO && need_info) {
 			u64 info;
 
-			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, info);
+			info = rdlbr_info(lbr_idx);
 			mis = !!(info & LBR_INFO_MISPRED);
 			pred = !mis;
 			in_tx = !!(info & LBR_INFO_IN_TX);
@@ -1336,6 +1369,7 @@ __init void intel_pmu_lbr_init_skl(void)
 	x86_pmu.lbr_tos	 = MSR_LBR_TOS;
 	x86_pmu.lbr_from = MSR_LBR_NHM_FROM;
 	x86_pmu.lbr_to   = MSR_LBR_NHM_TO;
+	x86_pmu.lbr_info = MSR_LBR_INFO_0;
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
@@ -1421,7 +1455,7 @@ int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 	lbr->nr = x86_pmu.lbr_nr;
 	lbr->from = x86_pmu.lbr_from;
 	lbr->to = x86_pmu.lbr_to;
-	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? MSR_LBR_INFO_0 : 0;
+	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
 
 	return 0;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index aaa426d..20e35cb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -690,7 +690,7 @@ struct x86_pmu {
 	 * Intel LBR
 	 */
 	unsigned int	lbr_tos, lbr_from, lbr_to,
-			lbr_nr;			   /* LBR base regs and size */
+			lbr_info, lbr_nr;	   /* LBR base regs and size */
 	union {
 		u64	lbr_sel_mask;		   /* LBR_SELECT valid bits */
 		u64	lbr_ctl_mask;		   /* LBR_CTL valid bits */
