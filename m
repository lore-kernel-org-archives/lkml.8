Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C0FC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BFD20776
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCUPau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38927 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgCUPan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg59-000523-R2; Sat, 21 Mar 2020 16:30:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8C6521C22E9;
        Sat, 21 Mar 2020 16:30:37 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:37 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Use syscall wrappers for x32_rt_sigreturn
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-6-brgerst@gmail.com>
References: <20200313195144.164260-6-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463716.28353.2010597040701838211.tip-bot2@tip-bot2>
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

Commit-ID:     27dd84fafcd5e3c565164bb303fe8ec8ef59e147
Gitweb:        https://git.kernel.org/tip/27dd84fafcd5e3c565164bb303fe8ec8ef59e147
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:31 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:20 +01:00

x86/entry/64: Use syscall wrappers for x32_rt_sigreturn

Add missing syscall wrapper for x32_rt_sigreturn().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200313195144.164260-6-brgerst@gmail.com

---
 arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
 arch/x86/include/asm/sighandling.h     | 5 -----
 arch/x86/kernel/signal.c               | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 44d510b..0b5a25b 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -367,7 +367,7 @@
 # is defined.
 #
 512	x32	rt_sigaction		__x32_compat_sys_rt_sigaction
-513	x32	rt_sigreturn		sys32_x32_rt_sigreturn
+513	x32	rt_sigreturn		__x32_compat_sys_x32_rt_sigreturn
 514	x32	ioctl			__x32_compat_sys_ioctl
 515	x32	readv			__x32_compat_sys_readv
 516	x32	writev			__x32_compat_sys_writev
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index 2fcbd6f..bd26834 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -17,9 +17,4 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask);
 
-
-#ifdef CONFIG_X86_X32_ABI
-asmlinkage long sys32_x32_rt_sigreturn(void);
-#endif
-
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8a29573..8609049 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -859,7 +859,7 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
 }
 
 #ifdef CONFIG_X86_X32_ABI
-asmlinkage long sys32_x32_rt_sigreturn(void)
+COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe_x32 __user *frame;
