Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C7B20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgF3ElK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgF3ElJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:41:09 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:41:09 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq84y-002aAs-5g; Tue, 30 Jun 2020 04:41:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 1/7] unexport linux/elfcore.h
Date:   Tue, 30 Jun 2020 05:41:02 +0100
Message-Id: <20200630044108.615673-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200630043641.GD2786714@ZenIV.linux.org.uk>
References: <20200630043641.GD2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

It's unusable from userland - it uses elf_gregset_t, which is not
provided by exported headers.  glibc has it in sys/procfs.h, but
the same file defines struct elf_prstatus, so linux/elfcore.h can't
be included once sys/procfs.h has been pulled.  Same goes for uclibc
and dietlibc simply doesn't have elf_gregset_t defined anywhere.

IOW, no userland source is including that thing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/elfcore.h      |  69 +++++++++++++++++++++++++++--
 include/uapi/linux/elfcore.h | 101 -------------------------------------------
 scripts/headers_install.sh   |   1 -
 usr/include/Makefile         |   1 -
 4 files changed, 66 insertions(+), 106 deletions(-)
 delete mode 100644 include/uapi/linux/elfcore.h

diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 4cad0e784b28..96ab215dad2d 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -5,12 +5,75 @@
 #include <linux/user.h>
 #include <linux/bug.h>
 #include <linux/sched/task_stack.h>
-
-#include <asm/elf.h>
-#include <uapi/linux/elfcore.h>
+#include <linux/types.h>
+#include <linux/signal.h>
+#include <linux/time.h>
+#include <linux/ptrace.h>
+#include <linux/fs.h>
+#include <linux/elf.h>
 
 struct coredump_params;
 
