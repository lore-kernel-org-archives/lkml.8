Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2A1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3E322286
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B44seAHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIPSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgIILan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:30:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE6C06179A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:30:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ae7002c1f5e624f33a6aa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e700:2c1f:5e62:4f33:a6aa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA3541EC027B;
        Wed,  9 Sep 2020 13:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599651028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gF6Scd5cy14X4AN/Sb0Jw5aLe2Jbw6dlDTXmjAO/chs=;
        b=B44seAHY/4PMrl8i9ZcuoUnJZeHFdAigK0HDA+DdaVbTPNxcue5uHmM2SlQKqM+t9J9G+b
        8EmTh0tHmrb4+Xe/wetu/GOXDfOsinxsiEWEGjmpYxwRFpUKA5IDpLYRQMK1CQySP3GrKM
        igb7amYKtNw/VwScXLlD7byipQopFmg=
Date:   Wed, 9 Sep 2020 13:30:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200909113022.GA12237@zn.tnic>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic>
 <20200908100837.GC25236@zn.tnic>
 <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
 <20200908152539.GE25236@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908152539.GE25236@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess something as straightforward as this:

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0ba24dfffdb2..9893caaf2696 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -373,10 +373,27 @@ static int msr_to_offset(u32 msr)
 	return -1;
 }
 
+__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
+				      struct pt_regs *regs, int trapnr,
+				      unsigned long error_code,
+				      unsigned long fault_addr)
+{
+	if (pr_warn_once("MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
+		show_stack_regs(regs);
+
+	panic("MCA Architectural violation!\n");
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
@@ -386,21 +403,42 @@ static u64 mce_rdmsrl(u32 msr)
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
+	if (pr_warn_once("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, (unsigned int)regs->dx, (unsigned int)regs->ax,
+			 regs->ip, (void *)regs->ip))
+		show_stack_regs(regs);
+
+	panic("MCA Architectural violation!\n");
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
 
@@ -408,7 +446,15 @@ static void mce_wrmsrl(u32 msr, u64 v)
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
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
