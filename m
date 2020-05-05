Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD8C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037C8206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shq5FSdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgEEO1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729129AbgEEO1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:27:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42930C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:27:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so2579282wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FleO+nOaYnZz3mJeQhLXIVqEb3+xWR02IfE0ccMfCa0=;
        b=shq5FSdSXpFDt5lC2w/dzaKdwsZR8y4r3N9obS+YA7l1DKMYNlTWCYjelvDPp2Yl3Q
         2kMZY4VoNzg3vHAGhpTssC2GOIWbBMMjVxZ6e5STeXkJS5vF2wB2nLmYrwzR/YDxowcW
         VuThVppxkdErYypmIt4I3y+ib/cXkXQF/2FseH7LMYgvnrAvB5YnI1svgKhggQyb5lc+
         cv4LuAA6YR7VyGWZbiwp0Zmqhck5ykXnPQrBoyUIl4LQWFwSS105eLhA59ssXO5IJTT0
         U4gyrG/skYcd5dGocqRvTIxC8Qtk6MRN1kUWGxXsjN4qEjfCxksRWEYao0fwEoWEOxiW
         Jo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FleO+nOaYnZz3mJeQhLXIVqEb3+xWR02IfE0ccMfCa0=;
        b=WP6BQRzwz+kXHfiWN5FR5unUxXkBPgDGMExXZNm1rXgH7SaQjFBSRURpH+249YWzyP
         ZzlkkdSH0aEkv0yIh4qraFoqqdDUmaBn7m4Vc8II/5ri/yKQK83o38+4IigyveD6z7+g
         8uXMFux+inwq6vCFFilhlcX/Ruj2dYPA8Ug9iTx+1RQHmcEXD43a0Tw6lPuhR93W7+6+
         AFbgqJKDTBAxigjQgpAdDM//fFzkjwx7T4SnLT3rYunbAQE603wb5NMoAwvCYQC9hXb0
         QJ5UXqFs6IYz121YEcpSeSA9sUzy8yDQDGs+/IyxXfvFXgDhThkIkAXucuqo+BtJHPm8
         hPsQ==
X-Gm-Message-State: AGi0PubLecz9/UQXZwWDKmitOFkkgxi1+GRnX8gAsOe7i1cBUMWbN2vc
        i0hDbYyYj5iRWuO4K3zym38Nqg==
X-Google-Smtp-Source: APiQypJqhcptL6MA35sFTmL5tLEld6OAAT6mXpIFdiHoZDMpoEy6CAVME+iPmIpSa3rFZdfwzuCf9w==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr3559712wmi.52.1588688834696;
        Tue, 05 May 2020 07:27:14 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:14dc:461f:a2ef:f8d3])
        by smtp.gmail.com with ESMTPSA id r3sm3542051wrx.72.2020.05.05.07.27.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 07:27:13 -0700 (PDT)
Date:   Tue, 5 May 2020 16:27:11 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
Message-ID: <20200505142711.GA12952@vingu-book>
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
 <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 mai 2020 à 21:40:56 (+0800), Peng Liu a écrit :
> On Mon, May 04, 2020 at 05:17:11PM +0200, Vincent Guittot wrote:
> > On Sun, 3 May 2020 at 10:34, Peng Liu <iwtbavbm@gmail.com> wrote:
> > >
> > > commit c5afb6a87f23 ("sched/fair: Fix nohz.next_balance update")
> > > During idle load balance, this_cpu(ilb) do load balance for the other
> > > idle CPUs, also gather the earliest (nohz.)next_balance.
> > >
> > > Since commit:
> > >   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
> > >
> > > We update nohz.next_balance like this:
> > >
> > >   _nohz_idle_balance() {
> > >       for_each_cpu(nohz.idle_cpus_mask) {
> > >           rebalance_domains() {
> > >               update nohz.next_balance <-- compare and update
> > >           }
> > >       }
> > >       rebalance_domains(this_cpu) {
> > >           update nohz.next_balance <-- compare and update
> > >       }
> > >       update nohz.next_balance <-- unconditionally update
> > >   }
> > >
> > > For instance, nohz.idle_cpus_mask spans {cpu2,3,5,8}, and this_cpu is
> > > cpu5. After the above loop we could gather the earliest *next_balance*
> > > among {cpu2,3,8}, then rebalance_domains(this_cpu) update
> > > nohz.next_balance with this_rq->next_balance, but finally overwrite
> > > nohz.next_balance with the earliest *next_balance* among {cpu2,3,8},
> > > we may end up with not getting the earliest next_balance.
> > >
> > > Since we can gather all the updated rq->next_balance, including this_cpu,
> > > in _nohz_idle_balance(), it's safe to remove the extra lines in
> > > rebalance_domains() which are originally intended for this_cpu. And
> > > finally the updating only happen in _nohz_idle_balance().
> > 
> > I'm not sure that's always true. Nothing prevents nohz_idle_balance()
> > to return false . Then run_rebalance_domains() calls
> > rebalance_domains(this_rq ,SCHED_IDLE) outside _nohz_idle_balance().
> > In this case we must keep the code in rebalance_domains().
> > 
> > For example when the tick is not stopped when entering idle. Or when
> > need_resched() returns true.
> > 
> > So instead of removing the code from rebalance_domains, you should
> > move the one in _nohz_idle_balance() to make sure that the "if
> > (likely(update_next_balance)) ..." is called before calling
> > rebalance_domains for the local cpu
> > 
> 
> Yes, you're right. When need_resched() returns true, things become out
> of expectation. We haven't really got the earliest next_balance, abort
> the update immediately and let the successor to help. Doubtless this
> will incur some overhead due to the repeating work.

