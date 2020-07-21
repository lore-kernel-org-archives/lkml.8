Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9C8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122832068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2NWfIyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgGUVFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgGUVFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:05:00 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B512C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:05:00 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b77so5063vsd.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJhbzVDa9nePxgAcv9hRGTSaFk2PPisZtuGmQbqXq4M=;
        b=G2NWfIyUsyvk7iqL8Y7G25VX3J5N1E5bZULjMHl9k6T+YkX8MSsjLfVSTNpw2Sl+Uo
         pMFA/3oH9PDppJbYTdVpPInv0V/MNW9w2iTGnWfnlyxIoH6x4b5KjFdpFDWwXK6TC0h/
         4qpnv+b2YuXE1frsbcWunmMf/5SVUx1/zTeTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJhbzVDa9nePxgAcv9hRGTSaFk2PPisZtuGmQbqXq4M=;
        b=NeYDqahrdEwODSDYvgYxW4ClBp4xxFc3sBHuLNLshzGb9qbW60lwRX4RBDimZra9y+
         XbbdwdcT3a7Ih7c8P48zRtoh/fQpSvXOuYMu/NjTHRr1U2NS9PV10TltX/shdbmown3Z
         jNr1n9R+X6Kr5aFAS/e8XCJVmsF7bwI69TrOxveG1VL2ZSEAfewqzF9o5FraU/MQtpzh
         DKCgfDkg0tNywwP8WLN1QJRaF/B0GxxXfcugJkt+FI0n5k+bL7PQnrCiPOlpg67T0cpu
         6Ay4NmLLV1IK6oSNS/TwZ70nj45EajWiF4UIo0a9cetXfrYOCfd9dlKrL6iU/XmwCNP9
         r+xw==
X-Gm-Message-State: AOAM533Swa3ZaJJ5NXIo11AEaw4Mjk0agtk9sx30x9CE1HQx0BqrgTs5
        BULRdGnIE5GMTaqXGC2ns9Y7LmSsV+g=
X-Google-Smtp-Source: ABdhPJw7icDnh2L9/OzczH0Did+8umEMSKvMskM4IpdDeMiaL5hwNdvKN5+3R3UDjy9HEzvNXex+2w==
X-Received: by 2002:a67:6c84:: with SMTP id h126mr20530999vsc.181.1595365498824;
        Tue, 21 Jul 2020 14:04:58 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id d3sm3534814vko.51.2020.07.21.14.04.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 14:04:57 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id m21so74541vkp.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:04:57 -0700 (PDT)
X-Received: by 2002:a1f:4e81:: with SMTP id c123mr12718651vkb.100.1595365497257;
 Tue, 21 Jul 2020 14:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
 <20200716151943.2167652-3-daniel.thompson@linaro.org> <CAD=FV=UDVjwy5=OiDCrMbn8o9N5GGMiG8JnL0j+9fy3m5Vf4Eg@mail.gmail.com>
 <20200720080759.tyq4rq4qxmkwdk2g@holly.lan>
