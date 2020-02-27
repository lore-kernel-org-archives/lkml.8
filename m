Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F93BC4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C91D2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUtf7iRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgB0N2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:28:49 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37432 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgB0N2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:28:48 -0500
Received: by mail-yw1-f67.google.com with SMTP id l5so2990574ywd.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RAlyL7PbxsV9p3PlZCQGXbk0kDKYtfdY2IGiwUqtP8c=;
        b=VUtf7iRb63ZoxPeYFkNo6sb5LNPAMd/0QwfImSFDed1y+kbwraRQUh/TQvqyA9dJJE
         +YHuv4tbZKNhe/DloQektTxG5GsrRhQfGC7hLWyt/Z7gytYmX9VqMA02tzlQHcXgWtZm
         PueAog93llTtotiDCcRxo/JnGtNt2lXcJIT90df9yxxtEHDRUfealoZZod7xjj9jbIEH
         Nye8pwwfRabkbC95HHVejPnm408Fcwot5L+qj7t67t1GVEtjiLypGBMVwXBcH8y07Y2J
         6Rzt8V+wEgLSUmFDmM+wja0+9YgA+mJMlMvPDyerjaag3NBOj7DBeW0IXdjeHZ3O4VbX
         5MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RAlyL7PbxsV9p3PlZCQGXbk0kDKYtfdY2IGiwUqtP8c=;
        b=s1aqbHzZVZ9NQXmAdB5aNuFLnXUgjbvbL30iBS1iBO6mLQxwBB62pjBPczJVyxWrb1
         QWIJNv8YRZc7+dFmCnqJAWnozOF92J2vxfpgjZJopGAUU8eEd1IrCXcQmqfZ0AplAKUg
         UKuouwde1K2kddrr552/Bagu2r9G9SIdMq81r7Iz6kvZs1jK1uaHX0Qmi9EZdgQRJrnx
         /7GYv/IQf69xTsjHm0leOgP097LV3XFRijQh4o2i150LELia8VuGue2VHAJbhyIGSr9+
         rjgldQvFEojrgqI+eOnljgUPmdkO5BI4aHO4+PXMmknxDBUHQCsdxBwcfiMovYU992C0
         mKkA==
X-Gm-Message-State: APjAAAXD3vHEnihdTe3yOhhosDUOPmT8kk+IFCH4LY63iUI2pOaH6RZR
        QRinbHilXLWuI58LqBQXXxEAX8c=
X-Google-Smtp-Source: APXvYqyx8FmPMbbGPqdQsJdIFI5B5DWiYju3gKZwPF2qFxUPSM3eGCegNFGuajegbUNVuF2IxRMXBw==
X-Received: by 2002:a81:3845:: with SMTP id f66mr4455895ywa.220.1582810124622;
        Thu, 27 Feb 2020 05:28:44 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j23sm2442759ywb.93.2020.02.27.05.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:28:44 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 6/8] x86-32: Enable syscall wrappers
Date:   Thu, 27 Feb 2020 08:28:24 -0500
Message-Id: <20200227132826.195669-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227132826.195669-1-brgerst@gmail.com>
References: <20200227132826.195669-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pt_regs based syscalls for 32-bit.  This makes the 32-bit native
kernel consistent with the 64-bit kernel, and improves the syscall
interface by not needing to push all 6 potential arguments onto the stack.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/Kconfig                       |   2 +-
 arch/x86/entry/common.c                |  20 +-
 arch/x86/entry/syscall_32.c            |  11 +-
 arch/x86/entry/syscall_64.c            |   7 -
 arch/x86/entry/syscalls/syscall_32.tbl | 818 ++++++++++++-------------
 arch/x86/entry/syscalls/syscalltbl.sh  |  33 +-
 arch/x86/include/asm/syscall.h         |   6 -
 arch/x86/include/asm/syscall_wrapper.h | 114 ++--
 arch/x86/include/asm/syscalls.h        |  29 -
 9 files changed, 503 insertions(+), 537 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7f65ee880463..d1c1920f2a55 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -30,7 +30,6 @@ config X86_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
-	select ARCH_HAS_SYSCALL_WRAPPER
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
@@ -79,6 +78,7 @@ config X86
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
+	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ec167d8c41cb..91689fd7a5e8 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -334,20 +334,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
-#ifdef CONFIG_IA32_EMULATION
 		regs->ax = ia32_sys_call_table[nr](regs);
-#else
-		/*
-		 * It's possible that a 32-bit syscall implementation
-		 * takes a 64-bit parameter but nonetheless assumes that
-		 * the high bits are zero.  Make sure we zero-extend all
-		 * of the args.
-		 */
-		regs->ax = ia32_sys_call_table[nr](
-			(unsigned int)regs->bx, (unsigned int)regs->cx,
-			(unsigned int)regs->dx, (unsigned int)regs->si,
-			(unsigned int)regs->di, (unsigned int)regs->bp);
-#endif /* CONFIG_IA32_EMULATION */
 	}
 
 	syscall_return_slowpath(regs);
@@ -439,3 +426,10 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 #endif
 }
 #endif
+
+extern asmlinkage long sys_ni_syscall(void);
+
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return sys_ni_syscall();
+}
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 7d17b3addbbb..7af944b686ef 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -4,18 +4,11 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
+#include <linux/syscalls.h>
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-#ifdef CONFIG_IA32_EMULATION
-/* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
 #define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
-#define __sys_ni_syscall __ia32_sys_ni_syscall
-#else /* CONFIG_IA32_EMULATION */
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-#define __sys_ni_syscall sys_ni_syscall
-#endif /* CONFIG_IA32_EMULATION */
 
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
@@ -27,6 +20,6 @@ __visible const sys_call_ptr_t ia32_sys_call_table[__NR_syscall_compat_max+1] =
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
 	 */
-	[0 ... __NR_syscall_compat_max] = &__sys_ni_syscall,
+	[0 ... __NR_syscall_compat_max] = &__ia32_sys_ni_syscall,
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index adf619a856e8..058dc1b73e96 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,13 +8,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-extern asmlinkage long sys_ni_syscall(void);
-
-SYSCALL_DEFINE0(ni_syscall)
-{
-	return sys_ni_syscall();
-}
-
 #define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
 #define __SYSCALL_X32(nr, sym, qual) __SYSCALL_64(nr, sym, qual)
 #include <asm/syscalls_64.h>
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index f06f0d1b1282..07313a5b27e7 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -11,434 +11,434 @@
 #
 # The abi is always "i386" for this file.
 #
-0	i386	restart_syscall		sys_restart_syscall		__ia32_sys_restart_syscall
-1	i386	exit			sys_exit			__ia32_sys_exit
-2	i386	fork			sys_fork			__ia32_sys_fork
-3	i386	read			sys_read			__ia32_sys_read
-4	i386	write			sys_write			__ia32_sys_write
-5	i386	open			sys_open			__ia32_compat_sys_open
-6	i386	close			sys_close			__ia32_sys_close
-7	i386	waitpid			sys_waitpid			__ia32_sys_waitpid
-8	i386	creat			sys_creat			__ia32_sys_creat
-9	i386	link			sys_link			__ia32_sys_link
-10	i386	unlink			sys_unlink			__ia32_sys_unlink
-11	i386	execve			sys_execve			__ia32_compat_sys_execve
-12	i386	chdir			sys_chdir			__ia32_sys_chdir
-13	i386	time			sys_time32			__ia32_sys_time32
-14	i386	mknod			sys_mknod			__ia32_sys_mknod
-15	i386	chmod			sys_chmod			__ia32_sys_chmod
-16	i386	lchown			sys_lchown16			__ia32_sys_lchown16
+0	i386	restart_syscall		__ia32_sys_restart_syscall
+1	i386	exit			__ia32_sys_exit
+2	i386	fork			__ia32_sys_fork
+3	i386	read			__ia32_sys_read
+4	i386	write			__ia32_sys_write
+5	i386	open			__ia32_sys_open				__ia32_compat_sys_open
+6	i386	close			__ia32_sys_close
+7	i386	waitpid			__ia32_sys_waitpid
+8	i386	creat			__ia32_sys_creat
+9	i386	link			__ia32_sys_link
+10	i386	unlink			__ia32_sys_unlink
+11	i386	execve			__ia32_sys_execve			__ia32_compat_sys_execve
+12	i386	chdir			__ia32_sys_chdir
+13	i386	time			__ia32_sys_time32
+14	i386	mknod			__ia32_sys_mknod
+15	i386	chmod			__ia32_sys_chmod
+16	i386	lchown			__ia32_sys_lchown16
 17	i386	break
-18	i386	oldstat			sys_stat			__ia32_sys_stat
-19	i386	lseek			sys_lseek			__ia32_compat_sys_lseek
-20	i386	getpid			sys_getpid			__ia32_sys_getpid
-21	i386	mount			sys_mount			__ia32_compat_sys_mount
-22	i386	umount			sys_oldumount			__ia32_sys_oldumount
-23	i386	setuid			sys_setuid16			__ia32_sys_setuid16
-24	i386	getuid			sys_getuid16			__ia32_sys_getuid16
-25	i386	stime			sys_stime32			__ia32_sys_stime32
-26	i386	ptrace			sys_ptrace			__ia32_compat_sys_ptrace
-27	i386	alarm			sys_alarm			__ia32_sys_alarm
-28	i386	oldfstat		sys_fstat			__ia32_sys_fstat
-29	i386	pause			sys_pause			__ia32_sys_pause
-30	i386	utime			sys_utime32			__ia32_sys_utime32
+18	i386	oldstat			__ia32_sys_stat
+19	i386	lseek			__ia32_sys_lseek			__ia32_compat_sys_lseek
+20	i386	getpid			__ia32_sys_getpid
+21	i386	mount			__ia32_sys_mount			__ia32_compat_sys_mount
+22	i386	umount			__ia32_sys_oldumount
+23	i386	setuid			__ia32_sys_setuid16
+24	i386	getuid			__ia32_sys_getuid16
+25	i386	stime			__ia32_sys_stime32
+26	i386	ptrace			__ia32_sys_ptrace			__ia32_compat_sys_ptrace
+27	i386	alarm			__ia32_sys_alarm
+28	i386	oldfstat		__ia32_sys_fstat
+29	i386	pause			__ia32_sys_pause
+30	i386	utime			__ia32_sys_utime32
 31	i386	stty
 32	i386	gtty
