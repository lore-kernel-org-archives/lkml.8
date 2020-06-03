Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D57C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF07E20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHrWWNRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgFCMHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFCMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:07:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7756C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:07:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so2410367ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 05:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIbOf5HdtSdKaIH50HNFnmpw4HPy6383aDhwDCSPydo=;
        b=nHrWWNRbiHniHbGOkTVHxhtEhQJ+Mq5wngAslBJTukuVvBjSNtiIub3q3D8ttCDxqA
         yD13A7K+uECthSFNgk+eYvEx4Xbxcj+VXXC4xsDXSbeCK6iw5nfvLoQ7w5rNWrek+I31
         S6Q3/Vc3ZGGSHm2e+ZgGXpyL7IGnDawcSSjT7wa8jbxy5mumQktI+rkcVv1oK7oDzO8v
         qweoyEFPUlPZcGsQ4/dQjFgRAniTDmoaXcwIecvVac6U6LA5T0Cw+QY8ZTAiCtZlieO9
         fFaYLnWmgc0FXRTK0Gt8pMt26k6uoZcMjYqkr60oIWRVU1EIHzWqCOVI/cZy7/0v4KPU
         OFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIbOf5HdtSdKaIH50HNFnmpw4HPy6383aDhwDCSPydo=;
        b=YcvSiEx4hD+cmlw+tFC8q9CXvNc8lAI1KQiAUBu4d12vCTe4CRBd9vtLLNABVrg86Y
         lZZbOFQ7oSUzqr3IPuDcEWzQwcn2raBvYa8JQAkZGkuyH6D0aO1a9LXWx4pW4nXON6Lm
         NmQcrFNt/zQuk0rNXNFMKIIRC5K2nWLtlGizuAEO1/me9Cu927NUuH5TAlKFBGQxVjmt
         iV4ERWExheL8qOdgLwND0KN5xVSAv97GG7zDXNAwP1AiwUilR00BZP+/0mesf+NMsmHn
         YJaucbCjV3cBkvGi6QYIF0tnm7FERHN9O1Xe0xAY3lmO2khrSrMsU+l9a0jruKQeqY1X
         ke0g==
X-Gm-Message-State: AOAM5328uo80PJwrZNjdF+PbsGfrd89EzjuytojPI/IrDYcl31pa99u9
        OSRHjVufuF04SNghYZ6V7Qkw69kk1AfXiG1qnEdr1A==
X-Google-Smtp-Source: ABdhPJw2OJ7VQfliCJ0/LvDl5j3aWobde24aTwoXE6TnbIU+ixmWhrNcMl0egFADMrKYzsAd02fTxmxSs78rb5jr5vE=
X-Received: by 2002:a2e:96da:: with SMTP id d26mr1938365ljj.25.1591186028318;
 Wed, 03 Jun 2020 05:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200603080304.16548-1-dietmar.eggemann@arm.com> <20200603080304.16548-5-dietmar.eggemann@arm.com>
In-Reply-To: <20200603080304.16548-5-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Jun 2020 14:06:56 +0200
Message-ID: <CAKfTPtBz8Du3=BhdHfxYY03v2FTqyVCNsd=p2z=6Vb9NqgkEiA@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: Remove unused 'sd' parameter from scale_rt_capacity()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 10:03, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Since commit 8ec59c0f5f49 ("sched/topology: Remove unused 'sd'
> parameter from arch_scale_cpu_capacity()") it is no longer needed.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5c4a559d0dae..7158d4e3c855 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8039,7 +8039,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>         };
>  }
>
> -static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
> +static unsigned long scale_rt_capacity(int cpu)
>  {
>         struct rq *rq = cpu_rq(cpu);
>         unsigned long max = arch_scale_cpu_capacity(cpu);
> @@ -8071,7 +8071,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>
>  static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>  {
> -       unsigned long capacity = scale_rt_capacity(sd, cpu);
> +       unsigned long capacity = scale_rt_capacity(cpu);
>         struct sched_group *sdg = sd->groups;
>
>         cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
> --
> 2.17.1
>
