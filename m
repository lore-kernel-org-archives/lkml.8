Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828E4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42390208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599075825;
	bh=LV44U5Bug3fmrofspGne+fm9i9nDhwK6TWX3gfFZUbc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ooml3x1Yo6dICZfxs0IbvBnC3h/SJAvT/hLv+SDsZrTRBFqjG1t+7qB0Re/s40REz
	 7+rkwYNq7M9MF1NWqPz/m04rXiKcyNFdnO+8c1+vz7wAvg1sCW4udBrnqFXHpxyQjS
	 3DM1rvRXMejXplHa/q2dfz9rEw7MM7Z4nPjVErkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBTnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBTnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:43:42 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 202692083B;
        Wed,  2 Sep 2020 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599075822;
        bh=LV44U5Bug3fmrofspGne+fm9i9nDhwK6TWX3gfFZUbc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ql3kuNFy3qZ5w7RYXya2aGz/L0paD5+UUDjH8JG9QDmbOOT+IWhE1r76pQafbQ9EI
         hke+ltK5+2/UH3yKDTIT50b7MIXvGsqQ4i3uJBdZnt1bSUzBVyw94Q/AxW5sZK/LIS
         RZ/s7/0IUWihhb+kOsCsbT1iijLEEk0rXKA6UQMA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E88B5352260D; Wed,  2 Sep 2020 12:43:41 -0700 (PDT)
Date:   Wed, 2 Sep 2020 12:43:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, frederic@kernel.org,
        joel@joelfernandes.org
Subject: Re: [PATCH] lockdep: Fix "USED" <- "IN-NMI" inversions
Message-ID: <20200902194341.GK29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200902160323.GK1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902160323.GK1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:03:23PM +0200, peterz@infradead.org wrote:
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
> 
> Fixes: f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thank you for looking into this!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

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
