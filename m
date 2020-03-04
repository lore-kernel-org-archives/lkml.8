Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C7EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322CD2072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbgCDJID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:08:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:17638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387846AbgCDJIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:08:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 01:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="413074308"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2020 01:07:57 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 10/13] perf evlist: Disable 'immediate' events last
Date:   Wed,  4 Mar 2020 11:06:30 +0200
Message-Id: <20200304090633.420-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304090633.420-1-adrian.hunter@intel.com>
References: <20200304090633.420-1-adrian.hunter@intel.com>
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
index 1548237b6558..06c4586065cc 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -379,22 +379,33 @@ void evlist__disable(struct evlist *evlist)
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
-			if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
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
+				if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
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
 		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
-- 
2.17.1

