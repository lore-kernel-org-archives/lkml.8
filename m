Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0945C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFD62077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbgDAKSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:18:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:34152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbgDAKR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:58 -0400
IronPort-SDR: 5VVJi+pA4XWT5qW1w7ORkcVq8QN5OLFopRWMr96DgZj9zULMtASJvhm8G+jKcoHc5CZ2c1MKw/
 iDYVoaxy6/og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:56 -0700
IronPort-SDR: yIlEM3giXfDAYSBPIFAGuF1w10PDSK7kJqChFTpXPM2N/TyhnbUOd6rFPaPhziwlpUPKdWgi66
 Ribw1YHC6D5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925581"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:56 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 13/16] perf tools: Move leader-sampling configuration
Date:   Wed,  1 Apr 2020 13:16:10 +0300
Message-Id: <20200401101613.6201-14-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move leader-sampling configuration in preparation for adding support for
leader sampling with AUX area events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evsel.c  | 19 -------------------
 tools/perf/util/record.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4ab073c9fe7..8ddcb95396ac 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1022,25 +1022,6 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		}
 	}
 
-	/*
-	 * Disable sampling for all group members other
-	 * than leader in case leader 'leads' the sampling.
-	 */
-	if ((leader != evsel) && leader->sample_read) {
-		attr->freq           = 0;
-		attr->sample_freq    = 0;
-		attr->sample_period  = 0;
-		attr->write_backward = 0;
-
-		/*
-		 * We don't get sample for slave events, we make them
-		 * when delivering group leader sample. Set the slave
-		 * event to follow the master sample_type to ease up
-		 * report.
-		 */
-		attr->sample_type = leader->core.attr.sample_type;
-	}
-
 	if (opts->no_samples)
 		attr->sample_freq = 0;
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 7def66168503..ce383fc1bbbc 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -167,6 +167,31 @@ bool perf_can_aux_sample(void)
 	return true;
 }
 
+static void perf_evsel__config_leader_sampling(struct evsel *evsel)
+{
+	struct perf_event_attr *attr = &evsel->core.attr;
+	struct evsel *leader = evsel->leader;
+
+	/*
+	 * Disable sampling for all group members other
+	 * than leader in case leader 'leads' the sampling.
+	 */
+	if (leader != evsel && leader->sample_read) {
+		attr->freq           = 0;
+		attr->sample_freq    = 0;
+		attr->sample_period  = 0;
+		attr->write_backward = 0;
+
+		/*
+		 * We don't get sample for slave events, we make them
+		 * when delivering group leader sample. Set the slave
+		 * event to follow the master sample_type to ease up
+		 * report.
+		 */
+		attr->sample_type = leader->core.attr.sample_type;
+	}
+}
+
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain)
 {
@@ -193,6 +218,10 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			evsel->core.attr.comm_exec = 1;
 	}
 
+	/* Configure leader sampling here now that the sample type is known */
+	evlist__for_each_entry(evlist, evsel)
+		perf_evsel__config_leader_sampling(evsel, evlist);
+
 	if (opts->full_auxtrace) {
 		/*
 		 * Need to be able to synthesize and parse selected events with
-- 
2.17.1

