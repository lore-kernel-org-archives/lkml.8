Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A01EC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D998206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=narfindustries.com header.i=@narfindustries.com header.b="aM1xf0Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD2Tdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2Tdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:33:47 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C988EC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:46 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id m24so2191086vsq.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=narfindustries.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=R7PXi289BqWvkuxiu79z1TDdWGWNhaC2jzw+L10mfTc=;
        b=aM1xf0UzRM3URx84WvYob4G+M8/c+3cZ26/L2EILNXgA9x9RwloTVLSTGo22qP5ca4
         A249mzBAAdLbZtCy2BXimfPGiTSdldlL3fAu7/v7HhrpTfZkP0Geh0TSFHF01I0pSwke
         EfoqUL2jsoLp9hEToIBmEUOX21pYq+hUj+qq6L6+isda4/SexkA/r6o5jdWzrwHqrlqr
         sSLZ4AusEL5+Z+FHG4glwXhkjlkrdOxbho0xVfmhneOEReaUhO8KRK0MQDA/nXEl3sCW
         fJjI43oHTrX0TSUID5Wszmg1tNHimKe9bFzoMjdHWYNbN916VdM3NHH1iNM4yfLPDiPn
         pRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=R7PXi289BqWvkuxiu79z1TDdWGWNhaC2jzw+L10mfTc=;
        b=q9OIeV3/0XpeASuiE12q15Sz8LyVoxF8ypeR8DEsPV/OvnHCRWH79Vwe6ldBXnCfg+
         gtImqQKZj+i71b+Jd3mRtJb4l/gxyoaAGkVZ58TliXW4ewaI5QQr0VWb1MJGUmCX9GcO
         2IoNvQ36SjFJ4x13SWxgqgj8CBZWEd3YVjLRR3nCBCmb4GZr0bT/shLK4/KBH8K/qMky
         9E0zzwSuoEjEqc5afT7sZt1WKL6on7NtsRtp1kvbHx2cyhMvRVXWB7NWBzX0lOyY+9e4
         Qm60speirmWiGJgZ7wnmKqlBw4IFg9nBGAGIoB0pIiglkjibjm13oShFJ8twDtyYOKsQ
         ymuw==
X-Gm-Message-State: AGi0PuZHmhnINfruNHrM9RR608kkFDGdkDikpywYibwhDLBcjpDJdCrm
        qifRBKmur2jMBmEytx2NCpaJzvLqNd4YAA==
X-Google-Smtp-Source: APiQypKsXXz+3h4VQ95RX6e+yO6fUb5JihCeepBAIAEisjvctJU70LF4dX8FJ+NfHONMP/LSTae2Mg==
X-Received: by 2002:a67:f78c:: with SMTP id j12mr18676vso.196.1588188825508;
        Wed, 29 Apr 2020 12:33:45 -0700 (PDT)
Received: from localhost.localdomain ([24.171.221.68])
        by smtp.gmail.com with ESMTPSA id k26sm76764uag.10.2020.04.29.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:33:45 -0700 (PDT)
From:   Javier Malave <javier.malave@narfindustries.com>
To:     bx@narfindustries.com
Cc:     Javier Malave <javier.malave@narfindustries.com>,
        linux-kernel@vger.kernel.org, ah@narfindustries.com
Subject: [RFC 1/9] Core Popcorn Changes
Date:   Wed, 29 Apr 2020 15:32:48 -0400
Message-Id: <83446cdea4cae17d82c12110ab598be7ef4334f2.1588127445.git.javier.malave@narfindustries.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <0>
 <cover.1588127445.git.javier.malave@narfindustries.com>
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <cover.1588127445.git.javier.malave@narfindustries.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Popcorn Linux is a Linux kernel-based software stack that 
enables applications to execute, with a shared source
base, on distributed hosts.

To achieve its goal of distributed multi-threaded
applications, Popcorn introduces certain core modifications
to the Linux kernel. These include the addition of
several system calls, a message layer and the Popcorn
implementation itself.

System Calls

In this RFC there are three system calls associated with
the migration mechanism.

popcorn_migrate: allows user to migrate a thread to another
popcorn registered node.

popcorn_get_node_info: get status information on Popcorn
registered nodes.

popcorn_get_thread_status: get status information of current
distributed thread.

Message Layer

Popcorn views compute resources as nodes. Each Popcorn node
may be multiple cores running an instance of the Linux kernel.
Each node registers itself in the network via the message layer
TCP/IP socket. Popcorn processes communicate with each other 
using Popcorn specific messages. Popcorn messages are used for 
the VMA coherency protocol, managing the necessary distributed 
locks, signaling process migration and exit.

Popcorn Implementation

The heart of Popcorn's implementation resides in kernel/popcorn.
Popcorn implements a main kernel thread to execute process
migration from its origin node to remote nodes. A pair of work
queues are used to process incoming messages and requests.

