Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFD5C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C72520663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCSU3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:29:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:60512 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgCSU3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:29:05 -0400
IronPort-SDR: oJlmJ6Y8cWsr9S+CVRXawhtX6qsd/BQXgIPMIYfSVIt4f4fSVehIejMgu1Ji+WjQFkWI2CfWJs
 ZRXeKqL/IPRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:29:03 -0700
IronPort-SDR: kysinYymoqG1Dl1OE1rZrGxt/JVgihLJDKMaAOU6/TQqZrbgLBb6O2sfSAsgisdQt1XKP7QKuw
 /xFp+oer2aXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031281"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:29:03 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 16/17] perf c2c: Add option to enable the LBR stitching approach
Date:   Thu, 19 Mar 2020 13:25:16 -0700
Message-Id: <20200319202517.23423-17-kan.liang@linux.intel.com>
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
 tools/perf/Documentation/perf-c2c.txt | 11 +++++++++++
 tools/perf/builtin-c2c.c              | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index e6150f21267d..2133eb320cb0 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -111,6 +111,17 @@ REPORT OPTIONS
 --display::
 	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The perf.data file must have been obtained using
+	perf c2c record --call-graph lbr.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
+
 C2C RECORD
 ----------
 The perf c2c record command setup options related to HITM cacheline analysis
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 246ac0b4d54f..0d544c4fb4be 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -95,6 +95,7 @@ struct perf_c2c {
 	bool			 use_stdio;
 	bool			 stats_only;
 	bool			 symbol_full;
+	bool			 stitch_lbr;
 
 	/* HITM shared clines stats */
 	struct c2c_stats	hitm_stats;
@@ -273,6 +274,9 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 		return -1;
 	}
 
+	if (c2c.stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	ret = sample__resolve_callchain(sample, &callchain_cursor, NULL,
 					evsel, &al, sysctl_perf_event_max_stack);
 	if (ret)
@@ -2601,6 +2605,12 @@ static int setup_callchain(struct evlist *evlist)
 		}
 	}
 
+	if (c2c.stitch_lbr && (mode != CALLCHAIN_LBR)) {
+		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			    "Please apply --call-graph lbr when recording.\n");
+		c2c.stitch_lbr = false;
+	}
+
 	callchain_param.record_mode = mode;
 	callchain_param.min_percent = 0;
 	return 0;
@@ -2752,6 +2762,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_STRING('c', "coalesce", &coalesce, "coalesce fields",
 		   "coalesce fields: pid,tid,iaddr,dso"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
+	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPT_PARENT(c2c_options),
 	OPT_END()
 	};
-- 
2.17.1

