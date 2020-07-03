Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C1CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E1320B80
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGCMxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:53:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:25743 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgGCMxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:47 -0400
IronPort-SDR: wdDFvE3t8R0yK/5t03JxbcVjnv5zN6vrY1LSoiWo4aZERlPRnKXLsVSgwWw0sUnPe4KyudjEVu
 3r+L6GOaWf9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598402"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598402"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:47 -0700
IronPort-SDR: HahSdZARvUigHrIP+nAJn+bDRIsVuIMJkC1hjRuaYt3RQg/PF7SzGtDef0w5zHafgaD5rqINmP
 AQtcmNqy4lxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265964039"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:46 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 18/23] perf/x86: Remove task_ctx_size
Date:   Fri,  3 Jul 2020 05:49:24 -0700
Message-Id: <1593780569-62993-19-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
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
index d740c86..6b1228a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2371,7 +2371,6 @@ static struct pmu pmu = {
 
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
-	.task_ctx_size          = sizeof(struct x86_perf_task_context),
 	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4fb1be4..ae4d4ab 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1673,7 +1673,6 @@ void __init intel_pmu_arch_lbr_init(void)
 
 	size = sizeof(struct x86_perf_task_context_arch_lbr) +
 	       lbr_nr * sizeof(struct lbr_entry);
-	x86_get_pmu()->task_ctx_size = size;
 	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6769917f..073f716 100644
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
index 03125b0..520386e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1242,15 +1242,13 @@ static void *alloc_task_ctx_data(struct pmu *pmu)
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

