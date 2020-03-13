Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCBAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617FA2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCMSfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:35:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:28646 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbgCMSek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:34:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 11:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="442506107"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 11:34:39 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 10/17] perf tools: Save previous sample for LBR stitching approach
Date:   Fri, 13 Mar 2020 11:33:12 -0700
Message-Id: <20200313183319.17739-11-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313183319.17739-1-kan.liang@linux.intel.com>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To retrieve the overwritten LBRs from previous sample for LBR stitching
approach, perf has to save the previous sample.

Only allocate the struct lbr_stitch once, when LBR stitching approach
is enabled and kernel supports hw_idx.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/machine.c | 23 +++++++++++++++++++++++
 tools/perf/util/thread.c  |  1 +
 tools/perf/util/thread.h  | 16 ++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f1661dd3ca69..d91e11bfc8ca 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2261,6 +2261,21 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	return 0;
 }
 
+static bool alloc_lbr_stitch(struct thread *thread)
+{
+	if (thread->lbr_stitch)
+		return true;
+
+	thread->lbr_stitch = calloc(1, sizeof(struct lbr_stitch));
+	if (!thread->lbr_stitch)
+		goto err;
+
+err:
+	pr_warning("Failed to allocate space for stitched LBRs. Disable LBR stitch\n");
+	thread->lbr_stitch_enable = false;
+	return false;
+}
+
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2277,6 +2292,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 {
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
+	struct lbr_stitch *lbr_stitch;
 	u64 branch_from = 0;
 	int err;
 
@@ -2289,6 +2305,13 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	if (i == chain_nr)
 		return 0;
 
+	if (thread->lbr_stitch_enable && !sample->no_hw_idx &&
+	    alloc_lbr_stitch(thread)) {
+		lbr_stitch = thread->lbr_stitch;
+
+		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
+	}
+
 	if (callchain_param.order == ORDER_CALLEE) {
 		/* Add kernel ip */
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 1f080db23615..8d0da260c84c 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -111,6 +111,7 @@ void thread__delete(struct thread *thread)
 
 	exit_rwsem(&thread->namespaces_lock);
 	exit_rwsem(&thread->comm_lock);
+	thread__free_stitch_list(thread);
 	free(thread);
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 95294050cff2..5fe239bd8f17 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -13,6 +13,7 @@
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
+#include "event.h"
 
 struct addr_location;
 struct map;
@@ -20,6 +21,10 @@ struct perf_record_namespaces;
 struct thread_stack;
 struct unwind_libunwind_ops;
 
+struct lbr_stitch {
+	struct perf_sample		prev_sample;
+};
+
 struct thread {
 	union {
 		struct rb_node	 rb_node;
@@ -49,6 +54,7 @@ struct thread {
 
 	/* LBR call stack stitch */
 	bool			lbr_stitch_enable;
+	struct lbr_stitch	*lbr_stitch;
 };
 
 struct machine;
@@ -145,4 +151,14 @@ static inline bool thread__is_filtered(struct thread *thread)
 	return false;
 }
 
+static inline void thread__free_stitch_list(struct thread *thread)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+
+	if (!lbr_stitch)
+		return;
+
+	free(thread->lbr_stitch);
+}
+
 #endif	/* __PERF_THREAD_H */
-- 
2.17.1

