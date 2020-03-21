Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B87C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B719120780
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCUPaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38919 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbgCUPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg59-00051Y-7C; Sat, 21 Mar 2020 16:30:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 156FB1C22E4;
        Sat, 21 Mar 2020 16:30:37 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:36 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Move sys_ni_syscall stub to common.c
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-7-brgerst@gmail.com>
References: <20200313195144.164260-7-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463674.28353.6214614962833183223.tip-bot2@tip-bot2>
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

Commit-ID:     cc42c045af1ff4dee875196f8fe7d6ed1f29ea64
Gitweb:        https://git.kernel.org/tip/cc42c045af1ff4dee875196f8fe7d6ed1f29ea64
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:32 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:20 +01:00

x86/entry/64: Move sys_ni_syscall stub to common.c

so it can be available to multiple syscall tables.  Also directly return
-ENOSYS instead of bouncing to the generic sys_ni_syscall().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200313195144.164260-7-brgerst@gmail.com

---
 arch/x86/entry/common.c                | 7 +++++++
 arch/x86/entry/syscall_64.c            | 7 -------
 arch/x86/include/asm/syscall_wrapper.h | 3 +++
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9747876..149bf54 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -438,3 +438,10 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 #endif
 }
 #endif
+
+#ifdef CONFIG_X86_64
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return -ENOSYS;
+}
+#endif
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index adf619a..058dc1b 100644
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
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 1d96cce..0f126e4 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -8,6 +8,9 @@
 
 struct pt_regs;
 
+extern asmlinkage long __x64_sys_ni_syscall(const struct pt_regs *regs);
+extern asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *regs);
+
 /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
 #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
 	__MAP(x,__SC_ARGS						\
