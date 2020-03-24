Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D91C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED8E2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KH+efs8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCXSXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:23:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45075 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgCXSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:23:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so9026338ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Z/XfnfAu9ceQUL+4esJL4zzfPg+m1cHaki8X5D0KAc=;
        b=KH+efs8QWFsMXtP/1h3X/sZVN4O6JBvhGqQ/QniqRsRB4dOUGXJc3xrcAP4MHW/3o1
         iUp7g4mfoMrys3LQFjsik+ziVbjTrKakyITo4+H5FlnmSwQYhMa5XPFBKDbM+zXJ7zjX
         l2F9uapeml1zNWYKqAkM9C5/YiP7YFmHmKKgA3BRdsy0X19Xo7cD2jgpWqlWjVJKZ122
         m5w8xV6nqv9PbAr1hsGAFq01pai5Bez2r6f2jRDBwNtEmg6KzrFWWAFUH4ydUUnQao8W
         czmKV6uEz3k1pUYzoEMO7i6+TXlRu3SNHL+VyciXNe0XUuk3Jmpu0FeLR3k302qL2Aae
         l1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Z/XfnfAu9ceQUL+4esJL4zzfPg+m1cHaki8X5D0KAc=;
        b=KDEr3E/MotEjAklm8rFXQwA+6D0kIY3MoG1g4T8yNyFJehTsI3QzTZaqXLH9bXS6we
         wtRm9k3cFOZLbGFAzeF1RjFJVuVWhf0lbPbbz8XjnTw1YjgTxFNlx7UEU7cSoEaAEhF5
         AM7DSFNbnqGll+do/x9RUxChyfyqLTcC9bKsQbOX4dpN0aLt5uUx7THka9/vSIRMfGyl
         3AEYk1S9/k/Oxz+FxBNVVtSw3udpBdNuuPDjGf4olbeao2yGn75wo7BPwtdi8PbS46NK
         8VZFiGj/GRWPSrN/OqXcnEVP8di42mTFxzxUvabBtXWj9jyPOnUZzOqFYT8W5QsT1+4e
         w/GA==
X-Gm-Message-State: ANhLgQ21dDHtgj3MZoUmt1gEyknbbkE/iQuSWRkbLMSBw5QMZc5DGEob
        P0l134V6fzLq76TmotxWEM+re/nI9mLssWJjlJ/61A==
X-Google-Smtp-Source: ADFU+vs4vBcP6AoNjrRm9G0VPxYcPaY9pUCxw+q08da5XNwtH22JNq/5i0gjNhfK0uvuBfmlzD1DCpEX4vcuS8BkITI=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr2434732ljd.99.1585074197138;
 Tue, 24 Mar 2020 11:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200324153643.15527-1-will@kernel.org> <20200324153643.15527-4-will@kernel.org>
 <CAG48ez1yTbbXn__Kf0csf8=LCFL+0hR0EyHNZsryN8p=SsLp5Q@mail.gmail.com>
 <20200324162652.GA2518046@kroah.com> <CAG48ez1c5Rjo+RZRW-qR7h40zT4mT8iQv5m3h0qTjfFpsckEsg@mail.gmail.com>
 <20200324165938.GA2521386@kroah.com>
