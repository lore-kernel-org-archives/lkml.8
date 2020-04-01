Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DF1C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244712077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbgDAKRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:34152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732241AbgDAKRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:53 -0400
IronPort-SDR: uwi6iFDb35GfQlhMkXMJzPEcpkKT79yxIogyq33fmBlJzV9DCWfcFSughCp9JN0nST+qMYDAc8
 rOlu+CtyCBmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:51 -0700
IronPort-SDR: HQ7ev7S2ehkI8t6nWVEsj3HbOqEu2Dgcd6qYrTN8Q6LOTLRxoqgdjtB5jXIBm/zt8sROevLHTE
 Q5lMBiQ9mjew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925558"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:51 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/16] perf tools: Add support for synthesized sample type
Date:   Wed,  1 Apr 2020 13:16:07 +0300
Message-Id: <20200401101613.6201-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For reporting purposes, an evsel sample can have a callchain synthesized
from AUX area data. Add support for keeping track of synthesized sample
types. Note, the recorded sample_type cannot be changed because it is
needed to continue to parse events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evsel.c |  2 +-
 tools/perf/util/evsel.h | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index eb880efbce16..60e6cd49dee3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2136,7 +2136,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		}
 	}
 
-	if (evsel__has_callchain(evsel)) {
+	if (type & PERF_SAMPLE_CALLCHAIN) {
 		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
 
 		OVERFLOW_CHECK_u64(array);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 53187c501ee8..e64ed4202cab 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -104,6 +104,14 @@ struct evsel {
 		perf_evsel__sb_cb_t	*cb;
 		void			*data;
 	} side_band;
+	/*
+	 * For reporting purposes, an evsel sample can have a callchain
+	 * synthesized from AUX area data. Keep track of synthesized sample
+	 * types here. Note, the recorded sample_type cannot be changed because
+	 * it is needed to continue to parse events.
+	 * See also evsel__has_callchain().
+	 */
+	__u64			synth_sample_type;
 };
 
 struct perf_missing_features {
@@ -398,7 +406,12 @@ static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
 
 static inline bool evsel__has_callchain(const struct evsel *evsel)
 {
-	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
+	/*
+	 * For reporting purposes, an evsel sample can have a recorded callchain
+	 * or a callchain synthesized from AUX area data.
+	 */
+	return evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN ||
+	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
 struct perf_env *perf_evsel__env(struct evsel *evsel);
-- 
2.17.1

