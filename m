Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C58C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE71221F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgD2PIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:08:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:48789 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbgD2PHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:07:38 -0400
IronPort-SDR: 9E5Zse7FsK1U0PY5XlTQiLAfjziFSSxoLCa1NwFfwUK7GXqucUc7AhCcsQUGXkJNKF6n1qZwL1
 ZrDMuv1k4z/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:07:37 -0700
IronPort-SDR: vsLLwu+FX2wqgr6iijNMfEZS2x9lTbHiXLM1/qdIy9HRCD/3fkSV2w4jN8xVBAalDUWO+ShPsy
 omVEnMRVeM9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="293227426"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2020 08:07:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] perf evsel: Add support for synthesized branch stack sample type
Date:   Wed, 29 Apr 2020 18:07:47 +0300
Message-Id: <20200429150751.12570-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429150751.12570-1-adrian.hunter@intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for a synthesized branch stack to be added to samples. As with
synthesized call chains, the sample type cannot be changed because it is
needed to continue to parse events. So add and use helper function
evsel__has_br_stack() to indicate a branch stack, whether original or
synthesized.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evsel.h   | 10 ++++++++++
 tools/perf/util/session.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a463bc65b001..bf999e3c50c7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -417,6 +417,16 @@ static inline bool evsel__has_callchain(const struct evsel *evsel)
 	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
+static inline bool evsel__has_br_stack(const struct evsel *evsel)
+{
+	/*
+	 * For reporting purposes, an evsel sample can have a recorded branch
+	 * stack or a branch stack synthesized from AUX area data.
+	 */
+	return evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK ||
+	       evsel->synth_sample_type & PERF_SAMPLE_BRANCH_STACK;
+}
+
 struct perf_env *perf_evsel__env(struct evsel *evsel);
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0b0bfe5bef17..2b5a08a92ce5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1243,7 +1243,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+	if (evsel__has_br_stack(evsel))
 		branch_stack__printf(sample, perf_evsel__has_branch_callstack(evsel));
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
-- 
2.17.1

