Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F97C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A398C21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD2PHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:07:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:48789 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2PHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:07:35 -0400
IronPort-SDR: YfXDklspG9LfWwPl70iETxPXGg1yBWxahGIMpSTgnwWouJX+PYz2xKdXuCB/SCF8abBjUXFG6M
 M081Sx5FaO8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:07:34 -0700
IronPort-SDR: f14gdEODFlrfMMkRuo61tCQBXXwbBwL5NLLjCTRb3vN8qusUuMbwAkVtfBnnysq5+DwUUGuUXs
 +5gEV2BUIN6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="293227399"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2020 08:07:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] perf intel-pt: Change branch stack support to use thread-stacks
Date:   Wed, 29 Apr 2020 18:07:45 +0300
Message-Id: <20200429150751.12570-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429150751.12570-1-adrian.hunter@intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change Intel PT's branch stack support to use thread stacks. The
advantages of using branch stack support from the thread-stack are:
1. the branches are accumulated separately for each thread
2. the branch stack is cleared only in between continuous traces

This helps pave the way for adding branch stacks to regular events, not
just synthesized events as at present.

While the 2 approaches are not identical, in simple cases the results
can be identical e.g.

  Before:

    # perf record --kcore -e intel_pt// uname
    # perf script --itrace=i10usl -F+brstacksym,+addr,+flags > cmp1.txt

  After:

    # perf script --itrace=i10usl -F+brstacksym,+addr,+flags > cmp2.txt
    # diff -s cmp1.txt cmp2.txt
    Files cmp1.txt and cmp2.txt are identical

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 141 ++++++++++---------------------------
 1 file changed, 39 insertions(+), 102 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index afc42a6e4e00..248a39fd4d0e 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -69,6 +69,8 @@ struct intel_pt {
 	bool sync_switch;
 	bool mispred_all;
 	bool use_thread_stack;
+	bool callstack;
+	unsigned int br_stack_sz;
 	int have_sched_switch;
 	u32 pmu_type;
 	u64 kernel_start;
@@ -146,8 +148,6 @@ struct intel_pt_queue {
 	const struct intel_pt_state *state;
 	struct ip_callchain *chain;
 	struct branch_stack *last_branch;
-	struct branch_stack *last_branch_rb;
-	size_t last_branch_pos;
 	union perf_event *event_buf;
 	bool on_heap;
 	bool stop;
@@ -930,14 +930,10 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	if (pt->synth_opts.last_branch) {
 		size_t sz = sizeof(struct branch_stack);
 
-		sz += pt->synth_opts.last_branch_sz *
-		      sizeof(struct branch_entry);
+		sz += pt->br_stack_sz * sizeof(struct branch_entry);
 		ptq->last_branch = zalloc(sz);
 		if (!ptq->last_branch)
 			goto out_free;
-		ptq->last_branch_rb = zalloc(sz);
-		if (!ptq->last_branch_rb)
-			goto out_free;
 	}
 
 	ptq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
@@ -1006,7 +1002,6 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 out_free:
 	zfree(&ptq->event_buf);
 	zfree(&ptq->last_branch);
-	zfree(&ptq->last_branch_rb);
 	zfree(&ptq->chain);
 	free(ptq);
 	return NULL;
@@ -1022,7 +1017,6 @@ static void intel_pt_free_queue(void *priv)
 	intel_pt_decoder_free(ptq->decoder);
 	zfree(&ptq->event_buf);
 	zfree(&ptq->last_branch);
-	zfree(&ptq->last_branch_rb);
 	zfree(&ptq->chain);
 	free(ptq);
 }
@@ -1190,58 +1184,6 @@ static int intel_pt_setup_queues(struct intel_pt *pt)
 	return 0;
 }
 
-static inline void intel_pt_copy_last_branch_rb(struct intel_pt_queue *ptq)
-{
-	struct branch_stack *bs_src = ptq->last_branch_rb;
-	struct branch_stack *bs_dst = ptq->last_branch;
-	size_t nr = 0;
-
-	bs_dst->nr = bs_src->nr;
-
-	if (!bs_src->nr)
-		return;
-
-	nr = ptq->pt->synth_opts.last_branch_sz - ptq->last_branch_pos;
-	memcpy(&bs_dst->entries[0],
-	       &bs_src->entries[ptq->last_branch_pos],
-	       sizeof(struct branch_entry) * nr);
-
-	if (bs_src->nr >= ptq->pt->synth_opts.last_branch_sz) {
-		memcpy(&bs_dst->entries[nr],
-		       &bs_src->entries[0],
-		       sizeof(struct branch_entry) * ptq->last_branch_pos);
-	}
-}
-
-static inline void intel_pt_reset_last_branch_rb(struct intel_pt_queue *ptq)
-{
-	ptq->last_branch_pos = 0;
-	ptq->last_branch_rb->nr = 0;
-}
-
-static void intel_pt_update_last_branch_rb(struct intel_pt_queue *ptq)
-{
-	const struct intel_pt_state *state = ptq->state;
-	struct branch_stack *bs = ptq->last_branch_rb;
-	struct branch_entry *be;
-
-	if (!ptq->last_branch_pos)
-		ptq->last_branch_pos = ptq->pt->synth_opts.last_branch_sz;
-
-	ptq->last_branch_pos -= 1;
-
-	be              = &bs->entries[ptq->last_branch_pos];
-	be->from        = state->from_ip;
-	be->to          = state->to_ip;
-	be->flags.abort = !!(state->flags & INTEL_PT_ABORT_TX);
-	be->flags.in_tx = !!(state->flags & INTEL_PT_IN_TX);
-	/* No support for mispredict */
-	be->flags.mispred = ptq->pt->mispred_all;
-
-	if (bs->nr < ptq->pt->synth_opts.last_branch_sz)
-		bs->nr += 1;
-}
-
 static inline bool intel_pt_skip_event(struct intel_pt *pt)
 {
 	return pt->synth_opts.initial_skip &&
@@ -1309,9 +1251,9 @@ static inline int intel_pt_opt_inject(struct intel_pt *pt,
 	return intel_pt_inject_event(event, sample, type);
 }
 
-static int intel_pt_deliver_synth_b_event(struct intel_pt *pt,
-					  union perf_event *event,
-					  struct perf_sample *sample, u64 type)
+static int intel_pt_deliver_synth_event(struct intel_pt *pt,
+					union perf_event *event,
+					struct perf_sample *sample, u64 type)
 {
 	int ret;
 
@@ -1371,8 +1313,8 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 		ptq->last_br_cyc_cnt = ptq->ipc_cyc_cnt;
 	}
 
-	return intel_pt_deliver_synth_b_event(pt, event, &sample,
-					      pt->branches_sample_type);
+	return intel_pt_deliver_synth_event(pt, event, &sample,
+					    pt->branches_sample_type);
 }
 
 static void intel_pt_prep_sample(struct intel_pt *pt,
@@ -1390,27 +1332,12 @@ static void intel_pt_prep_sample(struct intel_pt *pt,
 	}
 
 	if (pt->synth_opts.last_branch) {
-		intel_pt_copy_last_branch_rb(ptq);
+		thread_stack__br_sample(ptq->thread, ptq->cpu, ptq->last_branch,
+					pt->br_stack_sz);
 		sample->branch_stack = ptq->last_branch;
 	}
 }
 
