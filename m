Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1932086A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUXNHrrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgHTPRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:17:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgHTPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597936628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PMXYWC1oBwWR+/jYMDhjSaG6RLS3jk5SAEdEE7HPQTg=;
        b=jUXNHrrcCyVWcJfD7dKG1QjcSCVwjdVJ4oaCjcn439C1l0nTQ/mEiLVDqRzbgjxJL/Zs54
        fCcrkB3QzkT5Xrs92zQaKrtdRvFtHxtTfqgHAOjXiTDksj9JtbBVW06BmClW2yw4LeG9Nh
        q+FvuPc9K0MeUrF0ctmkIY6CBQ1+Mc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-IW4Zq59AM_y1UewTYlPvwA-1; Thu, 20 Aug 2020 11:17:07 -0400
X-MC-Unique: IW4Zq59AM_y1UewTYlPvwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 790641074649;
        Thu, 20 Aug 2020 15:17:04 +0000 (UTC)
Received: from treble (ovpn-117-70.rdu2.redhat.com [10.10.117.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFED17C0B8;
        Thu, 20 Aug 2020 15:17:01 +0000 (UTC)
Date:   Thu, 20 Aug 2020 10:16:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     peterz@infradead.org
Cc:     Brian Gerst <brgerst@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200820151659.b7q7hspe5zsf46eg@treble>
References: <20200820103832.486877479@infradead.org>
 <20200820104905.294802764@infradead.org>
 <CAMzpN2gmCu0q_8gLAOcSuLjpKF+rNj=wiCFsGZXgNwz000HCvg@mail.gmail.com>
 <20200820150841.GB1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820150841.GB1362448@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 05:08:41PM +0200, peterz@infradead.org wrote:
> On Thu, Aug 20, 2020 at 10:45:12AM -0400, Brian Gerst wrote:
> > On Thu, Aug 20, 2020 at 6:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/kernel/traps.c |   24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >
> > > --- a/arch/x86/kernel/traps.c
> > > +++ b/arch/x86/kernel/traps.c
> > > @@ -820,18 +820,6 @@ static void handle_debug(struct pt_regs
> > >                 goto out;
> > >         }
> > >
> > > -       if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
> > > -               /*
> > > -                * Historical junk that used to handle SYSENTER single-stepping.
> > > -                * This should be unreachable now.  If we survive for a while
> > > -                * without anyone hitting this warning, we'll turn this into
> > > -                * an oops.
> > > -                */
> > > -               tsk->thread.debugreg6 &= ~DR_STEP;
> > > -               set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
> > > -               regs->flags &= ~X86_EFLAGS_TF;
> > > -       }
> > > -
> > >         si_code = get_si_code(tsk->thread.debugreg6);
> > >         if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
> > >                 send_sigtrap(regs, 0, si_code);
> > > @@ -874,6 +862,18 @@ static __always_inline void exc_debug_ke
> > >         if (kprobe_debug_handler(regs))
> > >                 goto out;
> > >
> > > +       if (WARN_ON_ONCE(dr6 & DR_STEP)) {
> > > +               /*
> > > +                * Historical junk that used to handle SYSENTER single-stepping.
> > > +                * This should be unreachable now.  If we survive for a while
> > > +                * without anyone hitting this warning, we'll turn this into
> > > +                * an oops.
> > > +                */
> > > +               dr6 &= ~DR_STEP;
> > > +               set_thread_flag(TIF_SINGLESTEP);
> > > +               regs->flags &= ~X86_EFLAGS_TF;
> > > +       }
> > > +
> > >         handle_debug(regs, dr6, false);
> > >
> > >  out:
> > 
> > Can this be removed or changed to a BUG()?  The warning has been there
> > since 2016 and nobody has apparently complained about it.
> 
> Something like:
> 
> 	/*
> 	 * The kernel doesn't do TF outside of Kprobes, so if we get
> 	 * here, something's fishy.
> 	 */
> 	BUG_ON(dr6 & DR_STEP);
> 
> ?

What about kernel debuggers like kgdb and qemu gdb?

-- 
Josh

