Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22537C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9072070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NKw8Y0gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgD1TTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728338AbgD1TTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73846C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=T3Az2I6NrBjKPYKkaUHbBFNx72yC5+65dAU5og422iQ=; b=NKw8Y0gCT0LnDWhB84Bt0wYy0j
        dX/TSZwfSX1Yj6vAAFKudsQ9UCvpxAw47Iw4wvjjW7Kk33FSLDdGGeLuaEvfHI2n5hk8E9cFcfyJo
        pnsNiH0BkNGAAgJKSDayU6gskd+RYeU3R9/w0o5fi1P+WUYgpIMhc09n052/eci+4usHJbxqV/DYQ
        k8dPhoEH46t6Jsm0ujKRbuyKMN6gcFYNYCYflbc1koi2kMdJjNq7BG6wpZ4JmP2omiTEBWFnu+rL2
        5Sd9infhXhVtTAXojjfqXwdP4U/wMRbBPZ5IkWYusxqKbVIikXdpKzm0rN4/Upbqas/EVmvGjCSQ5
        NKzVzGVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlQ-0006Vl-7H; Tue, 28 Apr 2020 19:19:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9583E3075DB;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7FB3725D01311; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191659.558899462@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 03/14] x86,smap: Fix smap_{save,restore}() alternatives
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by objtool:

  lib/ubsan.o: warning: objtool: .altinstr_replacement+0x0: alternative modifies stack
  lib/ubsan.o: warning: objtool: .altinstr_replacement+0x7: alternative modifies stack

the smap_{save,restore}() alternatives violate (the newly enforced)
rule on stack invariance. That is, due to there only being a single
ORC table it must be valid to any alternative. These alternatives
violate this with the direct result that unwinds will not be correct
in between these calls.

[ In specific, since we force SMAP on for objtool, running on !SMAP
hardware will observe a different stack-layout and the ORC unwinder
will stumble. ]

So rewrite the functions to unconditionally save/restore the flags,
which gives an invariant stack layout irrespective of the SMAP state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/smap.h |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -57,16 +57,19 @@ static __always_inline unsigned long sma
 {
 	unsigned long flags;
 
-	asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
-				  X86_FEATURE_SMAP)
-		      : "=rm" (flags) : : "memory", "cc");
+	asm volatile ("# smap_save\n\t"
+		      "pushf; pop %0"
+		      : "=rm" (flags) : : "memory");
+
+	clac();
 
 	return flags;
 }
 
 static __always_inline void smap_restore(unsigned long flags)
 {
-	asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
+	asm volatile ("# smap_restore\n\t"
+		      "push %0; popf"
 		      : : "g" (flags) : "memory", "cc");
 }
 


