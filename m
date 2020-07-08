Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB24AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A860D20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qXU+jKwQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q1fv93+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgGHJw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgGHJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:57 -0400
Date:   Wed, 08 Jul 2020 09:51:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gr+j26DxdOrDysitakG8589IVHPGgKZDR0aXeIRtcgI=;
        b=qXU+jKwQu+Jy9wjhNYwLM6YbN/Cln3ctk4hdUt8VuumM1z4qamwyo5/QdGj1REmVJT5oc1
        kprOTCvz7VSj0QZ7pJKW39ozjQ2PNHo+ENczmnITa1V0MOP7YbHDvK6r3Vamk0ooL0xkUo
        9u2qk1sEnUDETTgcShrjZSBZj0GZAxB1+n28eAK17ISYvTQdJ0Nu4O1ZRbdI6S30MBmLiH
        Lr+ZUX0H97YMBlejZmdqpYDtbrk3vW7kTCbaDPQNPco1Tr/a4w4zD2R3Uf/7Wx3Fr+m4gz
        jYG3BEVez5ZNj97YGHE0hML9Li9DZBaBxeEak4ODS8WUvJv1LCBY+4MShXTqGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gr+j26DxdOrDysitakG8589IVHPGgKZDR0aXeIRtcgI=;
        b=q1fv93+Vymmm3f2JhfiP0LMzdxeMdOuCtp85amk+bfvy1CQRSGjHGxL5t3/AU8DP0dlx50
        5sWW0iE69tohlqDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Add the function pointers for
 LBR save and restore
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-5-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191412.4006.8926426477159396711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     799571bf38fc2b4b744fa448184b5915739b10fd
Gitweb:        https://git.kernel.org/tip/799571bf38fc2b4b744fa448184b5915739b10fd
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:10 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:52 +02:00

perf/x86/intel/lbr: Add the function pointers for LBR save and restore

The MSRs of Architectural LBR are different from previous model-specific
LBR. Perf has to implement different functions to save and restore them.

The function pointers for LBR save and restore are introduced. Perf
should initialize the corresponding functions at boot time.

The generic optimizations, e.g. avoiding restore LBR if no one else
touched them, still apply for Architectural LBRs. The related codes are
not moved to model-specific functions.

Current model-specific LBR functions are set as default.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-5-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c |  4 ++-
 arch/x86/events/intel/lbr.c  | 79 +++++++++++++++++++++--------------
 arch/x86/events/perf_event.h |  6 +++-
 3 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6414b47..50cb3c6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3981,6 +3981,8 @@ static __initconst const struct x86_pmu core_pmu = {
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
 	.lbr_read		= intel_pmu_lbr_read_64,
+	.lbr_save		= intel_pmu_lbr_save,
+	.lbr_restore		= intel_pmu_lbr_restore,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -4029,6 +4031,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
 	.lbr_read		= intel_pmu_lbr_read_64,
+	.lbr_save		= intel_pmu_lbr_save,
+	.lbr_restore		= intel_pmu_lbr_restore,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b8943f4..b2b8dc9 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -323,31 +323,13 @@ static inline u64 rdlbr_to(unsigned int idx)
 	return val;
 }
 
-static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
+void intel_pmu_lbr_restore(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct x86_perf_task_context *task_ctx = ctx;
 	int i;
 	unsigned lbr_idx, mask;
-	u64 tos;
-
-	if (task_ctx->lbr_callstack_users == 0 ||
-	    task_ctx->lbr_stack_state == LBR_NONE) {
-		intel_pmu_lbr_reset();
-		return;
-	}
-
-	tos = task_ctx->tos;
-	/*
-	 * Does not restore the LBR registers, if
-	 * - No one else touched them, and
-	 * - Did not enter C6
-	 */
-	if ((task_ctx == cpuc->last_task_ctx) &&
-	    (task_ctx->log_id == cpuc->last_log_id) &&
-	    rdlbr_from(tos)) {
-		task_ctx->lbr_stack_state = LBR_NONE;
-		return;
-	}
+	u64 tos = task_ctx->tos;
 
 	mask = x86_pmu.lbr_nr - 1;
 	for (i = 0; i < task_ctx->valid_lbrs; i++) {
@@ -368,24 +350,48 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 	}
 
 	wrmsrl(x86_pmu.lbr_tos, tos);
-	task_ctx->lbr_stack_state = LBR_NONE;
 
 	if (cpuc->lbr_select)
 		wrmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
-static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
+static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	unsigned lbr_idx, mask;
-	u64 tos, from;
-	int i;
+	u64 tos;
 
-	if (task_ctx->lbr_callstack_users == 0) {
+	if (task_ctx->lbr_callstack_users == 0 ||
+	    task_ctx->lbr_stack_state == LBR_NONE) {
+		intel_pmu_lbr_reset();
+		return;
+	}
+
+	tos = task_ctx->tos;
+	/*
+	 * Does not restore the LBR registers, if
+	 * - No one else touched them, and
+	 * - Did not enter C6
+	 */
+	if ((task_ctx == cpuc->last_task_ctx) &&
+	    (task_ctx->log_id == cpuc->last_log_id) &&
+	    rdlbr_from(tos)) {
 		task_ctx->lbr_stack_state = LBR_NONE;
 		return;
 	}
 
+	x86_pmu.lbr_restore(task_ctx);
+
+	task_ctx->lbr_stack_state = LBR_NONE;
+}
+
+void intel_pmu_lbr_save(void *ctx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct x86_perf_task_context *task_ctx = ctx;
+	unsigned lbr_idx, mask;
+	u64 tos, from;
+	int i;
+
 	mask = x86_pmu.lbr_nr - 1;
 	tos = intel_pmu_lbr_tos();
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
@@ -400,13 +406,26 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	}
 	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
+
+	if (cpuc->lbr_select)
+		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
+}
+
+static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (task_ctx->lbr_callstack_users == 0) {
+		task_ctx->lbr_stack_state = LBR_NONE;
+		return;
+	}
+
+	x86_pmu.lbr_save(task_ctx);
+
 	task_ctx->lbr_stack_state = LBR_VALID;
 
 	cpuc->last_task_ctx = task_ctx;
 	cpuc->last_log_id = ++task_ctx->log_id;
-
-	if (cpuc->lbr_select)
-		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 312d27f..6d11813 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -695,6 +695,8 @@ struct x86_pmu {
 
 	void		(*lbr_reset)(void);
 	void		(*lbr_read)(struct cpu_hw_events *cpuc);
+	void		(*lbr_save)(void *ctx);
+	void		(*lbr_restore)(void *ctx);
 
 	/*
 	 * Intel PT/LBR/BTS are exclusive
@@ -1090,6 +1092,10 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
 
 void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc);
 
+void intel_pmu_lbr_save(void *ctx);
+
+void intel_pmu_lbr_restore(void *ctx);
+
 void intel_pmu_lbr_init_core(void);
 
 void intel_pmu_lbr_init_nhm(void);
