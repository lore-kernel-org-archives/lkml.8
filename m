Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD8AC11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5360208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sae9NUFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgBUFKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:10:39 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36120 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUFKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:10:38 -0500
Received: by mail-yw1-f65.google.com with SMTP id n184so571836ywc.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 21:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDSGeH+wR1Wq8UkP2s9kdwnmJWq7UcyLMcSiaJoDz2o=;
        b=sae9NUFk64G3OQQj82yqtxzCs/xwLWF95G4TBAGKLaPo3HSTep5NZEQ2GFFec4OZnW
         xwiRv4gIbtOsJxzFAFZS6UWM3BdEKadVR0c1lHBlkTMdiOjuY0DjLtdlKFHuzndk0q+P
         RBN67MJKTPgTiPYX3zPQCgMU0bbJYDRoUjXmGK7G5m1ShxwEqCkDuUZWDawbgIa7lTko
         CT8AcKPwCZ69v+WAUpV/T2+0+TgO3E14ezpOHYUwEMFE0XiueLsHsIAihFT+WmPEuFnq
         o2t3VOIZdQjCpoMAFQJyOv0uoxDsF97Zq+K2SJtVbTNzYJ2NwzLW6fynuws/IgktjbvO
         DGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDSGeH+wR1Wq8UkP2s9kdwnmJWq7UcyLMcSiaJoDz2o=;
        b=akWyas7ezgRUa11wzXXBFWmyQcE2QHoXfmdaK1g+7VGsnFIzsuPIgL5eXzLzd1bPTi
         QkEZcnn2cEiePBegnL3ENrkQ+Ufcnru/69EXA53cTIDRb1oJMn6VgCMlXokpKtV2rg+f
         V1HUX+Dmnhs8c+iFyCFB5NxENWRNq6yE4KWBnYVsBY0y4ge83sVler7AqSXtQ1Kxy8wk
         bWTav4yLGFBF9FnuS/epGkztPHZbJ1Xr4Zg4F6+wOgK5Zw9y8chTe/hX68FvEysH7cxO
         WAlCQiWBlXCFNG3xwuFV2D6IdB1AYfaA70ux4lBvOEsGssK9lAQp0JTNk0aessNLl/Td
         6nWw==
X-Gm-Message-State: APjAAAXj2m8qy8J6dpZCPFLPjgCUelcsMXKkaYpTbAfGQvJwyBZbOx5W
        oURWYD7iDPuTnM1v462YIqd7kps=
X-Google-Smtp-Source: APXvYqwghbf61VT39BhYqyXwpVeDBafc8ymr6Ul/TC7KYCbIEGoaTGun0l1tMbKw0Qc+VO76eighcA==
X-Received: by 2002:a81:b343:: with SMTP id r64mr27208972ywh.278.1582261835016;
        Thu, 20 Feb 2020 21:10:35 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id a12sm840904ywa.95.2020.02.20.21.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 21:10:34 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/5] x86: Move 32-bit compat syscalls to common location
Date:   Fri, 21 Feb 2020 00:09:31 -0500
Message-Id: <20200221050934.719152-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221050934.719152-1-brgerst@gmail.com>
References: <20200221050934.719152-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the 32-bit wrappers for syscalls that take 64-bit arguments (loff_t)
to a common location so that native 32-bit can use them in preparation for
enabling pt_regs-based syscalls.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  18 ++--
 arch/x86/ia32/Makefile                 |   2 +-
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/{ia32 => kernel}/sys_ia32.c   | 130 ++++++++++++-------------
 arch/x86/um/sys_call_table_32.c        |  10 ++
 5 files changed, 87 insertions(+), 75 deletions(-)
 rename arch/x86/{ia32 => kernel}/sys_ia32.c (83%)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c17cb77eb150..f06f0d1b1282 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -191,8 +191,8 @@
 177	i386	rt_sigtimedwait		sys_rt_sigtimedwait_time32	__ia32_compat_sys_rt_sigtimedwait_time32
 178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		__ia32_compat_sys_rt_sigqueueinfo
 179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_compat_sys_rt_sigsuspend
-180	i386	pread64			sys_pread64			__ia32_compat_sys_x86_pread
-181	i386	pwrite64		sys_pwrite64			__ia32_compat_sys_x86_pwrite
+180	i386	pread64			sys_x86_pread			__ia32_sys_x86_pread
+181	i386	pwrite64		sys_x86_pwrite			__ia32_sys_x86_pwrite
 182	i386	chown			sys_chown16			__ia32_sys_chown16
 183	i386	getcwd			sys_getcwd			__ia32_sys_getcwd
 184	i386	capget			sys_capget			__ia32_sys_capget
