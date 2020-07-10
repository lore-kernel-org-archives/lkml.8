Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11280C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA97720725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGJPQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:16:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:38299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbgGJPMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:12:05 -0400
IronPort-SDR: OirmcublcAty+WGIK6SgMGpYFAb7ZwxhG+4fiKA3tUDejNRb/hDWIeNClQrlBShpiZXbUJ0nQC
 YgT9Pmhcsmdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686400"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:12:04 -0700
IronPort-SDR: ApfvsZB5EqAcaqU1HXnKmDQDdQAtqXkPPh3Ju3vXoWYQGqgoZMWFJA6Ucw5KkGTWjeioXaYqAk
 +QD2j4YNWctw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675542"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:12:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/12] perf intel-pt: Time filter logged perf events
Date:   Fri, 10 Jul 2020 18:11:01 +0300
Message-Id: <20200710151104.15137-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the debug logging (when used with the --time option) to time filter
logged perf events, but allow that to be overridden by using "d+a" instead
of plain "d".

That can reduce the size of the log file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt |  3 +++
 tools/perf/util/intel-pt.c                 | 19 ++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index d22dead7bbe0..4666e4a83615 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -886,6 +886,9 @@ and that the resulting file may be very large.  The "d" option may be followed
 by flags which affect what debug messages will or will not be logged. Each flag
 must be preceded by either '+' or '-'. The flags support by Intel PT are:
 		-a	Suppress logging of perf events
+		+a	Log all perf events
+By default, logged perf events are filtered by any specified time ranges, but
+flag +a overrides that.
 
 In addition, the period of the "instructions" event can be specified. e.g.
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 34caf24998dd..bddeb18648df 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -249,9 +249,22 @@ static void intel_pt_dump_sample(struct perf_session *session,
 	intel_pt_dump(pt, sample->aux_sample.data, sample->aux_sample.size);
 }
 
-static bool intel_pt_log_events(struct intel_pt *pt)
+static bool intel_pt_log_events(struct intel_pt *pt, u64 tm)
 {
-	return !(pt->synth_opts.log_minus_flags & AUXTRACE_LOG_FLG_ALL_PERF_EVTS);
+	struct perf_time_interval *range = pt->synth_opts.ptime_range;
+	int n = pt->synth_opts.range_num;
+
+	if (pt->synth_opts.log_plus_flags & AUXTRACE_LOG_FLG_ALL_PERF_EVTS)
+		return true;
+
+	if (pt->synth_opts.log_minus_flags & AUXTRACE_LOG_FLG_ALL_PERF_EVTS)
+		return false;
+
+	/* perf_time__ranges_skip_sample does not work if time is zero */
+	if (!tm)
+		tm = 1;
+
+	return !n || !perf_time__ranges_skip_sample(range, n, tm);
 }
 
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
@@ -2746,7 +2759,7 @@ static int intel_pt_process_event(struct perf_session *session,
 	if (!err && event->header.type == PERF_RECORD_TEXT_POKE)
 		err = intel_pt_text_poke(pt, event);
 
-	if (intel_pt_enable_logging && intel_pt_log_events(pt)) {
+	if (intel_pt_enable_logging && intel_pt_log_events(pt, sample->time)) {
 		intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
 			     event->header.type, sample->cpu, sample->time, timestamp);
 		intel_pt_log_event(event);
-- 
2.17.1

