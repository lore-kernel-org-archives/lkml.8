Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD80C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F2D208DB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCUPag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38872 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbgCUPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg52-0004xJ-1G; Sat, 21 Mar 2020 16:30:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 937061C22E4;
        Sat, 21 Mar 2020 16:30:31 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:31 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86: Remove unneeded includes
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-19-brgerst@gmail.com>
References: <20200313195144.164260-19-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463124.28353.11209623914740968.tip-bot2@tip-bot2>
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

Commit-ID:     ffd75b373f3656cbb593c5221cc36ce232b7bbc1
Gitweb:        https://git.kernel.org/tip/ffd75b373f3656cbb593c5221cc36ce232b7bbc1
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:44 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:25 +01:00

x86: Remove unneeded includes

Clean up includes of and in <asm/syscalls.h>

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200313195144.164260-19-brgerst@gmail.com

---
 arch/x86/include/asm/syscalls.h | 5 -----
 arch/x86/kernel/ldt.c           | 1 -
 arch/x86/kernel/process.c       | 1 -
 arch/x86/kernel/process_32.c    | 1 -
 arch/x86/kernel/process_64.c    | 1 -
 arch/x86/kernel/signal.c        | 2 --
 arch/x86/kernel/sys_x86_64.c    | 1 -
 7 files changed, 12 deletions(-)

diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index 06cbdca..6714a35 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -8,11 +8,6 @@
 #ifndef _ASM_X86_SYSCALLS_H
 #define _ASM_X86_SYSCALLS_H
 
-#include <linux/compiler.h>
-#include <linux/linkage.h>
-#include <linux/signal.h>
-#include <linux/types.h>
-
 /* Common in X86_32 and X86_64 */
 /* kernel/ioport.c */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on);
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index c57e1ca..84c3ba3 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -27,7 +27,6 @@
 #include <asm/tlb.h>
 #include <asm/desc.h>
 #include <asm/mmu_context.h>
-#include <asm/syscalls.h>
 #include <asm/pgtable_areas.h>
 
 /* This is a multiple of PAGE_SIZE. */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 839b524..d78e228 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -28,7 +28,6 @@
 #include <linux/hw_breakpoint.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
-#include <asm/syscalls.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
 #include <asm/fpu/internal.h>
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5052ced..954b013 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -49,7 +49,6 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
-#include <asm/syscalls.h>
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ffd4978..5ef9d8f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -48,7 +48,6 @@
 #include <asm/desc.h>
 #include <asm/proto.h>
 #include <asm/ia32.h>
-#include <asm/syscalls.h>
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8609049..0364f8c 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -42,8 +42,6 @@
 #endif /* CONFIG_X86_64 */
 
 #include <asm/syscall.h>
-#include <asm/syscalls.h>
-
 #include <asm/sigframe.h>
 #include <asm/signal.h>
 
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index ca3c11a..504fa54 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -21,7 +21,6 @@
 
 #include <asm/elf.h>
 #include <asm/ia32.h>
-#include <asm/syscalls.h>
 
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
