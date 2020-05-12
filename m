Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244E8C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB7E20746
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpJ2/f9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgELQWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgELQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:22:17 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C2C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:22:17 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so14185954qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEnxThmKo9eCKn9Sp5S//SCIqt2NuliFRLICXjN1F8w=;
        b=qpJ2/f9jFEw2XCnsQfklOx5O1EFTzceVHfXu1J5e7cHafuTXCDfUb5YnDchiAFVf3s
         jX+crR2gfyQv5H41/px3hC3d8mYCDhouCowZVS8ZR2Dj7msbcJs+/OAa7zYP3Z3P2tZO
         au5612/l0fzYXDXwkAO7TOJKK0LaFe81pNNxI1qiP5qaeHGELr1uXlTgF66qkpZQDsHP
         iFNxirnEGsp23l/WTFAlAkszfOh7yopgd1UpMaNaY9Owii6rSyCyYgYt1WgCqEkwmVxK
         6478KCl4hBT/j869nxatLWU+X7EJihyrXYrU+t9IAOe+24XJuiL7iK5VxObMn0tyheZZ
         k8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEnxThmKo9eCKn9Sp5S//SCIqt2NuliFRLICXjN1F8w=;
        b=MUWLvbYokE+iWoIv+RwkJYwDT6SeV1dbtRF0IXbMxZKa1jw6hSqcE2I8MaDSj/ef8J
         hCm/yK7Xwbi5wO1lxdKtmgul5sKS//t2iTCahQIMf82UbJxvLZXbrGgNubIwcuZxQYLc
         BmlwPAJZYlKghgSl+Q2/lyfPpV6F59UG7u5eJ3N+GbATIqNAEpVRjH8GcgNQAGd9Os2m
         SyGYC612Qh9cemlzTq8lBnOdD1ICJs5Yf1q7IJeZat7s2mZZV/jXD0jyvx0rLydDHV/D
         wI/UZkZWtMoQu8EeEzDwQrU+2mcOrtQk9A7zJMQfy9RGo8Wb5A6qqjfcpcw5AdjWHVfa
         Flgg==
X-Gm-Message-State: AGi0PuYnmnZef7w/QuqneCFdOBfn6PL1utxB3tAayGZOc2AJ7+TlXfFa
        WWy3Mt+vKBBTZSiOS6B5dAyRI8qEHbVmA1ix25jzfA==
X-Google-Smtp-Source: APiQypKKckVKHehHC9iDuSvbV8NCQd5IuVhMLPefx6OQwHvGRV3/irI6drHoBEN1CdZ/5EKC+/bJI5vBQ8VqJXPyZZQ=
X-Received: by 2002:a37:9d55:: with SMTP id g82mr18935803qke.407.1589300535553;
 Tue, 12 May 2020 09:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
 <20200511180527.GZ2869@paulmck-ThinkPad-P72> <1589250993.19238.22.camel@mtksdccf07>
 <CACT4Y+b6ZfmZG3YYC_TkoeGaAQjSEKvF4dZ9vHzTx5iokD4zTQ@mail.gmail.com>
 <20200512142541.GD2869@paulmck-ThinkPad-P72> <CACT4Y+ZfzLhcG2Wy_iEMB=hJ5k=ib+X-m29jDG2Jcs7S-TPX=w@mail.gmail.com>
 <20200512161422.GG2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200512161422.GG2869@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 May 2020 18:22:04 +0200
Message-ID: <CACT4Y+aWNDntO6+Rhn0a-4N1gLOTe5UzYB9m5TnkFxG_L15cXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rcu/kasan: record and print call_rcu() call stack
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 6:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > This feature will record first and last call_rcu() call stack and
> > > > > > > print two call_rcu() call stack in KASAN report.
> > > > > >
> > > > > > Suppose that a given rcu_head structure is passed to call_rcu(), then
> > > > > > the grace period elapses, the callback is invoked, and the enclosing
> > > > > > data structure is freed.  But then that same region of memory is
> > > > > > immediately reallocated as the same type of structure and again
> > > > > > passed to call_rcu(), and that this cycle repeats several times.
> > > > > >
> > > > > > Would the first call stack forever be associated with the first
> > > > > > call_rcu() in this series?  If so, wouldn't the last two usually
> > > > > > be the most useful?  Or am I unclear on the use case?
> > > >
> > > > 2 points here:
> > > >
> > > > 1. With KASAN the object won't be immediately reallocated. KASAN has
> > > > 'quarantine' to delay reuse of heap objects. It is assumed that the
> > > > object is still in quarantine when we detect a use-after-free. In such
> > > > a case we will have proper call_rcu stacks as well.
> > > > It is possible that the object is not in quarantine already and was
> > > > reused several times (quarantine is not infinite), but then KASAN will
> > > > report non-sense stacks for allocation/free as well. So wrong call_rcu
> > > > stacks are less of a problem in such cases.
> > > >
> > > > 2. We would like to memorize 2 last call_rcu stacks regardless, but we
> > > > just don't have a good place for the index (bit which of the 2 is the
> > > > one to overwrite). Probably could shove it into some existing field,
> > > > but then will require atomic operations, etc.
> > > >
> > > > Nobody knows how well/bad it will work. I think we need to get the
> > > > first version in, deploy on syzbot, accumulate some base of example
> > > > reports and iterate from there.
> > >
> > > If I understood the stack-index point below, why not just move the
> > > previous stackm index to clobber the previous-to-previous stack index,
> > > then put the current stack index into the spot thus opened up?
> >
> > We don't have any index in this change (don't have memory for such index).
> > The pseudo code is"
> >
> > u32 aux_stacks[2]; // = {0,0}
> >
> > if (aux_stacks[0] != 0)
> >     aux_stacks[0] = stack;
> > else
> >    aux_stacks[1] = stack;
>
> I was thinking in terms of something like this:
>
> u32 aux_stacks[2]; // = {0,0}
>
> if (aux_stacks[0] != 0) {
>     aux_stacks[0] = stack;
> } else {
>    if (aux_stacks[1])
>         aux_stacks[0] = aux_stacks[1];
>    aux_stacks[1] = stack;
> }
>
> Whether this actually makes sense in real life, I have no idea.
> The theory is that you want the last two stacks.  However, if these
> elements get cleared at kfree() time, then I could easily believe that
> the approach you already have (first and last) is the way to go.
>
> Just asking the question, not arguing for a change!

Oh, this is so obvious... in hindsight! :)

Walter, what do you think?

I would do this. I think latter stacks are generally more interesting
wrt shedding light on a bug. The first stack may even be "statically
known" (e.g. if object is always queued into a workqueue for some lazy
initialization during construction).
