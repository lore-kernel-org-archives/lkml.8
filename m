Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C580208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgEZGLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:11:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:16985 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgEZGLg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:11:36 -0400
IronPort-SDR: WeYBoT7mdsE0xCcsfTC8aN58UAuqKyRubJVlW06bxR5g3u1tNv+rghxSu8mcGMETvEvlka8QmI
 ItddAac3D+Yw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 23:11:35 -0700
IronPort-SDR: z9UQCckOyJt6mjENNnQWUwijYTPL/KR5G4uoEMcvdyI6xCMVoH0+FZwzPMWPTDcGjqziKwRAbR
 JeJNQHZY01Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="291068677"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2020 23:11:33 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 4/7] perf util: Link stream pair
Date:   Tue, 26 May 2020 14:09:17 +0800
Message-Id: <20200526060920.26490-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526060920.26490-1-yao.jin@linux.intel.com>
References: <20200526060920.26490-1-yao.jin@linux.intel.com>
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
 tools/perf/util/stream.c | 53 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stream.h |  4 +++
 2 files changed, 57 insertions(+)

diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index 7f538d1085ef..76896a790798 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -161,3 +161,56 @@ struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
 
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
+				   struct evsel_streams *es_pair,
+				   enum stream_type stream_type)
+{
+	if (stream_type == STREAM_CALLCHAIN)
+		return stream_callchain_match(base_stream, es_pair);
+
+	return NULL;
+}
+
+static void stream_link(struct stream *base_stream, struct stream *pair_stream,
+			enum stream_type stream_type)
+{
+	if (stream_type == STREAM_CALLCHAIN) {
+		base_stream->pair_cnode = pair_stream->cnode;
+		pair_stream->pair_cnode = base_stream->cnode;
+	}
+}
+
+void match_evsel_streams(struct evsel_streams *es_base,
+			 struct evsel_streams *es_pair)
+{
+	if (es_base->stream_type != es_pair->stream_type)
+		return;
+
+	for (int i = 0; i < es_base->nr_streams; i++) {
+		struct stream *base_stream = &es_base->streams[i];
+		struct stream *pair_stream;
+
+		pair_stream = stream_match(base_stream, es_pair,
+					   es_base->stream_type);
+		if (pair_stream) {
+			stream_link(base_stream, pair_stream,
+				    es_base->stream_type);
+		}
+	}
+}
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
index 705aa7cde3de..53f34e63f8fb 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -11,6 +11,7 @@ enum stream_type {
 
 struct stream {
 	struct callchain_node	*cnode;
+	struct callchain_node	*pair_cnode;
 };
 
 struct evsel_streams {
@@ -30,4 +31,7 @@ struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
 struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
 					int nr_evsel, int evsel_idx);
 
+void match_evsel_streams(struct evsel_streams *es_base,
+			 struct evsel_streams *es_pair);
+
 #endif /* __PERF_STREAM_H */
-- 
2.17.1

