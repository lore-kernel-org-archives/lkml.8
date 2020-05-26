Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A8EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED852208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgEZGLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:11:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:16985 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgEZGLd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:11:33 -0400
IronPort-SDR: TNwp6ajPHhTpaYSMe0gLPQrqQ2M4bJ4ov8CRDIzcwuP7x/gMmZDMTKo61kU6BSuYhhtVVd+vKu
 p20DzdcYSS1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 23:11:33 -0700
IronPort-SDR: 3XFxiPD/Dyg7BStCDWzlg3WK4DHEBBn4kHYURDJk64fh1bXkZYjktUJAT1Ik97uoJOfJP/PYpS
 GdEdn2GQvWFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="291068671"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2020 23:11:30 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 3/7] perf util: Compare two streams
Date:   Tue, 26 May 2020 14:09:16 +0800
Message-Id: <20200526060920.26490-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526060920.26490-1-yao.jin@linux.intel.com>
References: <20200526060920.26490-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stream is the branch history which is aggregated by the branch
records from perf samples. Now we only support the callchain as
stream.

If the callchain entries of one stream are fully matched with
the callchain entries of another stream, we think two streams
are matched.

For example,

   cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
   -----------------------                 -----------------------
             main div.c:39                           main div.c:39
             main div.c:44                           main div.c:44

Above two streams are matched (we don't consider the case that
source code is changed).

The matching logic is, compare the chain string first. If it's not
matched, fallback to dso address comparison.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 54 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |  4 +++
 2 files changed, 58 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 2775b752f2fa..d356e73c5622 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1613,3 +1613,57 @@ void callchain_param_setup(u64 sample_type)
 			callchain_param.record_mode = CALLCHAIN_FP;
 	}
 }
+
+static bool chain_match(struct callchain_list *base_chain,
+			struct callchain_list *pair_chain)
+{
+	enum match_result match;
+
+	match = match_chain_strings(base_chain->srcline,
+				    pair_chain->srcline);
+	if (match != MATCH_ERROR)
+		return match == MATCH_EQ;
+
+	match = match_chain_dso_addresses(base_chain->ms.map,
+					  base_chain->ip,
+					  pair_chain->ms.map,
+					  pair_chain->ip);
+
+	return match == MATCH_EQ;
+}
+
+bool callchain_cnode_matched(struct callchain_node *base_cnode,
+			     struct callchain_node *pair_cnode)
+{
+	struct callchain_list *base_chain, *pair_chain;
+	bool match = false;
+
+	pair_chain = list_first_entry(&pair_cnode->val,
+				      struct callchain_list,
+				      list);
+
+	list_for_each_entry(base_chain, &base_cnode->val, list) {
+		if (&pair_chain->list == &pair_cnode->val)
+			return false;
+
+		if (!base_chain->srcline || !pair_chain->srcline) {
+			pair_chain = list_next_entry(pair_chain, list);
+			continue;
+		}
+
+		match = chain_match(base_chain, pair_chain);
+		if (!match)
+			return false;
+
+		pair_chain = list_next_entry(pair_chain, list);
+	}
+
+	/*
+	 * Say chain1 is ABC, chain2 is ABCD, we consider they are
+	 * not fully matched.
+	 */
+	if (pair_chain && (&pair_chain->list != &pair_cnode->val))
+		return false;
+
+	return match;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index fe36a9e5ccd1..ad27fc8c7948 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -298,4 +298,8 @@ int callchain_branch_counts(struct callchain_root *root,
 			    u64 *abort_count, u64 *cycles_count);
 
 void callchain_param_setup(u64 sample_type);
+
+bool callchain_cnode_matched(struct callchain_node *base_cnode,
+			     struct callchain_node *pair_cnode);
+
 #endif	/* __PERF_CALLCHAIN_H */
-- 
2.17.1

