Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4B6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0AF22CA1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbgFTBYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbgFTBYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:24:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC8522CA1;
        Sat, 20 Jun 2020 01:24:29 +0000 (UTC)
Date:   Fri, 19 Jun 2020 21:24:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Tracing fixes for 5.8-rc1
Message-ID: <20200619212427.60abc603@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

A few fixes and small cleanups for tracing:

 - Have recordmcount work with > 64K sections (to support LTO)
 - kprobe RCU fixes
 - Correct a kprobe critical section with missing mutex
 - Remove redundant arch_disarm_kprobe() call
 - Fix lockup when kretprobe triggers within kprobe_flush_task()
 - Fix memory leak in fetch_op_data operations
 - Fix sleep in atomic in ftrace trace array sample code
 - Free up memory on failure in sample trace array code
 - Fix incorrect reporting of function_graph fields in format file
 - Fix quote within quote parsing in bootconfig
 - Fix return value of bootconfig tool
 - Add testcases for bootconfig tool
 - Fix maybe uninitialized warning in ftrace pid file code
 - Remove unused variable in tracing_iter_reset()
 - Fix some typos


Please pull the latest trace-v5.8-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.8-rc1

Tag SHA1: 51ce53ae395e2df3e879e63985e4c9a3b989c8f5
Head SHA1: 026bb845b0fff6dec91fe24511dad7d3067dc3ed


Jiri Olsa (1):
      kretprobe: Prevent triggering kretprobe from within kprobe_flush_task

Kaitao Cheng (1):
      ftrace: Fix maybe-uninitialized compiler warning

Kefeng Wang (2):
      sample-trace-array: Fix sleeping function called from invalid context
      sample-trace-array: Remove trace_array 'sample-instance'

Masami Hiramatsu (8):
      kprobes: Suppress the suspicious RCU warning on kprobes
      kprobes: Use non RCU traversal APIs on kprobe_tables if possible
      kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
      kprobes: Remove redundant arch_disarm_kprobe() call
      proc/bootconfig: Fix to use correct quotes for value
      tools/bootconfig: Fix to use correct quotes for value
      tools/bootconfig: Fix to return 0 if succeeded to show the bootconfig
      tools/bootconfig: Add testcase for show-command and quotes test

Sami Tolvanen (1):
      recordmcount: support >64k sections

Steven Rostedt (VMware) (1):
      tracing: Make ftrace packed events have align of 1

Vamshi K Sthambamkadi (1):
      tracing/probe: Fix memleak in fetch_op_data operations

Wei Yang (1):
      trace: Fix typo in allocate_ftrace_ops()'s comment

YangHui (1):
      tracing: Remove unused event variable in tracing_iter_reset

----
 arch/x86/kernel/kprobes/core.c      | 16 ++----
 fs/proc/bootconfig.c                | 15 ++++--
 include/linux/kprobes.h             |  4 ++
 kernel/kprobes.c                    | 61 ++++++++++++++++++-----
 kernel/trace/ftrace.c               | 12 ++++-
 kernel/trace/trace.c                |  3 +-
 kernel/trace/trace.h                |  3 ++
 kernel/trace/trace_entries.h        | 14 +++---
 kernel/trace/trace_export.c         | 16 ++++++
 kernel/trace/trace_functions.c      |  2 +-
 kernel/trace/trace_probe.c          |  4 +-
 samples/ftrace/sample-trace-array.c | 24 ++++++---
 scripts/recordmcount.h              | 98 ++++++++++++++++++++++++++++++++++---
 tools/bootconfig/main.c             | 24 +++++----
 tools/bootconfig/test-bootconfig.sh | 10 ++++
 15 files changed, 239 insertions(+), 67 deletions(-)
