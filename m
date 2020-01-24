Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9268DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D94920709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbgAXPSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387438AbgAXPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4576214DB;
        Fri, 24 Jan 2020 15:17:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i4-000qCG-RP; Fri, 24 Jan 2020 10:17:24 -0500
Message-Id: <20200124151724.737628955@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:16:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 03/14] tracing: Allow trace_printk() to nest in other tracing code
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

trace_printk() is used to debug the kernel which includes the tracing
infrastructure. But because it writes to the ring buffer, and so does much
of the tracing infrastructure, the ring buffer's recursive detection will
drop writes to the ring buffer that is in the same context as the current
write is happening (it allows interrupts to write when normal context is
writing, but wont let normal context write while normal context is writing).

This can cause confusion and think that the code is where the trace_printk()
exists is not hit. To solve this, up the recursive nesting of the ring
buffer when trace_printk() is called before it writes to the buffer itself.

Note, this does make it dangerous to use trace_printk() in the ring buffer
code itself, because this basically disables the recursion protection of
trace_printk() buffer writes. But as trace_printk() is only used for
debugging, and if this does occur, the developer will see the cause real
quick (recursive blowing up of the stack). Thus the developer can deal with
that. But having trace_printk() silently ignored is a much bigger problem,
and disabling recursive protection is a small price to pay to fix it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 106bbc0988fe..2e1db19dce97 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -866,10 +866,13 @@ int __trace_puts(unsigned long ip, const char *str, int size)
 
 	local_save_flags(irq_flags);
 	buffer = global_trace.array_buffer.buffer;
+	ring_buffer_nest_start(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc, 
 					    irq_flags, pc);
-	if (!event)
-		return 0;
+	if (!event) {
+		size = 0;
+		goto out;
+	}
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
@@ -885,7 +888,8 @@ int __trace_puts(unsigned long ip, const char *str, int size)
 
 	__buffer_unlock_commit(buffer, event);
 	ftrace_trace_stack(&global_trace, buffer, irq_flags, 4, pc, NULL);
-
+ out:
+	ring_buffer_nest_end(buffer);
 	return size;
 }
 EXPORT_SYMBOL_GPL(__trace_puts);
@@ -902,6 +906,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	struct bputs_entry *entry;
 	unsigned long irq_flags;
 	int size = sizeof(struct bputs_entry);
+	int ret = 0;
 	int pc;
 
 	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
@@ -914,10 +919,12 @@ int __trace_bputs(unsigned long ip, const char *str)
 
 	local_save_flags(irq_flags);
 	buffer = global_trace.array_buffer.buffer;
+
+	ring_buffer_nest_start(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_BPUTS, size,
 					    irq_flags, pc);
 	if (!event)
-		return 0;
+		goto out;
 
 	entry = ring_buffer_event_data(event);
 	entry->ip			= ip;
@@ -926,7 +933,10 @@ int __trace_bputs(unsigned long ip, const char *str)
 	__buffer_unlock_commit(buffer, event);
 	ftrace_trace_stack(&global_trace, buffer, irq_flags, 4, pc, NULL);
 
-	return 1;
+	ret = 1;
+ out:
+	ring_buffer_nest_end(buffer);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__trace_bputs);
 
@@ -3225,6 +3235,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	local_save_flags(flags);
 	size = sizeof(*entry) + sizeof(u32) * len;
 	buffer = tr->array_buffer.buffer;
+	ring_buffer_nest_start(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_BPRINT, size,
 					    flags, pc);
 	if (!event)
@@ -3240,6 +3251,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	}
 
 out:
+	ring_buffer_nest_end(buffer);
 	put_trace_buf();
 
 out_nobuffer:
@@ -3282,6 +3294,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 
 	local_save_flags(flags);
 	size = sizeof(*entry) + len + 1;
+	ring_buffer_nest_start(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    flags, pc);
 	if (!event)
@@ -3296,6 +3309,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	}
 
 out:
+	ring_buffer_nest_end(buffer);
 	put_trace_buf();
 
 out_nobuffer:
-- 
2.24.1


