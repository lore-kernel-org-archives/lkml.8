Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A944C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9CE207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbgFSOId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:54764 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733082AbgFSOIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:08:18 -0400
IronPort-SDR: 5keWf18pJnV+5fk91FX1Sap9OVW+znW3OVfAjbZVgZE5NKfH4CnxDQYx1NYkeQ+881BprV/8tq
 cY1qWS2kWCFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452866"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:08:02 -0700
IronPort-SDR: zNBIgavjEZzt33pdZHTsaELlnjH1Hi3KHCMhs4xXrorVIqBtjPNb41bjbs8oCnHeyprHUd06mQ
 pvUNc8ACxt7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837510"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:08:01 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 16/21] perf/x86: Remove task_ctx_size
Date:   Fri, 19 Jun 2020 07:04:04 -0700
Message-Id: <1592575449-64278-17-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A new kmem_cache method has replaced the kzalloc() to allocate the PMU
specific data. The task_ctx_size is not required anymore.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c      | 1 -
 arch/x86/events/intel/lbr.c | 1 -
 include/linux/perf_event.h  | 4 ----
 kernel/events/core.c        | 4 +---
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a619763..aeb6e6d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2364,7 +2364,6 @@ static struct pmu pmu = {
 
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
-	.task_ctx_size          = sizeof(struct x86_perf_task_context),
 	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 28f0d41..4060d3a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1662,7 +1662,6 @@ void __init intel_pmu_arch_lbr_init(void)
 
 	size = sizeof(struct x86_perf_task_context_arch_lbr) +
 	       lbr_nr * sizeof(struct x86_perf_arch_lbr_entry);
-	x86_get_pmu()->task_ctx_size = size;
 	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ef6440f..dd6f3a8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -419,10 +419,6 @@ struct pmu {
 	 */
 	void (*sched_task)		(struct perf_event_context *ctx,
 					bool sched_in);
-	/*
-	 * PMU specific data size
-	 */
-	size_t				task_ctx_size;
 
 	/*
 	 * Kmem cache of PMU specific data
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 165b79b..9800e99 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1239,15 +1239,13 @@ static void *alloc_task_ctx_data(struct pmu *pmu)
 	if (pmu->task_ctx_cache)
 		return kmem_cache_zalloc(pmu->task_ctx_cache, GFP_KERNEL);
 
-	return kzalloc(pmu->task_ctx_size, GFP_KERNEL);
+	return NULL;
 }
 
 static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
 {
 	if (pmu->task_ctx_cache && task_ctx_data)
 		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
-	else
-		kfree(task_ctx_data);
 }
 
 static void free_ctx(struct rcu_head *head)
-- 
2.7.4

