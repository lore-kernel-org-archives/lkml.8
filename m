Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663FDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F9C20738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgFVXqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:46:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54775 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730953AbgFVXqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:11 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8d-0005DO-Ki; Mon, 22 Jun 2020 23:46:07 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH 07/17] h8300: select HAVE_COPY_THREAD_TLS, switch to kernel_clone_args
Date:   Tue, 23 Jun 2020 01:43:16 +0200
Message-Id: <20200622234326.906346-8-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of a larger series that aims at getting rid of the
copy_thread()/copy_thread_tls() split that makes the process creation
codepaths in the kernel more convoluted and error-prone than they need
to be.
I'm converting all the remaining arches that haven't yet switched and
am collecting individual acks. Once I have them, I'll send the whole series
removing the copy_thread()/copy_thread_tls() split, the
HAVE_COPY_THREAD_TLS define and the legacy do_fork() helper. The only
kernel-wide process creation entry point for anything not going directly
through the syscall path will then be based on struct kernel_clone_args.
No more danger of weird process creation abi quirks between architectures
hopefully, and easier to maintain overall.
It also unblocks implementing clone3() on architectures not support
copy_thread_tls(). Any architecture that wants to implement clone3()
will need to select HAVE_COPY_THREAD_TLS and thus need to implement
copy_thread_tls(). So both goals are connected but independently
beneficial.

HAVE_COPY_THREAD_TLS means that a given architecture supports
CLONE_SETTLS and not setting it should usually mean that the
architectures doesn't implement it but that's not how things are. In
fact all architectures support CLONE_TLS it's just that they don't
follow the calling convention that HAVE_COPY_THREAD_TLS implies. That
means all architectures can be switched over to select
HAVE_COPY_THREAD_TLS. Once that is done we can remove that macro (yay,
less code), the unnecessary do_fork() export in kernel/fork.c, and also
rename copy_thread_tls() back to copy_thread(). At this point
copy_thread() becomes the main architecture specific part of process
creation but it will be the same layout and calling convention for all
architectures. (Once that is done we can probably cleanup each
copy_thread() function even more but that's for the future.)

Though h8300 doesn't not suppor the CLONE_SETTLS flag there's no reason to
not switch to the copy_thread_tls() calling convention. As before
CLONE_SETTLS with legacy clone will just be ignored. This brings us one
step closer to getting rid of the copy_thread()/copy_thread_tls() split we
still have and ultimately the HAVE_COPY_THREAD_TLS define in general. A lot
of architectures have already converted and h8300 is one of the few hat
haven't yet. This also unblocks implementing the clone3() syscall on h8300.
Once that is done we can get of another ARCH_WANTS_* macro.

Once Any architecture that supports HAVE_COPY_THREAD_TLS cannot call the
do_fork() helper anymore. This is fine and intended since it should be
removed in favor of the new, cleaner _do_fork() calling convention based
on struct kernel_clone_args. In fact, most architectures have already
switched.  With this patch, h8300 joins the other arches which can't use
the fork(), vfork(), clone(), clone3() syscalls directly and who follow
the new process creation calling convention that is based on struct
kernel_clone_args which we introduced a while back. This means less
custom assembly in the architectures entry path to set up the registers
before calling into the process creation helper and it is easier to to
support new features without having to adapt calling conventions. It
also unifies all process creation paths between fork(), vfork(),
clone(), and clone3(). (We can't fix the ABI nightmare that legacy
clone() is but we can prevent stuff like this happening in the future.)

For some more context, please see:
commit 606e9ad20094f6d500166881d301f31a51bc8aa7
Merge: ac61145a725a 457677c70c76
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Jan 11 15:33:48 2020 -0800

    Merge tag 'clone3-tls-v5.5-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux

    Pull thread fixes from Christian Brauner:
     "This contains a series of patches to fix CLONE_SETTLS when used with
      clone3().

      The clone3() syscall passes the tls argument through struct clone_args
      instead of a register. This means, all architectures that do not
      implement copy_thread_tls() but still support CLONE_SETTLS via
      copy_thread() expecting the tls to be located in a register argument
      based on clone() are currently unfortunately broken. Their tls value
      will be garbage.

      The patch series fixes this on all architectures that currently define
      __ARCH_WANT_SYS_CLONE3. It also adds a compile-time check to ensure
      that any architecture that enables clone3() in the future is forced to
      also implement copy_thread_tls().

      My ultimate goal is to get rid of the copy_thread()/copy_thread_tls()
      split and just have copy_thread_tls() at some point in the not too
      distant future (Maybe even renaming copy_thread_tls() back to simply
      copy_thread() once the old function is ripped from all arches). This
      is dependent now on all arches supporting clone3().

      While all relevant arches do that now there are still four missing:
      ia64, m68k, sh and sparc. They have the system call reserved, but not
      implemented. Once they all implement clone3() we can get rid of
      ARCH_WANT_SYS_CLONE3 and HAVE_COPY_THREAD_TLS.

Note that in the meantime, m68k has already switched to the new calling
convention. And I've got sparc patches acked by Dave, patches for ia64, and
nios2 have been sent out and are ready too.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/h8300/Kconfig          |  1 +
 arch/h8300/kernel/process.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index d11666d538fe..de0eb417a0b9 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -26,6 +26,7 @@ config H8300
 	select HAVE_ARCH_HASH
 	select CPU_NO_EFFICIENT_FFS
 	select UACCESS_MEMCPY
+	select HAVE_COPY_THREAD_TLS
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 0ef55e3052c9..ae23de4dcf42 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -105,9 +105,9 @@ void flush_thread(void)
 {
 }
 
-int copy_thread(unsigned long clone_flags,
-		unsigned long usp, unsigned long topstk,
-		struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+		    unsigned long topstk, struct task_struct *p,
+		    unsigned long tls)
 {
 	struct pt_regs *childregs;
 
@@ -159,11 +159,19 @@ asmlinkage int sys_clone(unsigned long __user *args)
 	unsigned long  newsp;
 	uintptr_t parent_tidptr;
 	uintptr_t child_tidptr;
+	struct kernel_clone_args kargs = {};
 
 	get_user(clone_flags, &args[0]);
 	get_user(newsp, &args[1]);
 	get_user(parent_tidptr, &args[2]);
 	get_user(child_tidptr, &args[3]);
-	return do_fork(clone_flags, newsp, 0,
-		       (int __user *)parent_tidptr, (int __user *)child_tidptr);
+
+	kargs.flags		= (lower_32_bits(clone_flags) & ~CSIGNAL);
+	kargs.pidfd		= (int __user *)parent_tidptr;
+	kargs.child_tid		= (int __user *)child_tidptr;
+	kargs.parent_tid	= (int __user *)parent_tidptr;
+	kargs.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL);
+	kargs.stack		= newsp;
+
+	return _do_fork(&kargs);
 }
-- 
2.27.0

