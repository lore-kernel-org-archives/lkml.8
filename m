Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E62C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDA820738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgFVXr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:47:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54753 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgFVXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:06 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8Z-0005DO-Ny; Mon, 22 Jun 2020 23:46:03 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-m68k@lists.linux-m68k.org, x86@kernel.org
Subject: [PATCH 01/17] fork: fold legacy_clone_args_valid() into _do_fork()
Date:   Tue, 23 Jun 2020 01:43:10 +0200
Message-Id: <20200622234326.906346-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This separate helper only existed to guarantee the mutual exclusivity of
CLONE_PIDFD and CLONE_PARENT_SETTID for legacy clone since CLONE_PIDFD
abuses the parent_tid field to return the pidfd. But we can actually handle
this uniformely thus removing the helper. For legacy clone we can detect
that CLONE_PIDFD is specified in conjunction with CLONE_PARENT_SETTID
because they will share the same memory which is invalid and for clone3()
setting the separate pidfd and parent_tid fields to the same memory is
bogus as well. So fold that helper directly into _do_fork() by detecting
this case.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: x86@kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/m68k/kernel/process.c |  3 ---
 arch/x86/kernel/sys_ia32.c |  3 ---
 include/linux/sched/task.h |  1 -
 kernel/fork.c              | 30 ++++++++++++++----------------
 4 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 90ae376b7ab1..0608439ba452 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -125,9 +125,6 @@ asmlinkage int m68k_clone(struct pt_regs *regs)
 		.tls		= regs->d5,
 	};
 
-	if (!legacy_clone_args_valid(&args))
-		return -EINVAL;
-
 	return _do_fork(&args);
 }
 
diff --git a/arch/x86/kernel/sys_ia32.c b/arch/x86/kernel/sys_ia32.c
index f8d65c99feb8..720cde885042 100644
--- a/arch/x86/kernel/sys_ia32.c
+++ b/arch/x86/kernel/sys_ia32.c
@@ -251,9 +251,6 @@ COMPAT_SYSCALL_DEFINE5(ia32_clone, unsigned long, clone_flags,
 		.tls		= tls_val,
 	};
 
-	if (!legacy_clone_args_valid(&args))
-		return -EINVAL;
-
 	return _do_fork(&args);
 }
 #endif /* CONFIG_IA32_EMULATION */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 38359071236a..ddce0ea515d1 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -96,7 +96,6 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern long _do_fork(struct kernel_clone_args *kargs);
-extern bool legacy_clone_args_valid(const struct kernel_clone_args *kargs);
 extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..9875aeb2ba41 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2422,6 +2422,20 @@ long _do_fork(struct kernel_clone_args *args)
 	int trace = 0;
 	long nr;
 
+	/*
+	 * For legacy clone() calls, CLONE_PIDFD uses the parent_tid argument
+	 * to return the pidfd. Hence, CLONE_PIDFD and CLONE_PARENT_SETTID are
+	 * mutually exclusive. With clone3() CLONE_PIDFD has grown a separate
+	 * field in struct clone_args and it still doesn't make sense to have
+	 * them both point at the same memory location. Performing this check
+	 * here has the advantage that we don't need to have a separate helper
+	 * to check for legacy clone().
+	 */
+	if ((args->flags & CLONE_PIDFD) &&
+	    (args->flags & CLONE_PARENT_SETTID) &&
+	    (args->pidfd == args->parent_tid))
+		return -EINVAL;
+
 	/*
 	 * Determine whether and which event to report to ptracer.  When
 	 * called from kernel_thread or CLONE_UNTRACED is explicitly
@@ -2479,16 +2493,6 @@ long _do_fork(struct kernel_clone_args *args)
 	return nr;
 }
 
-bool legacy_clone_args_valid(const struct kernel_clone_args *kargs)
-{
-	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
-	if ((kargs->flags & CLONE_PIDFD) &&
-	    (kargs->flags & CLONE_PARENT_SETTID))
-		return false;
-
-	return true;
-}
-
 #ifndef CONFIG_HAVE_COPY_THREAD_TLS
 /* For compatibility with architectures that call do_fork directly rather than
  * using the syscall entry points below. */
@@ -2508,9 +2512,6 @@ long do_fork(unsigned long clone_flags,
 		.stack_size	= stack_size,
 	};
 
-	if (!legacy_clone_args_valid(&args))
-		return -EINVAL;
-
 	return _do_fork(&args);
 }
 #endif
@@ -2593,9 +2594,6 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 		.tls		= tls,
 	};
 
-	if (!legacy_clone_args_valid(&args))
-		return -EINVAL;
-
 	return _do_fork(&args);
 }
 #endif
-- 
2.27.0

