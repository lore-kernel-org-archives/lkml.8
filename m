Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC251C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C601E20661
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgELMTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:19:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:43213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgELMTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:19:48 -0400
IronPort-SDR: 7Jxb+EEnURMLg1h+rbNyvG0kmlCNq4+1Yn+VD8OYxyggLv/8RaV2kAozzRCYjtjhYWGnxGe4xh
 dyGWZ3UtKBMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:19:48 -0700
IronPort-SDR: blBDWJg2B0kHgnWz1J+zgPjRh9GHTL83Bku00Afu93Ni1wvq/Wa7DrQ1/e5jKL68mxDtrVXqjT
 yGZ02P7+9yzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="250879346"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 05:19:44 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 10/15] perf evlist: Disable 'immediate' events last
Date:   Tue, 12 May 2020 15:19:17 +0300
Message-Id: <20200512121922.8997-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512121922.8997-1-adrian.hunter@intel.com>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events marked as 'immediate' are started before other events to ensure
that there is context at the start of the main tracing events. The same
is true at the end of tracing, so disable 'immediate' events after other
events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evlist.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 2a9de6491700..173b4f0e0e6e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -380,22 +380,33 @@ void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
 	struct affinity affinity;
-	int cpu, i;
+	int cpu, i, imm = 0;
+	bool has_imm = false;
 
 	if (affinity__setup(&affinity) < 0)
 		return;
 
-	evlist__for_each_cpu(evlist, i, cpu) {
-		affinity__set(&affinity, cpu);
-
-		evlist__for_each_entry(evlist, pos) {
-			if (evsel__cpu_iter_skip(pos, cpu))
-				continue;
-			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
-				continue;
-			evsel__disable_cpu(pos, pos->cpu_iter - 1);
+	/* Disable 'immediate' events last */
+	for (imm = 0; imm <= 1; imm++) {
+		evlist__for_each_cpu(evlist, i, cpu) {
+			affinity__set(&affinity, cpu);
+
+			evlist__for_each_entry(evlist, pos) {
+				if (evsel__cpu_iter_skip(pos, cpu))
+					continue;
+				if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
+					continue;
+				if (pos->immediate)
+					has_imm = true;
+				if (pos->immediate != imm)
+					continue;
+				evsel__disable_cpu(pos, pos->cpu_iter - 1);
+			}
 		}
+		if (!has_imm)
+			break;
 	}
+
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (!evsel__is_group_leader(pos) || !pos->core.fd)
-- 
2.17.1