Work is tracked via a remote_context struct introduced by
Popcorn Linux. This struct also contains necessary information
to implement the VMA coherency protocol. As such, this struct is
embedded in task_struct and mm_struct and forms part of the
memory management modifications necessary to achieve
dynamic thread migration.

We welcome feedback to these core modifications. And look
forward to an open and productive discussion of the complete
Popcorn Linux work.
---
 fs/proc/base.c                         |   9 ++
 fs/read_write.c                        |  15 +-
 include/linux/mm_types.h               |  12 ++
 include/linux/sched.h                  |  27 +++-
 include/uapi/asm-generic/mman-common.h |   4 +
 kernel/Kconfig.popcorn                 |  54 +++++++
 kernel/Makefile                        |   1 +
 kernel/exit.c                          |   9 ++
 kernel/fork.c                          |  51 ++++++-
 kernel/futex.c                         |  32 ++++
 kernel/sched/core.c                    | 106 +++++++++++++-
 kernel/sys_ni.c                        |   3 +
 mm/gup.c                               |  18 +++
 mm/internal.h                          |   4 +
 mm/madvise.c                           |  51 +++++++
 mm/memory.c                            | 195 ++++++++++++++++++++++++-
 mm/mmap.c                              |  53 +++++++
 mm/mprotect.c                          |  21 ++-
 mm/mremap.c                            |  20 +++
 19 files changed, 679 insertions(+), 6 deletions(-)
 create mode 100644 kernel/Kconfig.popcorn

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9c8ca6cd3..887f36c55 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -88,6 +88,9 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_struct.h>
 #include <linux/slab.h>
+#ifdef CONFIG_POPCORN
+#include <popcorn/types.h>
+#endif
 #include <linux/sched/autogroup.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
@@ -345,6 +348,12 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 	tsk = get_proc_task(file_inode(file));
 	if (!tsk)
 		return -ESRCH;
+#ifdef CONFIG_POPCORN
+	if (distributed_remote_process(tsk)) {
+		put_task_struct(tsk);
+		return 0;
+	}
+#endif
 	ret = get_task_cmdline(tsk, buf, count, pos);
 	put_task_struct(tsk);
 	if (ret > 0)