-33	i386	access			sys_access			__ia32_sys_access
-34	i386	nice			sys_nice			__ia32_sys_nice
+33	i386	access			__ia32_sys_access
+34	i386	nice			__ia32_sys_nice
 35	i386	ftime
-36	i386	sync			sys_sync			__ia32_sys_sync
-37	i386	kill			sys_kill			__ia32_sys_kill
-38	i386	rename			sys_rename			__ia32_sys_rename
-39	i386	mkdir			sys_mkdir			__ia32_sys_mkdir
-40	i386	rmdir			sys_rmdir			__ia32_sys_rmdir
-41	i386	dup			sys_dup				__ia32_sys_dup
-42	i386	pipe			sys_pipe			__ia32_sys_pipe
-43	i386	times			sys_times			__ia32_compat_sys_times
+36	i386	sync			__ia32_sys_sync
+37	i386	kill			__ia32_sys_kill
+38	i386	rename			__ia32_sys_rename
+39	i386	mkdir			__ia32_sys_mkdir
+40	i386	rmdir			__ia32_sys_rmdir
+41	i386	dup			__ia32_sys_dup
+42	i386	pipe			__ia32_sys_pipe
+43	i386	times			__ia32_sys_times			__ia32_compat_sys_times
 44	i386	prof
-45	i386	brk			sys_brk				__ia32_sys_brk
-46	i386	setgid			sys_setgid16			__ia32_sys_setgid16
-47	i386	getgid			sys_getgid16			__ia32_sys_getgid16
-48	i386	signal			sys_signal			__ia32_sys_signal
-49	i386	geteuid			sys_geteuid16			__ia32_sys_geteuid16
-50	i386	getegid			sys_getegid16			__ia32_sys_getegid16
-51	i386	acct			sys_acct			__ia32_sys_acct
-52	i386	umount2			sys_umount			__ia32_sys_umount
+45	i386	brk			__ia32_sys_brk
+46	i386	setgid			__ia32_sys_setgid16
+47	i386	getgid			__ia32_sys_getgid16
+48	i386	signal			__ia32_sys_signal
+49	i386	geteuid			__ia32_sys_geteuid16
+50	i386	getegid			__ia32_sys_getegid16
+51	i386	acct			__ia32_sys_acct
+52	i386	umount2			__ia32_sys_umount
 53	i386	lock
-54	i386	ioctl			sys_ioctl			__ia32_compat_sys_ioctl
-55	i386	fcntl			sys_fcntl			__ia32_compat_sys_fcntl64
+54	i386	ioctl			__ia32_sys_ioctl			__ia32_compat_sys_ioctl
+55	i386	fcntl			__ia32_sys_fcntl			__ia32_compat_sys_fcntl64
 56	i386	mpx
-57	i386	setpgid			sys_setpgid			__ia32_sys_setpgid
+57	i386	setpgid			__ia32_sys_setpgid
 58	i386	ulimit
-59	i386	oldolduname		sys_olduname			__ia32_sys_olduname
-60	i386	umask			sys_umask			__ia32_sys_umask
-61	i386	chroot			sys_chroot			__ia32_sys_chroot
-62	i386	ustat			sys_ustat			__ia32_compat_sys_ustat
-63	i386	dup2			sys_dup2			__ia32_sys_dup2
-64	i386	getppid			sys_getppid			__ia32_sys_getppid
-65	i386	getpgrp			sys_getpgrp			__ia32_sys_getpgrp
-66	i386	setsid			sys_setsid			__ia32_sys_setsid
-67	i386	sigaction		sys_sigaction			__ia32_compat_sys_sigaction
-68	i386	sgetmask		sys_sgetmask			__ia32_sys_sgetmask
-69	i386	ssetmask		sys_ssetmask			__ia32_sys_ssetmask
-70	i386	setreuid		sys_setreuid16			__ia32_sys_setreuid16
-71	i386	setregid		sys_setregid16			__ia32_sys_setregid16
-72	i386	sigsuspend		sys_sigsuspend			__ia32_sys_sigsuspend
-73	i386	sigpending		sys_sigpending			__ia32_compat_sys_sigpending
-74	i386	sethostname		sys_sethostname			__ia32_sys_sethostname
-75	i386	setrlimit		sys_setrlimit			__ia32_compat_sys_setrlimit
-76	i386	getrlimit		sys_old_getrlimit		__ia32_compat_sys_old_getrlimit
-77	i386	getrusage		sys_getrusage			__ia32_compat_sys_getrusage
-78	i386	gettimeofday		sys_gettimeofday		__ia32_compat_sys_gettimeofday
-79	i386	settimeofday		sys_settimeofday		__ia32_compat_sys_settimeofday
-80	i386	getgroups		sys_getgroups16			__ia32_sys_getgroups16
-81	i386	setgroups		sys_setgroups16			__ia32_sys_setgroups16
-82	i386	select			sys_old_select			__ia32_compat_sys_old_select
-83	i386	symlink			sys_symlink			__ia32_sys_symlink
-84	i386	oldlstat		sys_lstat			__ia32_sys_lstat
-85	i386	readlink		sys_readlink			__ia32_sys_readlink
-86	i386	uselib			sys_uselib			__ia32_sys_uselib
-87	i386	swapon			sys_swapon			__ia32_sys_swapon
-88	i386	reboot			sys_reboot			__ia32_sys_reboot
-89	i386	readdir			sys_old_readdir			__ia32_compat_sys_old_readdir
-90	i386	mmap			sys_old_mmap			__ia32_compat_sys_x86_mmap
-91	i386	munmap			sys_munmap			__ia32_sys_munmap
-92	i386	truncate		sys_truncate			__ia32_compat_sys_truncate
-93	i386	ftruncate		sys_ftruncate			__ia32_compat_sys_ftruncate
-94	i386	fchmod			sys_fchmod			__ia32_sys_fchmod
-95	i386	fchown			sys_fchown16			__ia32_sys_fchown16
-96	i386	getpriority		sys_getpriority			__ia32_sys_getpriority
-97	i386	setpriority		sys_setpriority			__ia32_sys_setpriority
+59	i386	oldolduname		__ia32_sys_olduname
+60	i386	umask			__ia32_sys_umask
+61	i386	chroot			__ia32_sys_chroot
+62	i386	ustat			__ia32_sys_ustat			__ia32_compat_sys_ustat
+63	i386	dup2			__ia32_sys_dup2
+64	i386	getppid			__ia32_sys_getppid
+65	i386	getpgrp			__ia32_sys_getpgrp
+66	i386	setsid			__ia32_sys_setsid
+67	i386	sigaction		__ia32_sys_sigaction			__ia32_compat_sys_sigaction
+68	i386	sgetmask		__ia32_sys_sgetmask
+69	i386	ssetmask		__ia32_sys_ssetmask
+70	i386	setreuid		__ia32_sys_setreuid16
+71	i386	setregid		__ia32_sys_setregid16
+72	i386	sigsuspend		__ia32_sys_sigsuspend
+73	i386	sigpending		__ia32_sys_sigpending			__ia32_compat_sys_sigpending
+74	i386	sethostname		__ia32_sys_sethostname
+75	i386	setrlimit		__ia32_sys_setrlimit			__ia32_compat_sys_setrlimit
+76	i386	getrlimit		__ia32_sys_old_getrlimit		__ia32_compat_sys_old_getrlimit
+77	i386	getrusage		__ia32_sys_getrusage			__ia32_compat_sys_getrusage
+78	i386	gettimeofday		__ia32_sys_gettimeofday			__ia32_compat_sys_gettimeofday
+79	i386	settimeofday		__ia32_sys_settimeofday			__ia32_compat_sys_settimeofday
+80	i386	getgroups		__ia32_sys_getgroups16
+81	i386	setgroups		__ia32_sys_setgroups16
+82	i386	select			__ia32_sys_old_select			__ia32_compat_sys_old_select
+83	i386	symlink			__ia32_sys_symlink
+84	i386	oldlstat		__ia32_sys_lstat
+85	i386	readlink		__ia32_sys_readlink
+86	i386	uselib			__ia32_sys_uselib
+87	i386	swapon			__ia32_sys_swapon
+88	i386	reboot			__ia32_sys_reboot
+89	i386	readdir			__ia32_sys_old_readdir			__ia32_compat_sys_old_readdir
+90	i386	mmap			__ia32_sys_old_mmap			__ia32_compat_sys_x86_mmap
+91	i386	munmap			__ia32_sys_munmap
+92	i386	truncate		__ia32_sys_truncate			__ia32_compat_sys_truncate
+93	i386	ftruncate		__ia32_sys_ftruncate			__ia32_compat_sys_ftruncate
+94	i386	fchmod			__ia32_sys_fchmod
+95	i386	fchown			__ia32_sys_fchown16
+96	i386	getpriority		__ia32_sys_getpriority
+97	i386	setpriority		__ia32_sys_setpriority
 98	i386	profil
