Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC8DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5953120705
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K3Rq6mtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbgDAOWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:22:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDAOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jt6kQ/7jZjF4jIZ7hA0fedkh4c/2dLW/5f5OfnJUwJc=; b=K3Rq6mtqzo1MfYlTy0XL3DhPfY
        WphMt+rBISm0SvqpYzIiev/E74tOx3kpd+Q7cYiI9PP7mH3d294QmI4T/HngO8HdeFa3h+LV3LtZK
        VETPHEJWaYE/BoZgxp5GglRfgdFvfOqg6iNv2384cC8XsoR4MaV8iAfGiuOjDpdKlF4UBVZhYXtau
        S5njnbWmPbAvwZ/e2VpP8VIXErlQSH+2WCcpks8TcojMDPCGbkiO/OfVeEi2g3b/GFg/cmgfs8oC4
        QzgxOGx+Hhbb2AyLNZvIm9IAvlAWqLnXrGP0JousyKNZBf1UoKybMCt8g5Mwf9MGq/rufXcj73hb9
        G0cErhlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJeGC-0006zU-10; Wed, 01 Apr 2020 14:22:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E00C3060FD;
        Wed,  1 Apr 2020 16:22:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 765F429D8618F; Wed,  1 Apr 2020 16:22:26 +0200 (CEST)
Date:   Wed, 1 Apr 2020 16:22:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200401142226.GU20696@hirez.programming.kicks-ass.net>
References: <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <20200401141402.m4klvezp5futb7ff@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401141402.m4klvezp5futb7ff@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 09:14:02AM -0500, Josh Poimboeuf wrote:
> On Wed, Apr 01, 2020 at 12:27:03AM +0200, Peter Zijlstra wrote:
> > On Tue, Mar 31, 2020 at 04:20:40PM -0500, Josh Poimboeuf wrote:
> > > On Tue, Mar 31, 2020 at 04:17:58PM -0500, Josh Poimboeuf wrote:
> > > > > I'm not against adding a second/separate hint for this. In fact, I
> > > > > almost considered teaching objtool how to interpret the whole IRET frame
> > > > > so that we can do it without hints. It's just that that's too much code
> > > > > for this one case.
> > > > > 
> > > > > HINT_IRET_SELF ?
> > > > 
> > > > Despite my earlier complaint about stack size knowledge, we could just
> > > > forget the hint and make "iretq in C code" equivalent to "reduce stack
> > > > size by arch_exception_stack_size()" and keep going.  There's
> > > > file->c_file which tells you it's a C file.
> > > 
> > > Or maybe "iretq in an STT_FUNC" is better since this pattern could
> > > presumably happen in a callable asm function.
> > 
> > Like so then?
> 
> I'd suggest a patch split like:
> 
> 1) objtool: automagic IRET-in-func
> 2) objtool: add RET_OFFSET
> 3) ftrace:  re-organize asm (and use RET_OFFSET hint)
> 4) objtool: remove now-unused SAVE/RESTORE

Sure.

> > --- a/arch/x86/include/asm/orc_types.h
> > +++ b/arch/x86/include/asm/orc_types.h
> > @@ -58,8 +58,13 @@
> >  #define ORC_TYPE_CALL			0
> >  #define ORC_TYPE_REGS			1
> >  #define ORC_TYPE_REGS_IRET		2
> > -#define UNWIND_HINT_TYPE_SAVE		3
> > -#define UNWIND_HINT_TYPE_RESTORE	4
> > +
> > +/*
> > + * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
> > + * and sibling calls. On these, sp_offset denotes the expected offset from
> > + * initial_func_cfi.
> > + */
> > +#define UNWIND_HINT_TYPE_RET_OFFSET	3
> 
> I think this comment belongs at the UNWIND_HINT_RET_OFFSET macro
> definition.

Humph, ok, but there's two of those :/

> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -282,7 +282,8 @@ static inline void tramp_free(void *tram
> > 
> >  /* Defined as markers to the end of the ftrace default trampolines */
> >  extern void ftrace_regs_caller_end(void);
> > -extern void ftrace_epilogue(void);
> > +extern void ftrace_regs_caller_ret(void);
> > +extern void ftrace_caller_end(void);
> >  extern void ftrace_caller_op_ptr(void);
> >  extern void ftrace_regs_caller_op_ptr(void);
> > 
> > @@ -334,7 +335,7 @@ create_trampoline(struct ftrace_ops *ops
> >  		call_offset = (unsigned long)ftrace_regs_call;
> >  	} else {
> >  		start_offset = (unsigned long)ftrace_caller;
> > -		end_offset = (unsigned long)ftrace_epilogue;
> > +		end_offset = (unsigned long)ftrace_caller_end;
> >  		op_offset = (unsigned long)ftrace_caller_op_ptr;
> >  		call_offset = (unsigned long)ftrace_call;
> >  	}
> > @@ -366,6 +367,13 @@ create_trampoline(struct ftrace_ops *ops
> >  	if (WARN_ON(ret < 0))
> >  		goto fail;
> > 
> > +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> > +		ip = ftrace_regs_caller_ret;
> > +		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
> > +		if (WARN_ON(ret < 0))
> > +			goto fail;
> > +	}
> > +
> 
> Hm?  This function creates a trampoline but it looks like this change is
> overwriting the original ftrace_64 code itself?

Ahh. So if you look at what the trampoline copies, you'll note we'll
copy until -- but *NOT* including -- the jmp ftrace_epilogue. Instead
we'll write a RET at the end.

However, due to splitting the return path, such that each instruction
has a unique stack offset, we now have a second jmp ftrace_epilogue in
the middle of the function. That too needs to be overwritten by a RET.

> > --- a/tools/objtool/Makefile
> > +++ b/tools/objtool/Makefile
> > @@ -31,7 +31,7 @@ INCLUDES := -I$(srctree)/tools/include \
> >  	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
> >  	    -I$(srctree)/tools/arch/$(SRCARCH)/include
> >  WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
> > -CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> > +CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -ggdb3 $(INCLUDES) $(LIBELF_FLAGS)
> >  LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> 
> Why?  Smells like a separate patch at least.

Oh, whoops :-) I keep doing this every time I need to run gdb on it.
I'll make it go away.
