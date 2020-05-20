Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFDBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028C4207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="rUVxQPbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgETMWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:22:20 -0400
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C607C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:22:20 -0700 (PDT)
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id A042A2E15B6;
        Wed, 20 May 2020 15:22:18 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id RHZB8Jy9ID-MGd0Xjff;
        Wed, 20 May 2020 15:22:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1589977338; bh=fWlELSchNbK6X8WY/LIEnxOeuh7ut5C9pJiR7sPpmL4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=rUVxQPbCa/3movkIPbwhwJovtico490x0cE7XdLEsHZQnLaUYW+pTRlQRpRn8/iwU
         SwZNBoMivSRY67RYcygcwS9TDCquOKNDRXOInxSLhkrIVEOhF2EzUU/7eUwTK2ozNJ
         Y+kQrnHFNE8mhbwf9qHviU4i9RzIkhZGNAH3lRtI=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:704::1:9])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id g13KAeIdih-MGWCL2v2;
        Wed, 20 May 2020 15:22:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v1 02/25] mm/swap: Don't abuse the seqcount latching API
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-3-a.darwish@linutronix.de>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <706c697c-c951-e0c3-40f8-f6e429b2226a@yandex-team.ru>
Date:   Wed, 20 May 2020 15:22:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519214547.352050-3-a.darwish@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2020 00.45, Ahmed S. Darwish wrote:
> Commit eef1a429f234 ("mm/swap.c: piggyback lru_add_drain_all() calls")
> implemented an optimization mechanism to exit the to-be-started LRU
> drain operation (name it A) if another drain operation *started and
> finished* while (A) was blocked on the LRU draining mutex.
> 
> This was done through a seqcount latch, which is an abuse of its
> semantics:
> 
>    1. Seqcount latching should be used for the purpose of switching
>       between two storage places with sequence protection to allow
>       interruptible, preemptible writer sections. The optimization
>       mechanism has absolutely nothing to do with that.
> 
>    2. The used raw_write_seqcount_latch() has two smp write memory
>       barriers to always insure one consistent storage place out of the
>       two storage places available. This extra smp_wmb() is redundant for
>       the optimization use case.
> 
> Beside the API abuse, the semantics of a latch sequence counter was
> force fitted into the optimization. What was actually meant is to track
> generations of LRU draining operations, where "current lru draining
> generation = x" implies that all generations 0 < n <= x are already
> *scheduled* for draining.
> 
> Remove the conceptually-inappropriate seqcount latch usage and manually
> implement the optimization using a counter and SMP memory barriers.

Well, I thought it fits perfectly =)

Maybe it's worth to add helpers with appropriate semantics?
This is pretty common pattern.

> 
> Link: https://lkml.kernel.org/r/CALYGNiPSr-cxV9MX9czaVh6Wz_gzSv3H_8KPvgjBTGbJywUJpA@mail.gmail.com
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> ---
>   mm/swap.c | 57 +++++++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index bf9a79fed62d..d6910eeed43d 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -713,10 +713,20 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
>    */
>   void lru_add_drain_all(void)
>   {
> -	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
> -	static DEFINE_MUTEX(lock);
> +	/*
> +	 * lru_drain_gen - Current generation of pages that could be in vectors
> +	 *
> +	 * (A) Definition: lru_drain_gen = x implies that all generations
> +	 *     0 < n <= x are already scheduled for draining.
> +	 *
> +	 * This is an optimization for the highly-contended use case where a
> +	 * user space workload keeps constantly generating a flow of pages
> +	 * for each CPU.
> +	 */
> +	static unsigned int lru_drain_gen;
>   	static struct cpumask has_work;
> -	int cpu, seq;
> +	static DEFINE_MUTEX(lock);
> +	int cpu, this_gen;
>   
>   	/*
>   	 * Make sure nobody triggers this path before mm_percpu_wq is fully
> @@ -725,21 +735,48 @@ void lru_add_drain_all(void)
>   	if (WARN_ON(!mm_percpu_wq))
>   		return;
>   
> -	seq = raw_read_seqcount_latch(&seqcount);
> +	/*
> +	 * (B) Cache the LRU draining generation number
> +	 *
> +	 * smp_rmb() ensures that the counter is loaded before the mutex is
> +	 * taken. It pairs with the smp_wmb() inside the mutex critical section
> +	 * at (D).
> +	 */
> +	this_gen = READ_ONCE(lru_drain_gen);
> +	smp_rmb();
>   
>   	mutex_lock(&lock);
>   
>   	/*
> -	 * Piggyback on drain started and finished while we waited for lock:
> -	 * all pages pended at the time of our enter were drained from vectors.
> +	 * (C) Exit the draining operation if a newer generation, from another
> +	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
>   	 */
> -	if (__read_seqcount_retry(&seqcount, seq))
> +	if (unlikely(this_gen != lru_drain_gen))
>   		goto done;
>   
> -	raw_write_seqcount_latch(&seqcount);
> +	/*
> +	 * (D) Increment generation number
> +	 *
> +	 * Pairs with READ_ONCE() and smp_rmb() at (B), outside of the critical
> +	 * section.
> +	 *
> +	 * This pairing must be done here, before the for_each_online_cpu loop
> +	 * below which drains the page vectors.
> +	 *
> +	 * Let x, y, and z represent some system CPU numbers, where x < y < z.
> +	 * Assume CPU #z is is in the middle of the for_each_online_cpu loop
> +	 * below and has already reached CPU #y's per-cpu data. CPU #x comes
> +	 * along, adds some pages to its per-cpu vectors, then calls
> +	 * lru_add_drain_all().
> +	 *
> +	 * If the paired smp_wmb() below is done at any later step, e.g. after
> +	 * the loop, CPU #x will just exit at (C) and miss flushing out all of
> +	 * its added pages.
> +	 */
> +	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
> +	smp_wmb();
>   
>   	cpumask_clear(&has_work);
> -
>   	for_each_online_cpu(cpu) {
>   		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
>   
> @@ -766,7 +803,7 @@ void lru_add_drain_all(void)
>   {
>   	lru_add_drain();
>   }
> -#endif
> +#endif /* CONFIG_SMP */
>   
>   /**
>    * release_pages - batched put_page()
> 
