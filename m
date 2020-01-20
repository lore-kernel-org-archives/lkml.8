Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A6AC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92E12077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsFzxHaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgATGO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 01:14:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34746 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATGO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 01:14:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so27605821oig.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 22:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XcKOx6X1xb0tdZjWwv0Dj2TEaA6LrjG3UmiZoBUklqY=;
        b=VsFzxHafM8zW3iEWuRTvUi1/iDuY2LLPXCOdVOn9fu3RYvyZrx3A9HdnfJHO4hhjg7
         gFrWlJR0uVZawSfI6K7S4LuqoggVf0IXmVI7CN6EfxzaHttD8owD6XGleTOWkqz2gr4q
         7e0wLddvbhZTfSFj6uCEcD06kntvPLESOSnwHxHHJhOL+6/k+PT5OqPOV8sTNeINTl8i
         uy2CJJ1AEr+pqQa2tUHifhlOp0uaKpJGL2HAAvT9suiHQi75Pu5I6+t6o6QiaJ9vlV3r
         JL999uvprvZ81dOdxYuyzU+/dBNKfwHfNBthDeqgCaYUv7NGNi9fOlcd5nq7/RysS5YZ
         I1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcKOx6X1xb0tdZjWwv0Dj2TEaA6LrjG3UmiZoBUklqY=;
        b=HJTtjNwfCYpTelVHiv8nQ6ipnUggGZsGgOt61XPmoNcjMAWHc/OVNnvgfysHLn/un9
         yGiTBXCEU6DypXgbHDxKapIJNCoSZsv4NmGlRegzmgIVI4qTT/U+35PMpnHO87bMinpi
         8qLc/xws7WMoLWyWav84D10FM9WNZAarhrGoM5L2raM2aHJ4y1icFDWCfHQb4ax38O/b
         kGmIQ1B3Eax1vvBnumW/N6fAYowA4tMNx0mVZ3h3ePWtrJ+iNC7Qbz+cw1gE/h8rObKq
         soH/GWExcOLJzlSdKNbakGdHQGxs/WpDkOdStQEWtq5xGPHxmmGZee5x3deRgmqNOKfe
         vjRg==
X-Gm-Message-State: APjAAAWcvgJocNFBRyxDzTqWwG7uBH6zBMZHhmd+tUIvjM+MnGuLDYqp
        1Qq4jZAOBuTiv95zDT3evvaWsLctZEYSQPpXFMJQdg==
X-Google-Smtp-Source: APXvYqxM/zhzb27sDa9VoakRkPFPvj2/D+oyWzJBmyyZWfFmAYU+lGYmVmYwynvwr+Dm1q1CG0OGBcpdd7GAgm7zxeg=
X-Received: by 2002:aca:1913:: with SMTP id l19mr11221306oii.47.1579500897580;
 Sun, 19 Jan 2020 22:14:57 -0800 (PST)
MIME-Version: 1.0
References: <1578876627-11938-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1578876627-11938-1-git-send-email-wanpengli@tencent.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 20 Jan 2020 14:14:46 +0800
Message-ID: <CANRm+CwHP63YJ_nbVaNOZhPWNYNwHSTjT3j7aiVnx1pVEf3K9A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] sched/nohz: Optimize get_nohz_timer_target()
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping Thomas,
On Mon, 13 Jan 2020 at 08:50, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> On a machine, cpu 0 is used for housekeeping, the other 39 cpus in the
> same socket are in nohz_full mode. We can observe huge time burn in the
> loop for seaching nearest busy housekeeper cpu by ftrace.
>
>   2)               |                        get_nohz_timer_target() {
>   2)   0.240 us    |                          housekeeping_test_cpu();
>   2)   0.458 us    |                          housekeeping_test_cpu();
>
>   ...
>
>   2)   0.292 us    |                          housekeeping_test_cpu();
>   2)   0.240 us    |                          housekeeping_test_cpu();
>   2)   0.227 us    |                          housekeeping_any_cpu();
>   2) + 43.460 us   |                        }
>
> This patch optimizes the searching logic by finding a nearest housekeeper
> cpu in the housekeeping cpumask, it can minimize the worst searching time
> from ~44us to < 10us in my testing. In addition, the last iterated busy
> housekeeper can become a random candidate while current CPU is a better
> fallback if it is a housekeeper.
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * current CPU is a better fallback if it is a housekeeper
>
>  kernel/sched/core.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 102dfcf..04a0f6a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -539,27 +539,32 @@ void resched_cpu(int cpu)
>   */
>  int get_nohz_timer_target(void)
>  {
> -       int i, cpu = smp_processor_id();
> +       int i, cpu = smp_processor_id(), default_cpu = -1;
>         struct sched_domain *sd;
>
> -       if (!idle_cpu(cpu) && housekeeping_cpu(cpu, HK_FLAG_TIMER))
> -               return cpu;
> +       if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
> +               if (!idle_cpu(cpu))
> +                       return cpu;
> +               default_cpu = cpu;
> +       }
>
>         rcu_read_lock();
>         for_each_domain(cpu, sd) {
> -               for_each_cpu(i, sched_domain_span(sd)) {
> +               for_each_cpu_and(i, sched_domain_span(sd),
> +                       housekeeping_cpumask(HK_FLAG_TIMER)) {
>                         if (cpu == i)
>                                 continue;
>
> -                       if (!idle_cpu(i) && housekeeping_cpu(i, HK_FLAG_TIMER)) {
> +                       if (!idle_cpu(i)) {
>                                 cpu = i;
>                                 goto unlock;
>                         }
>                 }
>         }
>
> -       if (!housekeeping_cpu(cpu, HK_FLAG_TIMER))
> -               cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
> +       if (default_cpu == -1)
> +               default_cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
> +       cpu = default_cpu;
>  unlock:
>         rcu_read_unlock();
>         return cpu;
> --
> 1.8.3.1
>
