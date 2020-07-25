Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C1C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C420714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y++mNFQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGYKOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 06:14:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54524 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgGYKOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 06:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595672093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0AOSE86PGeB1I9Z9HMCGCB3b0fmc6DBmuHd8pPAROo=;
        b=Y++mNFQ3HrrYgRlxqSr5x4gYDeFBSX8pnpAxzpi/v/SQG884gBTS34yElOXTcrd1PC3Op1
        UktxA6xzKyK/MazrAWkVMpn+U62+EM4qbBsbaDJ+Z6iGpUAWLtRe7YTLYEWWW8Lph9qKm1
        ZR2jF3BXAXp2LMDmwAjiE0HI0Ve558c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-nScs2uXVMfyq-xnABE0aEg-1; Sat, 25 Jul 2020 06:14:51 -0400
X-MC-Unique: nScs2uXVMfyq-xnABE0aEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 289B91009600;
        Sat, 25 Jul 2020 10:14:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id C482270105;
        Sat, 25 Jul 2020 10:14:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 25 Jul 2020 12:14:49 +0200 (CEST)
Date:   Sat, 25 Jul 2020 12:14:46 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200725101445.GB3870@redhat.com>
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
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24, Linus Torvalds wrote:
>
> I just realized that one thing we could do is to not even test the
> page bit for the shared case in the wakeup path.
>
> Because anybody who uses the non-exclusive "wait_on_page_locked()" or
> "wait_on_page_writeback()" isn't actually interested in the bit state
> any more at that point. All they care about is that somebody cleared
> it - not whether it was then re-taken again.
>
> So instead of keeping them on the list - or stopping the waitqueue
> walk because somebody else got the bit - we could just mark them
> successfully done, wake them up, and remove those entries from the
> list.

Heh. I too thought about this. And just in case, your patch looks correct
to me. But I can't really comment this behavioural change. Perhaps it
should come in a separate patch?

In essense, this partly reverts your commit 3510ca20ece0150
("Minor page waitqueue cleanups"). I mean this part:


     (b) we don't want to put the non-locking waiters always on the front of
         the queue, and the locking waiters always on the back.  Not only is
         that unfair, it means that we wake up thousands of reading threads
         that will just end up being blocked by the writer later anyway.
...

	@@ -972,10 +976,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
			spin_lock_irq(&q->lock);
	 
			if (likely(list_empty(&wait->entry))) {
	-			if (lock)
	-				__add_wait_queue_entry_tail_exclusive(q, wait);
	-			else
	-				__add_wait_queue(q, wait);
	+			__add_wait_queue_entry_tail(q, wait);
				SetPageWaiters(page);
			}

Oleg.

