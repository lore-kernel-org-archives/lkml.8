Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C72EC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1605C206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YipZuW6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgDHM3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:29:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37402 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgDHM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:29:30 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so5005324lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YO0DPEIowR6FKoT9Z2QqUeTnswzrFsJGk8ZK6iAlIKU=;
        b=YipZuW6X1zD7Wvyrp8vARlzLtnPe8PfbQVWbBfV421NTNrYJJOocOBDmHhANQZf4dL
         O/A2Io4sp3yWjH9+aGtyNht+VGYHZic2QbqmoRWkqavRoIdHjXmM/TSfx4uc/QrU7T+j
         f5EhaTLD+4z9IjVnVdfhGO0ECm4EwhvVtmcLaC0S/dZTXZ6nfEKKH+mi/ErqgAw+3VDq
         X2tFuEmyDr/0KETXmBYsgiMxrGwkHhjgpsPLhoIstUmk1mgW36iFX6hA3WHPvnBpgPoq
         J9qhwTi0aJJurvYXPq+SVoM1pKh3WliNSrNNHXV5x2zC3O3c95DXU0q1ze27E3TfLzHH
         pYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YO0DPEIowR6FKoT9Z2QqUeTnswzrFsJGk8ZK6iAlIKU=;
        b=JyC3MhWOwJ80scOse/gFTHrYMrlHETS2BeUZKcozDTGS0p+ofhZKERdbnKTLYXUZd6
         Ji0ZI8t/1axbwsD8UAJ68L0PB1HnVXOwHmWXLSCrQUP0YVRu8cnxZG1zZT9ZFQhazF2a
         kMhrB639JuWBVmlUGeaw0PLhYanBE8iz2pTW/LJPrxcGzqR8k7bBglw/k+WJYRrLu/1v
         AbIzsDIY3WkuZ8ZfAZDXDsWpwCtKagVl5oUa/oEgYww5HGZS5piF9moOpoZQRfjufU7K
         HtjK3qzL136FgYvTihq1usCkE0TTIk5BLooUahzhe9oypEmekVy4ZC6+c5R3iNdKDPYQ
         XQ3A==
X-Gm-Message-State: AGi0PuaJk0wtgzn4bEOPA9SBSJEP5fpJy4cKIJzkToTiQZ+7w/OyiTuG
        Tna0Etf8J9DC1WhxtS1oortlXdPgtTSjqwq3HcThxA==
X-Google-Smtp-Source: APiQypJqH7nZPuX1nBy1EL+9zs7Si/fi5boTxKmSFehn/X6zn5fQne54exz4MJYvS6BGs7Z+zWAopdlFX5VS+jLuaZs=
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr4507268lfo.149.1586348967692;
 Wed, 08 Apr 2020 05:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200408095012.3819-1-dietmar.eggemann@arm.com> <20200408095012.3819-2-dietmar.eggemann@arm.com>
In-Reply-To: <20200408095012.3819-2-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Apr 2020 14:29:16 +0200
Message-ID: <CAKfTPtC4_+dTddLdoFMdzUvsXwWyi3bUOXcg9kstC8RzZS_a+A@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/topology: Store root domain CPU capacity sum
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 at 11:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Add the sum of (original) CPU capacity of all member CPUs to the root
> domain.
>
> This is needed for capacity-aware SCHED_DEADLINE admission control.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/sched.h    | 11 +++++++++++
>  kernel/sched/topology.c | 14 ++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1e72d1b3d3ce..91bd0cb0c529 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -797,6 +797,7 @@ struct root_domain {
>         cpumask_var_t           rto_mask;
>         struct cpupri           cpupri;
>
> +       unsigned long           sum_cpu_capacity;
>         unsigned long           max_cpu_capacity;
>
>         /*
> @@ -2393,6 +2394,16 @@ static inline unsigned long capacity_orig_of(int cpu)
>  {
>         return cpu_rq(cpu)->cpu_capacity_orig;
>  }
> +
> +static inline unsigned long rd_capacity(int cpu)
> +{
> +       return cpu_rq(cpu)->rd->sum_cpu_capacity;
> +}
> +#else
> +static inline unsigned long rd_capacity(int cpu)
> +{
> +       return SCHED_CAPACITY_SCALE;
> +}
>  #endif
>
>  /**
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8344757bba6e..74b0c0fa4b1b 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2052,12 +2052,17 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>         /* Attach the domains */
>         rcu_read_lock();
>         for_each_cpu(i, cpu_map) {
> +               unsigned long cap = arch_scale_cpu_capacity(i);

Why do you replace the use of rq->cpu_capacity_orig by
arch_scale_cpu_capacity(i) ?
There is nothing about this change in the commit message

> +
>                 rq = cpu_rq(i);
>                 sd = *per_cpu_ptr(d.sd, i);
>
>                 /* Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing: */
> -               if (rq->cpu_capacity_orig > READ_ONCE(d.rd->max_cpu_capacity))
> -                       WRITE_ONCE(d.rd->max_cpu_capacity, rq->cpu_capacity_orig);
> +               if (cap > READ_ONCE(d.rd->max_cpu_capacity))
> +                       WRITE_ONCE(d.rd->max_cpu_capacity, cap);
> +
> +               WRITE_ONCE(d.rd->sum_cpu_capacity,
> +                          READ_ONCE(d.rd->sum_cpu_capacity) + cap);
>
>                 cpu_attach_domain(sd, d.rd, i);
>         }
> @@ -2067,8 +2072,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>                 static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
>
>         if (rq && sched_debug_enabled) {
> -               pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
> -                       cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
> +               pr_info("root domain span: %*pbl (capacity = %lu max cpu_capacity = %lu)\n",
> +                       cpumask_pr_args(cpu_map), rq->rd->sum_cpu_capacity,
> +                       rq->rd->max_cpu_capacity);
>         }
>
>         ret = 0;
> --
> 2.17.1
>
