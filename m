Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB85C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761E024681
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCJHDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:03:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:5965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgCJHDj (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:03:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524563"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:03:35 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 03/14] perf util: Return per-event callchain streams
Date:   Tue, 10 Mar 2020 15:02:34 +0800
Message-Id: <20200310070245.16314-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310070245.16314-1-yao.jin@linux.intel.com>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have created a 'struct callchain_streams'
array and each array entry contains per-event callchain streams.

This patch returns the pointer of per-event callchain streams
according to the evsel_idx.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 12 ++++++++++++
 tools/perf/util/callchain.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d9c68a8e7619..31ecc1abe7f9 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1724,3 +1724,15 @@ struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
 	*nr_evsel_streams = nr_evsel;
 	return callchain_streams;
 }
+
+struct callchain_streams *callchain_evsel_streams_get(struct callchain_streams *cs,
+						      int nr_streams_max,
+						      int evsel_idx)
+{
+	for (int i = 0; i < nr_streams_max; i++) {
+		if (cs[i].evsel_idx == evsel_idx)
+			return &cs[i];
+	}
+
+	return NULL;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 5852990cdf60..4e881361e154 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -305,4 +305,8 @@ struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
 							 int nr_streams_max,
 							 int *nr_evsel_streams);
 
+struct callchain_streams *callchain_evsel_streams_get(struct callchain_streams *cs,
+						      int nr_streams_max,
+						      int evsel_idx);
+
 #endif	/* __PERF_CALLCHAIN_H */
-- 
2.17.1

