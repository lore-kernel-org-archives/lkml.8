Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B99AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA2A2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sWSVtKWx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uZEZ8hQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGNItg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:49:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4582C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:49:35 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:49:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594716573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxxJabfXBdmkDeRUYI7JOQ08QQCOa1D9VqkTENSXrQI=;
        b=sWSVtKWxC7DdBe50wdjSFKEVu+rMxfuCGv8NcELxYUA+B7FHNUEGALieg7turgmA4j/LVG
        1TwUCGF+wshLWfhMagjCbSxKOg3ica4saXgvgZLTF5SfcPASMTw2buDdPpBRtbhij3pJuW
        wwLOHe1KMncWCYSoWOFnDHNMQ/EfOlc25Fb+jeABGHvO5VOjsknG2rpmf9S6upz7tAXFjf
        K1aByck4a/uDdOBZJ0TskhBszrWw+K7xqkw2s/A6IeWmKOibnRR9HsSCFBmblg2/2QEjly
        l5n4dvq3BykLoehjgVfRfCXCJYyzKam3xG/fVietdoW76pfla/D9Fw4lQrgvZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594716573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxxJabfXBdmkDeRUYI7JOQ08QQCOa1D9VqkTENSXrQI=;
        b=uZEZ8hQH7+kHqmNjv/VHv6Hp0zYV54bMmgBGyNrh5TJCWulyFVLGgLEw21vUDfKrgTdOe0
        kVJ3x1y/t9zW3fCQ==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 4/9] timers: Always keep track of next expiry
In-Reply-To: <20200707013253.26770-5-frederic@kernel.org>
Message-ID: <alpine.DEB.2.21.2007141037490.1386@somnus>
References: <20200707013253.26770-1-frederic@kernel.org> <20200707013253.26770-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Tue, 7 Jul 2020, Frederic Weisbecker wrote:

> So far next expiry was only tracked while the CPU was in nohz_idle mode
> in order to cope with missing ticks that can't increment the base->clk
> periodically anymore.
> 
> We are going to expand that logic beyond nohz in order to spare timers
> softirqs so do it unconditionally.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/time/timer.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index acf7cb8c09f8..8a4138e47aa4 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -558,8 +558,22 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
>  	 * timer is not deferrable. If the other CPU is on the way to idle
>  	 * then it can't set base->is_idle as we hold the base lock:
>  	 */
> -	if (!base->is_idle)
> -		return;
> +	if (base->is_idle)
> +		wake_up_nohz_cpu(base->cpu);
> +}
> +
> +/*
> + * Enqueue the timer into the hash bucket, mark it pending in
> + * the bitmap and store the index in the timer flags.
> + */
> +static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
> +			  unsigned int idx)
> +{
> +	hlist_add_head(&timer->entry, base->vectors + idx);
> +	__set_bit(idx, base->pending_map);
> +	timer_set_idx(timer, idx);
> +
> +	trace_timer_start(timer, timer->expires, timer->flags);
>  
>  	/* Check whether this is the new first expiring timer: */
>  	if (time_after_eq(timer->expires, base->next_expiry))
> @@ -578,21 +592,7 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
>  	} else {
>  		base->next_expiry = timer->expires;
>  	}
> -	wake_up_nohz_cpu(base->cpu);
> -}
>  
> -/*
> - * Enqueue the timer into the hash bucket, mark it pending in
> - * the bitmap and store the index in the timer flags.
> - */
> -static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
> -			  unsigned int idx)
> -{
> -	hlist_add_head(&timer->entry, base->vectors + idx);
> -	__set_bit(idx, base->pending_map);
> -	timer_set_idx(timer, idx);
> -
> -	trace_timer_start(timer, timer->expires, timer->flags);
>  	trigger_dyntick_cpu(base, timer);
>  }
>  

Could you please split those two hunks which do only a restructuring into a
separate patch?

Thanks,

	Anna-Maria

