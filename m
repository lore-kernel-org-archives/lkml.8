Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10327C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B252074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpSDZ4eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgCMTwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42895 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgCMTwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id g16so8624728qtp.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fkRgnGKYSaLMapcywZ52mczBOanYF+lRKhzYb9Tfgw=;
        b=PpSDZ4eF7TgkubggidA49KIUFJEmjLsjOtGfQ9RZDFDKERYYi7SDN1Nfb5yqKPXwi5
         aFjbJByjO36CZJ+efNk8rQlS1SEfc69HZ2WoxkiwMJcZF+aXt7SH7JiyU1z0ePiSjupP
         1bazLW7g5a11wH7RJ9ABZ9f7Zcg7M0Z576ZprDAplHKcGmrWRB1XqIvINEVXQxgmoxkA
         KjsT0lQLb/ei6PRxrSgIBfhUQlbM7Pk/U3GUJytW/uryV0YbZf06ptUVeZjAXL+Elgsr
         DOIR9VHafik7ithZlnolCiCjyi6b08SR75S0vQKB5syaoTTvb0jEPwWVIOUWb4Viamed
         032g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fkRgnGKYSaLMapcywZ52mczBOanYF+lRKhzYb9Tfgw=;
        b=XFwssJx8lMv/XLO2zMQeCeqAeFGj2UsmgNIHVrww9OKh597gRnDaiK4f8cJXR3Ryhm
         Xyh1oJ5KyddYmOCYBQKiUz2a+qShFava6cH0NOTUnEDes3d1PtgCFZCwc1BeP0ip9du9
         oYLjyI1iKLB8c+FYe7pd2+HqVtyKlEdeO2S6fxlRj74KAB9zlj2Hj8bcbDCDCoAHBx74
         3GU35E9BQfoFoU73bykizCZBYTW/wCLjc1Q4yGWnbFyk5bMK4nKJdapQEtqNn4GhdOMv
         np4aTWcJ8KtEvBdudj4Nt3mNmLeS4DEAVHqIdsVcRbrdhD4cgbfzskqDt+O5FWbDuY+2
         tDBA==
X-Gm-Message-State: ANhLgQ0YTYxBt4baG9YLTW1+YM9gl13LvNaOfMYml/QSNRShrCF2AvDh
        a+V+ooYF1Hv7rhhfYPHCBQ4D4VM=
X-Google-Smtp-Source: ADFU+vtwuQnAfGhreFLgTTWw+mf0MBo49T3Z463BBsy/Ew8nZLHWqi1hW6QEQW1FUcdYItA6qJZkbg==
X-Received: by 2002:ac8:2bf8:: with SMTP id n53mr6769567qtn.1.1584129148668;
        Fri, 13 Mar 2020 12:52:28 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:27 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 14/18] x86, syscalls: Rename 32-bit specific syscalls
Date:   Fri, 13 Mar 2020 15:51:40 -0400
Message-Id: <20200313195144.164260-15-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the syscalls that only exist for 32-bit from x86_* to ia32_* to make it
clear they are for 32-bit only.  Also rename the functions to match the syscall
name.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 30 +++++++++++++-------------
 arch/x86/ia32/sys_ia32.c               | 30 +++++++++++++-------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index b0712cdae7d8..0b8e24cb981d 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -101,7 +101,7 @@
 87	i386	swapon			sys_swapon
 88	i386	reboot			sys_reboot
 89	i386	readdir			sys_old_readdir			compat_sys_old_readdir
-90	i386	mmap			sys_old_mmap			compat_sys_x86_mmap
+90	i386	mmap			sys_old_mmap			compat_sys_ia32_mmap
 91	i386	munmap			sys_munmap
 92	i386	truncate		sys_truncate			compat_sys_truncate
 93	i386	ftruncate		sys_ftruncate			compat_sys_ftruncate
@@ -131,7 +131,7 @@
 117	i386	ipc			sys_ipc				compat_sys_ipc
 118	i386	fsync			sys_fsync
 119	i386	sigreturn		sys_sigreturn			compat_sys_sigreturn
