Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F00C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382DF20767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8NsXpi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406596AbgDNHZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406586AbgDNHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:25:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FDC0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:25:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so8564673lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHQRVLx2SQE97Miej6QF7cUPumlWCc/r2El9sm1eyXs=;
        b=e8NsXpi76Rw/tiin1JzdrQpBcrU9kxharw4P9vLp4+s/4Nxgq/gt94GfOrLTlX2P6g
         VVK4LM957BsdVnvgl4CiM6Hf0LG1YeE9TTi7YSM6QFUq1EsQyy1MU8jn2/fcjLkRT3Ia
         3p3GlrMqYaqOw/i+afDcQmSktbbecV1sPdm54E+I9JNu+bRahftGolJ2yW9sP58U2n3K
         cErgYMMd/nQ0PCfotNMEHwvNKoTReFI53nBr5Ue+mn+NC0yDl09yFLlgZgIGWDhLlHPW
         1X04WLPRrvBWx0OLp0n43KUbNCiz2tX4+wmXsXoAlOXYaGlMZokpG7X88GFzxDgszBw6
         wgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHQRVLx2SQE97Miej6QF7cUPumlWCc/r2El9sm1eyXs=;
        b=DJ0MZMR+t9BQAuFCIiA01Np7DgYU5RvruhjeZkcGLnjzZFhKBkWZZ16zSmiUjC3P2w
         xDcQlihPrU7rebxvk4gkLligXHjkFNxRklkW55198UxCr4HbDe+tTKbnjbiOkkvqRmp9
         0XrDyaOQHqzI6huxDwPj4EoJWT5GNdiQ7sq6VpIsTnMxZD8g23nwiNM9bhD8uuvpdMZt
         v1T2wdSyC9R7gIt91bXWAOtIS69jjHW2U4GsAZAuiZd5GxR2G98iMoWfRn8i2u6qsWjs
         kLuC0YmlOst/6m3CXfBAZsGgbfvdpxAscBEo0rr4T4E4ElqOd0AcyyGFcMc/TS58gaug
         Y+Pg==
X-Gm-Message-State: AGi0PuZOGLs9ygcUfO5HZ8/twvBReYWMeSXOt5WujLaJDZaW8xU0v65z
        IWw9DZoxZcWdCt9SZgLzpPifHxh87B8wa8UCkrG1vA==
X-Google-Smtp-Source: APiQypLYaTOthXSy3n7THDlx64ApeKgxwQDUiujJJb0LK5f4zaNGIhrCuhRYtlBIH8kcGiw/EBRNkfsVpKTppHVDBjU=
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr13077605lfo.149.1586849111586;
 Tue, 14 Apr 2020 00:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com>
In-Reply-To: <245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Apr 2020 09:25:00 +0200
Message-ID: <CAKfTPtBLc7Y-a-nuXF-p8wEaJQLiQn4crOg6R0Z4NBJ64yMLBg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Simplify the code of should_we_balance()
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, uri.lelli@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Apr 2020 at 11:21, Peng Wang <rocking@linux.alibaba.com> wrote:
>
> We only consider group_balance_cpu() after there is no idle
> cpu. So, just do comparison before return at these two cases.
>
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>

With the small fix in the comment below
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1ea3ddd..81b2c647 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9413,7 +9413,7 @@ static int active_load_balance_cpu_stop(void *data);
>  static int should_we_balance(struct lb_env *env)
>  {
>         struct sched_group *sg = env->sd->groups;
> -       int cpu, balance_cpu = -1;
> +       int cpu;
>
>         /*
>          * Ensure the balancing environment is consistent; can happen
> @@ -9434,18 +9434,12 @@ static int should_we_balance(struct lb_env *env)
>                 if (!idle_cpu(cpu))
>                         continue;
>
> -               balance_cpu = cpu;
> -               break;
> +               /* Are we the first idle CPU? */
> +               return cpu == env->dst_cpu;
>         }
>
> -       if (balance_cpu == -1)
> -               balance_cpu = group_balance_cpu(sg);
> -
> -       /*
> -        * First idle CPU or the first CPU(busiest) in this sched group
> -        * is eligible for doing load balancing at this and above domains.
> -        */
> -       return balance_cpu == env->dst_cpu;
> +       /* Are we the first balance CPU of this group? */

/* Are we the first CPU of this group ? */

> +       return group_balance_cpu(sg) == env->dst_cpu;
>  }
>
>  /*
> --
> 2.9.5
>
