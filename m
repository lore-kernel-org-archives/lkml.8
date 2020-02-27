Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB52C3F35C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3B22468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389954AbgB0OWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:22:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34454 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389428AbgB0OQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:16:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7JxH-0005Cc-FG; Thu, 27 Feb 2020 15:15:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2743F1C216F;
        Thu, 27 Feb 2020 15:15:59 +0100 (CET)
Date:   Thu, 27 Feb 2020 14:15:58 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/mce: Disable tracing and kprobes on do_machine_check()
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200225220216.315548935@linutronix.de>
References: <20200225220216.315548935@linutronix.de>
MIME-Version: 1.0
Message-ID: <158281295888.28353.15787585336529193970.tip-bot2@tip-bot2>
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

Commit-ID:     55ba18d6ed37a28cf8b8ca79e9aef4cf98183bb7
Gitweb:        https://git.kernel.org/tip/55ba18d6ed37a28cf8b8ca79e9aef4cf98183bb7
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 25 Feb 2020 22:36:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 27 Feb 2020 14:48:39 +01:00

x86/mce: Disable tracing and kprobes on do_machine_check()

do_machine_check() can be raised in almost any context including the most
fragile ones. Prevent kprobes and tracing.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200225220216.315548935@linutronix.de

---
 arch/x86/include/asm/traps.h   |  3 ---
 arch/x86/kernel/cpu/mce/core.c | 12 ++++++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index ffa0dc8..e1c660b 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -88,9 +88,6 @@ dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code,
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
-#ifdef CONFIG_X86_MCE
-dotraplinkage void do_machine_check(struct pt_regs *regs, long error_code);
-#endif
 dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c4f949..32ecc59 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1213,8 +1213,14 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
  * On Intel systems this is entered on all CPUs in parallel through
  * MCE broadcast. However some CPUs might be broken beyond repair,
  * so be always careful when synchronizing with others.
+ *
+ * Tracing and kprobes are disabled: if we interrupted a kernel context
+ * with IF=1, we need to minimize stack usage.  There are also recursion
+ * issues: if the machine check was due to a failure of the memory
+ * backing the user stack, tracing that reads the user stack will cause
+ * potentially infinite recursion.
  */
-void do_machine_check(struct pt_regs *regs, long error_code)
+void notrace do_machine_check(struct pt_regs *regs, long error_code)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1360,6 +1366,7 @@ out_ist:
 	ist_exit(regs);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
+NOKPROBE_SYMBOL(do_machine_check);
 
 #ifndef CONFIG_MEMORY_FAILURE
 int memory_failure(unsigned long pfn, int flags)
@@ -1892,10 +1899,11 @@ static void unexpected_machine_check(struct pt_regs *regs, long error_code)
 void (*machine_check_vector)(struct pt_regs *, long error_code) =
 						unexpected_machine_check;
 
-dotraplinkage void do_mce(struct pt_regs *regs, long error_code)
+dotraplinkage notrace void do_mce(struct pt_regs *regs, long error_code)
 {
 	machine_check_vector(regs, error_code);
 }
+NOKPROBE_SYMBOL(do_mce);
 
 /*
  * Called for each booted CPU to set up machine checks.
