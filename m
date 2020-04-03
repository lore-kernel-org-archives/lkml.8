Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A636F20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888968;
	bh=YlS3C3paNOPOCPOVkzGPM1lYneYCIbFiJUt5ldc4N6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y2L+NnDBP2vMQgqUC7JH32DSCfNaiwDJWvsJkkV8OvSsy9SjbHWicnMh6OoZ5Ojpr
	 Gmia/P5cnQVLctGFZOrgFWL+jMCpV+126uehpFBIZuLYxj578LplZexBc5lKrUCTWw
	 VggHQrEL0koYnwIZ0zbN6L4/GfV9h2wJ3MfRSZX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgDCEmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732601AbgDCEmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:16 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0051620B1F;
        Fri,  3 Apr 2020 04:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888936;
        bh=YlS3C3paNOPOCPOVkzGPM1lYneYCIbFiJUt5ldc4N6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxbYlkXWrEJWxrS2K7TGauQLjgCj57fhBHeADV6Of20Eq+uiVeuX6nmECqHDZmlkr
         O+LnFvA/KrEjR6u2WB2sk+DQ+mYwQmsNsWfTuBiihQnMHdZtZdUQx1Cf8O5gC5xxCn
         EDIxWmt8lpjsEcsAxipWvEd+Kffe1TYg0cOsLw1Y=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 06/11] csky: Fixup get wrong psr value from phyical reg
Date:   Fri,  3 Apr 2020 12:41:45 +0800
Message-Id: <20200403044150.20562-6-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200403044150.20562-1-guoren@kernel.org>
References: <20200403044150.20562-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

We should get psr value from regs->psr in stack, not directly get
it from phyiscal register then save the vector number in
tsk->trap_no.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/include/asm/processor.h |  1 +
 arch/csky/kernel/traps.c          | 11 ++++++++++-
 arch/csky/mm/fault.c              |  7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 21e0bd5293dd..c6bcd7f7c720 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -43,6 +43,7 @@ extern struct cpuinfo_csky cpu_data[];
 struct thread_struct {
 	unsigned long  ksp;       /* kernel stack pointer */
 	unsigned long  sr;        /* saved status register */
+	unsigned long  trap_no;   /* saved status register */
 
 	/* FPU regs */
 	struct user_fp __aligned(16) user_fp;
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index b057480e7463..63715cb90ee9 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -115,8 +115,9 @@ asmlinkage void trap_c(struct pt_regs *regs)
 	int sig;
 	unsigned long vector;
 	siginfo_t info;
+	struct task_struct *tsk = current;
 
-	vector = (mfcr("psr") >> 16) & 0xff;
+	vector = (regs->sr >> 16) & 0xff;
 
 	switch (vector) {
 	case VEC_ZERODIV:
@@ -129,6 +130,7 @@ asmlinkage void trap_c(struct pt_regs *regs)
 		sig = SIGTRAP;
 		break;
 	case VEC_ILLEGAL:
+		tsk->thread.trap_no = vector;
 		die_if_kernel("Kernel mode ILLEGAL", regs, vector);
 #ifndef CONFIG_CPU_NO_USER_BKPT
 		if (*(uint16_t *)instruction_pointer(regs) != USR_BKPT)
@@ -146,16 +148,20 @@ asmlinkage void trap_c(struct pt_regs *regs)
 		sig = SIGTRAP;
 		break;
 	case VEC_ACCESS:
+		tsk->thread.trap_no = vector;
 		return buserr(regs);
 #ifdef CONFIG_CPU_NEED_SOFTALIGN
 	case VEC_ALIGN:
+		tsk->thread.trap_no = vector;
 		return csky_alignment(regs);
 #endif
 #ifdef CONFIG_CPU_HAS_FPU
 	case VEC_FPE:
+		tsk->thread.trap_no = vector;
 		die_if_kernel("Kernel mode FPE", regs, vector);
 		return fpu_fpe(regs);
 	case VEC_PRIV:
+		tsk->thread.trap_no = vector;
 		die_if_kernel("Kernel mode PRIV", regs, vector);
 		if (fpu_libc_helper(regs))
 			return;
@@ -164,5 +170,8 @@ asmlinkage void trap_c(struct pt_regs *regs)
 		sig = SIGSEGV;
 		break;
 	}
+
+	tsk->thread.trap_no = vector;
+
 	send_sig(sig, current, 0);
 }
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index f76618b630f9..562c7f708749 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -179,11 +179,14 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
+		tsk->thread.trap_no = (regs->sr >> 16) & 0xff;
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 		return;
 	}
 
 no_context:
+	tsk->thread.trap_no = (regs->sr >> 16) & 0xff;
+
 	/* Are we prepared to handle this kernel fault? */
 	if (fixup_exception(regs))
 		return;
@@ -198,6 +201,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	die_if_kernel("Oops", regs, write);
 
 out_of_memory:
+	tsk->thread.trap_no = (regs->sr >> 16) & 0xff;
+
 	/*
 	 * We ran out of memory, call the OOM killer, and return the userspace
 	 * (which will retry the fault, or kill us if we got oom-killed).
@@ -206,6 +211,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	return;
 
 do_sigbus:
+	tsk->thread.trap_no = (regs->sr >> 16) & 0xff;
+
 	up_read(&mm->mmap_sem);
 
 	/* Kernel mode? Handle exceptions or die */
-- 
2.17.0

