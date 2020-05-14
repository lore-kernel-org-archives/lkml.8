Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A664C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A93F20728
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgENFix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:38:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:62468 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENFiv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:38:51 -0400
IronPort-SDR: 00B8NHNdQCZKgC1mT5c/ScjSiPQSS64sUEqA6WiJjHddc5a7r00Upw9tOVHSGKc+/s46pf2vaz
 c3DSCg9iGqSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 22:38:51 -0700
IronPort-SDR: XnX1a0KEMLuazqbcENeFXrU4JnnSIgc+zvoXOko9Y1X91fYsASHWj2gidcQt306dDnp7vNxz9d
 CiiHdK0aCS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="287289074"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2020 22:38:48 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 4/5] perf stat: Save aggr value to first member of prev_raw_counts
Date:   Thu, 14 May 2020 13:36:37 +0800
Message-Id: <20200514053638.3736-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514053638.3736-1-yao.jin@linux.intel.com>
References: <20200514053638.3736-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To collect the overall statistics for interval mode, we copy the
counts from evsel->prev_raw_counts to evsel->counts.

For AGGR_GLOBAL mode, because the perf_stat_process_counter creates
aggr values from per cpu values, but the per cpu values are 0,
so the calculated aggr values will be always 0.

This patch uses a trick that saves the previous aggr value to
the first member of perf_counts, then aggr calculation in
process_counter_values can work correctly for AGGR_GLOBAL.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stat.c | 10 ++++++++++
 tools/perf/util/stat.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index aadc723ce871..fbabdd5b9b62 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -249,6 +249,16 @@ void perf_evlist__copy_prev_raw_counts(struct evlist *evlist)
 		perf_evsel__copy_prev_raw_counts(evsel);
 }
 
+void perf_evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		*perf_counts(evsel->prev_raw_counts, 0, 0) =
+			evsel->prev_raw_counts->aggr;
+	}
+}
+
 static void zero_per_pkg(struct evsel *counter)
 {
 	if (counter->per_pkg_mask)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 62cf72c71869..18ead55756cc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -199,6 +199,7 @@ void perf_evlist__free_stats(struct evlist *evlist);
 void perf_evlist__reset_stats(struct evlist *evlist);
 void perf_evlist__reset_prev_raw_counts(struct evlist *evlist);
 void perf_evlist__copy_prev_raw_counts(struct evlist *evlist);
+void perf_evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
-- 
2.17.1

