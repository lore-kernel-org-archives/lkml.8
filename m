Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5602086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hsqwJcOC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Za092CMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbgGVWBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:01:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbgGVWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:01:13 -0400
Date:   Wed, 22 Jul 2020 22:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdnPhZuh/HPM/I7q1U7IP+2jIdnuESmQR94eRlQ8J6k=;
        b=hsqwJcOCcj89tdKOjvdHPMKyZ/mptdtyMlFhPkM4TgAAFKlhgDNHqHoC9vq4KSZSheVaIE
        lDfvITsWx3Jj1xqXTiswYjCtvjFEyGmzqjzeRsHdXsYXA+VfUlWcMgQbNoLP0DTMUfWTVx
        EfLp++3K6UyDsEDa1mpi++x1cT1mMD3d3v+Ct00zzrrz098tBFcxOWQEtln5PhPNQBrDqL
        S55fb/dfwQsg+Q4CMbWF2jGLoeHMaNe+Uva1xcTPkRnuV4hpsa3sLJVudCshVriWglmKpn
        /0dSJxP+zWAOmB4Rk3Yzltq5H5T80xQcLj/Rq2+vsO6PDl/vzPeeNtYoCmKAaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdnPhZuh/HPM/I7q1U7IP+2jIdnuESmQR94eRlQ8J6k=;
        b=Za092CMAB4u03jwFqHpuFAX6VoUyQUEvfM9Px5RdGhm7Hj7tyN55IstebcRCoLtX6jBmAj
        9z/FrFJ1P5u/oSDQ==
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/dumpstack: Add log_lvl to __show_regs()
Cc:     Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200629144847.492794-3-dima@arista.com>
References: <20200629144847.492794-3-dima@arista.com>
MIME-Version: 1.0
Message-ID: <159545526937.4006.3207917869633596873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     44e215352cf17333992d56941b5bf4af60a67609
Gitweb:        https://git.kernel.org/tip/44e215352cf17333992d56941b5bf4af60a67609
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Mon, 29 Jun 2020 15:48:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Jul 2020 23:56:53 +02:00

x86/dumpstack: Add log_lvl to __show_regs()

show_trace_log_lvl() provides x86 platform-specific way to unwind
backtrace with a given log level. Unfortunately, registers dump(s) are
not printed with the same log level - instead, KERN_DEFAULT is always
used.

Arista's switches uses quite common setup with rsyslog, where only
urgent messages goes to console (console_log_level=KERN_ERR), everything
else goes into /var/log/ as the console baud-rate often is indecently
slow (9600 bps).

Backtrace dumps without registers printed have proven to be as useful as
morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
(which I believe is still the most elegant way to fix raciness of sysrq[1])
the log level should be passed down the stack to register dumping
functions. Besides, there is a potential use-case for printing traces
with KERN_DEBUG level [2] (where registers dump shouldn't appear with
higher log level).

Add log_lvl parameter to __show_regs().
Keep the used log level intact to separate visible change.

