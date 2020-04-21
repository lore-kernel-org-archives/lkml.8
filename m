Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537F9C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0AA206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETzqOnQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgDUJeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgDUJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:34:10 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A17AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:34:10 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m10so520684oie.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4lUem6J31Z1o9v7Dk0MyJIdWtAPPyTWPMlNC8wY8cI=;
        b=ETzqOnQ6ktcw7qLsv0AqL9NW9zS0cjRuCnMWV3XaTeAHF51px8JFDw6Oy0MQZnn77o
         W0HsSEOjnS6G1rgFK5eWWbAtkvq0ngdp4csOjpuwMwsPQXbf7CPqPUbcmvYPSA+vfyIa
         B/ZdeWuDq+s1uEwXoWPv+6rY/Cvru9cEwApvavhjjQqmg8b/wYG8ljZs9sG0VJIxQ0Q+
         Pyv37lMT5KmPFttDfJ5eBdmjPUJ5TOOBzz8PbN+967RSCwj+86hyWEzYEutvmFC2zMxV
         OhptjSXknaRMvFnLnDr+vMODCbmOH6cfFauWRGjmaw5Gzy7c2fx0BLOoER54sWLGvDij
         sIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4lUem6J31Z1o9v7Dk0MyJIdWtAPPyTWPMlNC8wY8cI=;
        b=tXtNB0TSe33UkR/AuT4CRr35Z/OX078IZKJvoP+LfOOUl33wl7b04OYf02UzYsyyHG
         BwlRZRQ7BVCMCh0DigZwkytiao4R5fFEYlrhGbnUCVj5phqAQB20O6R9hEv531tMLpUz
         SEKQdWaxjnTliOCh0a8dirPZlMLvwqok70tkQ1brZ7C8TufyJhBPOm5giZLv4kTj5xCO
         oy3cjioAqhYNKZ/zgXPODDxOcAqJwVTBCL1zoq7otleMkkh7iws2S+MNE2kYqukeGdCj
         cipT6FHSA/iIFqqYhsUKz8bM9BWmdc3T/ymIUQpaIQwI96peQYq3iMcvAUybEL2TGyU8
         6+DA==
X-Gm-Message-State: AGi0Pua2Yhy6i8AyPU8FIzNjQvbu9FMAIRpBV/PF0KBEg5VzttwyYKJ3
        zVTh8+OGdindt02ppT3J5kstwgRmBrcNkk5h3xBC2g==
X-Google-Smtp-Source: APiQypJD0csI6smYkR6G35u9L/1AKGmw6sOUpQA5lng7nTgg6dTRQD7g1O6fQgRa81o+FVGU8OrLg/i3Id29vtHk9Xs=
X-Received: by 2002:aca:c5cf:: with SMTP id v198mr2616654oif.70.1587461649249;
 Tue, 21 Apr 2020 02:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200419094439.GA32841@carbon> <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
 <20200419182957.GA36919@carbon> <8e5a0283ed76465aac19a2b97a27ff15@AcuMS.aculab.com>
 <20200420150545.GB17661@paulmck-ThinkPad-P72> <20200420225715.GA176156@google.com>
 <20200420231244.GK17661@paulmck-ThinkPad-P72>
In-Reply-To: <20200420231244.GK17661@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Apr 2020 11:33:57 +0200
Message-ID: <CANpmjNOfXNE-Zh3MNP=-gmnhvKbsfUfTtWkyg_=VqTxS4nnptQ@mail.gmail.com>
Subject: Re: [RFC] WRITE_ONCE_INC() and friends
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Petko Manolov <petko.manolov@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 at 01:12, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Apr 21, 2020 at 12:57:15AM +0200, Marco Elver wrote:
> > On Mon, 20 Apr 2020, Paul E. McKenney wrote:
> >
> > > On Sun, Apr 19, 2020 at 09:37:10PM +0000, David Laight wrote:
> > > > From: Petko Manolov
> > > > > Sent: 19 April 2020 19:30
> > > > >
> > > > > On 20-04-19 18:02:50, David Laight wrote:
> > > > > > From: Petko Manolov
> > > > > > > Sent: 19 April 2020 10:45
> > > > > > > Recently I started reading up on KCSAN and at some point I ran into stuff like:
> > > > > > >
> > > > > > > WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> > > > > > > WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
> > > > > >
> > > > > > If all the accesses use READ/WRITE_ONCE() why not just mark the structure
> > > > > > field 'volatile'?
> > > > >
> > > > > This is a bit heavy.  I guess you've read this one:
> > > > >
> > > > >         https://lwn.net/Articles/233479/
> > > >
> > > > I remember reading something similar before.
> > > > I also remember a very old gcc (2.95?) that did a readback
> > > > after every volatile write on sparc (to flush the store buffer).
> > > > That broke everything.
> > > >
> > > > I suspect there is a lot more code that is attempting to be lockless
> > > > these days.
> > > > Ring buffers (one writer and one reader) are a typical example where
> > > > you don't need locks but do need to use a consistent value.
> > > >
> > > > Now you may also need ordering between accesses - which I think needs
> > > > more than volatile.
> > >
> > > In Petko's patch, all needed ordering is supplied by the fact that it
> > > is the same variable being read and written.  But yes, in many other
> > > cases, more ordering is required.
> > >
> > > > > And no, i am not sure all accesses are through READ/WRITE_ONCE().  If, for
> > > > > example, all others are from withing spin_lock/unlock pairs then we _may_ not
> > > > > need READ/WRITE_ONCE().
> > > >
> > > > The cost of volatile accesses is probably minimal unless the
> > > > code is written assuming the compiler will only access things once.
> > >
> > > And there are variables marked as volatile, for example, jiffies.
> > >
> > > But one downside of declaring variables volatile is that it can prevent
> > > KCSAN from spotting violations of the concurrency design for those
> > > variables.
> >
> > Note that, KCSAN currently treats volatiles not as special, except a
> > list of some known global volatiles (like jiffies). This means, that
> > KCSAN will tell us about data races involving unmarked volatiles (unless
> > they're in the list).
> >
> > As far as I can tell, this is what we want. At least according to LKMM.
> >
> > If, for whatever reason, volatiles should be treated differently, we'll
> > have to modify the compilers to emit different instrumentation for the
> > kernel.
>
> I stand corrected, then, thank you!
>
> In the current arrangement, declaring a variable volatile will cause
> KCSAN to generate lots of false positives.
>
> I don't currently have a strong feeling on changing the current situation
> with respect to volatile variables.  Is there a strong reason to change?
> The general view of the community, as you say, has been that you don't use
> the volatile keyword outside of exceptions such as jiffies, atomic_read(),
> atomic_set(), READ_ONCE(), WRITE_ONCE() and perhaps a few others.
>
> Thoughts?

I certainly agree, and also want to point out that checkpatch.pl
complains about volatile. We know using volatile has problems. KCSAN
is (along with checkpatch.pl) another tool that can warn us about such
problems (warning in case there is real concurrency). Another thing to
point out is that volatile is not portable, in case
READ_ONCE()/WRITE_ONCE()'s smp_load_barrier_depends() is not a noop.
So from what I see, there are strong reasons against changing the
situation for volatiles and KCSAN.

Thanks,
-- Marco
