Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894EBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775CC20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgFZSXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:23:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:59781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgFZSXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:41 -0400
IronPort-SDR: 8CbBYPFPAMxgMTuCl9rAIYWI9HRAxjFQb/wO3LDNotwVB49sB2T0jxM3gwaEovDtcIj4p0gGOI
 9n7PfmfRosnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512932"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512932"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:40 -0700
IronPort-SDR: erpCnGO862BPHhBxPMZjCWic92SIO0vieqrIVWN1Kj1j75kAKk/xPq9N0B2WIAT01BZUnROSkk
 C2hG77+znkjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153919"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:40 -0700
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
Subject: [PATCH V2 15/23] perf/core: Factor out functions to allocate/free the task_ctx_data
Date:   Fri, 26 Jun 2020 11:20:12 -0700
Message-Id: <1593195620-116988-16-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The method to allocate/free the task_ctx_data is going to be changed in
the following patch. Currently, the task_ctx_data is allocated/freed in
several different places. To avoid repeatedly modifying the same codes
in several different places, alloc_task_ctx_data() and
free_task_ctx_data() are factored out to allocate/free the
task_ctx_data. The modification only needs to be applied once.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9b8f925..7509040 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1238,12 +1238,22 @@ static void get_ctx(struct perf_event_context *ctx)
 	refcount_inc(&ctx->refcount);
 }
 
+static void *alloc_task_ctx_data(struct pmu *pmu)
+{
+	return kzalloc(pmu->task_ctx_size, GFP_KERNEL);
+}
+
+static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
+{
+	kfree(task_ctx_data);
+}
+
 static void free_ctx(struct rcu_head *head)
 {
 	struct perf_event_context *ctx;
 
 	ctx = container_of(head, struct perf_event_context, rcu_head);
-	kfree(ctx->task_ctx_data);
+	free_task_ctx_data(ctx->pmu, ctx->task_ctx_data);
 	kfree(ctx);
 }
 
@@ -4471,7 +4481,7 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		goto errout;
 
 	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
-		task_ctx_data = kzalloc(pmu->task_ctx_size, GFP_KERNEL);
+		task_ctx_data = alloc_task_ctx_data(pmu);
 		if (!task_ctx_data) {
 			err = -ENOMEM;
 			goto errout;
@@ -4529,11 +4539,11 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		}
 	}
 
-	kfree(task_ctx_data);
+	free_task_ctx_data(pmu, task_ctx_data);
 	return ctx;
 
 errout:
-	kfree(task_ctx_data);
+	free_task_ctx_data(pmu, task_ctx_data);
 	return ERR_PTR(err);
 }
 
@@ -12497,8 +12507,7 @@ inherit_event(struct perf_event *parent_event,
 	    !child_ctx->task_ctx_data) {
 		struct pmu *pmu = child_event->pmu;
 
-		child_ctx->task_ctx_data = kzalloc(pmu->task_ctx_size,
-						   GFP_KERNEL);
+		child_ctx->task_ctx_data = alloc_task_ctx_data(pmu);
 		if (!child_ctx->task_ctx_data) {
 			free_event(child_event);
 			return ERR_PTR(-ENOMEM);
-- 
2.7.4

