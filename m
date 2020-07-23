Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5870420888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwL9kOl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgGWMr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:47:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbgGWMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595508477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJcttqDco8CfqD0BegwArNFSC5U6Uee5kSlZI1/HOP0=;
        b=DwL9kOl2bRPS7TLVjguQnKWTgznSEDsfA0dARKfvbOPEvby/4/ODtiNqw8etbqwwiH1ZDf
        jvbFuw1/yj7zkpubL1qszlIp+6y3k4grOUkPVyQbuduqQD+jS+7Zg5xPI6wje1ucFfw1N+
        a4S2CSco3/i6u36dGBX7vL2/jNjI7+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-7gB_Oyw4O9adtKtjN-NQ4Q-1; Thu, 23 Jul 2020 08:47:54 -0400
X-MC-Unique: 7gB_Oyw4O9adtKtjN-NQ4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23E4F8005B0;
        Thu, 23 Jul 2020 12:47:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.249])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1866074F58;
        Thu, 23 Jul 2020 12:47:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 23 Jul 2020 14:47:52 +0200 (CEST)
Date:   Thu, 23 Jul 2020 14:47:50 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200723124749.GA7428@redhat.com>
References: <20200721063258.17140-1-mhocko@kernel.org>
 <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
 <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22, Linus Torvalds wrote:
>
> Comments? Oleg, this should fix the race you talked about too.

Yes.

I still can't convince myself thatI fully understand this patch but I see
nothing really wrong after a quick glance...

> +	 * We can no longer use 'wait' after we've done the
> +	 * list_del_init(&wait->entry),

Yes, but see below,

> +	 * the target may decide it's all done with no
> +	 * other locking, and 'wait' has been allocated on
> +	 * the stack of the target.
>  	 */
> -	if (test_bit(key->bit_nr, &key->page->flags))
> -		return -1;
> +	target = wait->private;
> +	smp_mb();
>
> -	return autoremove_wake_function(wait, mode, sync, key);
> +	/*
> +	 * Ok, we have successfully done what we're waiting for.
> +	 *
> +	 * Now unconditionally remove the wait entry, so that the
> +	 * waiter can use that to see success or not.
> +	 *
> +	 * We _really_ should have a "list_del_init_careful()"
> +	 * to properly pair with an unlocked "list_empty_careful()".
> +	 */
> +	list_del_init(&wait->entry);
> +
> +	/*
> +	 * Theres's another memory barrier in the wakup path, that
> +	 * makes sure the wakup happens after the above is visible
> +	 * to the target.
> +	 */
> +	wake_up_state(target, mode);

We can no longer use 'target'. If it was already woken up it can notice
list_empty_careful(), return without taking q->lock, and exit.

Of course, this is purely theoretical... rcu_read_lock() should help
but perhaps we can avoid it somehow?

Say, can't we abuse WQ_FLAG_WOKEN?

	wake_page_function:
		wait->flags |= WQ_FLAG_WOKEN;
		wmb();
		autoremove_wake_function(...);

	wait_on_page_bit_common:

		for (;;) {
			set_current_state();
			if (wait.flags & WQ_FLAG_WOKEN)
				break;
			schedule();
		}

		finish_wait();

		rmb();
		return wait.flags & WQ_FLAG_WOKEN ? 0 : -EINTR;

Another (cosmetic) problem is that wake_up_state(mode) looks confusing.
It is correct but only because we know that mode == TASK_NORMAL and thus
wake_up_state() can'fail if the target is still blocked.

> +	spin_lock_irq(&q->lock);
> +	SetPageWaiters(page);
> +	if (!trylock_page_bit_common(page, bit_nr, behavior))
> +		__add_wait_queue_entry_tail(q, wait);

do we need SetPageWaiters() if trylock() succeeds ?

Oleg.

