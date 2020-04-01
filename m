Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403BDC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D08A2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbgDAKRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:34142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732153AbgDAKRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:39 -0400
IronPort-SDR: Eds6tECmaAQ/flqNfzSs5sB9D7rHGoOTAKCuyeUQfd5wD6XMJELlpNI6ZeT+ut2Kk3PNeCKqeW
 NA/ZL2J337sw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:37 -0700
IronPort-SDR: px4/iN8a+fHSXbS/5BWyynh9IPCvse0hzDGlrJN8mW9hqjlQq3CLnJxD47pV2cRgnIgpPGfyE3
 0pFy4RLOl14g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925488"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/16] perf intel-bts: Implement ->evsel_is_auxtrace() callback
Date:   Wed,  1 Apr 2020 13:16:00 +0300
Message-Id: <20200401101613.6201-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-bts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 34cb380d19a3..059e1c805ed0 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -728,6 +728,15 @@ static void intel_bts_free(struct perf_session *session)
 	free(bts);
 }
 
+static bool intel_bts_evsel_is_auxtrace(struct perf_session *session,
+					struct evsel *evsel)
+{
+	struct intel_bts *bts = container_of(session->auxtrace, struct intel_bts,
+					     auxtrace);
+
+	return evsel->core.attr.type == bts->pmu_type;
+}
+
 struct intel_bts_synth {
 	struct perf_tool dummy_tool;
 	struct perf_session *session;
@@ -883,6 +892,7 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	bts->auxtrace.flush_events = intel_bts_flush;
 	bts->auxtrace.free_events = intel_bts_free_events;
 	bts->auxtrace.free = intel_bts_free;
+	bts->auxtrace.evsel_is_auxtrace = intel_bts_evsel_is_auxtrace;
 	session->auxtrace = &bts->auxtrace;
 
 	intel_bts_print_info(&auxtrace_info->priv[0], INTEL_BTS_PMU_TYPE,
-- 
2.17.1

