Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27525C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0927C2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGIRhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:35028 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbgGIRhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:16 -0400
IronPort-SDR: pBZO6JDcm570SfIVwA/WuOPRBmQ2FlveFpdmhHBcN/xvQYMNeakf5uMIKko3DI5aw6oTlM4ejV
 Jdad/ANS2Mlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537109"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:16 -0700
IronPort-SDR: tPzh02zc/A+ExKzN+NbLgM1H9JyR/9Uq344Pp+2wgkj9MIDi9dEvN21rodV3JHL8RCPz2cavpe
 Q8SariMjisCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292511"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] perf tools: Improve aux_output not supported error
Date:   Thu,  9 Jul 2020 20:36:20 +0300
Message-Id: <20200709173628.5613-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709173628.5613-1-adrian.hunter@intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For example:
 Before:
   $ perf record -e '{intel_pt/branch=0/,branch-loads/aux-output/ppp}' -- ls -l
   Error:
   branch-loads: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
 After:
   $ perf record -e '{intel_pt/branch=0/,branch-loads/aux-output/ppp}' -- ls -l
   Error:
   branch-loads: PMU Hardware doesn't support 'aux_output' feature

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evsel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9aa51a65593d..9c5c72094112 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2533,6 +2533,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 	 "No such device - did you specify an out-of-range profile CPU?");
 		break;
 	case EOPNOTSUPP:
+		if (evsel->core.attr.aux_output)
+			return scnprintf(msg, size,
+	"%s: PMU Hardware doesn't support 'aux_output' feature",
+					 evsel__name(evsel));
 		if (evsel->core.attr.sample_period != 0)
 			return scnprintf(msg, size,
 	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
-- 
2.25.1

