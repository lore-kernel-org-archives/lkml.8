Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA2CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AFB2468B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCJHDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:03:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:5965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgCJHDl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:03:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524592"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:03:38 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 04/14] perf util: Compare two streams
Date:   Tue, 10 Mar 2020 15:02:35 +0800
Message-Id: <20200310070245.16314-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310070245.16314-1-yao.jin@linux.intel.com>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all callchain entries of one stream are fully matched with
all entries of another stream, we think these two streams are
matched.

For example,

   cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
   -----------------------                 -----------------------
             main div.c:39                           main div.c:39
             main div.c:44                           main div.c:44

Above two streams are matched if div.c is not changed.

But the streams are not matched if div.c is source line changed
(e.g. div.c:39 is changed). If the source line is changed, they
are different streams.

So the challenge is how to identify the changed source lines.
For this purpose, we use the source line mapping table (see patch
"perf util: Create source line mapping table"). The source line
mapping information is saved in src_list.

So the matching logic is, if we can find the source lines, the
callchain entry comparison is based on source lines. Otherwise,
fallback to dso address comparison.

Once two streams are fully matched, they will be linked as
a pair. From the pair, we can know which streams are matched.
The pair information will be used in next patches.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 172 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |   8 ++
 2 files changed, 180 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 31ecc1abe7f9..a9dd91268b00 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1736,3 +1736,175 @@ struct callchain_streams *callchain_evsel_streams_get(struct callchain_streams *
 
 	return NULL;
 }
+
+static bool chain_srclist_match(struct srclist *src_list, const char *srcline_a,
+				const char *srcline_b, bool *src_found,
+				bool *src_changed)
+{
+	char file_a[PATH_MAX], file_b[PATH_MAX];
+	int line_a, line_b;
+	struct src_node *node;
+	struct line_pair *lp;
+
+	if (sscanf(srcline_a, "%[^:]:%d", file_a, &line_a) != 2)
+		return false;
+
+	if (sscanf(srcline_b, "%[^:]:%d", file_b, &line_b) != 2)
+		return false;
+
+	if (strcmp(file_a, file_b))
+		return false;
+
+	node = srclist__find(src_list, file_a, true);
+	if (!node)
+		return false;
+
+	*src_found = true;
+
+	lp = srclist__line_pair(node, line_a);
+	if (!lp)
+		return false;
+
+	if (line_a == line_b && lp->b_nr == -1) {
+		*src_changed = true;
+		return true;
+	}
+
+	if (lp->b_nr == line_b)
+		return true;
+
+	return false;
+}
+
+static bool chain_match(struct callchain_list *base_chain,
+			struct callchain_list *pair_chain,
+			struct srclist *src_list,
+			bool *src_changed)
+{
+	enum match_result match;
+	bool src_found = false;
+
+	*src_changed = false;
+
+	if (src_list && chain_srclist_match(src_list, pair_chain->srcline,
+					    base_chain->srcline, &src_found,
+					    src_changed)) {
+		return true;
+	}
+
+	if (!src_found)  {
+		match = match_chain_strings(base_chain->srcline,
+					    pair_chain->srcline);
+		if (match != MATCH_ERROR)
+			return match == MATCH_EQ;
+
+		match = match_chain_dso_addresses(base_chain->ms.map,
+						  base_chain->ip,
+						  pair_chain->ms.map,
+						  pair_chain->ip);
+
+		return match == MATCH_EQ;
+	}
+
+	return false;
+}
+
+static bool callchain_node_matched(struct callchain_node *base_cnode,
+				   struct callchain_node *pair_cnode,
+				   struct srclist *src_list,
+				   int *nr_changed)
+{
+	struct callchain_list *base_chain, *pair_chain;
+	bool match = false;
+
+	pair_chain = list_first_entry(&pair_cnode->val,
+				      struct callchain_list,
+				      list);
+
+	list_for_each_entry(base_chain, &base_cnode->val, list) {
+		bool src_changed;
+
+		if (&pair_chain->list == &pair_cnode->val)
+			return false;
+
+		if (!base_chain->srcline || !pair_chain->srcline) {
+			pair_chain = list_next_entry(pair_chain, list);
+			continue;
+		}
+
+		match = chain_match(base_chain, pair_chain, src_list,
+				    &src_changed);
+
+		if (src_changed) {
+			pair_chain->src_changed = true;
+			*nr_changed += 1;
+		}
+
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
+
+static struct stream_node *stream_node_match(struct stream_node *base_node,
+					     struct callchain_streams *cs_pair,
+					     struct srclist *src_list,
+					     bool *src_changed)
+{
+	*src_changed = false;
+
+	for (int i = 0; i < cs_pair->nr_streams; i++) {
+		struct stream_node *pair_node = &cs_pair->streams[i];
+		int nr_changed = 0;
+
+		if (callchain_node_matched(base_node->cnode, pair_node->cnode,
+					   src_list, &nr_changed)) {
+			if (nr_changed)
+				*src_changed = true;
+
+			return pair_node;
+		}
+	}
+
+	return NULL;
+}
+
+static void stream_nodes_link(struct stream_node *base_node,
+			      struct stream_node *pair_node,
+			      bool src_changed)
+{
+	base_node->pair_cnode = pair_node->cnode;
+	base_node->src_changed = src_changed;
+	pair_node->pair_cnode = base_node->cnode;
+}
+
+void callchain_match_streams(struct callchain_streams *cs_base,
+			     struct callchain_streams *cs_pair,
+			     struct srclist *src_list)
+{
+	for (int i = 0; i < cs_base->nr_streams; i++) {
+		struct stream_node *base_node = &cs_base->streams[i];
+		struct stream_node *pair_node;
+		bool src_changed;
+
+		pair_node = stream_node_match(base_node, cs_pair, src_list,
+					      &src_changed);
+		if (pair_node)
+			stream_nodes_link(base_node, pair_node, src_changed);
+		else
+			base_node->src_changed = src_changed;
+	}
+
+	if (src_list)
+		srclist__dump(src_list);
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 4e881361e154..c996ab4fb108 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -6,6 +6,7 @@
 #include <linux/rbtree.h>
 #include "map_symbol.h"
 #include "branch.h"
+#include "srclist.h"
 
 struct addr_location;
 struct evsel;
@@ -131,6 +132,7 @@ struct callchain_list {
 	u64			iter_cycles;
 	struct branch_type_stat brtype_stat;
 	const char		*srcline;
+	bool			src_changed;
 	struct list_head	list;
 };
 
@@ -162,6 +164,8 @@ struct callchain_cursor {
 
 struct stream_node {
 	struct callchain_node	*cnode;
+	struct callchain_node	*pair_cnode;
+	bool			src_changed;
 };
 
 struct callchain_streams {
@@ -309,4 +313,8 @@ struct callchain_streams *callchain_evsel_streams_get(struct callchain_streams *
 						      int nr_streams_max,
 						      int evsel_idx);
 
+void callchain_match_streams(struct callchain_streams *cs_base,
+			     struct callchain_streams *cs_pair,
+			     struct srclist *src_list);
+
 #endif	/* __PERF_CALLCHAIN_H */
-- 
2.17.1

