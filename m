Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFBDC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EE12098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgDVMWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728498AbgDVMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35797C03C1AF;
        Wed, 22 Apr 2020 05:17:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJU-0007YW-9r; Wed, 22 Apr 2020 14:17:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E09A51C02FC;
        Wed, 22 Apr 2020 14:17:11 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:11 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report: Add option to enable the LBR stitching approach
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200319202517.23423-14-kan.liang@linux.intel.com>
References: <20200319202517.23423-14-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158755783149.28353.15798067908871951560.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b1d1429b1820e1587d8588fc05b28ef9af42cfc6
Gitweb:        https://git.kernel.org/tip/b1d1429b1820e1587d8588fc05b28ef9af42cfc6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 19 Mar 2020 13:25:13 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:01 -03:00

perf report: Add option to enable the LBR stitching approach

With the LBR stitching approach, the reconstructed LBR call stack can
break the HW limitation. However, it may reconstruct invalid call stacks
in some cases, e.g. exception handing such as setjmp/longjmp.  Also, it
may impact the processing time especially when the number of samples
with stitched LBRs are huge.

Add an option to enable the approach.

  # To display the perf.data header info, please use
  # --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles'
  # Event count (approx.): 6492797701
  #
  # Children      Self  Command          Shared Object       Symbol
  # ........  ........  ...............  ..................
  # .................................
  #
    99.99%    99.99%  tchain_edit      tchain_edit        [.] f43
            |
            ---main
               f1
               f2
               f3
               f4
               f5
               f6
               f7
               f8
               f9
               f10
               f11
               f12
               f13
               f14
               f15
               f16
               f17
               f18
               f19
               f20
               f21
               f22
               f23
               f24
               f25
               f26
               f27
               f28
               f29
               f30
               f31
               |
                --99.65%--f32
                          f33
                          f34
                          f35
                          f36
                          f37
                          f38
                          f39
                          f40
                          f41
                          f42
                          f43

Committer testing:

  $ perf record --call-graph lbr /wb/tchain_edit
  [ perf record: Woken up 23 times to write data ]
  [ perf record: Captured and wrote 5.578 MB perf.data (6839 samples) ]
  $ perf report --header-only | egrep 'cpu(desc|.*capabilities)'
  # cpudesc : Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
  # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
  $

Before:

  $ perf report --no-children --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles:u'
  # Event count (approx.): 6459523879
  #
  # Overhead  Command      Shared Object     Symbol
  # ........  ...........  ................  .......................
  #
      99.95%  tchain_edit  tchain_edit       [.] f43
              |
               --99.92%--f43
                         f42
                         f41
                         f40
                         f39
                         f38
                         f37
                         f36
                         f35
                         f34
                         f33
                         f32
                         f31
                         f30
                         f29
                         f28
                         f27
                         f26
                         f25
                         f24
                         f23
                         f22
                         f21
                         f20
                         f19
                         f18
                         f17
                         f16
                         f15
                         f14
                         f13
                         f12
                         f11

       0.03%  tchain_edit  tchain_edit       [.] f42
       0.01%  tchain_edit  tchain_edit       [.] f41
       0.00%  tchain_edit  tchain_edit       [.] f31
       0.00%  tchain_edit  ld-2.29.so        [.] _dl_relocate_object
       0.00%  tchain_edit  ld-2.29.so        [.] memmove
       0.00%  tchain_edit  [unknown]         [k] 0xffffffff93a00b17

After:

  $ perf report --stitch-lbr --no-children --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles:u'
  # Event count (approx.): 6459496645
  #
  # Overhead  Command      Shared Object     Symbol
  # ........  ...........  ................  ........................
  #
      99.97%  tchain_edit  tchain_edit       [.] f43
              |
               --99.93%--f43
                         f42
                         f41
                         f40
                         f39
                         f38
                         f37
                         f36
                         f35
                         f34
                         f33
                         f32
                         f31
                         f30
                         f29
                         f28
                         f27
                         f26
                         f25
                         f24
                         f23
                         f22
                         f21
                         f20
                         f19
                         f18
                         f17
                         f16
                         f15
                         f14
                         f13
                         f12
                         f11
                         f10
                         f9
                         f8
                         f7
                         f6
                         f5
                         f4
                         f3
                         f2
                         f1
                         main
                         __libc_start_main

       0.02%  tchain_edit  [unknown]         [k] 0xffffffff93a00b17
       0.01%  tchain_edit  tchain_edit       [.] f31
       0.00%  tchain_edit  ld-2.29.so        [.] _dl_important_hwcaps

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-14-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 11 +++++++++++
 tools/perf/builtin-report.c              | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index f569b9e..d068103 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -488,6 +488,17 @@ include::itrace.txt[]
 	This option extends the perf report to show reference callgraphs,
 	which collected by reference event, in no callgraph event.
 
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
 --socket-filter::
 	Only report the samples on the processor socket that match with this filter
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c0cebd5..0c32767 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -84,6 +84,7 @@ struct report {
 	bool			header_only;
 	bool			nonany_branch_mode;
 	bool			group_set;
+	bool			stitch_lbr;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	struct annotation_options annotation_opts;
@@ -267,6 +268,9 @@ static int process_sample_event(struct perf_tool *tool,
 		return -1;
 	}
 
+	if (rep->stitch_lbr)
+		al.thread->lbr_stitch_enable = true;
+
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		goto out_put;
 
@@ -408,6 +412,12 @@ static int report__setup_sample_type(struct report *rep)
 			callchain_param.record_mode = CALLCHAIN_FP;
 	}
 
+	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
+		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
+			    "Please apply --call-graph lbr when recording.\n");
+		rep->stitch_lbr = false;
+	}
+
 	/* ??? handle more cases than just ANY? */
 	if (!(perf_evlist__combined_branch_type(session->evlist) &
 				PERF_SAMPLE_BRANCH_ANY))
@@ -1258,6 +1268,8 @@ int cmd_report(int argc, const char **argv)
 			"Show full source file name path for source lines"),
 	OPT_BOOLEAN(0, "show-ref-call-graph", &symbol_conf.show_ref_callgraph,
 		    "Show callgraph from reference event"),
+	OPT_BOOLEAN(0, "stitch-lbr", &report.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPT_INTEGER(0, "socket-filter", &report.socket_filter,
 		    "only show processor socket that match with this filter"),
 	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
