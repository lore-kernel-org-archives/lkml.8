Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52209C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2627B206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcllkKbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgCCLOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:14:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36240 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCCLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:14:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id 195so3081506ljf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 03:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+NszCv6mHHE+JhV0zOyAqXlWWUszaOvgsPt/ssy5gA=;
        b=qcllkKbZQ2YprbA/WXcceEiHAw3vDFRO8nq9DjpCvh4PuCIL91FudknRrXX7wziOYg
         nEoYBesJh41FrehPxp/ly4TTVgghxzfq3N9zpPl/rs76KcxE3sUqPGF45geOaQDujYGF
         XkiQDfE72f5NmB8ldK7z2u2O+W1VvJnInGwbeYKXTir8u/RtQdFMJswfMUqoixIDn//g
         gDq+WznXuAwJ0LYSkotyIpd/wFpfy24yF6Uz0O26gHj+W2Ce4t0rI/yw3n0ekMCUWUlO
         PLso/upLGWd6UCrkHz2vFazSVvHJqOHALBI7D80O5TbeBu9pV/ZOHKEexypk1gL4FTBX
         mARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+NszCv6mHHE+JhV0zOyAqXlWWUszaOvgsPt/ssy5gA=;
        b=YQ33S0ySomA6ohnhEVDgEV/TmapkJRi+kGbsj0H2TvIHJFov/gnzu8at3Kzn6atus+
         hZ4k7GrKTC4mAgece2m/xxDx3FD2ol14P1QmKAEViV7h7KQGSWC+Ff1qdFqyRj0dx+p2
         gmytEeN6FxFnumw5NA5mPf6XjVAU7euoI5qzOF2Lvh1IguMGO5hhZtnpsGU34ULFFYBA
         cnryy2EvN3pjGgosY7Dw2Tk4TAR90bqetj0rry/K74n8BmqaWocDtutN3LW4l1gD8Ota
         FNyJp2Wtq+dmwhzAu6q3tOOY6wKR7j8yVJLXQd8O11GF/svspUluznva1RGjnxNIdHEN
         bFYQ==
X-Gm-Message-State: ANhLgQ1SCbd89riKDFXBRt0C6LGjC7G8R6Sqp2PTuYX+IX66ggrFkF0P
        QvT3QwQhhba3zhHyyoiXygkHS+vAuIVQhMS5Nyeh2w==
X-Google-Smtp-Source: ADFU+vtUAIAyu6J3UXXJj8wtRIJPYFcuWyJEJwrCXeXcLLRRQY+m1Z4ykTSyYNdpUZQrBt45QCSZoZYERGHgheyjtsw=
X-Received: by 2002:a2e:2a06:: with SMTP id q6mr737825ljq.65.1583234059117;
 Tue, 03 Mar 2020 03:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20200303110258.1092-1-mgorman@techsingularity.net> <20200303110258.1092-2-mgorman@techsingularity.net>
In-Reply-To: <20200303110258.1092-2-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 3 Mar 2020 12:14:07 +0100
Message-ID: <CAKfTPtC5LAU9mmfqX9qydR-GQekXrSSNTErONm493UBpZWHZsA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Fix statistics for find_idlest_group()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paul McKenney <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Tue, 3 Mar 2020 at 12:03, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> From: Vincent Guittot <vincent.guittot@linaro.org>
>
> From: Vincent Guittot <vincent.guittot@linaro.org>
>
> sgs->group_weight is not set while gathering statistics in
> update_sg_wakeup_stats(). This means that a group can be classified as
> fully busy with 0 running tasks if utilization is high enough.
>
> This path is mainly used for fork and exec.
>
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Link: https://lore.kernel.org/r/20200218144534.4564-1-vincent.guittot@linaro.org

This one has been merged in tip/sched/urgent

> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..4b5d5e5e701e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8561,6 +8561,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>
>         sgs->group_capacity = group->sgc->capacity;
>
> +       sgs->group_weight = group->group_weight;
> +
>         sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
>
>         /*
> --
> 2.16.4
>
