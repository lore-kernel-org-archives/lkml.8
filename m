Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ABCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23552078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgGIRhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:35049 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgGIRhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:24 -0400
IronPort-SDR: 9tV5OWgi0b+lb5GrqdI80F3Mn0RvxQVWKO7yyTcOObAQWiHsBWxCbw6vvKQ+8GzHaMBF0RoWRS
 sivc+QO6SJRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537119"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537119"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:23 -0700
IronPort-SDR: MyOIw6DR4grQCECVCxcasxesRdxlEbN5j6ffOXjQWPmLwgOge6otTvbkqKQsqvPHoH1BLqSQ2Z
 lORKUYtaPV5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292536"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:21 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] perf intel-pt: Use itrace debug log flags to suppress some messages
Date:   Thu,  9 Jul 2020 20:36:24 +0300
Message-Id: <20200709173628.5613-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709173628.5613-1-adrian.hunter@intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "d" option may be followed by a number which has the following effect:
	1	Suppress logging of perf events

Suppressing perf events is useful for decreasing the size of the log.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt |  4 +++-
 tools/perf/util/intel-pt.c                 | 19 ++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 0fcd8ad897b0..85a2ff804900 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -879,7 +879,9 @@ The values may be combined by bitwise OR'ing them.
 
 The "d" option will cause the creation of a file "intel_pt.log" containing all
 decoded packets and instructions.  Note that this option slows down the decoder
-and that the resulting file may be very large.
+and that the resulting file may be very large.  The "d" option may be followed
+by a number which has the following effect:
+	1	Suppress logging of perf events
 
 In addition, the period of the "instructions" event can be specified. e.g.
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a8e8e8acbcc8..d90375659244 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -49,6 +49,8 @@
 #define INTEL_PT_ERR_SUPPRESS_OVF	1
 #define INTEL_PT_ERR_SUPPRESS_LOST	2
 
+#define INTEL_PT_LOG_SUPPRESS_EV	1
+
 struct range {
 	u64 start;
 	u64 end;
@@ -252,6 +254,11 @@ static void intel_pt_dump_sample(struct perf_session *session,
 	intel_pt_dump(pt, sample->aux_sample.data, sample->aux_sample.size);
 }
 
+static bool intel_pt_log_events(struct intel_pt *pt)
+{
+	return !(pt->synth_opts.log_flags & INTEL_PT_LOG_SUPPRESS_EV);
+}
+
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
 				   struct auxtrace_buffer *b)
 {
@@ -2589,10 +2596,6 @@ static int intel_pt_context_switch(struct intel_pt *pt, union perf_event *event,
 		return -EINVAL;
 	}
 
-	intel_pt_log("context_switch: cpu %d pid %d tid %d time %"PRIu64" tsc %#"PRIx64"\n",
-		     cpu, pid, tid, sample->time, perf_time_to_tsc(sample->time,
-		     &pt->tc));
-
 	ret = intel_pt_sync_switch(pt, cpu, tid, sample->time);
 	if (ret <= 0)
 		return ret;
@@ -2749,9 +2752,11 @@ static int intel_pt_process_event(struct perf_session *session,
 	if (!err && event->header.type == PERF_RECORD_TEXT_POKE)
 		err = intel_pt_text_poke(pt, event);
 
-	intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
-		     event->header.type, sample->cpu, sample->time, timestamp);
-	intel_pt_log_event(event);
+	if (intel_pt_enable_logging && intel_pt_log_events(pt)) {
+		intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
+			     event->header.type, sample->cpu, sample->time, timestamp);
+		intel_pt_log_event(event);
+	}
 
 	return err;
 }
-- 
2.25.1

