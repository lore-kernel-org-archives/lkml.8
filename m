Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02922C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B1520FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgFPMYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgFPMV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E61EC08C5C5;
        Tue, 16 Jun 2020 05:21:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb9-0004da-BH; Tue, 16 Jun 2020 14:21:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E06121C04CC;
        Tue, 16 Jun 2020 14:21:49 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:49 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add perf text poke event
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512121922.8997-2-adrian.hunter@intel.com>
References: <20200512121922.8997-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <159231010966.16989.222590734437390694.tip-bot2@tip-bot2>
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

Commit-ID:     e17d43b93e544f5016c0251d2074c15568d5d963
Gitweb:        https://git.kernel.org/tip/e17d43b93e544f5016c0251d2074c15568d5d963
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 12 May 2020 15:19:08 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:48 +02:00

perf: Add perf text poke event

Record (single instruction) changes to the kernel text (i.e.
self-modifying code) in order to support tracers like Intel PT and
ARM CoreSight.

A copy of the running kernel code is needed as a reference point (e.g.
from /proc/kcore). The text poke event records the old bytes and the
new bytes so that the event can be processed forwards or backwards.

The basic problem is recording the modified instruction in an
unambiguous manner given SMP instruction cache (in)coherence. That is,
when modifying an instruction concurrently any solution with one or
multiple timestamps is not sufficient:

	CPU0				CPU1
 0
 1	write insn A
 2					execute insn A
 3	sync-I$
 4

Due to I$, CPU1 might execute either the old or new A. No matter where
we record tracepoints on CPU0, one simply cannot tell what CPU1 will
have observed, except that at 0 it must be the old one and at 4 it
must be the new one.

To solve this, take inspiration from x86 text poking, which has to
solve this exact problem due to variable length instruction encoding
and I-fetch windows.

 1) overwrite the instruction with a breakpoint and sync I$

This guarantees that that code flow will never hit the target
instruction anymore, on any CPU (or rather, it will cause an
exception).

 2) issue the TEXT_POKE event

 3) overwrite the breakpoint with the new instruction and sync I$

Now we know that any execution after the TEXT_POKE event will either
observe the breakpoint (and hit the exception) or the new instruction.

So by guarding the TEXT_POKE event with an exception on either side;
we can now tell, without doubt, which instruction another CPU will
have observed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200512121922.8997-2-adrian.hunter@intel.com
---
 include/linux/perf_event.h      |  8 +++-
 include/uapi/linux/perf_event.h | 21 ++++++-
 kernel/events/core.c            | 90 +++++++++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b4bb320..46fe5cf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1232,6 +1232,9 @@ extern void perf_event_exec(void);
 extern void perf_event_comm(struct task_struct *tsk, bool exec);
 extern void perf_event_namespaces(struct task_struct *tsk);
 extern void perf_event_fork(struct task_struct *tsk);
+extern void perf_event_text_poke(const void *addr,
+				 const void *old_bytes, size_t old_len,
+				 const void *new_bytes, size_t new_len);
 
 /* Callchains */
 DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
@@ -1479,6 +1482,11 @@ static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
 static inline void perf_event_fork(struct task_struct *tsk)		{ }
+static inline void perf_event_text_poke(const void *addr,
+					const void *old_bytes,
+					size_t old_len,
+					const void *new_bytes,
+					size_t new_len)			{ }
 static inline void perf_event_init(void)				{ }
 static inline int  perf_swevent_get_recursion_context(void)		{ return -1; }
 static inline void perf_swevent_put_recursion_context(int rctx)		{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7b2d6fc..e5bee6c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -383,7 +383,8 @@ struct perf_event_attr {
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
-				__reserved_1   : 31;
+				text_poke      :  1, /* include text poke events */
+				__reserved_1   : 30;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1024,6 +1025,24 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_CGROUP			= 19,
 
+	/*
+	 * Records changes to kernel text i.e. self-modified code. 'old_len' is
+	 * the number of old bytes, 'new_len' is the number of new bytes. Either
+	 * 'old_len' or 'new_len' may be zero to indicate, for example, the
+	 * addition or removal of a trampoline. 'bytes' contains the old bytes
+	 * followed immediately by the new bytes.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u16				old_len;
+	 *	u16				new_len;
+	 *	u8				bytes[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_TEXT_POKE			= 20,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 856d98c..9b8f925 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -394,6 +394,7 @@ static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
 static atomic_t nr_cgroup_events __read_mostly;
+static atomic_t nr_text_poke_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4575,7 +4576,7 @@ static bool is_sb_event(struct perf_event *event)
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
-	    attr->context_switch ||
+	    attr->context_switch || attr->text_poke ||
 	    attr->bpf_event)
 		return true;
 	return false;
@@ -4651,6 +4652,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_dec(&nr_bpf_events);
+	if (event->attr.text_poke)
+		atomic_dec(&nr_text_poke_events);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -8628,6 +8631,89 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
 }
 
+struct perf_text_poke_event {
+	const void		*old_bytes;
+	const void		*new_bytes;
+	size_t			pad;
+	u16			old_len;
+	u16			new_len;
+
+	struct {
+		struct perf_event_header	header;
+
+		u64				addr;
+	} event_id;
+};
+
+static int perf_event_text_poke_match(struct perf_event *event)
+{
+	return event->attr.text_poke;
+}
+
+static void perf_event_text_poke_output(struct perf_event *event, void *data)
+{
+	struct perf_text_poke_event *text_poke_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	u64 padding = 0;
+	int ret;
+
+	if (!perf_event_text_poke_match(event))
+		return;
+
+	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, event);
+
+	ret = perf_output_begin(&handle, event, text_poke_event->event_id.header.size);
+	if (ret)
+		return;
+
+	perf_output_put(&handle, text_poke_event->event_id);
+	perf_output_put(&handle, text_poke_event->old_len);
+	perf_output_put(&handle, text_poke_event->new_len);
+
+	__output_copy(&handle, text_poke_event->old_bytes, text_poke_event->old_len);
+	__output_copy(&handle, text_poke_event->new_bytes, text_poke_event->new_len);
+
+	if (text_poke_event->pad)
+		__output_copy(&handle, &padding, text_poke_event->pad);
+
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
+void perf_event_text_poke(const void *addr, const void *old_bytes,
+			  size_t old_len, const void *new_bytes, size_t new_len)
+{
+	struct perf_text_poke_event text_poke_event;
+	size_t tot, pad;
+
+	if (!atomic_read(&nr_text_poke_events))
+		return;
+
+	tot  = sizeof(text_poke_event.old_len) + old_len;
+	tot += sizeof(text_poke_event.new_len) + new_len;
+	pad  = ALIGN(tot, sizeof(u64)) - tot;
+
+	text_poke_event = (struct perf_text_poke_event){
+		.old_bytes    = old_bytes,
+		.new_bytes    = new_bytes,
+		.pad          = pad,
+		.old_len      = old_len,
+		.new_len      = new_len,
+		.event_id  = {
+			.header = {
+				.type = PERF_RECORD_TEXT_POKE,
+				.misc = PERF_RECORD_MISC_KERNEL,
+				.size = sizeof(text_poke_event.event_id) + tot + pad,
+			},
+			.addr = (unsigned long)addr,
+		},
+	};
+
+	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event, NULL);
+}
+
 void perf_event_itrace_started(struct perf_event *event)
 {
 	event->attach_state |= PERF_ATTACH_ITRACE;
@@ -10945,6 +11031,8 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_inc(&nr_bpf_events);
+	if (event->attr.text_poke)
+		atomic_inc(&nr_text_poke_events);
 
 	if (inc) {
 		/*