diff --git a/fs/read_write.c b/fs/read_write.c
index c543d965e..b0bc6aefc 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -573,11 +573,18 @@ static inline loff_t *file_ppos(struct file *file)
 	return file->f_mode & FMODE_STREAM ? NULL : &file->f_pos;
 }
 
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+#include <popcorn/types.h>
+#endif
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count)
 {
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;
-
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+	if (WARN_ON(distributed_remote_process(current))) {
+		printk("  file read at remote thread is not supported yet\n");
+	}
+#endif
 	if (f.file) {
 		loff_t pos, *ppos = file_ppos(f.file);
 		if (ppos) {
@@ -602,6 +609,12 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;
 
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+	if (WARN_ON(distributed_remote_process(current))) {
+		printk("  file write at remote thread is not supported yet\n");
+	}
+#endif
+
 	if (f.file) {
 		loff_t pos, *ppos = file_ppos(f.file);
 		if (ppos) {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8ec38b11b..b041bce9c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -17,6 +17,10 @@
 
 #include <asm/mmu.h>
 
+#ifdef CONFIG_POPCORN
+struct remote_context;
+#endif
+
 #ifndef AT_VECTOR_SIZE_ARCH
 #define AT_VECTOR_SIZE_ARCH 0
 #endif
@@ -505,6 +509,10 @@ struct mm_struct {
 		/* HMM needs to track a few things per mm */
 		struct hmm *hmm;
 #endif
+#ifdef CONFIG_POPCORN
+		struct remote_context *remote;
+#endif
+
 	} __randomize_layout;
 
 	/*
@@ -670,6 +678,10 @@ enum vm_fault_reason {
 	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
 	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
+#ifdef CONFIG_POPCORN
+	VM_FAULT_CONTINUE       = (__force vm_fault_t)0x004000,
+	VM_FAULT_KILLED         = (__force vm_fault_t)0x008000,
+#endif
 };
 
 /* Encode hstate index for a hwpoisoned large page */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 118374106..7c787d435 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -29,7 +29,9 @@
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
 #include <linux/rseq.h>
-
+#ifdef CONFIG_POPCORN
+#include <linux/completion.h>
+#endif
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
 struct backing_dev_info;
@@ -1177,6 +1179,29 @@ struct task_struct {
 	unsigned long			task_state_change;
 #endif
 	int				pagefault_disabled;
+#ifdef CONFIG_POPCORN
+	struct remote_context *remote;
+	union {
+		int peer_nid;
+		int remote_nid;
+		int origin_nid;
+	};
+	union {
+		pid_t peer_pid;
+		pid_t remote_pid;
+		pid_t origin_pid;
+	};
+
+	bool is_worker;			/* kernel thread that manages the process*/
+	bool at_remote;			/* Is executing on behalf of another node? */
+
+	volatile void *remote_work;
+	struct completion remote_work_pended;
+
+	int migration_target_nid;
+	int backoff_weight;
+#endif
+
 #ifdef CONFIG_MMU
 	struct task_struct		*oom_reaper_list;
 #endif
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index abd238d0f..cd60c857e 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -64,6 +64,10 @@
 #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
+#ifdef CONFIG_POPCORN
+#define MADV_RELEASE 20
+#endif
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/kernel/Kconfig.popcorn b/kernel/Kconfig.popcorn
new file mode 100644
index 000000000..3ed8b4fc3
--- /dev/null
+++ b/kernel/Kconfig.popcorn
@@ -0,0 +1,54 @@
+menu "Popcorn Distributed Execution Support"
+
+# This is selected by all the architectures Popcorn supports
+config ARCH_SUPPORTS_POPCORN
+	bool
+
+config POPCORN
+	bool "Popcorn Distributed Execution Support"
+	depends on ARCH_SUPPORTS_POPCORN
+	default n
+	help
+	  Enable or disable the Popcorn multi-kernel Linux support.
+
+if POPCORN
+
+config POPCORN_DEBUG
+	bool "Log debug messages for Popcorn"
+	default n
+	help
+	  Enable or disable kernel messages that can help debug Popcorn issues.
+
+config POPCORN_DEBUG_PROCESS_SERVER
+	bool "Debug task migration"
+	depends on POPCORN_DEBUG
+	default n
+
+config POPCORN_DEBUG_PAGE_SERVER
+	bool "Debug page migration"
+	depends on POPCORN_DEBUG
+	default n
+
+config POPCORN_DEBUG_VMA_SERVER
+	bool "Debug VMA handling"
+	depends on POPCORN_DEBUG
+	default n
+
+config POPCORN_DEBUG_VERBOSE
+	bool "Log more debug messages"
+	depends on POPCORN_DEBUG
+	default n
+
+config POPCORN_CHECK_SANITY
+	bool "Perform extra-sanity checks"
+	default y
+
+
+comment "Popcorn is not currently supported on this architecture"
+	depends on !ARCH_SUPPORTS_POPCORN
+
+source "drivers/msg_layer/Kconfig"
+
+endif # POPCORN
+
+endmenu
diff --git a/kernel/Makefile b/kernel/Makefile
index a8d923b54..c082d96a8 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
+obj-$(CONFIG_POPCORN) += popcorn/
 
 obj-$(CONFIG_HAS_IOMEM) += iomem.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
diff --git a/kernel/exit.c b/kernel/exit.c
index 1803efb29..207c2d12f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -69,6 +69,10 @@
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 
+#ifdef CONFIG_POPCORN
+#include <popcorn/process_server.h>
+#endif
+
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
 	nr_threads--;
@@ -503,6 +507,11 @@ static void exit_mm(void)
 	if (!mm)
 		return;
 	sync_mm_rss(mm);
+
+#ifdef CONFIG_POPCORN
+	process_server_task_exit(current);
+#endif
+
 	/*
 	 * Serialize with any possible pending coredump.
 	 * We must hold mmap_sem around checking core_state
diff --git a/kernel/fork.c b/kernel/fork.c
index 75675b9bf..c49a72b16 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -107,6 +107,11 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/task.h>
 
+#ifdef CONFIG_POPCORN
+#include <popcorn/types.h>
+#include <popcorn/process_server.h>
+#endif
+
 /*
  * Minimum number of threads to boot the kernel
  */
@@ -923,6 +928,44 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
+
+#ifdef CONFIG_POPCORN
+	/*
+	 * Reset variables for tracking remote execution
+	 */
+	tsk->remote = NULL;
+	tsk->remote_nid = tsk->origin_nid = -1;
+	tsk->remote_pid = tsk->origin_pid = -1;
+
+	tsk->is_worker = false;
+
+	/*
+	 * If the new tsk is not in the same thread group as the parent,
+	 * then we do not need to propagate the old thread info.
+	 * Otherwise, make sure to keep an accurate record
+	 * of which node and thread group the new thread is a part of.
+	 */
+	if (orig->tgid != tsk->tgid) {
+		tsk->at_remote = false;
+	}
+
+	tsk->remote_work = NULL;
+	init_completion(&tsk->remote_work_pended);
+
+	tsk->migration_target_nid = -1;
+	tsk->backoff_weight = 0;
+
+	/*
+	 * Temporarily boost the priviledge to exploit thread bootstrapping
+	 * in copy_thread_tls() during kernel_thread(). Will be demoted in the
+	 * remote thread context.
+	 */
+	if (orig->is_worker) {
+		tsk->flags |= PF_KTHREAD;
+	}
+
+#endif // CONFIG_POPCORN
+
 	return tsk;
 
 free_stack:
@@ -1006,6 +1049,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
+#endif
+#ifdef CONFIG_POPCORN
+	mm->remote = NULL;
 #endif
 	mm_init_uprobes_state(mm);
 
@@ -1066,6 +1112,10 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+#ifdef CONFIG_POPCORN
+	if (mm->remote)
+		free_remote_context(mm->remote);
+#endif
 	mmdrop(mm);
 }
 
@@ -1927,7 +1977,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->utimescaled = p->stimescaled = 0;
 #endif
 	prev_cputime_init(&p->prev_cputime);
-
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 	seqcount_init(&p->vtime.seqcount);
 	p->vtime.starttime = 0;
diff --git a/kernel/futex.c b/kernel/futex.c
index 4b5b468c5..e374295e1 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -59,6 +59,12 @@
 
 #include <asm/futex.h>
 
+#ifdef CONFIG_POPCORN
+#include <popcorn/types.h>
+#include <popcorn/process_server.h>
+#include <popcorn/page_server.h>
+#endif
+
 #include "locking/rtmutex_common.h"
 
 /*
@@ -2684,6 +2690,9 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
 	int ret;
+#ifdef CONFIG_POPCORN
+	struct fault_handle *fh = NULL;
+#endif
 
 	if (!bitset)
 		return -EINVAL;
@@ -2701,11 +2710,19 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	}
 
 retry:
+#ifdef CONFIG_POPCORN
+	ret = page_server_get_userpage(uaddr, &fh, "wait");
+	if (ret < 0)
+		goto out;
+#endif
 	/*
 	 * Prepare to wait on uaddr. On success, holds hb lock and increments
 	 * q.key refs.
 	 */
 	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
+#ifdef CONFIG_POPCORN
+	page_server_put_userpage(fh, "wait");
+#endif
 	if (ret)
 		goto out;
 
@@ -3629,6 +3646,15 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 			return -ENOSYS;
 	}
 
+#ifdef CONFIG_POPCORN
+	if (distributed_process(current)) {
+		WARN_ON(cmd != FUTEX_WAIT &&
+				cmd != FUTEX_WAIT_BITSET &&
+				cmd != FUTEX_WAKE &&
+				cmd != FUTEX_WAKE_BITSET);
+	}
+#endif
+
 	switch (cmd) {
 	case FUTEX_WAIT:
 		val3 = FUTEX_BITSET_MATCH_ANY;
@@ -3695,6 +3721,12 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
 		val2 = (u32) (unsigned long) utime;
 
+#ifdef CONFIG_POPCORN
+	if (distributed_remote_process(current)) {
+		return process_server_do_futex_at_remote(
+				uaddr, op, val, tp ? true : false, &ts, uaddr2, val2, val3);
+	}
+#endif
 	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c42774..4bcb43f18 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2770,6 +2770,9 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 
 	calculate_sigpending();
 }
+#ifdef CONFIG_POPCORN_DEBUG
+extern void trace_task_status(void);
+#endif
 
 /*
  * context_switch - switch to the new MM and the new thread's register state.
@@ -2779,7 +2782,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
 	struct mm_struct *mm, *oldmm;
-
+#ifdef CONFIG_POPCORN_DEBUG
+	trace_task_status();
+#endif
 	prepare_task_switch(rq, prev, next);
 
 	mm = next->mm;
@@ -4912,6 +4917,105 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
 	return ret;
 }
 
+#ifdef CONFIG_POPCORN
+#include <popcorn/bundle.h>
+#include <popcorn/types.h>
+#include <popcorn/process_server.h>
+
+SYSCALL_DEFINE1(popcorn_get_thread_status, struct popcorn_thread_status __user *, status)
+{
+	struct popcorn_thread_status st = {
+		.current_nid = my_nid,
+		.peer_nid = current->peer_nid,
+		.peer_pid = current->peer_pid,
+	};
+
+	if (!access_ok(status, sizeof(*status))) {
+		return -EINVAL;
+	}
+
+	if (copy_to_user(status, &st, sizeof(st))) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+SYSCALL_DEFINE3(popcorn_get_node_info, int *, _my_nid, struct popcorn_node_info __user *, info, int, len)
+{
+	int i;
+
+	if (!access_ok(_my_nid, sizeof(*_my_nid))) {
+		return -EINVAL;
+	}
+	if (copy_to_user(_my_nid, &my_nid, sizeof(my_nid))) {
+		return -EINVAL;
+	}
+
+	if (!access_ok(info, sizeof(*info) * MAX_POPCORN_NODES)) {
+		return -EINVAL;
+	}
+	for (i = 0; i < len; i++) {
+		struct popcorn_node_info res = {
+			.status = 0,
+			.arch = POPCORN_ARCH_UNKNOWN,
+			.distance = 0,
+		};
+		struct popcorn_node_info __user *ni = info + i;
+
+		if (get_popcorn_node_online(i)) {
+			res.status = 1;
+			res.arch = get_popcorn_node_arch(i);
+		}
+
+		if (copy_to_user(ni, &res, sizeof(res))) {
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+#pragma GCC optimize ("no-omit-frame-pointer")
+#pragma GCC optimize ("no-optimize-sibling-calls")
+SYSCALL_DEFINE2(popcorn_migrate, int, nid, void __user *, uregs)
+{
+	int ret;
+	PSPRINTK("####### MIGRATE [%d] to %d\n", current->pid, nid);
+
+	if (nid == -1) {
+		nid = current->migration_target_nid;
+	}
+	if (nid < 0 || nid >= MAX_POPCORN_NODES) {
+		PSPRINTK("  [%d] invalid migration destination %d\n",
+				current->pid, nid);
+		return -EINVAL;
+	}
+	if (nid == my_nid) {
+		PSPRINTK("  [%d] already running at the destination %d\n",
+				current->pid, nid);
+		return -EBUSY;
+	}
+
+	if (!get_popcorn_node_online(nid)) {
+		PSPRINTK("  [%d] destination node %d is offline\n",
+				current->pid, nid);
+		return -EAGAIN;
+	}
+
+	ret = process_server_do_migration(current, nid, uregs);
+	if (ret) return ret;
+
+	current->migration_target_nid = -1;
+
+	update_frame_pointer();
+#ifdef CONFIG_POPCORN_DEBUG_VERBOSE
+	PSPRINTK("  [%d] resume execution\n", current->pid);
+#endif
+	return 0;
+}
+#pragma GCC reset_options
+#endif // CONFIG_POPCORN
+
 /**
  * sys_sched_yield - yield the current processor to other threads.
  *
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d9ae5ea6..51e19ede1 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -166,6 +166,9 @@ COND_SYSCALL(syslog);
 /* kernel/ptrace.c */
 
 /* kernel/sched/core.c */
+COND_SYSCALL(popcorn_migrate);
+COND_SYSCALL(popcorn_get_node_info);
+COND_SYSCALL(popcorn_get_thread_status);
 
 /* kernel/sys.c */
 COND_SYSCALL(setregid);
diff --git a/mm/gup.c b/mm/gup.c
index ddde097cf..f3ca58a7b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -22,6 +22,11 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_POPCORN
+#include <popcorn/process_server.h>
+#include <popcorn/vma_server.h>
+#endif
+
 #include "internal.h"
 
 struct follow_page_context {
@@ -969,6 +974,19 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 
 retry:
 	vma = find_extend_vma(mm, address);
+#ifdef CONFIG_POPCORN
+	if (distributed_remote_process(tsk)) {
+		if (!vma || address < vma->vm_start) {
+			if (vma_server_fetch_vma(tsk, address) == 0) {
+				/* Replace with updated VMA */
+				vma = find_extend_vma(mm, address);
+			} else {
+				return -ENOMEM;
+			}
+		}
+	}
+#endif
+
 	if (!vma || address < vma->vm_start)
 		return -EFAULT;
 
diff --git a/mm/internal.h b/mm/internal.h
index e32390802..e945732ef 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -9,6 +9,10 @@
 
 #include <linux/fs.h>
 #include <linux/mm.h>
+
+#ifdef CONFIG_POPCORN
+#include <popcorn/types.h>
+#endif
 #include <linux/pagemap.h>
 #include <linux/tracepoint-defs.h>
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 628022e67..4d13609d7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -28,6 +28,12 @@
 #include <asm/tlb.h>
 
 #include "internal.h"
+#ifdef CONFIG_POPCORN
+#include <popcorn/types.h>
+#include <popcorn/vma_server.h>
+#include <popcorn/page_server.h>
+#include <popcorn/bundle.h>
+#endif
 
 /*
  * Any behaviour which results in changes to the vma->vm_flags needs to
@@ -686,6 +692,23 @@ static int madvise_inject_error(int behavior,
 }
 #endif
 
+#ifdef CONFIG_POPCORN
+int madvise_release(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+{
+	int nr_pages = 0;
+	unsigned long addr;
+
+	/* mmap_sem is held */
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		nr_pages += page_server_release_page_ownership(vma, addr);
+	}
+
+	VSPRINTK("  [%d] %d %d / %ld %lx-%lx\n", current->pid, my_nid,
+			nr_pages, (end - start) / PAGE_SIZE, start, end);
+	return 0;
+}
+#endif
+
 static long
 madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		unsigned long start, unsigned long end, int behavior)
@@ -698,6 +721,10 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	case MADV_FREE:
 	case MADV_DONTNEED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
+#ifdef CONFIG_POPCORN
+	case MADV_RELEASE:
+		return madvise_release(vma, start, end);
+#endif
 	default:
 		return madvise_behavior(vma, prev, start, end, behavior);
 	}
@@ -726,6 +753,10 @@ madvise_behavior_valid(int behavior)
 #endif
 	case MADV_DONTDUMP:
 	case MADV_DODUMP:
+
+#ifdef CONFIG_POPCORN
+	case MADV_RELEASE:
+#endif
 	case MADV_WIPEONFORK:
 	case MADV_KEEPONFORK:
 #ifdef CONFIG_MEMORY_FAILURE
@@ -809,6 +840,11 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	int write;
 	size_t len;
 	struct blk_plug plug;
+#ifdef CONFIG_POPCORN
+	unsigned long start_orig = start;
+	size_t len_orig = len_in;
+#endif
+
 
 	if (!madvise_behavior_valid(behavior))
 		return error;
@@ -893,5 +929,20 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	else
 		up_read(&current->mm->mmap_sem);
 
+#ifdef CONFIG_POPCORN
+	if (distributed_remote_process(current)) {
+		error = vma_server_madvise_remote(start_orig, len_orig, behavior);
+		if (error)
+			return error;
+	}
+#endif
+
 	return error;
 }
