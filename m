Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC38C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E50D2224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHGUe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGUeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:34:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C8920866;
        Fri,  7 Aug 2020 20:34:24 +0000 (UTC)
Date:   Fri, 7 Aug 2020 16:34:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, will@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
        paulmck@kernel.org, rjw@rjwysocki.net
Subject: Re: [RFC][PATCH 3/3] lockdep,trace: Expose tracepoints
Message-ID: <20200807163422.02bae823@oasis.local.home>
In-Reply-To: <20200807193018.160331394@infradead.org>
References: <20200807192336.405068898@infradead.org>
        <20200807193018.160331394@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 21:23:39 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> The lockdep tracepoints are under the lockdep recursion counter, this
> has a bunch of nasty side effects:
> 
>  - TRACE_IRQFLAGS doesn't work across the entire tracepoint, leading to
>    all sorts of dodgy complaints.
> 
>  - RCU-lockdep doesn't see the tracepoints either, hiding numerous
>    "suspicious RCU usage" warnings.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/lockdep.c |   27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5000,8 +5000,9 @@ void lock_acquire(struct lockdep_map *lo
>  	raw_local_irq_save(flags);
>  	check_flags(flags);
>  
> -	current->lockdep_recursion++;
>  	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
> +
> +	current->lockdep_recursion++;
>  	__lock_acquire(lock, subclass, trylock, read, check,
>  		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
>  	lockdep_recursion_finish();
> @@ -5016,10 +5017,13 @@ void lock_release(struct lockdep_map *lo
>  	if (unlikely(current->lockdep_recursion))
>  		return;
>  
> +

Superfluous space.
 

Other than that:

Reviewed-by: Steven Rosted (VMware) <rostedt@goodmis.org>

-- Steve

>  	raw_local_irq_save(flags);
>  	check_flags(flags);
> -	current->lockdep_recursion++;
> +
>  	trace_lock_release(lock, ip);
> +
> +	current->lockdep_recursion++;
>  	if (__lock_release(lock, ip))
>  		check_chain_key(current);
>  	lockdep_recursion_finish();
> @@ -5171,7 +5175,7 @@ __lock_contended(struct lockdep_map *loc
>  		stats->bounces[bounce_contended + !!hlock->read]++;
>  }
>  
