Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AF3C54F70
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEF022244
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDTBHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:07:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:62984 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgDTBHE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:07:04 -0400
IronPort-SDR: MqMSTn2zMZYZthSafUtDvLqrl/M4z2UP+bc6JpOGh3Dns5gXmgGIKJ+hhl3XzNdjRqnpq2VY0M
 mmUTeD/ZL79Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 18:07:04 -0700
IronPort-SDR: PjJypzSdi2HOTELPQw+KkxosxeoMSbFJr3UwGsh0tkclkB9s7kg77tBKOJkztTPXwCZCJsZjYC
 kMW2kdl1ZgaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="364855003"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2020 18:07:01 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 3/7] perf util: Return per-event callchain streams
Date:   Mon, 20 Apr 2020 09:04:47 +0800
Message-Id: <20200420010451.24405-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420010451.24405-1-yao.jin@linux.intel.com>
References: <20200420010451.24405-1-yao.jin@linux.intel.com>
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
index 0c028caaeb19..bf66f33debd4 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1721,3 +1721,15 @@ struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
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
index 6a93ad84d395..6ff9d86d74d3 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -313,4 +313,8 @@ struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
 							 int nr_streams_max,
 							 int *nr_evsel_streams);
 
+struct callchain_streams *callchain_evsel_streams_get(struct callchain_streams *cs,
+						      int nr_streams_max,
+						      int evsel_idx);
+
 #endif	/* __PERF_CALLCHAIN_H */
-- 
2.17.1

