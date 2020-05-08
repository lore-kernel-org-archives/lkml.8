Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE29DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D346249D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgEHNFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729865AbgEHNFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D9C05BD09;
        Fri,  8 May 2020 06:05:17 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gi-0007Yk-7b; Fri, 08 May 2020 15:05:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1BE8A1C0857;
        Fri,  8 May 2020 15:05:00 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:59 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf thread-stack: Add branch stack support
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429150751.12570-2-adrian.hunter@intel.com>
References: <20200429150751.12570-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158894309991.8414.18153606352599150415.tip-bot2@tip-bot2>
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

Commit-ID:     86d67180b920d178ae1c2923f50a0759d6ce1a10
Gitweb:        https://git.kernel.org/tip/86d67180b920d178ae1c2923f50a0759d6ce1a10
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 29 Apr 2020 18:07:43 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

perf thread-stack: Add branch stack support

Intel PT already has support for creating branch stacks for each context
(per-cpu or per-thread). In the more common per-cpu case, the branch stack
is not separated for different threads, instead being cleared in between
each sample.

That approach will not work very well for adding branch stacks to
regular events. The branch stacks really need to be accumulated
separately for each thread.

As a start to accomplishing that, this patch adds support for putting
branch stack support into the thread-stack. The advantages are:

1. the branches are accumulated separately for each thread
2. the branch stack is cleared only in between continuous traces

This helps pave the way for adding branch stacks to regular events, not
just synthesized events as at present.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-bts.c    |   2 +-
 tools/perf/util/intel-pt.c     |   2 +-
 tools/perf/util/thread-stack.c | 113 ++++++++++++++++++++++++++++----
 tools/perf/util/thread-stack.h |   5 +-
 4 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 059e1c8..506112f 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -432,7 +432,7 @@ static int intel_bts_process_buffer(struct intel_bts_queue *btsq,
 					    le64_to_cpu(branch->from),
 					    le64_to_cpu(branch->to),
 					    btsq->intel_pt_insn.length,
-					    buffer->buffer_nr + 1);
+					    buffer->buffer_nr + 1, true, 0, 0);
 		if (filter && !(filter & btsq->sample_flags))
 			continue;
 		err = intel_bts_synth_branch_sample(btsq, branch);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 30e1ee6..bdb8447 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2033,7 +2033,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	    pt->synth_opts.thread_stack)
 		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
 				    state->to_ip, ptq->insn_len,
