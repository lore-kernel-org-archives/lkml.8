Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19EBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3DA206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lcNOL49+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGIK0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIK0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:26:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4146C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NpSN3ki+N4zt0HUfgIrsSnvQ6T16fz2RkuPCF/KHwA4=; b=lcNOL49+Mdl2jAvl5oF+UTjLxQ
        vrGb+GpK2zM5KjxfZnfYS9juP3DkDE/vVX9zDbTGjSHx/lNkzWkb6Aqj31d52bVWq2tYkjA8pHH1j
        X4oYBbugE1sQP0vzJ3VDwzuouBX6kFx5FxmQKvuZ3ewovX1rtAQkJ8HvNak/lTTGcdZWfUvrHNUls
        kvZY933UCc5YIZWLb87GFAe0oLb+sriTw6gaWlXXRdOhxSXqaDw5fHIVsW5q6vSwmDuSaaricufw2
        em88KHjCd6LiqQ/lkCrC+5igMpo53RyFqnh+x6QExX6ZHo4DSxAflVSVRjIj/J+SCG1BBR3cnA/mq
        Yxzsl22A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtTkZ-0006hx-5n; Thu, 09 Jul 2020 10:25:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E405930047A;
        Thu,  9 Jul 2020 12:25:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0866285718DB; Thu,  9 Jul 2020 12:25:50 +0200 (CEST)
Date:   Thu, 9 Jul 2020 12:25:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 09/10] x86/percpu: Clean up percpu_stable_op()
Message-ID: <20200709102550.GN597537@hirez.programming.kicks-ass.net>
References: <20200530221127.459704-1-brgerst@gmail.com>
 <20200530221127.459704-10-brgerst@gmail.com>
 <CAKwvOdmgN7xra26_xBYCJo45OdOUHLNmw16ioLOE171f_HE0eA@mail.gmail.com>
 <CAMzpN2hHSeN9Z3BO_Uo1-yCfh9YdEbkK0wb9E3D8rq6onQDZdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2hHSeN9Z3BO_Uo1-yCfh9YdEbkK0wb9E3D8rq6onQDZdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:19:51AM -0400, Brian Gerst wrote:
> On Mon, Jun 1, 2020 at 4:43 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Sat, May 30, 2020 at 3:11 PM Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > Use __pcpu_size_call_return() to simplify this_cpu_read_stable().
> >
> > Clever! As in this_cpu_read() in include/linux/percpu-defs.h.  Could
> > be its own patch before this, but it's fine.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > > Also remove __bad_percpu_size() which is now unused.
> > >
> > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > ---
> > >  arch/x86/include/asm/percpu.h | 41 ++++++++++-------------------------
> > >  1 file changed, 12 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> > > index 7efc0b5c4ff0..cf2b9c2a241e 100644
> > > --- a/arch/x86/include/asm/percpu.h
> > > +++ b/arch/x86/include/asm/percpu.h
> > > @@ -85,7 +85,6 @@
> > >
> > >  /* For arch-specific code, we can use direct single-insn ops (they
> > >   * don't give an lvalue though). */
> > > -extern void __bad_percpu_size(void);
> > >
> > >  #define __pcpu_type_1 u8
> > >  #define __pcpu_type_2 u16
> > > @@ -167,33 +166,13 @@ do {                                                                      \
> > >         (typeof(_var))(unsigned long) pfo_val__;                        \
> > >  })
> > >
> > > -#define percpu_stable_op(op, var)                      \
> > > -({                                                     \
> > > -       typeof(var) pfo_ret__;                          \
> > > -       switch (sizeof(var)) {                          \
> > > -       case 1:                                         \
> > > -               asm(op "b "__percpu_arg(P1)",%0"        \
> >
> > What does the `P` do here?
> > https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html#Simple-Constraints
> > says can be machine dependent integral literal in a certain range.
> > https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints
> > doesn't document `P` for x86 though...
> 
> https://gcc.gnu.org/onlinedocs/gcc-10.1.0/gcc/Extended-Asm.html#x86-Operand-Modifiers
> 
> Removing the 'P' modifier results in this:
>         movq %gs:$current_task, %rdx    #, pfo_val__
> 
> This is because the 'p' constraint treats a memory address as a
> constant.  I tried replacing it with __this_cpu_read(), which since
> commit 0b9ccc0a should have similar non-volatile semantics.  But the
> compiler still reloaded it on every use, so I left the asm template
> as-is for now until that can be resolved.

Right, I can into that same issue a while back and gave up staring at
compiler innards. __this_cpu_read() *should* allow re-loads, and it does
in places (we've had bugs because of it), but this_cpu_read_stable() is
somehow far more 'effective'.

It would be good if someone can update the comment with that thing, to
explain matters better.
