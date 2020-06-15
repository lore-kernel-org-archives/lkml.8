Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F54C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFC12074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ti6ciaEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgFOUWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:22:21 -0400
Received: from mail.efficios.com ([167.114.26.124]:47108 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgFOUWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:22:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E97542DB00B;
        Mon, 15 Jun 2020 16:22:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id a8n4ZN_lDj32; Mon, 15 Jun 2020 16:22:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AA41F2DB00A;
        Mon, 15 Jun 2020 16:22:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AA41F2DB00A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1592252537;
        bh=0YXpmIQcRfkj9sH8yI4Bwy+WBgg/yfvpy38oHznxo2I=;
        h=From:To:Date:Message-Id;
        b=ti6ciaEBQLxFHC3hm2/wK6k+d1KTRAfC3YJ6ScoZR6bMorOjxts4nvEqiF0y1ONYm
         3649TNClXmCyipvhVfyXs0i6U4rW18fNR7+2fLcCVcFI/d6plXLywA6hIdzexOduvs
         IrqXfG/ixPqbbP5d1blMmBbAxLva2kx34l27mCH5V1E4113cwE5rasCq6543yodxIx
         cSBOC2JEjyHnV6EAqcmWruswPkWy6+ma4Dj7xcCf5C+VrWPa1GAQE+rf9DRhCyuorc
         gKOhecGLOUJyE3l9m6VHqHUWzc3uq3I3mW0GjVABSRNz9rKR+eBO4EAkXispCODkOX
         /VXm04XGHnZUA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uniTQ7BM9AAG; Mon, 15 Jun 2020 16:22:17 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 5AE072DAC3E;
        Mon, 15 Jun 2020 16:22:17 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [RFC PATCH] sched_pair_cpu: Introduce scheduler task pairing system call
Date:   Mon, 15 Jun 2020 16:22:10 -0400
Message-Id: <20200615202210.1944-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an important use-case which is not possible with the "rseq"
(Restartable Sequences) system call, which was left as future work.

That use-case is to modify user-space per-cpu data structures belonging
to specific CPUs which may be brought offline and online again by CPU
hotplug. This can be used by memory allocators to migrate free memory
pools when CPUs are brought offline, or by ring buffer consumers to
target specific per-CPU buffers, even when CPUs are brought offline.

A few rather complex prior attempts were made to solve this.  Those were
based on in-kernel interpreters (cpu_opv, do_on_cpu).  That complexity
was generally frowned upon, even by their author.

This patch fulfills this use-case in a simpler way: it introduces a
"sched_pair_cpu" system call, which allows user-space threads to ask to
run "as if" it was running on the runqueue of a specific CPU, but
without being migrated to that cpu, until that pairing is cleared.

"But this can already be done with sched_setaffinity", some would
rightfully reply. However, sched_setaffinity is not safe with respect to
concurrent cpu hotplug and cpusets changes.  This new "cpu pairing"
concept addresses those limitations.

The key idea behind "sched_pair_cpu" is to let a worker thread eat CPU
time on the target CPU while the user-space thread is provided access to
user-space per-cpu data of that CPU, even though it is running on
another CPU. If any of the thread or the worker thread are preempted,
both get preempted.

For instance, this allows implementing this userspace library API for
incrementing a per-cpu counter for a specific cpu number received as
parameter:

static inline __attribute__((always_inline))
int percpu_addv(intptr_t *v, intptr_t count, int cpu)
{
        int ret;

        ret = rseq_addv(v, count, cpu);
check:
        if (rseq_unlikely(ret)) {
                sched_pair_cpu_set(cpu);
                ret = rseq_addv(v, count, percpu_current_cpu());
                sched_pair_cpu_clear();
                goto check;
        }
        return 0;
}

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Joel Fernandes <joelaf@google.com>
CC: "H . Peter Anvin" <hpa@zytor.com>
CC: Paul Turner <pjt@google.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: "Paul E. McKenney" <paulmck@kernel.org>
---
 arch/x86/entry/common.c                |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/exec.c                              |   3 +
 include/linux/kthread.h                |  25 --
 include/linux/sched.h                  |  64 +++++
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/sched.h             |   6 +
 init/init_task.c                       |   1 +
 kernel/fork.c                          |   1 +
 kernel/sched/core.c                    | 368 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   1 +
 13 files changed, 451 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 76735ec813e6..6bcdceba8e00 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -164,6 +164,7 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 			clear_thread_flag(TIF_NOTIFY_RESUME);
 			tracehook_notify_resume(regs);
 			rseq_handle_notify_resume(NULL, regs);
+			sched_pair_cpu_handle_notify_resume(NULL, regs);
 		}
 
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 54581ac671b4..334c24293555 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -442,3 +442,4 @@
 435	i386	clone3			sys_clone3
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
+439	i386	sched_pair_cpu		sys_sched_pair_cpu
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 37b844f839bc..6c8d19605a73 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,7 @@
 435	common	clone3			sys_clone3
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
+439	common	sched_pair_cpu		sys_sched_pair_cpu
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/exec.c b/fs/exec.c
index 2c465119affc..849fbd537d5c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1886,6 +1886,9 @@ static int __do_execve_file(int fd, struct filename *filename,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+#ifdef CONFIG_SMP
+	current->pair_cpu = -1;
+#endif
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	free_bprm(bprm);
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 8bbcaad7ef0f..78d5d693d4e7 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -75,31 +75,6 @@ extern int tsk_fork_get_node(struct task_struct *tsk);
  * respectively.  Queued kthread_works are processed by a kthread
  * running kthread_worker_fn().
  */
-struct kthread_work;
-typedef void (*kthread_work_func_t)(struct kthread_work *work);
-void kthread_delayed_work_timer_fn(struct timer_list *t);
-
-enum {
-	KTW_FREEZABLE		= 1 << 0,	/* freeze during suspend */
-};
-
-struct kthread_worker {
-	unsigned int		flags;
-	raw_spinlock_t		lock;
-	struct list_head	work_list;
-	struct list_head	delayed_work_list;
-	struct task_struct	*task;
-	struct kthread_work	*current_work;
-};
-
-struct kthread_work {
-	struct list_head	node;
-	kthread_work_func_t	func;
-	struct kthread_worker	*worker;
-	/* Number of canceling calls that are running at the moment. */
-	int			canceling;
-};
-
 struct kthread_delayed_work {
 	struct kthread_work work;
 	struct timer_list timer;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..a73dbc33d82a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -629,6 +629,31 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+struct kthread_work;
+typedef void (*kthread_work_func_t)(struct kthread_work *work);
+void kthread_delayed_work_timer_fn(struct timer_list *t);
+
+enum {
+	KTW_FREEZABLE		= 1 << 0,	/* freeze during suspend */
+};
+
+struct kthread_worker {
+	unsigned int		flags;
+	raw_spinlock_t		lock;
+	struct list_head	work_list;
+	struct list_head	delayed_work_list;
+	struct task_struct	*task;
+	struct kthread_work	*current_work;
+};
+
+struct kthread_work {
+	struct list_head	node;
+	kthread_work_func_t	func;
+	struct kthread_worker	*worker;
+	/* Number of canceling calls that are running at the moment. */
+	int			canceling;
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -659,6 +684,11 @@ struct task_struct {
 	/* Current CPU: */
 	unsigned int			cpu;
 #endif
+	int				pair_cpu;
+	struct kthread_work		pair_cpu_work;
+	int				pair_cpu_need_worker;
+	int				pair_cpu_worker_active;
+	int				pair_cpu_queued_work;
 	unsigned int			wakee_flips;
 	unsigned long			wakee_flip_decay_ts;
 	struct task_struct		*last_wakee;
@@ -1878,6 +1908,40 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #define TASK_SIZE_OF(tsk)	TASK_SIZE
 #endif
 
+static inline void sched_pair_cpu_set_notify_resume(struct task_struct *t)
+{
+	if (current->pair_cpu >= 0)
+		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+}
+
+static inline void sched_pair_cpu_preempt(struct task_struct *t)
+{
+	sched_pair_cpu_set_notify_resume(t);
+}
+
+void __sched_pair_cpu_handle_notify_resume(struct ksignal *sig,
+					   struct pt_regs *regs);
+
+static inline void sched_pair_cpu_handle_notify_resume(struct ksignal *ksig,
+						       struct pt_regs *regs)
+{
+	if (current->pair_cpu >= 0)
+		__sched_pair_cpu_handle_notify_resume(ksig, regs);
+}
+
+/*
+ * Clear paired cpu on clone.
+ */
+static inline void sched_pair_cpu_fork(struct task_struct *t,
+				       unsigned long clone_flags)
+{
+	t->pair_cpu = -1;
+	t->pair_cpu_need_worker = 0;
+	t->pair_cpu_worker_active = 0;
+	t->pair_cpu_queued_work = 0;
+	memset(&t->pair_cpu_work, 0, sizeof(t->pair_cpu_work));
+}
+
 #ifdef CONFIG_RSEQ
 
 /*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..bdddabd7698d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1003,6 +1003,7 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_sched_pair_cpu(int cmd, int flags, int cpu);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..8e8baad77d48 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -855,9 +855,11 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_sched_pair_cpu 439
+__SYSCALL(__NR_sched_pair_cpu, sys_sched_pair_cpu)
 
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 440
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..0e2c413fb280 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -145,4 +145,10 @@ struct clone_args {
 			 SCHED_FLAG_KEEP_ALL		| \
 			 SCHED_FLAG_UTIL_CLAMP)
 
+enum sched_pair_cpu_cmd {
+	SCHED_PAIR_CPU_CMD_QUERY			= 0,
+	SCHED_PAIR_CPU_CMD_SET				= (1 << 0),
+	SCHED_PAIR_CPU_CMD_CLEAR			= (1 << 1),
+};
+
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/init/init_task.c b/init/init_task.c
index bd403ed3e418..ea589ccbd2ad 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -89,6 +89,7 @@ struct task_struct init_task
 	.tasks		= LIST_HEAD_INIT(init_task.tasks),
 #ifdef CONFIG_SMP
 	.pushable_tasks	= PLIST_NODE_INIT(init_task.pushable_tasks, MAX_PRIO),
+	.pair_cpu	= -1,
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	.sched_task_group = &root_task_group,
diff --git a/kernel/fork.c b/kernel/fork.c
index 48ed22774efa..eb6ee55eb9b2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2225,6 +2225,7 @@ static __latent_entropy struct task_struct *copy_process(
 	copy_seccomp(p);
 
 	rseq_fork(p, clone_flags);
+	sched_pair_cpu_fork(p, clone_flags);
 
 	/* Don't start children in a dying pid namespace */
 	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..917ec9d6ea50 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -37,6 +37,19 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#define SCHED_PAIR_CPU_CMD_BITMASK	\
+	(SCHED_PAIR_CPU_CMD_SET | SCHED_PAIR_CPU_CMD_CLEAR)
+
+struct pair_cpu {
+	struct kthread_worker *worker;
+	int cpu;				/* protected cpu */
+	int worker_preempted;
+	struct task_struct *running;
+};
+
+DEFINE_PER_CPU(struct pair_cpu, pair_cpu);
+static enum cpuhp_state pair_cpu_hp_online;
+
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
 /*
  * Debugging: various feature bits
@@ -1692,6 +1705,117 @@ int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
+static void pair_cpu_preempt_ipi(void *data)
+{
+	/*
+	 * Order prior userspace memory accesses of local CPU with following
+	 * remote userspace memory accesses.
+	 */
+	smp_mb();
+	set_tsk_need_resched(current);
+}
+
+static void pair_cpu_work_func(struct kthread_work *work)
+{
+	struct task_struct *task = container_of(work, struct task_struct,
+						pair_cpu_work);
+	int task_pair_cpu = READ_ONCE(task->pair_cpu);
+	struct pair_cpu *cpum;
+
+	WARN_ON_ONCE(task_pair_cpu < 0);
+	cpum = per_cpu_ptr(&pair_cpu, task_pair_cpu);
+
+	preempt_disable();
+	/* Set worker active for task. */
+	WRITE_ONCE(cpum->worker_preempted, 0);
+	WRITE_ONCE(cpum->running, task);
+	/*
+	 * Order prior userspace memory accesses of local CPU with following
+	 * remote userspace memory accesses.
+	 */
+	smp_mb();
+	WRITE_ONCE(task->pair_cpu_worker_active, 1);
+	trace_printk("active from cpu %d task %p\n", smp_processor_id(), task);
+	preempt_enable();
+
+	trace_printk("wakeup from cpu %d task %p\n", smp_processor_id(), task);
+	/*
+	 * Wake up target task.
+	 */
+	wake_up_process(task);
+
+	/*
+	 * Consume CPU time as long as an associated task is running on another
+	 * CPU.
+	 */
+	while (READ_ONCE(task->pair_cpu_need_worker)
+	       && !READ_ONCE(cpum->worker_preempted)
+	       && task->state != TASK_DEAD) {
+		cond_resched();
+		cpu_relax();
+	}
+
+	/*
+	 * Order prior userspace memory accesses of remote CPU with following
+	 * local userspace memory accesses.
+	 */
+	smp_mb();
+	trace_printk("inactive from cpu %d task %p\n", smp_processor_id(), task);
+	WRITE_ONCE(cpum->running, NULL);
+	WRITE_ONCE(task->pair_cpu_worker_active, 0);
+	put_task_struct(task);
+}
+
+void __sched_pair_cpu_handle_notify_resume(struct ksignal *sig,
+					   struct pt_regs *regs)
+{
+	int task_pair_cpu = READ_ONCE(current->pair_cpu);
+	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, task_pair_cpu);
+
+	WARN_ON_ONCE(task_pair_cpu < 0);
+	preempt_disable();
+	if (task_pair_cpu == smp_processor_id()) {
+		WRITE_ONCE(current->pair_cpu_need_worker, 0);
+		preempt_enable();
+		if (current->pair_cpu_queued_work) {
+			if (kthread_cancel_work_sync(&current->pair_cpu_work))
+				put_task_struct(current);
+			current->pair_cpu_queued_work = 0;
+		}
+		trace_printk("notify resume run same cpu for cpu %d from task %p\n", task_pair_cpu,
+		       current);
+		return;
+	}
+	if (READ_ONCE(current->pair_cpu_worker_active)) {
+		preempt_enable();
+		trace_printk("notify resume run diff cpu for cpu %d from task %p\n", task_pair_cpu,
+		       current);
+		return;
+	}
+	preempt_enable();
+
+	if (current->pair_cpu_queued_work) {
+		if (kthread_cancel_work_sync(&current->pair_cpu_work))
+			put_task_struct(current);
+		current->pair_cpu_queued_work = 0;
+	}
+
+	preempt_disable();
+	set_current_state(TASK_INTERRUPTIBLE);
+	trace_printk("notify resume block for cpu %d from task %p state 0x%lx\n", task_pair_cpu,
+	       current, current->state);
+	WARN_ON_ONCE(current->pair_cpu_worker_active);
+	WRITE_ONCE(current->pair_cpu_need_worker, 1);
+	get_task_struct(current);
+	kthread_init_work(&current->pair_cpu_work, pair_cpu_work_func);
+	kthread_queue_work(cpum->worker, &current->pair_cpu_work);
+	current->pair_cpu_queued_work = 1;
+	preempt_enable();
+	schedule();
+	trace_printk("notify resume unblock for cpu %d from task %p state 0x%lx\n", task_pair_cpu,
+	       current, current->state);
+}
+
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 #ifdef CONFIG_SCHED_DEBUG
@@ -3118,6 +3242,87 @@ static inline void finish_lock_switch(struct rq *rq)
 # define finish_arch_post_lock_switch()	do { } while (0)
 #endif
 
+/*
+ * If we preempt the cpu mutex worker, we need to IPI the CPU
+ * running the thread currently associated to it before scheduling
+ * other tasks.
+ *
+ * This only targets pair_cpu worker for online cpus.
+ */
+static void pair_cpu_finish_switch_worker(struct task_struct *prev)
+{
+	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, smp_processor_id());
+	struct task_struct *running_task;
+	int cpu;
+
+	if (!cpum->worker || prev != cpum->worker->task)
+		return;
+	running_task = READ_ONCE(cpum->running);
+	if (!running_task)
+		return;
+	WRITE_ONCE(cpum->worker_preempted, 1);
+	WRITE_ONCE(running_task->pair_cpu_worker_active, 0);
+	WRITE_ONCE(cpum->running, NULL);
+
+	/*
+	 * If worker was preempted, we need to preempt the associated task with
+	 * an IPI. The IPI may fail if targetting an offline cpu. This implies
+	 * that a preemption of the target task has happened since it ran on
+	 * that cpu.
+	 */
+	cpu = task_cpu(running_task);
+
+	trace_printk("worker preempted from cpu %d task %p\n", smp_processor_id(), running_task);
+	if (cpu >= 0) {
+		smp_call_function_single(cpu, pair_cpu_preempt_ipi, NULL, 1);
+		/*
+		 * Order prior userspace memory accesses of remote CPU with
+		 * following local userspace memory accesses.
+		 */
+		smp_mb();
+	}
+}
+
+static void pair_cpu_remote_mb(void *data)
+{
+	/*
+	 * Order prior userspace memory accesses of remote CPU with following
+	 * local userspace memory accesses.
+	 */
+	smp_mb();
+}
+
+/*
+ * If we preempt a task currently associated with a cpu mutex worker,
+ * we need to tell the worker to stop using cpu time.
+ */
+static void pair_cpu_finish_switch_task(struct task_struct *prev, long prev_state)
+{
+	int prev_pair_cpu;
+
+	prev_pair_cpu = READ_ONCE(prev->pair_cpu);
+	if (prev_pair_cpu < 0 || !READ_ONCE(current->pair_cpu_need_worker))
+		return;
+	/*
+	 * Order prior userspace memory accesses of local CPU with following
+	 * remote userspace memory accesses.
+	 */
+	smp_mb();
+	/*
+	 * IPI may fail if CPU is offlined, in which case the memory barrier before
+	 * the worker completes will suffice.
+	 */
+	smp_call_function_single(prev_pair_cpu, pair_cpu_remote_mb, NULL, 1);
+	WRITE_ONCE(current->pair_cpu_worker_active, 0);
+	WRITE_ONCE(current->pair_cpu_need_worker, 0);
+}
+
+static void pair_cpu_finish_switch(struct task_struct *prev, long prev_state)
+{
+	pair_cpu_finish_switch_worker(prev);
+	pair_cpu_finish_switch_task(prev, prev_state);
+}
+
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -3139,6 +3344,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
+	sched_pair_cpu_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
 	prepare_task(next);
 	prepare_arch_switch(next);
@@ -3206,6 +3412,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
+	pair_cpu_finish_switch(prev, prev_state);
 
 	fire_sched_in_preempt_notifiers(current);
 	/*
@@ -6312,6 +6519,7 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 
 	rq->stop = stop;
 }
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -7923,6 +8131,166 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
+static void pair_cpu_spawn_worker(int cpu)
+{
+	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, cpu);
+	struct kthread_worker *worker;
+
+	WARN_ON_ONCE(cpum->worker);
+	worker = kthread_create_worker_on_cpu(cpu, 0, "pair_cpu/%d", cpu);
+	if (IS_ERR(worker)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+	cpum->worker = worker;
+	cpum->cpu = cpu;
+}
+
+static int pair_cpu_startup(unsigned int cpu)
+{
+	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, cpu);
+	struct task_struct *running_task;
+	int target_task_cpu;
+
+	trace_printk("startup cpu %d cpumutex %p worker %p\n", cpu, cpum, cpum->worker);
+	/* Bind the still running worker thread back to its rightful cpu. */
+	set_cpus_allowed_ptr(cpum->worker->task, cpumask_of(cpu));
+
+	/* Set worker as preempted and ipi other task. */
+	running_task = READ_ONCE(cpum->running);
+	if (!running_task)
+		return 0;
+	WRITE_ONCE(cpum->worker_preempted, 1);
+	WRITE_ONCE(running_task->pair_cpu_worker_active, 0);
+	WRITE_ONCE(cpum->running, NULL);
+
+	/*
+	 * If worker was preempted, we need to preempt the associated task with
+	 * an IPI. The IPI may fail due to CPU hotplug, in which case the task
+	 * has been preempted since it ran on target_task_cpu.
+	 */
+	target_task_cpu = task_cpu(running_task);
+
+	trace_printk("startup cpu %d preempt task %p\n", cpu, running_task);
+	if (target_task_cpu >= 0) {
+		smp_call_function_single(cpu, pair_cpu_preempt_ipi, NULL, 1);
+		/*
+		 * Order prior userspace memory accesses of remote CPU with
+		 * following local userspace memory accesses.
+		 */
+		smp_mb();
+	}
+
+	return 0;
+}
+
+static int pair_cpu_teardown(unsigned int cpu)
+{
+	struct pair_cpu *cpum = per_cpu_ptr(&pair_cpu, cpu);
+
+	trace_printk("teardown cpu %d cpumutex %p worker %p\n", cpu, cpum, cpum->worker);
+	/* The worker thread can now be migrated to any online cpu. */
+	set_cpus_allowed_ptr(cpum->worker->task, cpu_possible_mask);
+	return 0;
+}
+
+static void __init pair_cpu_spawn_workers(void)
+{
+	int ret, cpu;
+
+	cpus_read_lock();
+	for_each_possible_cpu(cpu)
+		pair_cpu_spawn_worker(cpu);
+	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
+					"cpumutex",
+					pair_cpu_startup,
+					pair_cpu_teardown);
+	WARN_ON_ONCE(ret < 0);
+	pair_cpu_hp_online = ret;
+	cpus_read_unlock();
+}
+
+late_initcall(pair_cpu_spawn_workers);
+
+static int sched_pair_cpu_set(int cpu)
+{
+	if (cpu < 0 || !cpu_possible(cpu))
+		return -EINVAL;
+	if (READ_ONCE(current->pair_cpu) >= 0)
+		return -EBUSY;
+	trace_printk("set cpu %d from task %p\n", cpu, current);
+	WRITE_ONCE(current->pair_cpu, cpu);
+	set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+	/*
+	 * From this point onwards, our user-space can only run if the target
+	 * cpu's worker thread is also running, except if the target cpu is
+	 * offline, in which case the worker thread needs to be handling our
+	 * work item, but can be preempted.
+	 */
+	trace_printk("running cpu %d from task %p\n", cpu, current);
+	return 0;
+}
+
+static int sched_pair_cpu_clear(void)
+{
+	int cpu;
+
+	cpu = READ_ONCE(current->pair_cpu);
+	if (cpu < 0)
+		return 0;
+	trace_printk("signal cpu %d from task %p\n", cpu, current);
+	if (READ_ONCE(current->pair_cpu_need_worker)) {
+		/*
+		 * Order prior userspace memory accesses of local CPU
+		 * with following remote userspace memory accesses.
+		 */
+		smp_mb();
+		WRITE_ONCE(current->pair_cpu_need_worker, 0);
+	}
+	if (current->pair_cpu_queued_work) {
+		if (kthread_cancel_work_sync(&current->pair_cpu_work))
+			put_task_struct(current);
+		current->pair_cpu_queued_work = 0;
+	}
+	WRITE_ONCE(current->pair_cpu, -1);
+	WARN_ON_ONCE(READ_ONCE(current->pair_cpu_worker_active));
+	return 0;
+}
+
+/*
+ * sys_sched_pair_cpu - Run with mutual exclusion with respect to userspace threads
+ *                      on the target cpu. Does not require migration to the target
+ *                      cpu.
+ * @cmd: command to issue (enum sched_pair_cpu_cmd)
+ * @flags: system call flags
+ * @cpu: cpu where the task should run.
+ *
+ * Returns -EINVAL if cmd is unknown.
+ * Returns -EINVAL if flags are unknown.
+ * Returns -EINVAL if the CPU is not part of the possible CPUs.
+ * Returns -EBUSY if trying to set pairing for the task is already paired to a CPU.
+ *
+ * SCHED_PAIR_CPU_CMD_QUERY: Return the mask of supported commands.
+ * SCHED_PAIR_CPU_CMD_SET:   Request to run with mutual exclusion with respect to
+ *                            userspace threads on the target cpu.
+ * SCHED_PAIR_CPU_CMD_CLEAR: Clear pair_cpu for current task.
+ */
+SYSCALL_DEFINE3(sched_pair_cpu, int, cmd, int, flags, int, cpu)
+{
+	if (unlikely(flags))
+		return -EINVAL;
+	switch (cmd) {
+	case SCHED_PAIR_CPU_CMD_QUERY:
+		return SCHED_PAIR_CPU_CMD_BITMASK;
+	case SCHED_PAIR_CPU_CMD_SET:
+		return sched_pair_cpu_set(cpu);
+	case SCHED_PAIR_CPU_CMD_CLEAR:
+		return sched_pair_cpu_clear();
+	default:
+		return -EINVAL;
+	}
+}
+
 void dump_cpu_task(int cpu)
 {
 	pr_info("Task dump for CPU %d:\n", cpu);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..54dd5e7af53a 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -472,3 +472,4 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+COND_SYSCALL(sched_pair_cpu);
-- 
2.17.1

