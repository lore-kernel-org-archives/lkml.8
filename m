Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89679C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693D6207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgGIRhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:35028 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgGIRhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:20 -0400
IronPort-SDR: KHOOLKXDHc4OeF0YfXVQXpI9MR35Q8VC0XT/MYG9fL/t9HZ0Zb2YslQO7VdPsjVCLl/9bqQ9qz
 tmoxr806oMIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537115"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537115"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:19 -0700
IronPort-SDR: KUuUl8mwMN0XJzQUh3KRpGbmxerBrBPJtzKsMgzYCw4fs2DjhdrTeokJLgmBPmZdVRWF0BJcuh
 KGUnhEkkArrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292520"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] perf intel-pt: Use itrace error flags to suppress some errors
Date:   Thu,  9 Jul 2020 20:36:22 +0300
Message-Id: <20200709173628.5613-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709173628.5613-1-adrian.hunter@intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The itrace "e" option may be followed by a number which has the
following effect for Intel PT:
	1	Suppress overflow events
	2	Suppress trace data lost events
The values may be combined by bitwise OR'ing them.

Suppressing those errors can be useful for testing and debugging
because they are not due to decoding.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt |  7 ++++++-
 tools/perf/util/intel-pt.c                 | 12 ++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index f4cd49a7fcdb..0fcd8ad897b0 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -871,7 +871,11 @@ Developer Manuals.
 
 Error events show where the decoder lost the trace.  Error events
 are quite important.  Users must know if what they are seeing is a complete
-picture or not.
+picture or not. The "e" option may be followed by a number which has the
+following effect:
+	1	Suppress overflow events
+	2	Suppress trace data lost events
+The values may be combined by bitwise OR'ing them.
 
 The "d" option will cause the creation of a file "intel_pt.log" containing all
 decoded packets and instructions.  Note that this option slows down the decoder
@@ -956,6 +960,7 @@ at the beginning. This is useful to ignore initialization code.
 
 skips the first million instructions.
 
+
 dump option
 ~~~~~~~~~~~
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 8c441b815d73..a8e8e8acbcc8 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -46,6 +46,9 @@
 
 #define MAX_TIMESTAMP (~0ULL)
 
+#define INTEL_PT_ERR_SUPPRESS_OVF	1
+#define INTEL_PT_ERR_SUPPRESS_LOST	2
+
 struct range {
 	u64 start;
 	u64 end;
@@ -1863,6 +1866,15 @@ static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 	char msg[MAX_AUXTRACE_ERROR_MSG];
 	int err;
 
+	if (pt->synth_opts.error_flags) {
+		if (code == INTEL_PT_ERR_OVR &&
+		    pt->synth_opts.error_flags & INTEL_PT_ERR_SUPPRESS_OVF)
+			return 0;
+		if (code == INTEL_PT_ERR_LOST &&
+		    pt->synth_opts.error_flags & INTEL_PT_ERR_SUPPRESS_LOST)
+			return 0;
+	}
+
 	intel_pt__strerror(code, msg, MAX_AUXTRACE_ERROR_MSG);
 
 	auxtrace_synth_error(&event.auxtrace_error, PERF_AUXTRACE_ERROR_ITRACE,
-- 
2.25.1

