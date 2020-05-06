Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C07C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61C120735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZBzbczY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgEFR71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgEFR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:59:27 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2044AC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=46gIvuh3m5ttMTLg33SSv4jAWgstAfDston+xkQue2w=; b=TZBzbczYZufgPt8ibCZCv/Mv72
        gagKhxN7EHkHY9LLNGieHsKUIKLa929R89NkZSsfhBdBteM/f+JkgmV7Aouz0ofTsRLT+U+WrP8Th
        +D2A2sNSz2/ZS7g4F7Tsc3BbMSBSQ1TJnsB1IjTnmKYBGHxq4DLQ0PJMH3iXu3iqys3rZ+kDIqNV0
        wYoEexxYrnEJhoHYVF5ahX6l6jaPPZvvYe+CU9t2Gfkv22wRvV4EJ5D+qpN9p8w9xfp8UXrr39kOc
        Or5EQ9SCuMhWG7cgfPK9fMLn21VJmnOj4Kg5aB97sbKWYsQWBjele5l9dmif3oVBqw4eh1ZbOUgYa
        M7lJt8rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWOJr-0000Rw-EB; Wed, 06 May 2020 17:58:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE5B3301DFC;
        Wed,  6 May 2020 19:58:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9AF32B87C191; Wed,  6 May 2020 19:58:52 +0200 (CEST)
Date:   Wed, 6 May 2020 19:58:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200506175852.GW3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <20200506172455.ho5em2mtzn7qqfjl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506172455.ho5em2mtzn7qqfjl@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:24:55PM -0500, Josh Poimboeuf wrote:
> On Fri, May 01, 2020 at 10:29:03PM +0200, Peter Zijlstra wrote:
> > +++ b/arch/x86/include/asm/static_call.h
> > @@ -30,4 +30,14 @@
> >  	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> >  	    ".popsection					\n")
> >  
> > +#define ARCH_DEFINE_STATIC_CALL_RETTRAMP(name)				\
> > +	asm(".pushsection .static_call.text, \"ax\"		\n"	\
> > +	    ".align 4						\n"	\
> > +	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
> > +	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> > +	    "	ret; nop; nop; nop; nop;			\n"	\
> > +	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
> > +	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> > +	    ".popsection					\n")
> > +
> 
> The boilerplate in these two trampoline macros is identical except for
> the actual instructions, maybe there could be a shared
> __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insns) macro which does most of
> the dirty work.

I'm afraid that'll just make it less readable :/

> >  #endif /* _ASM_STATIC_CALL_H */
> > --- a/arch/x86/kernel/static_call.c
> > +++ b/arch/x86/kernel/static_call.c
> > @@ -4,19 +4,41 @@
> >  #include <linux/bug.h>
> >  #include <asm/text-patching.h>
> >  
> > -static void __static_call_transform(void *insn, u8 opcode, void *func)
> > +enum insn_type {
> > +	call = 0, /* site call */
> > +	nop = 1,  /* site cond-call */
> > +	jmp = 2,  /* tramp / site tail-call */
> > +	ret = 3,  /* tramp / site cond-tail-call */
> > +};
> 
> The lowercase enums threw me for a loop, I thought they were variables a
> few times.  Starting a new enum trend? :-)

I can UPPERCASE them I suppose, not sure where this came from.

> >  void arch_static_call_transform(void *site, void *tramp, void *func)
> > @@ -24,10 +46,10 @@ void arch_static_call_transform(void *si
> >  	mutex_lock(&text_mutex);
> >  
> >  	if (tramp)
> > -		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
> > +		__static_call_transform(tramp, jmp + !func, func);
> >  
> >  	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
> > -		__static_call_transform(site, CALL_INSN_OPCODE, func);
> > +		__static_call_transform(site, !func, func);
> 
> Clever enum math, but probably more robust to be ignorant of the values:
> 
> 	if (tramp)
> 		__static_call_transform(tramp, func ? jmp : ret, func);
> 
>   	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
> 		__static_call_transform(site, func ? call : nop, func);
> 

That is more readable, and I checked, GCC is clever enough to not
actually emit branches for that, so w00t.

> > +++ b/include/linux/static_call.h
> > @@ -16,7 +16,9 @@
> >   *
> >   *   DECLARE_STATIC_CALL(name, func);
> >   *   DEFINE_STATIC_CALL(name, func);
> > + *   DEFINE_STATIC_COND_CALL(name, typename);
> >   *   static_call(name)(args...);
> > + *   static_cond_call(name)(args...)
> >   *   static_call_update(name, func);
> 
> Missing semicolon, also an updated description/example would be useful.

Yes, I already promised Rasmus more documentation.

> On that note, what do you think about tweaking the naming from
> 
>   DEFINE_STATIC_COND_CALL(name, typename);
>   static_cond_call(name)(args...);
> 
> to
> 
>   DEFINE_STATIC_CALL_NO_FUNC(name, typename);
>   static_call_if_func(name)(args...);
> 
> ?
> 
> Seems clearer to me.  They're still STATIC_CALLs, so it seems logical to
> keep those two words together.  And NO_FUNC clarifies the initialized
> value.
> 
> Similarly RETTRAMP could be ARCH_DEFINE_STATIC_CALL_NO_FUNC.

What can I say, I'm sorta used to the old naming by now, but sure, any
other opinions before I edit things?