-120	i386	clone			sys_clone			compat_sys_x86_clone
+120	i386	clone			sys_clone			compat_sys_ia32_clone
 121	i386	setdomainname		sys_setdomainname
 122	i386	uname			sys_newuname
 123	i386	modify_ldt		sys_modify_ldt
@@ -191,8 +191,8 @@
 177	i386	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
 178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 179	i386	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
-180	i386	pread64			sys_pread64			compat_sys_x86_pread
-181	i386	pwrite64		sys_pwrite64			compat_sys_x86_pwrite
+180	i386	pread64			sys_pread64			compat_sys_ia32_pread64
+181	i386	pwrite64		sys_pwrite64			compat_sys_ia32_pwrite64
 182	i386	chown			sys_chown16
 183	i386	getcwd			sys_getcwd
 184	i386	capget			sys_capget
@@ -204,11 +204,11 @@
 190	i386	vfork			sys_vfork
 191	i386	ugetrlimit		sys_getrlimit			compat_sys_getrlimit
 192	i386	mmap2			sys_mmap_pgoff
-193	i386	truncate64		sys_truncate64			compat_sys_x86_truncate64
-194	i386	ftruncate64		sys_ftruncate64			compat_sys_x86_ftruncate64
-195	i386	stat64			sys_stat64			compat_sys_x86_stat64
-196	i386	lstat64			sys_lstat64			compat_sys_x86_lstat64
-197	i386	fstat64			sys_fstat64			compat_sys_x86_fstat64
+193	i386	truncate64		sys_truncate64			compat_sys_ia32_truncate64
+194	i386	ftruncate64		sys_ftruncate64			compat_sys_ia32_ftruncate64
+195	i386	stat64			sys_stat64			compat_sys_ia32_stat64
+196	i386	lstat64			sys_lstat64			compat_sys_ia32_lstat64
+197	i386	fstat64			sys_fstat64			compat_sys_ia32_fstat64
 198	i386	lchown32		sys_lchown
 199	i386	getuid32		sys_getuid
 200	i386	getgid32		sys_getgid
@@ -236,7 +236,7 @@
 # 222 is unused
 # 223 is unused
 224	i386	gettid			sys_gettid
-225	i386	readahead		sys_readahead			compat_sys_x86_readahead
+225	i386	readahead		sys_readahead			compat_sys_ia32_readahead
 226	i386	setxattr		sys_setxattr
 227	i386	lsetxattr		sys_lsetxattr
 228	i386	fsetxattr		sys_fsetxattr
@@ -261,7 +261,7 @@
 247	i386	io_getevents		sys_io_getevents_time32
 248	i386	io_submit		sys_io_submit			compat_sys_io_submit
 249	i386	io_cancel		sys_io_cancel
-250	i386	fadvise64		sys_fadvise64			compat_sys_x86_fadvise64
+250	i386	fadvise64		sys_fadvise64			compat_sys_ia32_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
 252	i386	exit_group		sys_exit_group
 253	i386	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
@@ -283,7 +283,7 @@
 269	i386	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
 270	i386	tgkill			sys_tgkill
 271	i386	utimes			sys_utimes_time32
-272	i386	fadvise64_64		sys_fadvise64_64		compat_sys_x86_fadvise64_64
+272	i386	fadvise64_64		sys_fadvise64_64		compat_sys_ia32_fadvise64_64
 273	i386	vserver
 274	i386	mbind			sys_mbind
 275	i386	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
@@ -311,7 +311,7 @@
 297	i386	mknodat			sys_mknodat
 298	i386	fchownat		sys_fchownat
 299	i386	futimesat		sys_futimesat_time32
-300	i386	fstatat64		sys_fstatat64			compat_sys_x86_fstatat
+300	i386	fstatat64		sys_fstatat64			compat_sys_ia32_fstatat64
 301	i386	unlinkat		sys_unlinkat
 302	i386	renameat		sys_renameat
 303	i386	linkat			sys_linkat
