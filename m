Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF9AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A09206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0VcoZTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgEDPRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728165AbgEDPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:17:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47017C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 08:17:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so10068590ljl.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CR1034a54R7krWBlR+Wwz8ASr1KEH3BC6Ga1BqQA9Do=;
        b=O0VcoZTIHJm3q5Yhecj6iKf2QFe7hNfQjYJu3Oz4R4Y11TxpaQqzs7ySTskuftcNyJ
         +c91jxsHAJK3xvfPdnI88Wyc7FWEB0w6Cb2vkBCCAmlO7IanAGpEF44Z+n4ay96piosC
         WF9YyC/Ho0xromMA4OZ1T0ugLKPHm+swMvSkjkbXkBafalVHGXOQd28r25oqMxHrAtid
         4LJMOyRGDda+h8r5ou8H71MFgXEWXeyPrt2n2ppRJSaw3et6S65YqYd1EqMGEBYBK1W4
         GpD4RP2p6tLA7y+tDsJ6r1BywQlNXFW+gFqb/fki18j3VnI+cSTAZ7PGnUPoq34ekhym
         dccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CR1034a54R7krWBlR+Wwz8ASr1KEH3BC6Ga1BqQA9Do=;
        b=EJTI0YM8MfHFKcjqQierqNI97P0sqR2lcMJsesZeo02SO7l6CZ6NDGB9qYb0oy/t15
         KR/47fpIDyo4LpB/oZvWiMTWgFlRXHGh1wFldahKXaShJpY2OMYcZcoW0bnjDkdR5EKq
         BCZ8Iwjzx9oRF7jFE1rfha+pviJIUdAZlHnxomfdTP4l0ZnlclvSLnfbo+Jzju3SUXx6
         dek6PT9vvKobCMcX/soKODO3GZxgSeGa9kwCVkEnIRGrQZbmC/M9tE+w50bzMf2l1K0i
         5BQ3Ddr26OgvmEK7gHQXosCXQZto6rjud8T3UzlKgwkAWiyNWRuU+XeUfAM0W6wS/629
         GNxw==
X-Gm-Message-State: AGi0PubfS+yXU3ZdMREMNRNqZTXxcwcjpmiNWec316Uht5qA+W2L1kbT
        XW9OxTO6zwHh5Gjji5idc3iqmcjbl+gdsub8af2m5A==
X-Google-Smtp-Source: APiQypIiTJUXRfRhTlOGeY2tzGJ+yH7lUuJBg2i3Rrhxm6mUZbHU+mjW9/ZxtO/osVGX+urJQI55IyezV2ro0e4l1YU=
X-Received: by 2002:a2e:740f:: with SMTP id p15mr10731103ljc.151.1588605442680;
 Mon, 04 May 2020 08:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
In-Reply-To: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 May 2020 17:17:11 +0200
Message-ID: <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 May 2020 at 10:34, Peng Liu <iwtbavbm@gmail.com> wrote:
>
> commit c5afb6a87f23 ("sched/fair: Fix nohz.next_balance update")
> During idle load balance, this_cpu(ilb) do load balance for the other
> idle CPUs, also gather the earliest (nohz.)next_balance.
>
> Since commit:
>   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
>
> We update nohz.next_balance like this:
>
>   _nohz_idle_balance() {
>       for_each_cpu(nohz.idle_cpus_mask) {
>           rebalance_domains() {
>               update nohz.next_balance <-- compare and update
>           }
>       }
>       rebalance_domains(this_cpu) {
>           update nohz.next_balance <-- compare and update
>       }
>       update nohz.next_balance <-- unconditionally update
>   }
>
> For instance, nohz.idle_cpus_mask spans {cpu2,3,5,8}, and this_cpu is
> cpu5. After the above loop we could gather the earliest *next_balance*
> among {cpu2,3,8}, then rebalance_domains(this_cpu) update
> nohz.next_balance with this_rq->next_balance, but finally overwrite
> nohz.next_balance with the earliest *next_balance* among {cpu2,3,8},
> we may end up with not getting the earliest next_balance.
>
> Since we can gather all the updated rq->next_balance, including this_cpu,
> in _nohz_idle_balance(), it's safe to remove the extra lines in
> rebalance_domains() which are originally intended for this_cpu. And
> finally the updating only happen in _nohz_idle_balance().

I'm not sure that's always true. Nothing prevents nohz_idle_balance()
to return false . Then run_rebalance_domains() calls
rebalance_domains(this_rq ,SCHED_IDLE) outside _nohz_idle_balance().
In this case we must keep the code in rebalance_domains().

For example when the tick is not stopped when entering idle. Or when
need_resched() returns true.

So instead of removing the code from rebalance_domains, you should
move the one in _nohz_idle_balance() to make sure that the "if
(likely(update_next_balance)) ..." is called before calling
rebalance_domains for the local cpu



>
> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..1d0cf33fefad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9943,22 +9943,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>          * When the cpu is attached to null domain for ex, it will not be
>          * updated.
>          */
> -       if (likely(update_next_balance)) {
> +       if (likely(update_next_balance))
>                 rq->next_balance = next_balance;
> -
> -#ifdef CONFIG_NO_HZ_COMMON
> -               /*
> -                * If this CPU has been elected to perform the nohz idle
> -                * balance. Other idle CPUs have already rebalanced with
> -                * nohz_idle_balance() and nohz.next_balance has been
> -                * updated accordingly. This CPU is now running the idle load
> -                * balance for itself and we need to update the
> -                * nohz.next_balance accordingly.
> -                */
> -               if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
> -                       nohz.next_balance = rq->next_balance;
> -#endif
> -       }
>  }
>
>  static inline int on_null_domain(struct rq *rq)
> @@ -10321,9 +10307,15 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>                 has_blocked_load |= this_rq->has_blocked_load;
>         }
>
> -       if (flags & NOHZ_BALANCE_KICK)
> +       if (flags & NOHZ_BALANCE_KICK) {
>                 rebalance_domains(this_rq, CPU_IDLE);
>
> +               if (time_after(next_balance, this_rq->next_balance)) {
> +                       next_balance = this_rq->next_balance;
> +                       update_next_balance = 1;
> +               }
> +       }
> +
>         WRITE_ONCE(nohz.next_blocked,
>                 now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>
> --
> 2.17.1
>
