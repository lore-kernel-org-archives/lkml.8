Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A52C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5069A24658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgANVEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:04:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgANVDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E951D24683;
        Tue, 14 Jan 2020 21:03:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLd-000D6M-SM; Tue, 14 Jan 2020 16:03:37 -0500
Message-Id: <20200114210337.758284327@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 14/26] tracing: kprobes: Output kprobe event to printk buffer
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since kprobe-events use event_trigger_unlock_commit_regs() directly,
that events doesn't show up in printk buffer if "tp_printk" is set.

Use trace_event_buffer_commit() in kprobe events so that it can
invoke output_printk() as same as other trace events.

Link: http://lkml.kernel.org/r/157867233085.17873.5210928676787339604.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
[ Adjusted data var declaration placement in __kretprobe_trace_func() ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h |  1 +
 kernel/trace/trace.c         |  4 +--
 kernel/trace/trace_events.c  |  1 +
 kernel/trace/trace_kprobe.c  | 57 ++++++++++++++++++------------------
 4 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5f7b2b1fce24..20948ee56f8c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -216,6 +216,7 @@ struct trace_event_buffer {
 	void				*entry;
 	unsigned long			flags;
 	int				pc;
+	struct pt_regs			*regs;
 };
 
 void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b4294eb020f8..cb850d2c4bfa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2680,9 +2680,9 @@ void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
 
-	event_trigger_unlock_commit(fbuffer->trace_file, fbuffer->buffer,
+	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
 				    fbuffer->event, fbuffer->entry,
-				    fbuffer->flags, fbuffer->pc);
+				    fbuffer->flags, fbuffer->pc, fbuffer->regs);
 }
 EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a16d1b601c5c..dfb736a964d6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -272,6 +272,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 	if (!fbuffer->event)
 		return NULL;
 
+	fbuffer->regs = NULL;
 	fbuffer->entry = ring_buffer_event_data(fbuffer->event);
 	return fbuffer->entry;
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 477b6b011e7d..33a6a661904b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1175,35 +1175,35 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 		    struct trace_event_file *trace_file)
 {
 	struct kprobe_trace_entry_head *entry;
-	struct trace_buffer *buffer;
-	struct ring_buffer_event *event;
-	int size, dsize, pc;
-	unsigned long irq_flags;
 	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
+	struct trace_event_buffer fbuffer;
+	int dsize;
 
 	WARN_ON(call != trace_file->event_call);
 
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	local_save_flags(irq_flags);
-	pc = preempt_count();
+	local_save_flags(fbuffer.flags);
+	fbuffer.pc = preempt_count();
+	fbuffer.trace_file = trace_file;
 
 	dsize = __get_data_size(&tk->tp, regs);
-	size = sizeof(*entry) + tk->tp.size + dsize;
 
-	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
-						call->event.type,
-						size, irq_flags, pc);
-	if (!event)
+	fbuffer.event =
+		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
+					call->event.type,
+					sizeof(*entry) + tk->tp.size + dsize,
+					fbuffer.flags, fbuffer.pc);
+	if (!fbuffer.event)
 		return;
 
-	entry = ring_buffer_event_data(event);
+	fbuffer.regs = regs;
+	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
-	event_trigger_unlock_commit_regs(trace_file, buffer, event,
-					 entry, irq_flags, pc, regs);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 static void
@@ -1223,36 +1223,35 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 		       struct trace_event_file *trace_file)
 {
 	struct kretprobe_trace_entry_head *entry;
-	struct trace_buffer *buffer;
-	struct ring_buffer_event *event;
-	int size, pc, dsize;
-	unsigned long irq_flags;
+	struct trace_event_buffer fbuffer;
 	struct trace_event_call *call = trace_probe_event_call(&tk->tp);
+	int dsize;
 
 	WARN_ON(call != trace_file->event_call);
 
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	local_save_flags(irq_flags);
-	pc = preempt_count();
+	local_save_flags(fbuffer.flags);
+	fbuffer.pc = preempt_count();
+	fbuffer.trace_file = trace_file;
 
 	dsize = __get_data_size(&tk->tp, regs);
-	size = sizeof(*entry) + tk->tp.size + dsize;
-
-	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
-						call->event.type,
-						size, irq_flags, pc);
-	if (!event)
+	fbuffer.event =
+		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
+					call->event.type,
+					sizeof(*entry) + tk->tp.size + dsize,
+					fbuffer.flags, fbuffer.pc);
+	if (!fbuffer.event)
 		return;
 
-	entry = ring_buffer_event_data(event);
+	fbuffer.regs = regs;
+	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = (unsigned long)ri->ret_addr;
 	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
-	event_trigger_unlock_commit_regs(trace_file, buffer, event,
-					 entry, irq_flags, pc, regs);
+	trace_event_buffer_commit(&fbuffer);
 }
 
 static void
-- 
2.24.1


