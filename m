Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC841C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12CF20781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgCUPba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:31:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38889 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgCUPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg53-0004yU-9j; Sat, 21 Mar 2020 16:30:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DA2CD1C22E5;
        Sat, 21 Mar 2020 16:30:32 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:32 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Use IA32-specific wrappers for
 syscalls taking 64-bit arguments
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-16-brgerst@gmail.com>
References: <20200313195144.164260-16-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463257.28353.7220752053626182323.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     121b32a58a3af89a780cf194ce3769fc4120e574
Gitweb:        https://git.kernel.org/tip/121b32a58a3af89a780cf194ce3769fc4120e574
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:41 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:24 +01:00

x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments

For the 32-bit syscall interface, 64-bit arguments (loff_t) are passed via
a pair of 32-bit registers.  These register pairs end up in consecutive stack
slots, which matches the C ABI for 64-bit arguments.  But when accessing the
registers directly from pt_regs, the wrapper needs to manually reassemble the
64-bit value.  These wrappers already exist for 32-bit compat, so make them
available to 32-bit native in preparation for enabling pt_regs-based syscalls.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Link: https://lkml.kernel.org/r/20200313195144.164260-16-brgerst@gmail.com

---
 arch/x86/entry/syscalls/syscall_32.tbl |  18 +-
 arch/x86/ia32/Makefile                 |   2 +-
 arch/x86/ia32/sys_ia32.c               | 254 +------------------------
 arch/x86/kernel/Makefile               |   2 +-
 arch/x86/kernel/sys_ia32.c             | 255 ++++++++++++++++++++++++-
 arch/x86/um/Makefile                   |   1 +-
 6 files changed, 268 insertions(+), 264 deletions(-)
 delete mode 100644 arch/x86/ia32/sys_ia32.c
 create mode 100644 arch/x86/kernel/sys_ia32.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0b8e24c..54581ac 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -191,8 +191,8 @@
 177	i386	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
 178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 179	i386	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
-180	i386	pread64			sys_pread64			compat_sys_ia32_pread64
-181	i386	pwrite64		sys_pwrite64			compat_sys_ia32_pwrite64
+180	i386	pread64			sys_ia32_pread64
+181	i386	pwrite64		sys_ia32_pwrite64
 182	i386	chown			sys_chown16
 183	i386	getcwd			sys_getcwd
 184	i386	capget			sys_capget
@@ -204,8 +204,8 @@
 190	i386	vfork			sys_vfork
 191	i386	ugetrlimit		sys_getrlimit			compat_sys_getrlimit
 192	i386	mmap2			sys_mmap_pgoff
-193	i386	truncate64		sys_truncate64			compat_sys_ia32_truncate64
-194	i386	ftruncate64		sys_ftruncate64			compat_sys_ia32_ftruncate64
+193	i386	truncate64		sys_ia32_truncate64
+194	i386	ftruncate64		sys_ia32_ftruncate64
 195	i386	stat64			sys_stat64			compat_sys_ia32_stat64
 196	i386	lstat64			sys_lstat64			compat_sys_ia32_lstat64
 197	i386	fstat64			sys_fstat64			compat_sys_ia32_fstat64
@@ -236,7 +236,7 @@
 # 222 is unused
 # 223 is unused
 224	i386	gettid			sys_gettid
-225	i386	readahead		sys_readahead			compat_sys_ia32_readahead
+225	i386	readahead		sys_ia32_readahead
 226	i386	setxattr		sys_setxattr
 227	i386	lsetxattr		sys_lsetxattr
 228	i386	fsetxattr		sys_fsetxattr
@@ -261,7 +261,7 @@
 247	i386	io_getevents		sys_io_getevents_time32
 248	i386	io_submit		sys_io_submit			compat_sys_io_submit
 249	i386	io_cancel		sys_io_cancel
-250	i386	fadvise64		sys_fadvise64			compat_sys_ia32_fadvise64
+250	i386	fadvise64		sys_ia32_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
 252	i386	exit_group		sys_exit_group
 253	i386	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
