Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008A3C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00B2207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgHYHHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:07:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:4094 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgHYHGw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:06:52 -0400
IronPort-SDR: 2DvngSZFJIji1RWNBv82IxoUKjVTHdbvqmmD9Yncan+VBN6/7ARY/4NLPsvdblT8Gj5a7eZPXd
 LY9j2TMCpLbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156050080"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="156050080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 00:06:51 -0700
IronPort-SDR: hPFby4x61X0kNDuPAA2z6lSF+bxp5AFrShlTr53KZjyTfl8wri0sT/kxT8Ur3SFrzOZvMXa9D5
 Odx2lEWuy4Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="322655185"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2020 00:06:49 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 5/7] perf util: Calculate the sum of total streams hits
Date:   Tue, 25 Aug 2020 07:35:11 +0800
Message-Id: <20200824233513.16930-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824233513.16930-1-yao.jin@linux.intel.com>
References: <20200824233513.16930-1-yao.jin@linux.intel.com>
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
index 76896a790798..d42fad3fff7e 100644
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
index 53f34e63f8fb..c34806e50980 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -20,6 +20,7 @@ struct evsel_streams {
 	int			nr_streams_max;
 	int			nr_streams;
 	int			evsel_idx;
+	u64			streams_hits;
 };
 
 struct evlist;
-- 
2.17.1

