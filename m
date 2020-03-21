Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4E4C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD6520789
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgCUPav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38938 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgCUPao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:44 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg5B-00050N-94; Sat, 21 Mar 2020 16:30:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C68ED1C22E7;
        Sat, 21 Mar 2020 16:30:35 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:35 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Remove ptregs qualifier from syscall table
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-10-brgerst@gmail.com>
References: <20200313195144.164260-10-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463547.28353.6779026446666587633.tip-bot2@tip-bot2>
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

Commit-ID:     d3b1b776eefcc1695d15730f37cdaab201fd8707
Gitweb:        https://git.kernel.org/tip/d3b1b776eefcc1695d15730f37cdaab201fd8707
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:35 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:21 +01:00

x86/entry/64: Remove ptregs qualifier from syscall table

Now that the fast syscall path is removed, the ptregs qualifier is unused.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Link: https://lkml.kernel.org/r/20200313195144.164260-10-brgerst@gmail.com

---
 arch/x86/entry/syscalls/syscall_64.tbl | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 0b5a25b..e8fb722 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -23,7 +23,7 @@
 12	common	brk			__x64_sys_brk
 13	64	rt_sigaction		__x64_sys_rt_sigaction
 14	common	rt_sigprocmask		__x64_sys_rt_sigprocmask
-15	64	rt_sigreturn		__x64_sys_rt_sigreturn/ptregs
+15	64	rt_sigreturn		__x64_sys_rt_sigreturn
 16	64	ioctl			__x64_sys_ioctl
 17	common	pread64			__x64_sys_pread64
 18	common	pwrite64		__x64_sys_pwrite64
@@ -64,10 +64,10 @@
 53	common	socketpair		__x64_sys_socketpair
 54	64	setsockopt		__x64_sys_setsockopt
 55	64	getsockopt		__x64_sys_getsockopt
-56	common	clone			__x64_sys_clone/ptregs
-57	common	fork			__x64_sys_fork/ptregs
-58	common	vfork			__x64_sys_vfork/ptregs
-59	64	execve			__x64_sys_execve/ptregs
+56	common	clone			__x64_sys_clone
+57	common	fork			__x64_sys_fork
+58	common	vfork			__x64_sys_vfork
+59	64	execve			__x64_sys_execve
 60	common	exit			__x64_sys_exit
 61	common	wait4			__x64_sys_wait4
 62	common	kill			__x64_sys_kill
@@ -180,7 +180,7 @@
 169	common	reboot			__x64_sys_reboot
 170	common	sethostname		__x64_sys_sethostname
 171	common	setdomainname		__x64_sys_setdomainname
-172	common	iopl			__x64_sys_iopl/ptregs
+172	common	iopl			__x64_sys_iopl
 173	common	ioperm			__x64_sys_ioperm
 174	64	create_module
 175	common	init_module		__x64_sys_init_module
@@ -330,7 +330,7 @@
 319	common	memfd_create		__x64_sys_memfd_create
 320	common	kexec_file_load		__x64_sys_kexec_file_load
 321	common	bpf			__x64_sys_bpf
-322	64	execveat		__x64_sys_execveat/ptregs
+322	64	execveat		__x64_sys_execveat
 323	common	userfaultfd		__x64_sys_userfaultfd
 324	common	membarrier		__x64_sys_membarrier
 325	common	mlock2			__x64_sys_mlock2
@@ -356,7 +356,7 @@
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
-435	common	clone3			__x64_sys_clone3/ptregs
+435	common	clone3			__x64_sys_clone3
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 
@@ -374,7 +374,7 @@
 517	x32	recvfrom		__x32_compat_sys_recvfrom
 518	x32	sendmsg			__x32_compat_sys_sendmsg
 519	x32	recvmsg			__x32_compat_sys_recvmsg
-520	x32	execve			__x32_compat_sys_execve/ptregs
+520	x32	execve			__x32_compat_sys_execve
 521	x32	ptrace			__x32_compat_sys_ptrace
 522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
 523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
@@ -399,6 +399,6 @@
 542	x32	getsockopt		__x32_compat_sys_getsockopt
 543	x32	io_setup		__x32_compat_sys_io_setup
 544	x32	io_submit		__x32_compat_sys_io_submit
-545	x32	execveat		__x32_compat_sys_execveat/ptregs
+545	x32	execveat		__x32_compat_sys_execveat
 546	x32	preadv2			__x32_compat_sys_preadv64v2
 547	x32	pwritev2		__x32_compat_sys_pwritev64v2
