Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D9FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF49206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt6M5/nK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgF2TOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbgF2TOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:05 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5EC02A561
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:16:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so7089247pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=mFtZdXnZoFeNGtyvf66K2jZKiZ/gK1UF6BVtHNZ3mHI=;
        b=Nt6M5/nKGbXrQjy2BwEweDNFBFYiMj/wBEhhEny4MMASVjH6m6mZpHcVI+hg+PvGKm
         dEOYM40hm1iDmI7dX9FYhdtiO2EtIoHfGSn/pvM7OhuJBxjgUmH2oiHbd1JTaCXVsZtj
         8igrD7sl1wXJOhDDktWPbxu4++td2UGZmYJ868qDyhJwHjLnHY7dUK3NTHlB/VeRaTf5
         rcAQXEAOoJnheBuKBB6sw8K1WDJnqR06Bws7w5Sel6xC7nOwf9332Hi3ZdT0zQcQYAlB
         sZUoUrEh8qkGxR7hPxHfrbalGFLqqyngEmpS6B8HNYyVzbyh6o46d9HzOPBqzV3FAz79
         eMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=mFtZdXnZoFeNGtyvf66K2jZKiZ/gK1UF6BVtHNZ3mHI=;
        b=f5dabe7whLv3N0J0SjSTMYqTeiL7EVeMnPjFtxDCfDf0NuSgx7VZq/E0eMQR9WONPY
         nhvmiv2gUiwmmQhcZ5G50gXdpQbP/EG8Re4NOoQ56Xvx0ZlgtGghYjlPdX8ACaizZCRl
         JWb6CNStQPalhsqz3TaqVl9jXUGxmXPGY9UUIJKkUAijhjsMCSREmwXjhHxzyS9YR9RJ
         HOIQoKXo96U9AXPihkK3MZM0asAM4AXmcJePbz3XstpaM2dVKWh2YTk0xgXMJFRoSB91
         tw+elpPOw/p7nZnftF3A3G8UOF7AiHy1yM90l5tK83P38iwoII9naGqQ4HdH67lob64n
         ZrpQ==
X-Gm-Message-State: AOAM530/I57A/ZcDMYx0ou2ak/pkNDK1+x99SeMpB5/RD96WeSzPl9pu
        r2H7ctZR9y/LUYQYMcNHmMZ8cQjX
X-Google-Smtp-Source: ABdhPJwXie2fp8YVq1KEB6udvdDRGLBLXh9J5umDzqrc5tBT87oF/81ckceVCFPl9c0Vvk9ZPGqZJg==
X-Received: by 2002:a17:90a:e00a:: with SMTP id u10mr17351314pjy.17.1593436568724;
        Mon, 29 Jun 2020 06:16:08 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id k19sm7098pfg.153.2020.06.29.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 06:16:08 -0700 (PDT)
Date:   Mon, 29 Jun 2020 23:16:02 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oleg Nesterov <oleg@redhat.com>
References: <20200624161142.GA12184@redhat.com>
        <20200624162042.GA12238@redhat.com>
        <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
        <20200626154313.GI4817@hirez.programming.kicks-ass.net>
        <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
        <1593396958.ydiznwsuu8.astroid@bobo.none>
