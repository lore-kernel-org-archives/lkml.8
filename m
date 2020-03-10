Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448E3C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC72464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWOmkRG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgCJOKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:10:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42393 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:10:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id 66so13216897otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UH/kbp/wpXOAAE3tRNnXeOhnV8pFJCL150z+9pntZ4A=;
        b=RWOmkRG/j7y49Wh3SB9PdFhimY5gdbbMOjfJjQXm6WmxbtGRhWUGE2xUdZ7PzL4/Y/
         Fpvm/Of6YjafgVW2nYRKdQxF+l0LSXglzjiU8dCzWmTqyOm/9m5a04/5C3CTbomPV+Wx
         BBf/GYHEx8y8vA0rDW3muZe3lQoMsG18tsNePYHtL7TDDTpKvQi5TzkvH3txUaUX7kfP
         2KUzZjvsiJ3MWXs49B++XTqiVQaLOz2Z44p2Yzy4G/nxGS8NZ52+OtdnD9qHt90rTzJ5
         fI7NhweRPwmp3LbgL1FaXgg0jWQqVtfHFWmrLzAxSRCbsZG2BT4OfAzKLfOe8C9Z8uc/
         z5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UH/kbp/wpXOAAE3tRNnXeOhnV8pFJCL150z+9pntZ4A=;
        b=mGXRBy40aHcfwpQnXniBFU8r5N+/C5I8PKBd5on8FkmDe7gxygbRfJ1BaNRxdxsgLB
         KheXAGS5/IlgggZjAUbIv3w7w03gXLAKjUCFWAkKBbGEDJxMU65t68g7j4olBKhk9ers
         Y9vASLU+drwq1jjxhBucwq1iGnkatp0uEEAq4g1VtQQva5j9kwLfOwy9hxdyV9/E9gvU
         KhSFNtkQ/chO3bjQcAgiQbdAet99Ob6DDXlKcPB/nmmsViT2qaTz3e9kV61l8rsPaSmB
         uyd4c85c6D0X3vdLnwSSl3YkIbTEgtv/0WMJI/eCLGOA6nQnbwmo4wHVwIX+ZMM2pHhm
         ujLg==
X-Gm-Message-State: ANhLgQ1Cg82V0OpeShU8Desn8EFeNYlgLjYFAMW5yBs7ubt0nH8CBbhr
        ubGTq6ka/8Uy4hTxWyHEHhMsbjsk2d90/OCSLRIsqA==
X-Google-Smtp-Source: ADFU+vtwVdEQGAWAoaHHMTTQqrZlkWuEbwFRdLQaXgbygLf45P2NIhBJnC/ZRlCG+ZxCkxL54JOpEYeosmN3rZQiCHk=
X-Received: by 2002:a05:6830:1213:: with SMTP id r19mr9393949otp.17.1583849406243;
 Tue, 10 Mar 2020 07:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200310092119.14965-1-chris@chris-wilson.co.uk>
 <2e936d8fd2c445beb08e6dd3ee1f3891@AcuMS.aculab.com> <158384100886.16414.15741589015363013386@build.alporthouse.com>
 <723d527a4ad349b78bf11d52eba97c0e@AcuMS.aculab.com> <20200310125031.GY2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200310125031.GY2935@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Tue, 10 Mar 2020 15:09:54 +0100
Message-ID: <CANpmjNNT3HY7i9TywX0cAFqBtx2J3qOGOUG5nHzxAZ4bk_qgtg@mail.gmail.com>
Subject: Re: [PATCH] list: Prevent compiler reloads inside 'safe' list iteration
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 at 13:50, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Mar 10, 2020 at 12:23:34PM +0000, David Laight wrote:
> > From: Chris Wilson
> > > Sent: 10 March 2020 11:50
> > >
> > > Quoting David Laight (2020-03-10 11:36:41)
> > > > From: Chris Wilson
> > > > > Sent: 10 March 2020 09:21
> > > > > Instruct the compiler to read the next element in the list iteration
> > > > > once, and that it is not allowed to reload the value from the stale
> > > > > element later. This is important as during the course of the safe
> > > > > iteration, the stale element may be poisoned (unbeknownst to the
> > > > > compiler).
> > > >
> > > > Eh?
> > > > I thought any function call will stop the compiler being allowed
> > > > to reload the value.
> > > > The 'safe' loop iterators are only 'safe' against called
> > > > code removing the current item from the list.
> > > >
> > > > > This helps prevent kcsan warnings over 'unsafe' conduct in releasing the
> > > > > list elements during list_for_each_entry_safe() and friends.
> > > >
> > > > Sounds like kcsan is buggy ????
>
> Adding Marco on CC for his thoughts.

I'd have to see a stack-trace with line-numbers.

But keep in mind what KCSAN does, which is report "data races". If the
KCSAN report showed 2 accesses, where one of them was a *plain* read
(and the other a write), then it's a valid data race (per LKMM's
definition). It seems this was the case here.

As mentioned, the compiler is free to transform plain accesses in
various concurrency-unfriendly ways.

FWIW, for writes we're already being quite generous, in that plain
aligned writes up to word-size are assumed to be "atomic" with the
default (conservative) config, i.e. marking such writes is optional.
Although, that's a generous assumption that is not always guaranteed
to hold (https://lore.kernel.org/lkml/20190821103200.kpufwtviqhpbuv2n@willie-the-truck/).

If there is code for which you prefer not to see KCSAN reports at all,
you are free to disable them with KCSAN_SANITIZE_file.o := n

Thanks,
-- Marco

> > > The warning kcsan gave made sense (a strange case where the emptying the
> > > list from inside the safe iterator would allow that list to be taken
> > > under a global mutex and have one extra request added to it. The
> > > list_for_each_entry_safe() should be ok in this scenario, so long as the
> > > next element is read before this element is dropped, and the compiler is
> > > instructed not to reload the element.
> >
> > Normally the loop iteration code has to hold the mutex.
> > I guess it can be released inside the loop provided no other
> > code can ever delete entries.
> >
> > > kcsan is a little more insistent on having that annotation :)
> > >
> > > In this instance I would say it was a false positive from kcsan, but I
> > > can see why it would complain and suspect that given a sufficiently
> > > aggressive compiler, we may be caught out by a late reload of the next
> > > element.
> >
> > If you have:
> >       for (; p; p = next) {
> >               next = p->next;
> >               external_function_call(void);
> >       }
> > the compiler must assume that the function call
> > can change 'p->next' and read it before the call.
>
> That "must assume" is a statement of current compiler technology.
> Given the progress over the past forty years, I would not expect this
> restriction to hold forever.  Yes, we can and probably will get the
> compiler implementers to give us command-line flags to suppress global
> analysis.  But given the progress in compilers that I have seen over
> the past 4+ decades, I would expect that the day will come when we won't
> want to be using those command-line flags.
>
> But if you want to ignore KCSAN's warnings, you are free to do so.
>
> > Is this a list with strange locking rules?
> > The only deletes are from within the loop.
> > Adds and deletes are locked.
> > The list traversal isn't locked.
> >
> > I suspect kcsan bleats because it doesn't assume the compiler
> > will use a single instruction/memory operation to read p->next.
> > That is just stupid.
>
> Heh!  If I am still around, I will ask you for your evaluation of the
> above statement in 40 years.  Actually, 10 years will likely suffice.  ;-)
>
>                                                         Thanx, Paul
