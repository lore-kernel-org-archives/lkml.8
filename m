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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4050DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FE820684
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQN1vFGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGROiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGROit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:38:49 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1DBC0619D4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:38:49 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a11so9721701ilk.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVlh6YnMnB6ms9DYNLLrhP4IKFwjKNlr9OHw1qgPMms=;
        b=DQN1vFGdosicPuoOT1fjenFLcsLZ0Sc3Y6MQ4wUGWHg9qInhvc/HYsjXjTC+FAliej
         AxkiZpz1WflNaxdEGgic0BQQBoi2Xk7lCx1dYdB1RdidAu8YsqZ7L0m1rbvJTYjznLz0
         Lha8DLlYBUojE2kWLC024EzDMgdOy2mB8hVURiljTfDP9RjB04yflc/9J44omhiJ4Ssb
         ga4eCkJ3IcIk2Av3QOO4Sa1hk8Mmv0mPml+ZD/lordPugUtJtYgQRfSnOvH8xXzVBzwB
         l+feUIXqizyjjA+fOL/Rvo2BT7V/EkyEhsw1Ty9Fb6q0M5x8nRnGDzwuQphUqSS6a2xR
         G7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVlh6YnMnB6ms9DYNLLrhP4IKFwjKNlr9OHw1qgPMms=;
        b=gW3J7gdTWSpA3FqFKyK/GzjKLQzhVGzW5magXCcL0K8BdAdQ71rXJRzSOR0J/auqci
         ZK5TzTpZOBQaNi84QTjYlmSTEMy5quWDiYRJ7398FO82KYbzDVcYWUJyuHFRniXVhacq
         iHS8VpVa9rrm0wci5rycPBSVH7Vjtgu1IR/R2uZJQbiNAJmxQBu3vhyLT6EZCaW36GxK
         dvlZdzQjbRdH5wDJ/6GT7x1R+c2U+MFyQDX0MSwjGcFX1I7g/8mQ4ZnHH5jxhuDNisrL
         CRwAugOgrDGCgRn14zDA2gfktrWv6CJZlC94MAKn8zmNyLH1QnmewPjE4u5fX4Yo/N9d
         JkCQ==
X-Gm-Message-State: AOAM531faseE4aLrOBOajDN1A/IYkELH9FcOUCySpIByeHprXu+Tm2T1
        nghUvqcBF6D6ewX3Dr2/USiHMn0=
X-Google-Smtp-Source: ABdhPJydSr7e1ucbrjMsptSLlSvZ/dBdkcLBH5WCJROg2E8psXFtPql9XaHtoPudbcCh9x8qoQbGYA==
X-Received: by 2002:a92:52:: with SMTP id 79mr13679537ila.59.1595083128206;
        Sat, 18 Jul 2020 07:38:48 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 5sm5888610ion.7.2020.07.18.07.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 07:38:47 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/3] x86: Clean up do_fast_syscall_32() tests
Date:   Sat, 18 Jul 2020 10:38:39 -0400
Message-Id: <20200718143839.194960-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718143839.194960-1-brgerst@gmail.com>
References: <20200718143839.194960-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganize the tests for SYSEXITS/SYSRETL, cleaning up comments and merging
native and compat code.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c          | 85 ++++++++++++++------------------
 arch/x86/entry/entry_32.S        |  6 +--
 arch/x86/entry/entry_64_compat.S | 13 ++---
 arch/x86/include/asm/segment.h   |  1 +
 arch/x86/include/asm/syscall.h   |  2 +-
 5 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bdb4c15b8610e..df1497fa554b8 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -500,10 +500,24 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 	exit_to_user_mode();
 }
 
+/* Returns true to return using SYSEXIT/SYSRETL, or false to return using IRET */
 static bool __do_fast_syscall_32(struct pt_regs *regs)
 {
+	/*
+	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
+	 * convention.  Adjust regs so it looks like we entered using int80.
+	 */
+	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
+					vdso_image_32.sym_int80_landing_pad;
 	int res;
 
+	/*
+	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
+	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
+	 * Fix it up.
+	 */
+	regs->ip = landing_pad;
+
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		/*
@@ -522,34 +536,39 @@ static bool __do_fast_syscall_32(struct pt_regs *regs)
 		regs->ax = -EFAULT;
 		local_irq_disable();
 		__prepare_exit_to_usermode(regs);
+		/* Keep it simple: use IRET. */
 		return false;
 	}
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs);
+
+	/* XEN PV guests always use IRET path */
+	if (static_cpu_has(X86_FEATURE_XENPV))
+		return false;
+
+	/* CS and SS must match values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER32_CS || regs->ss != __USER_DS))
+		return false;
+
+	/* EIP must point to the VDSO landing pad */
+	if (unlikely(regs->ip != landing_pad))
+		return false;
+
+	/* The TF, RF, and VM flags must be restored with IRET */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)))
+		return false;
+
+	/* Return with SYSEXIT/SYSRETL */
 	return true;
 }
 
