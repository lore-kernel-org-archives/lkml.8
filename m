Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B0FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B074E2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb9GhRyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgGROiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgGROis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:38:48 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17271C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:38:48 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a12so13273202ion.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VKg4ubWDAS4fUbbXyuGGa4DPriIDuiugWVev/4KBGs=;
        b=Gb9GhRyyO8z06alZuTKabbrqFDoRjayL3M+bb9nM5uHKAcxgir3kIp+ZSGBdp/s1Hb
         lYCxZ+XeR47my+qGcDd2ppbm+f1wY5uIsJor1AtMwqIIxwa2vT7hxP7HNJgcDReteyYj
         WQefFcQbpYxnpgkQce+DdTZ+OqT5iWQe0F4im2t+/VgL8J1udMOzKXGBVvqKf1AX/Rta
         4YiL0lRcVA2uW2Rijbxi85IxK990V7pTxb2ruRHJhBAb12aSbzviLCBI0mO/FVbQP6LO
         YLdImoMt10+VjDGZCHudda+qe7tQ8I1lj86sizt78Sg4LB/e6mzyUZnSmwHcfFTGRc6N
         9yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VKg4ubWDAS4fUbbXyuGGa4DPriIDuiugWVev/4KBGs=;
        b=TWepUazpRggTQRlxAqdKCrBf4P78hSWD2N2S2xA4nOc0dtVRcAaJlTUzxuCFeqRitv
         ByDMx8c5/QAtsX6hvJsT00rwXF8bZ2R28Jjre3JZdsq7ft+QVvBBRL0MdCeWCU3g9ivA
         r7LKaZGETyz7xjV1k6oTgqQ152KuGBp1esOOFWwV9xmLk0c+o7r3YZjYicvlDABd9cdX
         GnrZb9QaTIQr/K8b7kBFdzgp4LxsaEIBgsjTQZBSILT70JxigFtMoxQj4MYAbXnbN3vI
         vslou2iuCe0PyG93i74PWLcxqFV9Kpt+Ce3qyMqFz4RMW1G+eqxMccsFbEocYVFV2uIf
         8jXw==
X-Gm-Message-State: AOAM530hBpdlJWN+BXfUGkuqQ4Icft699jT/S0P93zv2cahc001f1h8K
        ir7QmnOpfcy7TiCxIArBtusAUPI=
X-Google-Smtp-Source: ABdhPJxhh+gZuKO50KDXJGXoTaJsADDniBL0dRWpbwTIVyfTHmw+W/3K/8H5JIrBHKDF9XRYGd/Neg==
X-Received: by 2002:a6b:9042:: with SMTP id s63mr14778111iod.195.1595083126294;
        Sat, 18 Jul 2020 07:38:46 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 5sm5888610ion.7.2020.07.18.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 07:38:45 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/3] x86-64: Move SYSRET validation code to C
Date:   Sat, 18 Jul 2020 10:38:37 -0400
Message-Id: <20200718143839.194960-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718143839.194960-1-brgerst@gmail.com>
References: <20200718143839.194960-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/calling.h       | 10 +----
 arch/x86/entry/common.c        | 56 ++++++++++++++++++++++++++-
 arch/x86/entry/entry_64.S      | 71 ++--------------------------------
 arch/x86/include/asm/syscall.h |  2 +-
 4 files changed, 60 insertions(+), 79 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 98e4d8886f11c..904477d3e388f 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -147,27 +147,19 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
-.macro POP_REGS pop_rdi=1 skip_r11rcx=0
+.macro POP_REGS pop_rdi=1
 	popq %r15
 	popq %r14
 	popq %r13
 	popq %r12
 	popq %rbp
 	popq %rbx
-	.if \skip_r11rcx
-	popq %rsi
-	.else
 	popq %r11
-	.endif
 	popq %r10
 	popq %r9
 	popq %r8
 	popq %rax
-	.if \skip_r11rcx
-	popq %rsi
-	.else
 	popq %rcx
-	.endif
 	popq %rdx
 	popq %rsi
 	.if \pop_rdi
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 54ad1890aefca..9e01445f6679c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -365,9 +365,11 @@ __visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+__visible noinstr bool do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
+	long rip;
+	unsigned int shift_rip;
 
 	check_user_regs(regs);
 
@@ -394,6 +396,58 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 
 	instrumentation_end();
 	exit_to_user_mode();
