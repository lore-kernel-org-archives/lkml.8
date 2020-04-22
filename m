Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CFC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F7021582
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgDVMWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728308AbgDVMRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE2C03C1AA;
        Wed, 22 Apr 2020 05:17:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJV-0007Yc-AN; Wed, 22 Apr 2020 14:17:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EAE641C02FC;
        Wed, 22 Apr 2020 14:17:12 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:12 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf callchain: Save previous cursor nodes for LBR
 stitching approach
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
In-Reply-To: <20200319202517.23423-12-kan.liang@linux.intel.com>
References: <20200319202517.23423-12-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158755783256.28353.18206041486406653383.tip-bot2@tip-bot2>
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

Commit-ID:     7f1d39317c071268b4204175df7cfbb2187acb72
Gitweb:        https://git.kernel.org/tip/7f1d39317c071268b4204175df7cfbb2187acb72
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 19 Mar 2020 13:25:11 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:01 -03:00

perf callchain: Save previous cursor nodes for LBR stitching approach

The cursor nodes which generates from sample are eventually added into
callchain. To avoid generating cursor nodes from previous samples again,
the previous cursor nodes are also saved for LBR stitching approach.

Some option, e.g. hide-unresolved, may hide some LBRs.  Add a variable
'valid' in struct callchain_cursor_node to indicate this case. The LBR
stitching approach will only append the valid cursor nodes from previous
samples later.

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-12-kan.liang@linux.intel.com
[ Use zfree() instead of open coded equivalent, and use it when freeing members of structs ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.h |  3 +-
 tools/perf/util/machine.c   | 76 ++++++++++++++++++++++++++++++++++--
 tools/perf/util/thread.h    |  8 ++++-
 3 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 706bb7b..cb33cd4 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -143,6 +143,9 @@ struct callchain_cursor_node {
 	u64				ip;
 	struct map_symbol		ms;
 	const char			*srcline;
+	/* Indicate valid cursor node for LBR stitch */
+	bool				valid;
+
 	bool				branch;
 	struct branch_flags		branch_flags;
 	u64				branch_from;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a54ca09..737dee7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2224,6 +2224,31 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	return 0;
 }
 
+static void save_lbr_cursor_node(struct thread *thread,
+				 struct callchain_cursor *cursor,
+				 int idx)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+
+	if (!lbr_stitch)
+		return;
+
+	if (cursor->pos == cursor->nr) {
+		lbr_stitch->prev_lbr_cursor[idx].valid = false;
+		return;
+	}
+
+	if (!cursor->curr)
+		cursor->curr = cursor->first;
+	else
+		cursor->curr = cursor->curr->next;
+	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
+	       sizeof(struct callchain_cursor_node));
+
+	lbr_stitch->prev_lbr_cursor[idx].valid = true;
+	cursor->pos++;
+}
+
 static int lbr_callchain_add_lbr_ip(struct thread *thread,
 				    struct callchain_cursor *cursor,
 				    struct perf_sample *sample,
@@ -2240,6 +2265,21 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	int err, i;
 	u64 ip;
 
+	/*
+	 * The curr and pos are not used in writing session. They are cleared
+	 * in callchain_cursor_commit() when the writing session is closed.
+	 * Using curr and pos to track the current cursor node.
+	 */
+	if (thread->lbr_stitch) {
+		cursor->curr = NULL;
+		cursor->pos = cursor->nr;
+		if (cursor->nr) {
+			cursor->curr = cursor->first;
+			for (i = 0; i < (int)(cursor->nr - 1); i++)
+				cursor->curr = cursor->curr->next;
+		}
+	}
+
 	if (callee) {
 		/* Add LBR ip from first entries.to */
 		ip = entries[0].to;
@@ -2252,6 +2292,20 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		if (err)
 			return err;
 
+		/*
+		 * The number of cursor node increases.
+		 * Move the current cursor node.
+		 * But does not need to save current cursor node for entry 0.
+		 * It's impossible to stitch the whole LBRs of previous sample.
+		 */
+		if (thread->lbr_stitch && (cursor->pos != cursor->nr)) {
+			if (!cursor->curr)
+				cursor->curr = cursor->first;
+			else
+				cursor->curr = cursor->curr->next;
+			cursor->pos++;
+		}
+
 		/* Add LBR ip from entries.from one by one. */
 		for (i = 0; i < lbr_nr; i++) {
 			ip = entries[i].from;
@@ -2262,6 +2316,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 					       *branch_from);
 			if (err)
 				return err;
+			save_lbr_cursor_node(thread, cursor, i);
 		}
 		return 0;
 	}
@@ -2276,6 +2331,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 				       *branch_from);
 		if (err)
 			return err;
+		save_lbr_cursor_node(thread, cursor, i);
 	}
 
 	/* Add LBR ip from first entries.to */
@@ -2292,7 +2348,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	return 0;
 }
 
-static bool alloc_lbr_stitch(struct thread *thread)
+static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 {
 	if (thread->lbr_stitch)
 		return true;
@@ -2301,6 +2357,14 @@ static bool alloc_lbr_stitch(struct thread *thread)
 	if (!thread->lbr_stitch)
 		goto err;
 
+	thread->lbr_stitch->prev_lbr_cursor = calloc(max_lbr + 1, sizeof(struct callchain_cursor_node));
+	if (!thread->lbr_stitch->prev_lbr_cursor)
+		goto free_lbr_stitch;
+
+	return true;
+
+free_lbr_stitch:
+	zfree(&thread->lbr_stitch);
 err:
 	pr_warning("Failed to allocate space for stitched LBRs. Disable LBR stitch\n");
 	thread->lbr_stitch_enable = false;
@@ -2319,7 +2383,8 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					struct perf_sample *sample,
 					struct symbol **parent,
 					struct addr_location *root_al,
-					int max_stack)
+					int max_stack,
+					unsigned int max_lbr)
 {
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
@@ -2337,7 +2402,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 		return 0;
 
 	if (thread->lbr_stitch_enable && !sample->no_hw_idx &&
-	    alloc_lbr_stitch(thread)) {
+	    (max_lbr > 0) && alloc_lbr_stitch(thread, max_lbr)) {
 		lbr_stitch = thread->lbr_stitch;
 
 		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
@@ -2417,8 +2482,11 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 		chain_nr = chain->nr;
 
 	if (perf_evsel__has_branch_callstack(evsel)) {
+		struct perf_env *env = perf_evsel__env(evsel);
+
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
-						   root_al, max_stack);
+						   root_al, max_stack,
+						   !env ? 0 : env->max_branches);
 		if (err)
 			return (err < 0) ? err : 0;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 34eb61c..8456174 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -15,6 +15,7 @@
 #include <intlist.h>
 #include "rwsem.h"
 #include "event.h"
+#include "callchain.h"
 
 struct addr_location;
 struct map;
@@ -24,6 +25,7 @@ struct unwind_libunwind_ops;
 
 struct lbr_stitch {
 	struct perf_sample		prev_sample;
+	struct callchain_cursor_node	*prev_lbr_cursor;
 };
 
 struct thread {
@@ -154,6 +156,12 @@ static inline bool thread__is_filtered(struct thread *thread)
 
 static inline void thread__free_stitch_list(struct thread *thread)
 {
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+
+	if (!lbr_stitch)
+		return;
+
+	zfree(&lbr_stitch->prev_lbr_cursor);
 	zfree(&thread->lbr_stitch);
 }
 
