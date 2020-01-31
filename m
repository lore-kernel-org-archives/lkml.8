Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E42C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3CD20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTxwABBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgAaSzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:55:14 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44108 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgAaSzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:55:13 -0500
Received: by mail-yw1-f67.google.com with SMTP id t141so5718805ywc.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LQSLWOoReetCIdpu+9h4YNEFY4D/YOcI+H4hdRcLHo=;
        b=GTxwABBI9+3yHgLCLV9IsnX1UmSlN5zyu7Eqj4HYVDyUXzsvi/A/NluzZZ4jVWM1p8
         q/RxmSivl0x2yfPs5zcAYdfZkd+nOAC5TUkNqX4yUZsNUzrhQ1Qaa8TwH4M/FiBcbzfM
         yXoGnLPRt37sfJ+h4KnQsQAFdyObB4gtgDIEWBtDBX5gcGw16z1Jen4VXhAKkfsy107W
         kSxgAc6KcDcX5Ju9lex4dnejIhyAWYCTDd+pmzmPvmmCmKyY3VA47HIK19qsdXCDCR/z
         MioMOoPkC7i3Ah6Xh8fRavwneGUD25NMjrc94S2Ec0l/m+34m56Y1wHiVnEbPoPsKMYz
         Ws/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LQSLWOoReetCIdpu+9h4YNEFY4D/YOcI+H4hdRcLHo=;
        b=ehw9OpB1KJ0nASdP88rpFgeQ61NA1tVjO7SHM++fiboyWdyruNggizvqjRDGg2wY6p
         5OixyQ1X/fzBCL0qMa1N+oVgz3eIdH/8IdlnEqv9KfPmirJyyC5xIGT7Pw3RD02/ZJOn
         tTknI4QlqB6/C1KtLrtvAjk7GIM7csVzgKjTRd9OKFcGq40pM7P8bvQ9sFcVkoNHXvmi
         WjgCLw4eJpUa73CNRpMYqlhCfCWf3ijV4Q667UqWzUMPhIxTeeXjty3bWjF3Z+uCF39L
         cCeapHh57UphYXG+QTN7ptaEfQHWcp/Kv8TFf0/pec1uUukRvROOyRar/drFiB6CtNf3
         n5hQ==
X-Gm-Message-State: APjAAAUokIvzOxp7UfFalpJDIdBAPiHOpqJoA3u4CuS9TQv3xEPJOaBa
        1tgf1wj3Fue+nVMLD0Fdchqjg/5L3+eEO4dS9ZcimYxO
X-Google-Smtp-Source: APXvYqy9/uYNRyNxfH5Qji613hlgQDt/i0jNq8dvoebQM/CvjYymvkvZDiQwMnU0HkCj4yI5Ap9se4SzqwpNI7gIezc=
X-Received: by 2002:a81:3845:: with SMTP id f66mr9502941ywa.220.1580496912297;
 Fri, 31 Jan 2020 10:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20200131164308.GA5175@willie-the-truck> <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131185249.GR2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200131185249.GR2935@paulmck-ThinkPad-P72>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 10:55:01 -0800
Message-ID: <CANn89i+pEuNoV91rr4N+Vash4FQ0dX2AiKvtwPS4DK7bVuXFGg@mail.gmail.com>
Subject: Re: Confused about hlist_unhashed_lockless()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Jan 31, 2020 at 08:48:05AM -0800, Eric Dumazet wrote:
> > On Fri, Jan 31, 2020 at 8:43 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > Hi folks,
> > >
> > > I just ran into c54a2744497d ("list: Add hlist_unhashed_lockless()")
> > > but I'm a bit confused about what it's trying to achieve. It also seems
> > > to have been merged without any callers (even in -next) -- was that
> > > intentional?
> > >
> > > My main source of confusion is the lack of memory barriers. For example,
> > > if you look at the following pair of functions:
> > >
> > >
> > > static inline int hlist_unhashed_lockless(const struct hlist_node *h)
> > > {
> > >         return !READ_ONCE(h->pprev);
> > > }
> > >
> > > static inline void hlist_add_before(struct hlist_node *n,
> > >                                     struct hlist_node *next)
> > > {
> > >         WRITE_ONCE(n->pprev, next->pprev);
> > >         WRITE_ONCE(n->next, next);
> > >         WRITE_ONCE(next->pprev, &n->next);
> > >         WRITE_ONCE(*(n->pprev), n);
> > > }
> > >
> > >
> > > Then running these two concurrently on the same node means that
> > > hlist_unhashed_lockless() doesn't really tell you anything about whether
> > > or not the node is reachable in the list (i.e. there is another node
> > > with a next pointer pointing to it). In other words, I think all of
> > > these outcomes are permitted:
> > >
> > >         hlist_unhashed_lockless(n)      n reachable in list
> > >         0                               0 (No reordering)
> > >         0                               1 (No reordering)
> > >         1                               0 (No reordering)
> > >         1                               1 (Reorder first and last WRITE_ONCEs)
> > >
> > > So I must be missing some details about the use-case here. Please could
> > > you enlighten me? The RCU implementation permits only the first three
> > > outcomes afaict, why not use that and leave non-RCU hlist as it was?
> >
> > I guess the following has been lost :
>
> 4d3d2ae81afd ("timer: Use hlist_unhashed_lockless() in timer_pending()")
> in -rcu, slated for not this merge window but the next one.  And
> including the changes in your later email, Eric.  Please see below
> and let me know whether you are OK with it.
>
>                                                         Thanx, Paul

Well, it seems we only have to wait for data_race() being available, right ?

Then push a patch using data_race() instead of READ_ONCE() thing.