-/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
+__visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 {
-	/*
-	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
-	 * convention.  Adjust regs so it looks like we entered using int80.
-	 */
-	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
-					vdso_image_32.sym_int80_landing_pad;
 	bool success;
 
 	check_user_regs(regs);
 
-	/*
-	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
-	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
-	 * Fix it up.
-	 */
-	regs->ip = landing_pad;
-
 	enter_from_user_mode();
 	instrumentation_begin();
 
@@ -559,42 +578,10 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	instrumentation_end();
 	exit_to_user_mode();
 
-	/* If it failed, keep it simple: use IRET. */
-	if (!success)
-		return 0;
-
-#ifdef CONFIG_X86_64
-	/*
-	 * Opportunistic SYSRETL: if possible, try to return using SYSRETL.
-	 * SYSRETL is available on all 64-bit CPUs, so we don't need to
-	 * bother with SYSEXIT.
-	 *
-	 * Unlike 64-bit opportunistic SYSRET, we can't check that CX == IP,
-	 * because the ECX fixup above will ensure that this is essentially
-	 * never the case.
-	 */
-	return regs->cs == __USER32_CS && regs->ss == __USER_DS &&
-		regs->ip == landing_pad &&
-		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)) == 0;
-#else
-	/*
-	 * Opportunistic SYSEXIT: if possible, try to return using SYSEXIT.
-	 *
-	 * Unlike 64-bit opportunistic SYSRET, we can't check that CX == IP,
-	 * because the ECX fixup above will ensure that this is essentially
-	 * never the case.
-	 *
-	 * We don't allow syscalls at all from VM86 mode, but we still
-	 * need to check VM, because we might be returning from sys_vm86.
-	 */
-	return regs->cs == __USER_CS && regs->ss == __USER_DS &&
-		regs->ip == landing_pad &&
-		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
-#endif
+	return success;
 }
 
-/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
+__visible noinstr bool do_SYSENTER_32(struct pt_regs *regs)
 {
 	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
 	regs->sp = regs->bp;
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2d0bd5d5f0328..24979fc747df0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -965,9 +965,9 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	movl	%esp, %eax
 	call	do_SYSENTER_32
-	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
-		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
+
+	testb	%al, %al
+	jz	.Lsyscall_32_done
 
 	STACKLEAK_ERASE
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 541fdaf640453..d8ac70ebb5f9e 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -137,9 +137,10 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 
 	movq	%rsp, %rdi
 	call	do_SYSENTER_32
-	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
-		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
+
+	testb	%al, %al
+	jz	swapgs_restore_regs_and_return_to_usermode
+
 	jmp	sysret32_from_system_call
 
 .Lsysenter_fix_flags:
@@ -252,9 +253,9 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
-	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
-		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
+
+	testb	%al, %al
+	jz	swapgs_restore_regs_and_return_to_usermode
 
 	/* Opportunistic SYSRET */
 sysret32_from_system_call:
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 6669164abadcb..da29d2cfeee83 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -135,6 +135,7 @@
 #define __KERNEL_DS			(GDT_ENTRY_KERNEL_DS*8)
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
+#define __USER32_CS			__USER_CS
 #define __ESPFIX_SS			(GDT_ENTRY_ESPFIX_SS*8)
 
 /* segment for calling fn: */
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 766f9b9736185..e3e2f255bdb67 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -162,7 +162,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 
 bool do_syscall_64(unsigned long nr, struct pt_regs *regs);
 void do_int80_syscall_32(struct pt_regs *regs);
-long do_fast_syscall_32(struct pt_regs *regs);
+bool do_fast_syscall_32(struct pt_regs *regs);
 
 #endif	/* CONFIG_X86_32 */
 
-- 
2.26.2

