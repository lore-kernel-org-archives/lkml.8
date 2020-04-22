Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D5EC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0B921835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgDVMRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728481AbgDVMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA08C03C1AE;
        Wed, 22 Apr 2020 05:17:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJS-0007YM-Dr; Wed, 22 Apr 2020 14:17:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DEC6E1C02FC;
        Wed, 22 Apr 2020 14:17:09 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:09 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf hist: Add fast path for duplicate entries check
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
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
In-Reply-To: <20200319202517.23423-18-kan.liang@linux.intel.com>
References: <20200319202517.23423-18-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158755782945.28353.13339923488972169310.tip-bot2@tip-bot2>
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

Commit-ID:     12e89e65f446476951f42aedeef56b6bd6f7f1e6
Gitweb:        https://git.kernel.org/tip/12e89e65f446476951f42aedeef56b6bd6f7f1e6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 19 Mar 2020 13:25:17 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:01 -03:00

perf hist: Add fast path for duplicate entries check

Perf checks the duplicate entries in a callchain before adding an entry.
However the check is very slow especially with deeper call stack.
Almost ~50% elapsed time of perf report is spent on the check when the
call stack is always depth of 32.

The hist_entry__cmp() is used to compare the new entry with the old
entries. It will go through all the available sorts in the sort_list,
and call the specific cmp of each sort, which is very slow.

Actually, for most cases, there are no duplicate entries in callchain.
The symbols are usually different. It's much faster to do a quick check
for symbols first. Only do the full cmp when the symbols are exactly the
same.

The quick check is only to check symbols, not dso. Export
_sort__sym_cmp.

  $ perf record --call-graph lbr ./tchain_edit_64

  Without the patch
  $time perf report --stdio
  real    0m21.142s
  user    0m21.110s
  sys     0m0.033s

  With the patch
  $time perf report --stdio
  real    0m10.977s
  user    0m10.948s
  sys     0m0.027s

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-18-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 23 +++++++++++++++++++++++
 tools/perf/util/sort.c |  2 +-
 tools/perf/util/sort.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 283a69f..c2550db 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1070,6 +1070,20 @@ iter_next_cumulative_entry(struct hist_entry_iter *iter,
 	return fill_callchain_info(al, node, iter->hide_unresolved);
 }
 
+static bool
+hist_entry__fast__sym_diff(struct hist_entry *left,
+			   struct hist_entry *right)
+{
+	struct symbol *sym_l = left->ms.sym;
+	struct symbol *sym_r = right->ms.sym;
+
+	if (!sym_l && !sym_r)
+		return left->ip != right->ip;
+
+	return !!_sort__sym_cmp(sym_l, sym_r);
+}
+
+
 static int
 iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			       struct addr_location *al)
@@ -1096,6 +1110,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	};
 	int i;
 	struct callchain_cursor cursor;
+	bool fast = hists__has(he_tmp.hists, sym);
 
 	callchain_cursor_snapshot(&cursor, &callchain_cursor);
 
@@ -1106,6 +1121,14 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	 * It's possible that it has cycles or recursive calls.
 	 */
 	for (i = 0; i < iter->curr; i++) {
+		/*
+		 * For most cases, there are no duplicate entries in callchain.
+		 * The symbols are usually different. Do a quick check for
+		 * symbols first.
+		 */
+		if (fast && hist_entry__fast__sym_diff(he_cache[i], &he_tmp))
+			continue;
+
 		if (hist_entry__cmp(he_cache[i], &he_tmp) == 0) {
 			/* to avoid calling callback function */
 			iter->he = NULL;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f14cc72..dc15ddc 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -237,7 +237,7 @@ static int64_t _sort__addr_cmp(u64 left_ip, u64 right_ip)
 	return (int64_t)(right_ip - left_ip);
 }
 
-static int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
+int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 {
 	if (!sym_l || !sym_r)
 		return cmp_null(sym_l, sym_r);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index cfa6ac6..66d39c4 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -311,5 +311,7 @@ int64_t
 sort__daddr_cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t
 sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right);
+int64_t
+_sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r);
 char *hist_entry__srcline(struct hist_entry *he);
 #endif	/* __PERF_SORT_H */
