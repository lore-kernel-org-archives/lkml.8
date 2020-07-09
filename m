Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29273C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A0720774
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBlspvbI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKU5ebe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGIMRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGIMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:17:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D923C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 05:17:38 -0700 (PDT)
Date:   Thu, 9 Jul 2020 14:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594297055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9/XX5HXM2ll8OjdCHVTJjYmYRVPDW/XbrVT+FdrMNw=;
        b=OBlspvbIUcaBak4Y1ndWpexkjNjSW75cNJrVdxsOjjbwduC27L6mt9Bxr6WtvIhaMOaSCQ
        2fFAadDPlC7IciFYsH6nzMUVEsVzQ+Ij2eMKkG4QsbKLDgKI4YGjtDQj+8Li39FaNxMudQ
        NLDYYDGY51p0S2e502a1Q+6JY7/v4i+uC+nhc3+W4SaSXfv8wCiBR9j/UYR22qIGjtAkj8
        rViVMVQFfr5l+silHtw2IkuFAFdhjpu3ypvaqgqvoFu7lGb50GaadaiD3TO33p79mpm0pI
        jG3XlDtxan9E/udJu17u2HPGY3aZy3k/AjLV8EdM6l3sidhQcBZoON7flPWGfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594297055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9/XX5HXM2ll8OjdCHVTJjYmYRVPDW/XbrVT+FdrMNw=;
        b=xKU5ebe2U8GVpH9dgXDqKX5CtTQAvp7hhdSySYNDPsCLrSxxVZfYgCH3rS4f4cCBxiFWJG
        bQwDiEMlAVGQfeCA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 1/9] timer: Move trigger_dyntick_cpu() to
 enqueue_timer()
In-Reply-To: <20200707013253.26770-2-frederic@kernel.org>
Message-ID: <alpine.DEB.2.21.2007091312340.4020@somnus>
References: <20200707013253.26770-1-frederic@kernel.org> <20200707013253.26770-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Tue, 7 Jul 2020, Frederic Weisbecker wrote:

> Consolidate the code by calling trigger_dyntick_cpu() from
> enqueue_timer() instead of calling it from all its callers.

Looks good, but maybe you could also update the comments in the code (see
remarks below)?

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/time/timer.c | 46 +++++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 9a838d38dbe6..4c977df3610b 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -596,13 +573,29 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
>  	wake_up_nohz_cpu(base->cpu);
>  }
>  
> -static void
> -internal_add_timer(struct timer_base *base, struct timer_list *timer)
> +/*
> + * Enqueue the timer into the hash bucket, mark it pending in
> + * the bitmap and store the index in the timer flags.
> + */

enqueue_timer() also calls trigger_dyntick_cpu().

> +static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
> +			  unsigned int idx)
>  {
> -	__internal_add_timer(base, timer);
> +	hlist_add_head(&timer->entry, base->vectors + idx);
> +	__set_bit(idx, base->pending_map);
> +	timer_set_idx(timer, idx);
> +
> +	trace_timer_start(timer, timer->expires, timer->flags);
>  	trigger_dyntick_cpu(base, timer);
>  }
>  
> +static void internal_add_timer(struct timer_base *base, struct timer_list *timer)
> +{
> +	unsigned int idx;
> +
> +	idx = calc_wheel_index(timer->expires, base->clk);
> +	enqueue_timer(base, timer, idx);
> +}
> +
>  #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
>  
>  static struct debug_obj_descr timer_debug_descr;
> @@ -1059,7 +1052,6 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
>  	 */

The comment above still mentions that trigger_dyntick_cpu() is called which
is now part of enqueue_timer(). Might be a little confusing.

>  	if (idx != UINT_MAX && clk == base->clk) {
>  		enqueue_timer(base, timer, idx);
> -		trigger_dyntick_cpu(base, timer);
>  	} else {
>  		internal_add_timer(base, timer);
>  	}


Thanks,

	Anna-Maria
