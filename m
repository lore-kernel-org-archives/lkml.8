Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A52CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139EE206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T2eNCTLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgETNGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:06:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3w8UcJhv/evxbN9SDtpqdx6+/nvvE9mWMv6o2PB3CoU=; b=T2eNCTLr+UGEa/9+lCBwAKlgLr
        8Vfj23LpsS96f+CZoYkDDzJFYDIcUDCY53uu56KT28AiHparZ9i0ka1esxXdEU7L8J22oqmRevpVN
        RgmKCBmfWsad5tWu2L7tdve4tbJJqnENdpACmmSxwNUXRBDAyGzrQCMb7gelSQpflFSPkxTHZVVpY
        h/5/5VqdT77dXBEy4sIXuXKvqlG1YvViW9CcuooKhOUhykI164ZFQME9uVrLeccvdrHhyb2BZJAZR
        D7oYhx3ec5wdlqBiomtxr7Gsz1I24g+b1GmB+oJRfVrO8iaRq9LK8UinwBjmmCaDGDKVL4MIN1ZIv
        AQlBnSqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbOPP-0000pq-B5; Wed, 20 May 2020 13:05:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DAF8300478;
        Wed, 20 May 2020 15:05:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1CE129DB5065; Wed, 20 May 2020 15:05:12 +0200 (CEST)
Date:   Wed, 20 May 2020 15:05:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v1 02/25] mm/swap: Don't abuse the seqcount latching API
Message-ID: <20200520130512.GD325280@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-3-a.darwish@linutronix.de>
 <706c697c-c951-e0c3-40f8-f6e429b2226a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <706c697c-c951-e0c3-40f8-f6e429b2226a@yandex-team.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:22:15PM +0300, Konstantin Khlebnikov wrote:
> On 20/05/2020 00.45, Ahmed S. Darwish wrote:
> > Commit eef1a429f234 ("mm/swap.c: piggyback lru_add_drain_all() calls")
> > implemented an optimization mechanism to exit the to-be-started LRU
> > drain operation (name it A) if another drain operation *started and
> > finished* while (A) was blocked on the LRU draining mutex.

That commit is horrible...

> Well, I thought it fits perfectly =)
> 
> Maybe it's worth to add helpers with appropriate semantics?
> This is pretty common pattern.

Where's more sites?

> > @@ -725,21 +735,48 @@ void lru_add_drain_all(void)
> >   	if (WARN_ON(!mm_percpu_wq))
> >   		return;
> > -	seq = raw_read_seqcount_latch(&seqcount);
> >   	mutex_lock(&lock);
> >   	/*
> > -	 * Piggyback on drain started and finished while we waited for lock:
> > -	 * all pages pended at the time of our enter were drained from vectors.
> >   	 */
> > -	if (__read_seqcount_retry(&seqcount, seq))
> >   		goto done;

Since there is no ordering in raw_read_seqcount_latch(), and
mutex_lock() is an ACQUIRE, there's no guarantee the read actually
happens before the mutex is acquired.

> > -	raw_write_seqcount_latch(&seqcount);
> >   	cpumask_clear(&has_work);
