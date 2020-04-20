Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F8EC38A29
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A2922247
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDTBHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:07:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:62984 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgDTBHJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:07:09 -0400
IronPort-SDR: Vam7qWkXAUZDX8PDsJuMe/QgsF3mGkkA5X2/F0Q0H3h9qyMBwdT4NaJrl18rjC/BMkLbj8zHsM
 /pWTDOC91cUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 18:07:09 -0700
IronPort-SDR: CpfHVDPhU5qCxMLkJ7167ASok7lGalbPv2bkiMDtBQWys4nOZs/xvtb+8V2DjbmlQp2l1/+Piv
 6YJO5i7x42lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="364855022"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2020 18:07:07 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 5/7] perf util: Calculate the sum of all streams hits
Date:   Mon, 20 Apr 2020 09:04:49 +0800
Message-Id: <20200420010451.24405-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420010451.24405-1-yao.jin@linux.intel.com>
References: <20200420010451.24405-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have used callchain_node->hit to measure the hot level of one
stream. This patch calculates the sum of hits of all streams.

Then in next patch, we can use following formula to report hot
percent for one stream.

hot percent = callchain_node->hit / sum of all hits

 v2:
 ---
 Combine the variable decl line with its initial assignment
 in total_callchain_hits().

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1619f7fa4076..b0c8757c2dcf 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1683,6 +1683,38 @@ static void update_hot_streams(struct hist_entry *he,
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
+
 static void get_hot_streams(struct hists *hists,
 			    struct callchain_streams *s)
 {
@@ -1695,6 +1727,8 @@ static void get_hot_streams(struct hists *hists,
 		update_hot_streams(he, s);
 		next = rb_next(&he->rb_node);
 	}
+
+	s->chain_hits = total_callchain_hits(hists);
 }
 
 struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 52aa01b9eedf..a9b20b785dc7 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -181,6 +181,7 @@ struct callchain_streams {
 	int			nr_streams_max;
 	int			nr_streams;
 	int			evsel_idx;
+	u64			chain_hits;
 };
 
 extern __thread struct callchain_cursor callchain_cursor;
-- 
2.17.1

