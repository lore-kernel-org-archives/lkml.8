Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47EEC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20BE20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgDVMWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728505AbgDVMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B90C08C5F2;
        Wed, 22 Apr 2020 05:17:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJT-0007YT-OP; Wed, 22 Apr 2020 14:17:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 64D9C1C0450;
        Wed, 22 Apr 2020 14:17:11 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:11 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf script: Add option to enable the LBR stitching approach
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
In-Reply-To: <20200319202517.23423-15-kan.liang@linux.intel.com>
References: <20200319202517.23423-15-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158755783101.28353.13390091799409082831.tip-bot2@tip-bot2>
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

Commit-ID:     680d125cd522d460b24ccc8b29f03cdb62dea23e
Gitweb:        https://git.kernel.org/tip/680d125cd522d460b24ccc8b29f03cdb62dea23e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 19 Mar 2020 13:25:14 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:01 -03:00

perf script: Add option to enable the LBR stitching approach

With the LBR stitching approach, the reconstructed LBR call stack can
break the HW limitation. However, it may reconstruct invalid call stacks
in some cases, e.g. exception handing such as setjmp/longjmp.  Also, it
may impact the processing time especially when the number of samples
with stitched LBRs are huge.

Add an option to enable the approach.

Committer testing:

Using the same perf.data as with the latest cset committer testing
section:

  $ perf script --stitch-lbr
  <SNIP>
  tchain_edit 11131 15164.984292:     437491 cycles:u:
                    401106 f43+0x0 (/wb/tchain_edit)
                    40114c f42+0x18 (/wb/tchain_edit)
                    401172 f41+0xe (/wb/tchain_edit)
                    401194 f40+0x0 (/wb/tchain_edit)
                    40119b f39+0x0 (/wb/tchain_edit)
                    4011a2 f38+0x0 (/wb/tchain_edit)
                    4011a9 f37+0x0 (/wb/tchain_edit)
                    4011b0 f36+0x0 (/wb/tchain_edit)
                    4011b7 f35+0x0 (/wb/tchain_edit)
                    4011be f34+0x0 (/wb/tchain_edit)
                    4011c5 f33+0x0 (/wb/tchain_edit)
                    4011cc f32+0x0 (/wb/tchain_edit)
                    401207 f31+0x34 (/wb/tchain_edit)
                    401212 f30+0x0 (/wb/tchain_edit)
                    401219 f29+0x0 (/wb/tchain_edit)
                    401220 f28+0x0 (/wb/tchain_edit)
                    401227 f27+0x0 (/wb/tchain_edit)
                    40122e f26+0x0 (/wb/tchain_edit)
                    401235 f25+0x0 (/wb/tchain_edit)
                    40123c f24+0x0 (/wb/tchain_edit)
                    401243 f23+0x0 (/wb/tchain_edit)
                    40124a f22+0x0 (/wb/tchain_edit)
                    401251 f21+0x0 (/wb/tchain_edit)
                    401258 f20+0x0 (/wb/tchain_edit)
                    40125f f19+0x0 (/wb/tchain_edit)
                    401266 f18+0x0 (/wb/tchain_edit)
                    40126d f17+0x0 (/wb/tchain_edit)
                    401274 f16+0x0 (/wb/tchain_edit)
                    40127b f15+0x0 (/wb/tchain_edit)
                    401282 f14+0x0 (/wb/tchain_edit)
                    401289 f13+0x0 (/wb/tchain_edit)
                    401290 f12+0x0 (/wb/tchain_edit)
                    401297 f11+0x0 (/wb/tchain_edit)
                    40129e f10+0x0 (/wb/tchain_edit)
                    4012a5 f9+0x0 (/wb/tchain_edit)
                    4012ac f8+0x0 (/wb/tchain_edit)
                    4012b3 f7+0x0 (/wb/tchain_edit)
                    4012ba f6+0x0 (/wb/tchain_edit)
                    4012c1 f5+0x0 (/wb/tchain_edit)
                    4012c8 f4+0x0 (/wb/tchain_edit)
                    4012cf f3+0x0 (/wb/tchain_edit)
                    4012d6 f2+0x0 (/wb/tchain_edit)
                    4012dd f1+0x0 (/wb/tchain_edit)
                    4012e4 main+0x0 (/wb/tchain_edit)
              7f41a5016f41 __libc_start_main+0xf1 (/usr/lib64/libc-2.29.so)
  <SNIP>
  $

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-15-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 11 +++++++++++
 tools/perf/builtin-script.c              | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 963487e..372dfd1 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -440,6 +440,17 @@ include::itrace.txt[]
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
index 06b511c..a223654 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1697,6 +1697,7 @@ struct perf_script {
 	bool			show_cgroup_events;
 	bool			allocated;
 	bool			per_event_dump;
+	bool			stitch_lbr;
 	struct evswitch		evswitch;
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map *threads;
@@ -1923,6 +1924,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
+		if (script->stitch_lbr)
+			al->thread->lbr_stitch_enable = true;
+
 		if (symbol_conf.use_callchain && sample->callchain &&
 		    thread__resolve_callchain(al->thread, &callchain_cursor, evsel,
 					      sample, NULL, NULL, scripting_max_stack) == 0)
@@ -3170,6 +3174,12 @@ static void script__setup_sample_type(struct perf_script *script)
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
@@ -3481,6 +3491,8 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/kallsyms"),
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
+	OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
+		    "Enable LBR callgraph stitching approach"),
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
