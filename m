Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9456C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9743220709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ulzf4J2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgGTIIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:08:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85136C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:08:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so1895330wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1yXIPlBUH+EmDdZmp8j+ju0kw8iWENSTR87nU7J3gic=;
        b=Ulzf4J2vqLs8NwLETT7bcd+u4HAAwBmYUgFdDA6OzvG7chP9Dc2iYoP4a8g0hXIW4j
         uSSxTog/gDT29zrDukJMfV+m6rPQiFTeOmhUFeIPbqB8Cuo8d2kRH+nCv+Ce3TgIQ13s
         rW0RNcsEE6bjYWi3sW2IPbXdNppOguJKq5J4UWv1LMYrAWJBNfpCF8J/f0CJlvBeAwVY
         hONG9p634fn5Bgtts2YlmScANiWJ3Qllujg13dBWuHVyZHhKM9aVRAqdoUQVyPCeqehR
         9NsRXV+LWdRhodtQySz6C4jgES2XKiZ+l0/mbutdRvezINxHHFxPwlJ7d/DD9rmZ4lU+
         Js2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1yXIPlBUH+EmDdZmp8j+ju0kw8iWENSTR87nU7J3gic=;
        b=ha0sdumhw5mq+oNSN2HMITo2sOw9nB/OUWwn51VybeYW4o0hNLkUk2azScaC6UxNGb
         Blemf80dlX5ZqRatCjX2wVLGqs0Qi4rsHKqUBXsrvgm9t3YF8XTv30UMbEZgwY0ER8rS
         Sy1lJdhTWx7WxJZZcMZKWteoVRVOOUEPep87p48HE1B3av+jTzRvXxdbGdeHNiUMr6lI
         V57L/mqNNIPPshbeCqJg8cwN1fwW2a5CP6sZpIVWxs/3mhmQ27XdXca9qx1W9h/yd5GO
         x7TmsHBQpvR92DD02hbySFD9PHt2KOBlaoO7MJvhsyg0oilBY6kwIVBsecKJkAPG51ol
         Y8og==
X-Gm-Message-State: AOAM531wGx3DjRqpPwq1QbWEzFa4gwCRry3UxIfh+y86HOYrpI7w/x2P
        xr3SKfKXs2MKRRWefLNHHc49SA==
X-Google-Smtp-Source: ABdhPJz7eMPdqXW2QxkgN3v4OfLKvoMLVgo05mEGxQDWE0w9I97CQ/L+CeevJ5aEqAiM+mZL+O5AGg==
X-Received: by 2002:adf:f54b:: with SMTP id j11mr21195819wrp.206.1595232484043;
        Mon, 20 Jul 2020 01:08:04 -0700 (PDT)
Received: from holly.lan (82-132-214-103.dab.02.net. [82.132.214.103])
        by smtp.gmail.com with ESMTPSA id s19sm8354717wrb.54.2020.07.20.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:08:03 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:07:59 +0100
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
Message-ID: <20200720080759.tyq4rq4qxmkwdk2g@holly.lan>
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
 <20200716151943.2167652-3-daniel.thompson@linaro.org>
 <CAD=FV=UDVjwy5=OiDCrMbn8o9N5GGMiG8JnL0j+9fy3m5Vf4Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UDVjwy5=OiDCrMbn8o9N5GGMiG8JnL0j+9fy3m5Vf4Eg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 03:39:51PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 16, 2020 at 8:20 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > If we are running in a part of the kernel that dislikes breakpoint
