Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB9C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B412721974
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgD2PHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:07:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:48797 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgD2PHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:07:42 -0400
IronPort-SDR: MVLB9P2h7zY8YM5Wlxb4cNUSHdfWczoLXHeeWaVIyZqRhuGZzKx7KxKixcqvVhRiGLKQzpryIz
 i/CsyRSmmqfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:07:41 -0700
IronPort-SDR: OPeYninfVW8uR1JxBpF6mWWe7R0ZvPxy0cZxNvsfZu7eE3q9BXQ5vV+U6GKL0+U8mwajCaJV0g
 sirvIwErzDlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="293227446"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2020 08:07:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] perf intel-pt: Add support for synthesizing branch stacks for regular events
Date:   Wed, 29 Apr 2020 18:07:49 +0300
Message-Id: <20200429150751.12570-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429150751.12570-1-adrian.hunter@intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 # Overhead  Command  Source Shared Object  Source Symbol                                   Target Symbol                                   Basic Block Cycles
 # ........  .......  ....................  ..............................................  ..............................................  ..................
 #
      5.49%  uname    libc-2.30.so          [.] _dl_addr                                    [.] _dl_addr                                    -
      2.41%  uname    ld-2.30.so            [.] _dl_relocate_object                         [.] _dl_relocate_object                         -
      2.31%  uname    ld-2.30.so            [.] do_lookup_x                                 [.] do_lookup_x                                 -
      2.17%  uname    [kernel.kallsyms]     [k] unmap_page_range                            [k] unmap_page_range                            -
      2.05%  uname    ld-2.30.so            [k] _dl_start                                   [k] _dl_start                                   -
      1.97%  uname    ld-2.30.so            [.] _dl_lookup_symbol_x                         [.] _dl_lookup_symbol_x                         -
      1.94%  uname    [kernel.kallsyms]     [k] filemap_map_pages                           [k] filemap_map_pages                           -
      1.60%  uname    [kernel.kallsyms]     [k] __handle_mm_fault                           [k] __handle_mm_fault                           -
      1.44%  uname    [kernel.kallsyms]     [k] page_add_file_rmap                          [k] page_add_file_rmap                          -
      1.12%  uname    [kernel.kallsyms]     [k] vma_interval_tree_insert                    [k] vma_interval_tree_insert                    -
      0.94%  uname    [kernel.kallsyms]     [k] perf_iterate_ctx                            [k] perf_iterate_ctx                            -

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 73 ++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 248a39fd4d0e..7fb807b91f73 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -71,6 +71,7 @@ struct intel_pt {
 	bool use_thread_stack;
 	bool callstack;
 	unsigned int br_stack_sz;
+	unsigned int br_stack_sz_plus;
 	int have_sched_switch;
 	u32 pmu_type;
 	u64 kernel_start;
@@ -129,6 +130,7 @@ struct intel_pt {
 	unsigned int range_cnt;
 
 	struct ip_callchain *chain;
+	struct branch_stack *br_stack;
 };
 
 enum switch_state {
@@ -910,6 +912,44 @@ static void intel_pt_add_callchain(struct intel_pt *pt,
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
@@ -928,10 +968,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
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
@@ -1962,7 +1999,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags,
 				    state->from_ip, state->to_ip, ptq->insn_len,
 				    state->trace_nr, pt->callstack,
-				    pt->br_stack_sz,
+				    pt->br_stack_sz_plus,
 				    pt->mispred_all);
 	} else {
 		thread_stack__set_trace_nr(ptq->thread, ptq->cpu, state->trace_nr);
@@ -2608,6 +2645,8 @@ static int intel_pt_process_event(struct perf_session *session,
 	if (event->header.type == PERF_RECORD_SAMPLE) {
 		if (pt->synth_opts.add_callchain && !sample->callchain)
 			intel_pt_add_callchain(pt, sample);
+		if (pt->synth_opts.add_last_branch && !sample->branch_stack)
+			intel_pt_add_br_stack(pt, sample);
 	}
 
 	if (event->header.type == PERF_RECORD_AUX &&
@@ -3369,13 +3408,33 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
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
-- 
2.17.1

