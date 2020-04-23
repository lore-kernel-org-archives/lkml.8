Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217B0C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AAF2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gDm86eyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgDWMwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728423AbgDWMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:52:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4EC09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Qpd6POV9Dl8cGfRxGgmp4VrrkawprFNWTAByrT5wpXg=; b=gDm86eyKt0VrA9z3hFMUYTF6Qp
        i/PtD7TqxqBnj7gMvmmmOQO8ucDK1DxLqf/1W9KXNuU0MfoP4W+l5j3gJkHzhEu5xUQ4gweBf+6Kl
        q3kMZUJ1QovXoJrprpRHAH3bsiATRjznxyPGZ3bmUWz1gelbevEToaq4rtLLc5vbx2DpsReasBoun
        V+a6KQozXUJcNT474Tgnfp6BO2eHYyfuQelhFQ0B/WyGxjHLoMw85rpsqvok8Gm1RrCpBZlfbjo07
        PLLUr/W3pHYClJAp9R8qn/CqajOlz+5/0n9W3NvSMeAIiedur8g2wfQQh3TprnbkgEtNLhHlksThZ
        9gNN6dZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRbKi-0005ma-LD; Thu, 23 Apr 2020 12:52:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6AB29306AF8;
        Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 471F920BE6380; Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Message-Id: <20200423125042.876058319@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Apr 2020 14:47:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH 5/8] x86/speculation: Change FILL_RETURN_BUFFER to work with objtool
References: <20200423125013.452964352@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change FILL_RETURN_BUFFER and vmexit_fill_RSB() so that objtool groks
them and can generate correct ORC unwind information for them.

 - Since ORC is alternative invariant; that is, all alternatives
   should have the same ORC entries, the __FILL_RETURN_BUFFER body
   can not be part of an alternative.

   Therefore, move it out of the alternative and keep the alternative
   as a sort of jump_label around it.

 - Use the ANNOTATE_INTRA_FUNCTION_CALL annotation to white-list
   these 'funny' call instructions to nowhere.

 - Use UNWIND_HINT_EMPTY to 'fill' the speculation traps, otherwise
   objtool will consider them unreachable.

 - Move the RSP adjustment into the loop, such that the loop has a
   deterministic stack layout.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -4,11 +4,13 @@
 #define _ASM_X86_NOSPEC_BRANCH_H_
 
 #include <linux/static_key.h>
+#include <linux/frame.h>
 
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
+#include <asm/unwind_hints.h>
 
 /*
  * This should be used immediately before a retpoline alternative. It tells
@@ -46,21 +48,25 @@
 #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
 	mov	$(nr/2), reg;			\
 771:						\
+	ANNOTATE_INTRA_FUNCTION_CALL		\
 	call	772f;				\
 773:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;			\
 	pause;					\
 	lfence;					\
 	jmp	773b;				\
 772:						\
+	ANNOTATE_INTRA_FUNCTION_CALL		\
 	call	774f;				\
 775:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;			\
 	pause;					\
 	lfence;					\
 	jmp	775b;				\
 774:						\
+	add	$(BITS_PER_LONG/8) * 2, sp;	\
 	dec	reg;				\
-	jnz	771b;				\
-	add	$(BITS_PER_LONG/8) * nr, sp;
+	jnz	771b;
 
 #ifdef __ASSEMBLY__
 
@@ -137,10 +143,8 @@
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


