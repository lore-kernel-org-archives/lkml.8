Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948D8C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62374206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NlmLniwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgDFLEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:04:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgDFLEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=91jomgqgEShWhxWCDxxUvWHFtjKYAeVic8T17yZiSn8=; b=NlmLniwPmUoH7YNLXVJdXPrK+l
        BSO/zxAlrDgIJGujl0MsOfF08n+YIxscjpHe/C9oL+Vu7U8axjLxRB/5kcttKWJ+eCdZxE+tW6HUH
        If1hKl2oaimP6hbVLps5D4MDFT3d4bbFkibKLPmq9qui6MxO4SPzptmtPLYVgAW7d8alHnvRx52ai
        X5PaXfw+ovZ8oZWzV2yPq0qTgnlFjSWWYFNDKfAQ3lMckmhw16UNGhB7mZeGM3iEGHwsgTq3Owe/m
        w9ElvyKlI2yDoZl93WASyZTVuln50boW6iBuhck7D826fc/ct9HzvKom8P7DDcUh935dAPmNJ9Wt/
        f+BUW8rQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLPYX-0005ld-8D; Mon, 06 Apr 2020 11:04:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6B41304121;
        Mon,  6 Apr 2020 13:04:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB48F2BAC6A8E; Mon,  6 Apr 2020 13:04:38 +0200 (CEST)
Date:   Mon, 6 Apr 2020 13:04:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fangrui Song <maskray@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        clang-built-linux@googlegroups.com, hjl.tools@gmail.com
Subject: Re: [RESEND][PATCH v3 09/17] x86/static_call: Add out-of-line static
 call implementation
Message-ID: <20200406110438.GJ20730@hirez.programming.kicks-ass.net>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.819003994@infradead.org>
 <20200406010859.bcfouhukcgmg2on7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406010859.bcfouhukcgmg2on7@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 06:08:59PM -0700, Fangrui Song wrote:
> On 2020-03-24, Peter Zijlstra wrote:

> > +#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
> > +	asm(".pushsection .text, \"ax\"				\n"	\
> > +	    ".align 4						\n"	\
> > +	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
> > +	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> > +	    "	jmp.d32 " #func "				\n"	\
> > +	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
> > +	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> > +	    ".popsection					\n")
> > +
> > +#endif /* _ASM_STATIC_CALL_H */
> 
> Hi Peter,
> 
> Coming here from https://github.com/ClangBuiltLinux/linux/issues/974
> 
> jmp.d32 is not recognized by clang integrated assembler.
> The syntax appears to be very rarely used. According to Debian Code Search,
> u-boot is the only project using this syntax.

*groan*... I was going to use it in more places :-/

> In March 2017, gas added the pseudo prefix {disp32}
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=86fa6981e7487e2c2df4337aa75ed2d93c32eaf2
> which generalizes jmp.d32  ({disp32} jmp foo)

That's all well and cute, but I can't use that because its too new. Not
until we raise the minimum gcc/bintils version to something that
includes that.

> I wonder whether the instruction jmp.d32 can be replaced with the trick in
> arch/x86/include/asm/jump_label.h for clang portability.
> 
> % grep -A2 'jmp.d32' arch/x86/include/asm/jump_label.h
>         /* Equivalent to "jmp.d32 \target" */
>         .byte           0xe9
>         .long           \target - .Lstatic_jump_after_\@

Sure, but I was hoping to move away from that since all assemblers
should now support jmp.d32. Except of course, you have to go ruin
things.

The thing is, jmp.d32 reads so much nicer than the above crap.

Also, I still need a meta instruction like:

	nopjmp $label

what works just like 'jmp' but instead emits either a nop2 or a nop5.
I tried various hacks to get GAS to emit that, but no luck :/

The only up-side from that new syntax is that I suppose we can go write:

  {disp8} push \vec

without gas shitting itself and emitting a 5 byte push just because..
Except of course we can't, for the same reason I can't go around and
use:

  {disp32} jmp

in the above code.
