Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5888BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF2420855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LN/kimao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHGSl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:41:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34123C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 11:41:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z22so2815270oid.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qmBoGKJ/6jf0yN39yT89ZvHLfPlQIChbVPrk/otNWQ0=;
        b=LN/kimaoPxNG7QYyWZoeFQ1GljX2ckB7ujRpdZqKUZo6aEhUnGhDNdRNJYX9qgjG50
         4J9MMVXR4T16g8OfbfsNmZ7KbRjMI8bitZ8HVwidzNEB77ivrSeKq4ExqpcLBD9w4xsh
         VQIoy25TaJ8G28LKYf84f7MUAUWYAz0xElhDKICbvdAPuaAbLNIBSjV8uMEPmwcFHsa6
         5tja8W0ULyNw+pVogR6MlHqXoZ+3rRASVIod19W+z6Zcj7jzuwg6F7Lqy8xXoY/kCdeC
         n8527o34/Ze9xkLcAR1IF4jmwXtejTM9Qqr4EY0/t8By+h6els1583FfG5EevsFFBMj+
         UaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qmBoGKJ/6jf0yN39yT89ZvHLfPlQIChbVPrk/otNWQ0=;
        b=TjBOFvbfzJKPkg+2wd3YD5lOKdDxZyictdqSgGZkrP0no/RwbFocnS4kcLUYCeR0EM
         nyFLpfvNBAA88VMy4IN/C4EdaH1H/7pcyvnZ5RLwNRvWbW91MdFoIe+EM34vhx5beFdp
         1l44oua45jYDBDnGn+Ehj7h3b6FCCtiiZRQzKdq4ZSGaKntSdmqn4jetitRMNFSETHug
         j7005NK5zoWCXkUtJA6LVcuxLZIuLb8BvNMGW6OJE8E9/s2G2d0+1WifH01jaWiiWwNm
         i8AqSZvQWplW9sYfiRSHsc7/s++U+ML2sK/ZGrurxDksNsfs4rmNS2/swkDuPFF3dNIZ
         ej1w==
X-Gm-Message-State: AOAM530VheBQNiI7SoGn7R4x1bpaKbqEaXzzAiBTdDVzbr3ChJm6SRo7
        lamAsD7WF9IDsJSHpec9AIYk5A==
X-Google-Smtp-Source: ABdhPJzm6312WQgCLIUYAZsQXEO52kI7CL0mkhj7HhyDTHhtppSZdfXqwXhnC5rSkOv9IWQXavIRiw==
X-Received: by 2002:aca:d88a:: with SMTP id p132mr13091890oig.95.1596825684270;
        Fri, 07 Aug 2020 11:41:24 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k25sm1798842otb.1.2020.08.07.11.41.21
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 07 Aug 2020 11:41:22 -0700 (PDT)
Date:   Fri, 7 Aug 2020 11:41:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
In-Reply-To: <CAHk-=wihTRHMm1LC4AfidZptT9ZuT-wBjE2VhYzKBy66e4iwQw@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2008071047510.1239@eggly.anvils>
References: <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com> <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com> <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils> <alpine.LSU.2.11.2007252100230.5376@eggly.anvils> <alpine.LSU.2.11.2007261246530.6812@eggly.anvils> <alpine.LSU.2.11.2008052105040.8716@eggly.anvils> <CAHk-=whf7wCUV2oTDUg0eeNafhhk_OhJBT2SbHZXwgtmAzNeTg@mail.gmail.com>
 <20200806180024.GB17456@casper.infradead.org> <CAHk-=wihTRHMm1LC4AfidZptT9ZuT-wBjE2VhYzKBy66e4iwQw@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020, Linus Torvalds wrote:
> On Thu, Aug 6, 2020 at 11:00 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > It wasn't clear to me whether Hugh thought it was an improvement or
> > not that trylock was now less likely to jump the queue.  There're
> > the usual "fair is the opposite of throughput" kind of arguments.

I don't know.  I'm inclined to think that keeping just a small chance
of jumping the queue is probably good; but pay no attention to me,
that's an opinion based on ignorance.

