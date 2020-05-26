Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CC1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D59D2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEZGLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:11:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:16985 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgEZGLa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:11:30 -0400
IronPort-SDR: bLpxva0z5o6wGxfvo0f7MTeVaAb53dd+/o8nTxL7MJhD0U6IWA3ymXX9w4qbKPD9buBz1qNnCh
 LRNGFdvWw3wA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 23:11:30 -0700
IronPort-SDR: ggPVnra1YiL9FcDj7MM/MZcBJEkLBE22FRtnfbV3asmP6twvWgzyi5LePll5j87WnnifYy9L+M
 5jJtE3ClCWOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="291068663"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2020 23:11:28 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 2/7] perf util: Get the evsel_streams by evsel_idx
Date:   Tue, 26 May 2020 14:09:15 +0800
Message-Id: <20200526060920.26490-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526060920.26490-1-yao.jin@linux.intel.com>
References: <20200526060920.26490-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have created evsel_streams array

This patch returns the specified evsel_streams according to the
evsel_idx.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stream.c | 11 +++++++++++
 tools/perf/util/stream.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index 327a00c27ae2..7f538d1085ef 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -150,3 +150,14 @@ struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
 
 	return es;
 }
+
+struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
+					int nr_evsel, int evsel_idx)
+{
+	for (int i = 0; i < nr_evsel; i++) {
+		if (es[i].evsel_idx == evsel_idx)
+			return &es[i];
+	}
+
+	return NULL;
+}
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
index a8a0172b4d13..705aa7cde3de 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -27,4 +27,7 @@ struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
 						  int nr_streams_max,
 						  enum stream_type type);
 
+struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
+					int nr_evsel, int evsel_idx);
+
 #endif /* __PERF_STREAM_H */
-- 
2.17.1

