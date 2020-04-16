Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C51EC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE81C22246
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XvlfIPTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbgDPPMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395052AbgDPPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:12:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E7C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=C//9zFAM8a38K1V83WGzMSKEDUsKbQ07j0TNt8ViuBg=; b=XvlfIPTbYfHKUs/x7M4H5RhVC8
        T5lF4mwIFOah4qBdOAdZpr9wf/g1bXk5rxUdXxAUH4EmIEJZfmtTosTExZAN2bM5s22De5q388khD
        GFMC2zHQUbuWgdvlHAx35ryFYayieLrsPuOp3uw7NvQ6HB30zV7NS4HPYJmYxouswlVZXoYb7iOJJ
        FINloyMH2VgOy2DWq+vegH60AQceTgzAc2fm9kRlFvPRpCA9WAAPV+jnqwlo5y0xzFidALd7cD422
        hwWXOnYigwqYZ2nOWFf5EXtPYI6FNGa+3juhMn+CqT6vQlhrdbFdCm2ZXkKv98SafwCr73JsNRvd6
        lut5e09Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6BI-0003Wg-94; Thu, 16 Apr 2020 15:11:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43B553074A7;
        Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A6782B0DE9F7; Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Message-Id: <20200416151025.123683762@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 17:07:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 7/7] x86/nospec: Remove ANNOTATE_NOSPEC_ALTERNATIVE
References: <20200416150752.569029800@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that objtool is smart enough; remove ANNOTATE_NOSPEC_ALTERNATIVE
so that we might generate correct ORC unwind information.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -10,15 +10,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
-
-/*
- * This should be used immediately before a retpoline alternative. It tells
- * objtool where the retpolines are so that it can make sense of the control
- * flow by just reading the original instruction(s) and ignoring the
- * alternatives.
- */
-#define ANNOTATE_NOSPEC_ALTERNATIVE \
-	ANNOTATE_IGNORE_ALTERNATIVE
+#include <asm/unwind_hints.h>
 
 /*
  * Fill the CPU return stack buffer.
@@ -50,6 +42,7 @@
 	ANNOTATE_INTRA_FUNCTION_CALL		\
 	call	772f;				\
 773:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;			\
 	pause;					\
 	lfence;					\
 	jmp	773b;				\
@@ -57,6 +50,7 @@
 	ANNOTATE_INTRA_FUNCTION_CALL		\
 	call	774f;				\
 775:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;			\
 	pause;					\
 	lfence;					\
 	jmp	775b;				\
@@ -117,10 +111,8 @@
   */
 .macro FILL_RETURN_BUFFER reg:req nr:req ftr:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE "jmp .Lskip_rsb_\@",				\
-		__stringify(__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP))	\
-		\ftr
+	ALTERNATIVE "jmp .Lskip_rsb_\@", "", \ftr
+	__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP)
 .Lskip_rsb_\@:
 #endif
 .endm
@@ -141,7 +133,6 @@
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
 # define CALL_NOSPEC						\
-	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE("", "lfence", X86_FEATURE_RETPOLINE_AMD)	\
 	ALTERNATIVE(ANNOTATE_RETPOLINE_SAFE			\
 		    "call *%[thunk_target]\n",			\
@@ -157,7 +148,6 @@
  * here, anyway.
  */
 # define CALL_NOSPEC						\
-	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
@@ -225,10 +215,8 @@ static inline void vmexit_fill_RSB(void)
 #ifdef CONFIG_RETPOLINE
 	unsigned long loops;
 
-	asm volatile (ANNOTATE_NOSPEC_ALTERNATIVE
-		      ALTERNATIVE("jmp 910f",
-				  __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
-				  X86_FEATURE_RETPOLINE)
+	asm volatile (ALTERNATIVE("jmp 910f", "", X86_FEATURE_RETPOLINE)
+		      __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1))
 		      "910:"
 		      : "=r" (loops), ASM_CALL_CONSTRAINT
 		      : : "memory" );


