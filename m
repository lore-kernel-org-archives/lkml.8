Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C539C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F362F2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtTzrSGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgIDPWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgIDPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:22:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7EC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:22:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e11so7746520wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40Yi2am2UF1XR3ddwRvsmk6pyvurnS7zfPar1nGce0Q=;
        b=mtTzrSGudLPdDeD+AyiKELNqfeCUK3tiBpx1OftYgwUdKVHvS7d8bWMNEUHKmvidxO
         By3ZuJM3pdq9OfnwAus162oZNnv5I6s9p9KIPVC/KlaYe6IvgYBnqYt7u/6qLdtrX5Ai
         fx0v2VYegGtm5yLFXg3+2EfPorlYJl7UUGLx6kWba6jyEhQ0notQQJwMtME6OeJUWNAE
         wT5RAt3net0eDxTOYVaYq2ps3mgCBH7Cs7+EwS7FkB1sl6404szuLjmuSDjIro+z9jeG
         GNPBBXBdPMYjJJy7QcYTExM3NlBfp53jjez3Zmof2CAz+qsarPSImHFNPVZiO1lbRQh4
         c6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40Yi2am2UF1XR3ddwRvsmk6pyvurnS7zfPar1nGce0Q=;
        b=pF3Izrpha6NNvx+cq3vYF8NGigNdt3kNvuN0Ijs0gmk2gUisfPMBApLcHTifz02bdj
         JDgvj06uu5XMIkKpvKQOFwLReAPpyQ7/BR9W/hsdOrml94Qr06IjqcSS1YVbAPb18KmG
         GTY13NApfJUDzxi4/BmpD9JNj9BxXzYlnc4xi4O7la6IJ7upCnbfohJMTwJtKPJw1XiS
         rYX5L9Snb4JlP+qDoROZhqjfH1LZAlmfMocYSpwsszTckWjo3HntHrq4hE5qdGNmpb+U
         +36Ej4kdZlD4DN2ND/TYhK87dSmDl01v3GmPTRQCgtDqErunElxTmg43C+zUf7b7LNY+
         fZBg==
X-Gm-Message-State: AOAM532i3mLdhOL45HGsHlL8290cNUhbSw59tbsROWdbBJFhFwBxLwCQ
        OXTr8W4nF7yNNqJ/el0KUn88fg==
X-Google-Smtp-Source: ABdhPJwTNRy+ojk+wfG94L20EVKT+RoYhEsbmV9UJAMOrGbwImqMEcZIPqSiwuUbTEVhtir9QPLWeA==
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr8151372wmo.186.1599232965701;
        Fri, 04 Sep 2020 08:22:45 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v2sm13072702wrn.44.2020.09.04.08.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:22:44 -0700 (PDT)
Date:   Fri, 4 Sep 2020 16:22:42 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH v2 2/3] kgdb: Use the kprobe blocklist to limit single
 stepping
Message-ID: <20200904152242.ehzs3yowx7mvvasv@holly.lan>
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
 <20200716151943.2167652-3-daniel.thompson@linaro.org>
 <CAD=FV=UDVjwy5=OiDCrMbn8o9N5GGMiG8JnL0j+9fy3m5Vf4Eg@mail.gmail.com>
 <20200720080759.tyq4rq4qxmkwdk2g@holly.lan>
 <CAD=FV=WotJFiMe+tXtov2bEy2avH+=u5mi=gYM4U3_2DUGvO6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WotJFiMe+tXtov2bEy2avH+=u5mi=gYM4U3_2DUGvO6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 02:04:45PM -0700, Doug Anderson wrote:
