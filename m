Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD0AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3112070A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgENOft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgENOfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:35:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515202070A;
        Thu, 14 May 2020 14:35:46 +0000 (UTC)
Date:   Thu, 14 May 2020 10:35:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: A few more fixes for v5.7
Message-ID: <20200514103544.3dfb803d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Various tracing fixes:

 - Fix a crash when having function tracing and function stack tracing on
   the command line. The ftrace trampolines are created as executable and
   read only. But the stack tracer tries to modify them with text_poke()
   which expects all kernel text to still be writable at boot.
   Keep the trampolines writable at boot, and convert them to read-only
   with the rest of the kernel.

 - A selftest was triggering in the ring buffer iterator code, that
   is no longer valid with the update of keeping the ring buffer
   writable while a iterator is reading. Just bail after three failed
   attempts to get an event and remove the warning and disabling of the
   ring buffer.

 - While modifying the ring buffer code, decided to remove all the
   unnecessary BUG() calls.


Please pull the latest trace-v5.7-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.7-rc5

Tag SHA1: fae2d408d8746a002d3fda65c71d88af2586f4bd
Head SHA1: da4d401a6b8fda7414033f81982f64ade02c0e27


Steven Rostedt (VMware) (3):
      x86/ftrace: Have ftrace trampolines turn read-only at the end of system boot up
      ring-buffer: Don't deactivate the ring buffer on failed iterator reads
      ring-buffer: Remove all BUG() calls

----
 arch/x86/include/asm/ftrace.h  |  6 ++++++
 arch/x86/kernel/ftrace.c       | 29 ++++++++++++++++++++++++++++-
 arch/x86/mm/init_64.c          |  3 +++
 include/linux/ftrace.h         | 23 +++++++++++++++++++++++
 kernel/trace/ftrace_internal.h | 22 ----------------------
 kernel/trace/ring_buffer.c     | 34 +++++++++++++---------------------
 6 files changed, 73 insertions(+), 44 deletions(-)
---------------------------
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 85be2f506272..89af0d2c62aa 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -56,6 +56,12 @@ struct dyn_arch_ftrace {
 
 #ifndef __ASSEMBLY__
 
+#if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_DYNAMIC_FTRACE)
+extern void set_ftrace_ops_ro(void);
+#else
+static inline void set_ftrace_ops_ro(void) { }
+#endif
+
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 37a0aeaf89e7..b0e641793be4 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -407,7 +407,8 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	set_vm_flush_reset_perms(trampoline);
 
-	set_memory_ro((unsigned long)trampoline, npages);
+	if (likely(system_state != SYSTEM_BOOTING))
+		set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
@@ -415,6 +416,32 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	return 0;
 }
 
