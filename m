Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6EFC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE6C21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVOuTKuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgBMNjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:39:55 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45517 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbgBMNjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:39:54 -0500
Received: by mail-vk1-f196.google.com with SMTP id g7so1560788vkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dx8L+v0H0N23P1dqw/3kUTw/aoE8MBLl4O9EVbJhhQk=;
        b=fVOuTKuWhfbmMx0CFhAt5lBFlFD4R4hw/cAT8WzR4yif0oxxKZRtN7He4HsMrIpR0b
         R9+1ksOOCfhvk5TUUvjd41iv02vYhQwp9FzUCTyk+DN8aE1p2uSQmKSkYngJXVcTtWWb
         LMtUoHf3yx2bRJn8jzj3JfyJjndtH3qLKF3AjmpwWJEfJ7sJMIubPH2h4P/ZzuYVx5X6
         s8Jh3OTojunwLAQ7pEWes1d/kitgsF4KbYk7tj4squwEKp62DPDNl+/jGfwz9ASlPrPO
         QFOIAXiPB1omLzYPOXRK3GxIHzyAsxD3VAOHiM2HiodWIWO4NZIRiDzM1O/GuwT3Q7uR
         6rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dx8L+v0H0N23P1dqw/3kUTw/aoE8MBLl4O9EVbJhhQk=;
        b=Ce2Blg4HP86FFlq2LvYb/nZqYQ7BMhG5j+n1AtGoOsZN0b7OxfrKgbDHlkSZukRK5v
         KZfRQAr4YQnvMs5GxkMJBA2Ezf4oZQuWv3ZluBiZExlDHVO6Hhu0WV2F468+Eb1jL0ch
         7M6nqQwtFHQp2P8xZwB1H9CjzFEiX9c1eNUz1XjbijJpIj7oCohHHAP4QVL0b7w05BA1
         foURgDtSfNs5wePJ2DgDy5WHWiFvI2KrZjzZXGawuk8FbNf1yi5cZ2HVN/uZr+bRQezl
         h749ukBBSbIUe1efKwxCvfB4B+GVekJG/TCiOAG5Yg//vgvLeJZ8XpVz3wzmd02OFhCP
         P+TQ==
X-Gm-Message-State: APjAAAXY8hQ9CH/cxwb3mRnaEdRn+n+SaldHm5x9uvMoVPeRwmYP4am0
        3gCEu7pMQrSK4A//yK7yyOcGFjqxvxqe0+IAlPxnsw==
X-Google-Smtp-Source: APXvYqyYpdUWvLQJWCMjM/+cxxiYdIECKgS2pE/1RpmfUZDbgjf/9yT4eWmNUr+qxKyMXZE+maymOwUAbC+kJNOMbEU=
X-Received: by 2002:a1f:7288:: with SMTP id n130mr1992940vkc.46.1581601193410;
 Thu, 13 Feb 2020 05:39:53 -0800 (PST)
MIME-Version: 1.0
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org> <1580250967-4386-6-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1580250967-4386-6-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 13 Feb 2020 19:09:42 +0530
Message-ID: <CAHLCerNH+8TLoez1K=JHhd63z_kGv6cupPiyvugiE4YbQuuxpQ@mail.gmail.com>
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

"actual maximum currently available capacity" is quite a mouthful. :-)

"Remaining capacity" or "Effective capacity" anyone?

IIUC, this remaining capacity is NOT the same as the capped/decreased
capacity referred to in patches 1 and 3. The delta capacity (aka
thermal pressure) there refers to the difference between HW max
capacity and thermally throttled capacity.
Here, we also subtract RT/DL utilisation. Is that accurate?




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
