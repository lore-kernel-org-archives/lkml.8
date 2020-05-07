Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DCFC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7E42075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgEGHAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:00:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:18356 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGHAb (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:00:31 -0400
IronPort-SDR: zNYv7s8aRhR1qPnpUOZhbDObeW5Gxhb3mq4VKE/kzzsopJuwTGvsppcw1QdBp6qfC5vMmRMCWU
 YdEtLY0/UiJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 00:00:31 -0700
IronPort-SDR: KDKhUWDcHFBq/v3j4at9Xjggz7EqLXj0E2bGiZEsZ1l+w+QP7f5XuIpA8IYnMRGfQCZIhC29Xs
 g86o3vQR4wRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="370026111"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 00:00:27 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 2/4] perf counts: Reset prev_raw_counts counts
Date:   Thu,  7 May 2020 14:58:20 +0800
Message-Id: <20200507065822.8255-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507065822.8255-1-yao.jin@linux.intel.com>
References: <20200507065822.8255-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel->prev_raw_counts is updated in perf_evsel__compute_deltas:

perf_evsel__compute_deltas()
{
	tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
	*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
}

When we want to reset the evsel->prev_raw_counts in
perf_evsel__reset_prev_raw_counts, zeroing the aggr is not enough,
we need to reset the counts too.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/counts.c | 5 +++++
 tools/perf/util/counts.h | 2 ++
 tools/perf/util/stat.c   | 1 +
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index f94e1a23dad6..af3bf36f7c63 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -64,3 +64,8 @@ void perf_evsel__free_counts(struct evsel *evsel)
 	perf_counts__delete(evsel->counts);
 	evsel->counts = NULL;
 }
+
+void perf_evsel__reset_raw_counts(struct evsel *evsel)
+{
+	perf_counts__reset(evsel->prev_raw_counts);
+}
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 92196df4945f..15bb9acb7cb0 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -42,4 +42,6 @@ void perf_evsel__reset_counts(struct evsel *evsel);
 int perf_evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__free_counts(struct evsel *evsel);
 
+void perf_evsel__reset_raw_counts(struct evsel *evsel);
+
 #endif /* __PERF_COUNTS_H */
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 774468341851..89e541564ed5 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -168,6 +168,7 @@ static void perf_evsel__reset_prev_raw_counts(struct evsel *evsel)
 		evsel->prev_raw_counts->aggr.val = 0;
 		evsel->prev_raw_counts->aggr.ena = 0;
 		evsel->prev_raw_counts->aggr.run = 0;
+		perf_evsel__reset_raw_counts(evsel);
        }
 }
 
-- 
2.17.1