There should not be some repeating works because CPUs and sched_domain, which
have already been balanced, will not be rebalanced until the next load balance
interval.

Futhermore, there is in fact still work to do bcause not all the idle CPUs got
a chance to pull work

>
> 
> About the "tick is not stopped when entering idle" case, defer the
> update to nohz_balance_enter_idle() would be a choice too.
>
> 
> Of course, only update nohz.next_balance in rebalance_domains() is the
> simpliest way, but as @Valentin put, too many write to it may incur
> unnecessary overhead. If we can gather the earliest next_balance in

This is not really possible because we have to move it to the next interval.

> advance, then a single write is considered to be better.
> 
> By the way, remove the redundant check in nohz_idle_balance().
> 
> FWIW, how about the below?

Your proposal below looks quite complex. IMO, one solution would be to move the
update of nohz.next_balance before calling rebalance_domains(this_rq, CPU_IDLE)
so you are back to the previous behavior.

The only difference is that in case of an break because of need_resched, it
doesn't update nohz.next_balance. But on the other hand, we haven't yet
finished run rebalance_domains for all CPUs and some load_balance are still
pending. In fact, this will be done during next tick by an idle CPU.

So I would be in favor of something as simple as :

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04098d678f3b..e028bc1c4744 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10457,6 +10457,14 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
                }
        }

+       /*
+        * next_balance will be updated only when there is a need.
+        * When the CPU is attached to null domain for ex, it will not be
+        * updated.
+        */
+       if (likely(update_next_balance))
+               nohz.next_balance = next_balance;
+
        /* Newly idle CPU doesn't need an update */
        if (idle != CPU_NEWLY_IDLE) {
                update_blocked_averages(this_cpu);
@@ -10477,14 +10485,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
        if (has_blocked_load)
                WRITE_ONCE(nohz.has_blocked, 1);

-       /*
-        * next_balance will be updated only when there is a need.
-        * When the CPU is attached to null domain for ex, it will not be
-        * updated.
-        */
-       if (likely(update_next_balance))
-               nohz.next_balance = next_balance;
-
        return ret;
 }

> ***********************************************
> * Below code is !!!ENTIRELY UNTESTED!!!, just *
> * a draft to see whehter it's sensible!       *
> ***********************************************
> -------------------<-----------------------
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..a7d63ea706ac 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9943,22 +9943,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>  	 * When the cpu is attached to null domain for ex, it will not be
>  	 * updated.
>  	 */
> -	if (likely(update_next_balance)) {
> +	if (likely(update_next_balance))
>  		rq->next_balance = next_balance;
> -
> -#ifdef CONFIG_NO_HZ_COMMON
> -		/*
> -		 * If this CPU has been elected to perform the nohz idle
> -		 * balance. Other idle CPUs have already rebalanced with
> -		 * nohz_idle_balance() and nohz.next_balance has been
> -		 * updated accordingly. This CPU is now running the idle load
> -		 * balance for itself and we need to update the
> -		 * nohz.next_balance accordingly.
> -		 */
> -		if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
> -			nohz.next_balance = rq->next_balance;
> -#endif
> -	}
>  }
> 
>  static inline int on_null_domain(struct rq *rq)
> @@ -10218,6 +10204,9 @@ void nohz_balance_enter_idle(int cpu)
> 
>  	rq->nohz_tick_stopped = 1;
> 
> +	if (time_after(nohz.next_balance, rq->next_balance))
> +		nohz.next_balance = rq->next_balance;
> +
>  	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
>  	atomic_inc(&nohz.nr_cpus);
> 
> @@ -10287,6 +10276,7 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>  		 */
>  		if (need_resched()) {
>  			has_blocked_load = true;
> +			update_next_balance = 0;
>  			goto abort;
>  		}
> 
> @@ -10321,9 +10311,15 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>  		has_blocked_load |= this_rq->has_blocked_load;
>  	}
> 
> -	if (flags & NOHZ_BALANCE_KICK)
> +	if (flags & NOHZ_BALANCE_KICK) {
>  		rebalance_domains(this_rq, CPU_IDLE);
> 
> +		if (time_after(next_balance, this_rq->next_balance)) {
> +			next_balance = this_rq->next_balance;
> +			update_next_balance = 1;
> +		}
> +	}
> +
>  	WRITE_ONCE(nohz.next_blocked,
>  		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
> 
> @@ -10354,9 +10350,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  {
>  	int this_cpu = this_rq->cpu;
>  	unsigned int flags;
> -
> -	if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
> -		return false;

why did you remove this ?

> +	bool done;
> 
>  	if (idle != CPU_IDLE) {
>  		atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
> @@ -10368,9 +10362,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  	if (!(flags & NOHZ_KICK_MASK))
>  		return false;
> 
> -	_nohz_idle_balance(this_rq, flags, idle);
> +	/*
> +	 * If idle load balance terinated due to this CPU become busy,
> +	 * pretend it has successfully pulled some loads, and abort
> +	 * the following load balance.
> +	 */
> +	done = _nohz_idle_balance(this_rq, flags, idle);
> +	if (done == false && need_resched())
> +		return true;
> 
> -	return true;
> +	return done;
>  }
> 
>  static void nohz_newidle_balance(struct rq *this_rq)
