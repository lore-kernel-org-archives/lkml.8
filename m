Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BA1C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9257B20575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRI9dknK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406533AbgDNHVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406524AbgDNHVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:21:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C246C0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:21:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so8578739lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnugimfgLlPD7Ub15Rq+ZP2oqGldo7TE1O1Dmve7nnE=;
        b=wRI9dknKV5V3DYRe+7S8M3zpLgJPJdiiGSSB3ViTj+LgBtBkel7wQUYbC/TqthYAMq
         8N+ZCg6krg7n/i49R72BeyHVAAi0sL3HBE3ZFuki7Cb+qEZmfRdZ1UrkQ16rIYWz+PFW
         FQq7ghksGAgTcBLKDGYubGuW+9BAOqg1TygoLL6uZeaOu/4TWmFfwp+couNU8xssKvDi
         0/RGo61l/CBm8h8GjUZ1FpOcWg4tKnbPellLDne2hH4c5YWqDDzjjqmeBv75AiT65HWe
         m25ZKQZLWWspY4lreXA1g+MJ4FzZbRukIrFN5A67WRBvFEIG/+LtcTOSOELrENzRWM/q
         jsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnugimfgLlPD7Ub15Rq+ZP2oqGldo7TE1O1Dmve7nnE=;
        b=KzQFvIiIcxafvk2xH5QcMyVDbIzJU+K7sS056JSjavfH7UCujuowhnnyJuO1QaUZzT
         LM0XGAcrFZ4dsfOETpGab82ET4kzqpZIhYVtAp8KQvXDT6a5iHPRAbapSDe/OygNiDGb
         uVAexKQREm1rICJKLMU0sdmJerKXa3kzHfbENSbORG1vtOCZ6n92crkYStwRu+tmOumH
         48+Mbr9krLffh9/t6prZXOM35rB4hLNUM8iYfrlhyJcdlqSeQq0X3RRR6lUUL4zLWHzy
         juuJ1yfjpzWRNHRYTCCppPfkGj1F/8Jdo/Hhy1nltVs7xOxea5snySB+2XYpZ+qvqDyo
         UUyg==
X-Gm-Message-State: AGi0PubUu5+nQvqaw6mHcXiu2tKzQrJAi+8WcCgUYZ1J4b5dBZKpCeXz
        skVz+/tHSa4HOsnztS0Wu0ji/ZqNW0+E3MtstEginQ==
X-Google-Smtp-Source: APiQypJ4H6n7yG0F1w2Gn8N+H5CLgqJiuZoYs6jejd2ao/p3wXioqSyoAIymYwIciCXJXV97mBqob4c/A2XaK8HU/Sw=
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr12666522lfr.189.1586848868714;
 Tue, 14 Apr 2020 00:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1586779466-4439-1-git-send-email-wangqing@vivo.com> <1586779466-4439-2-git-send-email-wangqing@vivo.com>
In-Reply-To: <1586779466-4439-2-git-send-email-wangqing@vivo.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Apr 2020 09:20:57 +0200
Message-ID: <CAKfTPtDSk31p5xF9aHef4T7ixgx8m1H86Py=deu7L6dG4Z1vzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] [V2 1/2]sched:add task_running_oncpu
To:     Wang Qing <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jinho lim <jordan.lim@samsung.com>,
        Dave Martin <Dave.Martin@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 at 14:04, Wang Qing <wangqing@vivo.com> wrote:
>
> We have no interface whether the task is running,
> so we need to add an interface and distinguish CONFIG_SMP.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  include/linux/sched.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 4418f5c..13cc8f5 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1843,6 +1843,11 @@ static inline unsigned int task_cpu(const struct task_struct *p)
>
>  extern void set_task_cpu(struct task_struct *p, unsigned int cpu);
>
> +static inline int task_running_oncpu(const struct task_struct *p)

This function name is too close from task_running_on_cpu() and can be
misleading as the difference is only "_"
Also, how task_running_oncpu() is different from task_running() ?

> +{
> +       return p->on_cpu;
> +}
> +
>  #else
>
>  static inline unsigned int task_cpu(const struct task_struct *p)
> @@ -1854,6 +1859,11 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
>  {
>  }
>
> +static inline int task_running_oncpu(const struct task_struct *p)
> +{
> +       return p == current;
> +}
> +
>  #endif /* CONFIG_SMP */
>
>  /*
> --
> 2.7.4
>
