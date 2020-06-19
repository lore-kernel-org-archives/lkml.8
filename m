Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2200BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D700F20776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sPZRRrEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbgFSUZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:25:36 -0400
Received: from mail.efficios.com ([167.114.26.124]:47366 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389233AbgFSUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:25:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4DF102D621E;
        Fri, 19 Jun 2020 16:25:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SXyP6ssF4xyV; Fri, 19 Jun 2020 16:25:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E3F4B2D6147;
        Fri, 19 Jun 2020 16:25:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E3F4B2D6147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1592598329;
        bh=7b8olYESxPTHJsijCdD9Gp1aTlGeJTdSE9Y6OULi33k=;
        h=From:To:Date:Message-Id;
        b=sPZRRrENBLjezDbT5jTSH5qtlAQap+ljEHRlqcUWkbX5EGq94KkQLijZDqir69Mof
         bg5ZUIt+iqB0YEU8RqZFbFX8uKaayI2MYDQmiZa5+Rlr9KgewubsHn50/ftNx9hZZv
         DTx5DcDx6H5TUYPX+2Tp0u4/j17pg0q31LLuXnSvz4P11hRglsjdjLFTmmgX/LWPfK
         TpTigBKPrdMCooljQgR2KkHpa2Pbt8wH9rDKCKllH80+UDNFLwx2PVvlvn56xRQjEG
         WYok/3SMuiT0Qqn9nRC7NsCSxlfWLvaNl7OjbVoTykzxEQXZnZH2VQafCPlbCTuj0q
         K+TFVU6ovrSBA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JHVynxNyAmzp; Fri, 19 Jun 2020 16:25:29 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 737ED2D604B;
        Fri, 19 Jun 2020 16:25:29 -0400 (EDT)
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Julien Desfossez <ju@klipix.org>
Subject: [RFC PATCH v2] sched_pair_cpu: Introduce scheduler task pairing system call
Date:   Fri, 19 Jun 2020 16:25:16 -0400
Message-Id: <20200619202516.7109-1-mathieu.desnoyers@efficios.com>
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

A few rather complex prior attempts were made to solve this. Those were
based on in-kernel interpreters (cpu_opv, do_on_cpu). That complexity
was generally frowned upon, even by their author.

This patch fulfills this use-case in a simpler way: it introduces a
"sched_pair_cpu" system call, which allows user-space threads to ask to
run "as if" it was running on the runqueue of a specific CPU, but
without being migrated to that cpu, until that pairing is cleared.

"But this can already be done with sched_setaffinity", some could be
tempted to reply. However, sched_setaffinity is not safe with respect to
concurrent cpu hotplug and cpusets changes. This new "cpu pairing"
concept addresses those limitations.

The key idea behind "sched_pair_cpu" is to let a worker thread eat CPU
time on the target CPU while the user-space thread is provided access to
user-space per-cpu data of that CPU, even though it is running on
another CPU. If any of the worker or the user-space thread is preempted,
it preempts the paired thread through an IPI. The priority of the
per-cpu worker threads can be quite low, and is configurable by system
administrators.

It provides to user-space threads access to user-space per-CPU data
structures of the target CPU without requiring the task to migrate to
that CPU, thus without cache pollution which would be detrimental to
use-cases where the cgroup cpusets are used to partition the system.

While paired with a target CPU, restartable sequences can be used to
update the per-cpu data safely against preemption on that CPU.

CPU hotplug offline CPUs are handled by the worker thread as well: it
acts as a queue manager, allowing a single work item to progress at a
time for the offlined CPU which it handles.

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
CC: Julien Desfossez <ju@klipix.org>
---
Changes since v1:
- Update commit message,
- Clear pairing on execve.
- Introduce CONFIG_SCHED_PAIR_CPU and CONFIG_HAVE_SCHED_PAIR_CPU.
- Add missing memory barrier before returning to user-space.
- Fixes following stress-testing and tracing.
- Introduce worker timeout (4ms).
---
 arch/Kconfig                           |   6 +
 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/common.c                |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/exec.c                              |   1 +
 include/linux/kthread.h                |  25 --
 include/linux/sched.h                  | 100 ++++++
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/sched.h             |   6 +
 init/Kconfig                           |  12 +
 init/init_task.c                       |   3 +
 kernel/fork.c                          |   1 +
 kernel/sched/core.c                    | 425 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   1 +
 16 files changed, 563 insertions(+), 26 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..95f71db709a0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -321,6 +321,12 @@ config HAVE_RSEQ
 	  This symbol should be selected by an architecture if it
 	  supports an implementation of restartable sequences.
 
+config HAVE_SCHED_PAIR_CPU
+	bool
+	help
+	  This symbol should be selected by an architecture if it
+	  supports an implementation of the sched_pair_cpu system call.
+
 config HAVE_FUNCTION_ARG_ACCESS_API
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6a0cc524882d..b59145da4cae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -214,6 +214,7 @@ config X86
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_RSEQ
+	select HAVE_SCHED_PAIR_CPU
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bd3f14175193..18e05eff6d12 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -215,6 +215,7 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 			clear_thread_flag(TIF_NOTIFY_RESUME);
 			tracehook_notify_resume(regs);
 			rseq_handle_notify_resume(NULL, regs);
+			sched_pair_cpu_handle_notify_resume(NULL, regs);
 		}
 
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d8f8a1a69ed1..3093ba6c06b3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -443,3 +443,4 @@
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
+440	i386	sched_pair_cpu		sys_sched_pair_cpu
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78847b32e137..ebff2953ddbe 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -360,6 +360,7 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
+440	common	sched_pair_cpu		sys_sched_pair_cpu
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..0316d58d2013 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1931,6 +1931,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	sched_pair_cpu_execve();
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	free_bprm(bprm);
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 65b81e0c494d..0c330e7c1453 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -78,31 +78,6 @@ extern int tsk_fork_get_node(struct task_struct *tsk);
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
index b62e6aaf28f0..128cba8d525b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -630,6 +630,31 @@ struct wake_q_node {
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
@@ -660,6 +685,13 @@ struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
 	unsigned int			cpu;
+#endif
+#ifdef CONFIG_SCHED_PAIR_CPU
+	int				pair_cpu;
+	struct kthread_work		pair_cpu_work;
+	int				pair_cpu_need_worker;
+	int				pair_cpu_worker_active;
+	int				pair_cpu_queued_work;
 #endif
 	unsigned int			wakee_flips;
 	unsigned long			wakee_flip_decay_ts;
@@ -1912,6 +1944,74 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #define TASK_SIZE_OF(tsk)	TASK_SIZE
 #endif
 
+#ifdef CONFIG_SCHED_PAIR_CPU
+
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
+void sched_pair_cpu_clear(void);
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
+/*
+ * Clear paired cpu on exec.
+ */
+static inline void sched_pair_cpu_execve(void)
+{
+	sched_pair_cpu_clear();
+	memset(&current->pair_cpu_work, 0, sizeof(current->pair_cpu_work));
+}
+
+#else
+
+static inline void sched_pair_cpu_set_notify_resume(struct task_struct *t)
+{
+}
+static inline void sched_pair_cpu_preempt(struct task_struct *t)
+{
+}
+static inline void sched_pair_cpu_handle_notify_resume(struct ksignal *ksig,
+						       struct pt_regs *regs)
+{
+}
+static inline void sched_pair_cpu_fork(struct task_struct *t,
+				       unsigned long clone_flags)
+{
+}
+static inline void sched_pair_cpu_execve(void)
+{
+}
+
+#endif
+
 #ifdef CONFIG_RSEQ
 
 /*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7c354c2955f5..c567087e636d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,6 +1005,7 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_sched_pair_cpu(int cmd, int flags, int cpu);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f4a01305d9a6..49872b9733f3 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -857,9 +857,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_sched_pair_cpu 440
+__SYSCALL(__NR_sched_pair_cpu, sys_sched_pair_cpu)
 
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 441
 
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
diff --git a/init/Kconfig b/init/Kconfig
index a46aa8f3174d..c9c57fa3f1b9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1709,6 +1709,18 @@ config RSEQ
 
 	  If unsure, say Y.
 
+config SCHED_PAIR_CPU
+	bool "Enable sched_pair_cpu() system call" if EXPERT
+	default y
+	depends on HAVE_SCHED_PAIR_CPU
+	depends on SMP
+	select RSEQ
+	help
+	  Enable the CPU pairing system call. It provides user-space
+	  a mechanism to update per-cpu data belonging to specific CPUs
+	  with restartable sequences without requiring migration of the
+	  user-space thread to that CPU.
+
 config DEBUG_RSEQ
 	default n
 	bool "Enabled debugging of rseq() system call" if EXPERT
diff --git a/init/init_task.c b/init/init_task.c
index 15089d15010a..6d4fbd417569 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -96,6 +96,9 @@ struct task_struct init_task
 	.tasks		= LIST_HEAD_INIT(init_task.tasks),
 #ifdef CONFIG_SMP
 	.pushable_tasks	= PLIST_NODE_INIT(init_task.pushable_tasks, MAX_PRIO),
+#ifdef CONFIG_SCHED_PAIR_CPU
+	.pair_cpu	= -1,
+#endif
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	.sched_task_group = &root_task_group,
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..bf615a4c4ee8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2238,6 +2238,7 @@ static __latent_entropy struct task_struct *copy_process(
 	copy_seccomp(p);
 
 	rseq_fork(p, clone_flags);
+	sched_pair_cpu_fork(p, clone_flags);
 
 	/* Don't start children in a dying pid namespace */
 	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f360326861e..4f1ba8c7d292 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -39,6 +39,25 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#ifdef CONFIG_SCHED_PAIR_CPU
+
+#define MAX_SCHED_PAIR_CPU_WORK_NS	4000000		/* 4 ms */
+
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
+static DEFINE_PER_CPU(struct pair_cpu, pair_cpu);
+static enum cpuhp_state pair_cpu_hp_online;
+
+#endif /* CONFIG_SCHED_PAIR_CPU */
+
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
 /*
  * Debugging: various feature bits
@@ -1692,6 +1711,150 @@ int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
+#ifdef CONFIG_SCHED_PAIR_CPU
+
+static void pair_cpu_preempt_ipi(void *data)
+{
+	trace_printk("pair_cpu_preempt_ipi on cpu %d task %p\n", smp_processor_id(), current);
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
+	ktime_t time_begin = ktime_get();
+	bool timeout = false;
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
+		timeout = ktime_sub(ktime_get(), time_begin) > MAX_SCHED_PAIR_CPU_WORK_NS;
+		if (timeout)
+			break;
+		touch_softlockup_watchdog();
+		cond_resched();
+		cpu_relax();
+	}
+
+	trace_printk("inactive from cpu %d task %p\n", smp_processor_id(), task);
+	WRITE_ONCE(cpum->running, NULL);
+	WRITE_ONCE(task->pair_cpu_worker_active, 0);
+
+	if (timeout) {
+		/*
+		 * If worker timed out, we need to preempt the associated task with
+		 * an IPI. The IPI may fail if targetting an offline cpu. This implies
+		 * that a preemption of the target task has happened since it ran on
+		 * that cpu.
+		 */
+		int cpu = task_cpu(task);
+
+		trace_printk("worker timeout from cpu %d task %p task_cpu %d\n", smp_processor_id(), task, cpu);
+		if (cpu >= 0)
+			smp_call_function_single(cpu, pair_cpu_preempt_ipi, NULL, 1);
+	}
+
+	/*
+	 * Order prior userspace memory accesses of remote CPU with following
+	 * local userspace memory accesses.
+	 */
+	smp_mb();
+
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
+		/*
+		 *
+		 * Order prior userspace memory accesses of remote CPU with
+		 * following local userspace memory accesses.
+		 */
+		smp_mb();
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
+#endif /* CONFIG_SCHED_PAIR_CPU */
+
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 #ifdef CONFIG_SCHED_DEBUG
@@ -3181,6 +3344,99 @@ static inline void finish_lock_switch(struct rq *rq)
 # define finish_arch_post_lock_switch()	do { } while (0)
 #endif
 
