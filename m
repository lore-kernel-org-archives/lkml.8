Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4284C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8489A20658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJQlZaka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbgDAOjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:39:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36045 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732976AbgDAOjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585751962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpUXP8laC9RyobE1gvL0sU8pGwybPyvUGTH+WRG12+4=;
        b=HJQlZaka6R/tjs/dKiuiyyg3op/lo+lrA//gRdLufpOEIoYrEe2VVm43RjVIpjoNJBc/R0
        KU2fLqhdUeOgpFgI4A7u7pjQU5DlKAoG+YZhoWtBjbVu/nhTCaDDFu4t7raZjBvaMBvBYT
        lksHjJM/SRAJhF7tNOCKLTSOrok7MN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-jU89qjhQPXuRw-w6e6IVkQ-1; Wed, 01 Apr 2020 10:39:21 -0400
X-MC-Unique: jU89qjhQPXuRw-w6e6IVkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 765DB1005055;
        Wed,  1 Apr 2020 14:39:19 +0000 (UTC)
Received: from treble (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CEE4D768F;
        Wed,  1 Apr 2020 14:39:18 +0000 (UTC)
Date:   Wed, 1 Apr 2020 09:39:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200401143916.h5keq55yabetyv5u@treble>
References: <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <20200401141402.m4klvezp5futb7ff@treble>
 <20200401142226.GU20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401142226.GU20696@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:22:26PM +0200, Peter Zijlstra wrote:
> > > --- a/arch/x86/include/asm/orc_types.h
> > > +++ b/arch/x86/include/asm/orc_types.h
> > > @@ -58,8 +58,13 @@
> > >  #define ORC_TYPE_CALL			0
> > >  #define ORC_TYPE_REGS			1
> > >  #define ORC_TYPE_REGS_IRET		2
> > > -#define UNWIND_HINT_TYPE_SAVE		3
> > > -#define UNWIND_HINT_TYPE_RESTORE	4
> > > +
> > > +/*
> > > + * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
> > > + * and sibling calls. On these, sp_offset denotes the expected offset from
> > > + * initial_func_cfi.
> > > + */
> > > +#define UNWIND_HINT_TYPE_RET_OFFSET	3
> > 
> > I think this comment belongs at the UNWIND_HINT_RET_OFFSET macro
> > definition.
> 
> Humph, ok, but there's two of those :/

Just commenting the asm one should be fine I think.

That way a reader of code using the macro is more likely to understand
its purpose.

> > > --- a/arch/x86/kernel/ftrace.c
> > > +++ b/arch/x86/kernel/ftrace.c
> > > @@ -282,7 +282,8 @@ static inline void tramp_free(void *tram
> > > 
> > >  /* Defined as markers to the end of the ftrace default trampolines */
> > >  extern void ftrace_regs_caller_end(void);
> > > -extern void ftrace_epilogue(void);
> > > +extern void ftrace_regs_caller_ret(void);
> > > +extern void ftrace_caller_end(void);
> > >  extern void ftrace_caller_op_ptr(void);
> > >  extern void ftrace_regs_caller_op_ptr(void);
> > > 
> > > @@ -334,7 +335,7 @@ create_trampoline(struct ftrace_ops *ops
> > >  		call_offset = (unsigned long)ftrace_regs_call;
> > >  	} else {
> > >  		start_offset = (unsigned long)ftrace_caller;
> > > -		end_offset = (unsigned long)ftrace_epilogue;
> > > +		end_offset = (unsigned long)ftrace_caller_end;
> > >  		op_offset = (unsigned long)ftrace_caller_op_ptr;
> > >  		call_offset = (unsigned long)ftrace_call;
> > >  	}
> > > @@ -366,6 +367,13 @@ create_trampoline(struct ftrace_ops *ops
> > >  	if (WARN_ON(ret < 0))
> > >  		goto fail;
> > > 
> > > +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> > > +		ip = ftrace_regs_caller_ret;
> > > +		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
> > > +		if (WARN_ON(ret < 0))
> > > +			goto fail;
> > > +	}
> > > +
> > 
> > Hm?  This function creates a trampoline but it looks like this change is
> > overwriting the original ftrace_64 code itself?
> 
> Ahh. So if you look at what the trampoline copies, you'll note we'll
> copy until -- but *NOT* including -- the jmp ftrace_epilogue. Instead
> we'll write a RET at the end.
> 
> However, due to splitting the return path, such that each instruction
> has a unique stack offset, we now have a second jmp ftrace_epilogue in
> the middle of the function. That too needs to be overwritten by a RET.

Right, but 'ip' needs to point to the trampoline's version of
'ftrace_regs_caller_ret', not the original ftrace_64 version.

> > > --- a/tools/objtool/Makefile
> > > +++ b/tools/objtool/Makefile
> > > @@ -31,7 +31,7 @@ INCLUDES := -I$(srctree)/tools/include \
> > >  	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
> > >  	    -I$(srctree)/tools/arch/$(SRCARCH)/include
> > >  WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
> > > -CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> > > +CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -ggdb3 $(INCLUDES) $(LIBELF_FLAGS)
> > >  LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> > 
> > Why?  Smells like a separate patch at least.
> 
> Oh, whoops :-) I keep doing this every time I need to run gdb on it.
> I'll make it go away.

Ha, I do something similar, I just add -O0 to CFLAGS.

-- 
Josh