In-Reply-To: <20200324165938.GA2521386@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Mar 2020 19:22:50 +0100
Message-ID: <CAG48ez1677ihowvvgLO6i-oEu=d_woxiQj52sx0k7-nWXrBpBg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/21] list: Annotate lockless list primitives with data_race()
To:     Greg KH <greg@kroah.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 5:59 PM Greg KH <greg@kroah.com> wrote:
> On Tue, Mar 24, 2020 at 05:38:30PM +0100, Jann Horn wrote:
> > On Tue, Mar 24, 2020 at 5:26 PM Greg KH <greg@kroah.com> wrote:
> > > On Tue, Mar 24, 2020 at 05:20:45PM +0100, Jann Horn wrote:
> > > > On Tue, Mar 24, 2020 at 4:37 PM Will Deacon <will@kernel.org> wrote:
> > > > > Some list predicates can be used locklessly even with the non-RCU list
> > > > > implementations, since they effectively boil down to a test against
> > > > > NULL. For example, checking whether or not a list is empty is safe even
> > > > > in the presence of a concurrent, tearing write to the list head pointer.
> > > > > Similarly, checking whether or not an hlist node has been hashed is safe
> > > > > as well.
> > > > >
> > > > > Annotate these lockless list predicates with data_race() and READ_ONCE()
> > > > > so that KCSAN and the compiler are aware of what's going on. The writer
> > > > > side can then avoid having to use WRITE_ONCE() in the non-RCU
> > > > > implementation.
> > > > [...]
> > > > >  static inline int list_empty(const struct list_head *head)
> > > > >  {
> > > > > -       return READ_ONCE(head->next) == head;
> > > > > +       return data_race(READ_ONCE(head->next) == head);
> > > > >  }
> > > > [...]
> > > > >  static inline int hlist_unhashed(const struct hlist_node *h)
> > > > >  {
> > > > > -       return !READ_ONCE(h->pprev);
> > > > > +       return data_race(!READ_ONCE(h->pprev));
> > > > >  }
> > > >
> > > > This is probably valid in practice for hlist_unhashed(), which
> > > > compares with NULL, as long as the most significant byte of all kernel
> > > > pointers is non-zero; but I think list_empty() could realistically
> > > > return false positives in the presence of a concurrent tearing store?
> > > > This could break the following code pattern:
> > > >
> > > > /* optimistic lockless check */
> > > > if (!list_empty(&some_list)) {
> > > >   /* slowpath */
> > > >   mutex_lock(&some_mutex);
> > > >   list_for_each(tmp, &some_list) {
> > > >     ...
> > > >   }
> > > >   mutex_unlock(&some_mutex);
> > > > }
> > > >
> > > > (I'm not sure whether patterns like this appear commonly though.)
> > >
> > >
> > > I would hope not as the list could go "empty" before the lock is
> > > grabbed.  That pattern would be wrong.
> >
> > If the list becomes empty in between, the loop just iterates over
> > nothing, and the effect is no different from what you'd get if you had
> > bailed out before. But sure, you have to be aware that that can
> > happen.
>
> Doh, yeah, so it is safe, crazy, but safe :)

Here's an example of that pattern, I think (which I think is
technically incorrect if what peterz said is accurate?):

/**
 * waitqueue_active -- locklessly test for waiters on the queue
 * @wq_head: the waitqueue to test for waiters
 *
 * returns true if the wait list is not empty
 *
 * NOTE: this function is lockless and requires care, incorrect usage _will_
 * lead to sporadic and non-obvious failure.
 *
 * Use either while holding wait_queue_head::lock or when used for wakeups
 * with an extra smp_mb() like::
 *
 *      CPU0 - waker                    CPU1 - waiter
 *
 *                                      for (;;) {
 *      @cond = true;                     prepare_to_wait(&wq_head,
&wait, state);
 *      smp_mb();                         // smp_mb() from set_current_state()
 *      if (waitqueue_active(wq_head))         if (@cond)
 *        wake_up(wq_head);                      break;
 *                                        schedule();
 *                                      }
 *                                      finish_wait(&wq_head, &wait);
 *
 * Because without the explicit smp_mb() it's possible for the
 * waitqueue_active() load to get hoisted over the @cond store such that we'll
 * observe an empty wait list while the waiter might not observe @cond.
 *
 * Also note that this 'optimization' trades a spin_lock() for an smp_mb(),
 * which (when the lock is uncontended) are of roughly equal cost.
 */
static inline int waitqueue_active(struct wait_queue_head *wq_head)
{
        return !list_empty(&wq_head->head);
}

void signalfd_cleanup(struct sighand_struct *sighand)
{
        wait_queue_head_t *wqh = &sighand->signalfd_wqh;
        /*
         * The lockless check can race with remove_wait_queue() in progress,
         * but in this case its caller should run under rcu_read_lock() and
         * sighand_cachep is SLAB_TYPESAFE_BY_RCU, we can safely return.
         */
        if (likely(!waitqueue_active(wqh)))
                return;

        /* wait_queue_entry_t->func(POLLFREE) should do remove_wait_queue() */
        wake_up_poll(wqh, EPOLLHUP | POLLFREE);
}

and __add_wait_queue() just uses plain list_add(&wq_entry->entry,
&wq_head->head) under a lock.