+#ifdef CONFIG_SCHED_PAIR_CPU
+
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
+	trace_printk("worker preempted from cpu %d task %p task_cpu %d\n", smp_processor_id(), running_task, cpu);
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
+
+static void pair_cpu_remote_mb(void *data)
+{
+       /*
+        * Order prior userspace memory accesses of remote CPU with following
+        * local userspace memory accesses.
+        */
+       smp_mb();
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
+	if (prev_pair_cpu < 0 || !READ_ONCE(prev->pair_cpu_need_worker)
+	    || !READ_ONCE(prev->pair_cpu_worker_active))
+		return;
+	/*
+	* Order prior userspace memory accesses of local CPU with following
+	* remote userspace memory accesses.
+	*/
+	smp_mb();
+	/*
+	* IPI may fail if CPU is offlined, in which case the memory barrier
+	* before the worker completes will suffice.
+	*/
+	smp_call_function_single(prev_pair_cpu, pair_cpu_remote_mb, NULL, 1);
+	WRITE_ONCE(prev->pair_cpu_worker_active, 0);
+	WRITE_ONCE(prev->pair_cpu_need_worker, 0);
+}
+
+static void pair_cpu_finish_switch(struct task_struct *prev, long prev_state)
+{
+	pair_cpu_finish_switch_worker(prev);
+	pair_cpu_finish_switch_task(prev, prev_state);
+}
+
+#else /* CONFIG_SCHED_PAIR_CPU */
+
+static void pair_cpu_finish_switch(struct task_struct *prev, long prev_state)
+{
+}
+
+#endif /* CONFIG_SCHED_PAIR_CPU */
+
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -3269,6 +3525,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
+	pair_cpu_finish_switch(prev, prev_state);
 
 	fire_sched_in_preempt_notifiers(current);
 	/*
@@ -4123,6 +4380,7 @@ static void __sched notrace __schedule(bool preempt)
 	next = pick_next_task(rq, prev, &rf);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+	sched_pair_cpu_preempt(prev);
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
@@ -4149,6 +4407,7 @@ static void __sched notrace __schedule(bool preempt)
 
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
+		trace_printk("sched from cpu %d preempt %d prev %p next %p\n", smp_processor_id(), (int)preempt, prev, next);
 		trace_sched_switch(preempt, prev, next);
 
 		/* Also unlocks the rq: */
@@ -6386,6 +6645,7 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 
 	rq->stop = stop;
 }
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -8005,6 +8265,171 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
+#ifdef CONFIG_SCHED_PAIR_CPU
+
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
+void sched_pair_cpu_clear(void)
+{
+	int cpu;
+
+	cpu = READ_ONCE(current->pair_cpu);
+	if (cpu < 0)
+		return;
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
+	return;
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
+		sched_pair_cpu_clear();
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+#endif /* CONFIG_SCHED_PAIR_CPU */
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

