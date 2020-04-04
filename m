Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5102C4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9662B206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZqcbHlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgDDPvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:51:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46080 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgDDPvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3EYtfa+xKjdEtRV4GP+wBSY6n8PKxJuyv9F+7SC/PjM=; b=FZqcbHltgEPav+1HbWDD3soPTv
        82jW5d/oJCgdb54eQTFl7FcIvXkf58K7t8eZpfMDerK7e23t3/FFv9TEmDErnnXgo0HlEvXxPDotK
        671hUR+jyqw6t6qP64dAHK1W2gctoLi0ywnlkY/whF91Q7WJue4KVGOUF0mRyW2fqZsXMjhgifQSb
        TFt6EFyJhEYjmCzGju+V38dq5c/P0lo0rf/pbwD3+NsJxnkZfOAAteQriO8TgyQfi/kv02LWYEmDJ
        leYnj3OQ3SQEeEnC9shYANe7X4vXZhZkAFn61Mhg70QTLSkXI+81QXnFyhWXoi+q9L+Mdg2pjfyQu
        1IJJOzRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKl4z-00028L-K6; Sat, 04 Apr 2020 15:51:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87CB830275A;
        Sat,  4 Apr 2020 17:51:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A7072B15588B; Sat,  4 Apr 2020 17:51:26 +0200 (CEST)
Date:   Sat, 4 Apr 2020 17:51:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200404155126.GF20730@hirez.programming.kicks-ass.net>
References: <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
 <20200403154620.GS20730@hirez.programming.kicks-ass.net>
 <20200404133218.GL20760@hirez.programming.kicks-ass.net>
 <20200404142232.wpn7estahnabfy3z@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404142232.wpn7estahnabfy3z@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 09:22:32AM -0500, Josh Poimboeuf wrote:
> On Sat, Apr 04, 2020 at 03:32:18PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 03, 2020 at 05:46:20PM +0200, Peter Zijlstra wrote:
> > > On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
> > > > Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
> > > > work here?
> > > 
> > > Yes, it would.
> > 
> > Sorry, I have reconsidered. While it will shut up objtool, it will not
> > 'work'. That is, the ORC data generated will not correctly unwind.
> > 
> > I'll try and write a longer email tonight.
> 
> Right, that's what I've been trying to say.  The ORC data will be
> non-deterministic unless we unroll the loop.  Or did you mean something
> else?

The below should result in deterministic code.

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 07e95dcb40ad..109ee65f4a11 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -59,8 +59,8 @@
 	jmp	775b;				\
 774:						\
 	dec	reg;				\
-	jnz	771b;				\
-	add	$(BITS_PER_LONG/8) * nr, sp;
+	add	$(BITS_PER_LONG/8) * $2, sp;	\
+	jnz	771b;
 
 #ifdef __ASSEMBLY__
 
