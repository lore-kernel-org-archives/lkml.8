Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE2C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2D120748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgGJPSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:18:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:38267 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgGJPME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:12:04 -0400
IronPort-SDR: WYkjGxM5hHPLZV4YJq6qF0TxbePVTETW1lJip9Fp3/I6f30lPLCjGYQ1uslwU+JgsvPj9bVn9n
 1/cDxBz7smcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686384"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686384"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:12:03 -0700
IronPort-SDR: veqy4n/Rj54j8x8wW7EBJaiXpsujaC/fZiCHwe5yyxCwPDDso1d/Xg0UIRudnW8fn48dn+wJbR
 cqEdtmfV+Zhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675532"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:11:59 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/12] perf intel-pt: Use itrace debug log flags to suppress some messages
Date:   Fri, 10 Jul 2020 18:11:00 +0300
Message-Id: <20200710151104.15137-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "d" option may be followed by flags which affect what debug messages
will or will not be logged. Each flag must be preceded by either '+' or
'-'. The flags support by Intel PT are:
		-a	Suppress logging of perf events

Suppressing perf events is useful for decreasing the size of the log.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt |  5 ++++-
 tools/perf/util/intel-pt.c                 | 17 ++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 20ac592a2641..d22dead7bbe0 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -882,7 +882,10 @@ For example, for errors but not overflow or data lost errors:
 
 The "d" option will cause the creation of a file "intel_pt.log" containing all
 decoded packets and instructions.  Note that this option slows down the decoder
-and that the resulting file may be very large.
+and that the resulting file may be very large.  The "d" option may be followed
+by flags which affect what debug messages will or will not be logged. Each flag
+must be preceded by either '+' or '-'. The flags support by Intel PT are:
+		-a	Suppress logging of perf events
 
 In addition, the period of the "instructions" event can be specified. e.g.
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a1cb6a284a2b..34caf24998dd 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -249,6 +249,11 @@ static void intel_pt_dump_sample(struct perf_session *session,
 	intel_pt_dump(pt, sample->aux_sample.data, sample->aux_sample.size);
 }
 
+static bool intel_pt_log_events(struct intel_pt *pt)
+{
+	return !(pt->synth_opts.log_minus_flags & AUXTRACE_LOG_FLG_ALL_PERF_EVTS);
+}
+
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
 				   struct auxtrace_buffer *b)
 {
@@ -2585,10 +2590,6 @@ static int intel_pt_context_switch(struct intel_pt *pt, union perf_event *event,
 		return -EINVAL;
 	}
 
-	intel_pt_log("context_switch: cpu %d pid %d tid %d time %"PRIu64" tsc %#"PRIx64"\n",
-		     cpu, pid, tid, sample->time, perf_time_to_tsc(sample->time,
-		     &pt->tc));
-
 	ret = intel_pt_sync_switch(pt, cpu, tid, sample->time);
 	if (ret <= 0)
 		return ret;
@@ -2745,9 +2746,11 @@ static int intel_pt_process_event(struct perf_session *session,
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
2.17.1

