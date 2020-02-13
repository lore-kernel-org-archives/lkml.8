Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CECAC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19561218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="d/kPtkI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgBMMrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:47:41 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40306 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:47:40 -0500
Received: by mail-ua1-f66.google.com with SMTP id g13so2200916uab.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oy1TQ4c1/kXbmr4BqUIxSWOruEHkmefnsn2cXhY8GI=;
        b=d/kPtkI1Bf+wOmHtFluHQL9zwvFpmUqimDwOEHVuDq+h3190eH+3fmlMnouS7EVOe6
         i8tmfqAlcls2SSnlKqmGPnK1pp6AaXe/waW/T4ol169mqsa1+9rJtvKA/G8++BG60MNB
         uMyjapfqvO/CzlKxOO6dm8IQiZtKhQO6lNWTblhv5pYSjncM/tqhTBKKjWM8TnEw4npD
         asAx0Ccjcw8s6WwNcyLM2mc40Fy7pcutNwqoxRdMax7I0ZmttnepA5ZDmtWNaTiJnqfi
         VH9IfyRpKjwvLbUfdCqmUBfi46DPNZny932JGl+i6Ujk/0SIIX7vGYCneIRFeE4J/gJ8
         dnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oy1TQ4c1/kXbmr4BqUIxSWOruEHkmefnsn2cXhY8GI=;
        b=HQ5PfJcE5uo0kjgiuOQZ7Dt9Kd5C8mqbx17V1XIWBGxf8+md4dFoFEH4ZhmDZd5+Sa
         Mabs0BO7i7O8blZhugPu7/USpbSKzJw4dCZmHjyDoYCIYX+lMbWdouNGqHqt/h4gJmy6
         oWECH5axCeHP6a02nO9dOe0FrAsmktOBPy2MNdnqt8lHVE9Tw1Vl9HxU3t5pm1d/hJrK
         FQbzfb7wzISF59yK2uuSS68H3e8x/WkH8T3gtjpIaVCip0m/Jt5WDpyYaCXhfaOmhp83
         UpmkaiT5O+xFpehWVhbIpaOvxnbJef+k1ZHRX4e0KuMDAicnvLKdAH4CuMqd3twNr7fh
         WQWA==
X-Gm-Message-State: APjAAAVVbTZ83mm2naXPySuouOVPgqyLrfzLQ0a0sW5/GvHrvEgoz89M
        Pi2GAJT913i6OqFRfFWg+q4hlCNYJniQaTpEimNA8A==
X-Google-Smtp-Source: APXvYqzFeC0tJWAgAkTgwCcBVMOqPtaNCrUrLZOWi/RTrU5OwHVOiE/AUbue8lYQF7NptbC17slU6AV+U+pkZzXHUcc=
X-Received: by 2002:ab0:1849:: with SMTP id j9mr6881047uag.77.1581598058351;
 Thu, 13 Feb 2020 04:47:38 -0800 (PST)
MIME-Version: 1.0
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org> <1580250967-4386-6-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1580250967-4386-6-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 13 Feb 2020 18:17:26 +0530
Message-ID: <CAHLCerM1SeZWZa3-1bjtZHS-d1d9=yKGDt=ZQTpbYqPZFBGwkg@mail.gmail.com>
Subject: Re: [Patch v9 5/8] sched/fair: update cpu_capacity to reflect thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> cpu_capacity initially reflects the maximum possible capacity of a cpu.
> Thermal pressure on a cpu means this maximum possible capacity is
> unavailable due to thermal events. This patch subtracts the average thermal
> pressure for a cpu from its maximum possible capacity so that cpu_capacity
> reflects the actual maximum currently available capacity.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>
> v8->v9:
>         - Use thermal_load_avg to read rq->avg_thermal.load_avg.
>
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5f58c03..d879077 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7753,8 +7753,15 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>         if (unlikely(irq >= max))
>                 return 1;
>
> +       /*
> +        * avg_rt.util avg and avg_dl.util track binary signals

For avg_rt, s/util avg/util_avg/
For avg_dl, s/util/util_avg/    ?

> +        * (running and not running) with weights 0 and 1024 respectively.
> +        * avg_thermal.load_avg tracks thermal pressure and the weighted
> +        * average uses the actual delta max capacity(load).
> +        */
>         used = READ_ONCE(rq->avg_rt.util_avg);
>         used += READ_ONCE(rq->avg_dl.util_avg);
> +       used += thermal_load_avg(rq);
>
>         if (unlikely(used >= max))
>                 return 1;
> --
> 2.1.4
>
