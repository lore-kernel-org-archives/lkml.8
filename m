Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5879DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B61020724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593540167;
	bh=sBL6odnn3M3PTVwubLABVggnK4LACC8/9fcbP5Sl17k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eXx2e66nOHI4tZKsiAFlZQE3uI+UUdqPZRWySJnccfauegYpdABfNMGa9FA3aO+4Y
	 j5ml6kH+S3CEFQp0Zi5ozcXG7x6J+bZ6pMJF1An4CKdf9SRamk/pnb7u+17ZMMYzAp
	 uhpelhXc4m9h6ylRPclsuUBCbbIfXpw/VSa5ExRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390598AbgF3SCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbgF3SCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:02:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA62C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:02:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so23690779ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqFV+aEDatN0MsHX/XVi1DRPrONFdIa6+nFfBujC0Ls=;
        b=EAqU11uCdQrt1ChMpyrd1RyBBFe0OAzwEp6hoTYE3znu9IrZKk9Lxqzpw/zhMs/WG/
         1Fu9mNvA4GmzPvgEzbUH/6PKTyphxwGgiTmYgvN5IJHzv/19hx1/p/A2WZMFVwjSn5yf
         QwgHOMAQzURaBa3LMGZGKMxqjyv6QB89tVz54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqFV+aEDatN0MsHX/XVi1DRPrONFdIa6+nFfBujC0Ls=;
        b=S1zu6y5UuKzsuDPh3OE9AMVU45VpSFo2MaXvT+uElLE4Y8eO3GLwJupqWXP9C6RZDJ
         SdiXRMOi5nDFSYXc8sqKT/f7IuLvB+ddqS/+apUe4E4WcJ3ATXd66h/T0+91/LRmxXxg
         gqNfCWQnaaPSLGs6qrBugYthH0ZnlHq7uinSeGFEU4ajmZnYllJhSPy1Se6xEn6J91xm
         4Cz5GfUIqHKz+1+iNCf9KUy1EpJYu7vp7Yg5WFkfjwxijVJGsG+Kdfb6F9E3icGplrZ6
         pJbmJipxuN1zBC2gQRPF2t0FJ0+6bX0g0H0dNwixvliUvOFHBJpl9B7ahgjgLZ8H3k4J
         Ql/Q==
X-Gm-Message-State: AOAM5307WxE3NH//OEvNq+tAZnDtv/XdOUeJp4BEIahJ5FbSU9vGcUZV
        h7h65ernwqEuMiPpuugoq1pPhyj1M44=
X-Google-Smtp-Source: ABdhPJx0SdnXIJTEd5ZXHyZ061XniEZnVisQ3u93Ryl5qVYYHuVOd+TchJUJlWj1FVmsiooP8eVq5A==
X-Received: by 2002:a2e:854b:: with SMTP id u11mr7840354ljj.99.1593540162778;
        Tue, 30 Jun 2020 11:02:42 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i8sm1081704lja.18.2020.06.30.11.02.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 11:02:40 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id k15so11919891lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:02:40 -0700 (PDT)
X-Received: by 2002:ac2:5093:: with SMTP id f19mr12738963lfm.10.1593540159598;
 Tue, 30 Jun 2020 11:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
 <20200626154313.GI4817@hirez.programming.kicks-ass.net> <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
 <1593396958.ydiznwsuu8.astroid@bobo.none> <20200629140245.GB20323@redhat.com>
 <1593482844.k3rh7s05o8.astroid@bobo.none> <20200630061708.GA21263@redhat.com>
 <1593505946.t0nxq8q8kj.astroid@bobo.none> <20200630105354.GB23871@redhat.com>
 <20200630113637.GC23871@redhat.com> <20200630115052.GD23871@redhat.com>
In-Reply-To: <20200630115052.GD23871@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jun 2020 11:02:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfjK_-Wfkb6yXYpB5WfOv5yP2NiFO68yQfBfnzRu4yYQ@mail.gmail.com>
Message-ID: <CAHk-=wgfjK_-Wfkb6yXYpB5WfOv5yP2NiFO68yQfBfnzRu4yYQ@mail.gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss wakeup?
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 4:51 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 06/30, Oleg Nesterov wrote:
> >
> > may be someting like this
>
> or this ...

