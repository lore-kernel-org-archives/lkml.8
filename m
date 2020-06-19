Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2024BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0429220771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbgFSOI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:54754 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733053AbgFSOIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:08:15 -0400
IronPort-SDR: qHRjxId5GObV0pb3HVZCfG8QR4xD4HKDsubd19lqtLKg+l4ky3O6YjPdALF2LGCjLEsyGjN3+L
 QljAxw9fgACA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452857"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452857"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:58 -0700
IronPort-SDR: /8Y+618efKQYMA2brf0bZVtN3OnmcvtkMBWjElnl4GRny/lbzbqpD+1n3WVabhEh1BmKJJ6x77
 fX8ohHK1zfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837483"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:58 -0700
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
Subject: [PATCH 13/21] perf/core: Factor out functions to allocate/free the task_ctx_data
Date:   Fri, 19 Jun 2020 07:04:01 -0700
Message-Id: <1592575449-64278-14-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
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
index 633b4ae..a9bfe32 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1234,12 +1234,22 @@ static void get_ctx(struct perf_event_context *ctx)
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
 
@@ -4467,7 +4477,7 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		goto errout;
 
 	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
-		task_ctx_data = kzalloc(pmu->task_ctx_size, GFP_KERNEL);
+		task_ctx_data = alloc_task_ctx_data(pmu);
 		if (!task_ctx_data) {
 			err = -ENOMEM;
 			goto errout;
@@ -4525,11 +4535,11 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
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
 
@@ -12406,8 +12416,7 @@ inherit_event(struct perf_event *parent_event,
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

