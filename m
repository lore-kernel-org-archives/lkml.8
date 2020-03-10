Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C74C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FA62468A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCJHEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:04:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:5994 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgCJHEH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:04:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524713"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:04:04 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 14/14] perf diff: Filter out streams by changed functions
Date:   Tue, 10 Mar 2020 15:02:45 +0800
Message-Id: <20200310070245.16314-15-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310070245.16314-1-yao.jin@linux.intel.com>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime some changes are not reflected in the source code,
e.g. changing the compiler option. So for this, we can't get
the changes by diffing the source code lines.

This patch introduces a new perf-diff option "--changed-func".
It passes the names of changed functions then perf-diff can
know what functions are changed.

For example,
perf diff --stream --changed-func main --changed-func rand

It passes the function list {"main", "rand"} to perf-diff.
Now perf-diff knows the functions "main" and "rand" in new perf
data file are changed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt |  5 +++++
 tools/perf/builtin-diff.c              | 30 ++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index 296fea98ac07..784598c12e26 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -196,6 +196,11 @@ OPTIONS
 	Source code directory corresponding to perf.data. Should be
 	used with --stream and --before.
 
+--changed-func=::
+	The given function is changed in new perf data file. This option
+	needs to be used with --stream option. Multiple functions can be given
+	by using this option more than once.
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 98e9ab8c69ce..5e5f29105fe1 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -27,6 +27,7 @@
 #include "util/block-info.h"
 #include "util/srclist.h"
 #include "util/callchain.h"
+#include "util/strlist.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
@@ -49,6 +50,7 @@ struct perf_diff {
 	bool				 src_cmp;
 	bool				 stream;
 	struct srclist			*src_list;
+	struct strlist			*func_list;
 	u64				 total_cycles;
 	float				 min_percent;
 };
@@ -1017,7 +1019,8 @@ static int process_base_stream(struct data__file *data_base,
 		if (!es_pair)
 			return -1;
 
-		callchain_match_streams(es_base, es_pair, pdiff.src_list, NULL);
+		callchain_match_streams(es_base, es_pair, pdiff.src_list,
+					pdiff.func_list);
 		callchain_stream_report(es_base, es_pair);
 	}
 
@@ -1043,7 +1046,7 @@ static int process_base_stream(struct data__file *data_base,
 		block_hists_addr2line(&rep_pair->hist.block_hists, pair_dir);
 
 		block_info__match_report(rep_base, rep_pair,
-					 pdiff.src_list, NULL, NULL);
+					 pdiff.src_list, pdiff.func_list, NULL);
 
 		fprintf(stdout, "%s", title);
 
@@ -1213,6 +1216,24 @@ static struct callchain_streams *create_evsel_streams(struct evlist *evlist,
 	return evsel_streams;
 }
 
+static int parse_func(const struct option *opt __maybe_unused,
+		      const char *str, int unset __maybe_unused)
+{
+	int ret;
+
+	if (!pdiff.func_list) {
+		pdiff.func_list = strlist__new(NULL, NULL);
+		if (!pdiff.func_list)
+			return -ENOMEM;
+	}
+
+	ret = strlist__add(pdiff.func_list, str);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
@@ -1312,6 +1333,9 @@ static int __cmd_diff(void)
 	if (pdiff.src_list)
 		srclist__delete(pdiff.src_list);
 
+	if (pdiff.func_list)
+		strlist__delete(pdiff.func_list);
+
 	return ret;
 }
 
@@ -1390,6 +1414,8 @@ static const struct option options[] = {
 	OPT_CALLBACK(0, "percent-limit", &pdiff, "percent",
 		     "Don't show entries under that percent",
 		     parse_percent_limit),
+	OPT_CALLBACK(0, "changed-func", NULL, "func",
+		     "Given function is changed", parse_func),
 	OPT_END()
 };
 
-- 
2.17.1

