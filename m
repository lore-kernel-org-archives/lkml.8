Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D603C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A3F2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599100372;
	bh=WDcgb4OPfW9oJCLvkpEf5XVytpZGc7C+Vnhov/lxzCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kHRc1i8vZhDHAc2OnGMA30n6TDv0DuE1oaA9HAaILcxneAjJMBTtmSqdOgoT+LBS2
	 LP7Zrsq5DXa2ZVqBh9msqHDUzbvMoVBmS/NGdGgvNdpdS8GSu//09kYZNJhLfAAvBc
	 BDWuqJBQbHP89L1OHYAIQHq6v0YVW8uSwWvQirgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgICCcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICCcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:32:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD56D2072A;
        Thu,  3 Sep 2020 02:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599100365;
        bh=WDcgb4OPfW9oJCLvkpEf5XVytpZGc7C+Vnhov/lxzCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ynaIw1jaGGh4H7WLA0k2sndB56R659F5OcHwNf4M5hg05lOFC86D34RDvPGVtBjbs
         r7K3isMFz/cF08hR90pASAkZdxzpH/x1fqPJ4WWluzIdW44flv6ym4mVmW1+n42ATw
         Z72QtMrr+wsaKVPC+t6V3IC6TpsVrSKF1Eq8DAWw=
Date:   Thu, 3 Sep 2020 11:32:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, frederic@kernel.org,
        joel@joelfernandes.org
Subject: Re: [PATCH] lockdep: Fix "USED" <- "IN-NMI" inversions
Message-Id: <20200903113241.6770aa3b531509153fde3673@kernel.org>
In-Reply-To: <20200902160323.GK1362448@hirez.programming.kicks-ass.net>
References: <20200902160323.GK1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 18:03:23 +0200
peterz@infradead.org wrote:

> 
> During the LPC RCU BoF Paul asked how come the "USED" <- "IN-NMI"
> detector doesn't trip over rcu_read_lock()'s lockdep annotation.
> 
> Looking into this I found a very embarrasing typo in
> verify_lock_unused():
> 
> -	if (!(class->usage_mask & LOCK_USED))
> +	if (!(class->usage_mask & LOCKF_USED))
> 
> fixing that will indeed cause rcu_read_lock() to insta-splat :/
> 
> The above typo means that instead of testing for: 0x100 (1 <<
> LOCK_USED), we test for 8 (LOCK_USED), which corresponds to (1 <<
> LOCK_ENABLED_HARDIRQ).
> 
> So instead of testing for _any_ used lock, it will only match any lock
> used with interrupts enabled.
> 
> The rcu_read_lock() annotation uses .check=0, which means it will not
> set any of the interrupt bits and will thus never match.
> 
> In order to properly fix the situation and allow rcu_read_lock() to
> correctly work, split LOCK_USED into LOCK_USED and LOCK_USED_READ and by
> having .read users set USED_READ and test USED, pure read-recursive
> locks are permitted.

Confirmed this makes lockdep warnings on kretprobes spinlocks correctly.

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Note, if we backport this, we need to backport kretprobe lockless series too.

Thank you,

> 
> Fixes: f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index cccf4bc759c6..454355c033d2 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4324,13 +4324,18 @@ static int separate_irq_context(struct task_struct *curr,
>  static int mark_lock(struct task_struct *curr, struct held_lock *this,
>  			     enum lock_usage_bit new_bit)
>  {
> -	unsigned int new_mask = 1 << new_bit, ret = 1;
> +	unsigned int old_mask, new_mask, ret = 1;
>  
>  	if (new_bit >= LOCK_USAGE_STATES) {
>  		DEBUG_LOCKS_WARN_ON(1);
>  		return 0;
>  	}
>  
> +	if (new_bit == LOCK_USED && this->read)
> +		new_bit = LOCK_USED_READ;
> +
> +	new_mask = 1 << new_bit;
> +
>  	/*
>  	 * If already set then do not dirty the cacheline,
>  	 * nor do any checks:
> @@ -4343,13 +4348,22 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
>  	/*
>  	 * Make sure we didn't race:
>  	 */
> -	if (unlikely(hlock_class(this)->usage_mask & new_mask)) {
> -		graph_unlock();
> -		return 1;
> -	}
> +	if (unlikely(hlock_class(this)->usage_mask & new_mask))
> +		goto unlock;
>  
> +	old_mask = hlock_class(this)->usage_mask;
>  	hlock_class(this)->usage_mask |= new_mask;
>  
> +	/*
> +	 * Save one usage_traces[] entry and map both LOCK_USED and
> +	 * LOCK_USED_READ onto the same entry.
> +	 */
> +	if (new_bit == LOCK_USED || new_bit == LOCK_USED_READ) {
> +		if (old_mask & (LOCKF_USED | LOCKF_USED_READ))
> +			goto unlock;
> +		new_bit = LOCK_USED;
> +	}
> +
>  	if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
>  		return 0;
>  
> @@ -4363,6 +4377,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
>  			return 0;
>  	}
>  
> +unlock:
>  	graph_unlock();
>  
>  	/*
> @@ -5297,12 +5312,20 @@ static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock
>  {
>  #ifdef CONFIG_PROVE_LOCKING
>  	struct lock_class *class = look_up_lock_class(lock, subclass);
> +	unsigned long mask = LOCKF_USED;
>  
>  	/* if it doesn't have a class (yet), it certainly hasn't been used yet */
>  	if (!class)
>  		return;
>  
> -	if (!(class->usage_mask & LOCK_USED))
> +	/*
> +	 * READ locks only conflict with USED, such that if we only ever use
> +	 * READ locks, there is no deadlock possible -- RCU.
> +	 */
> +	if (!hlock->read)
> +		mask |= LOCKF_USED_READ;
> +
> +	if (!(class->usage_mask & mask))
>  		return;
>  
>  	hlock->class_idx = class - lock_classes;
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index baca699b94e9..b0be1560ed17 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -19,6 +19,7 @@ enum lock_usage_bit {
>  #include "lockdep_states.h"
>  #undef LOCKDEP_STATE
>  	LOCK_USED,
> +	LOCK_USED_READ,
>  	LOCK_USAGE_STATES
>  };
>  
> @@ -40,6 +41,7 @@ enum {
>  #include "lockdep_states.h"
>  #undef LOCKDEP_STATE
>  	__LOCKF(USED)
> +	__LOCKF(USED_READ)
>  };
>  
>  #define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE |


-- 
Masami Hiramatsu <mhiramat@kernel.org>