-99	i386	statfs			sys_statfs			__ia32_compat_sys_statfs
-100	i386	fstatfs			sys_fstatfs			__ia32_compat_sys_fstatfs
-101	i386	ioperm			sys_ioperm			__ia32_sys_ioperm
-102	i386	socketcall		sys_socketcall			__ia32_compat_sys_socketcall
-103	i386	syslog			sys_syslog			__ia32_sys_syslog
-104	i386	setitimer		sys_setitimer			__ia32_compat_sys_setitimer
-105	i386	getitimer		sys_getitimer			__ia32_compat_sys_getitimer
-106	i386	stat			sys_newstat			__ia32_compat_sys_newstat
-107	i386	lstat			sys_newlstat			__ia32_compat_sys_newlstat
-108	i386	fstat			sys_newfstat			__ia32_compat_sys_newfstat
-109	i386	olduname		sys_uname			__ia32_sys_uname
-110	i386	iopl			sys_iopl			__ia32_sys_iopl
-111	i386	vhangup			sys_vhangup			__ia32_sys_vhangup
+99	i386	statfs			__ia32_sys_statfs			__ia32_compat_sys_statfs
+100	i386	fstatfs			__ia32_sys_fstatfs			__ia32_compat_sys_fstatfs
+101	i386	ioperm			__ia32_sys_ioperm
+102	i386	socketcall		__ia32_sys_socketcall			__ia32_compat_sys_socketcall
+103	i386	syslog			__ia32_sys_syslog
+104	i386	setitimer		__ia32_sys_setitimer			__ia32_compat_sys_setitimer
+105	i386	getitimer		__ia32_sys_getitimer			__ia32_compat_sys_getitimer
+106	i386	stat			__ia32_sys_newstat			__ia32_compat_sys_newstat
+107	i386	lstat			__ia32_sys_newlstat			__ia32_compat_sys_newlstat
+108	i386	fstat			__ia32_sys_newfstat			__ia32_compat_sys_newfstat
+109	i386	olduname		__ia32_sys_uname
+110	i386	iopl			__ia32_sys_iopl
+111	i386	vhangup			__ia32_sys_vhangup
 112	i386	idle
-113	i386	vm86old			sys_vm86old			__ia32_sys_ni_syscall
-114	i386	wait4			sys_wait4			__ia32_compat_sys_wait4
-115	i386	swapoff			sys_swapoff			__ia32_sys_swapoff
-116	i386	sysinfo			sys_sysinfo			__ia32_compat_sys_sysinfo
-117	i386	ipc			sys_ipc				__ia32_compat_sys_ipc
-118	i386	fsync			sys_fsync			__ia32_sys_fsync
-119	i386	sigreturn		sys_sigreturn			__ia32_compat_sys_sigreturn
-120	i386	clone			sys_clone			__ia32_compat_sys_x86_clone
-121	i386	setdomainname		sys_setdomainname		__ia32_sys_setdomainname
-122	i386	uname			sys_newuname			__ia32_sys_newuname
-123	i386	modify_ldt		sys_modify_ldt			__ia32_sys_modify_ldt
-124	i386	adjtimex		sys_adjtimex_time32			__ia32_sys_adjtimex_time32
-125	i386	mprotect		sys_mprotect			__ia32_sys_mprotect
-126	i386	sigprocmask		sys_sigprocmask			__ia32_compat_sys_sigprocmask
+113	i386	vm86old			__ia32_sys_vm86old			__ia32_sys_ni_syscall
+114	i386	wait4			__ia32_sys_wait4			__ia32_compat_sys_wait4
+115	i386	swapoff			__ia32_sys_swapoff
+116	i386	sysinfo			__ia32_sys_sysinfo			__ia32_compat_sys_sysinfo
+117	i386	ipc			__ia32_sys_ipc				__ia32_compat_sys_ipc
+118	i386	fsync			__ia32_sys_fsync
+119	i386	sigreturn		__ia32_sys_sigreturn			__ia32_compat_sys_sigreturn
+120	i386	clone			__ia32_sys_clone			__ia32_compat_sys_x86_clone
+121	i386	setdomainname		__ia32_sys_setdomainname
+122	i386	uname			__ia32_sys_newuname
+123	i386	modify_ldt		__ia32_sys_modify_ldt
+124	i386	adjtimex		__ia32_sys_adjtimex_time32
+125	i386	mprotect		__ia32_sys_mprotect
+126	i386	sigprocmask		__ia32_sys_sigprocmask			__ia32_compat_sys_sigprocmask
 127	i386	create_module
-128	i386	init_module		sys_init_module			__ia32_sys_init_module
-129	i386	delete_module		sys_delete_module		__ia32_sys_delete_module
+128	i386	init_module		__ia32_sys_init_module
+129	i386	delete_module		__ia32_sys_delete_module
 130	i386	get_kernel_syms
-131	i386	quotactl		sys_quotactl			__ia32_compat_sys_quotactl32
-132	i386	getpgid			sys_getpgid			__ia32_sys_getpgid
-133	i386	fchdir			sys_fchdir			__ia32_sys_fchdir
-134	i386	bdflush			sys_bdflush			__ia32_sys_bdflush
-135	i386	sysfs			sys_sysfs			__ia32_sys_sysfs
-136	i386	personality		sys_personality			__ia32_sys_personality
+131	i386	quotactl		__ia32_sys_quotactl			__ia32_compat_sys_quotactl32
+132	i386	getpgid			__ia32_sys_getpgid
+133	i386	fchdir			__ia32_sys_fchdir
+134	i386	bdflush			__ia32_sys_bdflush
+135	i386	sysfs			__ia32_sys_sysfs
+136	i386	personality		__ia32_sys_personality
 137	i386	afs_syscall
-138	i386	setfsuid		sys_setfsuid16			__ia32_sys_setfsuid16
-139	i386	setfsgid		sys_setfsgid16			__ia32_sys_setfsgid16
-140	i386	_llseek			sys_llseek			__ia32_sys_llseek
-141	i386	getdents		sys_getdents			__ia32_compat_sys_getdents
-142	i386	_newselect		sys_select			__ia32_compat_sys_select
-143	i386	flock			sys_flock			__ia32_sys_flock
-144	i386	msync			sys_msync			__ia32_sys_msync
-145	i386	readv			sys_readv			__ia32_compat_sys_readv
-146	i386	writev			sys_writev			__ia32_compat_sys_writev
-147	i386	getsid			sys_getsid			__ia32_sys_getsid
-148	i386	fdatasync		sys_fdatasync			__ia32_sys_fdatasync
-149	i386	_sysctl			sys_sysctl			__ia32_compat_sys_sysctl
-150	i386	mlock			sys_mlock			__ia32_sys_mlock
-151	i386	munlock			sys_munlock			__ia32_sys_munlock
-152	i386	mlockall		sys_mlockall			__ia32_sys_mlockall
-153	i386	munlockall		sys_munlockall			__ia32_sys_munlockall
-154	i386	sched_setparam		sys_sched_setparam		__ia32_sys_sched_setparam
-155	i386	sched_getparam		sys_sched_getparam		__ia32_sys_sched_getparam
-156	i386	sched_setscheduler	sys_sched_setscheduler		__ia32_sys_sched_setscheduler
-157	i386	sched_getscheduler	sys_sched_getscheduler		__ia32_sys_sched_getscheduler
-158	i386	sched_yield		sys_sched_yield			__ia32_sys_sched_yield
-159	i386	sched_get_priority_max	sys_sched_get_priority_max	__ia32_sys_sched_get_priority_max
-160	i386	sched_get_priority_min	sys_sched_get_priority_min	__ia32_sys_sched_get_priority_min
-161	i386	sched_rr_get_interval	sys_sched_rr_get_interval_time32	__ia32_sys_sched_rr_get_interval_time32
-162	i386	nanosleep		sys_nanosleep_time32		__ia32_sys_nanosleep_time32
-163	i386	mremap			sys_mremap			__ia32_sys_mremap
-164	i386	setresuid		sys_setresuid16			__ia32_sys_setresuid16
-165	i386	getresuid		sys_getresuid16			__ia32_sys_getresuid16
-166	i386	vm86			sys_vm86			__ia32_sys_ni_syscall
+138	i386	setfsuid		__ia32_sys_setfsuid16
+139	i386	setfsgid		__ia32_sys_setfsgid16
+140	i386	_llseek			__ia32_sys_llseek
+141	i386	getdents		__ia32_sys_getdents			__ia32_compat_sys_getdents
+142	i386	_newselect		__ia32_sys_select			__ia32_compat_sys_select
+143	i386	flock			__ia32_sys_flock
+144	i386	msync			__ia32_sys_msync
+145	i386	readv			__ia32_sys_readv			__ia32_compat_sys_readv
+146	i386	writev			__ia32_sys_writev			__ia32_compat_sys_writev
+147	i386	getsid			__ia32_sys_getsid
+148	i386	fdatasync		__ia32_sys_fdatasync
+149	i386	_sysctl			__ia32_sys_sysctl			__ia32_compat_sys_sysctl
+150	i386	mlock			__ia32_sys_mlock
+151	i386	munlock			__ia32_sys_munlock
+152	i386	mlockall		__ia32_sys_mlockall
+153	i386	munlockall		__ia32_sys_munlockall
+154	i386	sched_setparam		__ia32_sys_sched_setparam
+155	i386	sched_getparam		__ia32_sys_sched_getparam
+156	i386	sched_setscheduler	__ia32_sys_sched_setscheduler
+157	i386	sched_getscheduler	__ia32_sys_sched_getscheduler
+158	i386	sched_yield		__ia32_sys_sched_yield
+159	i386	sched_get_priority_max	__ia32_sys_sched_get_priority_max
+160	i386	sched_get_priority_min	__ia32_sys_sched_get_priority_min
+161	i386	sched_rr_get_interval	__ia32_sys_sched_rr_get_interval_time32
+162	i386	nanosleep		__ia32_sys_nanosleep_time32
+163	i386	mremap			__ia32_sys_mremap
+164	i386	setresuid		__ia32_sys_setresuid16
+165	i386	getresuid		__ia32_sys_getresuid16
+166	i386	vm86			__ia32_sys_vm86				__ia32_sys_ni_syscall
 167	i386	query_module
-168	i386	poll			sys_poll			__ia32_sys_poll
+168	i386	poll			__ia32_sys_poll
 169	i386	nfsservctl
