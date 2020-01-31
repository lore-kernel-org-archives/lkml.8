Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F39C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8493F20663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uj6Lx/y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgAaReI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:34:08 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:33581 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgAaReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:34:08 -0500
Received: by mail-yw1-f48.google.com with SMTP id 192so5502994ywy.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWX5M+r9Vqe5q2CDK415PvCV4oP536RO8m5MiSJM4+Y=;
        b=uj6Lx/y4u/ldyuEjoY26heXH3fMxOt5GnIbtzH07r+7QXFp4YsgHI8lIKFv4PwAtLs
         0M2mh8nP/ST7Q8/zP4V3LoYr1I63PLWx54nqprkXfyo9OX29sXsYyXl3mK/C+woDD7++
         TWObORg0/aYsFC8EEsVcx6fcglEHbc4ROn1E1qbo5tR4uQotJiborvQWAQD2cXKstoNb
         oSL+9J57Lm5jsSE1lKOYlr4YF431XHqslTfwt9BghKU1u063PVgAwMQIjr/Pm0kyWmrU
         5OzAu302I8ZYJT9V3Q42D6fXyFtA0BddDxkew3GUEeXbRiNCS+2gnt7zdhyBc94r62bU
         kATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWX5M+r9Vqe5q2CDK415PvCV4oP536RO8m5MiSJM4+Y=;
        b=CcENQx1pvadaXR05qxv97xRL4wzFyozqTtNTSxZHK3PcpeLT1/pJUhb2weE3nLANcI
         EfHgxjTefoP4JY7XfvRe3rQW4cynjZatJMHmNqmX0ga0/LsC6fOSwXCGy4udNnARtUNq
         fgRQPpuSbt0kdw3KHIj7Y1wK+AoWCmdYdErbswtJFy38Wt4WJLq5ciw5e6LMiy7j5i6x
         2al/rCkoizgerQ1U4dwrCOBFEfyckC0u3b8oMGvFRPt/+CcQTXbpfpuwBn3cYwheeidW
         7Bx7lnsZdR6flXvjUX7loB1qp0TUZRQgVcgC3j0nxFVu1x2xTMAYqQcbJlMryF5LiXjH
         FpGQ==
X-Gm-Message-State: APjAAAUuDBwcPDkpZEYCO9hQ0tWPAwuO1pb0hTz21LYf5KvfyHy4O4zJ
        MPqzSnWefAlw5ssKk8v6DP4Nd+bQbjSqSM+fxeKBGQ==
X-Google-Smtp-Source: APXvYqz5RF9k94V/UP1uOazl013fhFiIEHJcmaFrXb1VDh+Bsv4cZtI9pfEwTTPJHymYnPaBOR4HXss/2UV7cKY8PiY=
X-Received: by 2002:a0d:c701:: with SMTP id j1mr1730946ywd.52.1580492046879;
 Fri, 31 Jan 2020 09:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20200131164308.GA5175@willie-the-truck> <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131165718.GA5517@willie-the-truck> <CANn89iKmSBPKJGw--WaJJhCdu2wz2aq-ve+E8z=gfsYj6Zom_A@mail.gmail.com>
 <20200131172058.GB5517@willie-the-truck>
In-Reply-To: <20200131172058.GB5517@willie-the-truck>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 09:33:55 -0800
Message-ID: <CANn89iJNgPOzCdc-7QoC+dawJVn7tLQxmrx58GL8PT9rDVT2hA@mail.gmail.com>
Subject: Re: Confused about hlist_unhashed_lockless()
To:     Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 9:21 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jan 31, 2020 at 09:06:27AM -0800, Eric Dumazet wrote:
> > On Fri, Jan 31, 2020 at 8:57 AM Will Deacon <will@kernel.org> wrote:
> > > On Fri, Jan 31, 2020 at 08:48:05AM -0800, Eric Dumazet wrote:
> > > > On Fri, Jan 31, 2020 at 8:43 AM Will Deacon <will@kernel.org> wrote:
> > > > > Then running these two concurrently on the same node means that
> > > > > hlist_unhashed_lockless() doesn't really tell you anything about whether
> > > > > or not the node is reachable in the list (i.e. there is another node
> > > > > with a next pointer pointing to it). In other words, I think all of
> > > > > these outcomes are permitted:
> > > > >
> > > > >         hlist_unhashed_lockless(n)      n reachable in list
> > > > >         0                               0 (No reordering)
> > > > >         0                               1 (No reordering)
> > > > >         1                               0 (No reordering)
> > > > >         1                               1 (Reorder first and last WRITE_ONCEs)
> > > > >
> > > > > So I must be missing some details about the use-case here. Please could
> > > > > you enlighten me? The RCU implementation permits only the first three
> > > > > outcomes afaict, why not use that and leave non-RCU hlist as it was?
> > > > >
> > > >
> > > > I guess the following has been lost :
> > >
> > > Thanks, although...
> > >
> > > > Author: Eric Dumazet <edumazet@google.com>
> > > > Date:   Thu Nov 7 11:23:14 2019 -0800
> > > >
> > > >     timer: use hlist_unhashed_lockless() in timer_pending()
> > > >
> > > >     timer_pending() is mostly used in lockless contexts.
> > >
> > > ... my point above still stands: the value returned by
> > > hlist_unhashed_lockless() doesn't tell you anything about whether or
> > > not the timer is reachable in the hlist or not. The comment above
> > > timer_pending() also states that:
> > >
> > >   | Callers must ensure serialization wrt. other operations done to
> > >   | this timer, e.g. interrupt contexts, or other CPUs on SMP.
> > >
> > > If that is intended to preclude list operations, shouldn't we use an
> > > RCU hlist instead of throwing {READ,WRITE}_ONCE() at the problem to
> > > shut the sanitiser up without actually fixing anything? :(
> >
> >
> > Sorry, but timer_pending() requires no serialization.
>
> Then we should update the comment!

Which one ?

It seems KCSAN does not read the comments :)

>
> Without serialisation, timer_pending() as currently implemented does
> not reliably tell you whether the timer is in the hlist. Is that not a
> problem?

No it is not a problem.

However some callers might have incorrect assumptions, I have not
audited all the code.

 Using an RCU hlist does not introduce serialisation, but does
> at least rule out the case where timer_pending() returns false for a
> timer that /is/ reachable in the list by another CPU.
>
> > The only thing we need is a READ_ONCE() so that compiler is not allowed
> > to optimize out stuff like
> >
> > loop() {
> >    if (timer_pending())
> >       something;
>
> If that was the case, then you wouldn't need to touch hlist_add_before()
> at all so there's got to be more to it than that or we can revert that
> part of the patch.


Sorry, I do not get your point. It would help if you provide a patch
or something.
