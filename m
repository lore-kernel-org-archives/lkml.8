Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA9C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8895020771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgDHKmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:42:23 -0400
Received: from foss.arm.com ([217.140.110.172]:36774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgDHKmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:42:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D7931B;
        Wed,  8 Apr 2020 03:42:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 745523F73D;
        Wed,  8 Apr 2020 03:42:20 -0700 (PDT)
References: <20200408095012.3819-1-dietmar.eggemann@arm.com> <20200408095012.3819-3-dietmar.eggemann@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for asymmetric CPU capacities
Message-ID: <jhjeesyw96u.mognet@arm.com>
In-reply-to: <20200408095012.3819-3-dietmar.eggemann@arm.com>
Date:   Wed, 08 Apr 2020 11:42:14 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/04/20 10:50, Dietmar Eggemann wrote:
> +++ b/kernel/sched/sched.h
> @@ -304,11 +304,14 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
>       __dl_update(dl_b, -((s32)tsk_bw / cpus));
>  }
>
> +static inline unsigned long rd_capacity(int cpu);
> +
>  static inline
> -bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
> +bool __dl_overflow(struct dl_bw *dl_b, int cpu, u64 old_bw, u64 new_bw)
>  {
>       return dl_b->bw != -1 &&
> -	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
> +	       cap_scale(dl_b->bw, rd_capacity(cpu)) <
> +	       dl_b->total_bw - old_bw + new_bw;
>  }
>

I don't think this is strictly equivalent to what we have now for the SMP
case. 'cpus' used to come from dl_bw_cpus(), which is an ugly way of
writing

     cpumask_weight(rd->span AND cpu_active_mask);

The rd->cpu_capacity_orig field you added gets set once per domain rebuild,
so it also happens in sched_cpu_(de)activate() but is separate from
touching cpu_active_mask. AFAICT this mean we can observe a CPU as !active
but still see its capacity_orig accounted in a root_domain.


>  extern void init_dl_bw(struct dl_bw *dl_b);