> On Mon, Jul 20, 2020 at 1:08 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Fri, Jul 17, 2020 at 03:39:51PM -0700, Doug Anderson wrote:
> > > On Thu, Jul 16, 2020 at 8:20 AM Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > >
> > > > If we are running in a part of the kernel that dislikes breakpoint
> > > > debugging then it is very unlikely to be safe to single step. Add
> > > > some safety rails to prevent stepping through anything on the kprobe
> > > > blocklist.
> > > >
> > > > As part of this kdb_ss() will no longer set the DOING_SS flags when it
> > > > requests a step. This is safe because this flag is already redundant,
> > > > returning KDB_CMD_SS is all that is needed to request a step (and this
> > > > saves us from having to unset the flag if the safety check fails).
> > > >
> > > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > > ---
> > > >  include/linux/kgdb.h        |  1 +
> > > >  kernel/debug/debug_core.c   | 13 +++++++++++++
> > > >  kernel/debug/gdbstub.c      | 10 +++++++++-
> > > >  kernel/debug/kdb/kdb_bp.c   |  8 ++------
> > > >  kernel/debug/kdb/kdb_main.c | 10 ++++++++--
> > > >  5 files changed, 33 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > > > index 7caba4604edc..aefe823998cb 100644
> > > > --- a/include/linux/kgdb.h
> > > > +++ b/include/linux/kgdb.h
> > > > @@ -214,6 +214,7 @@ extern void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc);
> > > >
> > > >  /* Optional functions. */
> > > >  extern int kgdb_validate_break_address(unsigned long addr);
> > > > +extern int kgdb_validate_single_step_address(unsigned long addr);
> > > >  extern int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt);
> > > >  extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
> > > >
> > > > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > > > index 133a361578dc..4b59bcc90c5d 100644
> > > > --- a/kernel/debug/debug_core.c
> > > > +++ b/kernel/debug/debug_core.c
> > > > @@ -208,6 +208,19 @@ int __weak kgdb_validate_break_address(unsigned long addr)
> > > >         return err;
> > > >  }
> > > >
> > > > +int __weak kgdb_validate_single_step_address(unsigned long addr)
> > > > +{
> > > > +       /*
> > > > +        * Disallow stepping when we are executing code that is marked
> > > > +        * as unsuitable for breakpointing... stepping won't be safe
> > > > +        * either!
> > > > +        */
> > > > +       if (kgdb_within_blocklist(addr))
> > > > +               return -EINVAL;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  unsigned long __weak kgdb_arch_pc(int exception, struct pt_regs *regs)
> > > >  {
> > > >         return instruction_pointer(regs);
> > > > diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> > > > index 61774aec46b4..f1c88007cc2b 100644
> > > > --- a/kernel/debug/gdbstub.c
> > > > +++ b/kernel/debug/gdbstub.c
> > > > @@ -1041,8 +1041,16 @@ int gdb_serial_stub(struct kgdb_state *ks)
> > > >                         if (tmp == 0)
> > > >                                 break;
> > > >                         /* Fall through - on tmp < 0 */
> > > > -               case 'c': /* Continue packet */
> > > >                 case 's': /* Single step packet */
> > > > +                       error = kgdb_validate_single_step_address(
> > > > +                                       kgdb_arch_pc(ks->ex_vector,
> > > > +                                                    ks->linux_regs));
> > >
> > > I'm a little confused.  Isn't this like saying "if
> > > (i_am_standing_in_acid) dont_step_into_acid"?
> >
> > I describe it more as:
> >
> >     if (we_know_there_is_acid_nearby)
> >         dont_step_forward
> >
> > It is possible we are currently stepping in acid but it is also possible
> > (and reasonably likely) that we haven't stepped in it yet but will do so
> > soon.
> >
> >
> > > Specifically you're checking the _current_ PC to see if it's in the
> > > blocklist, right?  ...but you've already (effectively) dropped into
> > > the debugger at that location, so if it really was a problem wouldn't
> > > we already be in trouble?
> >
> > The basic use case is where someone is stepping and we reach a PC that
> > would be blocked for a breakpoint. This will typically be due (although
> > I think it does generalize) to a function call and the safety rail will
> > be reached after we have jumped to the blocked function but before we
> > actually execute any instructions within it.
> >
> > Or putting it another way, there is no reason to worry if we start
> > somewhere "safe" and start stepping towards something on the blocklist.
> > We won't melt our shoes!
> 
> I guess I still don't totally get it.  So let's say we have:
> 
> void dont_trace_this(...)
> {
>   thing_not_to_trace_1();
>   thing_not_to_trace_2();
>   don_t_trace = this;
> }
> NOKPROBE_SYMBOL(dont_trace_this);
> 
> void trace_me()
> {
>   sing();
>   dance();
>   dont_trace_this();
>   party();
> }
> 
> So presumably the dont_trace_this() function is marked as
> NOKPROBE_SYMBOL because it's called by the kprobe handling code or by
> kgdb, right?  So if we had a breakpoint there then we'd just have
> infinite recursion.  Thus we want to prevent putting breakpoints
> anywhere in this function.  Even though dont_trace_this() is also
> called from the trace_me() function it doesn't matter--we still can't
> put breakpoints in it because it would cause problems with the
> debugger.
> 
> Now, I guess the question is: why exactly do we need to prevent single
> stepping in dont_trace_this().  In the case above where
> dont_trace_this() is called from trace_me() it would actually be OK to
> single step it, right?  ...unless this is on a CPU that doesn't have a
> "single step mode" and has to implement stepping by breakpoints, of
> course.

I think you are persuading me.

Although I can think of plenty of places where it isn't safe to step I'm
struggling to think of any way for us to end up stopped in the debugger
in those places and certainly now without setting the catastrophic
(which is the only safety rail currently extant).

That means I don't think I can put up a strong enough case that this
patch is better than doing nothing!

I'll drop it for now.

> ...but maybe I'm confused

I think on the whole you've expressed things more lucidly than I have!
Nevertheless...

> and there is a reason that we shouldn't
> allow single stepping into dont_trace_this() when called from
> trace_me().  If that is the case, I'm wondering why it's OK to step
> and stop on the first instruction of the function but it's not OK to
> step and stop through the other instructions in the function.

... when we stop on the first instruction of a function then we have not
actually executed any part of it. In other words we haven't executed
anything on the blocklist.

Of course the whole issue is moot for now.


Daniel.
