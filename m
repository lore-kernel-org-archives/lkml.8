Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FD0C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A28B216FD
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgCSOLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:11:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32873 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgCSOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsy-0002Hg-UF; Thu, 19 Mar 2020 15:11:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0F55F1C22B0;
        Thu, 19 Mar 2020 15:10:53 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:52 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Support PERF_SAMPLE_BRANCH_HW_INDEX
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200228163011.19358-3-kan.liang@linux.intel.com>
References: <20200228163011.19358-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158462705276.28353.12430745941418404371.tip-bot2@tip-bot2>
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

Commit-ID:     d3f85437ad6a55113882d730beaa75759452da8f
Gitweb:        https://git.kernel.org/tip/d3f85437ad6a55113882d730beaa75759452da8f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 28 Feb 2020 08:30:01 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 09 Mar 2020 21:43:24 -03:00

perf evsel: Support PERF_SAMPLE_BRANCH_HW_INDEX

A new branch sample type PERF_SAMPLE_BRANCH_HW_INDEX has been introduced
in latest kernel.

Enable HW_INDEX by default in LBR call stack mode.

If kernel doesn't support the sample type, switching it off.

Add HW_INDEX in attr_fprintf as well. User can check whether the branch
sample type is set via debug information or header.

Committer testing:

First collect some samples with LBR callchains, system wide, for a few
seconds:

  # perf record --call-graph lbr -a sleep 5
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.625 MB perf.data (224 samples) ]
  #

Now lets use 'perf evlist -v' to look at the branch_sample_type:

  # perf evlist -v
  cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
  #

So the machine has the kernel feature, and it was correctly added to
perf_event_attr.branch_sample_type, for the default 'cycles' event.

If we do it in another machine, where the kernel lacks the HW_INDEX
feature, we get:

  # perf record --call-graph lbr -a sleep 2s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.690 MB perf.data (499 samples) ]
  # perf evlist -v
  cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: USER|CALL_STACK|NO_FLAGS|NO_CYCLES
  #

No HW_INDEX in attr.branch_sample_type.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200228163011.19358-3-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c                   | 15 ++++++++++++---
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 05883a4..816d930 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -712,7 +712,8 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
 				attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
 							PERF_SAMPLE_BRANCH_CALL_STACK |
 							PERF_SAMPLE_BRANCH_NO_CYCLES |
-							PERF_SAMPLE_BRANCH_NO_FLAGS;
+							PERF_SAMPLE_BRANCH_NO_FLAGS |
+							PERF_SAMPLE_BRANCH_HW_INDEX;
 			}
 		} else
 			 pr_warning("Cannot use LBR callstack with branch stack. "
@@ -763,7 +764,8 @@ perf_evsel__reset_callgraph(struct evsel *evsel,
 	if (param->record_mode == CALLCHAIN_LBR) {
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 		attr->branch_sample_type &= ~(PERF_SAMPLE_BRANCH_USER |
-					      PERF_SAMPLE_BRANCH_CALL_STACK);
+					      PERF_SAMPLE_BRANCH_CALL_STACK |
+					      PERF_SAMPLE_BRANCH_HW_INDEX);
 	}
 	if (param->record_mode == CALLCHAIN_DWARF) {
 		perf_evsel__reset_sample_bit(evsel, REGS_USER);
@@ -1673,6 +1675,8 @@ fallback_missing_features:
 		evsel->core.attr.ksymbol = 0;
 	if (perf_missing_features.bpf)
 		evsel->core.attr.bpf_event = 0;
+	if (perf_missing_features.branch_hw_idx)
+		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->core.attr.sample_id_all = 0;
@@ -1784,7 +1788,12 @@ try_fallback:
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+	if (!perf_missing_features.branch_hw_idx &&
+	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
+		perf_missing_features.branch_hw_idx = true;
+		pr_debug2("switching off branch HW index support\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
 		perf_missing_features.aux_output = true;
 		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 99a0cb6..3380474 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,6 +119,7 @@ struct perf_missing_features {
 	bool ksymbol;
 	bool bpf;
 	bool aux_output;
+	bool branch_hw_idx;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 6512031..355d345 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -50,6 +50,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
 		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
 		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
 		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
+		bit_name(HW_INDEX),
 		{ .name = NULL, }
 	};
 #undef bit_name
