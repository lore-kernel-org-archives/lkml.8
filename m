Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80CBC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D8620663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCSU3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:29:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:60512 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbgCSU3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:29:06 -0400
IronPort-SDR: gh8WSXLQMD5/GZ0FmtYx2JVsO75938UgZuH2euh2+/sckyFNMySPnHru4n1nfMqqK/M5SJW7NW
 psPxcC52Ur7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:29:04 -0700
IronPort-SDR: Aw0IAjZ00auPnBeERmjVX2BLEWCwwtoxHw9KwW45R0250gAtvczMLLyUDahZo3+pr7BzS0Dfix
 gZM4Ql1Gj2lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031286"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:29:04 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 17/17] perf hist: Add fast path for duplicate entries check
Date:   Thu, 19 Mar 2020 13:25:17 -0700
Message-Id: <20200319202517.23423-18-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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

 $perf record --call-graph lbr ./tchain_edit_64

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
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c | 23 +++++++++++++++++++++++
 tools/perf/util/sort.c |  2 +-
 tools/perf/util/sort.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index e74a5acf66d9..311d6d119f3c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1057,6 +1057,20 @@ iter_next_cumulative_entry(struct hist_entry_iter *iter,
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
@@ -1083,6 +1097,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	};
 	int i;
 	struct callchain_cursor cursor;
+	bool fast = hists__has(he_tmp.hists, sym);
 
 	callchain_cursor_snapshot(&cursor, &callchain_cursor);
 
@@ -1093,6 +1108,14 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
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
index e860595576c2..96fd5fb42116 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -234,7 +234,7 @@ static int64_t _sort__addr_cmp(u64 left_ip, u64 right_ip)
 	return (int64_t)(right_ip - left_ip);
 }
 
-static int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
+int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 {
 	if (!sym_l || !sym_r)
 		return cmp_null(sym_l, sym_r);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 6c862d62d052..c3c3c68cbfdd 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -309,5 +309,7 @@ int64_t
 sort__daddr_cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t
 sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right);
+int64_t
+_sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r);
 char *hist_entry__srcline(struct hist_entry *he);
 #endif	/* __PERF_SORT_H */
-- 
2.17.1