+void set_ftrace_ops_ro(void)
+{
+	struct ftrace_ops *ops;
+	unsigned long start_offset;
+	unsigned long end_offset;
+	unsigned long npages;
+	unsigned long size;
+
+	do_for_each_ftrace_op(ops, ftrace_ops_list) {
+		if (!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
+			continue;
+
+		if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
+			start_offset = (unsigned long)ftrace_regs_caller;
+			end_offset = (unsigned long)ftrace_regs_caller_end;
+		} else {
+			start_offset = (unsigned long)ftrace_caller;
+			end_offset = (unsigned long)ftrace_epilogue;
+		}
+		size = end_offset - start_offset;
+		size = size + RET_SIZE + sizeof(void *);
+		npages = DIV_ROUND_UP(size, PAGE_SIZE);
+		set_memory_ro((unsigned long)ops->trampoline, npages);
+	} while_for_each_ftrace_op(ops);
+}
+
 static unsigned long calc_trampoline_call_offset(bool save_regs)
 {
 	unsigned long start_offset;
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3b289c2f75cd..8b5f73f5e207 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -54,6 +54,7 @@
 #include <asm/init.h>
 #include <asm/uv/uv.h>
 #include <asm/setup.h>
+#include <asm/ftrace.h>
 
 #include "mm_internal.h"
 
@@ -1291,6 +1292,8 @@ void mark_rodata_ro(void)
 	all_end = roundup((unsigned long)_brk_end, PMD_SIZE);
 	set_memory_nx(text_end, (all_end - text_end) >> PAGE_SHIFT);
 
+	set_ftrace_ops_ro();
+
 #ifdef CONFIG_CPA_DEBUG
 	printk(KERN_INFO "Testing CPA: undo %lx-%lx\n", start, end);
 	set_memory_rw(start, (end-start) >> PAGE_SHIFT);
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index db95244a62d4..ab4bd15cbcdb 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -210,6 +210,29 @@ struct ftrace_ops {
 #endif
 };
 
+extern struct ftrace_ops __rcu *ftrace_ops_list;
+extern struct ftrace_ops ftrace_list_end;
+
+/*
+ * Traverse the ftrace_global_list, invoking all entries.  The reason that we
+ * can use rcu_dereference_raw_check() is that elements removed from this list
+ * are simply leaked, so there is no need to interact with a grace-period
+ * mechanism.  The rcu_dereference_raw_check() calls are needed to handle
+ * concurrent insertions into the ftrace_global_list.
+ *
+ * Silly Alpha and silly pointer-speculation compiler optimizations!
+ */
+#define do_for_each_ftrace_op(op, list)			\
+	op = rcu_dereference_raw_check(list);			\
+	do
+
+/*
+ * Optimized for just a single item in the list (as that is the normal case).
+ */
+#define while_for_each_ftrace_op(op)				\
+	while (likely(op = rcu_dereference_raw_check((op)->next)) &&	\
+	       unlikely((op) != &ftrace_list_end))
+
 /*
  * Type of the current tracing.
  */
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 0456e0a3dab1..382775edf690 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -4,28 +4,6 @@
 
 #ifdef CONFIG_FUNCTION_TRACER
 
-/*
- * Traverse the ftrace_global_list, invoking all entries.  The reason that we
- * can use rcu_dereference_raw_check() is that elements removed from this list
- * are simply leaked, so there is no need to interact with a grace-period
- * mechanism.  The rcu_dereference_raw_check() calls are needed to handle
- * concurrent insertions into the ftrace_global_list.
- *
- * Silly Alpha and silly pointer-speculation compiler optimizations!
- */
-#define do_for_each_ftrace_op(op, list)			\
-	op = rcu_dereference_raw_check(list);			\
-	do
-
-/*
- * Optimized for just a single item in the list (as that is the normal case).
- */
-#define while_for_each_ftrace_op(op)				\
-	while (likely(op = rcu_dereference_raw_check((op)->next)) &&	\
-	       unlikely((op) != &ftrace_list_end))
-
-extern struct ftrace_ops __rcu *ftrace_ops_list;
-extern struct ftrace_ops ftrace_list_end;
 extern struct mutex ftrace_lock;
 extern struct ftrace_ops global_ops;
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6f0b42ceeb00..b8e1ca48be50 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -193,7 +193,7 @@ rb_event_length(struct ring_buffer_event *event)
 	case RINGBUF_TYPE_DATA:
 		return rb_event_data_length(event);
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
 	}
 	/* not hit */
 	return 0;
@@ -249,7 +249,7 @@ rb_event_data(struct ring_buffer_event *event)
 {
 	if (extended_time(event))
 		event = skip_time_extend(event);
-	BUG_ON(event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
+	WARN_ON_ONCE(event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 	/* If length is in len field, then array[0] has the data */
 	if (event->type_len)
 		return (void *)&event->array[0];
@@ -3727,7 +3727,7 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	default:
-		BUG();
+		RB_WARN_ON(cpu_buffer, 1);
 	}
 	return;
 }
@@ -3757,7 +3757,7 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 		return;
 
 	default:
-		BUG();
+		RB_WARN_ON(iter->cpu_buffer, 1);
 	}
 	return;
 }
@@ -4020,7 +4020,7 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 		return event;
 
 	default:
-		BUG();
+		RB_WARN_ON(cpu_buffer, 1);
 	}
 
 	return NULL;
@@ -4034,7 +4034,6 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
-	bool failed = false;
 
 	if (ts)
 		*ts = 0;
@@ -4056,19 +4055,14 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 		return NULL;
 
 	/*
-	 * We repeat when a time extend is encountered or we hit
-	 * the end of the page. Since the time extend is always attached
-	 * to a data event, we should never loop more than three times.
-	 * Once for going to next page, once on time extend, and
-	 * finally once to get the event.
-	 * We should never hit the following condition more than thrice,
-	 * unless the buffer is very small, and there's a writer
-	 * that is causing the reader to fail getting an event.
+	 * As the writer can mess with what the iterator is trying
+	 * to read, just give up if we fail to get an event after
+	 * three tries. The iterator is not as reliable when reading
+	 * the ring buffer with an active write as the consumer is.
+	 * Do not warn if the three failures is reached.
 	 */
-	if (++nr_loops > 3) {
-		RB_WARN_ON(cpu_buffer, !failed);
+	if (++nr_loops > 3)
 		return NULL;
-	}
 
 	if (rb_per_cpu_empty(cpu_buffer))
 		return NULL;
@@ -4079,10 +4073,8 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	}
 
 	event = rb_iter_head_event(iter);
-	if (!event) {
-		failed = true;
+	if (!event)
 		goto again;
-	}
 
 	switch (event->type_len) {
 	case RINGBUF_TYPE_PADDING:
@@ -4117,7 +4109,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 		return event;
 
 	default:
-		BUG();
+		RB_WARN_ON(cpu_buffer, 1);
 	}
 
 	return NULL;
