Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA2DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EE62084C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgEST6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgEST6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7EAC08C5C0;
        Tue, 19 May 2020 12:58:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nd-0008Cx-CO; Tue, 19 May 2020 21:58:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F36FD1C04D6;
        Tue, 19 May 2020 21:58:23 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/mce: Move nmi_enter/exit() into the entry point
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135314.243936614@linutronix.de>
References: <20200505135314.243936614@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830388.17951.10876721588740341916.tip-bot2@tip-bot2>
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

Commit-ID:     46dbb1443cd5c4e1c892b820d7a578995a1708cf
Gitweb:        https://git.kernel.org/tip/46dbb1443cd5c4e1c892b820d7a578995a1708cf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 03 Apr 2020 22:37:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:08 +02:00

x86/mce: Move nmi_enter/exit() into the entry point

There is no reason to have nmi_enter/exit() in the actual MCE
handlers. Move it to the entry point. This also covers the until now
uncovered initial handler which only prints.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135314.243936614@linutronix.de


---
 arch/x86/kernel/cpu/mce/core.c    | 26 +++++++++++++-------------
 arch/x86/kernel/cpu/mce/p5.c      |  4 ----
 arch/x86/kernel/cpu/mce/winchip.c |  4 ----
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e9265e2..f5993ed 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1100,8 +1100,10 @@ static void mce_clear_state(unsigned long *toclear)
  * kdump kernel establishing a new #MC handler where a broadcasted MCE
  * might not get handled properly.
  */
-static bool __mc_check_crashing_cpu(int cpu)
+static noinstr bool mce_check_crashing_cpu(void)
 {
+	unsigned int cpu = smp_processor_id();
+
 	if (cpu_is_offline(cpu) ||
 	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
@@ -1235,7 +1237,6 @@ void noinstr do_machine_check(struct pt_regs *regs, long error_code)
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
 	struct mca_config *cfg = &mca_cfg;
-	int cpu = smp_processor_id();
 	struct mce m, *final;
 	char *msg = NULL;
 	int worst = 0;
@@ -1264,11 +1265,6 @@ void noinstr do_machine_check(struct pt_regs *regs, long error_code)
 	 */
 	int lmce = 1;
 
-	if (__mc_check_crashing_cpu(cpu))
-		return;
-
-	nmi_enter();
-
 	this_cpu_inc(mce_exception_count);
 
 	mce_gather_info(&m, regs);
@@ -1356,7 +1352,7 @@ void noinstr do_machine_check(struct pt_regs *regs, long error_code)
 	sync_core();
 
 	if (worst != MCE_AR_SEVERITY && !kill_it)
-		goto out_ist;
+		return;
 
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
@@ -1373,9 +1369,6 @@ void noinstr do_machine_check(struct pt_regs *regs, long error_code)
 		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
 			mce_panic("Failed kernel mode recovery", &m, msg);
 	}
-
-out_ist:
-	nmi_exit();
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
 
@@ -1912,11 +1905,18 @@ static void unexpected_machine_check(struct pt_regs *regs, long error_code)
 void (*machine_check_vector)(struct pt_regs *, long error_code) =
 						unexpected_machine_check;
 
-dotraplinkage notrace void do_mce(struct pt_regs *regs, long error_code)
+dotraplinkage noinstr void do_mce(struct pt_regs *regs, long error_code)
 {
+	if (machine_check_vector == do_machine_check &&
+	    mce_check_crashing_cpu())
+		return;
+
+	nmi_enter();
+
 	machine_check_vector(regs, error_code);
+
+	nmi_exit();
 }
-NOKPROBE_SYMBOL(do_mce);
 
 /*
  * Called for each booted CPU to set up machine checks.
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index 5ee94aa..dc29f0f 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -25,8 +25,6 @@ static void pentium_machine_check(struct pt_regs *regs, long error_code)
 {
 	u32 loaddr, hi, lotype;
 
-	nmi_enter();
-
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
 	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
 
@@ -39,8 +37,6 @@ static void pentium_machine_check(struct pt_regs *regs, long error_code)
 	}
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
-
-	nmi_exit();
 }
 
 /* Set up machine check reporting for processors with Intel style MCE: */
diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index b3938c1..3f8f84b 100644
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -19,12 +19,8 @@
 /* Machine check handler for WinChip C6: */
 static void winchip_machine_check(struct pt_regs *regs, long error_code)
 {
-	nmi_enter();
-
 	pr_emerg("CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
-
-	nmi_exit();
 }
 
 /* Set up machine check reporting on the Winchip C6 series */