@@ -204,8 +204,8 @@
 190	i386	vfork			sys_vfork			__ia32_sys_vfork
 191	i386	ugetrlimit		sys_getrlimit			__ia32_compat_sys_getrlimit
 192	i386	mmap2			sys_mmap_pgoff			__ia32_sys_mmap_pgoff
-193	i386	truncate64		sys_truncate64			__ia32_compat_sys_x86_truncate64
-194	i386	ftruncate64		sys_ftruncate64			__ia32_compat_sys_x86_ftruncate64
+193	i386	truncate64		sys_x86_truncate64		__ia32_sys_x86_truncate64
+194	i386	ftruncate64		sys_x86_ftruncate64		__ia32_sys_x86_ftruncate64
 195	i386	stat64			sys_stat64			__ia32_compat_sys_x86_stat64
 196	i386	lstat64			sys_lstat64			__ia32_compat_sys_x86_lstat64
 197	i386	fstat64			sys_fstat64			__ia32_compat_sys_x86_fstat64
@@ -236,7 +236,7 @@
 # 222 is unused
 # 223 is unused
 224	i386	gettid			sys_gettid			__ia32_sys_gettid
-225	i386	readahead		sys_readahead			__ia32_compat_sys_x86_readahead
+225	i386	readahead		sys_x86_readahead		__ia32_sys_x86_readahead
 226	i386	setxattr		sys_setxattr			__ia32_sys_setxattr
 227	i386	lsetxattr		sys_lsetxattr			__ia32_sys_lsetxattr
 228	i386	fsetxattr		sys_fsetxattr			__ia32_sys_fsetxattr
@@ -261,7 +261,7 @@
 247	i386	io_getevents		sys_io_getevents_time32		__ia32_sys_io_getevents_time32
 248	i386	io_submit		sys_io_submit			__ia32_compat_sys_io_submit
 249	i386	io_cancel		sys_io_cancel			__ia32_sys_io_cancel
-250	i386	fadvise64		sys_fadvise64			__ia32_compat_sys_x86_fadvise64
+250	i386	fadvise64		sys_x86_fadvise64		__ia32_sys_x86_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
 252	i386	exit_group		sys_exit_group			__ia32_sys_exit_group
 253	i386	lookup_dcookie		sys_lookup_dcookie		__ia32_compat_sys_lookup_dcookie
@@ -283,7 +283,7 @@
 269	i386	fstatfs64		sys_fstatfs64			__ia32_compat_sys_fstatfs64
 270	i386	tgkill			sys_tgkill			__ia32_sys_tgkill
 271	i386	utimes			sys_utimes_time32		__ia32_sys_utimes_time32
-272	i386	fadvise64_64		sys_fadvise64_64		__ia32_compat_sys_x86_fadvise64_64
+272	i386	fadvise64_64		sys_x86_fadvise64_64		__ia32_sys_x86_fadvise64_64
 273	i386	vserver
 274	i386	mbind			sys_mbind			__ia32_sys_mbind
 275	i386	get_mempolicy		sys_get_mempolicy		__ia32_compat_sys_get_mempolicy
@@ -325,7 +325,7 @@
 311	i386	set_robust_list		sys_set_robust_list		__ia32_compat_sys_set_robust_list
 312	i386	get_robust_list		sys_get_robust_list		__ia32_compat_sys_get_robust_list
 313	i386	splice			sys_splice			__ia32_sys_splice
-314	i386	sync_file_range		sys_sync_file_range		__ia32_compat_sys_x86_sync_file_range
+314	i386	sync_file_range		sys_x86_sync_file_range		__ia32_sys_x86_sync_file_range
 315	i386	tee			sys_tee				__ia32_sys_tee
 316	i386	vmsplice		sys_vmsplice			__ia32_compat_sys_vmsplice
 317	i386	move_pages		sys_move_pages			__ia32_compat_sys_move_pages
@@ -335,7 +335,7 @@
 321	i386	signalfd		sys_signalfd			__ia32_compat_sys_signalfd
 322	i386	timerfd_create		sys_timerfd_create		__ia32_sys_timerfd_create
 323	i386	eventfd			sys_eventfd			__ia32_sys_eventfd
