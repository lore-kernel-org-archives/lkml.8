Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E96D2177B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgHYHGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:06:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:4094 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbgHYHGp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:06:45 -0400
IronPort-SDR: U+wygdyjwA3W9VvbkGWr7Tv9w8MhSyDchQsMhfnacVTiAB2bPgTAnjfn+RPPK7w+X3QOIKU5OJ
 8vy3pu2gYDgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156050059"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="156050059"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 00:06:44 -0700
IronPort-SDR: RBrB9AVilkTmbZCFTa+/JpiKC4cm9x6Fg/pN88NmQiNti/uwI0jUH1bqUAd4l2qJYybfghjDZL
 PHaayIZqeAAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="322655044"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2020 00:06:40 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 2/7] perf util: Get the evsel_streams by evsel_idx
Date:   Tue, 25 Aug 2020 07:35:08 +0800
Message-Id: <20200824233513.16930-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824233513.16930-1-yao.jin@linux.intel.com>
References: <20200824233513.16930-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have created evsel_streams array

This patch returns the specified evsel_streams according to the
evsel_idx.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v4:
   - Rename the patch from 'perf util: Return per-event callchain
     streams' to 'perf util: Get the evsel_streams by evsel_idx'

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

