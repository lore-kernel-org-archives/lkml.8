Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA210C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B029324999
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgEHNKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729942AbgEHNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B31C05BD0D;
        Fri,  8 May 2020 06:05:14 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gf-0007XH-A2; Fri, 08 May 2020 15:05:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 766211C084B;
        Fri,  8 May 2020 15:04:57 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:57 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf intel-pt: Add support for synthesizing branch
 stacks for regular events
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429150751.12570-8-adrian.hunter@intel.com>
References: <20200429150751.12570-8-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158894309739.8414.13833146962520220204.tip-bot2@tip-bot2>
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

Commit-ID:     f0a0251cee800bf90cff92ecfaf4a4d4c9c493b2
Gitweb:        https://git.kernel.org/tip/f0a0251cee800bf90cff92ecfaf4a4d4c9c493b2
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 29 Apr 2020 18:07:49 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf intel-pt: Add support for synthesizing branch stacks for regular events

Use the new thread_stack__br_sample_late() function to create a thread
stack for regular events.

Example:

 # perf record --kcore --aux-sample -e '{intel_pt//,cycles:ppp}' -c 10000 uname
 Linux
 [ perf record: Woken up 2 times to write data ]
 [ perf record: Captured and wrote 0.743 MB perf.data ]
 # perf report --itrace=Le --stdio | head -30 | tail -18

 # Samples: 11K of event 'cycles:ppp'
 # Event count (approx.): 11648
 #
 # Overhead  Command  Source Shared Object  Source Symbol                 Target Symbol                 Basic Block Cycles
 # ........  .......  ....................  ............................  ............................  ..................
 #
      5.49%  uname    libc-2.30.so          [.] _dl_addr                  [.] _dl_addr                  -
      2.41%  uname    ld-2.30.so            [.] _dl_relocate_object       [.] _dl_relocate_object       -
      2.31%  uname    ld-2.30.so            [.] do_lookup_x               [.] do_lookup_x               -
      2.17%  uname    [kernel.kallsyms]     [k] unmap_page_range          [k] unmap_page_range          -
      2.05%  uname    ld-2.30.so            [k] _dl_start                 [k] _dl_start                 -
      1.97%  uname    ld-2.30.so            [.] _dl_lookup_symbol_x       [.] _dl_lookup_symbol_x       -
      1.94%  uname    [kernel.kallsyms]     [k] filemap_map_pages         [k] filemap_map_pages         -
      1.60%  uname    [kernel.kallsyms]     [k] __handle_mm_fault         [k] __handle_mm_fault         -
      1.44%  uname    [kernel.kallsyms]     [k] page_add_file_rmap        [k] page_add_file_rmap        -
      1.12%  uname    [kernel.kallsyms]     [k] vma_interval_tree_insert  [k] vma_interval_tree_insert  -
      0.94%  uname    [kernel.kallsyms]     [k] perf_iterate_ctx          [k] perf_iterate_ctx          -

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 73 +++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 03b7690..59811b3 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -72,6 +72,7 @@ struct intel_pt {
 	bool use_thread_stack;
 	bool callstack;
 	unsigned int br_stack_sz;
+	unsigned int br_stack_sz_plus;
 	int have_sched_switch;
 	u32 pmu_type;
 	u64 kernel_start;
@@ -130,6 +131,7 @@ struct intel_pt {
 	unsigned int range_cnt;
 
 	struct ip_callchain *chain;
+	struct branch_stack *br_stack;
 };
 
 enum switch_state {
@@ -911,6 +913,44 @@ static void intel_pt_add_callchain(struct intel_pt *pt,
 	sample->callchain = pt->chain;
 }
 
+static struct branch_stack *intel_pt_alloc_br_stack(struct intel_pt *pt)
+{
+	size_t sz = sizeof(struct branch_stack);
+
+	sz += pt->br_stack_sz * sizeof(struct branch_entry);
+	return zalloc(sz);
+}
+
+static int intel_pt_br_stack_init(struct intel_pt *pt)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(pt->session->evlist, evsel) {
+		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK))
+			evsel->synth_sample_type |= PERF_SAMPLE_BRANCH_STACK;
+	}
+
+	pt->br_stack = intel_pt_alloc_br_stack(pt);
+	if (!pt->br_stack)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void intel_pt_add_br_stack(struct intel_pt *pt,
+				  struct perf_sample *sample)
+{
+	struct thread *thread = machine__findnew_thread(pt->machine,
+							sample->pid,
+							sample->tid);
+
+	thread_stack__br_sample_late(thread, sample->cpu, pt->br_stack,
+				     pt->br_stack_sz, sample->ip,
+				     pt->kernel_start);
+
+	sample->branch_stack = pt->br_stack;
+}
+
 static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 						   unsigned int queue_nr)
 {
@@ -929,10 +969,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	}
 
 	if (pt->synth_opts.last_branch) {
-		size_t sz = sizeof(struct branch_stack);
-
-		sz += pt->br_stack_sz * sizeof(struct branch_entry);
-		ptq->last_branch = zalloc(sz);
+		ptq->last_branch = intel_pt_alloc_br_stack(pt);
 		if (!ptq->last_branch)
 			goto out_free;
 	}
@@ -1963,7 +2000,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags,
 				    state->from_ip, state->to_ip, ptq->insn_len,
 				    state->trace_nr, pt->callstack,
-				    pt->br_stack_sz,
+				    pt->br_stack_sz_plus,
 				    pt->mispred_all);
 	} else {
 		thread_stack__set_trace_nr(ptq->thread, ptq->cpu, state->trace_nr);
@@ -2609,6 +2646,8 @@ static int intel_pt_process_event(struct perf_session *session,
 	if (event->header.type == PERF_RECORD_SAMPLE) {
 		if (pt->synth_opts.add_callchain && !sample->callchain)
 			intel_pt_add_callchain(pt, sample);
+		if (pt->synth_opts.add_last_branch && !sample->branch_stack)
+			intel_pt_add_br_stack(pt, sample);
 	}
 
 	if (event->header.type == PERF_RECORD_AUX &&
@@ -3370,13 +3409,33 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 			goto err_delete_thread;
 	}
 
-	if (pt->synth_opts.last_branch)
+	if (pt->synth_opts.last_branch || pt->synth_opts.add_last_branch) {
 		pt->br_stack_sz = pt->synth_opts.last_branch_sz;
+		pt->br_stack_sz_plus = pt->br_stack_sz;
+	}
+
+	if (pt->synth_opts.add_last_branch) {
+		err = intel_pt_br_stack_init(pt);
+		if (err)
+			goto err_delete_thread;
+		/*
+		 * Additional branch stack size to cater for tracing from the
+		 * actual sample ip to where the sample time is recorded.
+		 * Measured at about 200 branches, but generously set to 1024.
+		 * If kernel space is not being traced, then add just 1 for the
+		 * branch to kernel space.
+		 */
+		if (intel_pt_tracing_kernel(pt))
+			pt->br_stack_sz_plus += 1024;
+		else
+			pt->br_stack_sz_plus += 1;
+	}
 
 	pt->use_thread_stack = pt->synth_opts.callchain ||
 			       pt->synth_opts.add_callchain ||
 			       pt->synth_opts.thread_stack ||
-			       pt->synth_opts.last_branch;
+			       pt->synth_opts.last_branch ||
+			       pt->synth_opts.add_last_branch;
 
 	pt->callstack = pt->synth_opts.callchain ||
 			pt->synth_opts.add_callchain ||