+
+	/*
+	 * Check that the register state is valid for using SYSRET to exit
+	 * to userspace.  Otherwise use the slower IRET exit path.
+	 */
+
+	/* SYSRET requires RCX == RIP and R11 = EFLAGS */
+	if (unlikely(regs->cx != regs->ip || regs->r11 != regs->flags))
+		return false;
+
+	/* CS and SS must match values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER_CS || regs->ss != __USER_DS))
+		return false;
+
+	/*
+	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
+	 * in kernel space.  This essentially lets the user take over
+	 * the kernel, since userspace controls RSP.
+	 *
+	 * Change top bits to match most significant bit (47th or 56th bit
+	 * depending on paging mode) in the address.
+	 */
+	shift_rip = (64 - __VIRTUAL_MASK_SHIFT + 1);
+	rip = (long) regs->ip;
+	rip <<= shift_rip;
+	rip >>= shift_rip;
+	if (unlikely((unsigned long) rip != regs->ip))
+		return false;
+
+	/*
+	 * SYSCALL clears RF when it saves RFLAGS in R11 and SYSRET cannot
+	 * restore RF properly. If the slowpath sets it for whatever reason, we
+	 * need to restore it correctly.
+	 *
+	 * SYSRET can restore TF, but unlike IRET, restoring TF results in a
+	 * trap from userspace immediately after SYSRET.  This would cause an
+	 * infinite loop whenever #DB happens with register state that satisfies
+	 * the opportunistic SYSRET conditions.  For example, single-stepping
+	 * this user code:
+	 *
+	 *           movq       $stuck_here, %rcx
+	 *           pushfq
+	 *           popq %r11
+	 *   stuck_here:
+	 *
+	 * would never get past 'stuck_here'.
+	 */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF|X86_EFLAGS_TF)))
+		return false;
+
+	/* Use SYSRET to exit to userspace */
+	return true;
 }
 #endif
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index fb729f4c4fbc2..b8025a62ac5e8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -117,80 +117,15 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
-	/*
-	 * Try to use SYSRET instead of IRET if we're returning to
-	 * a completely clean 64-bit userspace context.  If we're not,
-	 * go to the slow exit path.
-	 */
-	movq	RCX(%rsp), %rcx
-	movq	RIP(%rsp), %r11
-
-	cmpq	%rcx, %r11	/* SYSRET requires RCX == RIP */
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	/*
-	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
-	 * in kernel space.  This essentially lets the user take over
-	 * the kernel, since userspace controls RSP.
-	 *
-	 * If width of "canonical tail" ever becomes variable, this will need
-	 * to be updated to remain correct on both old and new CPUs.
-	 *
-	 * Change top bits to match most significant bit (47th or 56th bit
-	 * depending on paging mode) in the address.
-	 */
-#ifdef CONFIG_X86_5LEVEL
-	ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
-		"shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATURE_LA57
-#else
-	shl	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
-	sar	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
-#endif
-
-	/* If this changed %rcx, it was not canonical */
-	cmpq	%rcx, %r11
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	cmpq	$__USER_CS, CS(%rsp)		/* CS must match SYSRET */
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	movq	R11(%rsp), %r11
-	cmpq	%r11, EFLAGS(%rsp)		/* R11 == RFLAGS */
-	jne	swapgs_restore_regs_and_return_to_usermode
-
-	/*
-	 * SYSCALL clears RF when it saves RFLAGS in R11 and SYSRET cannot
-	 * restore RF properly. If the slowpath sets it for whatever reason, we
-	 * need to restore it correctly.
-	 *
-	 * SYSRET can restore TF, but unlike IRET, restoring TF results in a
-	 * trap from userspace immediately after SYSRET.  This would cause an
-	 * infinite loop whenever #DB happens with register state that satisfies
-	 * the opportunistic SYSRET conditions.  For example, single-stepping
-	 * this user code:
-	 *
-	 *           movq	$stuck_here, %rcx
-	 *           pushfq
-	 *           popq %r11
-	 *   stuck_here:
-	 *
-	 * would never get past 'stuck_here'.
-	 */
-	testq	$(X86_EFLAGS_RF|X86_EFLAGS_TF), %r11
-	jnz	swapgs_restore_regs_and_return_to_usermode
-
-	/* nothing to check for RSP */
-
-	cmpq	$__USER_DS, SS(%rsp)		/* SS must match SYSRET */
-	jne	swapgs_restore_regs_and_return_to_usermode
+	testb	%al, %al		/* Is SYSRET allowed? */
+	jz	swapgs_restore_regs_and_return_to_usermode
 
 	/*
 	 * We win! This label is here just for ease of understanding
 	 * perf profiles. Nothing jumps here.
 	 */
 syscall_return_via_sysret:
-	/* rcx and r11 are already restored (see code above) */
-	POP_REGS pop_rdi=0 skip_r11rcx=1
+	POP_REGS pop_rdi=0
 
 	/*
 	 * Now all regs are restored except RSP and RDI.
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 7cbf733d11afd..766f9b9736185 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -160,7 +160,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 
-void do_syscall_64(unsigned long nr, struct pt_regs *regs);
+bool do_syscall_64(unsigned long nr, struct pt_regs *regs);
 void do_int80_syscall_32(struct pt_regs *regs);
 long do_fast_syscall_32(struct pt_regs *regs);
 
-- 
2.26.2