-324	i386	fallocate		sys_fallocate			__ia32_compat_sys_x86_fallocate
+324	i386	fallocate		sys_x86_fallocate		__ia32_sys_x86_fallocate
 325	i386	timerfd_settime		sys_timerfd_settime32		__ia32_sys_timerfd_settime32
 326	i386	timerfd_gettime		sys_timerfd_gettime32		__ia32_sys_timerfd_gettime32
 327	i386	signalfd4		sys_signalfd4			__ia32_compat_sys_signalfd4
diff --git a/arch/x86/ia32/Makefile b/arch/x86/ia32/Makefile
index d13b352b2aa7..8e4d0391ff6c 100644
--- a/arch/x86/ia32/Makefile
+++ b/arch/x86/ia32/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the ia32 kernel emulation subsystem.
 #
 
-obj-$(CONFIG_IA32_EMULATION) := sys_ia32.o ia32_signal.o
+obj-$(CONFIG_IA32_EMULATION) := ia32_signal.o
 
 obj-$(CONFIG_IA32_AOUT) += ia32_aout.o
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 70615591a265..3f6d611fce08 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -57,6 +57,8 @@ obj-y			+= setup.o x86_init.o i8259.o irqinit.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y			+= probe_roms.o
+obj-$(CONFIG_X86_32)	+= sys_ia32.o
+obj-$(CONFIG_IA32_EMULATION)	+= sys_ia32.o
 obj-$(CONFIG_X86_64)	+= sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
 obj-$(CONFIG_SYSFS)	+= ksysfs.o
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/kernel/sys_ia32.c
similarity index 83%
rename from arch/x86/ia32/sys_ia32.c
rename to arch/x86/kernel/sys_ia32.c
index 21790307121e..bc1359d2b8e6 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/kernel/sys_ia32.c
@@ -51,20 +51,79 @@
 
 #define AA(__x)		((unsigned long)(__x))
 
-
-COMPAT_SYSCALL_DEFINE3(x86_truncate64, const char __user *, filename,
-		       unsigned long, offset_low, unsigned long, offset_high)
+SYSCALL_DEFINE3(x86_truncate64, const char __user *, filename,
+		unsigned long, offset_low, unsigned long, offset_high)
 {
 	return ksys_truncate(filename,
 			    ((loff_t) offset_high << 32) | offset_low);
 }
 
-COMPAT_SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
-		       unsigned long, offset_low, unsigned long, offset_high)
+SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
+		unsigned long, offset_low, unsigned long, offset_high)
 {
 	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
 }
 
