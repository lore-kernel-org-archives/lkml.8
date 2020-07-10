Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9CBC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB9B2065D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGJPRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:17:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:38267 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgGJPMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:12:07 -0400
IronPort-SDR: s6kN79zbqKHNE38P+IAimxqsWCXM9Bjwp+mTVH2Jc5M7a3Q8l8gOXkWwzEkDkq1xBczCToTL16
 ZQcchkcvj6Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686422"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:12:06 -0700
IronPort-SDR: i16w8FlEiNh1RldoStAEaftJEKdDA1oLPZLXC2fGhCAtmU8jmUyT7nB0v/AwoZrxVkNQmx097Y
 3KIZt62WWMrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675552"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:12:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/12] perf auxtrace: Add itrace 'q' option for quicker, less detailed decoding
Date:   Fri, 10 Jul 2020 18:11:02 +0300
Message-Id: <20200710151104.15137-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'q' option is for modes of decoding that are quicker because they
skip or omit decoding some aspects of trace data.

If supported, the 'q' option may be repeated to increase the effect.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt | 3 +++
 tools/perf/util/auxtrace.c          | 3 +++
 tools/perf/util/auxtrace.h          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 9c0e8586ed47..d3740c8f399b 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -18,6 +18,7 @@
 		l	synthesize last branch entries (use with i or x)
 		L	synthesize last branch entries on existing event records
 		s       skip initial number of events
+		q	quicker (less detailed) decoding
 
 	The default is all events i.e. the same as --itrace=ibxwpe,
 	except for perf script where it is --itrace=ce
@@ -58,3 +59,5 @@
 	debug messages will or will not be logged. Each flag must be preceded
 	by either '+' or '-'. The flags are:
 		a	all perf events
+
+	If supported, the 'q' option may be repeated to increase the effect.
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e028187c51fe..42a85c86421d 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1554,6 +1554,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 		case 'a':
 			synth_opts->remote_access = true;
 			break;
+		case 'q':
+			synth_opts->quick += 1;
+			break;
 		case ' ':
 		case ',':
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 821ef5446a13..951d2d14cf24 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -100,6 +100,7 @@ enum itrace_period_type {
  * @error_minus_flags: flags to affect what errors are reported
  * @log_plus_flags: flags to affect what is logged
  * @log_minus_flags: flags to affect what is logged
+ * @quick: quicker (less detailed) decoding
  */
 struct itrace_synth_opts {
 	bool			set;
@@ -137,6 +138,7 @@ struct itrace_synth_opts {
 	unsigned int		error_minus_flags;
 	unsigned int		log_plus_flags;
 	unsigned int		log_minus_flags;
+	unsigned int		quick;
 };
 
 /**
@@ -642,6 +644,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				l[len]:     		synthesize last branch entries (use with i or x)\n" \
 "				L[len]:			synthesize last branch entries on existing event records\n" \
 "				sNUMBER:    		skip initial number of events\n"		\
+"				q:			quicker (less detailed) decoding\n" \
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
 "				concatenate multiple options. Default is ibxwpe or cewp\n"
 
-- 
2.17.1

