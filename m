Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD14207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbgEYQKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388556AbgEYQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:10:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA83C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:10:50 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jdFgY-00059p-Mv; Mon, 25 May 2020 18:10:43 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 02/25] mm/swap: Don't abuse the seqcount latching API
References: <20200519214547.352050-1-a.darwish@linutronix.de>
        <20200519214547.352050-3-a.darwish@linutronix.de>
        <20200522145707.GO325280@hirez.programming.kicks-ass.net>
Date:   Mon, 25 May 2020 18:10:40 +0200
In-Reply-To: <20200522145707.GO325280@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 22 May 2020 16:57:07 +0200")
Message-ID: <87y2pg9erj.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi,

This optimization is broken. The main concern here: Is it possible that
lru_add_drain_all() _would_ have drained pagevec X, but then aborted
because another lru_add_drain_all() is underway and that other task will
_not_ drain pagevec X? I claim the answer is yes!

My suggested changes are inline below.

I attached a litmus test to verify it.

On 2020-05-22, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, May 19, 2020 at 11:45:24PM +0200, Ahmed S. Darwish wrote:
>> @@ -713,10 +713,20 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
>>   */
>>  void lru_add_drain_all(void)
>>  {
>
>> +	static unsigned int lru_drain_gen;
>>  	static struct cpumask has_work;
>> +	static DEFINE_MUTEX(lock);
>> +	int cpu, this_gen;
>>  
>>  	/*
>>  	 * Make sure nobody triggers this path before mm_percpu_wq is fully
>> @@ -725,21 +735,48 @@ void lru_add_drain_all(void)
>>  	if (WARN_ON(!mm_percpu_wq))
>>  		return;
>>  

An smp_mb() is needed here.

	/*
	 * Guarantee the pagevec counter stores visible by
	 * this CPU are visible to other CPUs before loading
	 * the current drain generation.
	 */
	smp_mb();

>> +	this_gen = READ_ONCE(lru_drain_gen);
>> +	smp_rmb();
>
> 	this_gen = smp_load_acquire(&lru_drain_gen);
>>  
>>  	mutex_lock(&lock);
>>  
>>  	/*
>> +	 * (C) Exit the draining operation if a newer generation, from another
>> +	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
>>  	 */
>> +	if (unlikely(this_gen != lru_drain_gen))
>>  		goto done;
>>  
>
>> +	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
>> +	smp_wmb();

Instead of smp_wmb(), this needs to be a full memory barrier.

	/*
	 * Guarantee the new drain generation is stored before
	 * loading the pagevec counters.
	 */
	smp_mb();

> You can leave this smp_wmb() out and rely on the smp_mb() implied by
> queue_work_on()'s test_and_set_bit().
>
>>  	cpumask_clear(&has_work);
>> -
>>  	for_each_online_cpu(cpu) {
>>  		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
>>  
>
> While you're here, do:
>
> 	s/cpumask_set_cpu/__&/
>
>> @@ -766,7 +803,7 @@ void lru_add_drain_all(void)
>>  {
>>  	lru_add_drain();
>>  }
>> -#endif
>> +#endif /* CONFIG_SMP */
>>  
>>  /**
>>   * release_pages - batched put_page()

For the litmus test:

1:rx=0             (P1 did not see the pagevec counter)
2:rx=1             (P2 _would_ have seen the pagevec counter)
2:ry1=0 /\ 2:ry2=1 (P2 aborted due to optimization)

Changing the smp_mb() back to smp_wmb() in P1 and removing the smp_mb()
in P2 represents this patch. And it shows that sometimes P2 will abort
even though it would have drained the pagevec and P1 did not drain the
pagevec.

This is ugly as hell. And there maybe other memory barrier types to make
it pretty. But as is, memory barriers are missing.

John Ogness


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=lru_add_drain_all.litmus

C lru_add_drain_all

(*
 * x is a pagevec counter
 * y is @lru_drain_gen
 * z is @lock
 *)

{ }

P0(int *x)
{
	// mark pagevec for draining
	WRITE_ONCE(*x, 1);
}

P1(int *x, int *y, int *z)
{
	int rx;
	int rz;

	// mutex_lock(&lock);
	rz = cmpxchg_acquire(z, 0, 1);
	if (rz == 0) {

		// WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
		WRITE_ONCE(*y, 1);

		// guarantee lru_drain_gen store before loading pagevec
		smp_mb();

		// if (pagevec_count(...))
		rx = READ_ONCE(*x);

		// mutex_unlock(&lock);
		rz = cmpxchg_release(z, 1, 2);
	}
}

P2(int *x, int *y, int *z)
{
	int rx;
	int ry1;
	int ry2;
	int rz;

	// the pagevec counter as visible now to this CPU
	rx = READ_ONCE(*x);

	// guarantee pagevec store before loading lru_drain_gen
	smp_mb();

	// this_gen = READ_ONCE(lru_drain_gen); smp_rmb();
	ry1 = smp_load_acquire(y);

	// mutex_lock(&lock) - acquired after P1
	rz = cmpxchg_acquire(z, 2, 3);
	if (rz == 2) {

		// if (unlikely(this_gen != lru_drain_gen))
		ry2 = READ_ONCE(*y);
	}
}

locations [x; y; z]
exists (1:rx=0 /\ 2:rx=1 /\ 2:ry1=0 /\ 2:ry2=1)

--=-=-=--
