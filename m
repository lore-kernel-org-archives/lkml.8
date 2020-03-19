Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6048CC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42ABA20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCSU3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:29:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:60510 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbgCSU3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:29:02 -0400
IronPort-SDR: Zk7JYHXIhk0AyFiVeEkfzRLbZru9fmHJNDfH67ANNobzO4UNDiUPkV9pmvyF7o3iIRSWtf37Sb
 dtqLoD1Lyx6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:29:01 -0700
IronPort-SDR: SVGFDoi9uFrO2uApEoMQM/WK8AXtGRHIX4ow0AB6q7MbWtVw5Urf0TAoPD1GCA1XQ4rOARtvEM
 PZgaecle5HNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031271"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:29:01 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 14/17] perf script: Add option to enable the LBR stitching approach
Date:   Thu, 19 Mar 2020 13:25:14 -0700
Message-Id: <20200319202517.23423-15-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
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
 tools/perf/builtin-script.c              | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index db6a36aac47e..67d5a2c7065b 100644
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
index 656b347f6dd8..e0ec4a0e7b35 100644
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
@@ -3295,6 +3299,12 @@ static void script__setup_sample_type(struct perf_script *script)
 		else
 			callchain_param.record_mode = CALLCHAIN_FP;
 	}
+
+	if (script->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
+		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			   "Please apply --call-graph lbr when recording.\n");
+		script->stitch_lbr = false;
+	}
 }
 
 static int process_stat_round_event(struct perf_session *session,
@@ -3602,6 +3612,8 @@ int cmd_script(int argc, const char **argv)
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