-170	i386	setresgid		sys_setresgid16			__ia32_sys_setresgid16
-171	i386	getresgid		sys_getresgid16			__ia32_sys_getresgid16
-172	i386	prctl			sys_prctl			__ia32_sys_prctl
-173	i386	rt_sigreturn		sys_rt_sigreturn		__ia32_compat_sys_rt_sigreturn
-174	i386	rt_sigaction		sys_rt_sigaction		__ia32_compat_sys_rt_sigaction
-175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_compat_sys_rt_sigprocmask
-176	i386	rt_sigpending		sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
-177	i386	rt_sigtimedwait		sys_rt_sigtimedwait_time32	__ia32_compat_sys_rt_sigtimedwait_time32
-178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		__ia32_compat_sys_rt_sigqueueinfo
-179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_compat_sys_rt_sigsuspend
-180	i386	pread64			sys_x86_pread			__ia32_sys_x86_pread
-181	i386	pwrite64		sys_x86_pwrite			__ia32_sys_x86_pwrite
-182	i386	chown			sys_chown16			__ia32_sys_chown16
-183	i386	getcwd			sys_getcwd			__ia32_sys_getcwd
-184	i386	capget			sys_capget			__ia32_sys_capget
-185	i386	capset			sys_capset			__ia32_sys_capset
-186	i386	sigaltstack		sys_sigaltstack			__ia32_compat_sys_sigaltstack
-187	i386	sendfile		sys_sendfile			__ia32_compat_sys_sendfile
+170	i386	setresgid		__ia32_sys_setresgid16
+171	i386	getresgid		__ia32_sys_getresgid16
+172	i386	prctl			__ia32_sys_prctl
+173	i386	rt_sigreturn		__ia32_sys_rt_sigreturn			__ia32_compat_sys_rt_sigreturn
+174	i386	rt_sigaction		__ia32_sys_rt_sigaction			__ia32_compat_sys_rt_sigaction
+175	i386	rt_sigprocmask		__ia32_sys_rt_sigprocmask		__ia32_compat_sys_rt_sigprocmask
+176	i386	rt_sigpending		__ia32_sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
+177	i386	rt_sigtimedwait		__ia32_sys_rt_sigtimedwait_time32	__ia32_compat_sys_rt_sigtimedwait_time32
+178	i386	rt_sigqueueinfo		__ia32_sys_rt_sigqueueinfo		__ia32_compat_sys_rt_sigqueueinfo
+179	i386	rt_sigsuspend		__ia32_sys_rt_sigsuspend		__ia32_compat_sys_rt_sigsuspend
+180	i386	pread64			__ia32_sys_x86_pread
+181	i386	pwrite64		__ia32_sys_x86_pwrite
+182	i386	chown			__ia32_sys_chown16
+183	i386	getcwd			__ia32_sys_getcwd
+184	i386	capget			__ia32_sys_capget
+185	i386	capset			__ia32_sys_capset
+186	i386	sigaltstack		__ia32_sys_sigaltstack			__ia32_compat_sys_sigaltstack
+187	i386	sendfile		__ia32_sys_sendfile			__ia32_compat_sys_sendfile
 188	i386	getpmsg
 189	i386	putpmsg
-190	i386	vfork			sys_vfork			__ia32_sys_vfork
-191	i386	ugetrlimit		sys_getrlimit			__ia32_compat_sys_getrlimit
-192	i386	mmap2			sys_mmap_pgoff			__ia32_sys_mmap_pgoff
-193	i386	truncate64		sys_x86_truncate64		__ia32_sys_x86_truncate64
-194	i386	ftruncate64		sys_x86_ftruncate64		__ia32_sys_x86_ftruncate64
-195	i386	stat64			sys_stat64			__ia32_compat_sys_x86_stat64
-196	i386	lstat64			sys_lstat64			__ia32_compat_sys_x86_lstat64
-197	i386	fstat64			sys_fstat64			__ia32_compat_sys_x86_fstat64
-198	i386	lchown32		sys_lchown			__ia32_sys_lchown
-199	i386	getuid32		sys_getuid			__ia32_sys_getuid
-200	i386	getgid32		sys_getgid			__ia32_sys_getgid
-201	i386	geteuid32		sys_geteuid			__ia32_sys_geteuid
-202	i386	getegid32		sys_getegid			__ia32_sys_getegid
-203	i386	setreuid32		sys_setreuid			__ia32_sys_setreuid
-204	i386	setregid32		sys_setregid			__ia32_sys_setregid
-205	i386	getgroups32		sys_getgroups			__ia32_sys_getgroups
-206	i386	setgroups32		sys_setgroups			__ia32_sys_setgroups
-207	i386	fchown32		sys_fchown			__ia32_sys_fchown
-208	i386	setresuid32		sys_setresuid			__ia32_sys_setresuid
-209	i386	getresuid32		sys_getresuid			__ia32_sys_getresuid
-210	i386	setresgid32		sys_setresgid			__ia32_sys_setresgid
-211	i386	getresgid32		sys_getresgid			__ia32_sys_getresgid
-212	i386	chown32			sys_chown			__ia32_sys_chown
-213	i386	setuid32		sys_setuid			__ia32_sys_setuid
-214	i386	setgid32		sys_setgid			__ia32_sys_setgid
-215	i386	setfsuid32		sys_setfsuid			__ia32_sys_setfsuid
-216	i386	setfsgid32		sys_setfsgid			__ia32_sys_setfsgid
-217	i386	pivot_root		sys_pivot_root			__ia32_sys_pivot_root
-218	i386	mincore			sys_mincore			__ia32_sys_mincore
-219	i386	madvise			sys_madvise			__ia32_sys_madvise
-220	i386	getdents64		sys_getdents64			__ia32_sys_getdents64
-221	i386	fcntl64			sys_fcntl64			__ia32_compat_sys_fcntl64
+190	i386	vfork			__ia32_sys_vfork
+191	i386	ugetrlimit		__ia32_sys_getrlimit			__ia32_compat_sys_getrlimit
+192	i386	mmap2			__ia32_sys_mmap_pgoff
+193	i386	truncate64		__ia32_sys_x86_truncate64
+194	i386	ftruncate64		__ia32_sys_x86_ftruncate64
+195	i386	stat64			__ia32_sys_stat64			__ia32_compat_sys_x86_stat64
+196	i386	lstat64			__ia32_sys_lstat64			__ia32_compat_sys_x86_lstat64
+197	i386	fstat64			__ia32_sys_fstat64			__ia32_compat_sys_x86_fstat64
+198	i386	lchown32		__ia32_sys_lchown
+199	i386	getuid32		__ia32_sys_getuid
+200	i386	getgid32		__ia32_sys_getgid
+201	i386	geteuid32		__ia32_sys_geteuid
+202	i386	getegid32		__ia32_sys_getegid
+203	i386	setreuid32		__ia32_sys_setreuid
+204	i386	setregid32		__ia32_sys_setregid
+205	i386	getgroups32		__ia32_sys_getgroups
+206	i386	setgroups32		__ia32_sys_setgroups
+207	i386	fchown32		__ia32_sys_fchown
+208	i386	setresuid32		__ia32_sys_setresuid
+209	i386	getresuid32		__ia32_sys_getresuid
+210	i386	setresgid32		__ia32_sys_setresgid
+211	i386	getresgid32		__ia32_sys_getresgid
+212	i386	chown32			__ia32_sys_chown
+213	i386	setuid32		__ia32_sys_setuid
+214	i386	setgid32		__ia32_sys_setgid
+215	i386	setfsuid32		__ia32_sys_setfsuid
+216	i386	setfsgid32		__ia32_sys_setfsgid
+217	i386	pivot_root		__ia32_sys_pivot_root
+218	i386	mincore			__ia32_sys_mincore
+219	i386	madvise			__ia32_sys_madvise
+220	i386	getdents64		__ia32_sys_getdents64
+221	i386	fcntl64			__ia32_sys_fcntl64			__ia32_compat_sys_fcntl64
 # 222 is unused
 # 223 is unused
