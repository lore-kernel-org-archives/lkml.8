Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7768DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A56208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H/gRFfqw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QfC9Lv3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbgGaJ1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:27:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgGaJXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:13 -0400
Date:   Fri, 31 Jul 2020 09:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aCxYkwRjXc61L2Bu6X9PdPlYFvn8tjGJWQrPBJVaQkg=;
        b=H/gRFfqwXcFzqBT6gyFyWwQl4hG6vnqWwzS18pdBalL7Rar46lNBOkNdFu3jdxQrp+hAOy
        K9wAoE6Xmum1BUM2VUb3nKh2TEB4OJhSrJmqkKTZhNRtOyTDb4QOUV3CdQS34yevlQFvIK
        la094K2aEQHsB5n9DmSssVNAvkNe+mbdwg/mBMAif+LYGQaJg93rhULe5rGTR5+8UdjeLq
        hQj32b4IVtD2jMbPWGFxEeiR98eUS7rwCqqU4kB6SWmcNZ92kOSLPa/ibCIGajxBs0kbQD
        Lo/Mk5LQkTYdOeqKRi9dX9dGt7Su6YSg6wZ3ZHApynueMh4xKKjfd8eGzCrOVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aCxYkwRjXc61L2Bu6X9PdPlYFvn8tjGJWQrPBJVaQkg=;
        b=QfC9Lv3Qh0il1x2rXZdCms1ihL3JESSaHKKVr3Hssexr1l8IUD2asn/7yAeJbOi63CFPlo
        8GSCoBakECstJ4Ag==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Add a test to measure performance of
 read-side synchronization
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739001.4006.10636431557675514446.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     653ed64b01dc5989f8f579d0038e987476c2c023
Gitweb:        https://git.kernel.org/tip/653ed64b01dc5989f8f579d0038e987476c2c023
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Mon, 25 May 2020 00:36:48 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

refperf: Add a test to measure performance of read-side synchronization

Add a test for comparing the performance of RCU with various read-side
synchronization mechanisms. The test has proved useful for collecting
data and performing these comparisons.

Currently RCU, SRCU, reader-writer lock, reader-writer semaphore and
reference counting can be measured using refperf.perf_type parameter.
Each invocation of the test runs measures performance of a specific
mechanism.

The maximum number of CPUs to concurrently run readers on is chosen by
the test itself and is 75% of the total number of CPUs. So if you had 24
CPUs, the test runs with a maximum of 18 parallel readers.

A number of experiments are conducted, and in each experiment, the
number of readers is increased by 1, upto the 75% of CPUs mark. During
each experiment, all readers execute an empty loop with refperf.loops
iterations and time the total loop duration. This is then averaged.

Example output:
Parameters "refperf.perf_type=srcu refperf.loops=2000000" looks like:

[    3.347133] srcu-ref-perf:
[    3.347133] Threads  Time(ns)
[    3.347133] 1        36
[    3.347133] 2        34
[    3.347133] 3        34
[    3.347133] 4        34
[    3.347133] 5        33
[    3.347133] 6        33
[    3.347133] 7        33
[    3.347133] 8        33
[    3.347133] 9        33
[    3.347133] 10       33
[    3.347133] 11       33
[    3.347133] 12       33
[    3.347133] 13       33
[    3.347133] 14       33
[    3.347133] 15       32
[    3.347133] 16       33
[    3.347133] 17       33
[    3.347133] 18       34

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug |  19 +-
 kernel/rcu/Makefile      |   1 +-
 kernel/rcu/refperf.c     | 558 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 578 insertions(+)
 create mode 100644 kernel/rcu/refperf.c

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 452feae..858765b 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -61,6 +61,25 @@ config RCU_TORTURE_TEST
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
 
