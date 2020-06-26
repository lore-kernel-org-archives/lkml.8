Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D578C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771992100A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgFZSX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:23:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:59760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgFZSXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:41 -0400
IronPort-SDR: 6uvuBbs7rmdjeVmgHhWj5UkKIxBrYv+rdu30EGNEqQY57oV8nY/Ym+3RWCQvWroArfW0+gCYYt
 fWAq+RlFeIOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512936"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512936"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:41 -0700
IronPort-SDR: r+3G0Afc8dbO7Yb6qOAQluUjS+T5zojU8odk+hCqn+FPlvt9QhaCov3dfnAgO0gPnQyG9OcgaU
 AK5QbHx6CkoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153924"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:41 -0700
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
Subject: [PATCH V2 16/23] perf/core: Use kmem_cache to allocate the PMU specific data
Date:   Fri, 26 Jun 2020 11:20:13 -0700
Message-Id: <1593195620-116988-17-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Currently, the PMU specific data task_ctx_data is allocated by the
function kzalloc() in the perf generic code. When there is no specific
alignment requirement for the task_ctx_data, the method works well for
now. However, there will be a problem once a specific alignment
requirement is introduced in future features, e.g., the Architecture LBR
XSAVE feature requires 64-byte alignment. If the specific alignment
requirement is not fulfilled, the XSAVE family of instructions will fail
to save/restore the xstate to/from the task_ctx_data.

The function kzalloc() itself only guarantees a natural alignment. A
new method to allocate the task_ctx_data has to be introduced, which
has to meet the requirements as below:
- must be a generic method can be used by different architectures,
  because the allocation of the task_ctx_data is implemented in the
  perf generic code;
- must be an alignment-guarantee method (The alignment requirement is
  not changed after the boot);
- must be able to allocate/free a buffer (smaller than a page size)
  dynamically;
- should not cause extra CPU overhead or space overhead.

Several options were considered as below:
- One option is to allocate a larger buffer for task_ctx_data. E.g.,
    ptr = kmalloc(size + alignment, GFP_KERNEL);
    ptr &= ~(alignment - 1);
  This option causes space overhead.
- Another option is to allocate the task_ctx_data in the PMU specific
  code. To do so, several function pointers have to be added. As a
  result, both the generic structure and the PMU specific structure
  will become bigger. Besides, extra function calls are added when
  allocating/freeing the buffer. This option will increase both the
  space overhead and CPU overhead.
- The third option is to use a kmem_cache to allocate a buffer for the
  task_ctx_data. The kmem_cache can be created with a specific alignment
  requirement by the PMU at boot time. A new pointer for kmem_cache has
  to be added in the generic struct pmu, which would be used to
  dynamically allocate a buffer for the task_ctx_data at run time.
  Although the new pointer is added to the struct pmu, the existing
  variable task_ctx_size is not required anymore. The size of the
  generic structure is kept the same.

The third option which meets all the aforementioned requirements is used
to replace kzalloc() for the PMU specific data allocation. A later patch
will remove the kzalloc() method and the related variables.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h | 5 +++++
 kernel/events/core.c       | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 46fe5cf..09915ae 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -425,6 +425,11 @@ struct pmu {
 	size_t				task_ctx_size;
 
 	/*
+	 * Kmem cache of PMU specific data
+	 */
+	struct kmem_cache		*task_ctx_cache;
+
+	/*
 	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
 	 * can be synchronized using this function. See Intel LBR callstack support
 	 * implementation and Perf core context switch handling callbacks for usage
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7509040..30d9b31 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1240,12 +1240,18 @@ static void get_ctx(struct perf_event_context *ctx)
 
 static void *alloc_task_ctx_data(struct pmu *pmu)
 {
+	if (pmu->task_ctx_cache)
+		return kmem_cache_zalloc(pmu->task_ctx_cache, GFP_KERNEL);
+
 	return kzalloc(pmu->task_ctx_size, GFP_KERNEL);
 }
 
 static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
 {
-	kfree(task_ctx_data);
+	if (pmu->task_ctx_cache && task_ctx_data)
+		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
+	else
+		kfree(task_ctx_data);
 }
 
 static void free_ctx(struct rcu_head *head)
-- 
2.7.4