In-Reply-To: <1593396958.ydiznwsuu8.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1593436373.x8otyji40u.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Nicholas Piggin's message of June 29, 2020 1:28 pm:
> Excerpts from Linus Torvalds's message of June 28, 2020 3:39 pm:
>> On Fri, Jun 26, 2020 at 8:43 AM Peter Zijlstra <peterz@infradead.org> wr=
ote:
>>>
>>> I ended up with something like the below.. but it is too warm to think
>>> properly.
>>>
>>> I don't particularly like WQ_FLAG_PAGEWAITERS, but I liked open-coding
>>> all that even less.
>>=20
>> Ugh.
>>=20
>> I think I have a much simpler approach, actually.
>>=20
>> So the *problem* is purely around that
>>=20
>>                 if (behavior =3D=3D EXCLUSIVE) {
>>                         if (!test_and_set_bit_lock(bit_nr, &page->flags)=
)
>>                                 break;
>>                 } else ..
>>=20
>> and in particular it is purely *after* that test_and_set_bit_lock()
>> case. We have two cases:
>>=20
>>  (a) *If* we get the lock there, we're good, and all done, and we have
>> the lock. We don't care about any other wakeups, because they'll be
>> stale anyway (the thing that released the lock that we just took) and
>> because we got the lock, no other exclusive waiters should be woken up
>> anyway (and we will in turn wake up any waiters when we release it)
>>=20
>>  (b) we did *not* get the lock, because somebody else got it and is
>> about to immediately unlock again. And that _future_ wakeup that they
>> send might get lost because it might end up targeting us (but we might
>> just exit and not care).
>>=20
>> Agreed?
>>=20
>> So the only case that really matters is that we didn't get the lock,
>> but we must *not* be woken up afterwards.
>>=20
>> So how about the attached trivial two-liner? We solve the problem by
>> simply marking ourselves TASK_RUNNING, which means that we won't be
>> counted as an exclusive wakeup.
>>=20
>> Ok, so the "one" line to do that is that is actually two lines:
>>=20
>>         __set_current_state(TASK_RUNNING);
>>         smp_mb__before_atomic();
>>=20
>> and there's four lines of comments to go with it, but it really is
>> very simple: if we do that before we do the test_and_set_bit_lock(),
>> no wakeups will be lost, because we won't be sleeping for that wakeup.
>>=20
>> I'm not entirely happy about that "smp_mb__before_atomic()". I think
>> it's right in practice that test_and_set_bit_lock() (when it actually
>> does a write) has at LEAST atomic seqmantics, so I think it's good.
>> But it's not pretty.
>>=20
>> But I don't want to use a heavy
>>=20
>>         set_current_state(TASK_RUNNING);
>>         if (!test_and_set_bit_lock(bit_nr, &page->flags)) ..
>>=20
>> sequence, because at least on x86, that test_and_set_bit_lock()
>> already has a memory barrier in it, so the extra memory barrier from
>> set_current_state() is all kinds of pointless.
>>=20
>> Hmm?
>=20
> Wow good catch. Does bit_is_set even have to be true? If it's woken due=20
> to a signal, it may still be on the waitqueue right?

No, ignore this part (which you explained well it was just a thinko,
and your patch of course would not have worked if this was the case):
the exclusive wake up doesn't get lost if schedule() was called because
state goes back to running regardless of what woke it.

I still prefer if it can be changed to the below fix though.

> works, but it looks like a pretty standard variant of "don't lose
> wakeups" bug.
>=20
> prepare_to_wait_event() has a pretty good pattern (and comment), I would
> favour using that (test the signal when inserting on the waitqueue).
>=20
> @@ -1133,6 +1133,15 @@ static inline int wait_on_page_bit_common(wait_que=
ue_head_t *q,
>         for (;;) {
>                 spin_lock_irq(&q->lock);
> =20
> +               if (signal_pending_state(state, current)) {
> +                       /* Must not lose an exclusive wake up, see
> +                        * prepare_to_wait_event comment */
> +                       list_del_init(&wait->entry);
> +                       spin_unlock_irq(&q->lock);> +                    =
   ret =3D -EINTR;
> +                       break;
> +               }
> +
>                 if (likely(list_empty(&wait->entry))) {
>                         __add_wait_queue_entry_tail(q, wait);
>                         SetPageWaiters(page);
> @@ -1157,11 +1166,6 @@ static inline int wait_on_page_bit_common(wait_que=
ue_head_t *q,
>                                 break;
>                 }
> =20
> -               if (signal_pending_state(state, current)) {
> -                       ret =3D -EINTR;
> -                       break;
> -               }
> -
>                 if (behavior =3D=3D DROP) {
>                         /*
>                          * We can no longer safely access page->flags:
>=20
> - mutex_lock_common does the signal check under its wait queue lock.
>=20
> - rwsem looks like it does it backward and checks if it was woken if it
> got a signal and tries to handle it that way (hopefully okay, I prefer
> the standard pattern).
>=20
> - futex unqueues and tests for wakeup before testing signal.
>=20
> Etc. And it's not even exclusive to signals of course, those are just=20
> the typical asynchronous thing that would wake us without removing from
> the wait queue. Bit of a shame there is no standard pattern to follow
> though.
>=20
> I wonder how you could improve that. finish_wait could WARN_ON an
> exclusive waiter being found on the queue?
>=20
> @@ -377,6 +377,7 @@ void finish_wait(struct wait_queue_head *wq_head, str=
uct wait_queue_entry *wq_en
>          *    the list).
>          */
>         if (!list_empty_careful(&wq_entry->entry)) {
> +               WARN_ON(wq_entry->flags & WQ_FLAG_EXCLUSIVE);
>                 spin_lock_irqsave(&wq_head->lock, flags);
>                 list_del_init(&wq_entry->entry);
>                 spin_unlock_irqrestore(&wq_head->lock, flags);
>=20
> That doesn't catch a limited count of wake ups, maybe if you passed in=20
> success value to finish_wait, it could warn in case a failure has=20
> WQ_FLAG_WOKEN. That doesn't help things that invent their own waitqueues
> mind you. I wonder if we could do some kind of generic annotations for
> anyone implementing wait queues to call, which could have debug checks
> implemented?
>=20
> Thanks,
> Nick
>=20
>=20