In-Reply-To: <20200720080759.tyq4rq4qxmkwdk2g@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Jul 2020 14:04:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WotJFiMe+tXtov2bEy2avH+=u5mi=gYM4U3_2DUGvO6g@mail.gmail.com>
Message-ID: <CAD=FV=WotJFiMe+tXtov2bEy2avH+=u5mi=gYM4U3_2DUGvO6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kgdb: Use the kprobe blocklist to limit single stepping
To:     Daniel Thompson <daniel.thompson@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 20, 2020 at 1:08 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jul 17, 2020 at 03:39:51PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jul 16, 2020 at 8:20 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > If we are running in a part of the kernel that dislikes breakpoint
> > > debugging then it is very unlikely to be safe to single step. Add
> > > some safety rails to prevent stepping through anything on the kprobe
> > > blocklist.
> > >
> > > As part of this kdb_ss() will no longer set the DOING_SS flags when it
> > > requests a step. This is safe because this flag is already redundant,
> > > returning KDB_CMD_SS is all that is needed to request a step (and this
> > > saves us from having to unset the flag if the safety check fails).
> > >
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > ---
> > >  include/linux/kgdb.h        |  1 +
> > >  kernel/debug/debug_core.c   | 13 +++++++++++++
> > >  kernel/debug/gdbstub.c      | 10 +++++++++-
> > >  kernel/debug/kdb/kdb_bp.c   |  8 ++------
> > >  kernel/debug/kdb/kdb_main.c | 10 ++++++++--
> > >  5 files changed, 33 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > > index 7caba4604edc..aefe823998cb 100644
> > > --- a/include/linux/kgdb.h
> > > +++ b/include/linux/kgdb.h
> > > @@ -214,6 +214,7 @@ extern void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc);
> > >
> > >  /* Optional functions. */
> > >  extern int kgdb_validate_break_address(unsigned long addr);
> > > +extern int kgdb_validate_single_step_address(unsigned long addr);
> > >  extern int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt);
> > >  extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
> > >
> > > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > > index 133a361578dc..4b59bcc90c5d 100644
> > > --- a/kernel/debug/debug_core.c
> > > +++ b/kernel/debug/debug_core.c
> > > @@ -208,6 +208,19 @@ int __weak kgdb_validate_break_address(unsigned long addr)
> > >         return err;
> > >  }
> > >
> > > +int __weak kgdb_validate_single_step_address(unsigned long addr)
> > > +{
> > > +       /*
> > > +        * Disallow stepping when we are executing code that is marked
> > > +        * as unsuitable for breakpointing... stepping won't be safe
> > > +        * either!
> > > +        */
> > > +       if (kgdb_within_blocklist(addr))
> > > +               return -EINVAL;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  unsigned long __weak kgdb_arch_pc(int exception, struct pt_regs *regs)
> > >  {
> > >         return instruction_pointer(regs);
> > > diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> > > index 61774aec46b4..f1c88007cc2b 100644
> > > --- a/kernel/debug/gdbstub.c
> > > +++ b/kernel/debug/gdbstub.c
> > > @@ -1041,8 +1041,16 @@ int gdb_serial_stub(struct kgdb_state *ks)
> > >                         if (tmp == 0)
> > >                                 break;
> > >                         /* Fall through - on tmp < 0 */
> > > -               case 'c': /* Continue packet */
> > >                 case 's': /* Single step packet */
> > > +                       error = kgdb_validate_single_step_address(
> > > +                                       kgdb_arch_pc(ks->ex_vector,
> > > +                                                    ks->linux_regs));
> >
> > I'm a little confused.  Isn't this like saying "if
> > (i_am_standing_in_acid) dont_step_into_acid"?
>
> I describe it more as:
>
>     if (we_know_there_is_acid_nearby)
>         dont_step_forward
>
> It is possible we are currently stepping in acid but it is also possible
> (and reasonably likely) that we haven't stepped in it yet but will do so
> soon.
>
>
> > Specifically you're checking the _current_ PC to see if it's in the
> > blocklist, right?  ...but you've already (effectively) dropped into
> > the debugger at that location, so if it really was a problem wouldn't
> > we already be in trouble?
>
> The basic use case is where someone is stepping and we reach a PC that
> would be blocked for a breakpoint. This will typically be due (although
> I think it does generalize) to a function call and the safety rail will
> be reached after we have jumped to the blocked function but before we
> actually execute any instructions within it.
>
> Or putting it another way, there is no reason to worry if we start
> somewhere "safe" and start stepping towards something on the blocklist.
> We won't melt our shoes!

I guess I still don't totally get it.  So let's say we have:

void dont_trace_this(...)
{
  thing_not_to_trace_1();
  thing_not_to_trace_2();
  don_t_trace = this;
}
NOKPROBE_SYMBOL(dont_trace_this);

void trace_me()
{
  sing();
  dance();
  dont_trace_this();
  party();
}

So presumably the dont_trace_this() function is marked as
NOKPROBE_SYMBOL because it's called by the kprobe handling code or by
kgdb, right?  So if we had a breakpoint there then we'd just have
infinite recursion.  Thus we want to prevent putting breakpoints
anywhere in this function.  Even though dont_trace_this() is also
called from the trace_me() function it doesn't matter--we still can't
put breakpoints in it because it would cause problems with the
debugger.

Now, I guess the question is: why exactly do we need to prevent single
stepping in dont_trace_this().  In the case above where
dont_trace_this() is called from trace_me() it would actually be OK to
single step it, right?  ...unless this is on a CPU that doesn't have a
"single step mode" and has to implement stepping by breakpoints, of
course.

...but maybe I'm confused and there is a reason that we shouldn't
allow single stepping into dont_trace_this() when called from
trace_me().  If that is the case, I'm wondering why it's OK to step
and stop on the first instruction of the function but it's not OK to
step and stop through the other instructions in the function.

-Doug
