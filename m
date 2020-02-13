Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8732C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC7320873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWyC+rRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgBMOLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:11:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36181 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgBMOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:11:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id w25so5775935qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=j1SIK81ZPhXEIF166UZGxZMxUt2GaElLV0aYrlmFKR8=;
        b=fWyC+rRlU75y1ZgTDdL3baIpvwpSLKDByEZiVhRm8/xubRqqcdESqcktmqnoeb/cIn
         4inaXd76nUihpQyzxy0uNHOWspcRGihwSrfDHKtOi4lpEMGU7AxsZ3DGCZpo6oYxkgq2
         /upDrB/u7gZZul+zxoiVl7ettRNdPJxUPvwwyDXUXeE7MYTrzT5sPBMAB7V21n0FVZOJ
         GFqCLV2mlTtpu005HJ1+dAs4ejof88OJGdyUBbkXaVHHkDdt709iTMGCIlzP3T93GQDK
         JYlZ2mkZAhdtRgEjpvErXsG/ExQBbIQ9JeGqAyI+LeOyj3oyUygMtaR6Y2BJMbJqrlP8
         QjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=j1SIK81ZPhXEIF166UZGxZMxUt2GaElLV0aYrlmFKR8=;
        b=XzW5ZjoMxaupoHrqpm1V6anLIibIaQooB7BwdSR9+o60iWbygEot6pim8NeM/5Qnz5
         G/kaqLU86MkBKVnV7XpWl/GD5WdRd6QauKlgwRp9zuorjr/txP/iIXU1qjoUhoUgrkIF
         bF7TjhmlBk3FKEdhS+jauYUsSHJ5KUazA4KfUZsEYRW57bsqc2cXpBnu3F7OLwTy978E
         WoMjRtTOUaR7I5XQTaVc8xU+jW6eWn/eNOHZf8BaGBX+rdgM188VP3iOs/ATcu9yGqsg
         UmZzcf57oNpzUpCV7XJjQOLE/tGuC6WqJxrkgzIxMUlLVuKttk5vyxb4iI15CSt/oLkK
         mFkw==
X-Gm-Message-State: APjAAAX/yxET8mwZmxe42TfmeoFt9HcGjadZaFqViqaOLypx9LH1jzHI
        JD7OwP2yc+IsCMMCMFYidSVbnA==
X-Google-Smtp-Source: APXvYqx6Yi2P/DBXFl8xN2I8AfzQvZnpejL8cdj1vaH3HgFgD15v0/gvLdtgMSlrMWVDceXDoO6NgQ==
X-Received: by 2002:a37:5f43:: with SMTP id t64mr15506221qkb.68.1581603100486;
        Thu, 13 Feb 2020 06:11:40 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id b35sm1567396qtc.9.2020.02.13.06.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 06:11:39 -0800 (PST)
Subject: Re: [Patch v9 1/8] sched/pelt: Add support to track thermal pressure
To:     Amit Kucheria <amit.kucheria@verdurent.com>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-2-git-send-email-thara.gopinath@linaro.org>
 <CAHLCerM9xi4BqmGhfzsq-BQ+gEhP3n70T=RvBrpriXiXChLebQ@mail.gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, corbet@lwn.net,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E455919.5090506@linaro.org>
