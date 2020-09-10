Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A0C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA32214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fu9Np2Ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgIJSkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbgIJSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:38:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A677BC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:38:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f133200806c26bf29ee8a02.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:3200:806c:26bf:29ee:8a02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C11961EC04BF;
        Thu, 10 Sep 2020 20:38:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599763125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sDl/npz/0gYc9uruwF4kz3L9c/GWyK4BlY36lc1d+eM=;
        b=Fu9Np2UbMcbCHoTU7S93SO/NQvSsSXdmbGOraA1pbeDwodaGZ6P76w/8DfOzQU4kBQDSAE
        wHLpem+Z01v0fEeB4mYmdDUi7P1VUFamyiHeFdLgae5F799wDQGSgXfLzc7MSYEv/nU4AM
        NP/r7S5rsCqC+8su00k5ChcoA54tUOw=
Date:   Thu, 10 Sep 2020 20:38:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH -v2] x86/mce: Make mce_rdmsrl() panic on an inaccessible MSR
Message-ID: <20200910183845.GL8357@zn.tnic>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic>
 <20200908100837.GC25236@zn.tnic>
 <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
 <20200908152539.GE25236@zn.tnic>
 <20200909113022.GA12237@zn.tnic>
 <20200909182051.GA31883@agluck-desk2.amr.corp.intel.com>
 <20200909200321.GG12237@zn.tnic>
 <20200910182901.GK8357@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910182901.GK8357@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

If an exception needs to be handled while reading an MSR - which is in
most of the cases caused by a #GP on a non-existent MSR - then this
is most likely the incarnation of a BIOS or a hardware bug. Such bug
violates the architectural guarantee that MSR banks are present with all
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
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 72 ++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0ba24dfffdb2..a697baee9aa0 100644
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
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