-224	i386	gettid			sys_gettid			__ia32_sys_gettid
-225	i386	readahead		sys_x86_readahead		__ia32_sys_x86_readahead
-226	i386	setxattr		sys_setxattr			__ia32_sys_setxattr
-227	i386	lsetxattr		sys_lsetxattr			__ia32_sys_lsetxattr
-228	i386	fsetxattr		sys_fsetxattr			__ia32_sys_fsetxattr
-229	i386	getxattr		sys_getxattr			__ia32_sys_getxattr
-230	i386	lgetxattr		sys_lgetxattr			__ia32_sys_lgetxattr
-231	i386	fgetxattr		sys_fgetxattr			__ia32_sys_fgetxattr
-232	i386	listxattr		sys_listxattr			__ia32_sys_listxattr
-233	i386	llistxattr		sys_llistxattr			__ia32_sys_llistxattr
-234	i386	flistxattr		sys_flistxattr			__ia32_sys_flistxattr
-235	i386	removexattr		sys_removexattr			__ia32_sys_removexattr
-236	i386	lremovexattr		sys_lremovexattr		__ia32_sys_lremovexattr
-237	i386	fremovexattr		sys_fremovexattr		__ia32_sys_fremovexattr
-238	i386	tkill			sys_tkill			__ia32_sys_tkill
-239	i386	sendfile64		sys_sendfile64			__ia32_sys_sendfile64
-240	i386	futex			sys_futex_time32		__ia32_sys_futex_time32
-241	i386	sched_setaffinity	sys_sched_setaffinity		__ia32_compat_sys_sched_setaffinity
-242	i386	sched_getaffinity	sys_sched_getaffinity		__ia32_compat_sys_sched_getaffinity
-243	i386	set_thread_area		sys_set_thread_area		__ia32_sys_set_thread_area
-244	i386	get_thread_area		sys_get_thread_area		__ia32_sys_get_thread_area
-245	i386	io_setup		sys_io_setup			__ia32_compat_sys_io_setup
-246	i386	io_destroy		sys_io_destroy			__ia32_sys_io_destroy
-247	i386	io_getevents		sys_io_getevents_time32		__ia32_sys_io_getevents_time32
-248	i386	io_submit		sys_io_submit			__ia32_compat_sys_io_submit
-249	i386	io_cancel		sys_io_cancel			__ia32_sys_io_cancel
-250	i386	fadvise64		sys_x86_fadvise64		__ia32_sys_x86_fadvise64
+224	i386	gettid			__ia32_sys_gettid
+225	i386	readahead		__ia32_sys_x86_readahead
+226	i386	setxattr		__ia32_sys_setxattr
+227	i386	lsetxattr		__ia32_sys_lsetxattr
+228	i386	fsetxattr		__ia32_sys_fsetxattr
+229	i386	getxattr		__ia32_sys_getxattr
+230	i386	lgetxattr		__ia32_sys_lgetxattr
+231	i386	fgetxattr		__ia32_sys_fgetxattr
+232	i386	listxattr		__ia32_sys_listxattr
+233	i386	llistxattr		__ia32_sys_llistxattr
+234	i386	flistxattr		__ia32_sys_flistxattr
+235	i386	removexattr		__ia32_sys_removexattr
+236	i386	lremovexattr		__ia32_sys_lremovexattr
+237	i386	fremovexattr		__ia32_sys_fremovexattr
+238	i386	tkill			__ia32_sys_tkill
+239	i386	sendfile64		__ia32_sys_sendfile64
+240	i386	futex			__ia32_sys_futex_time32
+241	i386	sched_setaffinity	__ia32_sys_sched_setaffinity		__ia32_compat_sys_sched_setaffinity
+242	i386	sched_getaffinity	__ia32_sys_sched_getaffinity		__ia32_compat_sys_sched_getaffinity
+243	i386	set_thread_area		__ia32_sys_set_thread_area
+244	i386	get_thread_area		__ia32_sys_get_thread_area
+245	i386	io_setup		__ia32_sys_io_setup			__ia32_compat_sys_io_setup
+246	i386	io_destroy		__ia32_sys_io_destroy
+247	i386	io_getevents		__ia32_sys_io_getevents_time32
+248	i386	io_submit		__ia32_sys_io_submit			__ia32_compat_sys_io_submit
+249	i386	io_cancel		__ia32_sys_io_cancel
+250	i386	fadvise64		__ia32_sys_x86_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
-252	i386	exit_group		sys_exit_group			__ia32_sys_exit_group
-253	i386	lookup_dcookie		sys_lookup_dcookie		__ia32_compat_sys_lookup_dcookie
-254	i386	epoll_create		sys_epoll_create		__ia32_sys_epoll_create
-255	i386	epoll_ctl		sys_epoll_ctl			__ia32_sys_epoll_ctl
-256	i386	epoll_wait		sys_epoll_wait			__ia32_sys_epoll_wait
-257	i386	remap_file_pages	sys_remap_file_pages		__ia32_sys_remap_file_pages
-258	i386	set_tid_address		sys_set_tid_address		__ia32_sys_set_tid_address
-259	i386	timer_create		sys_timer_create		__ia32_compat_sys_timer_create
-260	i386	timer_settime		sys_timer_settime32		__ia32_sys_timer_settime32
-261	i386	timer_gettime		sys_timer_gettime32		__ia32_sys_timer_gettime32
-262	i386	timer_getoverrun	sys_timer_getoverrun		__ia32_sys_timer_getoverrun
-263	i386	timer_delete		sys_timer_delete		__ia32_sys_timer_delete
-264	i386	clock_settime		sys_clock_settime32		__ia32_sys_clock_settime32
-265	i386	clock_gettime		sys_clock_gettime32		__ia32_sys_clock_gettime32
-266	i386	clock_getres		sys_clock_getres_time32		__ia32_sys_clock_getres_time32
-267	i386	clock_nanosleep		sys_clock_nanosleep_time32	__ia32_sys_clock_nanosleep_time32
-268	i386	statfs64		sys_statfs64			__ia32_compat_sys_statfs64
-269	i386	fstatfs64		sys_fstatfs64			__ia32_compat_sys_fstatfs64
-270	i386	tgkill			sys_tgkill			__ia32_sys_tgkill
-271	i386	utimes			sys_utimes_time32		__ia32_sys_utimes_time32
-272	i386	fadvise64_64		sys_x86_fadvise64_64		__ia32_sys_x86_fadvise64_64
+252	i386	exit_group		__ia32_sys_exit_group
+253	i386	lookup_dcookie		__ia32_sys_lookup_dcookie		__ia32_compat_sys_lookup_dcookie
+254	i386	epoll_create		__ia32_sys_epoll_create
+255	i386	epoll_ctl		__ia32_sys_epoll_ctl
+256	i386	epoll_wait		__ia32_sys_epoll_wait
+257	i386	remap_file_pages	__ia32_sys_remap_file_pages
+258	i386	set_tid_address		__ia32_sys_set_tid_address
+259	i386	timer_create		__ia32_sys_timer_create			__ia32_compat_sys_timer_create
+260	i386	timer_settime		__ia32_sys_timer_settime32
+261	i386	timer_gettime		__ia32_sys_timer_gettime32
+262	i386	timer_getoverrun	__ia32_sys_timer_getoverrun
+263	i386	timer_delete		__ia32_sys_timer_delete
+264	i386	clock_settime		__ia32_sys_clock_settime32
+265	i386	clock_gettime		__ia32_sys_clock_gettime32
+266	i386	clock_getres		__ia32_sys_clock_getres_time32
+267	i386	clock_nanosleep		__ia32_sys_clock_nanosleep_time32
+268	i386	statfs64		__ia32_sys_statfs64			__ia32_compat_sys_statfs64
+269	i386	fstatfs64		__ia32_sys_fstatfs64			__ia32_compat_sys_fstatfs64
+270	i386	tgkill			__ia32_sys_tgkill
+271	i386	utimes			__ia32_sys_utimes_time32
+272	i386	fadvise64_64		__ia32_sys_x86_fadvise64_64
 273	i386	vserver
-274	i386	mbind			sys_mbind			__ia32_sys_mbind
-275	i386	get_mempolicy		sys_get_mempolicy		__ia32_compat_sys_get_mempolicy
-276	i386	set_mempolicy		sys_set_mempolicy		__ia32_sys_set_mempolicy
-277	i386	mq_open			sys_mq_open			__ia32_compat_sys_mq_open
-278	i386	mq_unlink		sys_mq_unlink			__ia32_sys_mq_unlink
-279	i386	mq_timedsend		sys_mq_timedsend_time32		__ia32_sys_mq_timedsend_time32
-280	i386	mq_timedreceive		sys_mq_timedreceive_time32	__ia32_sys_mq_timedreceive_time32
-281	i386	mq_notify		sys_mq_notify			__ia32_compat_sys_mq_notify
-282	i386	mq_getsetattr		sys_mq_getsetattr		__ia32_compat_sys_mq_getsetattr
-283	i386	kexec_load		sys_kexec_load			__ia32_compat_sys_kexec_load
-284	i386	waitid			sys_waitid			__ia32_compat_sys_waitid
+274	i386	mbind			__ia32_sys_mbind
+275	i386	get_mempolicy		__ia32_sys_get_mempolicy		__ia32_compat_sys_get_mempolicy
+276	i386	set_mempolicy		__ia32_sys_set_mempolicy
+277	i386	mq_open			__ia32_sys_mq_open			__ia32_compat_sys_mq_open
+278	i386	mq_unlink		__ia32_sys_mq_unlink
+279	i386	mq_timedsend		__ia32_sys_mq_timedsend_time32
+280	i386	mq_timedreceive		__ia32_sys_mq_timedreceive_time32
+281	i386	mq_notify		__ia32_sys_mq_notify			__ia32_compat_sys_mq_notify
+282	i386	mq_getsetattr		__ia32_sys_mq_getsetattr		__ia32_compat_sys_mq_getsetattr
+283	i386	kexec_load		__ia32_sys_kexec_load			__ia32_compat_sys_kexec_load
+284	i386	waitid			__ia32_sys_waitid			__ia32_compat_sys_waitid
 # 285 sys_setaltroot