---------------------------
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 3bafe1bd4dc7..8a5ec10e95dc 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -753,16 +753,11 @@ asm(
 NOKPROBE_SYMBOL(kretprobe_trampoline);
 STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 
-static struct kprobe kretprobe_kprobe = {
-	.addr = (void *)kretprobe_trampoline,
-};
-
 /*
  * Called from kretprobe_trampoline
  */
 __used __visible void *trampoline_handler(struct pt_regs *regs)
 {
-	struct kprobe_ctlblk *kcb;
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
 	struct hlist_node *tmp;
@@ -772,16 +767,12 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 	void *frame_pointer;
 	bool skipped = false;
 
-	preempt_disable();
-
 	/*
 	 * Set a dummy kprobe for avoiding kretprobe recursion.
 	 * Since kretprobe never run in kprobe handler, kprobe must not
 	 * be running at this point.
 	 */
-	kcb = get_kprobe_ctlblk();
-	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
-	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+	kprobe_busy_begin();
 
 	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
@@ -857,7 +848,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 			__this_cpu_write(current_kprobe, &ri->rp->kp);
 			ri->ret_addr = correct_ret_addr;
 			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, &kretprobe_kprobe);
+			__this_cpu_write(current_kprobe, &kprobe_busy);
 		}
 
 		recycle_rp_inst(ri, &empty_rp);
@@ -873,8 +864,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 
 	kretprobe_hash_unlock(current, &flags);
 
-	__this_cpu_write(current_kprobe, NULL);
-	preempt_enable();
+	kprobe_busy_end();
 
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 9955d75c0585..ad31ec4ad627 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -26,8 +26,9 @@ static int boot_config_proc_show(struct seq_file *m, void *v)
 static int __init copy_xbc_key_value_list(char *dst, size_t size)
 {
 	struct xbc_node *leaf, *vnode;
-	const char *val;
 	char *key, *end = dst + size;
+	const char *val;
+	char q;
 	int ret = 0;
 
 	key = kzalloc(XBC_KEYLEN_MAX, GFP_KERNEL);
@@ -41,16 +42,20 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 			break;
 		dst += ret;
 		vnode = xbc_node_get_child(leaf);
-		if (vnode && xbc_node_is_array(vnode)) {
+		if (vnode) {
 			xbc_array_for_each_value(vnode, val) {
-				ret = snprintf(dst, rest(dst, end), "\"%s\"%s",
-					val, vnode->next ? ", " : "\n");
+				if (strchr(val, '"'))
+					q = '\'';
+				else
+					q = '"';
+				ret = snprintf(dst, rest(dst, end), "%c%s%c%s",
+					q, val, q, vnode->next ? ", " : "\n");
 				if (ret < 0)
 					goto out;
 				dst += ret;
 			}
 		} else {
-			ret = snprintf(dst, rest(dst, end), "\"%s\"\n", val);
+			ret = snprintf(dst, rest(dst, end), "\"\"\n");
 			if (ret < 0)
 				break;
 			dst += ret;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 594265bfd390..05ed663e6c7b 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -350,6 +350,10 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
 	return this_cpu_ptr(&kprobe_ctlblk);
 }
 
+extern struct kprobe kprobe_busy;
+void kprobe_busy_begin(void);
+void kprobe_busy_end(void);
+
 kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 50cd84f53df0..4a904cc56d68 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -46,6 +46,11 @@
 
 
 static int kprobes_initialized;
+/* kprobe_table can be accessed by
+ * - Normal hlist traversal and RCU add/del under kprobe_mutex is held.
+ * Or
+ * - RCU hlist traversal under disabling preempt (breakpoint handlers)
+ */
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
@@ -326,7 +331,8 @@ struct kprobe *get_kprobe(void *addr)
 	struct kprobe *p;
 
 	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
-	hlist_for_each_entry_rcu(p, head, hlist) {
+	hlist_for_each_entry_rcu(p, head, hlist,
+				 lockdep_is_held(&kprobe_mutex)) {
 		if (p->addr == addr)
 			return p;
 	}
@@ -586,11 +592,12 @@ static void kprobe_optimizer(struct work_struct *work)
 	mutex_unlock(&module_mutex);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
-	mutex_unlock(&kprobe_mutex);
 
 	/* Step 5: Kick optimizer again if needed */
 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
 		kick_kprobe_optimizer();
+
+	mutex_unlock(&kprobe_mutex);
 }
 
 /* Wait for completing optimization and unoptimization */
@@ -668,8 +675,6 @@ static void force_unoptimize_kprobe(struct optimized_kprobe *op)
 	lockdep_assert_cpus_held();
 	arch_unoptimize_kprobe(op);
 	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-	if (kprobe_disabled(&op->kp))
-		arch_disarm_kprobe(&op->kp);
 }
 
 /* Unoptimize a kprobe if p is optimized */
@@ -849,7 +854,7 @@ static void optimize_all_kprobes(void)
 	kprobes_allow_optimization = true;
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry_rcu(p, head, hlist)
+		hlist_for_each_entry(p, head, hlist)
 			if (!kprobe_disabled(p))
 				optimize_kprobe(p);
 	}
