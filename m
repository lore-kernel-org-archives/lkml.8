Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DADC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E67207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgGIRh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:35052 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbgGIRhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:25 -0400
IronPort-SDR: FwthGTYHAGmXzb0h1m5KAxzlmxHNWC/5Q9h7yuqf/RwkC33Ki/LaIWiFfIxyqRxLHqW4+/UJAd
 TlAoRDIDbR1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537123"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537123"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:25 -0700
IronPort-SDR: 4HJWQ4vpriCUJISuEbqJhhqnYCHT40uFpgLYZaYfh+cwsvTqTn+uGQhui/Go6dCWvzrttvqRZF
 iE7soN4prtYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292543"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] perf intel-pt: Time filter logged perf events
Date:   Thu,  9 Jul 2020 20:36:25 +0300
Message-Id: <20200709173628.5613-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709173628.5613-1-adrian.hunter@intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the debug logging (when used with the --time option) to time filter
logged perf events, but allow that to be overridden by using "d2" instead
of plain "d".

By default that can greatly reduce the size of the log file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt |  3 +++
 tools/perf/util/intel-pt.c                 | 20 +++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 85a2ff804900..9a90e2db4e4a 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -882,6 +882,9 @@ decoded packets and instructions.  Note that this option slows down the decoder
 and that the resulting file may be very large.  The "d" option may be followed
 by a number which has the following effect:
 	1	Suppress logging of perf events
+	2	Log all perf events
+By default, logged perf events are filtered by any specified time ranges, but
+value 2 overrides that.
 
 In addition, the period of the "instructions" event can be specified. e.g.
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index d90375659244..597120dd6b77 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -50,6 +50,7 @@
 #define INTEL_PT_ERR_SUPPRESS_LOST	2
 
 #define INTEL_PT_LOG_SUPPRESS_EV	1
+#define INTEL_PT_LOG_ALL_EV		2
 
 struct range {
 	u64 start;
@@ -254,9 +255,22 @@ static void intel_pt_dump_sample(struct perf_session *session,
 	intel_pt_dump(pt, sample->aux_sample.data, sample->aux_sample.size);
 }
 
-static bool intel_pt_log_events(struct intel_pt *pt)
+static bool intel_pt_log_events(struct intel_pt *pt, u64 tm)
 {
-	return !(pt->synth_opts.log_flags & INTEL_PT_LOG_SUPPRESS_EV);
+	struct perf_time_interval *range = pt->synth_opts.ptime_range;
+	int n = pt->synth_opts.range_num;
+
+	if (pt->synth_opts.log_flags & INTEL_PT_LOG_ALL_EV)
+		return true;
+
+	if (pt->synth_opts.log_flags & INTEL_PT_LOG_SUPPRESS_EV)
+		return false;
+
+	/* perf_time__ranges_skip_sample does not work if time is zero */
+	if (!tm)
+		tm = 1;
+
+	return !n || !perf_time__ranges_skip_sample(range, n, tm);
 }
 
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
@@ -2752,7 +2766,7 @@ static int intel_pt_process_event(struct perf_session *session,
 	if (!err && event->header.type == PERF_RECORD_TEXT_POKE)
 		err = intel_pt_text_poke(pt, event);
 
-	if (intel_pt_enable_logging && intel_pt_log_events(pt)) {
+	if (intel_pt_enable_logging && intel_pt_log_events(pt, sample->time)) {
 		intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
 			     event->header.type, sample->cpu, sample->time, timestamp);
 		intel_pt_log_event(event);
-- 
2.25.1

