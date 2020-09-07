Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E2C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D0521775
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIGEQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 00:16:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:58719 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbgIGEQx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:16:53 -0400
IronPort-SDR: +4hNBy4KbWpeX4FIHaXBLuGjfLyiI91WPtl1F25ODdf7P+ZLN5L4daqw5/W+hXhOdBpZRhH1vA
 NTALiAi4inUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157215556"
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="157215556"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 21:16:53 -0700
IronPort-SDR: /1N+pY4NZGOh3DnzWjqZGq/ij2hOY7AZQCv2/3vxyG+vus2D726hZBYG0Bzf9sJ12YiTlru4MA
 ikGs5zfMzXiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="406709935"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2020 21:16:50 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 4/7] perf util: Link stream pair
Date:   Mon,  7 Sep 2020 12:16:03 +0800
Message-Id: <20200907041606.14500-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907041606.14500-1-yao.jin@linux.intel.com>
References: <20200907041606.14500-1-yao.jin@linux.intel.com>
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

