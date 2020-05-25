Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BDE2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404130AbgEYPYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404016AbgEYPYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:24:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FBAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:24:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jdExO-0002aw-LB; Mon, 25 May 2020 17:24:02 +0200
Date:   Mon, 25 May 2020 17:24:01 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 02/25] mm/swap: Don't abuse the seqcount latching API
Message-ID: <20200525152401.GA375786@debian-buster-darwi.lab.linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-3-a.darwish@linutronix.de>
 <20200522145707.GO325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522145707.GO325280@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, May 19, 2020 at 11:45:24PM +0200, Ahmed S. Darwish wrote:
> > @@ -713,10 +713,20 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
> >   */
> >  void lru_add_drain_all(void)
> >  {
>

Re-adding cut-out comment for context:

	/*
	 * lru_drain_gen - Current generation of pages that could be in vectors
	 *
	 * (A) Definition: lru_drain_gen = x implies that all generations
	 *     0 < n <= x are already scheduled for draining.
	 *
	 * This is an optimization for the highly-contended use case where a
	 * user space workload keeps constantly generating a flow of pages
	 * for each CPU.
	 */
> > +	static unsigned int lru_drain_gen;
> >  	static struct cpumask has_work;
> > +	static DEFINE_MUTEX(lock);
> > +	int cpu, this_gen;
> >
> >  	/*
> >  	 * Make sure nobody triggers this path before mm_percpu_wq is fully
> > @@ -725,21 +735,48 @@ void lru_add_drain_all(void)
> >  	if (WARN_ON(!mm_percpu_wq))
> >  		return;
> >
>

Re-adding cut-out comment for context:

	/*
	 * (B) Cache the LRU draining generation number
	 *
	 * smp_rmb() ensures that the counter is loaded before the mutex is
	 * taken. It pairs with the smp_wmb() inside the mutex critical section
	 * at (D).
	 */
> > +	this_gen = READ_ONCE(lru_drain_gen);
> > +	smp_rmb();
>
> 	this_gen = smp_load_acquire(&lru_drain_gen);

ACK. will do.

> >
> >  	mutex_lock(&lock);
> >
> >  	/*
> > +	 * (C) Exit the draining operation if a newer generation, from another
> > +	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
> >  	 */
> > +	if (unlikely(this_gen != lru_drain_gen))
> >  		goto done;
> >
>

Re-adding cut-out comment for context:

	/*
	 * (D) Increment generation number
	 *
	 * Pairs with READ_ONCE() and smp_rmb() at (B), outside of the critical
	 * section.
	 *
	 * This pairing must be done here, before the for_each_online_cpu loop
	 * below which drains the page vectors.
	 *
	 * Let x, y, and z represent some system CPU numbers, where x < y < z.
	 * Assume CPU #z is is in the middle of the for_each_online_cpu loop
	 * below and has already reached CPU #y's per-cpu data. CPU #x comes
	 * along, adds some pages to its per-cpu vectors, then calls
	 * lru_add_drain_all().
	 *
	 * If the paired smp_wmb() below is done at any later step, e.g. after
	 * the loop, CPU #x will just exit at (C) and miss flushing out all of
	 * its added pages.
	 */
> > +	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
> > +	smp_wmb();
>
> You can leave this smp_wmb() out and rely on the smp_mb() implied by
> queue_work_on()'s test_and_set_bit().
>

Won't this be too implicit?

Isn't it possible that, over the years, queue_work_on() impementation
changes and the test_and_set_bit()/smp_mb() gets removed?

If that happens, this commit will get *silently* broken and the local
CPU pages won't be drained.

> >  	cpumask_clear(&has_work);
> > -
> >  	for_each_online_cpu(cpu) {
> >  		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
> >
>
> While you're here, do:
>
> 	s/cpumask_set_cpu/__&/
>

ACK.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