@@ -876,7 +881,7 @@ static void unoptimize_all_kprobes(void)
 	kprobes_allow_optimization = false;
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry_rcu(p, head, hlist) {
+		hlist_for_each_entry(p, head, hlist) {
 			if (!kprobe_disabled(p))
 				unoptimize_kprobe(p, false);
 		}
@@ -1236,6 +1241,26 @@ __releases(hlist_lock)
 }
 NOKPROBE_SYMBOL(kretprobe_table_unlock);
 
+struct kprobe kprobe_busy = {
+	.addr = (void *) get_kprobe,
+};
+
+void kprobe_busy_begin(void)
+{
+	struct kprobe_ctlblk *kcb;
+
+	preempt_disable();
+	__this_cpu_write(current_kprobe, &kprobe_busy);
+	kcb = get_kprobe_ctlblk();
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+}
+
+void kprobe_busy_end(void)
+{
+	__this_cpu_write(current_kprobe, NULL);
+	preempt_enable();
+}
+
 /*
  * This function is called from finish_task_switch when task tk becomes dead,
  * so that we can recycle any function-return probe instances associated
@@ -1253,6 +1278,8 @@ void kprobe_flush_task(struct task_struct *tk)
 		/* Early boot.  kretprobe_table_locks not yet initialized. */
 		return;
 
+	kprobe_busy_begin();
+
 	INIT_HLIST_HEAD(&empty_rp);
 	hash = hash_ptr(tk, KPROBE_HASH_BITS);
 	head = &kretprobe_inst_table[hash];
@@ -1266,6 +1293,8 @@ void kprobe_flush_task(struct task_struct *tk)
 		hlist_del(&ri->hlist);
 		kfree(ri);
 	}
+
+	kprobe_busy_end();
 }
 NOKPROBE_SYMBOL(kprobe_flush_task);
 
