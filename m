Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F351CC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC97221E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgIKIEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:04:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:7287 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgIKIEn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:04:43 -0400
IronPort-SDR: 7LsPP4Vew0ZumuGCiSqxh6Sbe1WbVXixTws2ZHNSZAONu+o6E5H0+6VFlRZexdNJcGuw1STwRx
 0S2DOcRJEDpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="220268219"
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="220268219"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 01:04:40 -0700
IronPort-SDR: RI+g+XONF3Va1XeUw5EgFzObWXMtTojNgtBY8YaQ8o/zDk46oApN3N8HE0Pq1YNjIevZUE12Yn
 BXt9RTuWWY0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="342224855"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2020 01:04:37 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 6/7] perf util: Report hot streams
Date:   Fri, 11 Sep 2020 16:03:52 +0800
Message-Id: <20200911080353.13359-7-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911080353.13359-1-yao.jin@linux.intel.com>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We show the streams separately. They are divided into different sections.

1. "Matched hot streams"

2. "Hot streams in old perf data only"

3. "Hot streams in new perf data only".

For each stream, we report the cycles and hot percent (hits%).

For example,

     cycles: 2, hits: 4.08%
 --------------------------
              main div.c:42
      compute_flag div.c:28

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v6:
   - Rebase to perf/core

 v5:
   - Rebase to perf/core

 v4:
   - Remove "Hot chains in old perf data but source line changed
     in new perf data"

 tools/perf/util/callchain.c |  13 ++++
 tools/perf/util/callchain.h |   2 +
 tools/perf/util/stream.c    | 123 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/stream.h    |   3 +
 4 files changed, 141 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 4f824bfcc072..1b60985690bb 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1699,3 +1699,16 @@ u64 callchain_total_hits(struct hists *hists)
 
 	return chain_hits;
 }
+
+s64 callchain_avg_cycles(struct callchain_node *cnode)
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
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index ac5bea9c1eb7..5824134f983b 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -305,4 +305,6 @@ bool callchain_cnode_matched(struct callchain_node *base_cnode,
 
 u64 callchain_total_hits(struct hists *hists);
 
+s64 callchain_avg_cycles(struct callchain_node *cnode);
+
 #endif	/* __PERF_CALLCHAIN_H */
diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index 642316078e40..2d3dc7361ef1 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -199,3 +199,126 @@ void match_evsel_streams(struct evsel_streams *es_base,
 			stream_link(base_stream, pair_stream);
 	}
 }
+
+static void print_callchain_pair(struct stream *base_stream, int idx,
+				 struct evsel_streams *es_base,
+				 struct evsel_streams *es_pair)
+{
+	struct callchain_node *base_cnode = base_stream->cnode;
+	struct callchain_node *pair_cnode = base_stream->pair_cnode;
+	struct callchain_list *base_chain, *pair_chain;
+	char buf1[512], buf2[512], cbuf1[256], cbuf2[256];
+	char *s1, *s2;
+	double pct;
+
+	printf("\nhot chain pair %d:\n", idx);
+
+	pct = (double)base_cnode->hit / (double)es_base->streams_hits;
+	scnprintf(buf1, sizeof(buf1), "cycles: %ld, hits: %.2f%%",
+		  callchain_avg_cycles(base_cnode), pct * 100.0);
+
+	pct = (double)pair_cnode->hit / (double)es_pair->streams_hits;
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
+		scnprintf(buf1, sizeof(buf1), "%35s\t%35s", s1, s2);
+		printf("%s\n", buf1);
+		pair_chain = list_next_entry(pair_chain, list);
+	}
+}
+
+static void print_stream_callchain(struct stream *stream, int idx,
+				   struct evsel_streams *es, bool pair)
+{
+	struct callchain_node *cnode = stream->cnode;
+	struct callchain_list *chain;
+	char buf[512], cbuf[256], *s;
+	double pct;
+
+	printf("\nhot chain %d:\n", idx);
+
+	pct = (double)cnode->hit / (double)es->streams_hits;
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
+static void callchain_streams_report(struct evsel_streams *es_base,
+				     struct evsel_streams *es_pair)
+{
+	struct stream *base_stream;
+	int i, idx = 0;
+
+	printf("[ Matched hot streams ]\n");
+	for (i = 0; i < es_base->nr_streams; i++) {
+		base_stream = &es_base->streams[i];
+		if (base_stream->pair_cnode) {
+			print_callchain_pair(base_stream, ++idx,
+					     es_base, es_pair);
+		}
+	}
+
+	idx = 0;
+	printf("\n[ Hot streams in old perf data only ]\n");
+	for (i = 0; i < es_base->nr_streams; i++) {
+		base_stream = &es_base->streams[i];
+		if (!base_stream->pair_cnode) {
+			print_stream_callchain(base_stream, ++idx,
+					       es_base, false);
+		}
+	}
+
+	idx = 0;
+	printf("\n[ Hot streams in new perf data only ]\n");
+	for (i = 0; i < es_pair->nr_streams; i++) {
+		base_stream = &es_pair->streams[i];
+		if (!base_stream->pair_cnode) {
+			print_stream_callchain(base_stream, ++idx,
+					       es_pair, true);
+		}
+	}
+}
+
+void evsel_streams_report(struct evsel_streams *es_base,
+			  struct evsel_streams *es_pair)
+{
+	return callchain_streams_report(es_base, es_pair);
+}
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
index 56dfa90c810d..33b02c059d23 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -28,4 +28,7 @@ struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
 void match_evsel_streams(struct evsel_streams *es_base,
 			 struct evsel_streams *es_pair);
 
+void evsel_streams_report(struct evsel_streams *es_base,
+			  struct evsel_streams *es_pair);
+
 #endif /* __PERF_STREAM_H */
-- 
2.17.1

