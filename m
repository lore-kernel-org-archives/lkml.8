Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A47C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7F0207BC
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 21:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Uf3VnlDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgIFVVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:21:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47536 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgIFVVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 17:21:48 -0400
Received: from zn.tnic (p200300ec2f289700793ea211d80ace44.dip0.t-ipconnect.de [IPv6:2003:ec:2f28:9700:793e:a211:d80a:ce44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44F001EC0299;
        Sun,  6 Sep 2020 23:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599427303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=HM5R1OLI2Y86rBU/SMz/D4+lyPnAoxTQUL0ra//iafk=;
        b=Uf3VnlDnX7R/kPjAFgI0enhWdPylQcuVRhCZ2DZC3oeOmhQvLNSls7cYbWkxV/OLc1XsOX
        n9GVGYOaEJDnNYyTjJFkxtZ3PimoLtuD+iSAVheJVXLl0AeTSug/UPRqEc5sdirR7Y3++o
        tVfQqRbcBpGeJZXUvYpUrd8VBv5yzDU=
Date:   Sun, 6 Sep 2020 23:21:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     x86-ml <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200906212130.GA28456@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ingo and I talked about this thing this morning and tglx has had it on
his to-fix list too so here's a first attempt at it.

Below is just a brain dump of what we talked about so let's start with
it and see where it would take us.

Thx.

---

From: Borislav Petkov <bp@suse.de>

... without any exception handling and tracing.

If an exception needs to be handled while reading an MSR - which is in
most of the cases caused by a #GP on a non-existent MSR - then this
is most likely the incarnation of a BIOS or a hardware bug. Such bug
violates the architectural guarantee that MSR banks are present with all
MSRs belonging to them.

The proper fix belongs in the hardware/firmware - not in the kernel.

Handling exceptions while in #MC and while an NMI is being handled would
cause the nasty NMI nesting issue because of the shortcoming of IRET
of reenabling NMIs when executed. And the machine is in an #MC context
already so <Deity> be at its side.

Tracing MSR accesses while in #MC is another no-no due to tracing being
inherently a bad idea in atomic context:

  vmlinux.o: warning: objtool: do_machine_check()+0x4a: call to mce_rdmsrl() leaves .noinstr.text section

so remove all that "additional" functionality from mce_rdmsrl() and
concentrate on solely reading the MSRs.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/mce/core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0ba24dfffdb2..14ebdf3e22f3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -376,7 +376,7 @@ static int msr_to_offset(u32 msr)
 /* MSR access wrappers used for error injection */
 static u64 mce_rdmsrl(u32 msr)
 {
-	u64 v;
+	DECLARE_ARGS(val, low, high);
 
 	if (__this_cpu_read(injectm.finished)) {
 		int offset = msr_to_offset(msr);
@@ -386,17 +386,13 @@ static u64 mce_rdmsrl(u32 msr)
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
+	 * architectural violation and needs to be reported to hw vendor.
+	 */
+	asm volatile("rdmsr" : EAX_EDX_RET(val, low, high) : "c" (msr));
 
-	return v;
+	return EAX_EDX_VAL(val, low, high);
 }
 
 static void mce_wrmsrl(u32 msr, u64 v)
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
