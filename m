Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0BBC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A802075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551361;
	bh=sscrRof2T2gOXm1DhhLMfhcfPs75brf/YmFVxd4ypA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uPfKLmckbdvQRYQCAFj2f7swkKsMVTZGWwNJeu36dwMfYCsfAIJHozN1b4FVZepLS
	 O84PQRXV214nsSgRp5nGcAEVNNud7cW4Xfa+nbDK4+7ynUbnrhOlhJ/tUCkjpjiXAP
	 de9YCC5kOZ0W1GZVVnBbptVOxWqj3zqG5k8Dvoyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgDVK06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730761AbgDVK0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:26:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DE42075A;
        Wed, 22 Apr 2020 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551202;
        bh=sscrRof2T2gOXm1DhhLMfhcfPs75brf/YmFVxd4ypA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQex+vrjrq9htQSdHk50oy/JNLQN31pGLM84SABtTDlFfznNbcxo58koXYUc+XY4A
         lm1u2dYYJHr+wjYsbTkROdzQSO9tCItO7Fl/z7KOQj6La1qCl/fPRpOlvnYeCH0PcN
         ES43ZNSWWsGtWm3/XnO+s5MKTOt4Nmav86bHqu4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 115/166] csky: Fixup get wrong psr value from phyical reg
Date:   Wed, 22 Apr 2020 11:57:22 +0200
Message-Id: <20200422095101.040429043@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit 9c0e343d7654a329d1f9b53d253cbf7fb6eff85d ]

We should get psr value from regs->psr in stack, not directly get
it from phyiscal register then save the vector number in
tsk->trap_no.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/include/asm/processor.h |  1 +
 arch/csky/kernel/traps.c          | 11 ++++++++++-
 arch/csky/mm/fault.c              |  7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 21e0bd5293dde..c6bcd7f7c720b 100644
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
index b057480e7463c..63715cb90ee99 100644
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
index f76618b630f91..562c7f7087490 100644
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
2.20.1



