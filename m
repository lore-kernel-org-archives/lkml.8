Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A05FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB7B2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCMSer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:34:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:28647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgCMSen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:34:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 11:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="442506114"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 11:34:42 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 12/17] perf tools: Stitch LBR call stack
Date:   Fri, 13 Mar 2020 11:33:14 -0700
Message-Id: <20200313183319.17739-13-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313183319.17739-1-kan.liang@linux.intel.com>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In LBR call stack mode, the depth of reconstructed LBR call stack limits
to the number of LBR registers.

  For example, on skylake, the depth of reconstructed LBR call stack is
  always <= 32.

  # To display the perf.data header info, please use
  # --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles'
  # Event count (approx.): 6487119731
  #
  # Children      Self  Command          Shared Object       Symbol
  # ........  ........  ...............  ..................
  # ................................

    99.97%    99.97%  tchain_edit      tchain_edit        [.] f43
            |
             --99.64%--f11
                       f12
                       f13
                       f14
                       f15
                       f16
                       f17
                       f18
                       f19
                       f20
                       f21
                       f22
                       f23
                       f24
                       f25
                       f26
                       f27
                       f28
                       f29
                       f30
                       f31
                       f32
                       f33
                       f34
                       f35
                       f36
                       f37
                       f38
                       f39
                       f40
                       f41
                       f42
                       f43

For a call stack which is deeper than LBR limit, HW will overwrite the
LBR register with oldest branch. Only partial call stacks can be
reconstructed.

However, the overwritten LBRs may still be retrieved from previous
sample. At that moment, HW hasn't overwritten the LBR registers yet.
Perf tools can stitch those overwritten LBRs on current call stacks to
get a more complete call stack.

To determine if LBRs can be stitched, perf tools need to compare current
sample with previous sample.
- They should have identical LBR records (Same from, to and flags
  values, and the same physical index of LBR registers).
- The searching starts from the base-of-stack of current sample.

