Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C9BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B58B20679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgFCKYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCKYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:24:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FECC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 03:24:21 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jgQZC-0006jT-Jm; Wed, 03 Jun 2020 12:24:14 +0200
Date:   Wed, 3 Jun 2020 12:24:12 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] mm: swap: remove lru drain waiters
Message-ID: <20200603102412.GA1030128@debian-buster-darwi.lab.linutronix.de>
References: <20200601143734.9572-1-hdanton@sina.com>
 <20200603082145.jfgmzozx42rjxegx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603082145.jfgmzozx42rjxegx@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

For some reason, **all of your posts** from <hdanton@sina.com> do not
appear on lore.kernel.org.

Check, for example, https://lore.kernel.org/lkml/?q=hdanton%40sina.com,
where thread replies are there but not the actual posts.

Just wanted to let you know... Please continue below.

On Wed, Jun 03, 2020 at 10:21:45AM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-01 22:37:34 [+0800], Hillf Danton wrote:
> >
> > After updating the lru drain sequence, new comers avoid waiting for
> > the current drainer, because he is flushing works on each online CPU,
> > by trying to lock the mutex; the drainer OTOH tries to do works for
> > those who fail to acquire the lock by checking the lru drain sequence
> > after releasing lock.
> >
> > See eef1a429f234 ("mm/swap.c: piggyback lru_add_drain_all() calls")
> > for reasons why we can skip waiting for the lock.
> >
> > The memory barriers around the sequence and the lock come together
> > to remove waiters without their drain works bandoned.
> >
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > Signed-off-by: Hillf Danton <hdanton@sina.com>
> > ---
> > This is inspired by one of the works from Sebastian.
>
> Not me, it was Ahmed.
>
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -714,10 +714,11 @@ static void lru_add_drain_per_cpu(struct
> >   */
> >  void lru_add_drain_all(void)
> >  {
> > -	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
> > +	static unsigned int lru_drain_seq;
> >  	static DEFINE_MUTEX(lock);
> >  	static struct cpumask has_work;
> > -	int cpu, seq;
> > +	int cpu;
> > +	unsigned int seq;
> >
> >  	/*
> >  	 * Make sure nobody triggers this path before mm_percpu_wq is fully
> > @@ -726,18 +727,16 @@ void lru_add_drain_all(void)
> >  	if (WARN_ON(!mm_percpu_wq))
> >  		return;
> >
> > -	seq = raw_read_seqcount_latch(&seqcount);
> > +	lru_drain_seq++;
> > +	smp_mb();
> >
> > -	mutex_lock(&lock);
> > +more_work:
> >
> > -	/*
> > -	 * Piggyback on drain started and finished while we waited for lock:
> > -	 * all pages pended at the time of our enter were drained from vectors.
> > -	 */
> > -	if (__read_seqcount_retry(&seqcount, seq))
> > -		goto done;
> > +	if (!mutex_trylock(&lock))
> > +		return;
> >

The patch I've posted makes sure to preserve the existing draining
logic. It only fixes an erroneous usage of seqcount_t latching, plus a
memory barriers bugfix, found by John, and is to be included in v2:

    https://lkml.kernel.org/r/87y2pg9erj.fsf@vostro.fn.ogness.net

On the other hand, you're making the draining operation completely
asynchronous for a number of callers. This is such a huge change, and I
fail to see: 1) any rationale for it in the changelog, 2) whether it's
been verified that call-sites won't be affected.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