@@ -1499,12 +1528,14 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
 {
 	struct kprobe *ap, *list_p;
 
+	lockdep_assert_held(&kprobe_mutex);
+
 	ap = get_kprobe(p->addr);
 	if (unlikely(!ap))
 		return NULL;
 
 	if (p != ap) {
-		list_for_each_entry_rcu(list_p, &ap->list, list)
+		list_for_each_entry(list_p, &ap->list, list)
 			if (list_p == p)
 			/* kprobe p is a valid probe */
 				goto valid;
@@ -1669,7 +1700,9 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
 {
 	struct kprobe *kp;
 
-	list_for_each_entry_rcu(kp, &ap->list, list)
+	lockdep_assert_held(&kprobe_mutex);
+
+	list_for_each_entry(kp, &ap->list, list)
 		if (!kprobe_disabled(kp))
 			/*
 			 * There is an active probe on the list.
@@ -1748,7 +1781,7 @@ static int __unregister_kprobe_top(struct kprobe *p)
 	else {
 		/* If disabling probe has special handlers, update aggrprobe */
 		if (p->post_handler && !kprobe_gone(p)) {
-			list_for_each_entry_rcu(list_p, &ap->list, list) {
+			list_for_each_entry(list_p, &ap->list, list) {
 				if ((list_p != p) && (list_p->post_handler))
 					goto noclean;
 			}
@@ -2062,13 +2095,15 @@ static void kill_kprobe(struct kprobe *p)
 {
 	struct kprobe *kp;
 
+	lockdep_assert_held(&kprobe_mutex);
+
 	p->flags |= KPROBE_FLAG_GONE;
 	if (kprobe_aggrprobe(p)) {
 		/*
 		 * If this is an aggr_kprobe, we have to list all the
 		 * chained probes and mark them GONE.
 		 */
-		list_for_each_entry_rcu(kp, &p->list, list)
+		list_for_each_entry(kp, &p->list, list)
 			kp->flags |= KPROBE_FLAG_GONE;
 		p->post_handler = NULL;
 		kill_optimized_kprobe(p);
@@ -2312,7 +2347,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry_rcu(p, head, hlist)
+		hlist_for_each_entry(p, head, hlist)
 			if (within_module_init((unsigned long)p->addr, mod) ||
 			    (checkcore &&
 			     within_module_core((unsigned long)p->addr, mod))) {
@@ -2550,7 +2585,7 @@ static int arm_all_kprobes(void)
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
 		/* Arm all kprobes on a best-effort basis */
-		hlist_for_each_entry_rcu(p, head, hlist) {
+		hlist_for_each_entry(p, head, hlist) {
 			if (!kprobe_disabled(p)) {
 				err = arm_kprobe(p);
 				if (err)  {
@@ -2593,7 +2628,7 @@ static int disarm_all_kprobes(void)
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
 		/* Disarm all kprobes on a best-effort basis */
-		hlist_for_each_entry_rcu(p, head, hlist) {
+		hlist_for_each_entry(p, head, hlist) {
 			if (!arch_trampoline_kprobe(p) && !kprobe_disabled(p)) {
 				err = disarm_kprobe(p, false);
 				if (err) {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c163c3531faf..1903b80db6eb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2260,7 +2260,7 @@ ftrace_find_tramp_ops_next(struct dyn_ftrace *rec,
 
 		if (hash_contains_ip(ip, op->func_hash))
 			return op;
-	} 
+	}
 
 	return NULL;
 }
@@ -3599,7 +3599,7 @@ static int t_show(struct seq_file *m, void *v)
 			if (direct)
 				seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
 		}
-	}	
+	}
 
 	seq_putc(m, '\n');
 
@@ -7151,6 +7151,10 @@ static int pid_open(struct inode *inode, struct file *file, int type)
 	case TRACE_NO_PIDS:
 		seq_ops = &ftrace_no_pid_sops;
 		break;
+	default:
+		trace_array_put(tr);
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	ret = seq_open(file, seq_ops);
@@ -7229,6 +7233,10 @@ pid_write(struct file *filp, const char __user *ubuf,
 		other_pids = rcu_dereference_protected(tr->function_pids,
 					     lockdep_is_held(&ftrace_lock));
 		break;
+	default:
+		ret = -EINVAL;
+		WARN_ON_ONCE(1);
+		goto out;
 	}
 
 	ret = trace_pid_write(filtered_pids, &pid_list, ubuf, cnt);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ec44b0e2a19c..bb62269724d5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3570,7 +3570,6 @@ static void *s_next(struct seq_file *m, void *v, loff_t *pos)
 
 void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 {
-	struct ring_buffer_event *event;
 	struct ring_buffer_iter *buf_iter;
 	unsigned long entries = 0;
 	u64 ts;
@@ -3588,7 +3587,7 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 	 * that a reset never took place on a cpu. This is evident
 	 * by the timestamp being before the start of the buffer.
 	 */
-	while ((event = ring_buffer_iter_peek(buf_iter, &ts))) {
+	while (ring_buffer_iter_peek(buf_iter, &ts)) {
 		if (ts >= iter->array_buffer->time_start)
 			break;
 		entries++;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index def769df5bf1..13db4000af3f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -61,6 +61,9 @@ enum trace_type {
 #undef __field_desc
 #define __field_desc(type, container, item)
 
+#undef __field_packed
+#define __field_packed(type, container, item)
+
 #undef __array
 #define __array(type, item, size)	type	item[size];
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index a523da0dae0a..18c4a58aff79 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -78,8 +78,8 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
-		__field_desc(	unsigned long,	graph_ent,	func		)
-		__field_desc(	int,		graph_ent,	depth		)
+		__field_packed(	unsigned long,	graph_ent,	func		)
+		__field_packed(	int,		graph_ent,	depth		)
 	),
 
 	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
@@ -92,11 +92,11 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
-		__field_desc(	unsigned long,	ret,		func	)
-		__field_desc(	unsigned long,	ret,		overrun	)
-		__field_desc(	unsigned long long, ret,	calltime)
-		__field_desc(	unsigned long long, ret,	rettime	)
-		__field_desc(	int,		ret,		depth	)
+		__field_packed(	unsigned long,	ret,		func	)
+		__field_packed(	unsigned long,	ret,		overrun	)
+		__field_packed(	unsigned long long, ret,	calltime)
+		__field_packed(	unsigned long long, ret,	rettime	)
+		__field_packed(	int,		ret,		depth	)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 77ce5a3b6773..70d3d0a09053 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -45,6 +45,9 @@ static int ftrace_event_register(struct trace_event_call *call,
 #undef __field_desc
 #define __field_desc(type, container, item)		type item;
 
+#undef __field_packed
+#define __field_packed(type, container, item)		type item;
+
 #undef __array
 #define __array(type, item, size)			type item[size];
 
@@ -85,6 +88,13 @@ static void __always_unused ____ftrace_check_##name(void)		\
 	.size = sizeof(_type), .align = __alignof__(_type),		\
 	is_signed_type(_type), .filter_type = _filter_type },
 
+
+#undef __field_ext_packed
+#define __field_ext_packed(_type, _item, _filter_type) {	\
+	.type = #_type, .name = #_item,				\
+	.size = sizeof(_type), .align = 1,			\
+	is_signed_type(_type), .filter_type = _filter_type },
+
 #undef __field
 #define __field(_type, _item) __field_ext(_type, _item, FILTER_OTHER)
 
@@ -94,6 +104,9 @@ static void __always_unused ____ftrace_check_##name(void)		\
 #undef __field_desc
 #define __field_desc(_type, _container, _item) __field_ext(_type, _item, FILTER_OTHER)
 
+#undef __field_packed
+#define __field_packed(_type, _container, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
+
 #undef __array
 #define __array(_type, _item, _len) {					\
 	.type = #_type"["__stringify(_len)"]", .name = #_item,		\
@@ -129,6 +142,9 @@ static struct trace_event_fields ftrace_event_fields_##name[] = {	\
 #undef __field_desc
 #define __field_desc(type, container, item)
 
+#undef __field_packed
+#define __field_packed(type, container, item)
+
 #undef __array
 #define __array(type, item, len)
 
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 8a4c8d5c2c98..dd4dff71d89a 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -42,7 +42,7 @@ static int allocate_ftrace_ops(struct trace_array *tr)
 	if (!ops)
 		return -ENOMEM;
 
-	/* Currently only the non stack verision is supported */
+	/* Currently only the non stack version is supported */
 	ops->func = function_trace_call;
 	ops->flags = FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_PID;
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index b8a928e925c7..d2867ccc6aca 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -639,8 +639,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			ret = -EINVAL;
 			goto fail;
 		}
-		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM) ||
-		     parg->count) {
+		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
+		     code->op == FETCH_OP_DATA) || parg->count) {
 			/*
 			 * IMM, DATA and COMM is pointing actual address, those
 			 * must be kept, and if parg->count != 0, this is an
diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index d523450d73eb..6aba02a31c96 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -6,6 +6,7 @@
 #include <linux/timer.h>
 #include <linux/err.h>
 #include <linux/jiffies.h>
+#include <linux/workqueue.h>
 
 /*
  * Any file that uses trace points, must include the header.
@@ -20,6 +21,16 @@ struct trace_array *tr;
 static void mytimer_handler(struct timer_list *unused);
 static struct task_struct *simple_tsk;
 
+static void trace_work_fn(struct work_struct *work)
+{
+	/*
+	 * Disable tracing for event "sample_event".
+	 */
+	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event",
+			false);
+}
+static DECLARE_WORK(trace_work, trace_work_fn);
+
 /*
  * mytimer: Timer setup to disable tracing for event "sample_event". This
  * timer is only for the purposes of the sample module to demonstrate access of
@@ -29,11 +40,7 @@ static DEFINE_TIMER(mytimer, mytimer_handler);
 
 static void mytimer_handler(struct timer_list *unused)
 {
-	/*
-	 * Disable tracing for event "sample_event".
-	 */
-	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event",
-			false);
+	schedule_work(&trace_work);
 }
 
 static void simple_thread_func(int count)
@@ -76,6 +83,7 @@ static int simple_thread(void *arg)
 		simple_thread_func(count++);
 
 	del_timer(&mytimer);
+	cancel_work_sync(&trace_work);
 
 	/*
 	 * trace_array_put() decrements the reference counter associated with
@@ -107,8 +115,12 @@ static int __init sample_trace_array_init(void)
 	trace_printk_init_buffers();
 
 	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
-	if (IS_ERR(simple_tsk))
+	if (IS_ERR(simple_tsk)) {
+		trace_array_put(tr);
+		trace_array_destroy(tr);
 		return -1;
+	}
+
 	return 0;
 }
 
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 74eab03e31d4..f9b19524da11 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -29,6 +29,11 @@
 #undef has_rel_mcount
 #undef tot_relsize
 #undef get_mcountsym
+#undef find_symtab
+#undef get_shnum
+#undef set_shnum
+#undef get_shstrndx
+#undef get_symindex
 #undef get_sym_str_and_relp
 #undef do_func
 #undef Elf_Addr
@@ -58,6 +63,11 @@
 # define __has_rel_mcount	__has64_rel_mcount
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
+# define find_symtab		find_symtab64
+# define get_shnum		get_shnum64
+# define set_shnum		set_shnum64
+# define get_shstrndx		get_shstrndx64
+# define get_symindex		get_symindex64
 # define get_sym_str_and_relp	get_sym_str_and_relp_64
 # define do_func		do64
 # define get_mcountsym		get_mcountsym_64
@@ -91,6 +101,11 @@
 # define __has_rel_mcount	__has32_rel_mcount
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
+# define find_symtab		find_symtab32
+# define get_shnum		get_shnum32
+# define set_shnum		set_shnum32
+# define get_shstrndx		get_shstrndx32
+# define get_symindex		get_symindex32
 # define get_sym_str_and_relp	get_sym_str_and_relp_32
 # define do_func		do32
 # define get_mcountsym		get_mcountsym_32
@@ -173,6 +188,67 @@ static int MIPS_is_fake_mcount(Elf_Rel const *rp)
 	return is_fake;
 }
 
+static unsigned int get_symindex(Elf_Sym const *sym, Elf32_Word const *symtab,
+				 Elf32_Word const *symtab_shndx)
+{
+	unsigned long offset;
+	int index;
+
+	if (sym->st_shndx != SHN_XINDEX)
+		return w2(sym->st_shndx);
+
+	offset = (unsigned long)sym - (unsigned long)symtab;
+	index = offset / sizeof(*sym);
+
+	return w(symtab_shndx[index]);
+}
+
+static unsigned int get_shnum(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
+{
+	if (shdr0 && !ehdr->e_shnum)
+		return w(shdr0->sh_size);
+
+	return w2(ehdr->e_shnum);
+}
+
+static void set_shnum(Elf_Ehdr *ehdr, Elf_Shdr *shdr0, unsigned int new_shnum)
+{
+	if (new_shnum >= SHN_LORESERVE) {
+		ehdr->e_shnum = 0;
+		shdr0->sh_size = w(new_shnum);
+	} else
+		ehdr->e_shnum = w2(new_shnum);
+}
+
+static int get_shstrndx(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
+{
+	if (ehdr->e_shstrndx != SHN_XINDEX)
+		return w2(ehdr->e_shstrndx);
+
+	return w(shdr0->sh_link);
+}
+
+static void find_symtab(Elf_Ehdr *const ehdr, Elf_Shdr const *shdr0,
+			unsigned const nhdr, Elf32_Word **symtab,
+			Elf32_Word **symtab_shndx)
+{
+	Elf_Shdr const *relhdr;
+	unsigned k;
+
+	*symtab = NULL;
+	*symtab_shndx = NULL;
+
+	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
+		if (relhdr->sh_type == SHT_SYMTAB)
+			*symtab = (void *)ehdr + relhdr->sh_offset;
+		else if (relhdr->sh_type == SHT_SYMTAB_SHNDX)
+			*symtab_shndx = (void *)ehdr + relhdr->sh_offset;
+
+		if (*symtab && *symtab_shndx)
+			break;
+	}
+}
+
 /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
 static int append_func(Elf_Ehdr *const ehdr,
 			Elf_Shdr *const shstr,
@@ -188,10 +264,12 @@ static int append_func(Elf_Ehdr *const ehdr,
 	char const *mc_name = (sizeof(Elf_Rela) == rel_entsize)
 		? ".rela__mcount_loc"
 		:  ".rel__mcount_loc";
-	unsigned const old_shnum = w2(ehdr->e_shnum);
 	uint_t const old_shoff = _w(ehdr->e_shoff);
 	uint_t const old_shstr_sh_size   = _w(shstr->sh_size);
 	uint_t const old_shstr_sh_offset = _w(shstr->sh_offset);
+	Elf_Shdr *const shdr0 = (Elf_Shdr *)(old_shoff + (void *)ehdr);
+	unsigned int const old_shnum = get_shnum(ehdr, shdr0);
+	unsigned int const new_shnum = 2 + old_shnum; /* {.rel,}__mcount_loc */
 	uint_t t = 1 + strlen(mc_name) + _w(shstr->sh_size);
 	uint_t new_e_shoff;
 
@@ -201,6 +279,8 @@ static int append_func(Elf_Ehdr *const ehdr,
 	t += (_align & -t);  /* word-byte align */
 	new_e_shoff = t;
 
+	set_shnum(ehdr, shdr0, new_shnum);
+
 	/* body for new shstrtab */
 	if (ulseek(sb.st_size, SEEK_SET) < 0)
 		return -1;
@@ -255,7 +335,6 @@ static int append_func(Elf_Ehdr *const ehdr,
 		return -1;
 
 	ehdr->e_shoff = _w(new_e_shoff);
-	ehdr->e_shnum = w2(2 + w2(ehdr->e_shnum));  /* {.rel,}__mcount_loc */
 	if (ulseek(0, SEEK_SET) < 0)
 		return -1;
 	if (uwrite(ehdr, sizeof(*ehdr)) < 0)
@@ -434,6 +513,8 @@ static int find_secsym_ndx(unsigned const txtndx,
 				uint_t *const recvalp,
 				unsigned int *sym_index,
 				Elf_Shdr const *const symhdr,
+				Elf32_Word const *symtab,
+				Elf32_Word const *symtab_shndx,
 				Elf_Ehdr const *const ehdr)
 {
 	Elf_Sym const *const sym0 = (Elf_Sym const *)(_w(symhdr->sh_offset)
@@ -445,7 +526,7 @@ static int find_secsym_ndx(unsigned const txtndx,
 	for (symp = sym0, t = nsym; t; --t, ++symp) {
 		unsigned int const st_bind = ELF_ST_BIND(symp->st_info);
 
-		if (txtndx == w2(symp->st_shndx)
+		if (txtndx == get_symindex(symp, symtab, symtab_shndx)
 			/* avoid STB_WEAK */
 		    && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
 			/* function symbols on ARM have quirks, avoid them */
@@ -516,21 +597,23 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 	return totrelsz;
 }
 
-
 /* Overall supervision for Elf32 ET_REL file. */
 static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 		   unsigned const reltype)
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	unsigned const nhdr = w2(ehdr->e_shnum);
-	Elf_Shdr *const shstr = &shdr0[w2(ehdr->e_shstrndx)];
+	unsigned const nhdr = get_shnum(ehdr, shdr0);
+	Elf_Shdr *const shstr = &shdr0[get_shstrndx(ehdr, shdr0)];
 	char const *const shstrtab = (char const *)(_w(shstr->sh_offset)
 		+ (void *)ehdr);
 
 	Elf_Shdr const *relhdr;
 	unsigned k;
 
+	Elf32_Word *symtab;
+	Elf32_Word *symtab_shndx;
+
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
 	unsigned       totrelsz;
 
@@ -561,6 +644,8 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 		return -1;
 	}
 
+	find_symtab(ehdr, shdr0, nhdr, &symtab, &symtab_shndx);
+
 	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
 		char const *const txtname = has_rel_mcount(relhdr, shdr0,
 			shstrtab, fname);
@@ -577,6 +662,7 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 			result = find_secsym_ndx(w(relhdr->sh_info), txtname,
 						&recval, &recsym,
 						&shdr0[symsec_sh_link],
+						symtab, symtab_shndx,
 						ehdr);
 			if (result)
 				goto out;
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 0efaf45f7367..e0878f5f74b1 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -14,13 +14,18 @@
 #include <linux/kernel.h>
 #include <linux/bootconfig.h>
 
-static int xbc_show_array(struct xbc_node *node)
+static int xbc_show_value(struct xbc_node *node)
 {
 	const char *val;
+	char q;
 	int i = 0;
 
 	xbc_array_for_each_value(node, val) {
-		printf("\"%s\"%s", val, node->next ? ", " : ";\n");
+		if (strchr(val, '"'))
+			q = '\'';
+		else
+			q = '"';
+		printf("%c%s%c%s", q, val, q, node->next ? ", " : ";\n");
 		i++;
 	}
 	return i;
@@ -48,10 +53,7 @@ static void xbc_show_compact_tree(void)
 			continue;
 		} else if (cnode && xbc_node_is_value(cnode)) {
 			printf("%s = ", xbc_node_get_data(node));
-			if (cnode->next)
-				xbc_show_array(cnode);
-			else
-				printf("\"%s\";\n", xbc_node_get_data(cnode));
+			xbc_show_value(cnode);
 		} else {
 			printf("%s;\n", xbc_node_get_data(node));
 		}
@@ -205,11 +207,13 @@ int show_xbc(const char *path)
 	}
 
 	ret = load_xbc_from_initrd(fd, &buf);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_err("Failed to load a boot config from initrd: %d\n", ret);
-	else
-		xbc_show_compact_tree();
-
+		goto out;
+	}
+	xbc_show_compact_tree();
+	ret = 0;
+out:
 	close(fd);
 	free(buf);
 
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index eff16b77d5eb..3c2ab9e75730 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -55,6 +55,9 @@ echo "Apply command test"
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 new_size=$(stat -c %s $INITRD)
 
+echo "Show command test"
+xpass $BOOTCONF $INITRD
+
 echo "File size check"
 xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 9 + 12)
 
@@ -114,6 +117,13 @@ xpass grep -q "bar" $OUTFILE
 xpass grep -q "baz" $OUTFILE
 xpass grep -q "qux" $OUTFILE
 
+echo "Double/single quotes test"
+echo "key = '\"string\"';" > $TEMPCONF
+$BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $TEMPCONF
+cat $TEMPCONF
+xpass grep \'\"string\"\' $TEMPCONF
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD
