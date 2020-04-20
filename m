Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92A9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C6920724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383871;
	bh=arrV/6jlE9PMFQImZ+Ghcb3WvlSfwtJ473Br6T/Y84w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mQqV4eT9qTYHW8jIaTuSKXscyGfDq/OhBwwZs7h31N1oFiJl8Rwq3tGkz0kFR/L24
	 9cbsqM/tC03SIjpJ91SCwba185+TiCCjX1hRBA4pzKFj/K8ehNi4yJ2xOk83P73v5M
	 p6EMGpt7WH4mFIWteVmq22q1NvOz68sdYXes4Yh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgDTL5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDTL5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:57:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4498221F4;
        Mon, 20 Apr 2020 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383868;
        bh=arrV/6jlE9PMFQImZ+Ghcb3WvlSfwtJ473Br6T/Y84w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyrZreaAvDI7QXHESL67uiJjwuroNfR0jVCKb/FMNVOAAJtFNi31IVl/7VAYZi+YB
         jvLQDk2eOs0JEO4pErtMyF+1PlnDpUd8nOm+OL7feTYtxjm6LcLNhuiZCqYOv0qt4N
         l1UzGACJ30AXP/WyywVpsg5oJS4gkMxU0GKDRjiU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Subject: [PATCH 58/60] perf top: Add option to enable the LBR stitching approach
Date:   Mon, 20 Apr 2020 08:53:14 -0300
Message-Id: <20200420115316.18781-59-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
The option must be used with --call-graph lbr.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-16-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt |  9 +++++++++
 tools/perf/builtin-top.c              | 11 +++++++++++
 tools/perf/util/top.h                 |  1 +
 3 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 487737a725e9..20227dabc208 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -319,6 +319,15 @@ Default is to monitor all CPUS.
 	go straight to the histogram browser, just like 'perf top' with no events
 	explicitely specified does.
 
+--stitch-lbr::
+	Show callgraph with stitched LBRs, which may have more complete
+	callgraph. The option must be used with --call-graph lbr recording.
+	Disabled by default. In common cases with call stack overflows,
+	it can recreate better call stacks than the default lbr call stack
+	output. But this approach is not full proof. There can be cases
+	where it creates incorrect call stacks from incorrect matches.
+	The known limitations include exception handing such as
+	setjmp/longjmp will have calls/returns not match.
 
 INTERACTIVE PROMPTING KEYS
 --------------------------
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 289cf83e658a..6b067a5ba1d5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -33,6 +33,7 @@
 #include "util/map.h"
 #include "util/mmap.h"
 #include "util/session.h"
+#include "util/thread.h"
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
 #include "util/top.h"
@@ -775,6 +776,9 @@ static void perf_event__process_sample(struct perf_tool *tool,
 	if (machine__resolve(machine, &al, sample) < 0)
 		return;
 
+	if (top->stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	if (!machine->kptr_restrict_warned &&
 	    symbol_conf.kptr_restrict &&
 	    al.cpumode == PERF_RECORD_MISC_KERNEL) {
@@ -1571,6 +1575,8 @@ int cmd_top(int argc, const char **argv)
 		    "Sort the output by the event at the index n in group. "
 		    "If n is invalid, sort by the first event. "
 		    "WARNING: should be used on grouped events."),
+	OPT_BOOLEAN(0, "stitch-lbr", &top.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
@@ -1640,6 +1646,11 @@ int cmd_top(int argc, const char **argv)
 		}
 	}
 
+	if (top.stitch_lbr && !(callchain_param.record_mode == CALLCHAIN_LBR)) {
+		pr_err("Error: --stitch-lbr must be used with --call-graph lbr\n");
+		goto out_delete_evlist;
+	}
+
 	if (opts->branch_stack && callchain_param.enabled)
 		symbol_conf.show_branchflag_count = true;
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index f117d4f4821e..45dc84ddff37 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -36,6 +36,7 @@ struct perf_top {
 	bool		   use_tui, use_stdio;
 	bool		   vmlinux_warned;
 	bool		   dump_symtab;
+	bool		   stitch_lbr;
 	struct hist_entry  *sym_filter_entry;
 	struct evsel 	   *sym_evsel;
 	struct perf_session *session;
-- 
2.21.1

