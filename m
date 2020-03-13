Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12741C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA882074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCMSfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:35:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:28647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbgCMSer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:34:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 11:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="442506145"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 11:34:46 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 16/17] perf c2c: Add option to enable the LBR stitching approach
Date:   Fri, 13 Mar 2020 11:33:18 -0700
Message-Id: <20200313183319.17739-17-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313183319.17739-1-kan.liang@linux.intel.com>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
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
 tools/perf/builtin-c2c.c              |  6 ++++++
 2 files changed, 17 insertions(+)

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
index 246ac0b4d54f..c798763f62db 100644
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
@@ -2752,6 +2756,8 @@ static int perf_c2c__report(int argc, const char **argv)
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

