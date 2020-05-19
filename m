Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7F2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7C620842
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEST6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgEST6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12CFC08C5C5;
        Tue, 19 May 2020 12:58:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nl-0008Iq-Oq; Tue, 19 May 2020 21:58:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E76631C04D6;
        Tue, 19 May 2020 21:58:28 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:28 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert Alignment check exception to IDTENTRY
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134905.928967113@linutronix.de>
References: <20200505134905.928967113@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830884.17951.7533780566909644216.tip-bot2@tip-bot2>
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

Commit-ID:     ea28f3d0310506b97fdca160ea2e1e30e3bd4583
Gitweb:        https://git.kernel.org/tip/ea28f3d0310506b97fdca160ea2e1e30e3bd4583
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:03 +02:00

x86/entry: Convert Alignment check exception to IDTENTRY

Convert #AC to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototypes
  - Remove the RCU warning as the new entry macro ensures correctness

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134905.928967113@linutronix.de



---
 arch/x86/entry/entry_32.S       | 6 ------
 arch/x86/entry/entry_64.S       | 1 -
 arch/x86/include/asm/idtentry.h | 1 +
 arch/x86/include/asm/traps.h    | 3 ---
 arch/x86/kernel/idt.c           | 2 +-
 arch/x86/kernel/traps.c         | 4 +---
 arch/x86/xen/enlighten_pv.c     | 2 +-
 arch/x86/xen/xen-asm_64.S       | 2 +-
 8 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 66d4683..7402890 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1311,12 +1311,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-SYM_CODE_START(alignment_check)
-	ASM_CLAC
-	pushl	$do_alignment_check
-	jmp	common_exception
-SYM_CODE_END(alignment_check)
-
 #ifdef CONFIG_X86_MCE
 SYM_CODE_START(machine_check)
 	ASM_CLAC
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f1f126b..3c95a63 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1073,7 +1073,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_AC		alignment_check		do_alignment_check		has_error_code=1
 idtentry	X86_TRAP_XF		simd_coprocessor_error	do_simd_coprocessor_error	has_error_code=0
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index ed44ba6..531dbc0 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -137,5 +137,6 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_NP,	exc_segment_not_present);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index e84677b..0f755e1 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -19,7 +19,6 @@ asmlinkage void double_fault(void);
 #endif
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
-asmlinkage void alignment_check(void);
 #ifdef CONFIG_X86_MCE
 asmlinkage void machine_check(void);
 #endif /* CONFIG_X86_MCE */
@@ -31,7 +30,6 @@ asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
-asmlinkage void xen_alignment_check(void);
 #ifdef CONFIG_X86_MCE
 asmlinkage void xen_machine_check(void);
 #endif /* CONFIG_X86_MCE */
@@ -43,7 +41,6 @@ dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
 dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 2bde50d..af48196 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -85,7 +85,7 @@ static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_GP,		asm_exc_general_protection),
 	INTG(X86_TRAP_SPURIOUS,		asm_exc_spurious_interrupt_bug),
 	INTG(X86_TRAP_MF,		asm_exc_coprocessor_error),
-	INTG(X86_TRAP_AC,		alignment_check),
+	INTG(X86_TRAP_AC,		asm_exc_alignment_check),
 	INTG(X86_TRAP_XF,		simd_coprocessor_error),
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ba26beb..9f156c8 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -270,12 +270,10 @@ DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
 		      0, NULL);
 }
 
-dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
 {
 	char *str = "alignment check";
 
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-
 	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
 		return;
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 6225d1f..afe12d9 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -634,7 +634,7 @@ static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY(exc_general_protection,		false ),
 	TRAP_ENTRY(exc_spurious_interrupt_bug,		false ),
 	TRAP_ENTRY(exc_coprocessor_error,		false ),
-	{ alignment_check,             xen_alignment_check,             false },
+	TRAP_ENTRY(exc_alignment_check,			false ),
 	{ simd_coprocessor_error,      xen_simd_coprocessor_error,      false },
 };
 
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 589de18..a591bec 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -46,7 +46,7 @@ xen_pv_trap asm_exc_general_protection
 xen_pv_trap page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap asm_exc_coprocessor_error
-xen_pv_trap alignment_check
+xen_pv_trap asm_exc_alignment_check
 #ifdef CONFIG_X86_MCE
 xen_pv_trap machine_check
 #endif /* CONFIG_X86_MCE */
