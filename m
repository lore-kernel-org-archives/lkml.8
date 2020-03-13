Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE97C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4638206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WedUWvmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCMTwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37735 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgCMTwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id z25so9811518qkj.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aGWeeZxam+RA/gOZU30VbNy4/YYZFegQB/HTp8l/H2I=;
        b=WedUWvmWHVcKnZmQxhB+zgv/qtNcrl4D/cPf8L53fAhAbaC3OlYN6bfSHNMVkTBQ5I
         zbB/jRnFOz9dI46d9LecaG+iJChCELSOOtQ4mWLMdpJNYJg4v3H2OWfSFus7JheeZHcs
         7EPPKpl69F+ynR8N9zVOD2IcSSLikyEEydwumzpijFKOz+Xe5OPqJRUvDbfulEy+Y7un
         8Q3E8uLYtOLCotLTpKmLjf2dkQnMfCjj625cR3G74UP2cBXWe8u7LLqpXBZx6SfEdxvZ
         n/SZ7o3b5Aiv2S3rmsXd4FvY2MSYtw41ATbDbdUCg+P7Orx5ic5v6SJaHzz0VJNRCC1F
         5JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aGWeeZxam+RA/gOZU30VbNy4/YYZFegQB/HTp8l/H2I=;
        b=M6vvj3llYd/gbtGQryKYUD/EtpttmVItPDvPvMwbk13G9Zp4tya9XCTik1dm2IW+Oc
         3VaHINOiRE+xo3e5YP6CeoIM5LCl7s9S9TH/PEn4/H3wZAZzaVUBmTi3orK9ygaAm2y3
         kSU9uGfEwa/AK3tg3bLAVJ9uCYjKBtGrR9o7u9nHKVYBZbLJvocyYDl0qZaHQ8I8+0ht
         i+odMawN8p/eqzx4k6BXYa8IsglfzQAQeaLya9B0sqw974uFH+6P16kuHydpP8hAXrZb
         4+ASI4luajsL08oT+DZOllAtJvTb9Qq3PhitESICZUA4upTKhjd9THDd57crORGek4UU
         iZmg==
X-Gm-Message-State: ANhLgQ1Sd0gWMUCPBR54XfpjnysJTaSHcoVuAHYeMamTvP9fqxsyvikW
        feGohq6xhnUtjNdlkUtIXWJ8S2o=
X-Google-Smtp-Source: ADFU+vvIZ8hjl/yFEXVrWM/V79YuNj5nRLl4z9KLzz4h3Z33OOIQEo28pgv+vQb0+jqPbzk5ctD8Xg==
X-Received: by 2002:a37:e10f:: with SMTP id c15mr14229396qkm.262.1584129150024;
        Fri, 13 Mar 2020 12:52:30 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:29 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 15/18] x86: Use IA32-specific wrappers for syscalls taking 64-bit arguments
Date:   Fri, 13 Mar 2020 15:51:41 -0400
Message-Id: <20200313195144.164260-16-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the 32-bit syscall interface, 64-bit arguments (loff_t) are passed via
a pair of 32-bit registers.  These register pairs end up in consecutive stack
slots, which matches the C ABI for 64-bit arguments.  But when accessing the
registers directly from pt_regs, the wrapper needs to manually reassemble the
64-bit value.  These wrappers already exist for 32-bit compat, so make them
available to 32-bit native in preparation for enabling pt_regs-based syscalls.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  18 ++--
 arch/x86/ia32/Makefile                 |   2 +-
 arch/x86/kernel/Makefile               |   2 +
 arch/x86/{ia32 => kernel}/sys_ia32.c   | 131 +++++++++++++------------
 arch/x86/um/Makefile                   |   1 +
 5 files changed, 79 insertions(+), 75 deletions(-)
 rename arch/x86/{ia32 => kernel}/sys_ia32.c (83%)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0b8e24cb981d..54581ac671b4 100644
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
index a189dc6f98dc..ab03fede1422 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/kernel/sys_ia32.c
@@ -51,20 +51,80 @@
 
 #define AA(__x)		((unsigned long)(__x))
 
-
-COMPAT_SYSCALL_DEFINE3(ia32_truncate64, const char __user *, filename,
-		       unsigned long, offset_low, unsigned long, offset_high)
+SYSCALL_DEFINE3(ia32_truncate64, const char __user *, filename,
+		unsigned long, offset_low, unsigned long, offset_high)
 {
 	return ksys_truncate(filename,
 			    ((loff_t) offset_high << 32) | offset_low);
 }
 
-COMPAT_SYSCALL_DEFINE3(ia32_ftruncate64, unsigned int, fd,
-		       unsigned long, offset_low, unsigned long, offset_high)
+SYSCALL_DEFINE3(ia32_ftruncate64, unsigned int, fd,
+		unsigned long, offset_low, unsigned long, offset_high)
 {
 	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
 }
 
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
 /*
  * Another set for IA32/LFS -- x86_64 struct stat is different due to
  * support for 64bit inode numbers.
@@ -170,66 +230,6 @@ COMPAT_SYSCALL_DEFINE1(ia32_mmap, struct mmap_arg_struct32 __user *, arg)
 			       a.offset>>PAGE_SHIFT);
 }
 
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
 /*
  * The 32-bit clone ABI is CONFIG_CLONE_BACKWARDS
  */
@@ -252,3 +252,4 @@ COMPAT_SYSCALL_DEFINE5(ia32_clone, unsigned long, clone_flags,
 
 	return _do_fork(&args);
 }
+#endif /* CONFIG_IA32_EMULATION */
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 33c51c064c77..77f70b969d14 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -21,6 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
+subarch-y += ../kernel/sys_ia32.o
 
 else
 
-- 
2.24.1

