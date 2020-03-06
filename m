Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48ABC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B5920848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flGi9naM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCFPG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:06:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45302 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgCFPG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:06:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id e18so2521607ljn.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 07:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HDzaXzxxLYUrn3GPFNsbIyfPdJnKtK/whxE91ORURCc=;
        b=flGi9naMgZ3cXPY2kE4gBsm03tlbpD/xvruyRJWJC0xBOgkTEAeOjE9Rk51U4yrZ12
         1QEOzwhXQHtJqOeY8+M6h+I9rug0fH4VaQvYmrCqj1dUUAZk8nn644/TXTkG0058gJCr
         yKBT/Ye8/4LooN4T2IEInrGgbxpIcYhWEL4j0rr61O9b4kO8a5Rf/64oEqSDNKuvcR+c
         fcSwV4wGsfpdq9S9NCql/Uk5YxZ3DjU71iaFXnmum8+u7FaX/wdDljH0usmud/wsbQy3
         sVzWl7hSKM8+xI4seOlkTl2KgByHxSh3iLUhdWT1FyLc0atYYPVrS7CLSI76J1Q0Xp3c
         Mvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HDzaXzxxLYUrn3GPFNsbIyfPdJnKtK/whxE91ORURCc=;
        b=q3n8MISyhJumw+I9v/anPtrfSr3ViHkneNnvudymTDDkdgCDH/jEIiyLzXh04Os5AP
         SJU5cPijjhlgxt8BBX/PT9GLp3iEeDT6KcXWEwejgcb1ZEoo7SZB8istCDS5YkV0iXZF
         BN6URpoDaKu4l/Uebl8gIYKj+TQb/wDdsIbKtIis7fe1PTCHwHCKqGu0nIgmP0z5EaCq
         YFbEBW+0Y630pNItfAw773NXC8pGERqxwqwQ7euQbzNoJgW8gYHjYNaob/Wj8+A9QhIT
         AtkC7mpu+eeLavCiqz6a2OFat0D6yhGYlb+fbnSF6XWdvPNjiHKJQHJuTJ04WdC9TL0o
         wMfA==
X-Gm-Message-State: ANhLgQ35csZvnZHBRzWRvtxn83Xh3Ge/zcZCJxjnHsUu9v2O6akVx7yV
        1GmTJ5DSFQFd3QdPRCFJ5vMAZCWFdc5L9EdMWbVWGg==
X-Google-Smtp-Source: ADFU+vtszizaVHFKYfQaEqNZqyuZaX9ujZwolXIPaU3X9+/GNEpBFayStkFmPfsNN6ibQlssTyv1Ufh1GBLGP9Yd0i0=
X-Received: by 2002:a2e:8112:: with SMTP id d18mr2223030ljg.137.1583507184315;
 Fri, 06 Mar 2020 07:06:24 -0800 (PST)
MIME-Version: 1.0
References: <bb14528b-08c3-c4c0-5bcf-4bec1d75227a@linux.alibaba.com>
In-Reply-To: <bb14528b-08c3-c4c0-5bcf-4bec1d75227a@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Mar 2020 16:06:12 +0100
Message-ID: <CAKfTPtAt43DOT2AnRLyO5tqxDGhaCqFKOc1Ws+WSt2NLtGQ9UQ@mail.gmail.com>
Subject: Re: [PATCH] sched: avoid scale real weight down to zero
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 03:57, =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com=
> wrote:
>
> During our testing, we found a case that shares no longer
> working correctly, the cgroup topology is like:
>
>   /sys/fs/cgroup/cpu/A          (shares=3D102400)
>   /sys/fs/cgroup/cpu/A/B        (shares=3D2)
>   /sys/fs/cgroup/cpu/A/B/C      (shares=3D1024)
>
>   /sys/fs/cgroup/cpu/D          (shares=3D1024)
>   /sys/fs/cgroup/cpu/D/E        (shares=3D1024)
>   /sys/fs/cgroup/cpu/D/E/F      (shares=3D1024)
>
> The same benchmark is running in group C & F, no other tasks are
> running, the benchmark is capable to consumed all the CPUs.
>
> We suppose the group C will win more CPU resources since it could
> enjoy all the shares of group A, but it's F who wins much more.
>
> The reason is because we have group B with shares as 2, since
> A->cfs_rq.load.weight =3D=3D B->se.load.weight =3D=3D B->shares/nr_cpus,
> so A->cfs_rq.load.weight become very small.
>
> And in calc_group_shares() we calculate shares as:
>
>   load =3D max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg=
);
>   shares =3D (tg_shares * load) / tg_weight;
>
> Since the 'cfs_rq->load.weight' is too small, the load become 0
> after scale down, although 'tg_shares' is 102400, shares of the se
> which stand for group A on root cfs_rq become 2.
>
> While the se of D on root cfs_rq is far more bigger than 2, so it
> wins the battle.
>
> Thus when scale_load_down() scale real weight down to 0, it's no
> longer telling the real story, the caller will have the wrong
> information and the calculation will be buggy.
>
> This patch add check in scale_load_down(), so the real weight will
> be >=3D MIN_SHARES after scale, after applied the group C wins as
> expected.
>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/sched.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2a0caf394dd4..75c283f22256 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -118,7 +118,13 @@ extern long calc_load_fold_active(struct rq *this_rq=
, long adjust);
>  #ifdef CONFIG_64BIT
>  # define NICE_0_LOAD_SHIFT     (SCHED_FIXEDPOINT_SHIFT + SCHED_FIXEDPOIN=
T_SHIFT)
>  # define scale_load(w)         ((w) << SCHED_FIXEDPOINT_SHIFT)
> -# define scale_load_down(w)    ((w) >> SCHED_FIXEDPOINT_SHIFT)
> +# define scale_load_down(w) \
> +({ \
> +       unsigned long __w =3D (w); \
> +       if (__w) \
> +               __w =3D max(MIN_SHARES, __w >> SCHED_FIXEDPOINT_SHIFT); \
> +       __w; \
> +})
>  #else
>  # define NICE_0_LOAD_SHIFT     (SCHED_FIXEDPOINT_SHIFT)
>  # define scale_load(w)         (w)
> --
> 2.14.4.44.g2045bb6
>
