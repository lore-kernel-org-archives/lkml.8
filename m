Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A80C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23465208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgIKIFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:05:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:7287 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgIKIEi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:04:38 -0400
IronPort-SDR: 82nzSZO45jIJsHFTSQCFOq2WR7WiO3xoq0wM5rcuVG2X8sAK+8dg8Xl27FBgtyWo8Jl/n+EXyF
 CNHtcYmhc11w==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="220268211"
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="220268211"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 01:04:37 -0700
IronPort-SDR: m868ZjNeq6WbHpvS/tIyhYW1XqJc8gIsEcwzSI6hqLi+aXcUdE2DxUAfOQmSvy+el93vqaAMXi
 3b2GP6jYIYlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="342224842"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2020 01:04:34 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 5/7] perf util: Calculate the sum of total streams hits
Date:   Fri, 11 Sep 2020 16:03:51 +0800
Message-Id: <20200911080353.13359-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911080353.13359-1-yao.jin@linux.intel.com>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have used callchain_node->hit to measure the hot level of one
stream. This patch calculates the sum of hits of total streams.

Thus in next patch, we can use following formula to report hot
percent for one stream.

hot percent = callchain_node->hit / sum of total hits

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v6:
   - Rebase to perf/core

 v5:
   - Rebase to perf/core

 v4:
   - No functional change.

 v2:
   - Combine the variable decl line with its initial assignment
     in total_callchain_hits().

 tools/perf/util/callchain.c | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |  3 +++
 tools/perf/util/stream.c    |  2 ++
 tools/perf/util/stream.h    |  1 +
 4 files changed, 38 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d356e73c5622..4f824bfcc072 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1667,3 +1667,35 @@ bool callchain_cnode_matched(struct callchain_node *base_cnode,
 
 	return match;
 }
+
+static u64 count_callchain_hits(struct hist_entry *he)
+{
+	struct rb_root *root = &he->sorted_chain;
+	struct rb_node *rb_node = rb_first(root);
+	struct callchain_node *node;
+	u64 chain_hits = 0;
+
+	while (rb_node) {
+		node = rb_entry(rb_node, struct callchain_node, rb_node);
+		chain_hits += node->hit;
+		rb_node = rb_next(rb_node);
+	}
+
+	return chain_hits;
+}
+
+u64 callchain_total_hits(struct hists *hists)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+	u64 chain_hits = 0;
+
+	while (next) {
+		struct hist_entry *he = rb_entry(next, struct hist_entry,
+						 rb_node);
+
+		chain_hits += count_callchain_hits(he);
+		next = rb_next(&he->rb_node);
+	}
+
+	return chain_hits;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index ad27fc8c7948..ac5bea9c1eb7 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -13,6 +13,7 @@ struct ip_callchain;
 struct map;
 struct perf_sample;
 struct thread;
+struct hists;
 
 #define HELP_PAD "\t\t\t\t"
 
@@ -302,4 +303,6 @@ void callchain_param_setup(u64 sample_type);
 bool callchain_cnode_matched(struct callchain_node *base_cnode,
 			     struct callchain_node *pair_cnode);
 
+u64 callchain_total_hits(struct hists *hists);
+
 #endif	/* __PERF_CALLCHAIN_H */
diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index e96e21d6e07b..642316078e40 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -106,6 +106,8 @@ static void init_hot_callchain(struct hists *hists, struct evsel_streams *es)
 		update_hot_callchain(he, es);
 		next = rb_next(&he->rb_node);
 	}
+
+	es->streams_hits = callchain_total_hits(hists);
 }
 
 static int evlist_init_callchain_streams(struct evlist *evlist,
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
index 2eb6f17a834e..56dfa90c810d 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -14,6 +14,7 @@ struct evsel_streams {
 	int			nr_streams_max;
 	int			nr_streams;
 	int			evsel_idx;
+	u64			streams_hits;
 };
 
 struct evlist;
-- 
2.17.1

