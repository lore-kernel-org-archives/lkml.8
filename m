Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9EC206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMS49H5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEDHxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDHxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:53:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF36BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 00:53:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so8701918ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 00:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmXGi3GpP/NWw/x5EeBfh2CHXXIxEQ6XPHMrgxKeMTQ=;
        b=eMS49H5UTt/uzOOGrd44QxN8eOb6fq0hkRXyeaMqi8xL3G25gwvdk8XTDEI2XWeWPy
         zWZ6guNxob8E0Jwpm/pE6crthlJ7YwmkpjWYG4wjWzSKvX7J+fj+N2kmyXJCM/ZhRu2A
         YBT/LtdcOOzwODqpopZ8E/IrDG9Md0vA4O3B3Pu9ATO117TZhPvzRpRMAWZFdykww1Ge
         pUv0BmtrBso9L6tMXjMAFsisZ77UbeyQz5C5ElIMa5ExYdAGclfJjGRZ7V1r3bj7jGVY
         VRR2jtAAD/zroipjKmj7lVS6S7OIkZi2O7anJJ6D1Ly2ghYJhRjMSLlty1vcMcnbPxsQ
         TDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmXGi3GpP/NWw/x5EeBfh2CHXXIxEQ6XPHMrgxKeMTQ=;
        b=Qf++3HWcKNrB6c6Q9scrQS7mlfEXn8JQ7nDvAHOoEeX6NeYXbjHZpNdcNGRxzT4/r5
         G+AbXHnkCOcY1FR/1e91Yk+bbdUpgVDP2svxltLnm4lU/OgaNtyOknXICgLvV4PkNip0
         9yHazHWAuTFxLF2zZRmLgw/53/Wdjt4FpUHuNcLasVBs/oqjagVKxSh9cjMbSw/l9cOv
         uwQShSUVHePwI2kXfl7YOPuL8ylzsMrh/b5t6a/na8xFHe8yeejaTKFNSutjxS2h11IY
         WdH3612hCIbL/ljWv94TV2W50xOL5mdIth3xBFWtDAlFifqVtEPJ9aPID7iMpfHDnraj
         eY9g==
X-Gm-Message-State: AGi0PuakQJWFON2AFMcI19Hqar90FnIqNj9skM93Ur7KCmk+gqt72NXd
        spI9H27GMEmAFQhUWbv0JFqUliKTTPWOCJwtfNQwCNXMJUg=
X-Google-Smtp-Source: APiQypKNLqUCReBS+vFry0LD76xdsoPJXx/J6gLLBL1gNM0yxRkWxkjQDSJfoU7Crke/c7fcR6aLKtHPBhPZi8dAkYk=
X-Received: by 2002:a2e:3209:: with SMTP id y9mr8957526ljy.154.1588578828316;
 Mon, 04 May 2020 00:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200504015704.6952-1-hdanton@sina.com>
In-Reply-To: <20200504015704.6952-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 May 2020 09:53:36 +0200
Message-ID: <CAKfTPtA3wVD3X7+HqTs-ovSQ8FmZRyryAFb2zzUm4kAbPo4+tw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: correct llc shared domain's number of
 busy CPUs
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 at 03:57, Hillf Danton <hdanton@sina.com> wrote:
>
>
> The comment says, if there is an imbalance between LLC domains (IOW we
> could increase the overall cache use),  we need some less-loaded LLC
> domain to pull some load.
>
> To show that imbalance, record busy CPUs as they come and go by doing
> a minor cleanup for sd::nohz_idle.

Your comment failed to explain why we can get rid of sd->nohz_idle

>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10138,13 +10138,8 @@ static void set_cpu_sd_state_busy(int cp
>
>         rcu_read_lock();
>         sd = rcu_dereference(per_cpu(sd_llc, cpu));
> -
> -       if (!sd || !sd->nohz_idle)
> -               goto unlock;
> -       sd->nohz_idle = 0;

you remove the use of sd->nohz_idle but you don't remove it from
struct sched_domain

> -
> -       atomic_inc(&sd->shared->nr_busy_cpus);
> -unlock:
> +       if (sd)
> +               atomic_inc(&sd->shared->nr_busy_cpus);
>         rcu_read_unlock();
>  }
>
> @@ -10168,13 +10163,8 @@ static void set_cpu_sd_state_idle(int cp
>
>         rcu_read_lock();
>         sd = rcu_dereference(per_cpu(sd_llc, cpu));
> -
> -       if (!sd || sd->nohz_idle)
> -               goto unlock;
> -       sd->nohz_idle = 1;
> -
> -       atomic_dec(&sd->shared->nr_busy_cpus);
> -unlock:
> +       if (sd)
> +               atomic_dec(&sd->shared->nr_busy_cpus);
>         rcu_read_unlock();
>  }
>
>