@@ -283,7 +283,7 @@
 269	i386	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
 270	i386	tgkill			sys_tgkill
 271	i386	utimes			sys_utimes_time32
-272	i386	fadvise64_64		sys_fadvise64_64		compat_sys_ia32_fadvise64_64
+272	i386	fadvise64_64		sys_ia32_fadvise64_64
 273	i386	vserver
 274	i386	mbind			sys_mbind
 275	i386	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
@@ -325,7 +325,7 @@
 311	i386	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
 312	i386	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
 313	i386	splice			sys_splice
-314	i386	sync_file_range		sys_sync_file_range		compat_sys_ia32_sync_file_range
+314	i386	sync_file_range		sys_ia32_sync_file_range
 315	i386	tee			sys_tee
 316	i386	vmsplice		sys_vmsplice			compat_sys_vmsplice
 317	i386	move_pages		sys_move_pages			compat_sys_move_pages
@@ -335,7 +335,7 @@
 321	i386	signalfd		sys_signalfd			compat_sys_signalfd
 322	i386	timerfd_create		sys_timerfd_create
 323	i386	eventfd			sys_eventfd
-324	i386	fallocate		sys_fallocate			compat_sys_ia32_fallocate
+324	i386	fallocate		sys_ia32_fallocate
 325	i386	timerfd_settime		sys_timerfd_settime32
 326	i386	timerfd_gettime		sys_timerfd_gettime32
 327	i386	signalfd4		sys_signalfd4			compat_sys_signalfd4
diff --git a/arch/x86/ia32/Makefile b/arch/x86/ia32/Makefile
index d13b352..8e4d039 100644
--- a/arch/x86/ia32/Makefile
+++ b/arch/x86/ia32/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the ia32 kernel emulation subsystem.
 #
 
