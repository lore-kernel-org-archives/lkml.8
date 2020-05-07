Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A001C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA23320A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o613vzDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEGQTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbgEGQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:19:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC12C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0p5WulZR7umMf1/umKKJlS4alO76V1BmJ7qJ4B9RAmw=; b=o613vzDnwS5qP+TGmhrpOZc+Wb
        NfKKI2c90WIkZ8TGkvCgjES174G0G0cTPOL9R/721kb4NzT2x20luJc2RQAG549yFRKJ0qJY8h1YK
        VKfneLxTD510KJ+Al/OFPa+sdcqVKXMtZiqXjf4Pe/evC7n9O1ufaLDwxqmsVycOIeZ5by+w631zp
        LG7RTok0Glq/ii1p3mXL3gceiBxzW5URasRrAfDdsPWsDmhnK47WkoT80umgfFzeEpcHOq1XPNxRZ
        gsWI0mCirm+VJY2ArNviRRFMwKAihXXyCqa6SFPfH/ajJSr60gxHbEt9q3KMoaID8uwJKCD0SO1SX
        vWfNuQ2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWjEf-0003RE-Q5; Thu, 07 May 2020 16:18:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61F81301EFB;
        Thu,  7 May 2020 18:18:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4F2512038FB67; Thu,  7 May 2020 18:18:55 +0200 (CEST)
Message-Id: <20200507161828.741881602@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 May 2020 18:10:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     jpoimboe@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 2/3] x86/entry: Provide ASM_INSTR_{BEGIN,END}
References: <20200507161020.783541450@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce clutter.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/irq_stack.h |   10 ++--------
 arch/x86/include/asm/kvm_host.h  |   10 ++--------
 include/linux/compiler.h         |   14 ++++++++++++++
 3 files changed, 18 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -24,15 +24,9 @@ do {									\
 	asm volatile(							\
 		"movq	%%rsp, (%[ts])				\n"	\
 		"movq	%[ts], %%rsp				\n"	\
-		"1:						\n"	\
-		"	.pushsection .discard.instr_begin	\n"	\
-		"	.long 1b - .				\n"	\
-		"	.popsection				\n"	\
+		ASM_INSTR_BEGIN						\
 		_asm "                                          \n"	\
-		"2:						\n"	\
-		"	.pushsection .discard.instr_end		\n"	\
-		"	.long 2b - .				\n"	\
-		"	.popsection				\n"	\
+		ASM_INSTR_END						\
 		"popq	%%rsp					\n"	\
 		:							\
 		: [ts] "r" (tos), ##__VA_ARGS__				\
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1601,15 +1601,9 @@ asmlinkage void kvm_spurious_fault(void)
 	insn "\n\t"							\
 	"jmp	668f \n\t"						\
 	"667: \n\t"							\
-	"1: \n\t"							\
-	".pushsection .discard.instr_begin \n\t"			\
-	".long 1b - . \n\t"						\
-	".popsection \n\t"						\
+	ASM_INSTR_BEGIN							\
 	"call	kvm_spurious_fault \n\t"				\
-	"1: \n\t"							\
-	".pushsection .discard.instr_end \n\t"				\
-	".long 1b - . \n\t"						\
-	".popsection \n\t"						\
+	ASM_INSTR_END							\
 	"668: \n\t"							\
 	_ASM_EXTABLE(666b, 667b)
 
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -135,12 +135,26 @@ void ftrace_likely_update(struct ftrace_
 		     ".popsection\n\t" : : "i" (__COUNTER__));		\
 })
 
+#define ASM_INSTR_BEGIN							\
+	"999:\n\t"							\
+	".pushsection .discard.instr_begin\n\t"				\
+	".long 999b - .\n\t"						\
+	".popsection\n\t"
+
+#define ASM_INSTR_END							\
+	"999:\n\t"							\
+	".pushsection .discard.instr_end\n\t"				\
+	".long 999b - .\n\t"						\
+	".popsection\n\t"
+
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
 #define __annotate_jump_table
 #define instr_begin()		do { } while(0)
 #define instr_end()		do { } while(0)
+#define ASM_INSTR_BEGIN
+#define ASM_INSTR_END
 #endif
 
 #ifndef ASM_UNREACHABLE