@@ -325,7 +325,7 @@
 311	i386	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
 312	i386	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
 313	i386	splice			sys_splice
-314	i386	sync_file_range		sys_sync_file_range		compat_sys_x86_sync_file_range
+314	i386	sync_file_range		sys_sync_file_range		compat_sys_ia32_sync_file_range
 315	i386	tee			sys_tee
 316	i386	vmsplice		sys_vmsplice			compat_sys_vmsplice
 317	i386	move_pages		sys_move_pages			compat_sys_move_pages
@@ -335,7 +335,7 @@
 321	i386	signalfd		sys_signalfd			compat_sys_signalfd
 322	i386	timerfd_create		sys_timerfd_create
 323	i386	eventfd			sys_eventfd
-324	i386	fallocate		sys_fallocate			compat_sys_x86_fallocate
+324	i386	fallocate		sys_fallocate			compat_sys_ia32_fallocate
 325	i386	timerfd_settime		sys_timerfd_settime32
 326	i386	timerfd_gettime		sys_timerfd_gettime32
 327	i386	signalfd4		sys_signalfd4			compat_sys_signalfd4
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 21790307121e..a189dc6f98dc 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -52,14 +52,14 @@
 #define AA(__x)		((unsigned long)(__x))
 
 
-COMPAT_SYSCALL_DEFINE3(x86_truncate64, const char __user *, filename,
+COMPAT_SYSCALL_DEFINE3(ia32_truncate64, const char __user *, filename,
 		       unsigned long, offset_low, unsigned long, offset_high)
 {
 	return ksys_truncate(filename,
 			    ((loff_t) offset_high << 32) | offset_low);
 }
 
-COMPAT_SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
+COMPAT_SYSCALL_DEFINE3(ia32_ftruncate64, unsigned int, fd,
 		       unsigned long, offset_low, unsigned long, offset_high)
 {
 	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
@@ -97,7 +97,7 @@ static int cp_stat64(struct stat64 __user *ubuf, struct kstat *stat)
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE2(x86_stat64, const char __user *, filename,
+COMPAT_SYSCALL_DEFINE2(ia32_stat64, const char __user *, filename,
 		       struct stat64 __user *, statbuf)
 {
 	struct kstat stat;
@@ -108,7 +108,7 @@ COMPAT_SYSCALL_DEFINE2(x86_stat64, const char __user *, filename,
 	return ret;
 }
 
-COMPAT_SYSCALL_DEFINE2(x86_lstat64, const char __user *, filename,
+COMPAT_SYSCALL_DEFINE2(ia32_lstat64, const char __user *, filename,
 		       struct stat64 __user *, statbuf)
 {
 	struct kstat stat;
@@ -118,7 +118,7 @@ COMPAT_SYSCALL_DEFINE2(x86_lstat64, const char __user *, filename,
 	return ret;
 }
 
-COMPAT_SYSCALL_DEFINE2(x86_fstat64, unsigned int, fd,
+COMPAT_SYSCALL_DEFINE2(ia32_fstat64, unsigned int, fd,
 		       struct stat64 __user *, statbuf)
 {
 	struct kstat stat;
@@ -128,7 +128,7 @@ COMPAT_SYSCALL_DEFINE2(x86_fstat64, unsigned int, fd,
 	return ret;
 }
 
-COMPAT_SYSCALL_DEFINE4(x86_fstatat, unsigned int, dfd,
+COMPAT_SYSCALL_DEFINE4(ia32_fstatat64, unsigned int, dfd,
 		       const char __user *, filename,
 		       struct stat64 __user *, statbuf, int, flag)
 {
@@ -156,7 +156,7 @@ struct mmap_arg_struct32 {
 	unsigned int offset;
 };
 
-COMPAT_SYSCALL_DEFINE1(x86_mmap, struct mmap_arg_struct32 __user *, arg)
+COMPAT_SYSCALL_DEFINE1(ia32_mmap, struct mmap_arg_struct32 __user *, arg)
 {
 	struct mmap_arg_struct32 a;
 
@@ -171,14 +171,14 @@ COMPAT_SYSCALL_DEFINE1(x86_mmap, struct mmap_arg_struct32 __user *, arg)
 }
 
 /* warning: next two assume little endian */
-COMPAT_SYSCALL_DEFINE5(x86_pread, unsigned int, fd, char __user *, ubuf,
+COMPAT_SYSCALL_DEFINE5(ia32_pread64, unsigned int, fd, char __user *, ubuf,
 		       u32, count, u32, poslo, u32, poshi)
 {
 	return ksys_pread64(fd, ubuf, count,
 			    ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
-COMPAT_SYSCALL_DEFINE5(x86_pwrite, unsigned int, fd, const char __user *, ubuf,
+COMPAT_SYSCALL_DEFINE5(ia32_pwrite64, unsigned int, fd, const char __user *, ubuf,
 		       u32, count, u32, poslo, u32, poshi)
 {
 	return ksys_pwrite64(fd, ubuf, count,
@@ -190,7 +190,7 @@ COMPAT_SYSCALL_DEFINE5(x86_pwrite, unsigned int, fd, const char __user *, ubuf,
  * Some system calls that need sign extended arguments. This could be
  * done by a generic wrapper.
  */
-COMPAT_SYSCALL_DEFINE6(x86_fadvise64_64, int, fd, __u32, offset_low,
+COMPAT_SYSCALL_DEFINE6(ia32_fadvise64_64, int, fd, __u32, offset_low,
 		       __u32, offset_high, __u32, len_low, __u32, len_high,
 		       int, advice)
 {
@@ -200,13 +200,13 @@ COMPAT_SYSCALL_DEFINE6(x86_fadvise64_64, int, fd, __u32, offset_low,
 				 advice);
 }
 
-COMPAT_SYSCALL_DEFINE4(x86_readahead, int, fd, unsigned int, off_lo,
+COMPAT_SYSCALL_DEFINE4(ia32_readahead, int, fd, unsigned int, off_lo,
 		       unsigned int, off_hi, size_t, count)
 {
 	return ksys_readahead(fd, ((u64)off_hi << 32) | off_lo, count);
 }
 
-COMPAT_SYSCALL_DEFINE6(x86_sync_file_range, int, fd, unsigned int, off_low,
+COMPAT_SYSCALL_DEFINE6(ia32_sync_file_range, int, fd, unsigned int, off_low,
 		       unsigned int, off_hi, unsigned int, n_low,
 		       unsigned int, n_hi, int, flags)
 {
@@ -215,14 +215,14 @@ COMPAT_SYSCALL_DEFINE6(x86_sync_file_range, int, fd, unsigned int, off_low,
 				    ((u64)n_hi << 32) | n_low, flags);
 }
 
-COMPAT_SYSCALL_DEFINE5(x86_fadvise64, int, fd, unsigned int, offset_lo,
+COMPAT_SYSCALL_DEFINE5(ia32_fadvise64, int, fd, unsigned int, offset_lo,
 		       unsigned int, offset_hi, size_t, len, int, advice)
 {
 	return ksys_fadvise64_64(fd, ((u64)offset_hi << 32) | offset_lo,
 				 len, advice);
 }
 
-COMPAT_SYSCALL_DEFINE6(x86_fallocate, int, fd, int, mode,
+COMPAT_SYSCALL_DEFINE6(ia32_fallocate, int, fd, int, mode,
 		       unsigned int, offset_lo, unsigned int, offset_hi,
 		       unsigned int, len_lo, unsigned int, len_hi)
 {
@@ -233,7 +233,7 @@ COMPAT_SYSCALL_DEFINE6(x86_fallocate, int, fd, int, mode,
 /*
  * The 32-bit clone ABI is CONFIG_CLONE_BACKWARDS
  */
-COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
+COMPAT_SYSCALL_DEFINE5(ia32_clone, unsigned long, clone_flags,
 		       unsigned long, newsp, int __user *, parent_tidptr,
 		       unsigned long, tls_val, int __user *, child_tidptr)
 {
-- 
2.24.1