Guys, I'd suggest we either

 (a) do the minimal ugly one-liner workaround

or

 (b) do something *much* more radical.

What would that "radical" thing be? Just move the "behavior" bit into
the "struct wait_page_key" itself, and handle it at wakeup time!

Right now we have

 - wake_page_function() basically tests that it's the right bit and
page, and that the bit has actually cleared

 - then it calls "autoremove_wake_function()" to wake things up and
remove you from the wait list if that wqoke you up.

I would suggest that if we want to clean this up, we do

 - add "behavior" to  "struct wait_page_key"

 - now, for the "exclusive" case, instead of doing

        if (test_bit(key->bit_nr, &key->page->flags))
                return -1;

   the wake_page_function() would actually do

        if (test_and_set_bit(key->bit_nr, &key->page->flags))
                return -1;
        /*
         * Careful, careful: we need to make sure that the *last*
         * thing that touches 'wq_entry' is setting WQ_FLAG_WOKEN
         */
        list_del_init(&wq_entry->entry);
        default_wake_function(wq_entry, mode, sync, key);
        smp_store_release(&wq_entry->flags, WQ_FLAG_WOKEN);

        /* No point in waking up anybody else */
        return -1;

while for the SHARED and DROP cases it would do

        if (test_bit(key->bit_nr, &key->page->flags))
                return -1;
        list_del_init(&wq_entry->entry);
        default_wake_function(wq_entry, mode, sync, key);
        smp_store_release(&wq_entry->flags, WQ_FLAG_WOKEN);

        return 0;

and now the actual _waiting_ side can basically just do

        /* All the wait-queue setup is done outside the loop */
        wait_page.behavior = behavior;

        spin_lock_irq(&q->lock);
        .. test the big again here, do the rigth thing for mode, exit if done ..
        __add_wait_queue_entry_tail(q, wait);
        SetPageWaiters(page);
        set_current_state(state);
        spin_unlock_irq(&q->lock);

        for (;;) {
                set_current_state(state);

                /*
                 * Have we already been woken and are all done?
                 * We don't even need to remove ourselves from the
                 * wait-queues, that's been done for us.
                 */
                if (wait->flags & WQ_FLAG_WOKEN)
                        return 0;

                if (signal_pending_state(state, current))
                         break;

                io_schedule();
        }
        /* We got interrupted by a signal? */
        finish_wait(q, wait);

        /* But maybe we raced with being woken and are all done? */
        if (wait->flags & WQ_FLAG_WOKEN)
                        return 0;

        return -EINTR;

NOTE! The above doesn't do the thrashing/delayacct handling, and that
was intentional for clarity, because I actually think that should be
done in an outer function that just calls this actual "do the
lock/wait"

Look, doesn't that seem *much* simpler and clearer? Having that flag
in the wait-queue (that stays around even after it's been removed from
the list) shows that the state we're testing for - or the state we
wanted - is already ours.

Note that we have a "woken_wake_function()" that does that
WQ_FLAG_WOKEN thing, but I don't think it's careful about that final
WQ_FLAG_WOKEN bit setting, and the above function cares about that
(notice how it checks WQ_FLAG_WOKEN without ever taking the spinlock
that protects the other members of it, so the stack space can get
deallocated immediately once it sees that flag.

The above code has been written in my MUA, it may be entirely broken,
but it _feels_ right to me.

And yes, it's a lot bigger change than my one-liner. But honestly,
this is the kind of thing that the whole "struct wait_page_key" thing
is all about and exists for.

What do people think? I think it clarifies the logic and makes things
potentially much clearer. In fact, now the actual _waiting_ code never
looks at the struct page at all, so it can drop the reference to the
page early, outside the loop, adn that "drop" thing doesn't even have
to be visible on the waker side either (the wakeup logic is the same
as SHARED)

Hmm?

              Linus
