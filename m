Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D627DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4002078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgGIRhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:35028 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbgGIRhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:21 -0400
IronPort-SDR: NaBNvyy9SJw/p94hOmx7DJnP9Ze/nzoy0n45xvbSoM+eLpaCanLGU7DoVvMLtuyDZKVs8yZdf0
 tXd2y1KCz12g==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537118"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537118"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:21 -0700
IronPort-SDR: VVZjKTB7Khs3H5RS1BMHr+63/B0NwTPHJHvZVFy5QmpQAKa4gogC/OGRZsAayi1eFXxtNcXFPf
 JQOlMndslzqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292526"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] perf auxtrace: Add optional log flags to the itrace 'd' option
Date:   Thu,  9 Jul 2020 20:36:23 +0300
Message-Id: <20200709173628.5613-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709173628.5613-1-adrian.hunter@intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the 'd' option to be followed by an architecture-specific number
which flags what kind of debug messages will or will not be logged.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt | 3 +++
 tools/perf/util/auxtrace.c          | 2 ++
 tools/perf/util/auxtrace.h          | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 34864b4047ed..3dd8fddb8b1b 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -50,3 +50,6 @@
 
 	The 'e' option may be followed by an architecture-specific number which
 	flags what kind of errors will or will not be reported.
+
+	If supported, The 'd' option may be followed by an architecture-specific
+	number which flags what kind of debug messages will or will not be logged.
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 5cfc0b12b2b3..3f806c2881c9 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1441,6 +1441,8 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			break;
 		case 'd':
 			synth_opts->log = true;
+			synth_opts->log_flags = strtoul(p, &endptr, 0);
+			p = endptr;
 			break;
 		case 'c':
 			synth_opts->branches = true;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a04475f41f28..f41dbdc98175 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -92,6 +92,7 @@ enum itrace_period_type {
  * @ptime_range: time intervals to trace or NULL
  * @range_num: number of time intervals to trace
  * @error_flags: arch-specific flags to affect what errors are reported
+ * @log_flags: arch-specific flags to affect what is logged
  */
 struct itrace_synth_opts {
 	bool			set;
@@ -126,6 +127,7 @@ struct itrace_synth_opts {
 	struct perf_time_interval *ptime_range;
 	int			range_num;
 	unsigned int		error_flags;
+	unsigned int		log_flags;
 };
 
 /**
-- 
2.25.1

