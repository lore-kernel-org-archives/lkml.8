Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA67BC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A7D2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aa1Dej3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD0JEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgD0JEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:04:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F3DC061A41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:04:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b2so16705036ljp.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rydwbdaoje7MZkccmx6moHONOQ/I4uRhTduHZ8udciY=;
        b=Aa1Dej3nfI6OjBce4bcO7gX9gTJQQO8b5pd+OHcnl3RkIp+iil/bEd9umIFXVU7o9u
         3EoKlTpF67u+/DYGIsDR5vtBWBd9co/A+YtH4zvw6NXeA52avNtjmUlOuJVr40G394ts
         SyhcG1Uze5Glpv0iw5rAAGtl8VZUTRSZ2NnJfcSg8vQLicRCewvqj+qOd4hqolCQNeHz
         +deoh+hiYrRgpT2Bj2o1+/Uan+TQs5IXR1e30VZQCgvpTj78Hx1s/FEc2JNfglFtVF4a
         Hvp9hmEif+RMdSfR+gXd23s1Jtgj+5fPBRobyrMpjwgnmFx+LqXMH2z1yThqislMSIK+
         9ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rydwbdaoje7MZkccmx6moHONOQ/I4uRhTduHZ8udciY=;
        b=T8vueULKuVVLLfUeRzAf8Xnqz937rM19lzHiW7jPT7GlPomdye3p02bB5k5BQNfdaC
         Dti01XRVI50hPeiaFK6MW5VRWcIxgh8q0XtniE35tIJkQVY+3D+AcHuBzySQ13sE7MZj
         IKrj8VPt01kl8jG8drBTBQ7HGZlQ+uTA9r6BO5ORmHoQEYUGvDxXCGvsffzQXpE+h69N
         tr1o3B+WY5pupKC66eAo9DWZammLBN5xIkFZ+4uKQH2/2AeHzZlHawP1M972vgMMDO8v
         xRMqNc7E+JzjKUkk0yYkQ5rczgs8MDTtqP1WnHhHjSq23WCti7kGLLyPv6VFpObdlCcF
         63mQ==
X-Gm-Message-State: AGi0Pua8g1RPojUNZSrksANsZbaZP8bJgqxFT7DIXXyAnFwf/bz7xeTd
        S4c+unhN5Qls+tEfq8hn8C/aLFOa1iFWfahzanGmow==
X-Google-Smtp-Source: APiQypL+qnAEryBX91teGvr/Jpek4pNl5NTRYSAAc3aCTsdpogjlQ76SHR7A02Mai03Nq5ntTYUfkIeATXUiW5uN3CU=
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr13838553ljh.65.1587978250291;
 Mon, 27 Apr 2020 02:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200421004749.GC26573@shao2-debian> <20200425012306.13516-1-hdanton@sina.com>
 <20200426124208.8872-1-hdanton@sina.com>
In-Reply-To: <20200426124208.8872-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Apr 2020 11:03:58 +0200
Message-ID: <CAKfTPtD1ES2-Jd1cW2XctRmhuJ_2Nh+oJeA8jF9UYgBW8+8-Yg@mail.gmail.com>
Subject: Re: [LKP] [sched/fair] 6c8116c914: stress-ng.mmapfork.ops_per_sec
 -38.0% regression
To:     Hillf Danton <hdanton@sina.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Tao Zhou <ouwen210@hotmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020 at 14:42, Hillf Danton <hdanton@sina.com> wrote:
>
>
> On 4/21/2020 8:47 AM, kernel test robot wrote:
> >
> > Greeting,
> >
> > FYI, we noticed a 56.4% improvement of stress-ng.fifo.ops_per_sec due to commit:
> >
> >
> > commit: 6c8116c914b65be5e4d6f66d69c8142eb0648c22 ("sched/fair: Fix condition of avg_load calculation")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: stress-ng
> > on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
> > with following parameters:
> >
> >     nr_threads: 100%
> >     disk: 1HDD
> >     testtime: 1s
> >     class: scheduler
> >     cpufreq_governor: performance
> >     ucode: 0xb000038
> >     sc_pid_max: 4194304
> >
>
> We need to handle group_fully_busy in a different way from
> group_overloaded as task push does not help grow load balance
> in the former case.

Have you tested this patch for the UC above ? Do you have figures ?

>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8744,30 +8744,20 @@ find_idlest_group(struct sched_domain *s
>
>         switch (local_sgs.group_type) {
>         case group_overloaded:
> -       case group_fully_busy:
> -               /*
> -                * When comparing groups across NUMA domains, it's possible for
> -                * the local domain to be very lightly loaded relative to the
> -                * remote domains but "imbalance" skews the comparison making
> -                * remote CPUs look much more favourable. When considering
> -                * cross-domain, add imbalance to the load on the remote node
> -                * and consider staying local.
> -                */
> -
> -               if ((sd->flags & SD_NUMA) &&
> -                   ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
> +               if (100 * local_sgs.avg_load <= sd->imbalance_pct * (idlest_sgs.avg_load + imbalance))
> +                       return idlest;

So you have completely removed the NUMA special case without explaining why.

And you have also removed the tests for small load.

Could you explain the rationale behind all these changes ?

Also keep in mind that the current version provide +58% improvement
for  stress-ng.fifo

> +               if (local_sgs.avg_load > idlest_sgs.avg_load + imbalance)
> +                       return idlest;
> +               else
>                         return NULL;
>
> +       case group_fully_busy:
>                 /*
> -                * If the local group is less loaded than the selected
> -                * idlest group don't try and push any tasks.
> +                * Pushing task to the idlest group will make the target group
> +                * overloaded, leaving the local group that is overloaded fully busy,
> +                * thus we earn nothing except for the exchange of group types.

For this case both local and idlest are fully busy and in this case
one will become overloaded so you must compare the load to be fair in
the spread of load

>                  */
> -               if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
> -                       return NULL;
> -
> -               if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
> -                       return NULL;
> -               break;
> +               return NULL;
>
>         case group_imbalanced:
>         case group_asym_packing:
>