Once perf determines to stitch the previous LBRs, the corresponding LBR
cursor nodes will be copied to 'lists'.
The 'lists' is to track the LBR cursor nodes which are going to be
stitched.
When the stitching is over, the nodes will not be freed immediately.
They will be moved to 'free_lists'. Next stitching may reuse the space.
Both 'lists' and 'free_lists' will be freed when all samples are
processed.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/branch.h    |  19 +++--
 tools/perf/util/callchain.h |   5 ++
 tools/perf/util/machine.c   | 139 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/thread.h    |  13 ++++
 4 files changed, 168 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 154a05cd03af..4d3f02fa223d 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -15,13 +15,18 @@
 #include "event.h"
 
 struct branch_flags {
-	u64 mispred:1;
-	u64 predicted:1;
-	u64 in_tx:1;
-	u64 abort:1;
-	u64 cycles:16;
-	u64 type:4;
-	u64 reserved:40;
+	union {
+		u64 value;
+		struct {
+			u64 mispred:1;
+			u64 predicted:1;
+			u64 in_tx:1;
+			u64 abort:1;
+			u64 cycles:16;
+			u64 type:4;
+			u64 reserved:40;
+		};
+	};
 };
 
 struct branch_info {
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index cb33cd42ff43..8f668ee29f25 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -154,6 +154,11 @@ struct callchain_cursor_node {
 	struct callchain_cursor_node	*next;
 };
 
+struct stitch_list {
+	struct list_head		node;
+	struct callchain_cursor_node	cursor;
+};
+
 struct callchain_cursor {
 	u64				nr;
 	struct callchain_cursor_node	*first;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f190265a1f26..4d4df1f3c066 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2317,6 +2317,119 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	return 0;
 }
 
+static int lbr_callchain_add_stitched_lbr_ip(struct thread *thread,
+					     struct callchain_cursor *cursor)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+	struct callchain_cursor_node *cnode;
+	struct stitch_list *stitch_node;
+	int err;
+
+	list_for_each_entry(stitch_node, &lbr_stitch->lists, node) {
+		cnode = &stitch_node->cursor;
+
+		err = callchain_cursor_append(cursor, cnode->ip,
+					      &cnode->ms,
+					      cnode->branch,
+					      &cnode->branch_flags,
+					      cnode->nr_loop_iter,
+					      cnode->iter_cycles,
+					      cnode->branch_from,
+					      cnode->srcline);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static struct stitch_list *get_stitch_node(struct thread *thread)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+	struct stitch_list *stitch_node;
+
+	if (!list_empty(&lbr_stitch->free_lists)) {
+		stitch_node = list_first_entry(&lbr_stitch->free_lists,
+					       struct stitch_list, node);
+		list_del(&stitch_node->node);
+
+		return stitch_node;
+	}
+
+	return malloc(sizeof(struct stitch_list));
+}
+
+static bool has_stitched_lbr(struct thread *thread,
+			     struct perf_sample *cur,
+			     struct perf_sample *prev,
+			     unsigned int max_lbr,
+			     bool callee)
+{
+	struct branch_stack *cur_stack = cur->branch_stack;
+	struct branch_entry *cur_entries = perf_sample__branch_entries(cur);
+	struct branch_stack *prev_stack = prev->branch_stack;
+	struct branch_entry *prev_entries = perf_sample__branch_entries(prev);
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+	int i, j, nr_identical_branches = 0;
+	struct stitch_list *stitch_node;
+	u64 cur_base, distance;
+
+	if (!cur_stack || !prev_stack)
+		return false;
+
+	/* Find the physical index of the base-of-stack for current sample. */
+	cur_base = max_lbr - cur_stack->nr + cur_stack->hw_idx + 1;
+
+	distance = (prev_stack->hw_idx > cur_base) ? (prev_stack->hw_idx - cur_base) :
+						     (max_lbr + prev_stack->hw_idx - cur_base);
+	/* Previous sample has shorter stack. Nothing can be stitched. */
+	if (distance + 1 > prev_stack->nr)
+		return false;
+
+	/*
+	 * Check if there are identical LBRs between two samples.
+	 * Identicall LBRs must have same from, to and flags values. Also,
+	 * they have to be saved in the same LBR registers (same physical
+	 * index).
+	 *
+	 * Starts from the base-of-stack of current sample.
+	 */
+	for (i = distance, j = cur_stack->nr - 1; (i >= 0) && (j >= 0); i--, j--) {
+		if ((prev_entries[i].from != cur_entries[j].from) ||
+		    (prev_entries[i].to != cur_entries[j].to) ||
+		    (prev_entries[i].flags.value != cur_entries[j].flags.value))
+			break;
+		nr_identical_branches++;
+	}
+
+	if (!nr_identical_branches)
+		return false;
+
+	/*
+	 * Save the LBRs between the base-of-stack of previous sample
+	 * and the base-of-stack of current sample into lbr_stitch->lists.
+	 * These LBRs will be stitched later.
+	 */
+	for (i = prev_stack->nr - 1; i > (int)distance; i--) {
+
+		if (!lbr_stitch->prev_lbr_cursor[i].valid)
+			continue;
+
+		stitch_node = get_stitch_node(thread);
+		if (!stitch_node)
+			return false;
+
+		memcpy(&stitch_node->cursor, &lbr_stitch->prev_lbr_cursor[i],
+		       sizeof(struct callchain_cursor_node));
+
+		if (callee)
+			list_add(&stitch_node->node, &lbr_stitch->lists);
+		else
+			list_add_tail(&stitch_node->node, &lbr_stitch->lists);
+	}
+
+	return true;
+}
+
 static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 {
 	if (thread->lbr_stitch)
@@ -2330,6 +2443,9 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 	if (!thread->lbr_stitch->prev_lbr_cursor)
 		goto free_lbr_stitch;
 
+	INIT_LIST_HEAD(&thread->lbr_stitch->lists);
+	INIT_LIST_HEAD(&thread->lbr_stitch->free_lists);
+
 	return true;
 
 free_lbr_stitch:
@@ -2356,9 +2472,11 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					int max_stack,
 					unsigned int max_lbr)
 {
+	bool callee = (callchain_param.order == ORDER_CALLEE);
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
 	struct lbr_stitch *lbr_stitch;
+	bool stitched_lbr = false;
 	u64 branch_from = 0;
 	int err;
 
@@ -2375,10 +2493,18 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	    (max_lbr > 0) && alloc_lbr_stitch(thread, max_lbr)) {
 		lbr_stitch = thread->lbr_stitch;
 
+		stitched_lbr = has_stitched_lbr(thread, sample,
+						&lbr_stitch->prev_sample,
+						max_lbr, callee);
+
+		if (!stitched_lbr && !list_empty(&lbr_stitch->lists)) {
+			list_replace_init(&lbr_stitch->lists,
+					  &lbr_stitch->free_lists);
+		}
 		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
 	}
 
-	if (callchain_param.order == ORDER_CALLEE) {
+	if (callee) {
 		/* Add kernel ip */
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
 						  parent, root_al, branch_from,
@@ -2391,7 +2517,18 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 		if (err)
 			goto error;
 
+		if (stitched_lbr) {
+			err = lbr_callchain_add_stitched_lbr_ip(thread, cursor);
+			if (err)
+				goto error;
+		}
+
 	} else {
+		if (stitched_lbr) {
+			err = lbr_callchain_add_stitched_lbr_ip(thread, cursor);
+			if (err)
+				goto error;
+		}
 		err = lbr_callchain_add_lbr_ip(thread, cursor, sample, parent,
 					       root_al, &branch_from, false);
 		if (err)
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 477c669cdbfa..12dd7288a14d 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -23,6 +23,8 @@ struct thread_stack;
 struct unwind_libunwind_ops;
 
 struct lbr_stitch {
+	struct list_head		lists;
+	struct list_head		free_lists;
 	struct perf_sample		prev_sample;
 	struct callchain_cursor_node	*prev_lbr_cursor;
 };
@@ -156,10 +158,21 @@ static inline bool thread__is_filtered(struct thread *thread)
 static inline void thread__free_stitch_list(struct thread *thread)
 {
 	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+	struct stitch_list *pos, *tmp;
 
 	if (!lbr_stitch)
 		return;
 
+	list_for_each_entry_safe(pos, tmp, &lbr_stitch->lists, node) {
+		list_del_init(&pos->node);
+		free(pos);
+	}
+
+	list_for_each_entry_safe(pos, tmp, &lbr_stitch->free_lists, node) {
+		list_del_init(&pos->node);
+		free(pos);
+	}
+
 	free(lbr_stitch->prev_lbr_cursor);
 	free(thread->lbr_stitch);
 }
-- 
2.17.1

