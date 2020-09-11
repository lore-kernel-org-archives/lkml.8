Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36D0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76346206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3E663e4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kp20XhM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgIKJrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgIKJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:47:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7307CC061573;
        Fri, 11 Sep 2020 02:47:40 -0700 (PDT)
Date:   Fri, 11 Sep 2020 09:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599817649;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVKv2QhlpPZOFuzgKjwcq03D7evNR6wB5bcvEJU/SB0=;
        b=U3E663e4Lnu8TwNkTNC4lC8r6ltwASHnD84+tiY1cJ8Ci21I7MqaGf9r9OZ48mlAHoiRKM
        pJbWgOUKZr5XMCBV3jZb8sFmEFw8QGnLRo+Y/YOZ8fWL9rOlW+mOxf3hpIjTZJUyYxZ/wn
        QG8LsDhP+723A7JoZuack3XI958VtCMJEoZPFJBXLVGuYs+NJs9LmYIVAwDKES98j87i4j
        kggup7PvvGp333T3Yw1wJCNcl0Oj+FcynlSQX71GzpafOblwU22WhUIphjy/jfYQQxFIEB
        QFmtOMa4++lUCuiS1j2uHMDvDR8fHAPMKcvquKgT6RqFojhRiDGpCzpSeipQ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599817649;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVKv2QhlpPZOFuzgKjwcq03D7evNR6wB5bcvEJU/SB0=;
        b=Kp20XhM4umXcQotmY3akh1lqKz9UBRpF5xN7wqjUlJKak4wFV12WKdJpqdHO14MNpEOGPH
        7Noq7Ofumf1qdBBQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Make mce_rdmsrl() panic on an inaccessible MSR
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200906212130.GA28456@zn.tnic>
References: <20200906212130.GA28456@zn.tnic>
MIME-Version: 1.0
Message-ID: <159981764812.4289.4399405549568254826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e2def7d49d0812ea40a224161b2001b2e815dce2
Gitweb:        https://git.kernel.org/tip/e2def7d49d0812ea40a224161b2001b2e815dce2
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 06 Sep 2020 23:02:52 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 11 Sep 2020 08:25:43 +02:00

x86/mce: Make mce_rdmsrl() panic on an inaccessible MSR

If an exception needs to be handled while reading an MSR - which is in
most of the cases caused by a #GP on a non-existent MSR - then this
is most likely the incarnation of a BIOS or a hardware bug. Such bug
violates the architectural guarantee that MCA banks are present with all
MSRs belonging to them.

The proper fix belongs in the hardware/firmware - not in the kernel.

Handling an #MC exception which is raised while an NMI is being handled
would cause the nasty NMI nesting issue because of the shortcoming of
IRET of reenabling NMIs when executed. And the machine is in an #MC
context already so <Deity> be at its side.

Tracing MSR accesses while in #MC is another no-no due to tracing being
inherently a bad idea in atomic context:

  vmlinux.o: warning: objtool: do_machine_check()+0x4a: call to mce_rdmsrl() leaves .noinstr.text section

so remove all that "additional" functionality from mce_rdmsrl() and
provide it with a special exception handler which panics the machine
when that MSR is not accessible.

The exception handler prints a human-readable message explaining what
the panic reason is but, what is more, it panics while in the #GP
handler and latter won't have executed an IRET, thus opening the NMI
nesting issue in the case when the #MC has happened while handling
an NMI. (#MC itself won't be reenabled until MCG_STATUS hasn't been
cleared).

Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
[ Add missing prototypes for ex_handler_* ]
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200906212130.GA28456@zn.tnic
---
 arch/x86/kernel/cpu/mce/core.c     | 72 ++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/mce/internal.h | 10 ++++-
 2 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0ba24df..a697bae 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -373,10 +373,28 @@ static int msr_to_offset(u32 msr)
 	return -1;
 }
 
+__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
+				      struct pt_regs *regs, int trapnr,
+				      unsigned long error_code,
+				      unsigned long fault_addr)
+{
+	pr_emerg("MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
+		 (unsigned int)regs->cx, regs->ip, (void *)regs->ip);
+
+	show_stack_regs(regs);
+
+	panic("MCA architectural violation!\n");
+
+	while (true)
+		cpu_relax();
+
+	return true;
+}
+
 /* MSR access wrappers used for error injection */
 static u64 mce_rdmsrl(u32 msr)
 {
-	u64 v;
+	DECLARE_ARGS(val, low, high);
 
 	if (__this_cpu_read(injectm.finished)) {
 		int offset = msr_to_offset(msr);
@@ -386,21 +404,43 @@ static u64 mce_rdmsrl(u32 msr)
 		return *(u64 *)((char *)this_cpu_ptr(&injectm) + offset);
 	}
 
-	if (rdmsrl_safe(msr, &v)) {
-		WARN_ONCE(1, "mce: Unable to read MSR 0x%x!\n", msr);
-		/*
-		 * Return zero in case the access faulted. This should
-		 * not happen normally but can happen if the CPU does
-		 * something weird, or if the code is buggy.
-		 */
-		v = 0;
-	}
+	/*
+	 * RDMSR on MCA MSRs should not fault. If they do, this is very much an
+	 * architectural violation and needs to be reported to hw vendor. Panic
+	 * the box to not allow any further progress.
+	 */
+	asm volatile("1: rdmsr\n"
+		     "2:\n"
+		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_rdmsr_fault)
+		     : EAX_EDX_RET(val, low, high) : "c" (msr));
 
-	return v;
+
+	return EAX_EDX_VAL(val, low, high);
+}
+
+__visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
+				      struct pt_regs *regs, int trapnr,
+				      unsigned long error_code,
+				      unsigned long fault_addr)
+{
+	pr_emerg("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
+		 (unsigned int)regs->cx, (unsigned int)regs->dx, (unsigned int)regs->ax,
+		  regs->ip, (void *)regs->ip);
+
+	show_stack_regs(regs);
+
+	panic("MCA architectural violation!\n");
+
+	while (true)
+		cpu_relax();
+
+	return true;
 }
 
 static void mce_wrmsrl(u32 msr, u64 v)
 {
+	u32 low, high;
+
 	if (__this_cpu_read(injectm.finished)) {
 		int offset = msr_to_offset(msr);
 
@@ -408,7 +448,15 @@ static void mce_wrmsrl(u32 msr, u64 v)
 			*(u64 *)((char *)this_cpu_ptr(&injectm) + offset) = v;
 		return;
 	}
-	wrmsrl(msr, v);
+
+	low  = (u32)v;
+	high = (u32)(v >> 32);
+
+	/* See comment in mce_rdmsrl() */
+	asm volatile("1: wrmsr\n"
+		     "2:\n"
+		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wrmsr_fault)
+		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 6473070..b122610 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -185,4 +185,14 @@ extern bool amd_filter_mce(struct mce *m);
 static inline bool amd_filter_mce(struct mce *m)			{ return false; };
 #endif
 
+__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
+				      struct pt_regs *regs, int trapnr,
+				      unsigned long error_code,
+				      unsigned long fault_addr);
+
+__visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
+				      struct pt_regs *regs, int trapnr,
+				      unsigned long error_code,
+				      unsigned long fault_addr);
+
 #endif /* __X86_MCE_INTERNAL_H__ */
