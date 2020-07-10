Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5540C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D4020720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgGJPND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:13:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:38264 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgGJPL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:11:56 -0400
IronPort-SDR: R9HQ+fRvLQMovk1s41cBHjVVUUfJfolNf/kkX7aXvz92LZALtA+vr8NQFAw7/pdY0UjVoXTGzG
 XcSba84OQ+2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686236"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686236"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:11:53 -0700
IronPort-SDR: jkDt7nsWM9mcN+v+Xzef4FUr1qyvjNOYhFQ63kOIJ1iFl7+z5e55T8CEKCKaPqwdZBQdar4Ntp
 hYSzK0I3ym8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675474"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:11:51 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/12] perf tools: Improve aux_output not supported error
Date:   Fri, 10 Jul 2020 18:10:55 +0300
Message-Id: <20200710151104.15137-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
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
index 80a7f9862aec..6606c1e3b4fe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2539,6 +2539,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
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
2.17.1

