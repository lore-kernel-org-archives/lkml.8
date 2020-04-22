Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F00C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D9A20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgDVMUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728680AbgDVMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ED2C03C1A9;
        Wed, 22 Apr 2020 05:17:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJU-0007YZ-TC; Wed, 22 Apr 2020 14:17:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6614F1C0450;
        Wed, 22 Apr 2020 14:17:12 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:12 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf callchain: Stitch LBR call stack
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200319202517.23423-13-kan.liang@linux.intel.com>
References: <20200319202517.23423-13-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158755783201.28353.13142738133653650393.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ff165628d72644e37674c5485658e8bd9f4a348b
Gitweb:        https://git.kernel.org/tip/ff165628d72644e37674c5485658e8bd9f4a348b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 19 Mar 2020 13:25:12 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:01 -03:00

perf callchain: Stitch LBR call stack

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
cursor nodes will be copied to 'lists'.  The 'lists' is to track the LBR
cursor nodes which are going to be stitched.

When the stitching is over, the nodes will not be freed immediately.
They will be moved to 'free_lists'. Next stitching may reuse the space.
Both 'lists' and 'free_lists' will be freed when all samples are
processed.

Committer notes:

Fix the intel-pt.c initialization of the union with 'struct
branch_flags', that breaks the build with its unnamed union on older gcc
versions.

Uninline thread__free_stitch_list(), as it grew big and started dragging
includes to thread.h, so move it to thread.c where what it needs in
terms of headers are already there.

This fixes the build in several systems such as debian:experimental when
cross building to the MIPS32 architecture, i.e. in the other cases what
was needed was being included by sheer luck.

  In file included from builtin-sched.c:11:
  util/thread.h: In function 'thread__free_stitch_list':
  util/thread.h:169:3: error: implicit declaration of function 'free' [-Werror=implicit-function-declaration]
    169 |   free(pos);
        |   ^~~~
  util/thread.h:169:3: error: incompatible implicit declaration of built-in function 'free' [-Werror]
  util/thread.h:19:1: note: include '<stdlib.h>' or provide a declaration of 'free'
     18 | #include "callchain.h"
    +++ |+#include <stdlib.h>
     19 |
  util/thread.h:174:3: error: incompatible implicit declaration of built-in function 'free' [-Werror]
    174 |   free(pos);
        |   ^~~~
  util/thread.h:174:3: note: include '<stdlib.h>' or provide a declaration of 'free'

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-13-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/branch.h    |  19 +++--
 tools/perf/util/callchain.h |   5 +-
 tools/perf/util/intel-pt.c  |  17 +---
 tools/perf/util/machine.c   | 139 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/thread.c    |  22 ++++++-
 tools/perf/util/thread.h    |  14 +----
 6 files changed, 188 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 154a05c..4d3f02f 100644
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
index cb33cd4..8f668ee 100644
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
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a659b4a..4be7634 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1717,15 +1717,14 @@ static u64 intel_pt_lbr_flags(u64 info)
 	union {
 		struct branch_flags flags;
 		u64 result;
-	} u = {
-		.flags = {
-			.mispred	= !!(info & LBR_INFO_MISPRED),
-			.predicted	= !(info & LBR_INFO_MISPRED),
-			.in_tx		= !!(info & LBR_INFO_IN_TX),
-			.abort		= !!(info & LBR_INFO_ABORT),
-			.cycles		= info & LBR_INFO_CYCLES,
-		}
-	};
+	} u;
+
+	u.result	  = 0;
+	u.flags.mispred	  = !!(info & LBR_INFO_MISPRED);
+	u.flags.predicted = !(info & LBR_INFO_MISPRED);
+	u.flags.in_tx	  = !!(info & LBR_INFO_IN_TX);
+	u.flags.abort	  = !!(info & LBR_INFO_ABORT);
+	u.flags.cycles	  = info & LBR_INFO_CYCLES;
 
 	return u.result;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 737dee7..5ac32ca 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2348,6 +2348,119 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
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
@@ -2361,6 +2474,9 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 	if (!thread->lbr_stitch->prev_lbr_cursor)
 		goto free_lbr_stitch;
 
+	INIT_LIST_HEAD(&thread->lbr_stitch->lists);
+	INIT_LIST_HEAD(&thread->lbr_stitch->free_lists);
+
 	return true;
 
 free_lbr_stitch:
@@ -2386,9 +2502,11 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
 
@@ -2405,10 +2523,18 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
@@ -2421,7 +2547,18 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 8d0da26..665e5c0 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -454,3 +454,25 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
 
        return dso__data_read_offset(al.map->dso, machine, offset, buf, len);
 }
+
+void thread__free_stitch_list(struct thread *thread)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+	struct stitch_list *pos, *tmp;
+
+	if (!lbr_stitch)
+		return;
+
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
+	zfree(&lbr_stitch->prev_lbr_cursor);
+	zfree(&thread->lbr_stitch);
+}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 8456174..b066fb3 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -5,7 +5,6 @@
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
 #include <linux/list.h>
-#include <linux/zalloc.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
@@ -24,6 +23,8 @@ struct thread_stack;
 struct unwind_libunwind_ops;
 
 struct lbr_stitch {
+	struct list_head		lists;
+	struct list_head		free_lists;
 	struct perf_sample		prev_sample;
 	struct callchain_cursor_node	*prev_lbr_cursor;
 };
@@ -154,15 +155,6 @@ static inline bool thread__is_filtered(struct thread *thread)
 	return false;
 }
 
-static inline void thread__free_stitch_list(struct thread *thread)
-{
-	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
-
-	if (!lbr_stitch)
-		return;
-
-	zfree(&lbr_stitch->prev_lbr_cursor);
-	zfree(&thread->lbr_stitch);
-}
+void thread__free_stitch_list(struct thread *thread);
 
 #endif	/* __PERF_THREAD_H */