+struct elf_siginfo
+{
+	int	si_signo;			/* signal number */
+	int	si_code;			/* extra code */
+	int	si_errno;			/* errno */
+};
+
+/*
+ * Definitions to generate Intel SVR4-like core files.
+ * These mostly have the same names as the SVR4 types with "elf_"
+ * tacked on the front to prevent clashes with linux definitions,
+ * and the typedef forms have been avoided.  This is mostly like
+ * the SVR4 structure, but more Linuxy, with things that Linux does
+ * not support and which gdb doesn't really use excluded.
+ */
+struct elf_prstatus
+{
+	struct elf_siginfo pr_info;	/* Info associated with signal */
+	short	pr_cursig;		/* Current signal */
+	unsigned long pr_sigpend;	/* Set of pending signals */
+	unsigned long pr_sighold;	/* Set of held signals */
+	pid_t	pr_pid;
+	pid_t	pr_ppid;
+	pid_t	pr_pgrp;
+	pid_t	pr_sid;
+	struct __kernel_old_timeval pr_utime;	/* User time */
+	struct __kernel_old_timeval pr_stime;	/* System time */
+	struct __kernel_old_timeval pr_cutime;	/* Cumulative user time */
+	struct __kernel_old_timeval pr_cstime;	/* Cumulative system time */
+	elf_gregset_t pr_reg;	/* GP registers */
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	/* When using FDPIC, the loadmap addresses need to be communicated
+	 * to GDB in order for GDB to do the necessary relocations.  The
+	 * fields (below) used to communicate this information are placed
+	 * immediately after ``pr_reg'', so that the loadmap addresses may
+	 * be viewed as part of the register set if so desired.
+	 */
+	unsigned long pr_exec_fdpic_loadmap;
+	unsigned long pr_interp_fdpic_loadmap;
+#endif
+	int pr_fpvalid;		/* True if math co-processor being used.  */
+};
+
+#define ELF_PRARGSZ	(80)	/* Number of chars for args */
+
+struct elf_prpsinfo
+{
+	char	pr_state;	/* numeric process state */
+	char	pr_sname;	/* char for pr_state */
+	char	pr_zomb;	/* zombie */
+	char	pr_nice;	/* nice val */
+	unsigned long pr_flag;	/* flags */
+	__kernel_uid_t	pr_uid;
+	__kernel_gid_t	pr_gid;
+	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
+	/* Lots missing */
+	char	pr_fname[16];	/* filename of executable */
+	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
+};
+
 static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
 {
 #ifdef ELF_CORE_COPY_REGS
diff --git a/include/uapi/linux/elfcore.h b/include/uapi/linux/elfcore.h
deleted file mode 100644
index baf03562306d..000000000000
--- a/include/uapi/linux/elfcore.h
+++ /dev/null
@@ -1,101 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_ELFCORE_H
-#define _UAPI_LINUX_ELFCORE_H
-
-#include <linux/types.h>
-#include <linux/signal.h>
-#include <linux/time.h>
-#include <linux/ptrace.h>
-#include <linux/elf.h>
-#include <linux/fs.h>
-
-struct elf_siginfo
-{
-	int	si_signo;			/* signal number */
-	int	si_code;			/* extra code */
-	int	si_errno;			/* errno */
-};
-
-
-#ifndef __KERNEL__
-typedef elf_greg_t greg_t;
-typedef elf_gregset_t gregset_t;
-typedef elf_fpregset_t fpregset_t;
-typedef elf_fpxregset_t fpxregset_t;
-#define NGREG ELF_NGREG
-#endif
-
-/*
- * Definitions to generate Intel SVR4-like core files.
- * These mostly have the same names as the SVR4 types with "elf_"
- * tacked on the front to prevent clashes with linux definitions,
- * and the typedef forms have been avoided.  This is mostly like
- * the SVR4 structure, but more Linuxy, with things that Linux does
- * not support and which gdb doesn't really use excluded.
- * Fields present but not used are marked with "XXX".
- */
-struct elf_prstatus
-{
-#if 0
-	long	pr_flags;	/* XXX Process flags */
-	short	pr_why;		/* XXX Reason for process halt */
-	short	pr_what;	/* XXX More detailed reason */
-#endif
-	struct elf_siginfo pr_info;	/* Info associated with signal */
-	short	pr_cursig;		/* Current signal */
-	unsigned long pr_sigpend;	/* Set of pending signals */
-	unsigned long pr_sighold;	/* Set of held signals */
-#if 0
-	struct sigaltstack pr_altstack;	/* Alternate stack info */
-	struct sigaction pr_action;	/* Signal action for current sig */
-#endif
-	pid_t	pr_pid;
-	pid_t	pr_ppid;
-	pid_t	pr_pgrp;
-	pid_t	pr_sid;
-	struct __kernel_old_timeval pr_utime;	/* User time */
-	struct __kernel_old_timeval pr_stime;	/* System time */
-	struct __kernel_old_timeval pr_cutime;	/* Cumulative user time */
-	struct __kernel_old_timeval pr_cstime;	/* Cumulative system time */
-#if 0
-	long	pr_instr;		/* Current instruction */
-#endif
-	elf_gregset_t pr_reg;	/* GP registers */
-#ifdef CONFIG_BINFMT_ELF_FDPIC
-	/* When using FDPIC, the loadmap addresses need to be communicated
-	 * to GDB in order for GDB to do the necessary relocations.  The
-	 * fields (below) used to communicate this information are placed
-	 * immediately after ``pr_reg'', so that the loadmap addresses may
-	 * be viewed as part of the register set if so desired.
-	 */
-	unsigned long pr_exec_fdpic_loadmap;
-	unsigned long pr_interp_fdpic_loadmap;
-#endif
-	int pr_fpvalid;		/* True if math co-processor being used.  */
-};
-
-#define ELF_PRARGSZ	(80)	/* Number of chars for args */
-
-struct elf_prpsinfo
-{
-	char	pr_state;	/* numeric process state */
-	char	pr_sname;	/* char for pr_state */
-	char	pr_zomb;	/* zombie */
-	char	pr_nice;	/* nice val */
-	unsigned long pr_flag;	/* flags */
-	__kernel_uid_t	pr_uid;
-	__kernel_gid_t	pr_gid;
-	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
-	/* Lots missing */
-	char	pr_fname[16];	/* filename of executable */
-	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
-};
-
-#ifndef __KERNEL__
-typedef struct elf_prstatus prstatus_t;
-typedef struct elf_prpsinfo prpsinfo_t;
-#define PRARGSZ ELF_PRARGSZ 
-#endif
-
-
-#endif /* _UAPI_LINUX_ELFCORE_H */
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 955cf3aedf21..9314247bb222 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -86,7 +86,6 @@ arch/x86/include/uapi/asm/auxvec.h:CONFIG_X86_64
 arch/x86/include/uapi/asm/mman.h:CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 include/uapi/asm-generic/fcntl.h:CONFIG_64BIT
 include/uapi/linux/atmdev.h:CONFIG_COMPAT
-include/uapi/linux/elfcore.h:CONFIG_BINFMT_ELF_FDPIC
 include/uapi/linux/eventpoll.h:CONFIG_PM_SLEEP
 include/uapi/linux/hw_breakpoint.h:CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
 include/uapi/linux/pktcdvd.h:CONFIG_CDROM_PKTCDVD_WCACHE
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 55362f3ab393..f6b3c85d900e 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -28,7 +28,6 @@ no-header-test += linux/am437x-vpfe.h
 no-header-test += linux/android/binder.h
 no-header-test += linux/android/binderfs.h
 no-header-test += linux/coda.h
-no-header-test += linux/elfcore.h
 no-header-test += linux/errqueue.h
 no-header-test += linux/fsmap.h
 no-header-test += linux/hdlc/ioctl.h
-- 
2.11.0

