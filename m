Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C411C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D672220672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="d5tU2dJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgF2Thy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbgF2Thp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0237C02F00A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:48:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so15644941wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJwdjEheHiVlOSgPrC9hHSnG45HC0yQWcARpTX2OEK4=;
        b=d5tU2dJnQZ41qIFt8csBt3yN0KaHWLqnmk7Xyt6aXiXv53ZffXDcsl74S58xEUdxsO
         53dG1mJJMziu+yaPbQK4dPLTRAJN+99rElOex2+VkDm1LRhqKVOL+9NAzma41UlRQGir
         RclF3j2Of3CDBMZgRbW7T7ls/9rYBPdevtAnB+I4k/HPjFmo62h1Pp+CCvX1uIumr2hp
         kStWY5M5mPClSDC+YiLfioC5+nAx7j/rBRYa1OtQOP2jr2x/8M3YMsYXu5makZfxtcZc
         UtUBLyG7Pc8af3JMHQjDl8QWFY9D/GKPf2/CXN3SrknfLAWLExIo3hR7tGClTfsluBbR
         LZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJwdjEheHiVlOSgPrC9hHSnG45HC0yQWcARpTX2OEK4=;
        b=Ipxb1veF9Zm4Y6sqsk7H31de+T4OxlnkeTfsa7raRHA3DKO9sOB59Gn0qfJtV/wDQE
         r0nK4Y91qiIFq/0Or1dLenHj5KWvE0h7sRfl1qVtYArmhi5EZ1IjI0IOu4dQFIdGCTfK
         9KBsolJpOn501byA8H+ZkVPVjCib+0g53uBa0huUkgOvSVfucvOga2luQoOtkX7HlOIb
         sWJIKw1tFCKWG+gfxUmbUuJ5x+4Var9QGmO3mjnHBCvq8f55oX1pHxsLBOz1c6+7Xyd9
         HymJkp/J2U5OLFp5EiHu79bzF255wBvtMYNLLMAqY025kB1y770vJ90CwRnFlh6yPEhO
         n3Cw==
X-Gm-Message-State: AOAM5330VfE2RH7Y1tVRKXzHktZ8akBDEfdo/9MoZSOocTiaw2eQRZVk
        hWwjzlhVyexe36bIlzrWOVoRXn7C+0+rlQ==
X-Google-Smtp-Source: ABdhPJyOUPOt+gxli2NAQ0XXoO5wo7Xb47bRi3anS64JJEJu11Q0ucpwXxQ1XBfaUxt8rjPMU0tc8Q==
X-Received: by 2002:a1c:ba08:: with SMTP id k8mr16543886wmf.28.1593442131940;
        Mon, 29 Jun 2020 07:48:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id s8sm42786336wru.38.2020.06.29.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:48:51 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH v2 2/3] x86/dumpstack: Add log_lvl to __show_regs()
Date:   Mon, 29 Jun 2020 15:48:46 +0100
Message-Id: <20200629144847.492794-3-dima@arista.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629144847.492794-1-dima@arista.com>
References: <20200629144847.492794-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
functions. Besides, I have a potential use-case for printing traces
with KERN_DEBUG level [2] (where registers dump shouldn't appear with
higher log level).

Add log_lvl parameter to __show_regs().
Keep the used log level intact to separate visible change.

[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
[2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/
Acked-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/include/asm/kdebug.h |  3 ++-
 arch/x86/kernel/dumpstack.c   |  9 ++++---
 arch/x86/kernel/process_32.c  | 29 ++++++++++----------
 arch/x86/kernel/process_64.c  | 51 ++++++++++++++++++-----------------
 4 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index da024bbda6f4..d1514e70477b 100644
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
index c36d629a25a8..4954d6678cef 100644
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
index acfd6d2a0cbf..4f2f54e1281c 100644
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
index 09bcb296cda6..04d201ad3a1e 100644
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
-- 
2.27.0

