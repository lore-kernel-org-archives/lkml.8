Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C128C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F20820721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q1TDVwTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgBCNoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:44:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40024 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgBCNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zC2sfBamRXFijFFdsN6r4tMmtKI3cYN3Dfgalrla30w=; b=q1TDVwTzDcYYDYypZnLZ2+GU9k
        t9W908W9s3cOx4ZPfrECNoheBCZ8ja/+59IVucwNie6MquCJNnMq/jhBtLD2DwhGkWN8DLr17YLok
        UleYcUFOz7vBfD6TQffQSagkNpQn/VXGa973ShiM/paBDQsabwuoPLZWU5F83ulAQ8my0Sse78NJg
        2aR1Y0+7oqBKi3CM8WhekXGtspUU5HyCblJzwrgA8LifWJaWmjjAkTf2ZYDJNujPe/McB3t4HL+Vw
        p4WG81hAjNkMmT5IYLe5pi5FRiEMnTilqyVgBhW3OJ4jBf4d672tZt9XuWnQGbcUnVogQIdzb+HyJ
        Qd+/puwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyc1t-0004nN-4p; Mon, 03 Feb 2020 13:44:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B95C3300E0C;
        Mon,  3 Feb 2020 14:42:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C943A2B63D24F; Mon,  3 Feb 2020 14:44:41 +0100 (CET)
Date:   Mon, 3 Feb 2020 14:44:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: Re: [PATCH -v2 5/7] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20200203134441.GI14914@hirez.programming.kicks-ass.net>
References: <20200131150703.194229898@infradead.org>
 <20200131151540.155211856@infradead.org>
 <7a876b46-b80c-1164-d139-6026adcb222c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a876b46-b80c-1164-d139-6026adcb222c@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Mon, Feb 03, 2020 at 02:45:16PM +0300, Kirill Tkhai wrote:

> Maybe, this is not a subject of this patchset. But since this is a newborn function,
> can we introduce it to save one unneeded wake_up of writer? This is a situation,
> when writer becomes woken up just to write itself into sem->writer.task.
> 
> Something like below:
> 
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index a136677543b4..e4f88bfd43ed 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -9,6 +9,8 @@
>  #include <linux/sched/task.h>
>  #include <linux/errno.h>
>  
> +static bool readers_active_check(struct percpu_rw_semaphore *sem);
> +
>  int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
>  			const char *name, struct lock_class_key *key)
>  {
> @@ -101,6 +103,16 @@ static bool __percpu_rwsem_trylock(struct percpu_rw_semaphore *sem, bool reader)
>  	return __percpu_down_write_trylock(sem);
>  }
>  
> +static void queue_sem_writer(struct percpu_rw_semaphore *sem, struct task_struct *p)
> +{
> +	rcu_assign_pointer(sem->writer.task, p);
> +	smp_mb();
> +	if (readers_active_check(sem)) {
> +		WRITE_ONCE(sem->writer.task, NULL);
> +		wake_up_process(p);
> +	}
> +}
> +
>  /*
>   * The return value of wait_queue_entry::func means:
>   *
> @@ -129,7 +141,11 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
>  	list_del_init(&wq_entry->entry);
>  	smp_store_release(&wq_entry->private, NULL);
>  
> -	wake_up_process(p);
> +	if (reader || readers_active_check(sem))
> +		wake_up_process(p);
> +	else
> +		queue_sem_writer(sem, p);
> +
>  	put_task_struct(p);
>  
>  	return !reader; /* wake (readers until) 1 writer */
> @@ -247,8 +263,11 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
>  	 * them.
>  	 */
>  
> -	/* Wait for all active readers to complete. */
> -	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
> +	if (rcu_access_pointer(sem->writer.task))
> +		WRITE_ONCE(sem->writer.task, NULL);
> +	else
> +		/* Wait for all active readers to complete. */
> +		rcuwait_wait_event(&sem->writer, readers_active_check(sem));
>  }
>  EXPORT_SYMBOL_GPL(percpu_down_write);
>  
> Just an idea, completely untested.

Hurm,.. I think I see what you're proposing. I also think your immediate
patch is racy, consider for example what happens if your
queue_sem_writer() finds !readers_active_check(), such that we do in
fact need to wait. Then your percpu_down_write() will find
sem->writer.task and clear it -- no waiting.

Also, I'm not going to hold up these patches for this, we can always do
this on top.

Still, let me consider this a little more.
