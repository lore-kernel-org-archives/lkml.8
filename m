Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDCEC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087DA214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bj1DjXXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442252AbgDPPOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395071AbgDPPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:12:18 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5DDC061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=b/SVIF2bqg/aqFhiDrD4mJ5SPvsGXxPICH6tt/LqIrQ=; b=Bj1DjXXCocH4tUw12qeWrn1JeB
        oM3bo+wTGczUMDn1QaedE6l5Rk1me7g20I1afVqXRx2OO1izft/EXM7QlT8ri4Tlt5nhf61VML+e9
        jt4uDfPBRCQ1dYv9tk9ipU2M7d3zVS9/dAjTPs+zmhupb271CUdABZevC5uIySeHn3xOpe0Fj6xKs
        MKqnliYnsO7a415mqKKRsM8dH6ogsKxecg2mG8q1XMWidnUMU0JKgqUxxuNXft3FxwYHbWw7BA199
        WVTogdy2gJ1opROkyxD2FIJKK9jtJ31J9+tW+O+KXw9BDiy6vfQBmlhSFiAvWsxBtApZSqSWO6/HW
        VM2MVK9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6BJ-00046w-4y; Thu, 16 Apr 2020 15:11:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43A5630746C;
        Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 14C9A2B0DE4C6; Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Message-Id: <20200416151025.004441230@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 17:07:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 5/7] x86/speculation: Change __FILL_RETURN_BUFFER to work with objtool
References: <20200416150752.569029800@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Chartre <alexandre.chartre@oracle.com>

Change __FILL_RETURN_BUFFER so that the stack state is deterministically
defined for each iteration and that objtool can have an accurate view
of the stack.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200414103618.12657-8-alexandre.chartre@oracle.com
---
 arch/x86/include/asm/nospec-branch.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -4,6 +4,7 @@
 #define _ASM_X86_NOSPEC_BRANCH_H_
 
 #include <linux/static_key.h>
+#include <linux/frame.h>
 
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
@@ -46,12 +47,14 @@
 #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
 	mov	$(nr/2), reg;			\
 771:						\
+	ANNOTATE_INTRA_FUNCTION_CALL		\
 	call	772f;				\
 773:	/* speculation trap */			\
 	pause;					\
 	lfence;					\
 	jmp	773b;				\
 772:						\
+	ANNOTATE_INTRA_FUNCTION_CALL		\
 	call	774f;				\
 775:	/* speculation trap */			\
 	pause;					\
@@ -59,8 +62,8 @@
 	jmp	775b;				\
 774:						\
 	dec	reg;				\
-	jnz	771b;				\
-	add	$(BITS_PER_LONG/8) * nr, sp;
+	add	$(BITS_PER_LONG/8) * 2, sp;	\
+	jnz	771b;
 
 #ifdef __ASSEMBLY__
 