-				    state->trace_nr);
+				    state->trace_nr, true, 0, 0);
 	else
 		thread_stack__set_trace_nr(ptq->thread, ptq->cpu, state->trace_nr);
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 83f6c83..7969883 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -80,6 +80,10 @@ struct thread_stack_entry {
  * @comm: current comm
  * @arr_sz: size of array if this is the first element of an array
  * @rstate: used to detect retpolines
+ * @br_stack_rb: branch stack (ring buffer)
+ * @br_stack_sz: maximum branch stack size
+ * @br_stack_pos: current position in @br_stack_rb
+ * @mispred_all: mark all branches as mispredicted
  */
 struct thread_stack {
 	struct thread_stack_entry *stack;
@@ -95,6 +99,10 @@ struct thread_stack {
 	struct comm *comm;
 	unsigned int arr_sz;
 	enum retpoline_state_t rstate;
+	struct branch_stack *br_stack_rb;
+	unsigned int br_stack_sz;
+	unsigned int br_stack_pos;
+	bool mispred_all;
 };
 
 /*
@@ -126,13 +134,26 @@ static int thread_stack__grow(struct thread_stack *ts)
 }
 
 static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
-			      struct call_return_processor *crp)
+			      struct call_return_processor *crp,
+			      bool callstack, unsigned int br_stack_sz)
 {
 	int err;
 
-	err = thread_stack__grow(ts);
-	if (err)
-		return err;
+	if (callstack) {
+		err = thread_stack__grow(ts);
+		if (err)
+			return err;
+	}
+
+	if (br_stack_sz) {
+		size_t sz = sizeof(struct branch_stack);
+
+		sz += br_stack_sz * sizeof(struct branch_entry);
+		ts->br_stack_rb = zalloc(sz);
+		if (!ts->br_stack_rb)
+			return -ENOMEM;
+		ts->br_stack_sz = br_stack_sz;
+	}
 
 	if (thread->maps && thread->maps->machine) {
 		struct machine *machine = thread->maps->machine;
@@ -150,7 +171,9 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 }
 
 static struct thread_stack *thread_stack__new(struct thread *thread, int cpu,
-					      struct call_return_processor *crp)
+					      struct call_return_processor *crp,
+					      bool callstack,
+					      unsigned int br_stack_sz)
 {
 	struct thread_stack *ts = thread->ts, *new_ts;
 	unsigned int old_sz = ts ? ts->arr_sz : 0;
@@ -176,7 +199,7 @@ static struct thread_stack *thread_stack__new(struct thread *thread, int cpu,
 		ts += cpu;
 
 	if (!ts->stack &&
-	    thread_stack__init(ts, thread, crp))
+	    thread_stack__init(ts, thread, crp, callstack, br_stack_sz))
 		return NULL;
 
 	return ts;
@@ -319,6 +342,9 @@ static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
 
 	if (!crp) {
 		ts->cnt = 0;
+		ts->br_stack_pos = 0;
+		if (ts->br_stack_rb)
+			ts->br_stack_rb->nr = 0;
 		return 0;
 	}
 
@@ -353,8 +379,33 @@ int thread_stack__flush(struct thread *thread)
 	return err;
 }
 
+static void thread_stack__update_br_stack(struct thread_stack *ts, u32 flags,
+					  u64 from_ip, u64 to_ip)
+{
+	struct branch_stack *bs = ts->br_stack_rb;
+	struct branch_entry *be;
+
+	if (!ts->br_stack_pos)
+		ts->br_stack_pos = ts->br_stack_sz;
+
+	ts->br_stack_pos -= 1;
+
+	be              = &bs->entries[ts->br_stack_pos];
+	be->from        = from_ip;
+	be->to          = to_ip;
+	be->flags.value = 0;
+	be->flags.abort = !!(flags & PERF_IP_FLAG_TX_ABORT);
+	be->flags.in_tx = !!(flags & PERF_IP_FLAG_IN_TX);
+	/* No support for mispredict */
+	be->flags.mispred = ts->mispred_all;
+
+	if (bs->nr < ts->br_stack_sz)
+		bs->nr += 1;
+}
+
 int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
-			u64 to_ip, u16 insn_len, u64 trace_nr)
+			u64 to_ip, u16 insn_len, u64 trace_nr, bool callstack,
+			unsigned int br_stack_sz, bool mispred_all)
 {
 	struct thread_stack *ts = thread__stack(thread, cpu);
 
@@ -362,12 +413,13 @@ int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 		return -EINVAL;
 
 	if (!ts) {
-		ts = thread_stack__new(thread, cpu, NULL);
+		ts = thread_stack__new(thread, cpu, NULL, callstack, br_stack_sz);
 		if (!ts) {
 			pr_warning("Out of memory: no thread stack\n");
 			return -ENOMEM;
 		}
 		ts->trace_nr = trace_nr;
+		ts->mispred_all = mispred_all;
 	}
 
 	/*
@@ -381,8 +433,14 @@ int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 		ts->trace_nr = trace_nr;
 	}
 
-	/* Stop here if thread_stack__process() is in use */
-	if (ts->crp)
+	if (br_stack_sz)
+		thread_stack__update_br_stack(ts, flags, from_ip, to_ip);
+
+	/*
+	 * Stop here if thread_stack__process() is in use, or not recording call
+	 * stack.
+	 */
+	if (ts->crp || !callstack)
 		return 0;
 
 	if (flags & PERF_IP_FLAG_CALL) {
@@ -430,6 +488,7 @@ static void __thread_stack__free(struct thread *thread, struct thread_stack *ts)
 {
 	__thread_stack__flush(thread, ts);
 	zfree(&ts->stack);
+	zfree(&ts->br_stack_rb);
 }
 
 static void thread_stack__reset(struct thread *thread, struct thread_stack *ts)
@@ -554,6 +613,38 @@ out:
 	}
 }
 
+void thread_stack__br_sample(struct thread *thread, int cpu,
+			     struct branch_stack *dst, unsigned int sz)
+{
+	struct thread_stack *ts = thread__stack(thread, cpu);
+	const size_t bsz = sizeof(struct branch_entry);
+	struct branch_stack *src;
+	struct branch_entry *be;
+	unsigned int nr;
+
+	dst->nr = 0;
+
+	if (!ts)
+		return;
+
+	src = ts->br_stack_rb;
+	if (!src->nr)
+		return;
+
+	dst->nr = min((unsigned int)src->nr, sz);
+
+	be = &dst->entries[0];
+	nr = min(ts->br_stack_sz - ts->br_stack_pos, (unsigned int)dst->nr);
+	memcpy(be, &src->entries[ts->br_stack_pos], bsz * nr);
+
+	if (src->nr >= ts->br_stack_sz) {
+		sz -= nr;
+		be = &dst->entries[nr];
+		nr = min(ts->br_stack_pos, sz);
+		memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
+	}
+}
+
 struct call_return_processor *
 call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data)
@@ -921,7 +1012,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	}
 
 	if (!ts) {
-		ts = thread_stack__new(thread, sample->cpu, crp);
+		ts = thread_stack__new(thread, sample->cpu, crp, true, 0);
 		if (!ts)
 			return -ENOMEM;
 		ts->comm = comm;
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index 8962ddc..c279a0c 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -81,13 +81,16 @@ struct call_return_processor {
 };
 
 int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
-			u64 to_ip, u16 insn_len, u64 trace_nr);
+			u64 to_ip, u16 insn_len, u64 trace_nr, bool callstack,
+			unsigned int br_stack_sz, bool mispred_all);
 void thread_stack__set_trace_nr(struct thread *thread, int cpu, u64 trace_nr);
 void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *chain,
 			  size_t sz, u64 ip, u64 kernel_start);
 void thread_stack__sample_late(struct thread *thread, int cpu,
 			       struct ip_callchain *chain, size_t sz, u64 ip,
 			       u64 kernel_start);
+void thread_stack__br_sample(struct thread *thread, int cpu,
+			     struct branch_stack *dst, unsigned int sz);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread, int cpu);
