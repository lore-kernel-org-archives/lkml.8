Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD09C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18272065D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgGJPTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:19:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:38270 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgGJPL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:11:59 -0400
IronPort-SDR: +XW8sqGZY66IHmrC5zzAgKLf7xWiaIKkF8jn7DN/nZpOUBDRFGwP3pPdQg+uuXXUSb0GGKur9j
 O9eNsZTaH2pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686290"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686290"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:11:56 -0700
IronPort-SDR: n1SjVceTeR5yH8vaqkz1549J14IAVEBSpdOG/boll0caxAFVyUpHf5XUrSszoIiNz4aXJwlkEi
 il2ZvxDyDRUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675492"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:11:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/12] perf auxtrace: Add optional error flags to the itrace 'e' option
Date:   Fri, 10 Jul 2020 18:10:57 +0300
Message-Id: <20200710151104.15137-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the 'e' option to be followed by flags which will affect what errors
will or will not be reported. Each flag must be preceded by either '+' or
'-'. The flags are:
	o	overflow
	l	trace data lost

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt |  6 ++++
 tools/perf/util/auxtrace.c          | 44 +++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h          | 12 +++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index e817179c5027..114d0544d7c7 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -47,3 +47,9 @@
 	--itrace=i0nss1000000
 
 	skips the first million instructions.
+
+	The 'e' option may be followed by flags which affect what errors will or
+	will not be reported. Each flag must be preceded by either '+' or '-'.
+	The flags are:
+		o	overflow
+		l	trace data lost
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 25c639ac4ad4..f0b0758830ee 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1349,6 +1349,47 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->initial_skip = 0;
 }
 
+static int get_flag(const char **ptr, unsigned int *flags)
+{
+	while (1) {
+		char c = **ptr;
+
+		if (c >= 'a' && c <= 'z') {
+			*flags |= 1 << (c - 'a');
+			++*ptr;
+			return 0;
+		} else if (c == ' ') {
+			++*ptr;
+			continue;
+		} else {
+			return -1;
+		}
+	}
+}
+
+static int get_flags(const char **ptr, unsigned int *plus_flags, unsigned int *minus_flags)
+{
+	while (1) {
+		switch (**ptr) {
+		case '+':
+			++*ptr;
+			if (get_flag(ptr, plus_flags))
+				return -1;
+			break;
+		case '-':
+			++*ptr;
+			if (get_flag(ptr, minus_flags))
+				return -1;
+			break;
+		case ' ':
+			++*ptr;
+			break;
+		default:
+			return 0;
+		}
+	}
+}
+
 /*
  * Please check tools/perf/Documentation/perf-script.txt for information
  * about the options parsed here, which is introduced after this cset,
@@ -1436,6 +1477,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			break;
 		case 'e':
 			synth_opts->errors = true;
+			if (get_flags(&p, &synth_opts->error_plus_flags,
+				      &synth_opts->error_minus_flags))
+				goto out_err;
 			break;
 		case 'd':
 			synth_opts->log = true;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e3ce5fb03ca0..cfe6d00d8624 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -55,6 +55,9 @@ enum itrace_period_type {
 	PERF_ITRACE_PERIOD_NANOSECS,
 };
 
+#define AUXTRACE_ERR_FLG_OVERFLOW	(1 << ('o' - 'a'))
+#define AUXTRACE_ERR_FLG_DATA_LOST	(1 << ('l' - 'a'))
+
 /**
  * struct itrace_synth_opts - AUX area tracing synthesis options.
  * @set: indicates whether or not options have been set
@@ -91,6 +94,8 @@ enum itrace_period_type {
  * @cpu_bitmap: CPUs for which to synthesize events, or NULL for all
  * @ptime_range: time intervals to trace or NULL
  * @range_num: number of time intervals to trace
+ * @error_plus_flags: flags to affect what errors are reported
+ * @error_minus_flags: flags to affect what errors are reported
  */
 struct itrace_synth_opts {
 	bool			set;
@@ -124,6 +129,8 @@ struct itrace_synth_opts {
 	unsigned long		*cpu_bitmap;
 	struct perf_time_interval *ptime_range;
 	int			range_num;
+	unsigned int		error_plus_flags;
+	unsigned int		error_minus_flags;
 };
 
 /**
@@ -613,7 +620,10 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				p:	    		synthesize power events\n"			\
 "				o:			synthesize other events recorded due to the use\n" \
 "							of aux-output (refer to perf record)\n"	\
-"				e:	    		synthesize error events\n"			\
+"				e[flags]:		synthesize error events\n" \
+"							each flag must be preceded by + or -\n" \
+"							error flags are: o (overflow)\n" \
+"									 l (data lost)\n" \
 "				d:	    		create a debug log\n"			\
 "				f:	    		synthesize first level cache events\n" \
 "				m:	    		synthesize last level cache events\n" \
-- 
2.17.1