Thanks for mentioning the lucky lock_page(): I was quite wrong to
single out trylock_page() - I suppose its lack of a slow path just
helped it spring to mind more easily.

> 
> Yeah, it could go either way. But on the whole, if the lock bit is
> getting any contention, I think we'd rather have it be fair for
> latency reasons.
> 
> That said, I'm not convinced about my patch, and I actually threw it
> away without even testing it (sometimes I keep patches around in my
> private tree for testing, and they can live there for months or even
> years when I wonder if they are worth it, but this time I didn't
> bother to go to the trouble).
> 
> If somebody is interested in pursuing this, I think that patch might
> be a good starting point (and it _might_ even work), but it seemed to
> be too subtle to really worry about unless somebody finds an actual
> acute reason for it.

It is an attractive idea, passing the baton from one to the next;
and a logical destination from where you had already arrived.
Maybe somebody, not me, should pursue it.

I tried to ignore it, but eventually succumbed to temptation, and ran
it overnight at home (my usual tmpfs swapping), and on one machine at
work (fork/exit stress etc).  It did need one fixup, below: then home
testing went fine.  But the fork/exit stress hit that old familiar
unlock_page wake_up_page_bit softlockup that your existing patch
has appeared to fix.  I can't afford to investigate further (though
might regret that: I keep wondering if the small dose of unfairness
in your existing patch is enough to kick the test when it otherwise
would hang, and this new stricter patch be pointing to that).

My home testing was, effectively, on top of c6fe44d96fc1 (v5.8 plus
your two patches): I did not have in the io_uring changes from the
current tree. In glancing there, I noticed one new and one previous
instance of SetPageWaiters() *after* __add_wait_queue_entry_tail():
are those correct?
 
> 
> I think the existing patch narrowing the window is good, and it
> clearly didn't hurt throughput (although that was almost certainly for
> other reasons).

Agreed.

> 
>                 Linus
> 

--- linus/mm/filemap.c	2020-08-07 02:08:13.727709186 -0700
+++ hughd/mm/filemap.c	2020-08-07 02:16:10.960331473 -0700
@@ -1044,7 +1044,7 @@ static int wake_page_function(wait_queue
 	return ret;
 }
 
-static int wake_up_page_bit(struct page *page, int bit_nr)
+static void wake_up_page_bit(struct page *page, int bit_nr, bool exclude)
 {
 	wait_queue_head_t *q = page_waitqueue(page);
 	struct wait_page_key key;
@@ -1096,15 +1096,28 @@ static int wake_up_page_bit(struct page
 		 * That's okay, it's a rare case. The next waker will clear it.
 		 */
 	}
+
+	/*
+	 * If we hoped to pass PG_locked on to the next locker, but found
+	 * no exclusive taker, then we must clear it before dropping q->lock.
+	 * Otherwise unlock_page() can race trylock_page_bit_common(), and if
+	 * PageWaiters was already set from before, then cmpxchg sees no
+	 * difference to send it back to wake_up_page_bit().
+	 *
+	 * We may have already dropped and retaken q->lock on the way here, but
+	 * I think this works out because new entries are always added at tail.
+	 */
+	if (exclude && !exclusive)
+		clear_bit(bit_nr, &page->flags);
+
 	spin_unlock_irqrestore(&q->lock, flags);
-	return exclusive;
 }
 
 static void wake_up_page(struct page *page, int bit)
 {
 	if (!PageWaiters(page))
 		return;
-	wake_up_page_bit(page, bit);
+	wake_up_page_bit(page, bit, false);
 }
 
 /*
@@ -1339,8 +1352,8 @@ void unlock_page(struct page *page)
 			 * spinlock wake_up_page_bit() will do.
 			 */
 			smp_mb__before_atomic();
-			if (wake_up_page_bit(page, PG_locked))
-				return;
+			wake_up_page_bit(page, PG_locked, true);
+			return;
 		}
 		new = cmpxchg_release(&page->flags, flags, flags & ~(1 << PG_locked));
 		if (likely(new == flags))
