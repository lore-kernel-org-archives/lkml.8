Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1627C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A15E2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbgDAKSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:18:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:34142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732107AbgDAKRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:37 -0400
IronPort-SDR: atT5Zg3jGFF9iubidjsOz3xN+ctbkEYSQ41OWZP4rCGfh7ZgvVAg6bUC+xi7f1m3GxXmZFogZ5
 91IUmESrkv/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:35 -0700
IronPort-SDR: Yc0jM+nwpjLWF3jKghwbK38EuNfAN3bUyNS3s5T4z6MuvnipWAJq7SvhqXl8W9pk04aN/J3c5H
 N5IeMufU0Txg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925478"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 02/16] perf intel-pt: Implement ->evsel_is_auxtrace() callback
Date:   Wed,  1 Apr 2020 13:15:59 +0300
Message-Id: <20200401101613.6201-3-adrian.hunter@intel.com>
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
 tools/perf/util/intel-pt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 23c8289c2472..db25c77d82f3 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2715,6 +2715,15 @@ static void intel_pt_free(struct perf_session *session)
 	free(pt);
 }
 
+static bool intel_pt_evsel_is_auxtrace(struct perf_session *session,
+				       struct evsel *evsel)
+{
+	struct intel_pt *pt = container_of(session->auxtrace, struct intel_pt,
+					   auxtrace);
+
+	return evsel->core.attr.type == pt->pmu_type;
+}
+
 static int intel_pt_process_auxtrace_event(struct perf_session *session,
 					   union perf_event *event,
 					   struct perf_tool *tool __maybe_unused)
@@ -3310,6 +3319,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	pt->auxtrace.flush_events = intel_pt_flush;
 	pt->auxtrace.free_events = intel_pt_free_events;
 	pt->auxtrace.free = intel_pt_free;
+	pt->auxtrace.evsel_is_auxtrace = intel_pt_evsel_is_auxtrace;
 	session->auxtrace = &pt->auxtrace;
 
 	if (dump_trace)
-- 
2.17.1

