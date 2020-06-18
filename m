Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9757C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2212073E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgFRNvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbgFRNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:51:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00698C0613EE;
        Thu, 18 Jun 2020 06:51:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jluwV-0002lZ-DV; Thu, 18 Jun 2020 15:50:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 644751C074B;
        Thu, 18 Jun 2020 15:50:58 +0200 (CEST)
Date:   Thu, 18 Jun 2020 13:50:58 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/process/64: Make save_fsgs_for_kvm() ready
 for FSGSBASE
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528201402.1708239-7-sashal@kernel.org>
References: <20200528201402.1708239-7-sashal@kernel.org>
MIME-Version: 1.0
Message-ID: <159248825819.16989.14274005498297309528.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     6758034e4d6a7f0e26b748789ab1f83f3116d1b9
Gitweb:        https://git.kernel.org/tip/6758034e4d6a7f0e26b748789ab1f83f3116d1b9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 28 May 2020 16:13:52 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jun 2020 15:47:01 +02:00

x86/process/64: Make save_fsgs_for_kvm() ready for FSGSBASE

save_fsgs_for_kvm() is invoked via

  vcpu_enter_guest()
    kvm_x86_ops.prepare_guest_switch(vcpu)
      vmx_prepare_switch_to_guest()
        save_fsgs_for_kvm()

with preemption disabled, but interrupts enabled.

The upcoming FSGSBASE based GS safe needs interrupts to be disabled. This
could be done in the helper function, but that function is also called from
switch_to() which has interrupts disabled already.

Disable interrupts inside save_fsgs_for_kvm() and rename the function to
current_save_fsgs() so it can be invoked from other places.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200528201402.1708239-7-sashal@kernel.org
---
 arch/x86/include/asm/processor.h |  4 +---
 arch/x86/kernel/process_64.c     | 15 +++++++++------
 arch/x86/kvm/vmx/vmx.c           |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f66202d..7c2ecdf 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -457,10 +457,8 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
 
-#if IS_ENABLED(CONFIG_KVM)
 /* Save actual FS/GS selectors and bases to current->thread */
-void save_fsgs_for_kvm(void);
-#endif
+void current_save_fsgs(void);
 #else	/* X86_64 */
 #ifdef CONFIG_STACKPROTECTOR
 /*
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index c41e0aa..ef2f755 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -240,18 +240,21 @@ static __always_inline void save_fsgs(struct task_struct *task)
 	save_base_legacy(task, task->thread.gsindex, GS);
 }
 
-#if IS_ENABLED(CONFIG_KVM)
 /*
  * While a process is running,current->thread.fsbase and current->thread.gsbase
- * may not match the corresponding CPU registers (see save_base_legacy()). KVM
- * wants an efficient way to save and restore FSBASE and GSBASE.
- * When FSGSBASE extensions are enabled, this will have to use RD{FS,GS}BASE.
+ * may not match the corresponding CPU registers (see save_base_legacy()).
  */
-void save_fsgs_for_kvm(void)
+void current_save_fsgs(void)
 {
+	unsigned long flags;
+
+	/* Interrupts need to be off for FSGSBASE */
+	local_irq_save(flags);
 	save_fsgs(current);
+	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(save_fsgs_for_kvm);
+#if IS_ENABLED(CONFIG_KVM)
+EXPORT_SYMBOL_GPL(current_save_fsgs);
 #endif
 
 static __always_inline void loadseg(enum which_selector which,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 36c7717..ccd5b7b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1172,7 +1172,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 
 	gs_base = cpu_kernelmode_gs_base(cpu);
 	if (likely(is_64bit_mm(current->mm))) {
-		save_fsgs_for_kvm();
+		current_save_fsgs();
 		fs_sel = current->thread.fsindex;
 		gs_sel = current->thread.gsindex;
 		fs_base = current->thread.fsbase;
