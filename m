Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEAE2176B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIGEQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 00:16:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:58716 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgIGEQs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:16:48 -0400
IronPort-SDR: RTk6AYm8P8ncqRnDqXPLShHa1EplN7taWCaOPMz+ln7Cln6aEZ9VU1fBip2vuRlYEjMVblbb+I
 lpgLnra+85Ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157215550"
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="157215550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 21:16:48 -0700
IronPort-SDR: Qcq4kksz5s7aVAj8VjOAc7gjv8FR0hTulaQKx/9Wu7xTsv2ZA7q9Z6BzNNdmaYlUvsXVL2+fgf
 eg3JatYWm3iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="406709923"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2020 21:16:45 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 2/7] perf util: Get the evsel_streams by evsel_idx
Date:   Mon,  7 Sep 2020 12:16:01 +0800
Message-Id: <20200907041606.14500-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907041606.14500-1-yao.jin@linux.intel.com>
References: <20200907041606.14500-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have created evsel_streams array

This patch returns the specified evsel_streams according to the
evsel_idx.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v5:
   - Rebase to perf/core

 v4:
   - Rename the patch from 'perf util: Return per-event callchain
     streams' to 'perf util: Get the evsel_streams by evsel_idx'

 tools/perf/util/stream.c | 11 +++++++++++
 tools/perf/util/stream.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index 015c1d07ce3a..7882a7f05d97 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -146,3 +146,14 @@ struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
 
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
index c6844c5787cb..66f61d954eef 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -20,4 +20,7 @@ struct evlist;
 struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
 						  int nr_streams_max);
 
+struct evsel_streams *evsel_streams_get(struct evsel_streams *es,
+					int nr_evsel, int evsel_idx);
+
 #endif /* __PERF_STREAM_H */
-- 
2.17.1