-obj-$(CONFIG_IA32_EMULATION) := sys_ia32.o ia32_signal.o
+obj-$(CONFIG_IA32_EMULATION) := ia32_signal.o
 
 obj-$(CONFIG_IA32_AOUT) += ia32_aout.o
 
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
deleted file mode 100644
index a189dc6..0000000
--- a/arch/x86/ia32/sys_ia32.c
+++ /dev/null
@@ -1,254 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * sys_ia32.c: Conversion between 32bit and 64bit native syscalls. Based on
- *             sys_sparc32
- *
- * Copyright (C) 2000		VA Linux Co
- * Copyright (C) 2000		Don Dugger <n0ano@valinux.com>
- * Copyright (C) 1999		Arun Sharma <arun.sharma@intel.com>
- * Copyright (C) 1997,1998	Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- * Copyright (C) 1997		David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 2000		Hewlett-Packard Co.
- * Copyright (C) 2000		David Mosberger-Tang <davidm@hpl.hp.com>
- * Copyright (C) 2000,2001,2002	Andi Kleen, SuSE Labs (x86-64 port)
- *
- * These routines maintain argument size conversion between 32bit and 64bit
- * environment. In 2.5 most of this should be moved to a generic directory.
- *
- * This file assumes that there is a hole at the end of user address space.
- *
- * Some of the functions are LE specific currently. These are
- * hopefully all marked.  This should be fixed.
- */
-
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/signal.h>
-#include <linux/syscalls.h>
-#include <linux/times.h>
-#include <linux/utsname.h>
-#include <linux/mm.h>
-#include <linux/uio.h>
-#include <linux/poll.h>
-#include <linux/personality.h>
-#include <linux/stat.h>
-#include <linux/rwsem.h>
-#include <linux/compat.h>
-#include <linux/vfs.h>
-#include <linux/ptrace.h>
-#include <linux/highuid.h>
-#include <linux/sysctl.h>
-#include <linux/slab.h>
-#include <linux/sched/task.h>
-#include <asm/mman.h>
-#include <asm/types.h>
-#include <linux/uaccess.h>
-#include <linux/atomic.h>
-#include <asm/vgtod.h>
-#include <asm/ia32.h>
-
-#define AA(__x)		((unsigned long)(__x))
-
-
-COMPAT_SYSCALL_DEFINE3(ia32_truncate64, const char __user *, filename,
-		       unsigned long, offset_low, unsigned long, offset_high)
-{
-	return ksys_truncate(filename,
-			    ((loff_t) offset_high << 32) | offset_low);
-}
-
-COMPAT_SYSCALL_DEFINE3(ia32_ftruncate64, unsigned int, fd,
-		       unsigned long, offset_low, unsigned long, offset_high)
-{
-	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
-}
-
-/*
- * Another set for IA32/LFS -- x86_64 struct stat is different due to
- * support for 64bit inode numbers.
- */
-static int cp_stat64(struct stat64 __user *ubuf, struct kstat *stat)
-{
-	typeof(ubuf->st_uid) uid = 0;
-	typeof(ubuf->st_gid) gid = 0;
-	SET_UID(uid, from_kuid_munged(current_user_ns(), stat->uid));
-	SET_GID(gid, from_kgid_munged(current_user_ns(), stat->gid));
-	if (!access_ok(ubuf, sizeof(struct stat64)) ||
-	    __put_user(huge_encode_dev(stat->dev), &ubuf->st_dev) ||
-	    __put_user(stat->ino, &ubuf->__st_ino) ||
-	    __put_user(stat->ino, &ubuf->st_ino) ||
-	    __put_user(stat->mode, &ubuf->st_mode) ||
-	    __put_user(stat->nlink, &ubuf->st_nlink) ||
-	    __put_user(uid, &ubuf->st_uid) ||
-	    __put_user(gid, &ubuf->st_gid) ||
-	    __put_user(huge_encode_dev(stat->rdev), &ubuf->st_rdev) ||
-	    __put_user(stat->size, &ubuf->st_size) ||
-	    __put_user(stat->atime.tv_sec, &ubuf->st_atime) ||
-	    __put_user(stat->atime.tv_nsec, &ubuf->st_atime_nsec) ||
-	    __put_user(stat->mtime.tv_sec, &ubuf->st_mtime) ||
-	    __put_user(stat->mtime.tv_nsec, &ubuf->st_mtime_nsec) ||
-	    __put_user(stat->ctime.tv_sec, &ubuf->st_ctime) ||
-	    __put_user(stat->ctime.tv_nsec, &ubuf->st_ctime_nsec) ||
-	    __put_user(stat->blksize, &ubuf->st_blksize) ||
-	    __put_user(stat->blocks, &ubuf->st_blocks))
-		return -EFAULT;
-	return 0;
-}
-
-COMPAT_SYSCALL_DEFINE2(ia32_stat64, const char __user *, filename,
-		       struct stat64 __user *, statbuf)
-{
-	struct kstat stat;
-	int ret = vfs_stat(filename, &stat);
-
-	if (!ret)
-		ret = cp_stat64(statbuf, &stat);
-	return ret;
-}
-
-COMPAT_SYSCALL_DEFINE2(ia32_lstat64, const char __user *, filename,
-		       struct stat64 __user *, statbuf)
-{
-	struct kstat stat;
-	int ret = vfs_lstat(filename, &stat);
-	if (!ret)
-		ret = cp_stat64(statbuf, &stat);
-	return ret;
-}
-
-COMPAT_SYSCALL_DEFINE2(ia32_fstat64, unsigned int, fd,
-		       struct stat64 __user *, statbuf)
-{
-	struct kstat stat;
-	int ret = vfs_fstat(fd, &stat);
-	if (!ret)
-		ret = cp_stat64(statbuf, &stat);
-	return ret;
-}
-
-COMPAT_SYSCALL_DEFINE4(ia32_fstatat64, unsigned int, dfd,
-		       const char __user *, filename,
-		       struct stat64 __user *, statbuf, int, flag)
-{
-	struct kstat stat;
-	int error;
-
-	error = vfs_fstatat(dfd, filename, &stat, flag);
-	if (error)
-		return error;
-	return cp_stat64(statbuf, &stat);
-}
-
-/*
- * Linux/i386 didn't use to be able to handle more than
- * 4 system call parameters, so these system calls used a memory
- * block for parameter passing..
- */
-
-struct mmap_arg_struct32 {
-	unsigned int addr;
-	unsigned int len;
-	unsigned int prot;
-	unsigned int flags;
-	unsigned int fd;
-	unsigned int offset;
-};
-
-COMPAT_SYSCALL_DEFINE1(ia32_mmap, struct mmap_arg_struct32 __user *, arg)
-{
-	struct mmap_arg_struct32 a;
-
-	if (copy_from_user(&a, arg, sizeof(a)))
-		return -EFAULT;
-
-	if (a.offset & ~PAGE_MASK)
-		return -EINVAL;
-
-	return ksys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd,
-			       a.offset>>PAGE_SHIFT);
-}
-
-/* warning: next two assume little endian */
-COMPAT_SYSCALL_DEFINE5(ia32_pread64, unsigned int, fd, char __user *, ubuf,
-		       u32, count, u32, poslo, u32, poshi)
-{
-	return ksys_pread64(fd, ubuf, count,
-			    ((loff_t)AA(poshi) << 32) | AA(poslo));
-}
-
-COMPAT_SYSCALL_DEFINE5(ia32_pwrite64, unsigned int, fd, const char __user *, ubuf,
-		       u32, count, u32, poslo, u32, poshi)
-{
-	return ksys_pwrite64(fd, ubuf, count,
-			     ((loff_t)AA(poshi) << 32) | AA(poslo));
-}
-
-
-/*
- * Some system calls that need sign extended arguments. This could be
- * done by a generic wrapper.
- */
-COMPAT_SYSCALL_DEFINE6(ia32_fadvise64_64, int, fd, __u32, offset_low,
-		       __u32, offset_high, __u32, len_low, __u32, len_high,
-		       int, advice)
-{
-	return ksys_fadvise64_64(fd,
-				 (((u64)offset_high)<<32) | offset_low,
-				 (((u64)len_high)<<32) | len_low,
-				 advice);
-}
-
-COMPAT_SYSCALL_DEFINE4(ia32_readahead, int, fd, unsigned int, off_lo,
-		       unsigned int, off_hi, size_t, count)
-{
-	return ksys_readahead(fd, ((u64)off_hi << 32) | off_lo, count);
-}
-
-COMPAT_SYSCALL_DEFINE6(ia32_sync_file_range, int, fd, unsigned int, off_low,
-		       unsigned int, off_hi, unsigned int, n_low,
-		       unsigned int, n_hi, int, flags)
-{
-	return ksys_sync_file_range(fd,
-				    ((u64)off_hi << 32) | off_low,
-				    ((u64)n_hi << 32) | n_low, flags);
-}
-
-COMPAT_SYSCALL_DEFINE5(ia32_fadvise64, int, fd, unsigned int, offset_lo,
-		       unsigned int, offset_hi, size_t, len, int, advice)
-{
-	return ksys_fadvise64_64(fd, ((u64)offset_hi << 32) | offset_lo,
-				 len, advice);
-}
-
-COMPAT_SYSCALL_DEFINE6(ia32_fallocate, int, fd, int, mode,
-		       unsigned int, offset_lo, unsigned int, offset_hi,
-		       unsigned int, len_lo, unsigned int, len_hi)
-{
-	return ksys_fallocate(fd, mode, ((u64)offset_hi << 32) | offset_lo,
-			      ((u64)len_hi << 32) | len_lo);
-}
-
-/*
- * The 32-bit clone ABI is CONFIG_CLONE_BACKWARDS
- */
-COMPAT_SYSCALL_DEFINE5(ia32_clone, unsigned long, clone_flags,
-		       unsigned long, newsp, int __user *, parent_tidptr,
-		       unsigned long, tls_val, int __user *, child_tidptr)
-{
-	struct kernel_clone_args args = {
-		.flags		= (clone_flags & ~CSIGNAL),
-		.pidfd		= parent_tidptr,
-		.child_tid	= child_tidptr,
-		.parent_tid	= parent_tidptr,
-		.exit_signal	= (clone_flags & CSIGNAL),
-		.stack		= newsp,
-		.tls		= tls_val,
-	};
-
-	if (!legacy_clone_args_valid(&args))
-		return -EINVAL;
-
-	return _do_fork(&args);
-}
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 9b294c1..b8f89f7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -53,6 +53,8 @@ obj-y			+= setup.o x86_init.o i8259.o irqinit.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y			+= probe_roms.o
+obj-$(CONFIG_X86_32)	+= sys_ia32.o
+obj-$(CONFIG_IA32_EMULATION)	+= sys_ia32.o
 obj-$(CONFIG_X86_64)	+= sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
 obj-$(CONFIG_SYSFS)	+= ksysfs.o
