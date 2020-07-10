Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81261C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6479D2065D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGJPP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:15:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:38264 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgGJPL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:11:59 -0400
IronPort-SDR: SR7gP8FbT1lJcDs1kMc9nAwjscGWHcqESmNaEeYS4KiJmZij44KHhEgxcvqJlVbFub3Ie2+aTz
 Yd54W747V/AA==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686314"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:11:58 -0700
IronPort-SDR: ERac0KsH8rDYb6wE9CiXgD83MZHzMxGi9MHpmN6pq+vAY5ZTGpqeoNO3synewSy9+/z9vy33ph
 LW1zZYUlPSKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675506"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:11:56 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 06/12] perf intel-pt: Use itrace error flags to suppress some errors
Date:   Fri, 10 Jul 2020 18:10:58 +0300
Message-Id: <20200710151104.15137-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The itrace "e" option may be followed by flags which affect what errors
will or will not be reported.  Each flag must be preceded by either '+' or '-'.
The flags supported by Intel PT are:
		-o	Suppress overflow errors
		-l	Suppress trace data lost errors
For example, for errors but not overflow or data lost errors:

	--itrace=e-o-l

Suppressing those errors can be useful for testing and debugging
because they are not due to decoding.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 9 ++++++++-
 tools/perf/util/intel-pt.c                 | 9 +++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index f4cd49a7fcdb..20ac592a2641 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -871,7 +871,14 @@ Developer Manuals.
 
 Error events show where the decoder lost the trace.  Error events
 are quite important.  Users must know if what they are seeing is a complete
-picture or not.
+picture or not. The "e" option may be followed by flags which affect what errors
+will or will not be reported.  Each flag must be preceded by either '+' or '-'.
+The flags supported by Intel PT are:
+		-o	Suppress overflow errors
+		-l	Suppress trace data lost errors
+For example, for errors but not overflow or data lost errors:
+
+	--itrace=e-o-l
 
 The "d" option will cause the creation of a file "intel_pt.log" containing all
 decoded packets and instructions.  Note that this option slows down the decoder
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f09d4cfcd0fd..a1cb6a284a2b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1862,6 +1862,15 @@ static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 	char msg[MAX_AUXTRACE_ERROR_MSG];
 	int err;
 
+	if (pt->synth_opts.error_minus_flags) {
+		if (code == INTEL_PT_ERR_OVR &&
+		    pt->synth_opts.error_minus_flags & AUXTRACE_ERR_FLG_OVERFLOW)
+			return 0;
+		if (code == INTEL_PT_ERR_LOST &&
+		    pt->synth_opts.error_minus_flags & AUXTRACE_ERR_FLG_DATA_LOST)
+			return 0;
+	}
+
 	intel_pt__strerror(code, msg, MAX_AUXTRACE_ERROR_MSG);
 
 	auxtrace_synth_error(&event.auxtrace_error, PERF_AUXTRACE_ERROR_ITRACE,
-- 
2.17.1

