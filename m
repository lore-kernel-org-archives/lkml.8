Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55435C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A135420786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4ynlCXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgHFRFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgHFREp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:04:45 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7DAC034620
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 06:26:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so44830096qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2iPfxLBjVspZYrNz+huCOCqkAd+X2FNwnJZLpWw+hM=;
        b=Y4ynlCXKpUtRgCoRk5Ti+JvbQvLBJhoDyUZKoyhtmY7lfFYMIZMnj1VrVkD89tOWzG
         UDwmd8cf+5zAURws27dVU4KtqqcfXWq2iI29b0U13AoTFqvFygDiPCEPAt26EOs5YYQY
         T7Ko8UixmobQX2cH/A28lxdtcJ9tI2gujadmpowppl/KjMwlSEs9iQiPKj6guDuUTMhZ
         ouxhD5ppzi4GvruPpWaS+0szPx57vt36FfI1kwdZqbK6oajfmXvpU9iSM0xsMVWhySYf
         K/84x5aatxjiXyiN5qPY8OGk68e5WA30dNhfKabWHiPhYi3r08k4BwndSGs/0GCOSx9e
         67cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2iPfxLBjVspZYrNz+huCOCqkAd+X2FNwnJZLpWw+hM=;
        b=HMoIoSrEp9ij2cRnJpOi4jpIRI3g4M8frl8eVC9nx5CulRY/hMCri2mhWlL/qawFll
         ne7kmfKVpbZQFe3yMESvWAXGcYGVYItySkaKvJANS7uolW2i7hw2jL7gcwQStbksVo/r
         EXWpgThyRzmz57JEXqbwfVT6SoJqF+/wkkUBormSMTlTq+6TFjfFgfVifCjF/Gg8aUHI
         t1tQfzazfXk7lu6TtuCt9RNN2ytJgZvXpzCd5enkwLdxcJvYbMteuF7J6HndVuSpjGCU
         juS7GuDRePmoi45liJj5Xa3fCeUPPWBVW6rPXV3W4/lf3BAq7/q/uJVZqhu8jAnc0Too
         9DSQ==
X-Gm-Message-State: AOAM530U2stwxUi9OLQ2M036+TWTt90zR1aFfRnUhXWyNlahhtPLn9i3
        hWtK/388KLE5CHRfh05+zhe7Y1DM7HVKMbnBALmCxg==
X-Google-Smtp-Source: ABdhPJxReIfkTG2PFeEofgMQSaJ+TVjIRZizX6Bx1Li3yDeV50HDF/ByHlxxkoxuQ0Awpa3E+ru/ewqtulglRVJQKdA=
X-Received: by 2002:a05:620a:676:: with SMTP id a22mr8706700qkh.8.1596720369262;
 Thu, 06 Aug 2020 06:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200805230852.GA28727@paulmck-ThinkPad-P72> <CANpmjNPxzOFC+VQujipFaPmAV8evU2LnB4X-iXuHah45o-7pfw@mail.gmail.com>
 <CACT4Y+Ye7j-scb-thp2ubORCoEnuJPHL7W6Wh_DLP_4cux-0SQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Ye7j-scb-thp2ubORCoEnuJPHL7W6Wh_DLP_4cux-0SQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Aug 2020 15:25:57 +0200
Message-ID: <CACT4Y+aF=Y-b7Lm7+UAD7Zb1kS1uWF+G_3yBbXsY6YO3k2dBuw@mail.gmail.com>
Subject: Re: Finally starting on short RCU grace periods, but...
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "'Dmitry Vyukov' via syzkaller-upstream-moderation" 
        <syzkaller-upstream-moderation@googlegroups.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 3:22 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Aug 6, 2020 at 12:31 PM Marco Elver <elver@google.com> wrote:
> >
> > +Cc kasan-dev
> >
> > On Thu, 6 Aug 2020 at 01:08, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Hello!
> > >
> > > If I remember correctly, one of you asked for a way to shorten RCU
> > > grace periods so that KASAN would have a better chance of detecting bugs
> > > such as pointers being leaked out of RCU read-side critical sections.
> > > I am finally starting entering and testing code for this, but realized
> > > that I had forgotten a couple of things:
> > >
> > > 1.      I don't remember exactly who asked, but I suspect that it was
> > >         Kostya.  I am using his Reported-by as a placeholder for the
> > >         moment, but please let me know if this should be adjusted.
> >
> > It certainly was not me.
> >
> > > 2.      Although this work is necessary to detect situtions where
> > >         call_rcu() is used to initiate a grace period, there already
> > >         exists a way to make short grace periods that are initiated by
> > >         synchronize_rcu(), namely, the rcupdate.rcu_expedited kernel
> > >         boot parameter.  This will cause all calls to synchronize_rcu()
> > >         to act like synchronize_rcu_expedited(), resulting in about 2-3
> > >         orders of magnitude reduction in grace-period latency on small
> > >         systems (say 16 CPUs).
> > >
> > > In addition, I plan to make a few other adjustments that will
> > > increase the probability of KASAN spotting a pointer leak even in the
> > > rcupdate.rcu_expedited case.
> >
> > Thank you, that'll be useful I think.
> >
> > > But if you would like to start this sort of testing on current mainline,
> > > rcupdate.rcu_expedited is your friend!
>
> Hi Paul,
>
> This is great!
>
> I understand it's not a sufficiently challenging way of tracking
> things, but it's simply here ;)
> https://bugzilla.kernel.org/show_bug.cgi?id=208299
> (now we also know who asked for this, +Jann)
>
> I've tested on the latest mainline and with rcupdate.rcu_expedited=1
> it boots to ssh successfully and I see:
> [    0.369258][    T0] All grace periods are expedited (rcu_expedited).
>
> I have created https://github.com/google/syzkaller/pull/2021 to enable
> it on syzbot.
> On syzbot we generally use only 2-4 CPUs per VM, so it should be even better.
>
> > Do any of you remember some bugs we missed due to this? Can we find
> > them if we add this option?
>
> The problem is that it's hard to remember bugs that were not caught :)
> Here is an approximation of UAFs with free in rcu callback:
> https://groups.google.com/forum/#!searchin/syzkaller-bugs/KASAN$20use-after-free$20rcu_do_batch%7Csort:date
> The ones with low hit count are the ones that we almost did not catch.
> That's the best estimation I can think of. Also potentially we can get
> reproducers for such bugs without reproducers.
> Maybe we will be able to correlate some bugs/reproducers that appear
> soon with this change.

Wait, it was added in 2012?
https://github.com/torvalds/linux/commit/3705b88db0d7cc4
