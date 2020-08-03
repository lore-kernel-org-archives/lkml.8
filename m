Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5ACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF6C206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgHCNO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:14:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:36872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgHCNO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:14:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3E6AACA0;
        Mon,  3 Aug 2020 13:15:09 +0000 (UTC)
Date:   Mon, 3 Aug 2020 15:14:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Hugh Dickins <hughd@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200803131453.GL5174@dhcp22.suse.cz>
References: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com>
 <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils>
 <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
sorry for being late in discussion (was offline or very busy with other
stuff).

I hope I got it right and this is the latest version of your patches. Btw.
do you still think that increasing PAGE_WAIT_TABLE_BITS is reasonable.
In the meantime I have learned that the customer suffering from the
issue is very unlikely to reboot the machine anytime soon or even
willing to test a non-trivial patch. We do not own any machine which
exhibit this problem unfortunately. So it is quite unlikely I can
help with testing.

Also does it make sense to put this into mmotm tree for a while to get a
larger testing coverage?

I didn't get to review these patch and it will take some time to do that
because this is really subtle area.

Thanks for helping out and sorry that I cannot really help much more
now.

On Fri 24-07-20 16:25:56, Linus Torvalds wrote:
> From 0bccb60841cc52a9aa6e9cc6b7eff59d1983e8fa Mon Sep 17 00:00:00 2001
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 23 Jul 2020 10:16:49 -0700
> Subject: [PATCH 1/2] mm: rewrite wait_on_page_bit_common() logic
> 
> It turns out that wait_on_page_bit_common() had several problems,
> ranging from just unfair behavioe due to re-queueing at the end of the
> wait queue when re-trying, and an outright bug that could result in
> missed wakeups (but probably never happened in practice).
> 
> This rewrites the whole logic to avoid both issues, by simply moving the
> logic to check (and possibly take) the bit lock into the wakeup path
> instead.
> 
> That makes everything much more straightforward, and means that we never
> need to re-queue the wait entry: if we get woken up, we'll be notified
> through WQ_FLAG_WOKEN, and the wait queue entry will have been removed,
> and everything will have been done for us.
> 
> Link: https://lore.kernel.org/lkml/CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/alpine.LSU.2.11.2007221359450.1017@eggly.anvils/
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Reported-by: Hugh Dickins <hughd@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  mm/filemap.c | 132 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 85 insertions(+), 47 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 385759c4ce4b..8c3d3e233d37 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1002,6 +1002,7 @@ struct wait_page_queue {
>  
>  static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *arg)
>  {
> +	int ret;
>  	struct wait_page_key *key = arg;
>  	struct wait_page_queue *wait_page
>  		= container_of(wait, struct wait_page_queue, wait);
> @@ -1014,17 +1015,40 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
>  		return 0;
>  
>  	/*
> -	 * Stop walking if it's locked.
> -	 * Is this safe if put_and_wait_on_page_locked() is in use?
> -	 * Yes: the waker must hold a reference to this page, and if PG_locked
> -	 * has now already been set by another task, that task must also hold
> -	 * a reference to the *same usage* of this page; so there is no need
> -	 * to walk on to wake even the put_and_wait_on_page_locked() callers.
> +	 * If it's an exclusive wait, we get the bit for it, and
> +	 * stop walking if we can't.
> +	 *
> +	 * If it's a non-exclusive wait, then the fact that this
> +	 * wake function was called means that the bit already
> +	 * was cleared, and we don't care if somebody then
> +	 * re-took it.
>  	 */
> -	if (test_bit(key->bit_nr, &key->page->flags))
> -		return -1;
> +	ret = 0;
> +	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
> +		if (test_and_set_bit(key->bit_nr, &key->page->flags))
> +			return -1;
> +		ret = 1;
> +	}
> +	wait->flags |= WQ_FLAG_WOKEN;
>  
> -	return autoremove_wake_function(wait, mode, sync, key);
> +	wake_up_state(wait->private, mode);
> +
> +	/*
> +	 * Ok, we have successfully done what we're waiting for,
> +	 * and we can unconditionally remove the wait entry.
> +	 *
> +	 * Note that this has to be the absolute last thing we do,
> +	 * since after list_del_init(&wait->entry) the wait entry
> +	 * might be de-allocated and the process might even have
> +	 * exited.
> +	 *
> +	 * We _really_ should have a "list_del_init_careful()" to
> +	 * properly pair with the unlocked "list_empty_careful()"
> +	 * in finish_wait().
> +	 */
> +	smp_mb();
> +	list_del_init(&wait->entry);
> +	return ret;
>  }
>  
>  static void wake_up_page_bit(struct page *page, int bit_nr)
> @@ -1103,16 +1127,31 @@ enum behavior {
>  			 */
>  };
>  
> +/*
> + * Attempt to check (or get) the page bit, and mark the
> + * waiter woken if successful.
> + */
> +static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
> +					struct wait_queue_entry *wait)
> +{
> +	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
> +		if (test_and_set_bit(bit_nr, &page->flags))
> +			return false;
> +	} else if (test_bit(bit_nr, &page->flags))
> +		return false;
> +
> +	wait->flags |= WQ_FLAG_WOKEN;
> +	return true;
> +}
> +
>  static inline int wait_on_page_bit_common(wait_queue_head_t *q,
>  	struct page *page, int bit_nr, int state, enum behavior behavior)
>  {
>  	struct wait_page_queue wait_page;
>  	wait_queue_entry_t *wait = &wait_page.wait;
> -	bool bit_is_set;
>  	bool thrashing = false;
>  	bool delayacct = false;
>  	unsigned long pflags;
> -	int ret = 0;
>  
>  	if (bit_nr == PG_locked &&
>  	    !PageUptodate(page) && PageWorkingset(page)) {
> @@ -1130,48 +1169,47 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
>  	wait_page.page = page;
>  	wait_page.bit_nr = bit_nr;
>  
> -	for (;;) {
> -		spin_lock_irq(&q->lock);
> +	/*
> +	 * Do one last check whether we can get the
> +	 * page bit synchronously.
> +	 *
> +	 * Do the SetPageWaiters() marking before that
> +	 * to let any waker we _just_ missed know they
> +	 * need to wake us up (otherwise they'll never
> +	 * even go to the slow case that looks at the
> +	 * page queue), and add ourselves to the wait
> +	 * queue if we need to sleep.
> +	 *
> +	 * This part needs to be done under the queue
> +	 * lock to avoid races.
> +	 */
> +	spin_lock_irq(&q->lock);
> +	SetPageWaiters(page);
> +	if (!trylock_page_bit_common(page, bit_nr, wait))
> +		__add_wait_queue_entry_tail(q, wait);
> +	spin_unlock_irq(&q->lock);
>  
> -		if (likely(list_empty(&wait->entry))) {
> -			__add_wait_queue_entry_tail(q, wait);
> -			SetPageWaiters(page);
> -		}
> +	/*
> +	 * From now on, all the logic will be based on
> +	 * the WQ_FLAG_WOKEN flag, and the and the page
> +	 * bit testing (and setting) will be - or has
> +	 * already been - done by the wake function.
> +	 *
> +	 * We can drop our reference to the page.
> +	 */
> +	if (behavior == DROP)
> +		put_page(page);
>  
> +	for (;;) {
>  		set_current_state(state);
>  
> -		spin_unlock_irq(&q->lock);
> -
> -		bit_is_set = test_bit(bit_nr, &page->flags);
> -		if (behavior == DROP)
> -			put_page(page);
> -
> -		if (likely(bit_is_set))
> -			io_schedule();
> -
> -		if (behavior == EXCLUSIVE) {
> -			if (!test_and_set_bit_lock(bit_nr, &page->flags))
> -				break;
> -		} else if (behavior == SHARED) {
> -			if (!test_bit(bit_nr, &page->flags))
> -				break;
> -		}
> -
> -		if (signal_pending_state(state, current)) {
> -			ret = -EINTR;
> +		if (signal_pending_state(state, current))
>  			break;
> -		}
>  
> -		if (behavior == DROP) {
> -			/*
> -			 * We can no longer safely access page->flags:
> -			 * even if CONFIG_MEMORY_HOTREMOVE is not enabled,
> -			 * there is a risk of waiting forever on a page reused
> -			 * for something that keeps it locked indefinitely.
> -			 * But best check for -EINTR above before breaking.
> -			 */
> +		if (wait->flags & WQ_FLAG_WOKEN)
>  			break;
> -		}
> +
> +		io_schedule();
>  	}
>  
>  	finish_wait(q, wait);
> @@ -1190,7 +1228,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
>  	 * bother with signals either.
>  	 */
>  
> -	return ret;
> +	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
>  }
>  
>  void wait_on_page_bit(struct page *page, int bit_nr)
> -- 
> 2.28.0.rc0.3.g1e25d3a62f
> 

> From 93f0263b9b952a1c449cec56a6aadf6320e821f9 Mon Sep 17 00:00:00 2001
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 23 Jul 2020 12:33:41 -0700
> Subject: [PATCH 2/2] list: add "list_del_init_careful()" to go with
>  "list_empty_careful()"
> 
> That gives us ordering guarantees around the pair.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  include/linux/list.h | 20 +++++++++++++++++++-
>  kernel/sched/wait.c  |  2 +-
>  mm/filemap.c         |  7 +------
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index aff44d34f4e4..0d0d17a10d25 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -282,6 +282,24 @@ static inline int list_empty(const struct list_head *head)
>  	return READ_ONCE(head->next) == head;
>  }
>  
> +/**
> + * list_del_init_careful - deletes entry from list and reinitialize it.
> + * @entry: the element to delete from the list.
> + *
> + * This is the same as list_del_init(), except designed to be used
> + * together with list_empty_careful() in a way to guarantee ordering
> + * of other memory operations.
> + *
> + * Any memory operations done before a list_del_init_careful() are
> + * guaranteed to be visible after a list_empty_careful() test.
> + */
> +static inline void list_del_init_careful(struct list_head *entry)
> +{
> +	__list_del_entry(entry);
> +	entry->prev = entry;
> +	smp_store_release(&entry->next, entry);
> +}
> +
>  /**
>   * list_empty_careful - tests whether a list is empty and not being modified
>   * @head: the list to test
> @@ -297,7 +315,7 @@ static inline int list_empty(const struct list_head *head)
>   */
>  static inline int list_empty_careful(const struct list_head *head)
>  {
> -	struct list_head *next = head->next;
> +	struct list_head *next = smp_load_acquire(&head->next);
>  	return (next == head) && (next == head->prev);
>  }
>  
> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> index ba059fbfc53a..01f5d3020589 100644
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -389,7 +389,7 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
>  	int ret = default_wake_function(wq_entry, mode, sync, key);
>  
>  	if (ret)
> -		list_del_init(&wq_entry->entry);
> +		list_del_init_careful(&wq_entry->entry);
>  
>  	return ret;
>  }
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8c3d3e233d37..991503bbf922 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1041,13 +1041,8 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
>  	 * since after list_del_init(&wait->entry) the wait entry
>  	 * might be de-allocated and the process might even have
>  	 * exited.
> -	 *
> -	 * We _really_ should have a "list_del_init_careful()" to
> -	 * properly pair with the unlocked "list_empty_careful()"
> -	 * in finish_wait().
>  	 */
> -	smp_mb();
> -	list_del_init(&wait->entry);
> +	list_del_init_careful(&wait->entry);
>  	return ret;
>  }
>  
> -- 
> 2.28.0.rc0.3.g1e25d3a62f
> 


-- 
Michal Hocko
SUSE Labs
