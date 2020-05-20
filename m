Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF6AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332C3207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jTnoWPWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgETM3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:29:51 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BFBC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:29:51 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d7so2282622qtn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gLsfEuBByJJ7dCDrAvPQMezrYld8qlmG1Yg21K/T1F4=;
        b=jTnoWPWPrn1cH2mRULwKtugWBw37GcAzioZAUYuoTtZ4yDDwFR7g7O3LozaE2sTKYo
         5XoQQYcbamNfssPv6RA2KCDdtsbtA/P+uIN5cqJKQF30IJoZg0twJivSEadMZWK+Mcxe
         KO8XTFubiMVQIt0q0tG1snFEAytrpWUix/TM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gLsfEuBByJJ7dCDrAvPQMezrYld8qlmG1Yg21K/T1F4=;
        b=tim41dkpAMoqCVjbFZT6jYxgYJMsYBh0c0N9vrxnQo71CG7JkZddtxhsSmoUW9v/Jd
         5lYCUMIu5jyqbuuszGc/aQtKTd+uVko8yMiOUQjf+nMY7K4wxPgoJxE5NzSpnHogY/Ev
         8DTgiC9n29mu2aK5BD66+CQ4/X1CMGoRjoGij4HBzgsPizBvr+cDmU7WpTi8WJ4CbfhA
         lSurC52PXkXZV2oMnJxBf9QvJFQOiuRLEu0xXk6tiuK/8hxYHGtos0J16xB2IpBu9zrK
         SbNi/L09eVWVmaCIQozj2He8ixQqk1PZgakNGEB/7NnEMhY/Mn4EHo2s8UXjGbUattpz
         Z+pQ==
X-Gm-Message-State: AOAM531TUFCdoqbh/1iIBnCApC1NeSSD/FXN/80w28F6FOMg7bSWoEQ4
        1EEzCTsRCteHN4OmYLNQjPNMrQ==
X-Google-Smtp-Source: ABdhPJx39Jmypmux/XZQcDswfaSeTiv3yz3bER/JWeV7gpYGwuFT62vD/Y+xmacLrASw8TvNRr4ovA==
X-Received: by 2002:ac8:c8b:: with SMTP id n11mr5108723qti.49.1589977790879;
        Wed, 20 May 2020 05:29:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m1sm2415383qtf.72.2020.05.20.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 05:29:50 -0700 (PDT)
Date:   Wed, 20 May 2020 08:29:49 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200520122949.GB16672@google.com>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164714.22557-2-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:47:05PM +0200, Frederic Weisbecker wrote:
> Pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
> timers) can unconditionally lock rdp->nocb_lock as they always execute
> in the context of an offloaded rdp.
> 
> This also prepare for toggling CPUs to/from callback's offloaded mode
> where the offloaded state will possibly change when rdp->nocb_lock
> isn't taken. We'll still want the entrypoints to lock the rdp in any
> case.

Suggested rewrite for change log:
<wordsmithing>
Make pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
timers) unconditionally lock rdp->nocb_lock as they always execute in the
context of an offloaded rdp.

This prepares for future toggling of CPUs to/from callback's offloaded mode
where the offloaded state can change when rdp->nocb_lock is not held. We'll
still want the entrypoints to lock the rdp in any case.
</wordsmithing>

Also, can we inline rcu_nocb_lock_irqsave() into
do_nocb_deferred_wakeup_common() since that's the only user, and then delete
rcu_nocb_lock_irqsave() and the corresponding unlock? That would also remove
confusion about which API to use for nocb locking (i.e. whether to directly
acquire lock or call rcu_nocb_lock_irqsave()).

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_plugin.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 097635c41135..523570469864 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1909,7 +1909,7 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
>  	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
>  
>  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
> -	rcu_nocb_lock_irqsave(rdp, flags);
> +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
>  	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
>  	__call_rcu_nocb_wake(rdp, true, flags);
>  }
> @@ -1942,7 +1942,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	 */
>  	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> -		rcu_nocb_lock_irqsave(rdp, flags);
> +		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
>  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>  		if (bypass_ncbs &&
>  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> @@ -1951,7 +1951,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  			(void)rcu_nocb_try_flush_bypass(rdp, j);
>  			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
> -			rcu_nocb_unlock_irqrestore(rdp, flags);
> +			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
>  			continue; /* No callbacks here, try next. */
>  		}
>  		if (bypass_ncbs) {
> @@ -1996,7 +1996,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  		} else {
>  			needwake = false;
>  		}
> -		rcu_nocb_unlock_irqrestore(rdp, flags);
> +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
>  		if (needwake) {
>  			swake_up_one(&rdp->nocb_cb_wq);
>  			gotcbs = true;
> @@ -2084,7 +2084,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>  	rcu_do_batch(rdp);
>  	local_bh_enable();
>  	lockdep_assert_irqs_enabled();
> -	rcu_nocb_lock_irqsave(rdp, flags);
> +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
>  	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
>  	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
>  	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
> @@ -2092,7 +2092,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>  		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
>  	}
>  	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
> -		rcu_nocb_unlock_irqrestore(rdp, flags);
> +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
>  		if (needwake_gp)
>  			rcu_gp_kthread_wake();
>  		return;
> @@ -2100,7 +2100,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>  
>  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
>  	WRITE_ONCE(rdp->nocb_cb_sleep, true);
> -	rcu_nocb_unlock_irqrestore(rdp, flags);
> +	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
>  	if (needwake_gp)
>  		rcu_gp_kthread_wake();
>  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> -- 
> 2.25.0
> 