+/* warning: next two assume little endian */
+SYSCALL_DEFINE5(x86_pread, unsigned int, fd, char __user *, ubuf,
+		u32, count, u32, poslo, u32, poshi)
+{
+	return ksys_pread64(fd, ubuf, count,
+			    ((loff_t)AA(poshi) << 32) | AA(poslo));
+}
+
+SYSCALL_DEFINE5(x86_pwrite, unsigned int, fd, const char __user *, ubuf,
+		u32, count, u32, poslo, u32, poshi)
+{
+	return ksys_pwrite64(fd, ubuf, count,
+			     ((loff_t)AA(poshi) << 32) | AA(poslo));
+}
+
+/*
+ * Some system calls that need sign extended arguments. This could be
+ * done by a generic wrapper.
+ */
+SYSCALL_DEFINE6(x86_fadvise64_64, int, fd, __u32, offset_low,
+		__u32, offset_high, __u32, len_low, __u32, len_high,
+		int, advice)
+{
+	return ksys_fadvise64_64(fd,
+				 (((u64)offset_high)<<32) | offset_low,
+				 (((u64)len_high)<<32) | len_low,
+				 advice);
+}
+
+SYSCALL_DEFINE4(x86_readahead, int, fd, unsigned int, off_lo,
+		unsigned int, off_hi, size_t, count)
+{
+	return ksys_readahead(fd, ((u64)off_hi << 32) | off_lo, count);
+}
+
+SYSCALL_DEFINE6(x86_sync_file_range, int, fd, unsigned int, off_low,
+		unsigned int, off_hi, unsigned int, n_low,
+		unsigned int, n_hi, int, flags)
+{
+	return ksys_sync_file_range(fd,
+				    ((u64)off_hi << 32) | off_low,
+				    ((u64)n_hi << 32) | n_low, flags);
+}
+
+SYSCALL_DEFINE5(x86_fadvise64, int, fd, unsigned int, offset_lo,
+		unsigned int, offset_hi, size_t, len, int, advice)
+{
+	return ksys_fadvise64_64(fd, ((u64)offset_hi << 32) | offset_lo,
+				 len, advice);
+}
+
+SYSCALL_DEFINE6(x86_fallocate, int, fd, int, mode,
+		unsigned int, offset_lo, unsigned int, offset_hi,
+		unsigned int, len_lo, unsigned int, len_hi)
+{
+	return ksys_fallocate(fd, mode, ((u64)offset_hi << 32) | offset_lo,
+			      ((u64)len_hi << 32) | len_lo);
+}
+
+#ifdef CONFIG_IA32_EMULATION
 /*
  * Another set for IA32/LFS -- x86_64 struct stat is different due to
  * support for 64bit inode numbers.
@@ -170,66 +229,6 @@ COMPAT_SYSCALL_DEFINE1(x86_mmap, struct mmap_arg_struct32 __user *, arg)
 			       a.offset>>PAGE_SHIFT);
 }
 
-/* warning: next two assume little endian */
-COMPAT_SYSCALL_DEFINE5(x86_pread, unsigned int, fd, char __user *, ubuf,
-		       u32, count, u32, poslo, u32, poshi)
-{
-	return ksys_pread64(fd, ubuf, count,
-			    ((loff_t)AA(poshi) << 32) | AA(poslo));
-}
-
-COMPAT_SYSCALL_DEFINE5(x86_pwrite, unsigned int, fd, const char __user *, ubuf,
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
-COMPAT_SYSCALL_DEFINE6(x86_fadvise64_64, int, fd, __u32, offset_low,
-		       __u32, offset_high, __u32, len_low, __u32, len_high,
-		       int, advice)
-{
-	return ksys_fadvise64_64(fd,
-				 (((u64)offset_high)<<32) | offset_low,
-				 (((u64)len_high)<<32) | len_low,
-				 advice);
-}
-
-COMPAT_SYSCALL_DEFINE4(x86_readahead, int, fd, unsigned int, off_lo,
-		       unsigned int, off_hi, size_t, count)
-{
-	return ksys_readahead(fd, ((u64)off_hi << 32) | off_lo, count);
-}
-
-COMPAT_SYSCALL_DEFINE6(x86_sync_file_range, int, fd, unsigned int, off_low,
-		       unsigned int, off_hi, unsigned int, n_low,
-		       unsigned int, n_hi, int, flags)
-{
-	return ksys_sync_file_range(fd,
-				    ((u64)off_hi << 32) | off_low,
-				    ((u64)n_hi << 32) | n_low, flags);
-}
-
-COMPAT_SYSCALL_DEFINE5(x86_fadvise64, int, fd, unsigned int, offset_lo,
-		       unsigned int, offset_hi, size_t, len, int, advice)
-{
-	return ksys_fadvise64_64(fd, ((u64)offset_hi << 32) | offset_lo,
-				 len, advice);
-}
-
-COMPAT_SYSCALL_DEFINE6(x86_fallocate, int, fd, int, mode,
-		       unsigned int, offset_lo, unsigned int, offset_hi,
-		       unsigned int, len_lo, unsigned int, len_hi)
-{
-	return ksys_fallocate(fd, mode, ((u64)offset_hi << 32) | offset_lo,
-			      ((u64)len_hi << 32) | len_lo);
-}
-
 /*
  * The 32-bit clone ABI is CONFIG_CLONE_BACKWARDS
  */
@@ -252,3 +251,4 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
 
 	return _do_fork(&args);
 }
+#endif /* CONFIG_IA32_EMULATION */
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 9649b5ad2ca2..d5520e92f89d 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -26,6 +26,16 @@
 
 #define old_mmap sys_old_mmap
 
+#define sys_x86_pread sys_pread64
+#define sys_x86_pwrite sys_pwrite64
+#define sys_x86_truncate64 sys_truncate64
+#define sys_x86_ftruncate64 sys_ftruncate64
+#define sys_x86_readahead sys_readahead
+#define sys_x86_fadvise64 sys_fadvise64
+#define sys_x86_fadvise64_64 sys_fadvise64_64
+#define sys_x86_sync_file_range sys_sync_file_range
+#define sys_x86_fallocate sys_fallocate
+
 #define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
 #include <asm/syscalls_32.h>
 
-- 
2.24.1

