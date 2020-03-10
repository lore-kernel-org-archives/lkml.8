Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D3EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD222468D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCJHDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:03:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:5965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgCJHDq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:03:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524628"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:03:43 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 06/14] perf util: Report hot streams
Date:   Tue, 10 Mar 2020 15:02:37 +0800
Message-Id: <20200310070245.16314-7-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310070245.16314-1-yao.jin@linux.intel.com>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We show the streams separately. They are divided into different sections.

1. "Matched hot chains between old perf data and new perf data"

2. "Hot chains in old perf data but source line changed in new perf data"

3. "Hot chains in old perf data only"

4. "Hot chains in new perf data only".

For each stream, we report the cycles and hot percent (hits%).

For example,

     cycles: 2, hits: 4.08%
 --------------------------
              main div.c:42
      compute_flag div.c:28

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 155 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |   3 +
 2 files changed, 158 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 040995405664..e13eee1042eb 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1781,6 +1781,9 @@ static bool chain_srclist_match(struct srclist *src_list, const char *srcline_a,
 	struct src_node *node;
 	struct line_pair *lp;
 
+	if (!srcline_a || !srcline_b)
+		return false;
+
 	if (sscanf(srcline_a, "%[^:]:%d", file_a, &line_a) != 2)
 		return false;
 
@@ -1821,6 +1824,10 @@ static bool chain_match(struct callchain_list *base_chain,
 
 	*src_changed = false;
 
+	/*
+	 * Check sourceline first. If not matched,
+	 * fallback to symbol match and address match.
+	 */
 	if (src_list && chain_srclist_match(src_list, pair_chain->srcline,
 					    base_chain->srcline, &src_found,
 					    src_changed)) {
@@ -1943,3 +1950,151 @@ void callchain_match_streams(struct callchain_streams *cs_base,
 	if (src_list)
 		srclist__dump(src_list);
 }
+
+static s64 callchain_avg_cycles(struct callchain_node *cnode)
+{
+	struct callchain_list *chain;
+	s64 cycles = 0;
+
+	list_for_each_entry(chain, &cnode->val, list) {
+		if (chain->srcline && chain->branch_count)
+			cycles += chain->cycles_count / chain->branch_count;
+	}
+
+	return cycles;
+}
+
+static void print_callchain_pair(struct stream_node *base_node, int idx,
+				 struct callchain_streams *cs_base,
+				 struct callchain_streams *cs_pair)
+{
+	struct callchain_node *base_cnode = base_node->cnode;
+	struct callchain_node *pair_cnode = base_node->pair_cnode;
+	struct callchain_list *base_chain, *pair_chain;
+	char buf1[512], buf2[512], cbuf1[256], cbuf2[256];
+	char *s1, *s2;
+	double pct;
+
+	printf("\nhot chain pair %d:\n", idx);
+
+	pct = (double)base_cnode->hit / (double)cs_base->chain_hits;
+	scnprintf(buf1, sizeof(buf1), "cycles: %ld, hits: %.2f%%",
+		  callchain_avg_cycles(base_cnode), pct * 100.0);
+
+	pct = (double)pair_cnode->hit / (double)cs_pair->chain_hits;
+	scnprintf(buf2, sizeof(buf2), "cycles: %ld, hits: %.2f%%",
+		  callchain_avg_cycles(pair_cnode), pct * 100.0);
+
+	printf("%35s\t%35s\n", buf1, buf2);
+
+	printf("%35s\t%35s\n",
+	       "---------------------------",
+	       "--------------------------");
+
+	pair_chain = list_first_entry(&pair_cnode->val,
+				      struct callchain_list,
+				      list);
+
+	list_for_each_entry(base_chain, &base_cnode->val, list) {
+		if (&pair_chain->list == &pair_cnode->val)
+			return;
+
+		s1 = callchain_list__sym_name(base_chain, cbuf1, sizeof(cbuf1),
+					      false);
+		s2 = callchain_list__sym_name(pair_chain, cbuf2, sizeof(cbuf2),
+					      false);
+
+		if (!pair_chain->src_changed)
+			scnprintf(buf1, sizeof(buf1), "%35s\t%35s", s1, s2);
+		else
+			scnprintf(buf1, sizeof(buf1), "%35s\t%35s*", s1, s2);
+
+		printf("%s\n", buf1);
+		pair_chain = list_next_entry(pair_chain, list);
+	}
+}
+
+static void print_stream_callchain(struct stream_node *node, int idx,
+				   struct callchain_streams *cs, bool pair)
+{
+	struct callchain_node *cnode = node->cnode;
+	struct callchain_list *chain;
+	char buf[512], cbuf[256], *s;
+	double pct;
+
+	printf("\nhot chain %d:\n", idx);
+
+	pct = (double)cnode->hit / (double)cs->chain_hits;
+	scnprintf(buf, sizeof(buf), "cycles: %ld, hits: %.2f%%",
+		  callchain_avg_cycles(cnode), pct * 100.0);
+
+	if (pair) {
+		printf("%35s\t%35s\n", "", buf);
+		printf("%35s\t%35s\n",
+		       "", "--------------------------");
+	} else {
+		printf("%35s\n", buf);
+		printf("%35s\n", "--------------------------");
+	}
+
+	list_for_each_entry(chain, &cnode->val, list) {
+		s = callchain_list__sym_name(chain, cbuf, sizeof(cbuf), false);
+
+		if (pair)
+			scnprintf(buf, sizeof(buf), "%35s\t%35s", "", s);
+		else
+			scnprintf(buf, sizeof(buf), "%35s", s);
+
+		printf("%s\n", buf);
+	}
+}
+
+void callchain_stream_report(struct callchain_streams *cs_base,
+			     struct callchain_streams *cs_pair)
+{
+	struct stream_node *base_node;
+	int i, idx = 0;
+
+	printf("[ Matched hot chains between old perf data and new perf data ]\n");
+	for (i = 0; i < cs_base->nr_streams; i++) {
+		base_node = &cs_base->streams[i];
+		if (base_node->pair_cnode) {
+			if (!base_node->src_changed) {
+				print_callchain_pair(base_node, ++idx,
+						     cs_base, cs_pair);
+			}
+		}
+	}
+
+	idx = 0;
+	printf("\n[ Hot chains in old perf data but source line changed (*) in new perf data ]\n");
+	for (i = 0; i < cs_base->nr_streams; i++) {
+		base_node = &cs_base->streams[i];
+		if (base_node->pair_cnode) {
+			if (base_node->src_changed) {
+				print_callchain_pair(base_node, ++idx,
+						     cs_base, cs_pair);
+			}
+		}
+	}
+
+	idx = 0;
+	printf("\n[ Hot chains in old perf data only ]\n");
+	for (i = 0; i < cs_base->nr_streams; i++) {
+		base_node = &cs_base->streams[i];
+		if (!base_node->pair_cnode) {
+			print_stream_callchain(base_node, ++idx,
+					       cs_base, false);
+		}
+	}
+
+	idx = 0;
+	printf("\n[ Hot chains in new perf data only ]\n");
+	for (i = 0; i < cs_pair->nr_streams; i++) {
+		base_node = &cs_pair->streams[i];
+		if (!base_node->pair_cnode) {
+			print_stream_callchain(base_node, ++idx,
+					       cs_pair, true);
+		}
+	}
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 3c0e0b45656b..90826a280476 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -318,4 +318,7 @@ void callchain_match_streams(struct callchain_streams *cs_base,
 			     struct callchain_streams *cs_pair,
 			     struct srclist *src_list);
 
+void callchain_stream_report(struct callchain_streams *cs_base,
+			     struct callchain_streams *cs_pair);
+
 #endif	/* __PERF_CALLCHAIN_H */
-- 
2.17.1