> > debugging then it is very unlikely to be safe to single step. Add
> > some safety rails to prevent stepping through anything on the kprobe
> > blocklist.
> >
> > As part of this kdb_ss() will no longer set the DOING_SS flags when it
> > requests a step. This is safe because this flag is already redundant,
> > returning KDB_CMD_SS is all that is needed to request a step (and this
> > saves us from having to unset the flag if the safety check fails).
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  include/linux/kgdb.h        |  1 +
> >  kernel/debug/debug_core.c   | 13 +++++++++++++
> >  kernel/debug/gdbstub.c      | 10 +++++++++-
> >  kernel/debug/kdb/kdb_bp.c   |  8 ++------
> >  kernel/debug/kdb/kdb_main.c | 10 ++++++++--
> >  5 files changed, 33 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 7caba4604edc..aefe823998cb 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -214,6 +214,7 @@ extern void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc);
> >
> >  /* Optional functions. */
> >  extern int kgdb_validate_break_address(unsigned long addr);
> > +extern int kgdb_validate_single_step_address(unsigned long addr);
> >  extern int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt);
> >  extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
> >
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 133a361578dc..4b59bcc90c5d 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -208,6 +208,19 @@ int __weak kgdb_validate_break_address(unsigned long addr)
> >         return err;
> >  }
> >
> > +int __weak kgdb_validate_single_step_address(unsigned long addr)
> > +{
> > +       /*
> > +        * Disallow stepping when we are executing code that is marked
> > +        * as unsuitable for breakpointing... stepping won't be safe
> > +        * either!
> > +        */
> > +       if (kgdb_within_blocklist(addr))
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> >  unsigned long __weak kgdb_arch_pc(int exception, struct pt_regs *regs)
> >  {
> >         return instruction_pointer(regs);
> > diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> > index 61774aec46b4..f1c88007cc2b 100644
> > --- a/kernel/debug/gdbstub.c
> > +++ b/kernel/debug/gdbstub.c
> > @@ -1041,8 +1041,16 @@ int gdb_serial_stub(struct kgdb_state *ks)
> >                         if (tmp == 0)
> >                                 break;
> >                         /* Fall through - on tmp < 0 */
> > -               case 'c': /* Continue packet */
> >                 case 's': /* Single step packet */
> > +                       error = kgdb_validate_single_step_address(
> > +                                       kgdb_arch_pc(ks->ex_vector,
> > +                                                    ks->linux_regs));
> 
> I'm a little confused.  Isn't this like saying "if
> (i_am_standing_in_acid) dont_step_into_acid"?

I describe it more as:

    if (we_know_there_is_acid_nearby)
        dont_step_forward

It is possible we are currently stepping in acid but it is also possible
(and reasonably likely) that we haven't stepped in it yet but will do so
soon.


> Specifically you're checking the _current_ PC to see if it's in the
> blocklist, right?  ...but you've already (effectively) dropped into
> the debugger at that location, so if it really was a problem wouldn't
> we already be in trouble?

The basic use case is where someone is stepping and we reach a PC that
would be blocked for a breakpoint. This will typically be due (although
I think it does generalize) to a function call and the safety rail will
be reached after we have jumped to the blocked function but before we
actually execute any instructions within it.

Or putting it another way, there is no reason to worry if we start
somewhere "safe" and start stepping towards something on the blocklist.
We won't melt our shoes!

There are more complex cases when we drop into the debugger in the
middle of blocked code with a not-breakpoint-or-step trap. You're right
that we'd been in touble and the debugger it probably a bit fragile.
However that certainly doesn't mean blocking stepping at this point
is a bad thing!


> What you really want (I think?) is to know if the instruction that
> you're stepping into is in the blocklist, right?  ...but you can't
> know that because it requires a full instruction emulator (that's why
> CPUs have "single step mode").

As above, I don't think this is needed but if there was an architecture
that did then it can override the default implementation if it wanted
to.

 
> I guess you get a marginal benefit if someone manually set their
> instruction pointer to be an address in the middle of a blocklisted
> function and then trying to step, but I'm not sure that's really
> something we need to add code for?

Perhaps off-topic given this isn't why we add the satefy rails but...

I think people who directly set PC should be regarded as very
sophisticated users (and therefore do not need safety rails) so I have
little interest in honouring the blocklist for direct writes to the
PC. More generally sophisticated users should be able to find
KGDB_HONOUR_BLOCKLIST pretty quickly if they need to!


> It feels like the right solution is that the architecture-specific
> single-step code should simply consider a single-step through a
> blocklisted area to be a step through one giant instruction.

For kgdb this feature is already implemented (next or finish).


> > +                       if (error != 0) {
> > +                               error_packet(remcom_out_buffer, error);
> > +                               break;
> > +                       }
> > +                       fallthrough;
> > +               case 'c': /* Continue packet */
> >                         if (kgdb_contthread && kgdb_contthread != current) {
> >                                 /* Can't switch threads in kgdb */
> >                                 error_packet(remcom_out_buffer, -EINVAL);
> > diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
> > index ec4940146612..4853c413f579 100644
> > --- a/kernel/debug/kdb/kdb_bp.c
> > +++ b/kernel/debug/kdb/kdb_bp.c
> > @@ -507,18 +507,14 @@ static int kdb_bc(int argc, const char **argv)
> >   *     None.
> >   * Remarks:
> >   *
> > - *     Set the arch specific option to trigger a debug trap after the next
> > - *     instruction.
> > + *     KDB_CMD_SS is a command that our caller acts on to effect the step.
> >   */
> >
> >  static int kdb_ss(int argc, const char **argv)
> >  {
> >         if (argc != 0)
> >                 return KDB_ARGCOUNT;
> > -       /*
> > -        * Set trace flag and go.
> > -        */
> > -       KDB_STATE_SET(DOING_SS);
> > +
> >         return KDB_CMD_SS;
> >  }
> >
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 5c7949061671..cd40bf780b93 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -1189,7 +1189,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
> >                      kdb_dbtrap_t db_result)
> >  {
> >         char *cmdbuf;
> > -       int diag;
> > +       int diag, res;
> >         struct task_struct *kdb_current =
> >                 kdb_curr_task(raw_smp_processor_id());
> >
> > @@ -1346,10 +1346,16 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
> >                 }
> >                 if (diag == KDB_CMD_GO
> >                  || diag == KDB_CMD_CPU
> > -                || diag == KDB_CMD_SS
> >                  || diag == KDB_CMD_KGDB)
> >                         break;
> >
> > +               if (diag == KDB_CMD_SS) {
> > +                       res = kgdb_validate_single_step_address(instruction_pointer(regs));
> 
> Is it legit to use instruction_pointer() directly?  Should you be
> calling kgdb_arch_pc()  ...or does that just account for having just
> hit a breakpoint?

I decided between kgdb_arch_pc() and instruction_pointer() based on the
usage of regs in the rest of this file (which is exclusively
instruction_pointer() ). I didn't want the lookup to mismatch what the
user has been told in the console.

On the other hand, I did cross my mind that every PC lookup could be
broken and I made a note for the future...


Daniel.