+config RCU_REF_PERF_TEST
+	tristate "Performance tests for read-side synchronization (RCU and others)"
+	depends on DEBUG_KERNEL
+	select TORTURE_TEST
+	select SRCU
+	select TASKS_RCU
+	select TASKS_RUDE_RCU
+	select TASKS_TRACE_RCU
+	default n
+	help
+	  This option provides a kernel module that runs performance tests
+	  useful comparing RCU with various read-side synchronization mechanisms.
+	  The kernel module may be built after the fact on the running kernel to be
+	  tested, if desired.
+
+	  Say Y here if you want these performance tests built into the kernel.
+	  Say M if you want to build it as a module instead.
+	  Say N if you are unsure.
+
 config RCU_CPU_STALL_TIMEOUT
 	int "RCU CPU stall timeout in seconds"
 	depends on RCU_STALL_COMMON
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index f91f2c2..ba7d826 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
+obj-$(CONFIG_RCU_REF_PERF_TEST) += refperf.o
 obj-$(CONFIG_TREE_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
 obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
new file mode 100644
index 0000000..6116153
--- /dev/null
+++ b/kernel/rcu/refperf.c
@@ -0,0 +1,558 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Performance test comparing RCU vs other mechanisms
+// for acquiring references on objects.
+//
+// Copyright (C) Google, 2020.
+//
+// Author: Joel Fernandes <joel@joelfernandes.org>
+
+#define pr_fmt(fmt) fmt
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kthread.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/notifier.h>
+#include <linux/percpu.h>
+#include <linux/rcupdate.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/stat.h>
+#include <linux/srcu.h>
+#include <linux/slab.h>
+#include <linux/torture.h>
+#include <linux/types.h>
+
+#include "rcu.h"
+
+#define PERF_FLAG "-ref-perf: "
+
+#define PERFOUT(s, x...) \
+	pr_alert("%s" PERF_FLAG s, perf_type, ## x)
+
+#define VERBOSE_PERFOUT(s, x...) \
+	do { if (verbose) pr_alert("%s" PERF_FLAG s, perf_type, ## x); } while (0)
+
+#define VERBOSE_PERFOUT_ERRSTRING(s, x...) \
+	do { if (verbose) pr_alert("%s" PERF_FLAG "!!! " s, perf_type, ## x); } while (0)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
+
+static char *perf_type = "rcu";
+module_param(perf_type, charp, 0444);
+MODULE_PARM_DESC(perf_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
+
+torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
+
+// Number of loops per experiment, all readers execute an operation concurrently
+torture_param(long, loops, 10000000, "Number of loops per experiment.");
+
+#ifdef MODULE
+# define REFPERF_SHUTDOWN 0
+#else
+# define REFPERF_SHUTDOWN 1
+#endif
+
+torture_param(bool, shutdown, REFPERF_SHUTDOWN,
+	      "Shutdown at end of performance tests.");
+
+struct reader_task {
+	struct task_struct *task;
+	atomic_t start;
+	wait_queue_head_t wq;
+	u64 last_duration_ns;
+
+	// The average latency When 1..<this reader> are concurrently
+	// running an experiment. For example, if this reader_task is
+	// of index 5 in the reader_tasks array, then result is for
+	// 6 cores.
+	u64 result_avg;
+};
+
+static struct task_struct *shutdown_task;
+static wait_queue_head_t shutdown_wq;
+
+static struct task_struct *main_task;
+static wait_queue_head_t main_wq;
+static int shutdown_start;
+
+static struct reader_task *reader_tasks;
+static int nreaders;
+
+// Number of readers that are part of the current experiment.
+static atomic_t nreaders_exp;
+
+// Use to wait for all threads to start.
+static atomic_t n_init;
+
+// Track which experiment is currently running.
+static int exp_idx;
+
+// Operations vector for selecting different types of tests.
+struct ref_perf_ops {
+	void (*init)(void);
+	void (*cleanup)(void);
+	int (*readlock)(void);
+	void (*readunlock)(int idx);
+	const char *name;
+};
+
+static struct ref_perf_ops *cur_ops;
+
+// Definitions for RCU ref perf testing.
+static int ref_rcu_read_lock(void) __acquires(RCU)
+{
+	rcu_read_lock();
+	return 0;
+}
+
+static void ref_rcu_read_unlock(int idx) __releases(RCU)
+{
+	rcu_read_unlock();
+}
+
+static void rcu_sync_perf_init(void)
+{
+}
+
+static struct ref_perf_ops rcu_ops = {
+	.init		= rcu_sync_perf_init,
+	.readlock	= ref_rcu_read_lock,
+	.readunlock	= ref_rcu_read_unlock,
+	.name		= "rcu"
+};
+
+
+// Definitions for SRCU ref perf testing.
+DEFINE_STATIC_SRCU(srcu_refctl_perf);
+static struct srcu_struct *srcu_ctlp = &srcu_refctl_perf;
+
+static int srcu_ref_perf_read_lock(void) __acquires(srcu_ctlp)
+{
+	return srcu_read_lock(srcu_ctlp);
+}
+
+static void srcu_ref_perf_read_unlock(int idx) __releases(srcu_ctlp)
+{
+	srcu_read_unlock(srcu_ctlp, idx);
+}
+
+static struct ref_perf_ops srcu_ops = {
+	.init		= rcu_sync_perf_init,
+	.readlock	= srcu_ref_perf_read_lock,
+	.readunlock	= srcu_ref_perf_read_unlock,
+	.name		= "srcu"
+};
+
+// Definitions for reference count
+static atomic_t refcnt;
+
+static int srcu_ref_perf_refcnt_lock(void)
+{
+	atomic_inc(&refcnt);
+	return 0;
+}
+
+static void srcu_ref_perf_refcnt_unlock(int idx) __releases(srcu_ctlp)
+{
+	atomic_dec(&refcnt);
+	srcu_read_unlock(srcu_ctlp, idx);
+}
+
+static struct ref_perf_ops refcnt_ops = {
+	.init		= rcu_sync_perf_init,
+	.readlock	= srcu_ref_perf_refcnt_lock,
+	.readunlock	= srcu_ref_perf_refcnt_unlock,
+	.name		= "refcnt"
+};
+
+// Definitions for rwlock
+static rwlock_t test_rwlock;
+
+static void ref_perf_rwlock_init(void)
+{
+	rwlock_init(&test_rwlock);
+}
+
+static int ref_perf_rwlock_lock(void)
+{
+	read_lock(&test_rwlock);
+	return 0;
+}
+
+static void ref_perf_rwlock_unlock(int idx)
+{
+	read_unlock(&test_rwlock);
+}
+
+static struct ref_perf_ops rwlock_ops = {
+	.init		= ref_perf_rwlock_init,
+	.readlock	= ref_perf_rwlock_lock,
+	.readunlock	= ref_perf_rwlock_unlock,
+	.name		= "rwlock"
+};
+
+// Definitions for rwsem
+static struct rw_semaphore test_rwsem;
+
+static void ref_perf_rwsem_init(void)
+{
+	init_rwsem(&test_rwsem);
+}
+
+static int ref_perf_rwsem_lock(void)
+{
+	down_read(&test_rwsem);
+	return 0;
+}
+
+static void ref_perf_rwsem_unlock(int idx)
+{
+	up_read(&test_rwsem);
+}
+
+static struct ref_perf_ops rwsem_ops = {
+	.init		= ref_perf_rwsem_init,
+	.readlock	= ref_perf_rwsem_lock,
+	.readunlock	= ref_perf_rwsem_unlock,
+	.name		= "rwsem"
+};
+
+// Reader kthread.  Repeatedly does empty RCU read-side
+// critical section, minimizing update-side interference.
+static int
+ref_perf_reader(void *arg)
+{
+	unsigned long flags;
+	long me = (long)arg;
+	struct reader_task *rt = &(reader_tasks[me]);
+	unsigned long spincnt;
+	int idx;
+	u64 start;
+	s64 duration;
+
+	VERBOSE_PERFOUT("ref_perf_reader %ld: task started", me);
+	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+	atomic_inc(&n_init);
+repeat:
+	VERBOSE_PERFOUT("ref_perf_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
+
+	// Wait for signal that this reader can start.
+	wait_event(rt->wq, (atomic_read(&nreaders_exp) && atomic_read(&rt->start)) ||
+			   torture_must_stop());
+
+	if (torture_must_stop())
+		goto end;
+
+	// Make sure that the CPU is affinitized appropriately during testing.
+	WARN_ON_ONCE(smp_processor_id() != me);
+
+	atomic_dec(&rt->start);
+
+	// To prevent noise, keep interrupts disabled. This also has the
+	// effect of preventing entries into slow path for rcu_read_unlock().
+	local_irq_save(flags);
+	start = ktime_get_mono_fast_ns();
+
+	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
+
+	for (spincnt = 0; spincnt < loops; spincnt++) {
+		idx = cur_ops->readlock();
+		cur_ops->readunlock(idx);
+	}
+
+	duration = ktime_get_mono_fast_ns() - start;
+	local_irq_restore(flags);
+
+	rt->last_duration_ns = WARN_ON_ONCE(duration < 0) ? 0 : duration;
+
+	atomic_dec(&nreaders_exp);
+
+	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d ended, (readers remaining=%d)",
+			me, exp_idx, atomic_read(&nreaders_exp));
+
+	if (!atomic_read(&nreaders_exp))
+		wake_up(&main_wq);
+
+	if (!torture_must_stop())
+		goto repeat;
+end:
+	torture_kthread_stopping("ref_perf_reader");
+	return 0;
+}
+
+void reset_readers(int n)
+{
+	int i;
+	struct reader_task *rt;
+
+	for (i = 0; i < n; i++) {
+		rt = &(reader_tasks[i]);
+
+		rt->last_duration_ns = 0;
+	}
+}
+
+// Print the results of each reader and return the sum of all their durations.
+u64 process_durations(int n)
+{
+	int i;
+	struct reader_task *rt;
+	char buf1[64];
+	char buf[512];
+	u64 sum = 0;
+
+	buf[0] = 0;
+	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
+		exp_idx);
+
+	for (i = 0; i <= n && !torture_must_stop(); i++) {
+		rt = &(reader_tasks[i]);
+		sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
+
+		if (i % 5 == 0)
+			strcat(buf, "\n");
+		strcat(buf, buf1);
+
+		sum += rt->last_duration_ns;
+	}
+	strcat(buf, "\n");
+
+	PERFOUT("%s\n", buf);
+
+	return sum;
+}
+
+// The main_func is the main orchestrator, it performs a bunch of
+// experiments.  For every experiment, it orders all the readers
+// involved to start and waits for them to finish the experiment. It
+// then reads their timestamps and starts the next experiment. Each
+// experiment progresses from 1 concurrent reader to N of them at which
+// point all the timestamps are printed.
+static int main_func(void *arg)
+{
+	int exp, r;
+	char buf1[64];
+	char buf[512];
+
+	set_cpus_allowed_ptr(current, cpumask_of(nreaders % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+
+	VERBOSE_PERFOUT("main_func task started");
+	atomic_inc(&n_init);
+
+	// Wait for all threads to start.
+	wait_event(main_wq, atomic_read(&n_init) == (nreaders + 1));
+
+	// Start exp readers up per experiment
+	for (exp = 0; exp < nreaders && !torture_must_stop(); exp++) {
+		if (torture_must_stop())
+			goto end;
+
+		reset_readers(exp);
+		atomic_set(&nreaders_exp, exp + 1);
+
+		exp_idx = exp;
+
+		for (r = 0; r <= exp; r++) {
+			atomic_set(&reader_tasks[r].start, 1);
+			wake_up(&reader_tasks[r].wq);
+		}
+
+		VERBOSE_PERFOUT("main_func: experiment started, waiting for %d readers",
+				exp);
+
+		wait_event(main_wq,
+			   !atomic_read(&nreaders_exp) || torture_must_stop());
+
+		VERBOSE_PERFOUT("main_func: experiment ended");
+
+		if (torture_must_stop())
+			goto end;
+
+		reader_tasks[exp].result_avg = process_durations(exp) / ((exp + 1) * loops);
+	}
+
+	// Print the average of all experiments
+	PERFOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
+
+	buf[0] = 0;
+	strcat(buf, "\n");
+	strcat(buf, "Threads\tTime(ns)\n");
+
+	for (exp = 0; exp < nreaders; exp++) {
+		sprintf(buf1, "%d\t%llu\n", exp + 1, reader_tasks[exp].result_avg);
+		strcat(buf, buf1);
+	}
+
+	PERFOUT("%s", buf);
+
+	// This will shutdown everything including us.
+	if (shutdown) {
+		shutdown_start = 1;
+		wake_up(&shutdown_wq);
+	}
+
+	// Wait for torture to stop us
+	while (!torture_must_stop())
+		schedule_timeout_uninterruptible(1);
+
+end:
+	torture_kthread_stopping("main_func");
+	return 0;
+}
+
+static void
+ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
+{
+	pr_alert("%s" PERF_FLAG
+		 "--- %s:  verbose=%d shutdown=%d loops=%ld\n", perf_type, tag,
+		 verbose, shutdown, loops);
+}
+
+static void
+ref_perf_cleanup(void)
+{
+	int i;
+
+	if (torture_cleanup_begin())
+		return;
+
+	if (!cur_ops) {
+		torture_cleanup_end();
+		return;
+	}
+
+	if (reader_tasks) {
+		for (i = 0; i < nreaders; i++)
+			torture_stop_kthread("ref_perf_reader",
+					     reader_tasks[i].task);
+	}
+	kfree(reader_tasks);
+
+	torture_stop_kthread("main_task", main_task);
+	kfree(main_task);
+
+	// Do perf-type-specific cleanup operations.
+	if (cur_ops->cleanup != NULL)
+		cur_ops->cleanup();
+
+	torture_cleanup_end();
+}
+
+// Shutdown kthread.  Just waits to be awakened, then shuts down system.
+static int
+ref_perf_shutdown(void *arg)
+{
+	wait_event(shutdown_wq, shutdown_start);
+
+	smp_mb(); // Wake before output.
+	ref_perf_cleanup();
+	kernel_power_off();
+
+	return -EINVAL;
+}
+
+static int __init
+ref_perf_init(void)
+{
+	long i;
+	int firsterr = 0;
+	static struct ref_perf_ops *perf_ops[] = {
+		&rcu_ops, &srcu_ops, &refcnt_ops, &rwlock_ops, &rwsem_ops,
+	};
+
+	if (!torture_init_begin(perf_type, verbose))
+		return -EBUSY;
+
+	for (i = 0; i < ARRAY_SIZE(perf_ops); i++) {
+		cur_ops = perf_ops[i];
+		if (strcmp(perf_type, cur_ops->name) == 0)
+			break;
+	}
+	if (i == ARRAY_SIZE(perf_ops)) {
+		pr_alert("rcu-perf: invalid perf type: \"%s\"\n", perf_type);
+		pr_alert("rcu-perf types:");
+		for (i = 0; i < ARRAY_SIZE(perf_ops); i++)
+			pr_cont(" %s", perf_ops[i]->name);
+		pr_cont("\n");
+		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_PERF_TEST));
+		firsterr = -EINVAL;
+		cur_ops = NULL;
+		goto unwind;
+	}
+	if (cur_ops->init)
+		cur_ops->init();
+
+	ref_perf_print_module_parms(cur_ops, "Start of test");
+
+	// Shutdown task
+	if (shutdown) {
+		init_waitqueue_head(&shutdown_wq);
+		firsterr = torture_create_kthread(ref_perf_shutdown, NULL,
+						  shutdown_task);
+		if (firsterr)
+			goto unwind;
+		schedule_timeout_uninterruptible(1);
+	}
+
+	// Reader tasks (~75% of online CPUs).
+	nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
+	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
+			       GFP_KERNEL);
+	if (!reader_tasks) {
+		VERBOSE_PERFOUT_ERRSTRING("out of memory");
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+
+	VERBOSE_PERFOUT("Starting %d reader threads\n", nreaders);
+
+	for (i = 0; i < nreaders; i++) {
+		firsterr = torture_create_kthread(ref_perf_reader, (void *)i,
+						  reader_tasks[i].task);
+		if (firsterr)
+			goto unwind;
+
+		init_waitqueue_head(&(reader_tasks[i].wq));
+	}
+
+	// Main Task
+	init_waitqueue_head(&main_wq);
+	firsterr = torture_create_kthread(main_func, NULL, main_task);
+	if (firsterr)
+		goto unwind;
+	schedule_timeout_uninterruptible(1);
+
+
+	// Wait until all threads start
+	while (atomic_read(&n_init) < nreaders + 1)
+		schedule_timeout_uninterruptible(1);
+
+	wake_up(&main_wq);
+
+	torture_init_end();
+	return 0;
+
+unwind:
+	torture_init_end();
+	ref_perf_cleanup();
+	return firsterr;
+}
+
+module_init(ref_perf_init);
+module_exit(ref_perf_cleanup);
