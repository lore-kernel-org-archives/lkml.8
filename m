Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D2C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020F52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tOXt9GVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgD1TTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728490AbgD1TTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA2C035493
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vRZfYVt90Tna9hvcYDWq0QfZ3RiArT47vEsslpQCWE8=; b=tOXt9GViT1bU8Lq0ZIKcfcDlmw
        OybM28XWBaBbIIC4aNUOlUqWWGaUSiTGvOTqIHvOczMlYqHTbapHi+BB6yvMI73WUIkoE3WPX6Qr5
        2rCrJgTu3t2NTEkNsUFAy5GZBm+c/ZXuahZu/RlWUJg/VZ3sxBne6llOJxR/bqovHeKjh0n/etcn2
        KMXPGCt78b8TjOuhnDUrW+ReiXOuopt+xxpQxB57WEvzF/RoTrtVEWkevIJWk/Cm+jhftr/XTPZJu
        CH8R7/i0D0DqWCTGmMmmKmBnJkfYNDP5SPcNZFDWfrcBFg3Mwu18ZZBbrFVbUlOrHF/tZipug4hvB
        Y1N0b7jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlS-0006WG-1N; Tue, 28 Apr 2020 19:19:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C59D430796B;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A384423CFDE42; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191700.091696925@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org, arnd@arndb.de
Subject: [PATCH v2 12/14] x86: Simplify retpoline declaration
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of how KSYM works, we need one declaration per line. Seeing
how we're going to be doubling the amount of retpoline symbols,
simplify the machinery in order to avoid having to copy/paste even
more.

Cc: arnd@arndb.de
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/GEN-for-each-reg.h |   25 ++++++++++++++++++++++
 arch/x86/include/asm/asm-prototypes.h   |   28 +++++++------------------
 arch/x86/lib/retpoline.S                |   35 +++++++++++++-------------------
 3 files changed, 48 insertions(+), 40 deletions(-)

--- /dev/null
+++ b/arch/x86/include/asm/GEN-for-each-reg.h
@@ -0,0 +1,25 @@
+#ifdef CONFIG_64BIT
+GEN(rax)
+GEN(rbx)
+GEN(rcx)
+GEN(rdx)
+GEN(rsi)
+GEN(rdi)
+GEN(rbp)
+GEN(r8)
+GEN(r9)
+GEN(r10)
+GEN(r11)
+GEN(r12)
+GEN(r13)
+GEN(r14)
+GEN(r15)
+#else
+GEN(eax)
+GEN(ebx)
+GEN(ecx)
+GEN(edx)
+GEN(esi)
+GEN(edi)
+GEN(ebp)
+#endif
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -17,24 +17,12 @@ extern void cmpxchg8b_emu(void);
 #endif
 
 #ifdef CONFIG_RETPOLINE
-#ifdef CONFIG_X86_32
-#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_e ## reg(void);
-#else
-#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_r ## reg(void);
-INDIRECT_THUNK(8)
-INDIRECT_THUNK(9)
-INDIRECT_THUNK(10)
-INDIRECT_THUNK(11)
-INDIRECT_THUNK(12)
-INDIRECT_THUNK(13)
-INDIRECT_THUNK(14)
-INDIRECT_THUNK(15)
-#endif
-INDIRECT_THUNK(ax)
-INDIRECT_THUNK(bx)
-INDIRECT_THUNK(cx)
-INDIRECT_THUNK(dx)
-INDIRECT_THUNK(si)
-INDIRECT_THUNK(di)
-INDIRECT_THUNK(bp)
+
+#define DECL_INDIRECT_THUNK(reg) \
+	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
+
+#undef GEN
+#define GEN(reg) DECL_INDIRECT_THUNK(reg)
+#include <asm/GEN-for-each-reg.h>
+
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -24,25 +24,20 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
  * only see one instance of "__x86_indirect_thunk_\reg" rather
  * than one per register with the correct names. So we do it
  * the simple and nasty way...
+ *
+ * Worse, you can only have a single EXPORT_SYMBOL per line,
+ * and CPP can't insert newlines, so we have to repeat everything
+ * at least twice.
  */
-#define __EXPORT_THUNK(sym) _ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
-#define EXPORT_THUNK(reg) __EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
-#define GENERATE_THUNK(reg) THUNK reg ; EXPORT_THUNK(reg)
 
-GENERATE_THUNK(_ASM_AX)
-GENERATE_THUNK(_ASM_BX)
-GENERATE_THUNK(_ASM_CX)
-GENERATE_THUNK(_ASM_DX)
-GENERATE_THUNK(_ASM_SI)
-GENERATE_THUNK(_ASM_DI)
-GENERATE_THUNK(_ASM_BP)
-#ifdef CONFIG_64BIT
-GENERATE_THUNK(r8)
-GENERATE_THUNK(r9)
-GENERATE_THUNK(r10)
-GENERATE_THUNK(r11)
-GENERATE_THUNK(r12)
-GENERATE_THUNK(r13)
-GENERATE_THUNK(r14)
-GENERATE_THUNK(r15)
-#endif
+#define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
+#define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
+
+#undef GEN
+#define GEN(reg) THUNK reg
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) EXPORT_THUNK(reg)
+#include <asm/GEN-for-each-reg.h>
+