Date:   Thu, 13 Feb 2020 09:11:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerM9xi4BqmGhfzsq-BQ+gEhP3n70T=RvBrpriXiXChLebQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2020 07:29 AM, Amit Kucheria wrote:
> On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
>>
>> Extrapolating on the existing framework to track rt/dl utilization using
>> pelt signals, add a similar mechanism to track thermal pressure. The
>> difference here from rt/dl utilization tracking is that, instead of
>> tracking time spent by a cpu running a rt/dl task through util_avg, the
>> average thermal pressure is tracked through load_avg. This is because
>> thermal pressure signal is weighted "delta" capacity and is not
>> binary(util_avg is binary). "delta capacity" here means delta between the
>> actual capacity of a cpu and the decreased capacity a cpu due to a thermal
>> event.
>>
>> In order to track average thermal pressure, a new sched_avg variable
>> avg_thermal is introduced. Function update_thermal_load_avg can be called
>> to do the periodic bookkeeping (accumulate, decay and average) of the
>> thermal pressure.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>
>> v6->v7:
>>         - Added CONFIG_HAVE_SCHED_THERMAL_PRESSURE to stub out
>>           update_thermal_load_avg in unsupported architectures as per
>>           review comments from Peter, Dietmar and Quentin.
>>         - Updated comment for update_thermal_load_avg as per review
>>           comments from Peter and Dietmar.
>> v7->v8:
>>         - Fixed typo in defining update_thermal_load_avg which was
>>           causing build errors (reported by kbuild test report)
>> v8->v9:
>>         - Defined thermal_load_avg to read rq->avg_thermal.load_avg and
>>           avoid cacheline miss in unsupported cases as per Peter's
>>           suggestion.
>>
>>  include/trace/events/sched.h |  4 ++++
>>  init/Kconfig                 |  4 ++++
>>  kernel/sched/pelt.c          | 31 +++++++++++++++++++++++++++++++
>>  kernel/sched/pelt.h          | 31 +++++++++++++++++++++++++++++++
>>  kernel/sched/sched.h         |  3 +++
>>  5 files changed, 73 insertions(+)
>>
>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>> index 420e80e..a8fb667 100644
>> --- a/include/trace/events/sched.h
>> +++ b/include/trace/events/sched.h
>> @@ -613,6 +613,10 @@ DECLARE_TRACE(pelt_dl_tp,
>>         TP_PROTO(struct rq *rq),
>>         TP_ARGS(rq));
>>
>> +DECLARE_TRACE(pelt_thermal_tp,
>> +       TP_PROTO(struct rq *rq),
>> +       TP_ARGS(rq));
>> +
>>  DECLARE_TRACE(pelt_irq_tp,
>>         TP_PROTO(struct rq *rq),
>>         TP_ARGS(rq));
>> diff --git a/init/Kconfig b/init/Kconfig
>> index bd9f1fd..055c3bf 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -463,6 +463,10 @@ config HAVE_SCHED_AVG_IRQ
>>         depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
>>         depends on SMP
>>
>> +config HAVE_SCHED_THERMAL_PRESSURE
>> +       bool "Enable periodic averaging of thermal pressure"
>> +       depends on SMP
>> +
>>  config BSD_PROCESS_ACCT
>>         bool "BSD Process Accounting"
>>         depends on MULTIUSER
>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index bd006b7..5d1fbf0 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -367,6 +367,37 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
>> +/*
>> + * thermal:
>> + *
>> + *   load_sum = \Sum se->avg.load_sum but se->avg.load_sum is not tracked
>> + *
>> + *   util_avg and runnable_load_avg are not supported and meaningless.
>> + *
>> + * Unlike rt/dl utilization tracking that track time spent by a cpu
>> + * running a rt/dl task through util_avg, the average thermal pressure is
>> + * tracked through load_avg. This is because thermal pressure signal is
>> + * weighted "delta" capacity and is not binary(util_avg is binary). "delta
> 
> May I suggest a slight rewording here and in the commit description,
> 
>    This is because the thermal pressure signal is weighted "delta"
> capacity unlike util_avg which is binary.

Sure! Will fix it.

> 
> It would also help, if you expanded on what you mean by binary in the
> commit description and how the delta capacity is weighted.

I don't understand this. Binary means  0 or 1. delta capacity is time
weighted, i will update this.

> 
>> + * capacity" here means delta between the actual capacity of a cpu and the
>> + * decreased capacity a cpu due to a thermal event.
> 
> Use consistent wording throughout the series - either capped or
> decreased capacity.
> 
>> + */
> 
> This could be shortened to:
> 
> Delta capacity of cpu = Actual capacity - Capped capacity due to thermal event

Will fix this.

> 
>> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
>> +{
>> +       if (___update_load_sum(now, &rq->avg_thermal,
>> +                              capacity,
>> +                              capacity,
>> +                              capacity)) {
>> +               ___update_load_avg(&rq->avg_thermal, 1, 1);
>> +               trace_pelt_thermal_tp(rq);
>> +               return 1;
>> +       }
>> +
>> +       return 0;
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>>  /*
>>   * irq:
>> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
>> index afff644..916979a 100644
>> --- a/kernel/sched/pelt.h
>> +++ b/kernel/sched/pelt.h
>> @@ -7,6 +7,26 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>>
>> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
>> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
>> +
>> +static inline u64 thermal_load_avg(struct rq *rq)
>> +{
>> +       return READ_ONCE(rq->avg_thermal.load_avg);
>> +}
>> +#else
>> +static inline int
>> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline u64 thermal_load_avg(struct rq *rq)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>>  int update_irq_load_avg(struct rq *rq, u64 running);
>>  #else
>> @@ -159,6 +179,17 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>>  }
>>
>>  static inline int
>> +update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline u64 thermal_load_avg(struct rq *rq)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline int
>>  update_irq_load_avg(struct rq *rq, u64 running)
>>  {
>>         return 0;
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 1a88dc8..1f256cb 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -944,6 +944,9 @@ struct rq {
>>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>>         struct sched_avg        avg_irq;
>>  #endif
>> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
>> +       struct sched_avg        avg_thermal;
>> +#endif
>>         u64                     idle_stamp;
>>         u64                     avg_idle;
>>
>> --
>> 2.1.4
>>


-- 
Warm Regards
Thara