+
+#ifdef CONFIG_POPCORN
+long ksys_madvise(unsigned long start, size_t len, int behavior)
+{
+	return __do_sys_madvise(start, len, behavior);
+}
+#endif
diff --git a/mm/memory.c b/mm/memory.c
index ddf20bd0c..dd972a6a1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -81,6 +81,11 @@
 #include <asm/pgtable.h>
 
 #include "internal.h"
+#ifdef CONFIG_POPCORN
+#include <linux/delay.h>
+#include <popcorn/page_server.h>
+#include <popcorn/process_server.h>
+#endif
 
 #if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
@@ -1059,6 +1064,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		pte_t ptent = *pte;
 		if (pte_none(ptent))
 			continue;
+#ifdef CONFIG_POPCORN
+		page_server_zap_pte(vma, addr, pte, &ptent);
+#endif
 
 		if (pte_present(ptent)) {
 			struct page *page;
@@ -3889,7 +3897,29 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			vmf->pte = NULL;
 		}
 	}
+#ifdef CONFIG_POPCORN
+	if (distributed_process(current)) {
+		int ret;
+		if (pmd_none(*vmf->pmd)) {
+			if (__pte_alloc(vmf->vma->vm_mm, vmf->pmd))
+				return VM_FAULT_OOM;
+		}
 
+		ret = page_server_handle_pte_fault(vmf);
+		if (ret == VM_FAULT_RETRY) {
+			int backoff = ++current->backoff_weight;
+			PGPRINTK("  [%d] backoff %d\n", current->pid, backoff);
+			if (backoff <= 10) {
+				udelay(backoff * 100);
+			} else {
+				msleep(backoff - 10);
+			}
+		} else {
+			current->backoff_weight /= 2;
+		}
+		if (ret != VM_FAULT_CONTINUE) return ret;
+	}
+#endif
 	if (!vmf->pte) {
 		if (vma_is_anonymous(vmf->vma))
 			return do_anonymous_page(vmf);
@@ -3897,8 +3927,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
-	if (!pte_present(vmf->orig_pte))
+	if (!pte_present(vmf->orig_pte)) {
+#ifdef CONFIG_POPCORN
+		page_server_panic(true, vmf->vma->vm_mm,
+				  vmf->address, vmf->pte, entry);
+#endif
 		return do_swap_page(vmf);
+	}
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
@@ -3932,6 +3967,164 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+#ifdef CONFIG_POPCORN
+struct page *get_normal_page(struct vm_area_struct *vma, unsigned long addr, pte_t *pte)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct mem_cgroup *memcg;
+	struct page *page;
+	pte_t entry = *pte;
+
+	if ((page = vm_normal_page(vma, addr, entry)))
+		return page;
+
+	BUG_ON(!is_zero_pfn(pte_pfn(entry)) && "Cannot handle this special page");
+
+	page = alloc_zeroed_user_highpage_movable(vma, addr);
+	if (!page)
+		return NULL;
+
+	if (mem_cgroup_try_charge(page, mm, GFP_KERNEL, &memcg, false)) {
+		put_page(page);
+		return NULL;
+	}
+
+	__SetPageUptodate(page);
+
+	entry = mk_pte(page, vma->vm_page_prot);
+	if (vma->vm_flags & VM_WRITE)
+		entry = pte_mkwrite(pte_mkdirty(entry));
+
+	inc_mm_counter_fast(mm, MM_ANONPAGES);
+	page_add_new_anon_rmap(page, vma, addr, false);
+	mem_cgroup_commit_charge(page, memcg, false, false);
+	lru_cache_add_active_or_unevictable(page, vma);
+
+	set_pte_at_notify(mm, addr, pte, entry);
+	update_mmu_cache(vma, addr, pte);
+	flush_tlb_page(vma, addr);
+
+	return page;
+}
+
+int handle_pte_fault_origin(struct mm_struct *mm, struct vm_area_struct *vma,
+			    unsigned long address,
+			    pte_t *pte, pmd_t *pmd, unsigned int flags)
+{
+	struct mem_cgroup *memcg;
+	struct page *page;
+	spinlock_t *ptl;
+	pte_t entry = *pte;
+	struct vm_fault vmf = {
+		.vma = vma,
+		.address = address & PAGE_MASK,
+		.flags = flags,
+		.pgoff = linear_page_index(vma, address),
+		.gfp_mask = __get_fault_gfp_mask(vma),
+	};
+
+	barrier();
+
+	/* TODO this is broken, vmd is not populated. And cast probably breaks things */
+	if (!vma_is_anonymous(vma))
+	  return do_fault(&vmf);
+
+	/**
+	 * Following is for anonymous page. Almost same to do_anonymos_page
+	 * except it allocates page upon read
+	 */
+	pte_unmap(pte);
+
+	if (vma->vm_flags & VM_SHARED) return VM_FAULT_SIGBUS;
+
+	if (unlikely(anon_vma_prepare(vma)))
+		return VM_FAULT_OOM;
+
+	page = alloc_zeroed_user_highpage_movable(vma, address);
+	if (!page)
+		return VM_FAULT_OOM;
+
+	if (mem_cgroup_try_charge(page, mm, GFP_KERNEL, &memcg, false)) {
+		put_page(page);
+		return VM_FAULT_OOM;
+	}
+
+	__SetPageUptodate(page);
+
+	entry = mk_pte(page, vma->vm_page_prot);
+	if (vma->vm_flags & VM_WRITE)
+		entry = pte_mkwrite(pte_mkdirty(entry));
+
+	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+	if (!pte_none(*pte)) {
+		/* Somebody already attached a page */
+		mem_cgroup_cancel_charge(page, memcg, false);
+		put_page(page);
+	} else {
+		inc_mm_counter_fast(mm, MM_ANONPAGES);
+		page_add_new_anon_rmap(page, vma, address, false);
+		mem_cgroup_commit_charge(page, memcg, false, false);
+		lru_cache_add_active_or_unevictable(page, vma);
+
+		set_pte_at(mm, address, pte, entry);
+		/* No need to invalidate - it was non-present before */
+		update_mmu_cache(vma, address, pte);
+	}
+	pte_unmap_unlock(pte, ptl);
+	return 0;
+}
+
+int cow_file_at_origin(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, pte_t *pte)
+{
+	struct page *new_page, *old_page;
+	struct mem_cgroup *memcg;
+	pte_t entry;
+
+	/**
+	 * Following is very similar to do_wp_page() and wp_page_copy()
+	 */
+	if (anon_vma_prepare(vma))
+		return VM_FAULT_OOM;
+
+	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, addr);
+	if (!new_page) return VM_FAULT_OOM;
+
+	if (mem_cgroup_try_charge(new_page, mm, GFP_KERNEL, &memcg, false)) {
+		put_page(new_page);
+		return VM_FAULT_OOM;
+	}
+
+	old_page = vm_normal_page(vma, addr, *pte);
+	BUG_ON(!old_page);
+	BUG_ON(PageAnon(old_page));
+
+	get_page(old_page);
+
+	copy_user_highpage(new_page, old_page, addr, vma);
+	__SetPageUptodate(new_page);
+
+	dec_mm_counter_fast(mm, MM_FILEPAGES);
+	inc_mm_counter_fast(mm, MM_ANONPAGES);
+
+	flush_cache_page(vma, addr, pte_pfn(*pte));
+	entry = mk_pte(new_page, vma->vm_page_prot);
+	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+
+	ptep_clear_flush_notify(vma, addr, pte);
+	page_add_new_anon_rmap(new_page, vma, addr, false);
+	mem_cgroup_commit_charge(new_page, memcg, false, false);
+	lru_cache_add_active_or_unevictable(new_page, vma);
+
+	set_pte_at_notify(mm, addr, pte, entry);
+	update_mmu_cache(vma, addr, pte);
+
+	page_remove_rmap(old_page, false);
+	put_page(old_page);
+
+	return 0;
+}
+#endif /* CONFIG_POPCORN */
+
 /*
  * By the time we get here, we already hold the mm semaphore
  *
diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae..9d25692e5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -53,6 +53,12 @@
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
 
+#ifdef CONFIG_POPCORN
+#include <popcorn/bundle.h>
+#include <popcorn/types.h>
+#include <popcorn/vma_server.h>
+#endif
+
 #include "internal.h"
 
 #ifndef arch_mmap_check
@@ -200,6 +206,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool populate;
 	bool downgraded = false;
 	LIST_HEAD(uf);
+#ifdef CONFIG_POPCORN
+	if (distributed_remote_process(current)) {
+		while (!down_write_trylock(&mm->mmap_sem))
+			schedule();
+	}
+#endif
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
@@ -281,6 +293,13 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
+#ifdef CONFIG_POPCORN
+	if (distributed_remote_process(current)) {
+		if (vma_server_brk_remote(oldbrk, brk)) {
+			return brk;
+		}
+	}
+#endif
 	return brk;
 
 out:
@@ -289,6 +308,13 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return retval;
 }
 
+#ifdef CONFIG_POPCORN
+long ksys_brk(unsigned long addr)
+{
+	return __do_sys_brk(addr);
+}
+#endif
+
 static long vma_compute_subtree_gap(struct vm_area_struct *vma)
 {
 	unsigned long max, prev_end, subtree_gap;
@@ -1607,6 +1633,12 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 	}
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+#ifdef CONFIG_POPCORN
+	if (distributed_remote_process(current)) {
+		retval = vma_server_mmap_remote(file, addr, len, prot, flags, pgoff);
+		goto out_fput;
+	}
+#endif
 
 	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 out_fput:
@@ -2846,9 +2878,20 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 	int ret;
 	struct mm_struct *mm = current->mm;
 	LIST_HEAD(uf);
+#ifdef CONFIG_POPCORN
+	if (distributed_process(current)) {
+		while (!down_write_trylock(&mm->mmap_sem))
+			schedule();
+	} else {
+		if (down_write_killable(&mm->mmap_sem))
+			return -EINTR;
+
+	}
+#else
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
+#endif
 
 	ret = __do_munmap(mm, start, len, &uf, downgrade);
 	/*
@@ -2875,6 +2918,16 @@ EXPORT_SYMBOL(vm_munmap);
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
 	profile_munmap(addr);
+
+#ifdef CONFIG_POPCORN
+	if (unlikely(distributed_process(current))) {
+		if (current->at_remote) {
+			return vma_server_munmap_remote(addr, len);
+		} else {
+			return vma_server_munmap_origin(addr, len, my_nid);
+		}
+	}
+#endif
 	return __vm_munmap(addr, len, true);
 }
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index bf38dfbbb..d78e9dbc5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -24,6 +24,11 @@
 #include <linux/mmu_notifier.h>
 #include <linux/migrate.h>
 #include <linux/perf_event.h>
+#ifdef CONFIG_POPCORN
+#include <popcorn/types.h>
+#include <popcorn/vma_server.h>
+#endif
+
 #include <linux/pkeys.h>
 #include <linux/ksm.h>
 #include <linux/uaccess.h>
@@ -479,7 +484,13 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		return -ENOMEM;
 	if (!arch_validate_prot(prot, start))
 		return -EINVAL;
-
+#ifdef CONFIG_POPCORN
+	if (distributed_remote_process(current)) {
+		error = vma_server_mprotect_remote(start, len, prot);
+		if (error)
+			return error;
+	}
+#endif
 	reqprot = prot;
 
 	if (down_write_killable(&current->mm->mmap_sem))
@@ -582,6 +593,14 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 	return do_mprotect_pkey(start, len, prot, -1);
 }
 
+#ifdef CONFIG_POPCORN
+long ksys_mprotect(unsigned long start, size_t len,
+		  unsigned long prot)
+{
+        return __do_sys_mprotect(start, len, prot);
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
 SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
diff --git a/mm/mremap.c b/mm/mremap.c
index fc241d23c..3d9e26352 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -30,6 +30,11 @@
 
 #include "internal.h"
 
+#ifdef CONFIG_POPCORN
+#include <popcorn/types.h>
+#include <popcorn/vma_server.h>
+#endif
+
 static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -617,6 +622,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 
 	old_len = PAGE_ALIGN(old_len);
 	new_len = PAGE_ALIGN(new_len);
+#ifdef CONFIG_POPCORN
+	if (distributed_remote_process(current)) {
+		vma_server_mremap_remote(addr, old_len, new_len, flags, new_addr);
+	}
+#endif
+
 
 	/*
 	 * We allow a zero old-len as a special case
@@ -727,3 +738,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	userfaultfd_unmap_complete(mm, &uf_unmap);
 	return ret;
 }
+
+#ifdef CONFIG_POPCORN
+long ksys_mremap(unsigned long addr,
+		 unsigned long old_len, unsigned long new_len,
+		 unsigned long flags, unsigned long new_addr)
+{
+        return __do_sys_mremap(addr, old_len, new_len, flags, new_addr);
+}
+#endif
-- 
2.17.1