[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
[2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Petr Mladek <pmladek@suse.com>
Link: https://lkml.kernel.org/r/20200629144847.492794-3-dima@arista.com

---
 arch/x86/include/asm/kdebug.h |  3 +-
 arch/x86/kernel/dumpstack.c   |  9 ++++--
 arch/x86/kernel/process_32.c  | 29 +++++++++----------
 arch/x86/kernel/process_64.c  | 51 +++++++++++++++++-----------------
 4 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index da024bb..d1514e7 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -36,7 +36,8 @@ extern void die(const char *, struct pt_regs *,long);
 void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_stack_regs(struct pt_regs *regs);
-extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
+extern void __show_regs(struct pt_regs *regs, enum show_regs_mode,
+			const char *log_lvl);
 extern void show_iret_regs(struct pt_regs *regs, const char *log_lvl);
 extern unsigned long oops_begin(void);
 extern void oops_end(unsigned long, struct pt_regs *, int signr);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index c36d629..4954d66 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -146,7 +146,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	 * they can be printed in the right context.
 	 */
 	if (!partial && on_stack(info, regs, sizeof(*regs))) {
-		__show_regs(regs, SHOW_REGS_SHORT);
+		__show_regs(regs, SHOW_REGS_SHORT, KERN_DEFAULT);
 
 	} else if (partial && on_stack(info, (void *)regs + IRET_FRAME_OFFSET,
 				       IRET_FRAME_SIZE)) {
@@ -345,7 +345,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	oops_exit();
 
 	/* Executive summary in case the oops scrolled away */
-	__show_regs(&exec_summary_regs, SHOW_REGS_ALL);
+	__show_regs(&exec_summary_regs, SHOW_REGS_ALL, KERN_DEFAULT);
 
 	if (!signr)
 		return;
@@ -437,9 +437,12 @@ void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr)
 
 void show_regs(struct pt_regs *regs)
 {
+	enum show_regs_mode print_kernel_regs;
+
 	show_regs_print_info(KERN_DEFAULT);
 
-	__show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
+	print_kernel_regs = user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL;
+	__show_regs(regs, print_kernel_regs, KERN_DEFAULT);
 
 	/*
 	 * When in-kernel, we also print out the stack at the time of the fault..
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index acfd6d2..4f2f54e 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -56,7 +56,8 @@
 
 #include "process.h"
 
-void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
+		 const char *log_lvl)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -67,14 +68,14 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	else
 		savesegment(gs, gs);
 
-	show_ip(regs, KERN_DEFAULT);
+	show_ip(regs, log_lvl);
 
-	printk(KERN_DEFAULT "EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
-		regs->ax, regs->bx, regs->cx, regs->dx);
-	printk(KERN_DEFAULT "ESI: %08lx EDI: %08lx EBP: %08lx ESP: %08lx\n",
-		regs->si, regs->di, regs->bp, regs->sp);
-	printk(KERN_DEFAULT "DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x EFLAGS: %08lx\n",
-	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, regs->ss, regs->flags);
+	printk("%sEAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
+		log_lvl, regs->ax, regs->bx, regs->cx, regs->dx);
+	printk("%sESI: %08lx EDI: %08lx EBP: %08lx ESP: %08lx\n",
+		log_lvl, regs->si, regs->di, regs->bp, regs->sp);
+	printk("%sDS: %04x ES: %04x FS: %04x GS: %04x SS: %04x EFLAGS: %08lx\n",
+	       log_lvl, (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, regs->ss, regs->flags);
 
 	if (mode != SHOW_REGS_ALL)
 		return;
@@ -83,8 +84,8 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	cr2 = read_cr2();
 	cr3 = __read_cr3();
 	cr4 = __read_cr4();
-	printk(KERN_DEFAULT "CR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n",
-			cr0, cr2, cr3, cr4);
+	printk("%sCR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n",
+		log_lvl, cr0, cr2, cr3, cr4);
 
 	get_debugreg(d0, 0);
 	get_debugreg(d1, 1);
@@ -98,10 +99,10 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	    (d6 == DR6_RESERVED) && (d7 == 0x400))
 		return;
 
-	printk(KERN_DEFAULT "DR0: %08lx DR1: %08lx DR2: %08lx DR3: %08lx\n",
-			d0, d1, d2, d3);
-	printk(KERN_DEFAULT "DR6: %08lx DR7: %08lx\n",
-			d6, d7);
+	printk("%sDR0: %08lx DR1: %08lx DR2: %08lx DR3: %08lx\n",
+		log_lvl, d0, d1, d2, d3);
+	printk("%sDR6: %08lx DR7: %08lx\n",
+		log_lvl, d6, d7);
 }
 
 void release_thread(struct task_struct *dead_task)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 09bcb29..04d201a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -62,30 +62,31 @@
 #include "process.h"
 
 /* Prints also some state that isn't saved in the pt_regs */
-void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
+		 const char *log_lvl)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L, fs, gs, shadowgs;
 	unsigned long d0, d1, d2, d3, d6, d7;
 	unsigned int fsindex, gsindex;
 	unsigned int ds, es;
 
-	show_iret_regs(regs, KERN_DEFAULT);
+	show_iret_regs(regs, log_lvl);
 
 	if (regs->orig_ax != -1)
 		pr_cont(" ORIG_RAX: %016lx\n", regs->orig_ax);
 	else
 		pr_cont("\n");
 
-	printk(KERN_DEFAULT "RAX: %016lx RBX: %016lx RCX: %016lx\n",
-	       regs->ax, regs->bx, regs->cx);
-	printk(KERN_DEFAULT "RDX: %016lx RSI: %016lx RDI: %016lx\n",
-	       regs->dx, regs->si, regs->di);
-	printk(KERN_DEFAULT "RBP: %016lx R08: %016lx R09: %016lx\n",
-	       regs->bp, regs->r8, regs->r9);
-	printk(KERN_DEFAULT "R10: %016lx R11: %016lx R12: %016lx\n",
-	       regs->r10, regs->r11, regs->r12);
-	printk(KERN_DEFAULT "R13: %016lx R14: %016lx R15: %016lx\n",
-	       regs->r13, regs->r14, regs->r15);
+	printk("%sRAX: %016lx RBX: %016lx RCX: %016lx\n",
+	       log_lvl, regs->ax, regs->bx, regs->cx);
+	printk("%sRDX: %016lx RSI: %016lx RDI: %016lx\n",
+	       log_lvl, regs->dx, regs->si, regs->di);
+	printk("%sRBP: %016lx R08: %016lx R09: %016lx\n",
+	       log_lvl, regs->bp, regs->r8, regs->r9);
+	printk("%sR10: %016lx R11: %016lx R12: %016lx\n",
+	       log_lvl, regs->r10, regs->r11, regs->r12);
+	printk("%sR13: %016lx R14: %016lx R15: %016lx\n",
+	       log_lvl, regs->r13, regs->r14, regs->r15);
 
 	if (mode == SHOW_REGS_SHORT)
 		return;
@@ -93,8 +94,8 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	if (mode == SHOW_REGS_USER) {
 		rdmsrl(MSR_FS_BASE, fs);
 		rdmsrl(MSR_KERNEL_GS_BASE, shadowgs);
-		printk(KERN_DEFAULT "FS:  %016lx GS:  %016lx\n",
-		       fs, shadowgs);
+		printk("%sFS:  %016lx GS:  %016lx\n",
+		       log_lvl, fs, shadowgs);
 		return;
 	}
 
@@ -112,12 +113,12 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	cr3 = __read_cr3();
 	cr4 = __read_cr4();
 
-	printk(KERN_DEFAULT "FS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
-	       fs, fsindex, gs, gsindex, shadowgs);
-	printk(KERN_DEFAULT "CS:  %04lx DS: %04x ES: %04x CR0: %016lx\n", regs->cs, ds,
-			es, cr0);
-	printk(KERN_DEFAULT "CR2: %016lx CR3: %016lx CR4: %016lx\n", cr2, cr3,
-			cr4);
+	printk("%sFS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
+	       log_lvl, fs, fsindex, gs, gsindex, shadowgs);
+	printk("%sCS:  %04lx DS: %04x ES: %04x CR0: %016lx\n",
+		log_lvl, regs->cs, ds, es, cr0);
+	printk("%sCR2: %016lx CR3: %016lx CR4: %016lx\n",
+		log_lvl, cr2, cr3, cr4);
 
 	get_debugreg(d0, 0);
 	get_debugreg(d1, 1);
@@ -129,14 +130,14 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	/* Only print out debug registers if they are in their non-default state. */
 	if (!((d0 == 0) && (d1 == 0) && (d2 == 0) && (d3 == 0) &&
 	    (d6 == DR6_RESERVED) && (d7 == 0x400))) {
-		printk(KERN_DEFAULT "DR0: %016lx DR1: %016lx DR2: %016lx\n",
-		       d0, d1, d2);
-		printk(KERN_DEFAULT "DR3: %016lx DR6: %016lx DR7: %016lx\n",
-		       d3, d6, d7);
+		printk("%sDR0: %016lx DR1: %016lx DR2: %016lx\n",
+		       log_lvl, d0, d1, d2);
+		printk("%sDR3: %016lx DR6: %016lx DR7: %016lx\n",
+		       log_lvl, d3, d6, d7);
 	}
 
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		printk(KERN_DEFAULT "PKRU: %08x\n", read_pkru());
+		printk("%sPKRU: %08x\n", log_lvl, read_pkru());
 }
 
 void release_thread(struct task_struct *dead_task)