-static inline int intel_pt_deliver_synth_event(struct intel_pt *pt,
-					       struct intel_pt_queue *ptq,
-					       union perf_event *event,
-					       struct perf_sample *sample,
-					       u64 type)
-{
-	int ret;
-
-	ret = intel_pt_deliver_synth_b_event(pt, event, sample, type);
-
-	if (pt->synth_opts.last_branch)
-		intel_pt_reset_last_branch_rb(ptq);
-
-	return ret;
-}
-
 static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
@@ -1435,7 +1362,7 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 
 	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->instructions_sample_type);
 }
 
@@ -1453,7 +1380,7 @@ static int intel_pt_synth_transaction_sample(struct intel_pt_queue *ptq)
 	sample.id = ptq->pt->transactions_id;
 	sample.stream_id = ptq->pt->transactions_id;
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->transactions_sample_type);
 }
 
@@ -1494,7 +1421,7 @@ static int intel_pt_synth_ptwrite_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->ptwrites_sample_type);
 }
 
@@ -1524,7 +1451,7 @@ static int intel_pt_synth_cbr_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1549,7 +1476,7 @@ static int intel_pt_synth_mwait_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1574,7 +1501,7 @@ static int intel_pt_synth_pwre_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1599,7 +1526,7 @@ static int intel_pt_synth_exstop_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1624,7 +1551,7 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 	sample.raw_size = perf_synth__raw_size(raw);
 	sample.raw_data = perf_synth__raw_data(&raw);
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
+	return intel_pt_deliver_synth_event(pt, event, &sample,
 					    pt->pwr_events_sample_type);
 }
 
@@ -1844,7 +1771,9 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 			intel_pt_add_lbrs(&br.br_stack, items);
 			sample.branch_stack = &br.br_stack;
 		} else if (pt->synth_opts.last_branch) {
-			intel_pt_copy_last_branch_rb(ptq);
+			thread_stack__br_sample(ptq->thread, ptq->cpu,
+						ptq->last_branch,
+						pt->br_stack_sz);
 			sample.branch_stack = ptq->last_branch;
 		} else {
 			br.br_stack.nr = 0;
@@ -1879,7 +1808,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		sample.transaction = txn;
 	}
 
-	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
+	return intel_pt_deliver_synth_event(pt, event, &sample, sample_type);
 }
 
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
@@ -2029,12 +1958,15 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	if (!(state->type & INTEL_PT_BRANCH))
 		return 0;
 
-	if (pt->use_thread_stack)
-		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
-				    state->to_ip, ptq->insn_len,
-				    state->trace_nr, true, 0, 0);
-	else
+	if (pt->use_thread_stack) {
+		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags,
+				    state->from_ip, state->to_ip, ptq->insn_len,
+				    state->trace_nr, pt->callstack,
+				    pt->br_stack_sz,
+				    pt->mispred_all);
+	} else {
 		thread_stack__set_trace_nr(ptq->thread, ptq->cpu, state->trace_nr);
+	}
 
 	if (pt->sample_branches) {
 		err = intel_pt_synth_branch_sample(ptq);
@@ -2042,9 +1974,6 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 			return err;
 	}
 
-	if (pt->synth_opts.last_branch)
-		intel_pt_update_last_branch_rb(ptq);
-
 	if (!ptq->sync_switch)
 		return 0;
 
@@ -3440,9 +3369,17 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 			goto err_delete_thread;
 	}
 
+	if (pt->synth_opts.last_branch)
+		pt->br_stack_sz = pt->synth_opts.last_branch_sz;
+
 	pt->use_thread_stack = pt->synth_opts.callchain ||
 			       pt->synth_opts.add_callchain ||
-			       pt->synth_opts.thread_stack;
+			       pt->synth_opts.thread_stack ||
+			       pt->synth_opts.last_branch;
+
+	pt->callstack = pt->synth_opts.callchain ||
+			pt->synth_opts.add_callchain ||
+			pt->synth_opts.thread_stack;
 
 	err = intel_pt_synth_events(pt, session);
 	if (err)
-- 
2.17.1

