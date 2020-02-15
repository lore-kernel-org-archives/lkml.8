Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A393FC2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AC0246A1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBOImo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 03:42:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgBOImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 03:42:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j2t1Q-0005Kj-BF; Sat, 15 Feb 2020 09:41:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 535701C205E;
        Sat, 15 Feb 2020 09:41:54 +0100 (CET)
Date:   Sat, 15 Feb 2020 08:41:54 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools include UAPI: Sync x86's syscalls_64.tbl,
 generic unistd.h and fcntl.h to pick up openat2 and pidfd_getfd
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158175611405.13786.14264078224920446308.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c452833387624d1990c9bbb0ee1e98c10c147478
Gitweb:        https://git.kernel.org/tip/c452833387624d1990c9bbb0ee1e98c10c147478
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 11 Feb 2020 11:58:56 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 11 Feb 2020 16:41:06 -03:00

tools include UAPI: Sync x86's syscalls_64.tbl, generic unistd.h and fcntl.h to pick up openat2 and pidfd_getfd

  fddb5d430ad9 ("open: introduce openat2(2) syscall")
  9a2cef09c801 ("arch: wire up pidfd_getfd syscall")

We also need to grab a copy of uapi/linux/openat2.h since it is now
needed by fcntl.h, add it to tools/perf/check_headers.h.

  $ diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  --- tools/perf/arch/x86/entry/syscalls/syscall_64.tbl	2019-12-20 16:43:57.662429958 -0300
  +++ arch/x86/entry/syscalls/syscall_64.tbl	2020-02-10 16:36:22.070012468 -0300
  @@ -357,6 +357,8 @@
   433	common	fspick			__x64_sys_fspick
   434	common	pidfd_open		__x64_sys_pidfd_open
   435	common	clone3			__x64_sys_clone3/ptregs
  +437	common	openat2			__x64_sys_openat2
  +438	common	pidfd_getfd		__x64_sys_pidfd_getfd

   #
   # x32-specific system call numbers start at 512 to avoid cache impact
  $

Update tools/'s copy of that file:

  $ cp arch/x86/entry/syscalls/syscall_64.tbl tools/perf/arch/x86/entry/syscalls/syscall_64.tbl

See the result:

  $ diff -u /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
  --- /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before	2020-02-10 16:42:59.010636041 -0300
  +++ /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c	2020-02-10 16:43:24.149958337 -0300
  @@ -346,5 +346,7 @@
   	[433] = "fspick",
   	[434] = "pidfd_open",
   	[435] = "clone3",
  +	[437] = "openat2",
  +	[438] = "pidfd_getfd",
   };
  -#define SYSCALLTBL_x86_64_MAX_ID 435
  +#define SYSCALLTBL_x86_64_MAX_ID 438
  $

Now one can use:

  perf trace -e openat2,pidfd_getfd

To get just those syscalls or use in things like:

  perf trace -e open*

To get all the open variant (open, openat, openat2, etc) or:

  perf trace pidfd*

To get the pidfd syscalls.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h           |  7 ++-
 tools/include/uapi/linux/fcntl.h                  |  2 +-
 tools/include/uapi/linux/openat2.h                | 39 ++++++++++++++-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |  2 +-
 tools/perf/check-headers.sh                       |  1 +-
 5 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/uapi/linux/openat2.h

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 1fc8faa..3a3201e 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -851,8 +851,13 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
 
+#define __NR_openat2 437
+__SYSCALL(__NR_openat2, sys_openat2)
+#define __NR_pidfd_getfd 438
+__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+
 #undef __NR_syscalls
-#define __NR_syscalls 436
+#define __NR_syscalls 439
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 1f97b33..ca88b7b 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_FCNTL_H
 
 #include <asm/fcntl.h>
+#include <linux/openat2.h>
 
 #define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
 #define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
@@ -100,5 +101,4 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
-
 #endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/tools/include/uapi/linux/openat2.h b/tools/include/uapi/linux/openat2.h
new file mode 100644
index 0000000..58b1eb7
--- /dev/null
+++ b/tools/include/uapi/linux/openat2.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_OPENAT2_H
+#define _UAPI_LINUX_OPENAT2_H
+
+#include <linux/types.h>
+
+/*
+ * Arguments for how openat2(2) should open the target path. If only @flags and
+ * @mode are non-zero, then openat2(2) operates very similarly to openat(2).
+ *
+ * However, unlike openat(2), unknown or invalid bits in @flags result in
+ * -EINVAL rather than being silently ignored. @mode must be zero unless one of
+ * {O_CREAT, O_TMPFILE} are set.
+ *
+ * @flags: O_* flags.
+ * @mode: O_CREAT/O_TMPFILE file mode.
+ * @resolve: RESOLVE_* flags.
+ */
+struct open_how {
+	__u64 flags;
+	__u64 mode;
+	__u64 resolve;
+};
+
+/* how->resolve flags for openat2(2). */
+#define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
+					(includes bind-mounts). */
+#define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
+					"magic-links". */
+#define RESOLVE_NO_SYMLINKS	0x04 /* Block traversal through all symlinks
+					(implies OEXT_NO_MAGICLINKS) */
+#define RESOLVE_BENEATH		0x08 /* Block "lexical" trickery like
+					"..", symlinks, and absolute
+					paths which escape the dirfd. */
+#define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
+					be scoped inside the dirfd
+					(similar to chroot(2)). */
+
+#endif /* _UAPI_LINUX_OPENAT2_H */
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c29976e..44d510b 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -357,6 +357,8 @@
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
 435	common	clone3			__x64_sys_clone3/ptregs
+437	common	openat2			__x64_sys_openat2
+438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 68039a9..bfb21d0 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -13,6 +13,7 @@ include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
 include/uapi/linux/mount.h
+include/uapi/linux/openat2.h
 include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
 include/uapi/linux/sched.h
