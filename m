Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE94C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC802085B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGIRhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:35052 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbgGIRh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:27 -0400
IronPort-SDR: TKl9PNqxJhl4TRfpgA/4PZ6p1mLKhAUght9d5FQi4aH8z546HlDF65L3UgJf4SrVDqm7JA1UWp
 lOZbldc4ueLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537125"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537125"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:27 -0700
IronPort-SDR: EALHoU8sNmtjqo6TRgSnsXDJDA6Syl7Xjfz8/JK5hPX652mjThliY+ftLCdOYURQ6NcS+N74dM
 rjiLoA6MYf1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292546"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] perf auxtrace: Add itrace 'q' option for quicker, less detailed decoding
Date:   Thu,  9 Jul 2020 20:36:26 +0300
Message-Id: <20200709173628.5613-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709173628.5613-1-adrian.hunter@intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
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
 tools/perf/util/auxtrace.h          | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 3dd8fddb8b1b..d4ffa11b9d50 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -18,6 +18,7 @@
 		l	synthesize last branch entries (use with i or x)
 		L	synthesize last branch entries on existing event records
 		s       skip initial number of events
+		q	quicker (less detailed) decoding
 
 	The default is all events i.e. the same as --itrace=ibxwpe,
 	except for perf script where it is --itrace=ce
@@ -53,3 +54,5 @@
 
 	If supported, The 'd' option may be followed by an architecture-specific
 	number which flags what kind of debug messages will or will not be logged.
+
+	If supported, the 'q' option may be repeated to increase the effect.
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 3f806c2881c9..81726c014237 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1511,6 +1511,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
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
index f41dbdc98175..d3b5520fa992 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -93,6 +93,7 @@ enum itrace_period_type {
  * @range_num: number of time intervals to trace
  * @error_flags: arch-specific flags to affect what errors are reported
  * @log_flags: arch-specific flags to affect what is logged
+ * @quick: quicker (less detailed) decoding
  */
 struct itrace_synth_opts {
 	bool			set;
@@ -128,6 +129,7 @@ struct itrace_synth_opts {
 	int			range_num;
 	unsigned int		error_flags;
 	unsigned int		log_flags;
+	unsigned int		quick;
 };
 
 /**
-- 
2.25.1

