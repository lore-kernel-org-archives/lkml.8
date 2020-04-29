Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC970C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51022073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rXaGgUyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD2KSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgD2KSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:18:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EADBC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O4oSLMbagjvesSlEm/b27ihwjuOmH9oGqPuJvxLvzPc=; b=rXaGgUypclMJ/dNqK6MkrYjqFg
        7cfR5YOg+XQeOZHqTkmKfyVCpLVERMyq68jDZM2rex/O+ogYmPKdAEf8HH2V4j3YCv6qeQkLIT+lZ
        jg9PhEdK1QPkY1LhonaJ5m5EoWGgm0ovP9wGUZEBEDJMXT9p3DxxTtNvng5MAw/K7eHvJqE4cj0e2
        stBxewTT0yZ1MqJaKp1gsv8SpAPAh95bryLsfJcGLB+nNm5lU1iqYN8cZiBjNYGN+zgjhiLE0xiiM
        Glivjvz8NqigBTQE5KYfVz8ROHSU/DNlm7EpksrgjFj2EcpNSN7pONMnzoUMI9eGAD0Kw+eHFcSbS
        zrjrkgnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTjn3-0004UF-LA; Wed, 29 Apr 2020 10:18:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A39A301224;
        Wed, 29 Apr 2020 12:18:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E497201F9F0B; Wed, 29 Apr 2020 12:18:02 +0200 (CEST)
Date:   Wed, 29 Apr 2020 12:18:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jthierry@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 03/14] x86,smap: Fix smap_{save,restore}() alternatives
Message-ID: <20200429101802.GI13592@hirez.programming.kicks-ass.net>
References: <20200428191101.886208539@infradead.org>
 <20200428191659.558899462@infradead.org>
 <CAMzpN2jp1mtnf61eXPaj2O5=-8Fp42v+t6Br3ce9Fioq8h=0YA@mail.gmail.com>
 <20200429083053.GE13592@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429083053.GE13592@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:30:53AM +0200, Peter Zijlstra wrote:
> > POPF is an expensive instruction that should be avoided if possible.
> > A better solution would be to have the alternative jump over the
> > push/pop when SMAP is disabled.
> 
> Yeah. I think I had that, but then confused myself again. I don't think
> it matters much if you look at where it's used though.
> 
> Still, let me try the jmp thing again..

Here goes..

---
Subject: x86,smap: Fix smap_{save,restore}() alternatives
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Apr 28 19:57:59 CEST 2020

As reported by objtool:

  lib/ubsan.o: warning: objtool: .altinstr_replacement+0x0: alternative modifies stack
  lib/ubsan.o: warning: objtool: .altinstr_replacement+0x7: alternative modifies stack

the smap_{save,restore}() alternatives violate (the newly enforced)
rule on stack invariance. That is, due to there only being a single
ORC table it must be valid to any alternative. These alternatives
violate this with the direct result that unwinds will not be correct
when it hits between the PUSH and POP instructions.

Rewrite the functions to only have a conditional jump.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/smap.h |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -57,8 +57,10 @@ static __always_inline unsigned long sma
 {
 	unsigned long flags;
 
-	asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
-				  X86_FEATURE_SMAP)
+	asm volatile ("# smap_save\n\t"
+		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
+		      "pushf; pop %0; " __ASM_CLAC "\n\t"
+		      "1:"
 		      : "=rm" (flags) : : "memory", "cc");
 
 	return flags;
@@ -66,7 +68,10 @@ static __always_inline unsigned long sma
 
 static __always_inline void smap_restore(unsigned long flags)
 {
-	asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
+	asm volatile ("# smap_restore\n\t"
+		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
+		      "push %0; popf\n\t"
+		      "1:"
 		      : : "g" (flags) : "memory", "cc");
 }
 
