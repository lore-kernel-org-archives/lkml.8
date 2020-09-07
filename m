Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1B0C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DE721775
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIGERB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 00:17:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:58721 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgIGEQz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:16:55 -0400
IronPort-SDR: HVpVEEGTSr8cEC6YZ5sKdltHd+BjdTe2dKgBeEiP0oHG9WItFw7UGsC3ie0mnA0nayDwO4c1Bx
 LGcpKnqEnk1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157215560"
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="157215560"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 21:16:55 -0700
IronPort-SDR: 4IeShO1W0kSru4lTLYtCIOQA56JzP/iKf4OVwdGAD4j+a9HrYPa4oNDtp2yc/zXU5Ut1oLG+Mp
 az6CN+4eZhrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="406709942"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2020 21:16:53 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 5/7] perf util: Calculate the sum of total streams hits
Date:   Mon,  7 Sep 2020 12:16:04 +0800
Message-Id: <20200907041606.14500-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907041606.14500-1-yao.jin@linux.intel.com>
References: <20200907041606.14500-1-yao.jin@linux.intel.com>
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
index 7cab271e656b..90d31582393e 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1653,3 +1653,35 @@ bool callchain_cnode_matched(struct callchain_node *base_cnode,
 
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
index 72134bed49d8..082f73524c9a 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -13,6 +13,7 @@ struct ip_callchain;
 struct map;
 struct perf_sample;
 struct thread;
+struct hists;
 
 #define HELP_PAD "\t\t\t\t"
 
@@ -293,4 +294,6 @@ int callchain_branch_counts(struct callchain_root *root,
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

