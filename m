Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501D3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E225246BB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgB1Qc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:32:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:35576 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgB1QcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:32:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 08:32:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="227593091"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2020 08:32:25 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 09/12] perf script: Add option to enable the LBR stitching approach
Date:   Fri, 28 Feb 2020 08:30:08 -0800
Message-Id: <20200228163011.19358-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228163011.19358-1-kan.liang@linux.intel.com>
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With the LBR stitching approach, the reconstructed LBR call stack
can break the HW limitation. However, it may reconstruct invalid call
stacks in some cases, e.g. exception handing such as setjmp/longjmp.
Also, it may impact the processing time especially when the number of
samples with stitched LBRs are huge.

Add an option to enable the approach.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt | 11 +++++++++++
 tools/perf/builtin-script.c              |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2599b057e47b..472f20f1e479 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -426,6 +426,17 @@ include::itrace.txt[]
 --show-on-off-events::
 	Show the --switch-on/off events too.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The perf.data file must have been obtained using
+	perf record --call-graph lbr.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script-perl[1],
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index acf3107bbda2..c229e0199003 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1687,6 +1687,7 @@ struct perf_script {
 	bool			show_bpf_events;
 	bool			allocated;
 	bool			per_event_dump;
+	bool			stitch_lbr;
 	struct evswitch		evswitch;
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map *threads;
@@ -1913,6 +1914,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
+		if (script->stitch_lbr)
+			al->thread->lbr_stitch_enable = true;
+
 		if (symbol_conf.use_callchain && sample->callchain &&
 		    thread__resolve_callchain(al->thread, &callchain_cursor, evsel,
 					      sample, NULL, NULL, scripting_max_stack) == 0)
@@ -3602,6 +3606,8 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/kallsyms"),
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
+	OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
-- 
2.17.1

