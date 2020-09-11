Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8BBC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA85B208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgIKIEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:04:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:7285 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgIKIEf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:04:35 -0400
IronPort-SDR: Gy3ncYckxQkuGGWGEPh/pivOTdToa3tKvmjv02VP708iOy6u9fuiWCZ1KVkM4i30ZC1cXL4qJ3
 NP/rsPXegisw==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="220268204"
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="220268204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 01:04:34 -0700
IronPort-SDR: pBBl62HL60H3E0LbkpE/APnu32m3m9/vee2QoYCyKSTwevMuKNHFh5taclQJgFkNCPQnR3iwYD
 3jSbDaHCqiUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="342224835"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2020 01:04:31 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 4/7] perf util: Link stream pair
Date:   Fri, 11 Sep 2020 16:03:50 +0800
Message-Id: <20200911080353.13359-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911080353.13359-1-yao.jin@linux.intel.com>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have created an evsel_streams for one event,
and top N hottest streams will be saved in a stream array in
evsel_streams.

This patch compares total streams among two evsel_streams.

Once two streams are fully matched, they will be linked as
a pair. From the pair, we can know which streams are matched.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v6:
   - Rebase to perf/core

 v5:
   - Remove enum stream_type

 v4:
   - New patch in v4.

 tools/perf/util/stream.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stream.h |  4 ++++
 2 files changed, 44 insertions(+)

diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index 7882a7f05d97..e96e21d6e07b 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -157,3 +157,43 @@ struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
 
 	return NULL;
 }
+
+static struct stream *stream_callchain_match(struct stream *base_stream,
+					     struct evsel_streams *es_pair)
+{
+	for (int i = 0; i < es_pair->nr_streams; i++) {
+		struct stream *pair_stream = &es_pair->streams[i];
+
+		if (callchain_cnode_matched(base_stream->cnode,
+					    pair_stream->cnode)) {
+			return pair_stream;
+		}
+	}
+
+	return NULL;
+}
+
+static struct stream *stream_match(struct stream *base_stream,
+				   struct evsel_streams *es_pair)
+{
+	return stream_callchain_match(base_stream, es_pair);
+}
+
+static void stream_link(struct stream *base_stream, struct stream *pair_stream)
+{
+	base_stream->pair_cnode = pair_stream->cnode;
+	pair_stream->pair_cnode = base_stream->cnode;
+}
+
+void match_evsel_streams(struct evsel_streams *es_base,
+			 struct evsel_streams *es_pair)
+{
+	for (int i = 0; i < es_base->nr_streams; i++) {
+		struct stream *base_stream = &es_base->streams[i];
+		struct stream *pair_stream;
+
+		pair_stream = stream_match(base_stream, es_pair);
+		if (pair_stream)
+			stream_link(base_stream, pair_stream);
+	}
+}
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
index 66f61d954eef..2eb6f17a834e 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -6,6 +6,7 @@
 
 struct stream {
 	struct callchain_node	*cnode;
+	struct callchain_node	*pair_cnode;
 };
 
 struct evsel_streams {
@@ -23,4 +24,7 @@ struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
 struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
 					int nr_evsel, int evsel_idx);
 
+void match_evsel_streams(struct evsel_streams *es_base,
+			 struct evsel_streams *es_pair);
+
 #endif /* __PERF_STREAM_H */
-- 
2.17.1

