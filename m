Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2520CC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D3B24692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCJHDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:03:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:5965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgCJHDn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:03:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524604"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:03:41 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 05/14] perf util: Calculate the sum of all streams hits
Date:   Tue, 10 Mar 2020 15:02:36 +0800
Message-Id: <20200310070245.16314-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310070245.16314-1-yao.jin@linux.intel.com>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have used callchain_node->hit to measure the hot level of one
stream. This patch calculates the sum of hits of all streams.

Then in next patch, we can use following formula to report hot
percent for one stream.

hot percent = callchain_node->hit / sum of all hits

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index a9dd91268b00..040995405664 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1685,6 +1685,39 @@ static void update_hot_streams(struct hist_entry *he,
 	}
 }
 
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
+static u64 total_callchain_hits(struct hists *hists)
+{
+	struct rb_node *next;
+	u64 chain_hits = 0;
+
+	next = rb_first_cached(&hists->entries);
+	while (next) {
+		struct hist_entry *he;
+
+		he = rb_entry(next, struct hist_entry, rb_node);
+		chain_hits += count_callchain_hits(he);
+		next = rb_next(&he->rb_node);
+	}
+
+	return chain_hits;
+}
+
 static void get_hot_streams(struct hists *hists,
 			    struct callchain_streams *s)
 {
@@ -1698,6 +1731,8 @@ static void get_hot_streams(struct hists *hists,
 		update_hot_streams(he, s);
 		next = rb_next(&he->rb_node);
 	}
+
+	s->chain_hits = total_callchain_hits(hists);
 }
 
 struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index c996ab4fb108..3c0e0b45656b 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -173,6 +173,7 @@ struct callchain_streams {
 	int			nr_streams_max;
 	int			nr_streams;
 	int			evsel_idx;
+	u64			chain_hits;
 };
 
 extern __thread struct callchain_cursor callchain_cursor;
-- 
2.17.1

