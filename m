Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7211620748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGJPO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:14:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:38267 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbgGJPMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:12:02 -0400
IronPort-SDR: iE0qdStwdY7IXW1/fdJorK6mR5IpU2PUkCjHSaYVqqwv/s+Jg9Es4sjSaBN0XTSees+1XzqNeA
 Jy7GatGx4h1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686338"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686338"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:11:59 -0700
IronPort-SDR: IKlGdx6I4KO/QrkEOiY+7CfkJTf0TPBnrsD2OYsKSg7uh82GxmyksdO4wqZ70O7X94B57E613d
 oOB0IFsJa7Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675520"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:11:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/12] perf auxtrace: Add optional log flags to the itrace 'd' option
Date:   Fri, 10 Jul 2020 18:10:59 +0300
Message-Id: <20200710151104.15137-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the 'd' option to be followed by flags which will affect what debug
messages will or will not be reported. Each flag must be preceded by either
'+' or '-'. The flags are:
	a	all perf events

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt |  5 +++++
 tools/perf/util/auxtrace.c          |  3 +++
 tools/perf/util/auxtrace.h          | 10 +++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 114d0544d7c7..9c0e8586ed47 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -53,3 +53,8 @@
 	The flags are:
 		o	overflow
 		l	trace data lost
+
+	If supported, the 'd' option may be followed by flags which affect what
+	debug messages will or will not be logged. Each flag must be preceded
+	by either '+' or '-'. The flags are:
+		a	all perf events
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index f0b0758830ee..e028187c51fe 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1483,6 +1483,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			break;
 		case 'd':
 			synth_opts->log = true;
+			if (get_flags(&p, &synth_opts->log_plus_flags,
+				      &synth_opts->log_minus_flags))
+				goto out_err;
 			break;
 		case 'c':
 			synth_opts->branches = true;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index cfe6d00d8624..821ef5446a13 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -58,6 +58,8 @@ enum itrace_period_type {
 #define AUXTRACE_ERR_FLG_OVERFLOW	(1 << ('o' - 'a'))
 #define AUXTRACE_ERR_FLG_DATA_LOST	(1 << ('l' - 'a'))
 
+#define AUXTRACE_LOG_FLG_ALL_PERF_EVTS	(1 << ('a' - 'a'))
+
 /**
  * struct itrace_synth_opts - AUX area tracing synthesis options.
  * @set: indicates whether or not options have been set
@@ -96,6 +98,8 @@ enum itrace_period_type {
  * @range_num: number of time intervals to trace
  * @error_plus_flags: flags to affect what errors are reported
  * @error_minus_flags: flags to affect what errors are reported
+ * @log_plus_flags: flags to affect what is logged
+ * @log_minus_flags: flags to affect what is logged
  */
 struct itrace_synth_opts {
 	bool			set;
@@ -131,6 +135,8 @@ struct itrace_synth_opts {
 	int			range_num;
 	unsigned int		error_plus_flags;
 	unsigned int		error_minus_flags;
+	unsigned int		log_plus_flags;
+	unsigned int		log_minus_flags;
 };
 
 /**
@@ -624,7 +630,9 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "							each flag must be preceded by + or -\n" \
 "							error flags are: o (overflow)\n" \
 "									 l (data lost)\n" \
-"				d:	    		create a debug log\n"			\
+"				d[flags]:		create a debug log\n" \
+"							each flag must be preceded by + or -\n" \
+"							log flags are: a (all perf events)\n" \
 "				f:	    		synthesize first level cache events\n" \
 "				m:	    		synthesize last level cache events\n" \
 "				t:	    		synthesize TLB events\n" \
-- 
2.17.1

