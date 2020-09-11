Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF4D208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgIKIEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:04:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:7265 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKIEa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:04:30 -0400
IronPort-SDR: rKInKPeulxDphW+mS3X1pybJ3Um6UqMRpuBtXHPtFShD2F6CO+2V/5rihZ01u7jEzoboNtPOR8
 qNSidFA7q00w==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="220268197"
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="220268197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 01:04:29 -0700
IronPort-SDR: 2BUfJJamDDk0+68Z2ElGS2Jd+Sd3l/wY+eCFKxl8XzJeBye0EFiNpFInWbH6NiXzTsBvQ/Ufox
 0FuqoNkZtNfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="342224817"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2020 01:04:27 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 2/7] perf util: Get the evsel_streams by evsel_idx
Date:   Fri, 11 Sep 2020 16:03:48 +0800
Message-Id: <20200911080353.13359-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911080353.13359-1-yao.jin@linux.intel.com>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have created evsel_streams array

This patch returns the specified evsel_streams according to the
evsel_idx.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v6:
   - Rebase to perf/core

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