diff --git a/arch/x86/kernel/sys_ia32.c b/arch/x86/kernel/sys_ia32.c
new file mode 100644
index 0000000..ab03fed
--- /dev/null
+++ b/arch/x86/kernel/sys_ia32.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sys_ia32.c: Conversion between 32bit and 64bit native syscalls. Based on
+ *             sys_sparc32
+ *
+ * Copyright (C) 2000		VA Linux Co
+ * Copyright (C) 2000		Don Dugger <n0ano@valinux.com>
+ * Copyright (C) 1999		Arun Sharma <arun.sharma@intel.com>
+ * Copyright (C) 1997,1998	Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+ * Copyright (C) 1997		David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 2000		Hewlett-Packard Co.
+ * Copyright (C) 2000		David Mosberger-Tang <davidm@hpl.hp.com>
+ * Copyright (C) 2000,2001,2002	Andi Kleen, SuSE Labs (x86-64 port)
+ *
+ * These routines maintain argument size conversion between 32bit and 64bit
+ * environment. In 2.5 most of this should be moved to a generic directory.
+ *
+ * This file assumes that there is a hole at the end of user address space.
+ *
+ * Some of the functions are LE specific currently. These are
+ * hopefully all marked.  This should be fixed.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/signal.h>
+#include <linux/syscalls.h>
+#include <linux/times.h>
+#include <linux/utsname.h>
+#include <linux/mm.h>
+#include <linux/uio.h>
+#include <linux/poll.h>
+#include <linux/personality.h>
+#include <linux/stat.h>
+#include <linux/rwsem.h>
+#include <linux/compat.h>
+#include <linux/vfs.h>
+#include <linux/ptrace.h>
+#include <linux/highuid.h>
+#include <linux/sysctl.h>
+#include <linux/slab.h>
+#include <linux/sched/task.h>
+#include <asm/mman.h>
+#include <asm/types.h>
+#include <linux/uaccess.h>
+#include <linux/atomic.h>
+#include <asm/vgtod.h>
+#include <asm/ia32.h>
+
+#define AA(__x)		((unsigned long)(__x))
+
+SYSCALL_DEFINE3(ia32_truncate64, const char __user *, filename,
+		unsigned long, offset_low, unsigned long, offset_high)
+{
+	return ksys_truncate(filename,
+			    ((loff_t) offset_high << 32) | offset_low);
+}
+
+SYSCALL_DEFINE3(ia32_ftruncate64, unsigned int, fd,
+		unsigned long, offset_low, unsigned long, offset_high)
+{
+	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
+}
+
+/* warning: next two assume little endian */
+SYSCALL_DEFINE5(ia32_pread64, unsigned int, fd, char __user *, ubuf,
+		u32, count, u32, poslo, u32, poshi)
+{
+	return ksys_pread64(fd, ubuf, count,
+			    ((loff_t)AA(poshi) << 32) | AA(poslo));
+}
+
+SYSCALL_DEFINE5(ia32_pwrite64, unsigned int, fd, const char __user *, ubuf,
+		u32, count, u32, poslo, u32, poshi)
+{
+	return ksys_pwrite64(fd, ubuf, count,
+			     ((loff_t)AA(poshi) << 32) | AA(poslo));
+}
+
+
+/*
+ * Some system calls that need sign extended arguments. This could be
+ * done by a generic wrapper.
+ */
+SYSCALL_DEFINE6(ia32_fadvise64_64, int, fd, __u32, offset_low,
+		__u32, offset_high, __u32, len_low, __u32, len_high,
+		int, advice)
+{
+	return ksys_fadvise64_64(fd,
+				 (((u64)offset_high)<<32) | offset_low,
+				 (((u64)len_high)<<32) | len_low,
+				 advice);
+}
+
+SYSCALL_DEFINE4(ia32_readahead, int, fd, unsigned int, off_lo,
+		unsigned int, off_hi, size_t, count)
+{
+	return ksys_readahead(fd, ((u64)off_hi << 32) | off_lo, count);
+}
+
+SYSCALL_DEFINE6(ia32_sync_file_range, int, fd, unsigned int, off_low,
+		unsigned int, off_hi, unsigned int, n_low,
+		unsigned int, n_hi, int, flags)
+{
+	return ksys_sync_file_range(fd,
+				    ((u64)off_hi << 32) | off_low,
+				    ((u64)n_hi << 32) | n_low, flags);
+}
+
+SYSCALL_DEFINE5(ia32_fadvise64, int, fd, unsigned int, offset_lo,
+		unsigned int, offset_hi, size_t, len, int, advice)
+{
+	return ksys_fadvise64_64(fd, ((u64)offset_hi << 32) | offset_lo,
+				 len, advice);
+}
+
+SYSCALL_DEFINE6(ia32_fallocate, int, fd, int, mode,
+		unsigned int, offset_lo, unsigned int, offset_hi,
+		unsigned int, len_lo, unsigned int, len_hi)
+{
+	return ksys_fallocate(fd, mode, ((u64)offset_hi << 32) | offset_lo,
+			      ((u64)len_hi << 32) | len_lo);
+}
+
+#ifdef CONFIG_IA32_EMULATION
+/*
+ * Another set for IA32/LFS -- x86_64 struct stat is different due to
+ * support for 64bit inode numbers.
+ */
+static int cp_stat64(struct stat64 __user *ubuf, struct kstat *stat)
+{
+	typeof(ubuf->st_uid) uid = 0;
+	typeof(ubuf->st_gid) gid = 0;
+	SET_UID(uid, from_kuid_munged(current_user_ns(), stat->uid));
+	SET_GID(gid, from_kgid_munged(current_user_ns(), stat->gid));
+	if (!access_ok(ubuf, sizeof(struct stat64)) ||
+	    __put_user(huge_encode_dev(stat->dev), &ubuf->st_dev) ||
+	    __put_user(stat->ino, &ubuf->__st_ino) ||
+	    __put_user(stat->ino, &ubuf->st_ino) ||
+	    __put_user(stat->mode, &ubuf->st_mode) ||
+	    __put_user(stat->nlink, &ubuf->st_nlink) ||
+	    __put_user(uid, &ubuf->st_uid) ||
+	    __put_user(gid, &ubuf->st_gid) ||
+	    __put_user(huge_encode_dev(stat->rdev), &ubuf->st_rdev) ||
+	    __put_user(stat->size, &ubuf->st_size) ||
+	    __put_user(stat->atime.tv_sec, &ubuf->st_atime) ||
+	    __put_user(stat->atime.tv_nsec, &ubuf->st_atime_nsec) ||
+	    __put_user(stat->mtime.tv_sec, &ubuf->st_mtime) ||
+	    __put_user(stat->mtime.tv_nsec, &ubuf->st_mtime_nsec) ||
+	    __put_user(stat->ctime.tv_sec, &ubuf->st_ctime) ||
+	    __put_user(stat->ctime.tv_nsec, &ubuf->st_ctime_nsec) ||
+	    __put_user(stat->blksize, &ubuf->st_blksize) ||
+	    __put_user(stat->blocks, &ubuf->st_blocks))
+		return -EFAULT;
+	return 0;
+}
+
+COMPAT_SYSCALL_DEFINE2(ia32_stat64, const char __user *, filename,
+		       struct stat64 __user *, statbuf)
+{
+	struct kstat stat;
+	int ret = vfs_stat(filename, &stat);
+
+	if (!ret)
+		ret = cp_stat64(statbuf, &stat);
+	return ret;
+}
+
+COMPAT_SYSCALL_DEFINE2(ia32_lstat64, const char __user *, filename,
+		       struct stat64 __user *, statbuf)
+{
+	struct kstat stat;
+	int ret = vfs_lstat(filename, &stat);
+	if (!ret)
+		ret = cp_stat64(statbuf, &stat);
+	return ret;
+}
+
+COMPAT_SYSCALL_DEFINE2(ia32_fstat64, unsigned int, fd,
+		       struct stat64 __user *, statbuf)
+{
+	struct kstat stat;
+	int ret = vfs_fstat(fd, &stat);
+	if (!ret)
+		ret = cp_stat64(statbuf, &stat);
+	return ret;
+}
+
+COMPAT_SYSCALL_DEFINE4(ia32_fstatat64, unsigned int, dfd,
+		       const char __user *, filename,
+		       struct stat64 __user *, statbuf, int, flag)
+{
+	struct kstat stat;
+	int error;
+
+	error = vfs_fstatat(dfd, filename, &stat, flag);
+	if (error)
+		return error;
+	return cp_stat64(statbuf, &stat);
+}
+
+/*
+ * Linux/i386 didn't use to be able to handle more than
+ * 4 system call parameters, so these system calls used a memory
+ * block for parameter passing..
+ */
+
+struct mmap_arg_struct32 {
+	unsigned int addr;
+	unsigned int len;
+	unsigned int prot;
+	unsigned int flags;
+	unsigned int fd;
+	unsigned int offset;
+};
+
+COMPAT_SYSCALL_DEFINE1(ia32_mmap, struct mmap_arg_struct32 __user *, arg)
+{
+	struct mmap_arg_struct32 a;
+
+	if (copy_from_user(&a, arg, sizeof(a)))
+		return -EFAULT;
+
+	if (a.offset & ~PAGE_MASK)
+		return -EINVAL;
+
+	return ksys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd,
+			       a.offset>>PAGE_SHIFT);
+}
+
+/*
+ * The 32-bit clone ABI is CONFIG_CLONE_BACKWARDS
+ */
+COMPAT_SYSCALL_DEFINE5(ia32_clone, unsigned long, clone_flags,
+		       unsigned long, newsp, int __user *, parent_tidptr,
+		       unsigned long, tls_val, int __user *, child_tidptr)
+{
+	struct kernel_clone_args args = {
+		.flags		= (clone_flags & ~CSIGNAL),
+		.pidfd		= parent_tidptr,
+		.child_tid	= child_tidptr,
+		.parent_tid	= parent_tidptr,
+		.exit_signal	= (clone_flags & CSIGNAL),
+		.stack		= newsp,
+		.tls		= tls_val,
+	};
+
+	if (!legacy_clone_args_valid(&args))
+		return -EINVAL;
+
+	return _do_fork(&args);
+}
+#endif /* CONFIG_IA32_EMULATION */
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 33c51c0..77f70b9 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -21,6 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
+subarch-y += ../kernel/sys_ia32.o
 
 else
 
