Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2433AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3CF2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lFPlDrZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgG1QCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbgG1QCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:02:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C0EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:02:06 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q4so21749684lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pYEC9dZ+jd5ZdpQ86R7MRp/YpojCjB5i3kRxOXIqZ4=;
        b=lFPlDrZAPUQGkmZpmSCIMJDbvQtxgVtpwEqHn/z1SvDBcvz/7LeDdZGg4TSxdYSyqk
         1AL+peXtrZTzNnqgR0xs7Y7977CKVPUok7j3yTy3fQYqP10ZqxqIy+9zptz2JJbZcWaM
         1mA94lw8guaLpIHv0MPGhj0YPfLyPVmnef/ODkEwrC00hyOPvUfFWOSFl3+GXoyXNH0M
         t0Vg8hdOAGTu3wxRXFazn8ao0NP1jTcE4K54hUNsuXJb/t0nZB3hCsK7SHo4Zm2aMn1+
         wgBJCGNHD1ozmLFA67jDuE7KQ9jNegJ3U2Z89iqfBH4vcO/T/fCQt9+msff18hc1XoOU
         +gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pYEC9dZ+jd5ZdpQ86R7MRp/YpojCjB5i3kRxOXIqZ4=;
        b=ajqnK72K2hXbq+hfNVnrpUUxAZdlwYfljppNQdKMqiEEPkc9FXoS1lO6/VkZpMkgwH
         hsEahr0X6bdUgHb59WIOP6cc2V3rxJjdbOc9hAWsz7HphLbpnfag3zFQ3BfJhnUbcle4
         6y3ooQyRCkzU1laFenEHqE/Q9AbzDGxRiHHNUZP6PnN7OguU7Z5CvOXumtV1oDDKwGa7
         7DucUY2Px63pZXJeGQDjZ8Rjv6s3WSSmgpMW49f0wKtTBhaCsEQQhT3OD4OAVduX0gRO
         6D6bZ06iX3yTTRcosSTPZbzQPOqCrTUn4P170w2WwoxZoaZHnVPNvQC955/GsIaLn9r5
         VwdQ==
X-Gm-Message-State: AOAM532RHoxlrc3XAiRQ91NwTqFPHWJK9yBg9zr36eNgVUeJgErSjHsa
        M+kNWmanh3RjO4V7FysXTjAWbBCzBNIkhAdyHloGtw==
X-Google-Smtp-Source: ABdhPJyNDixSOqhlBwh4RtvxiHRwy6t1BD/alks9BCgw7xmmuH8s5mdvp3+TVPFpJ/ycVp044ugkXyxzh7rvfBAZS+Q=
X-Received: by 2002:a2e:6c14:: with SMTP id h20mr11602812ljc.176.1595952125171;
 Tue, 28 Jul 2020 09:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200727120424.1627555-1-jannh@google.com> <CAB0TPYHx-SkaWR6i0LwLYRJv13_0V3Ak63H0=parZNvS5XdqgA@mail.gmail.com>
 <CAG48ez23-oOGjeNhFCzrWxJuuJUsdgbpiSiPvM0ov1n+FcLPhw@mail.gmail.com>
In-Reply-To: <CAG48ez23-oOGjeNhFCzrWxJuuJUsdgbpiSiPvM0ov1n+FcLPhw@mail.gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 28 Jul 2020 18:01:54 +0200
Message-ID: <CAB0TPYEd-UeEeZbn7iDLwXYLRZfS5vSgY4hJTooYdCs3n6FTqA@mail.gmail.com>
Subject: Re: [PATCH v2] binder: Prevent context manager from incrementing ref 0
To:     Jann Horn <jannh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Mattias Nissler <mnissler@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for the detailed explanation, I understood now.

Martijn

On Tue, Jul 28, 2020 at 4:50 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Jul 28, 2020 at 3:50 PM Martijn Coenen <maco@android.com> wrote:
> > On Mon, Jul 27, 2020 at 2:04 PM Jann Horn <jannh@google.com> wrote:
> > >  - task B opens /dev/binder once, creating binder_proc instance P3
> > >  - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
> > >    transaction)
> > >  - P2 receives the handle and uses it to call P3 (two-way transaction)
> > >  - P3 calls P2 (via magic handle 0) (two-way transaction)
> > >  - P2 calls P2 (via handle 1) (two-way transaction)
> >
> > Why do you need P3 involved at all? Could P2 just straight away make a
> > call on handle 1?
>
> Yes, it could, I think. IIRC these steps are necessary if you want to
> actually get a KASAN splat, instead of just a transaction-to-self with
> no further consequences. It has been a while since I looked at this,
> but I'll try to figure out again what was going on...
>
>
> A UAF occurs in the following code due to the transaction-to-self,
> because the "if (t->to_thread == thread)" is tricked into believing
> that the transaction has already been accepted.
>
> static int binder_thread_release(struct binder_proc *proc,
>                                  struct binder_thread *thread)
> {
>         struct binder_transaction *t;
>         struct binder_transaction *send_reply = NULL;
>         [...]
>         t = thread->transaction_stack;
>         if (t) {
>                 [...]
>                 if (t->to_thread == thread)
>                         send_reply = t;
>         } else {
>                 [...]
>         }
>         [...]
>         //NOTE: transaction is freed here because top-of-stack is
>         //      wrongly treated as already-accepted incoming transaction)
>         if (send_reply)
>                 binder_send_failed_reply(send_reply, BR_DEAD_REPLY);
>         //NOTE pending transaction work is processed here (transaction has not
>         //     yet been accepted)
>         binder_release_work(proc, &thread->todo);
>         [...]
> }
>
> An unaccepted transaction will only have a non-NULL ->to_thread if the
> transaction has a specific target thread; for a non-reply transaction,
> that is only the case if it is a two-way transaction that was sent
> while the binder call stack already contained the target task (iow,
> the transaction looks like a synchronous callback invocation).
>
> With the steps:
>
>  - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
>    transaction)
>  - P2 receives the handle and uses it to call P3 (two-way transaction)
>  - P3 calls P2 (via magic handle 0) (two-way transaction)
>  - P2 calls P2 (via handle 1) (two-way transaction)
>
> the call stack will look like this:
>
>     P3 -> P2 -> P3 -> P2 -> P2
>
> The initial call from P3 to P2 was IIRC just to give P2 a handle to
> P3; IIRC the relevant part of the call stack was:
>
>     P2 -> P3 -> P2 -> P2
>
> Because P2 already occurs down in the call stack, the final
> transaction "P2 -> P2" is considered to be a callback and is
> thread-directed.
>
>
> The reason why P3 has to be created from task B is the "if
> (target_node && target_proc->pid == proc->pid)" check for transactions
> to reference 0.
