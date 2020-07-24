Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE7FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F872065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFuCi7l+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXHYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgGXHYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:24:01 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF50C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:24:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so8997562lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Agbo96iJWTQmppeH0ZuVgDrrhEDWnKr3NEJ2MsKJuc=;
        b=mFuCi7l+1rKxLSIS4b35GsIQLtRrutcM6ZpK4vRXfP3n07SDev1BNPBWl3J9CeFf/e
         PzRVm3eCeLvS9EZQt8c3Xsu0U0oRLuOzPngbbt0c46GjdkagIN8NRMDN1OqfY9bfMoXM
         Ce4S16ACxeEiF/dtgVqbFB9yzhkX+TZvT4ivsYbOI6jH8vgP39qexvtwvH1BV64UK9uO
         n8wV700vtTzh5bgI1C0EbErR3Kz/nwE2jN5tyQrFD25QtG0UpbHJ2QLbDr8OItjijxmV
         4Bzglfj+9DMSCcg0d/TGOiuGINFHsAhSsYlSgzsKec6ypoftrpkfTgcFjOilkbzahLSf
         Brdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Agbo96iJWTQmppeH0ZuVgDrrhEDWnKr3NEJ2MsKJuc=;
        b=sCorxoWNX0M+BY7WIkiHzz9b1dXa5n/D2nmr77crwm7W4Rt41CUQ4s3vsLIImuo6aB
         jybl/xXu1Wco3fVO6EXJWp7OzhinbdQNR13k7TOx+/iCpallXyiR1VmyGzclQ/1fUp9n
         jUSUmC/Y2G0KUAI5iERJ6RJhMJZuwK+QBpBS0VRtQ1aiAGCs6af68qSjVpNRdnbhCmi5
         Tp9KSb7ZMclk01LaIbt/a4jc10HlBqK6+fO62ovhBXyjMCTqNt8IgF5a3JXpAxYUCExC
         HuZeaBxzWhu1WcnBUhuNsMsHTdO+IzoehJfAH03a5cM/+sPn9bnLGZHIp2ptqsJJpdoO
         wxpA==
X-Gm-Message-State: AOAM533CvmQDKMKbVcIN+SrjqtMkXioCS3E9PbyR3cS6V34aFJM42P6l
        BN1QSvf/4UDnuC08qN0EXogiTSsdR2QHdHEa1qJFbg==
X-Google-Smtp-Source: ABdhPJzQ0oQeWvbZCU6Ss+2K5GdUaGPBLM+kpg2yLrepsv/h/3BOTAfChWcaUJIy3xgp6oz5Ai/Ciocd5hdvAv8g2gg=
X-Received: by 2002:a2e:3c0e:: with SMTP id j14mr3783563lja.25.1595575439290;
 Fri, 24 Jul 2020 00:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200723233853.48815-1-humjb_1983@163.com>
In-Reply-To: <20200723233853.48815-1-humjb_1983@163.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Jul 2020 09:23:48 +0200
Message-ID: <CAKfTPtCnewaivay7bftUY27+-qB=ct3eSNEoZW=-2Z6k0S4B4Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: consider sched-idle CPU when selecting idle core
To:     Jiang Biao <humjb_1983@163.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 01:39, Jiang Biao <humjb_1983@163.com> wrote:
>
> From: Jiang Biao <benbjiang@tencent.com>
>
> Sched-idle CPU has been considered in select_idle_cpu and
> select_idle_smt, it also needs to be considered in select_idle_core to
> be consistent and keep the same *idle* policy.

In the case of select_idle_core, we are looking for a core that is
fully idle but if one CPU of the core is running a sched_idle task,
the core will not be idle and we might end up having  the wakeup task
on a CPU and a sched_idle task on another CPU of the core which is not
what we want

>
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fa8dbcfa4d..f430a9820d08 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6014,7 +6014,7 @@ void __update_idle_core(struct rq *rq)
>                 if (cpu == core)
>                         continue;
>
> -               if (!available_idle_cpu(cpu))
> +               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
>                         goto unlock;
>         }
>
> @@ -6045,7 +6045,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>                 bool idle = true;
>
>                 for_each_cpu(cpu, cpu_smt_mask(core)) {
> -                       if (!available_idle_cpu(cpu)) {
> +                       if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu)) {
>                                 idle = false;
>                                 break;
>                         }
> --
> 2.21.0
>
>