-286	i386	add_key			sys_add_key			__ia32_sys_add_key
-287	i386	request_key		sys_request_key			__ia32_sys_request_key
-288	i386	keyctl			sys_keyctl			__ia32_compat_sys_keyctl
-289	i386	ioprio_set		sys_ioprio_set			__ia32_sys_ioprio_set
-290	i386	ioprio_get		sys_ioprio_get			__ia32_sys_ioprio_get
-291	i386	inotify_init		sys_inotify_init		__ia32_sys_inotify_init
-292	i386	inotify_add_watch	sys_inotify_add_watch		__ia32_sys_inotify_add_watch
-293	i386	inotify_rm_watch	sys_inotify_rm_watch		__ia32_sys_inotify_rm_watch
-294	i386	migrate_pages		sys_migrate_pages		__ia32_sys_migrate_pages
-295	i386	openat			sys_openat			__ia32_compat_sys_openat
-296	i386	mkdirat			sys_mkdirat			__ia32_sys_mkdirat
-297	i386	mknodat			sys_mknodat			__ia32_sys_mknodat
-298	i386	fchownat		sys_fchownat			__ia32_sys_fchownat
-299	i386	futimesat		sys_futimesat_time32		__ia32_sys_futimesat_time32
-300	i386	fstatat64		sys_fstatat64			__ia32_compat_sys_x86_fstatat
-301	i386	unlinkat		sys_unlinkat			__ia32_sys_unlinkat
-302	i386	renameat		sys_renameat			__ia32_sys_renameat
-303	i386	linkat			sys_linkat			__ia32_sys_linkat
-304	i386	symlinkat		sys_symlinkat			__ia32_sys_symlinkat
-305	i386	readlinkat		sys_readlinkat			__ia32_sys_readlinkat
-306	i386	fchmodat		sys_fchmodat			__ia32_sys_fchmodat
-307	i386	faccessat		sys_faccessat			__ia32_sys_faccessat
-308	i386	pselect6		sys_pselect6_time32		__ia32_compat_sys_pselect6_time32
-309	i386	ppoll			sys_ppoll_time32		__ia32_compat_sys_ppoll_time32
-310	i386	unshare			sys_unshare			__ia32_sys_unshare
-311	i386	set_robust_list		sys_set_robust_list		__ia32_compat_sys_set_robust_list
-312	i386	get_robust_list		sys_get_robust_list		__ia32_compat_sys_get_robust_list
-313	i386	splice			sys_splice			__ia32_sys_splice
-314	i386	sync_file_range		sys_x86_sync_file_range		__ia32_sys_x86_sync_file_range
-315	i386	tee			sys_tee				__ia32_sys_tee
-316	i386	vmsplice		sys_vmsplice			__ia32_compat_sys_vmsplice
-317	i386	move_pages		sys_move_pages			__ia32_compat_sys_move_pages
-318	i386	getcpu			sys_getcpu			__ia32_sys_getcpu
-319	i386	epoll_pwait		sys_epoll_pwait			__ia32_sys_epoll_pwait
-320	i386	utimensat		sys_utimensat_time32		__ia32_sys_utimensat_time32
-321	i386	signalfd		sys_signalfd			__ia32_compat_sys_signalfd
-322	i386	timerfd_create		sys_timerfd_create		__ia32_sys_timerfd_create
-323	i386	eventfd			sys_eventfd			__ia32_sys_eventfd
-324	i386	fallocate		sys_x86_fallocate		__ia32_sys_x86_fallocate
-325	i386	timerfd_settime		sys_timerfd_settime32		__ia32_sys_timerfd_settime32
-326	i386	timerfd_gettime		sys_timerfd_gettime32		__ia32_sys_timerfd_gettime32
-327	i386	signalfd4		sys_signalfd4			__ia32_compat_sys_signalfd4
-328	i386	eventfd2		sys_eventfd2			__ia32_sys_eventfd2
-329	i386	epoll_create1		sys_epoll_create1		__ia32_sys_epoll_create1
-330	i386	dup3			sys_dup3			__ia32_sys_dup3
-331	i386	pipe2			sys_pipe2			__ia32_sys_pipe2
-332	i386	inotify_init1		sys_inotify_init1		__ia32_sys_inotify_init1
-333	i386	preadv			sys_preadv			__ia32_compat_sys_preadv
-334	i386	pwritev			sys_pwritev			__ia32_compat_sys_pwritev
-335	i386	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		__ia32_compat_sys_rt_tgsigqueueinfo
-336	i386	perf_event_open		sys_perf_event_open		__ia32_sys_perf_event_open
-337	i386	recvmmsg		sys_recvmmsg_time32		__ia32_compat_sys_recvmmsg_time32
-338	i386	fanotify_init		sys_fanotify_init		__ia32_sys_fanotify_init
-339	i386	fanotify_mark		sys_fanotify_mark		__ia32_compat_sys_fanotify_mark
-340	i386	prlimit64		sys_prlimit64			__ia32_sys_prlimit64
-341	i386	name_to_handle_at	sys_name_to_handle_at		__ia32_sys_name_to_handle_at
-342	i386	open_by_handle_at	sys_open_by_handle_at		__ia32_compat_sys_open_by_handle_at
-343	i386	clock_adjtime		sys_clock_adjtime32		__ia32_sys_clock_adjtime32
-344	i386	syncfs			sys_syncfs			__ia32_sys_syncfs
-345	i386	sendmmsg		sys_sendmmsg			__ia32_compat_sys_sendmmsg
-346	i386	setns			sys_setns			__ia32_sys_setns
-347	i386	process_vm_readv	sys_process_vm_readv		__ia32_compat_sys_process_vm_readv
-348	i386	process_vm_writev	sys_process_vm_writev		__ia32_compat_sys_process_vm_writev
-349	i386	kcmp			sys_kcmp			__ia32_sys_kcmp
-350	i386	finit_module		sys_finit_module		__ia32_sys_finit_module
-351	i386	sched_setattr		sys_sched_setattr		__ia32_sys_sched_setattr
-352	i386	sched_getattr		sys_sched_getattr		__ia32_sys_sched_getattr
-353	i386	renameat2		sys_renameat2			__ia32_sys_renameat2
-354	i386	seccomp			sys_seccomp			__ia32_sys_seccomp
-355	i386	getrandom		sys_getrandom			__ia32_sys_getrandom
-356	i386	memfd_create		sys_memfd_create		__ia32_sys_memfd_create
-357	i386	bpf			sys_bpf				__ia32_sys_bpf
-358	i386	execveat		sys_execveat			__ia32_compat_sys_execveat
-359	i386	socket			sys_socket			__ia32_sys_socket
-360	i386	socketpair		sys_socketpair			__ia32_sys_socketpair
-361	i386	bind			sys_bind			__ia32_sys_bind
-362	i386	connect			sys_connect			__ia32_sys_connect
-363	i386	listen			sys_listen			__ia32_sys_listen
-364	i386	accept4			sys_accept4			__ia32_sys_accept4
-365	i386	getsockopt		sys_getsockopt			__ia32_compat_sys_getsockopt
-366	i386	setsockopt		sys_setsockopt			__ia32_compat_sys_setsockopt
-367	i386	getsockname		sys_getsockname			__ia32_sys_getsockname
-368	i386	getpeername		sys_getpeername			__ia32_sys_getpeername
-369	i386	sendto			sys_sendto			__ia32_sys_sendto
-370	i386	sendmsg			sys_sendmsg			__ia32_compat_sys_sendmsg
-371	i386	recvfrom		sys_recvfrom			__ia32_compat_sys_recvfrom
-372	i386	recvmsg			sys_recvmsg			__ia32_compat_sys_recvmsg
-373	i386	shutdown		sys_shutdown			__ia32_sys_shutdown
-374	i386	userfaultfd		sys_userfaultfd			__ia32_sys_userfaultfd
-375	i386	membarrier		sys_membarrier			__ia32_sys_membarrier
-376	i386	mlock2			sys_mlock2			__ia32_sys_mlock2
-377	i386	copy_file_range		sys_copy_file_range		__ia32_sys_copy_file_range
-378	i386	preadv2			sys_preadv2			__ia32_compat_sys_preadv2
-379	i386	pwritev2		sys_pwritev2			__ia32_compat_sys_pwritev2
-380	i386	pkey_mprotect		sys_pkey_mprotect		__ia32_sys_pkey_mprotect
-381	i386	pkey_alloc		sys_pkey_alloc			__ia32_sys_pkey_alloc
-382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
-383	i386	statx			sys_statx			__ia32_sys_statx
-384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
-385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_pgetevents
-386	i386	rseq			sys_rseq			__ia32_sys_rseq
-393	i386	semget			sys_semget    			__ia32_sys_semget
-394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
-395	i386	shmget			sys_shmget    			__ia32_sys_shmget
-396	i386	shmctl			sys_shmctl    			__ia32_compat_sys_shmctl
-397	i386	shmat			sys_shmat     			__ia32_compat_sys_shmat
-398	i386	shmdt			sys_shmdt     			__ia32_sys_shmdt
-399	i386	msgget			sys_msgget    			__ia32_sys_msgget
-400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
-401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
-402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
-403	i386	clock_gettime64		sys_clock_gettime		__ia32_sys_clock_gettime
-404	i386	clock_settime64		sys_clock_settime		__ia32_sys_clock_settime
-405	i386	clock_adjtime64		sys_clock_adjtime		__ia32_sys_clock_adjtime
-406	i386	clock_getres_time64	sys_clock_getres		__ia32_sys_clock_getres
-407	i386	clock_nanosleep_time64	sys_clock_nanosleep		__ia32_sys_clock_nanosleep
-408	i386	timer_gettime64		sys_timer_gettime		__ia32_sys_timer_gettime
-409	i386	timer_settime64		sys_timer_settime		__ia32_sys_timer_settime
-410	i386	timerfd_gettime64	sys_timerfd_gettime		__ia32_sys_timerfd_gettime
-411	i386	timerfd_settime64	sys_timerfd_settime		__ia32_sys_timerfd_settime
-412	i386	utimensat_time64	sys_utimensat			__ia32_sys_utimensat
-413	i386	pselect6_time64		sys_pselect6			__ia32_compat_sys_pselect6_time64
-414	i386	ppoll_time64		sys_ppoll			__ia32_compat_sys_ppoll_time64
-416	i386	io_pgetevents_time64	sys_io_pgetevents		__ia32_sys_io_pgetevents
-417	i386	recvmmsg_time64		sys_recvmmsg			__ia32_compat_sys_recvmmsg_time64
-418	i386	mq_timedsend_time64	sys_mq_timedsend		__ia32_sys_mq_timedsend
-419	i386	mq_timedreceive_time64	sys_mq_timedreceive		__ia32_sys_mq_timedreceive
-420	i386	semtimedop_time64	sys_semtimedop			__ia32_sys_semtimedop
-421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait_time64
-422	i386	futex_time64		sys_futex			__ia32_sys_futex
-423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	__ia32_sys_sched_rr_get_interval
-424	i386	pidfd_send_signal	sys_pidfd_send_signal		__ia32_sys_pidfd_send_signal
-425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
-426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
-427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
-428	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
-429	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
-430	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
-431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
-432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
-433	i386	fspick			sys_fspick			__ia32_sys_fspick
-434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
-435	i386	clone3			sys_clone3			__ia32_sys_clone3
-437	i386	openat2			sys_openat2			__ia32_sys_openat2
-438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
+286	i386	add_key			__ia32_sys_add_key
+287	i386	request_key		__ia32_sys_request_key
+288	i386	keyctl			__ia32_sys_keyctl			__ia32_compat_sys_keyctl
+289	i386	ioprio_set		__ia32_sys_ioprio_set
+290	i386	ioprio_get		__ia32_sys_ioprio_get
+291	i386	inotify_init		__ia32_sys_inotify_init
+292	i386	inotify_add_watch	__ia32_sys_inotify_add_watch
+293	i386	inotify_rm_watch	__ia32_sys_inotify_rm_watch
+294	i386	migrate_pages		__ia32_sys_migrate_pages
+295	i386	openat			__ia32_sys_openat			__ia32_compat_sys_openat
+296	i386	mkdirat			__ia32_sys_mkdirat
+297	i386	mknodat			__ia32_sys_mknodat
+298	i386	fchownat		__ia32_sys_fchownat
+299	i386	futimesat		__ia32_sys_futimesat_time32
+300	i386	fstatat64		__ia32_sys_fstatat64			__ia32_compat_sys_x86_fstatat
+301	i386	unlinkat		__ia32_sys_unlinkat
+302	i386	renameat		__ia32_sys_renameat
+303	i386	linkat			__ia32_sys_linkat
+304	i386	symlinkat		__ia32_sys_symlinkat
+305	i386	readlinkat		__ia32_sys_readlinkat
+306	i386	fchmodat		__ia32_sys_fchmodat
+307	i386	faccessat		__ia32_sys_faccessat
+308	i386	pselect6		__ia32_sys_pselect6_time32		__ia32_compat_sys_pselect6_time32
+309	i386	ppoll			__ia32_sys_ppoll_time32			__ia32_compat_sys_ppoll_time32
+310	i386	unshare			__ia32_sys_unshare
+311	i386	set_robust_list		__ia32_sys_set_robust_list		__ia32_compat_sys_set_robust_list
+312	i386	get_robust_list		__ia32_sys_get_robust_list		__ia32_compat_sys_get_robust_list
+313	i386	splice			__ia32_sys_splice
+314	i386	sync_file_range		__ia32_sys_x86_sync_file_range
+315	i386	tee			__ia32_sys_tee
+316	i386	vmsplice		__ia32_sys_vmsplice			__ia32_compat_sys_vmsplice
+317	i386	move_pages		__ia32_sys_move_pages			__ia32_compat_sys_move_pages
+318	i386	getcpu			__ia32_sys_getcpu
+319	i386	epoll_pwait		__ia32_sys_epoll_pwait
+320	i386	utimensat		__ia32_sys_utimensat_time32
+321	i386	signalfd		__ia32_sys_signalfd			__ia32_compat_sys_signalfd
+322	i386	timerfd_create		__ia32_sys_timerfd_create
+323	i386	eventfd			__ia32_sys_eventfd
+324	i386	fallocate		__ia32_sys_x86_fallocate
+325	i386	timerfd_settime		__ia32_sys_timerfd_settime32
+326	i386	timerfd_gettime		__ia32_sys_timerfd_gettime32
+327	i386	signalfd4		__ia32_sys_signalfd4			__ia32_compat_sys_signalfd4
+328	i386	eventfd2		__ia32_sys_eventfd2
+329	i386	epoll_create1		__ia32_sys_epoll_create1
+330	i386	dup3			__ia32_sys_dup3
+331	i386	pipe2			__ia32_sys_pipe2
+332	i386	inotify_init1		__ia32_sys_inotify_init1
+333	i386	preadv			__ia32_sys_preadv			__ia32_compat_sys_preadv
+334	i386	pwritev			__ia32_sys_pwritev			__ia32_compat_sys_pwritev
+335	i386	rt_tgsigqueueinfo	__ia32_sys_rt_tgsigqueueinfo		__ia32_compat_sys_rt_tgsigqueueinfo
+336	i386	perf_event_open		__ia32_sys_perf_event_open
+337	i386	recvmmsg		__ia32_sys_recvmmsg_time32		__ia32_compat_sys_recvmmsg_time32
+338	i386	fanotify_init		__ia32_sys_fanotify_init
+339	i386	fanotify_mark		__ia32_sys_fanotify_mark		__ia32_compat_sys_fanotify_mark
+340	i386	prlimit64		__ia32_sys_prlimit64
+341	i386	name_to_handle_at	__ia32_sys_name_to_handle_at
+342	i386	open_by_handle_at	__ia32_sys_open_by_handle_at		__ia32_compat_sys_open_by_handle_at
+343	i386	clock_adjtime		__ia32_sys_clock_adjtime32
+344	i386	syncfs			__ia32_sys_syncfs
+345	i386	sendmmsg		__ia32_sys_sendmmsg			__ia32_compat_sys_sendmmsg
+346	i386	setns			__ia32_sys_setns
+347	i386	process_vm_readv	__ia32_sys_process_vm_readv		__ia32_compat_sys_process_vm_readv
+348	i386	process_vm_writev	__ia32_sys_process_vm_writev		__ia32_compat_sys_process_vm_writev
+349	i386	kcmp			__ia32_sys_kcmp
+350	i386	finit_module		__ia32_sys_finit_module
+351	i386	sched_setattr		__ia32_sys_sched_setattr
+352	i386	sched_getattr		__ia32_sys_sched_getattr
+353	i386	renameat2		__ia32_sys_renameat2
+354	i386	seccomp			__ia32_sys_seccomp
+355	i386	getrandom		__ia32_sys_getrandom
+356	i386	memfd_create		__ia32_sys_memfd_create
+357	i386	bpf			__ia32_sys_bpf
+358	i386	execveat		__ia32_sys_execveat			__ia32_compat_sys_execveat
+359	i386	socket			__ia32_sys_socket
+360	i386	socketpair		__ia32_sys_socketpair
+361	i386	bind			__ia32_sys_bind
+362	i386	connect			__ia32_sys_connect
+363	i386	listen			__ia32_sys_listen
+364	i386	accept4			__ia32_sys_accept4
+365	i386	getsockopt		__ia32_sys_getsockopt			__ia32_compat_sys_getsockopt
+366	i386	setsockopt		__ia32_sys_setsockopt			__ia32_compat_sys_setsockopt
+367	i386	getsockname		__ia32_sys_getsockname
+368	i386	getpeername		__ia32_sys_getpeername
+369	i386	sendto			__ia32_sys_sendto
+370	i386	sendmsg			__ia32_sys_sendmsg			__ia32_compat_sys_sendmsg
+371	i386	recvfrom		__ia32_sys_recvfrom			__ia32_compat_sys_recvfrom
+372	i386	recvmsg			__ia32_sys_recvmsg			__ia32_compat_sys_recvmsg
+373	i386	shutdown		__ia32_sys_shutdown
+374	i386	userfaultfd		__ia32_sys_userfaultfd
+375	i386	membarrier		__ia32_sys_membarrier
+376	i386	mlock2			__ia32_sys_mlock2
+377	i386	copy_file_range		__ia32_sys_copy_file_range
+378	i386	preadv2			__ia32_sys_preadv2			__ia32_compat_sys_preadv2
+379	i386	pwritev2		__ia32_sys_pwritev2			__ia32_compat_sys_pwritev2
+380	i386	pkey_mprotect		__ia32_sys_pkey_mprotect
+381	i386	pkey_alloc		__ia32_sys_pkey_alloc
+382	i386	pkey_free		__ia32_sys_pkey_free
+383	i386	statx			__ia32_sys_statx
+384	i386	arch_prctl		__ia32_sys_arch_prctl			__ia32_compat_sys_arch_prctl
+385	i386	io_pgetevents		__ia32_sys_io_pgetevents_time32		__ia32_compat_sys_io_pgetevents
+386	i386	rseq			__ia32_sys_rseq
+393	i386	semget			__ia32_sys_semget
+394	i386	semctl			__ia32_sys_semctl    			__ia32_compat_sys_semctl
+395	i386	shmget			__ia32_sys_shmget
+396	i386	shmctl			__ia32_sys_shmctl    			__ia32_compat_sys_shmctl
+397	i386	shmat			__ia32_sys_shmat     			__ia32_compat_sys_shmat
+398	i386	shmdt			__ia32_sys_shmdt
+399	i386	msgget			__ia32_sys_msgget
+400	i386	msgsnd			__ia32_sys_msgsnd    			__ia32_compat_sys_msgsnd
+401	i386	msgrcv			__ia32_sys_msgrcv    			__ia32_compat_sys_msgrcv
+402	i386	msgctl			__ia32_sys_msgctl    			__ia32_compat_sys_msgctl
+403	i386	clock_gettime64		__ia32_sys_clock_gettime
+404	i386	clock_settime64		__ia32_sys_clock_settime
+405	i386	clock_adjtime64		__ia32_sys_clock_adjtime
+406	i386	clock_getres_time64	__ia32_sys_clock_getres
+407	i386	clock_nanosleep_time64	__ia32_sys_clock_nanosleep
+408	i386	timer_gettime64		__ia32_sys_timer_gettime
+409	i386	timer_settime64		__ia32_sys_timer_settime
+410	i386	timerfd_gettime64	__ia32_sys_timerfd_gettime
+411	i386	timerfd_settime64	__ia32_sys_timerfd_settime
+412	i386	utimensat_time64	__ia32_sys_utimensat
+413	i386	pselect6_time64		__ia32_sys_pselect6			__ia32_compat_sys_pselect6_time64
+414	i386	ppoll_time64		__ia32_sys_ppoll			__ia32_compat_sys_ppoll_time64
+416	i386	io_pgetevents_time64	__ia32_sys_io_pgetevents
+417	i386	recvmmsg_time64		__ia32_sys_recvmmsg			__ia32_compat_sys_recvmmsg_time64
+418	i386	mq_timedsend_time64	__ia32_sys_mq_timedsend
+419	i386	mq_timedreceive_time64	__ia32_sys_mq_timedreceive
+420	i386	semtimedop_time64	__ia32_sys_semtimedop
+421	i386	rt_sigtimedwait_time64	__ia32_sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait_time64
+422	i386	futex_time64		__ia32_sys_futex
+423	i386	sched_rr_get_interval_time64	__ia32_sys_sched_rr_get_interval
+424	i386	pidfd_send_signal	__ia32_sys_pidfd_send_signal
+425	i386	io_uring_setup		__ia32_sys_io_uring_setup
+426	i386	io_uring_enter		__ia32_sys_io_uring_enter
+427	i386	io_uring_register	__ia32_sys_io_uring_register
+428	i386	open_tree		__ia32_sys_open_tree
+429	i386	move_mount		__ia32_sys_move_mount
+430	i386	fsopen			__ia32_sys_fsopen
+431	i386	fsconfig		__ia32_sys_fsconfig
+432	i386	fsmount			__ia32_sys_fsmount
+433	i386	fspick			__ia32_sys_fspick
+434	i386	pidfd_open		__ia32_sys_pidfd_open
+435	i386	clone3			__ia32_sys_clone3
+437	i386	openat2			__ia32_sys_openat2
+438	i386	pidfd_getfd		__ia32_sys_pidfd_getfd
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index 1af2be39e7d9..e776a68bbe42 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -36,25 +36,32 @@ emit() {
     if [ "$abi" = "64" -a "${entry}" != "${entry#__x64_sys}" ]; then
 	    umlentry="sys${entry#__x64_sys}"
     fi
+    if [ "$abi" = "I386" -a "${entry}" != "${entry#__ia32_sys}" ]; then
+	    umlentry="sys${entry#__ia32_sys}"
+    fi
 
-    if [ -z "$compat" ]; then
-	if [ -n "$entry" -a -z "$umlentry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	elif [ -n "$umlentry" ]; then # implies -n "$entry"
+    if [ -n "$entry" ]; then
+	if [ -n "$umlentry" ]; then
 	    echo "#ifdef CONFIG_X86"
-	    syscall_macro "$abi" "$nr" "$entry"
+	fi
+
+	if [ -n "$compat" ]; then
+	    echo "#ifdef CONFIG_X86_32"
+	fi
+
+	syscall_macro "$abi" "$nr" "$entry"
+
+	if [ -n "$compat" ]; then
+	    echo "#else /* CONFIG_X86_32 */"
+	    syscall_macro "$abi" "$nr" "$compat"
+	    echo "#endif"
+	fi
+
+	if [ -n "$umlentry" ]; then
 	    echo "#else /* CONFIG_UML */"
 	    syscall_macro "$abi" "$nr" "$umlentry"
 	    echo "#endif"
 	fi
-    else
-	echo "#ifdef CONFIG_X86_32"
-	if [ -n "$entry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	fi
-	echo "#else"
-	syscall_macro "$abi" "$nr" "$compat"
-	echo "#endif"
     fi
 }
 
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index d20ffc518cf4..576178aefa01 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -17,13 +17,7 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
-#ifdef CONFIG_X86_64
 typedef asmlinkage long (*sys_call_ptr_t)(const struct pt_regs *);
-#else
-typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
-					  unsigned long, unsigned long,
-					  unsigned long, unsigned long);
-#endif /* CONFIG_X86_64 */
 extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index b19b696b1cb4..f3f29aeba2cb 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -8,6 +8,50 @@
 
 struct pt_regs;
 
+extern asmlinkage long __x64_sys_ni_syscall(const struct pt_regs *regs);
+extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
+
+/*
+ * Instead of the generic __SYSCALL_DEFINEx() definition, the x86 version takes
+ * struct pt_regs *regs as the only argument of the syscall stub(s) named as:
+ * __x64_sys_*()         - 64-bit native syscall
+ * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
+ * __ia32_compat_sys_*() - 32-bit compat syscall
+ * __x32_compat_sys_*()  - 64-bit X32 compat syscall
+ *
+ * The registers are decoded according to the ABI:
+ * 64-bit: RDI, RSI, RDX, R10, R8, R9
+ * 32-bit: EBX, ECX, EDX, ESI, EDI, EBP
+ *
+ * The stub then passes the decoded arguments to the __se_sys_*() wrapper to
+ * perform sign-extension (omitted for zero-argument syscalls).  Finally the
+ * arguments are passed to the __do_sys_*() function which is the actual
+ * syscall.  These wrappers are marked as inline so the compiler can optimize
+ * the functions where appropriate.
+ *
+ * Example assembly (slightly re-ordered for better readability):
+ *
+ * <__x64_sys_recv>:		<-- syscall with 4 parameters
+ *	callq	<__fentry__>
+ *
+ *	mov	0x70(%rdi),%rdi	<-- decode regs->di
+ *	mov	0x68(%rdi),%rsi	<-- decode regs->si
+ *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
+ *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
+ *
+ *	xor	%r9d,%r9d	<-- clear %r9
+ *	xor	%r8d,%r8d	<-- clear %r8
+ *
+ *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
+ *				    which takes 6 arguments
+ *
+ *	cltq			<-- extend return value to 64-bit
+ *	retq			<-- return
+ *
+ * This approach avoids leaking random user-provided register content down
+ * the call chain.
+ */
+
 /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
 #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
 	__MAP(x,__SC_ARGS						\
@@ -65,6 +109,26 @@ struct pt_regs;
 #define __X64_SYS_NI(name)
 #endif /* CONFIG_X86_64 */
 
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+#define __IA32_SYS_STUB0(name)						\
+	__SYS_STUB0(ia32, sys_##name)
+
+#define __IA32_SYS_STUBx(x, name, ...)					\
+	__SYS_STUBx(ia32, sys##name,					\
+		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __IA32_COND_SYSCALL(name)					\
+	__COND_SYSCALL(ia32, sys_##name)
+
+#define __IA32_SYS_NI(name)						\
+	__SYS_NI(ia32, sys_##name)
+#else /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
+#define __IA32_SYS_STUB0(name)
+#define __IA32_SYS_STUBx(x, name, ...)
+#define __IA32_COND_SYSCALL(name)
+#define __IA32_SYS_NI(name)
+#endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
+
 #ifdef CONFIG_IA32_EMULATION
 /*
  * For IA32 emulation, we need to handle "compat" syscalls *and* create
@@ -87,27 +151,11 @@ struct pt_regs;
 #define __IA32_COMPAT_SYS_NI(name)					\
 	__SYS_NI(ia32, compat_sys_##name)
 
-#define __IA32_SYS_STUB0(name)						\
-	__SYS_STUB0(ia32, sys_##name)
-
-#define __IA32_SYS_STUBx(x, name, ...)					\
-	__SYS_STUBx(ia32, sys##name,					\
-		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
-
-#define __IA32_COND_SYSCALL(name)					\
-	__COND_SYSCALL(ia32, sys_##name)
-
-#define __IA32_SYS_NI(name)						\
-	__SYS_NI(ia32, sys_##name)
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
 #define __IA32_COMPAT_COND_SYSCALL(name)
 #define __IA32_COMPAT_SYS_NI(name)
-#define __IA32_SYS_STUB0(name)
-#define __IA32_SYS_STUBx(x, name, ...)
-#define __IA32_COND_SYSCALL(name)
-#define __IA32_SYS_NI(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -182,40 +230,6 @@ struct pt_regs;
 
 #endif /* CONFIG_COMPAT */
 
-
-/*
- * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
- * struct pt_regs *regs as the only argument of the syscall stub named
- * __x64_sys_*(). It decodes just the registers it needs and passes them on to
- * the __se_sys_*() wrapper performing sign extension and then to the
- * __do_sys_*() function doing the actual job. These wrappers and functions
- * are inlined (at least in very most cases), meaning that the assembly looks
- * as follows (slightly re-ordered for better readability):
- *
- * <__x64_sys_recv>:		<-- syscall with 4 parameters
- *	callq	<__fentry__>
- *
- *	mov	0x70(%rdi),%rdi	<-- decode regs->di
- *	mov	0x68(%rdi),%rsi	<-- decode regs->si
- *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
- *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
- *
- *	xor	%r9d,%r9d	<-- clear %r9
- *	xor	%r8d,%r8d	<-- clear %r8
- *
- *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
- *				    which takes 6 arguments
- *
- *	cltq			<-- extend return value to 64-bit
- *	retq			<-- return
- *
- * This approach avoids leaking random user-provided register content down
- * the call chain.
- *
- * If IA32_EMULATION is enabled, this macro generates an additional wrapper
- * named __ia32_sys_*() which decodes the struct pt_regs *regs according
- * to the i386 calling convention (bx, cx, dx, si, di, bp).
- */
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index 91b7b6e1a115..06cbdca634d6 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -17,33 +17,4 @@
 /* kernel/ioport.c */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on);
 
-#ifdef CONFIG_X86_32
-/*
- * These definitions are only valid on pure 32-bit systems; x86-64 uses a
- * different syscall calling convention
- */
-asmlinkage long sys_ioperm(unsigned long, unsigned long, int);
-asmlinkage long sys_iopl(unsigned int);
-
-/* kernel/ldt.c */
-asmlinkage long sys_modify_ldt(int, void __user *, unsigned long);
-
-/* kernel/signal.c */
-asmlinkage long sys_rt_sigreturn(void);
-
-/* kernel/tls.c */
-asmlinkage long sys_set_thread_area(struct user_desc __user *);
-asmlinkage long sys_get_thread_area(struct user_desc __user *);
-
-/* X86_32 only */
-
-/* kernel/signal.c */
-asmlinkage long sys_sigreturn(void);
-
-/* kernel/vm86_32.c */
-struct vm86_struct;
-asmlinkage long sys_vm86old(struct vm86_struct __user *);
-asmlinkage long sys_vm86(unsigned long, unsigned long);
-
-#endif /* CONFIG_X86_32 */
 #endif /* _ASM_X86_SYSCALLS_H */
-- 
2.24.1

