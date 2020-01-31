Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801A6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511432464B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6hJnNZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgAaRGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:06:41 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:38160 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgAaRGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:06:41 -0500
Received: by mail-yw1-f45.google.com with SMTP id 10so5390028ywv.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 09:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FwCXU85/DYT+g9qFs5HT07hGg5Z75Y3d9H26QRE81Q=;
        b=i6hJnNZZIpxGgX7i+XKFx18XZV0oIC9DW/vMZd79FnXZTLFZmiqmdDXGrli3XeKWay
         hdyMM/PXjKTTztenZOe7FFUS0+9FmFa0Xx2BDopmJSmu7jiA2/KaNlX1qW0xSpBnwA/n
         1MPqgYwnX+ewjpnbBHfqXbcjq3MjUA5de01ozExT/uEfX8WnVev1GvGB2L9tZIot+MN3
         iN/N81CBfzZTHtNYLU4xLDn9NSldniScns33Z23oAiyiC364C0YzgUg7o5GiKXrilEoA
         e8RmsgZnWZ4ebH79tSBg3MouUHux5vaCt7a5gVebEnAv3GFqRm5CV5aor9l8AXIvkxEx
         RZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FwCXU85/DYT+g9qFs5HT07hGg5Z75Y3d9H26QRE81Q=;
        b=JWUZ5MoUmFchG443hRmQDxxM8ZAo+VkAKKQ8O5hp2aab5lhzc8avoXY3YEMFtUx6ND
         WjUWOp/PWNNRW6/8uz3wxDiMd1A3qFzUeh53RKg810TMC83FatqZYI5CWIiJ61QW70tt
         B8XLt6D+SulVR7GbAgiGhnG1j0yw7QJwrW0NIwKGV0rHQLPVADKFvZvYiKoq0sNz5tIg
         06Xi9qUlUp5wqICiL4SfUVUrcZEQBdVc0g6bFfb0W7j9MiFtl0pNJeennnEm9xjQVpuA
         56f1QqYJtodfaYKxCnE8SztNPsOv+FOV4CQ0N12dUaeecuG533qkmBKEGD6xUuAAwo0w
         NrZQ==
X-Gm-Message-State: APjAAAXpHJ96BwuJt+ZAok7uLrDbbSsfqmoxMfuAtoumyCAnZizyy7vG
        Sw/pFopuTkE0SZH1j7ztoOnY8khGn3FOCUV7gXbPzQ==
X-Google-Smtp-Source: APXvYqxwr5VvzF6l/JlQslZS8/BZfpnUcBfOFPpCoDKS27R4t3VdJVAoiC23bNa4CyfOmXI+p200VgeIpo0tnOuE9rc=
X-Received: by 2002:a0d:c701:: with SMTP id j1mr1630125ywd.52.1580490398485;
 Fri, 31 Jan 2020 09:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20200131164308.GA5175@willie-the-truck> <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131165718.GA5517@willie-the-truck>
In-Reply-To: <20200131165718.GA5517@willie-the-truck>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 09:06:27 -0800
Message-ID: <CANn89iKmSBPKJGw--WaJJhCdu2wz2aq-ve+E8z=gfsYj6Zom_A@mail.gmail.com>
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

On Fri, Jan 31, 2020 at 8:57 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jan 31, 2020 at 08:48:05AM -0800, Eric Dumazet wrote:
> > On Fri, Jan 31, 2020 at 8:43 AM Will Deacon <will@kernel.org> wrote:
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
> > >
> >
> > I guess the following has been lost :
>
> Thanks, although...
>
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Thu Nov 7 11:23:14 2019 -0800
> >
> >     timer: use hlist_unhashed_lockless() in timer_pending()
> >
> >     timer_pending() is mostly used in lockless contexts.
>
> ... my point above still stands: the value returned by
> hlist_unhashed_lockless() doesn't tell you anything about whether or
> not the timer is reachable in the hlist or not. The comment above
> timer_pending() also states that:
>
>   | Callers must ensure serialization wrt. other operations done to
>   | this timer, e.g. interrupt contexts, or other CPUs on SMP.
>
> If that is intended to preclude list operations, shouldn't we use an
> RCU hlist instead of throwing {READ,WRITE}_ONCE() at the problem to
> shut the sanitiser up without actually fixing anything? :(


Sorry, but timer_pending() requires no serialization.

The only thing we need is a READ_ONCE() so that compiler is not allowed
to optimize out stuff like

loop() {
   if (timer_pending())
      something;
}
