Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C4CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B18420720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fhfH5PNJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GdfD9K69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgGHJvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:51:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGHJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:46 -0400
Date:   Wed, 08 Jul 2020 09:51:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHgMxlkSbEJSf97I5bf8z7K7NgvXEo7/zO2vDV9W4i8=;
        b=fhfH5PNJBzuJ80LikHX7laYP6LD3TaCrbVZBw8jP3c5gOg0N1Xu2wZLQm5CjuQ3fShXpiy
        eaQ6fB9+PL8+++gDcf0Z/um1kUgIpPbF0wAcDpp/ZGo1mZPl8ZY9NxlU+dj18264PHDdDT
        lFDnYkqMO5lEuzVHie023WwHw3bK7EPvLBNzJKD8WYR8rXExt0zP3aoN6xGpBfO4i+MWW6
        uWxxOozQdIIg8cbImHkpBzAH1xZwaypaDUOFzSkHuBpyf9uan4JuNqFL8lfoijKUgrbLju
        mFhFuTehL3aLeSIcrHtoK14IzE2vnrixW9H1ac4fNHKwDK7dU/a43nW/WGxacQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHgMxlkSbEJSf97I5bf8z7K7NgvXEo7/zO2vDV9W4i8=;
        b=GdfD9K69M+8vhiPsoCaylfZy4GPu9+w245CorBVx6721wGLunQSOKpFtQ6PllcRPEqbuzy
        eZOrYl7sqFuwVICw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Support XSAVES for arch LBR read
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-24-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-24-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190283.4006.10798804933769478660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c085fb8774671e83f6199a8e838fbc0e57094029
Gitweb:        https://git.kernel.org/tip/c085fb8774671e83f6199a8e838fbc0e57094029
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:57 +02:00

perf/x86/intel/lbr: Support XSAVES for arch LBR read

Reading LBR registers in a perf NMI handler for a non-PEBS event
causes a high overhead because the number of LBR registers is huge.
To reduce the overhead, the XSAVES instruction should be used to replace
the LBR registers' reading method.

The XSAVES buffer used for LBR read has to be per-CPU because the NMI
handler invoked the lbr_read(). The existing task_ctx_data buffer
cannot be used which is per-task and only be allocated for the LBR call
stack mode. A new lbr_xsave pointer is introduced in the cpu_hw_events
as an XSAVES buffer for LBR read.

The XSAVES buffer should be allocated only when LBR is used by a
non-PEBS event on the CPU because the total size of the lbr_xsave is
not small (~1.4KB).

The XSAVES buffer is allocated when a non-PEBS event is added, but it
is lazily released in x86_release_hardware() when perf releases the
entire PMU hardware resource, because perf may frequently schedule the
event, e.g. high context switch. The lazy release method reduces the
overhead of frequently allocate/free the buffer.

If the lbr_xsave fails to be allocated, roll back to normal Arch LBR
lbr_read().

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/1593780569-62993-24-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  1 +-
 arch/x86/events/intel/lbr.c  | 40 ++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  7 ++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6b1228a..1cbf57d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -358,6 +358,7 @@ void x86_release_hardware(void)
 	if (atomic_dec_and_mutex_lock(&pmc_refcount, &pmc_reserve_mutex)) {
 		release_pmc_hardware();
 		release_ds_buffers();
+		release_lbr_buffers();
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 }
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index cb1a049..63f58bd 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -658,6 +658,7 @@ static inline bool branch_user_callstack(unsigned br_sel)
 
 void intel_pmu_lbr_add(struct perf_event *event)
 {
+	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!x86_pmu.lbr_nr)
@@ -695,6 +696,29 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	perf_sched_cb_inc(event->ctx->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
+
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
+	    kmem_cache && !cpuc->lbr_xsave &&
+	    (cpuc->lbr_users != cpuc->lbr_pebs_users))
+		cpuc->lbr_xsave = kmem_cache_alloc(kmem_cache, GFP_KERNEL);
+}
+
+void release_lbr_buffers(void)
+{
+	struct kmem_cache *kmem_cache = x86_get_pmu()->task_ctx_cache;
+	struct cpu_hw_events *cpuc;
+	int cpu;
+
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+		if (kmem_cache && cpuc->lbr_xsave) {
+			kmem_cache_free(kmem_cache, cpuc->lbr_xsave);
+			cpuc->lbr_xsave = NULL;
+		}
+	}
 }
 
 void intel_pmu_lbr_del(struct perf_event *event)
@@ -945,6 +969,19 @@ static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
 	intel_pmu_store_lbr(cpuc, NULL);
 }
 
+static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
+{
+	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
+
+	if (!xsave) {
+		intel_pmu_store_lbr(cpuc, NULL);
+		return;
+	}
+	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+
+	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+}
+
 void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1767,14 +1804,15 @@ void __init intel_pmu_arch_lbr_init(void)
 		x86_pmu.lbr_ctl_map = NULL;
 
 	x86_pmu.lbr_reset = intel_pmu_arch_lbr_reset;
-	x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
 	if (arch_lbr_xsave) {
 		x86_pmu.lbr_save = intel_pmu_arch_lbr_xsaves;
 		x86_pmu.lbr_restore = intel_pmu_arch_lbr_xrstors;
+		x86_pmu.lbr_read = intel_pmu_arch_lbr_read_xsave;
 		pr_cont("XSAVE ");
 	} else {
 		x86_pmu.lbr_save = intel_pmu_arch_lbr_save;
 		x86_pmu.lbr_restore = intel_pmu_arch_lbr_restore;
+		x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
 	}
 
 	pr_cont("Architectural LBR, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d5e351c..7b68ab5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -253,6 +253,7 @@ struct cpu_hw_events {
 	void				*last_task_ctx;
 	int				last_log_id;
 	int				lbr_select;
+	void				*lbr_xsave;
 
 	/*
 	 * Intel host/guest exclude bits
@@ -1066,6 +1067,8 @@ void release_ds_buffers(void);
 
 void reserve_ds_buffers(void);
 
+void release_lbr_buffers(void);
+
 extern struct event_constraint bts_constraint;
 extern struct event_constraint vlbr_constraint;
 
@@ -1207,6 +1210,10 @@ static inline void release_ds_buffers(void)
 {
 }
 
+static inline void release_lbr_buffers(void)
+{
+}
+
 static inline int intel_pmu_init(void)
 {
 	return 0;
