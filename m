Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D25C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D8620672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSOPv6uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgF3OWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgF3OWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:22:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB67DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:22:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so22814056ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zh5OINLhqWxAVAI3s85IunN5mpLZEUsWBAJF+8N24bk=;
        b=LSOPv6uysLjXHjZxGzyYxK/f1G7RrhMgj1hYMh8qg0m8OIrYRw0f7e6l9fvBuzq2ev
         9muCwae9+BaYvTiJyjeYqjNEpA5ESQWZPkeIlOrChU0xRZgLNXTTTl/YSkMViWWFRbkF
         RHDhPjcKU0ivgL8sHJPa+2dcao4EuBY7RW/8AGW1Gu7hjfp7P0PDwFBQ6+h7+BCdReOZ
         oatei1b3v9JkJhH8PDTBrD3kQ+TMDBmrd3LadGalnj0LK7IwBPvUQs7f8OrGgFxHu6IK
         q+jIs77Pc0T83Pm7zyCsEka28gR/xQa8JqJ7/87eOLfV1y9kuRJ66p+Sy5fXu4lmq+MU
         qlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zh5OINLhqWxAVAI3s85IunN5mpLZEUsWBAJF+8N24bk=;
        b=tlAEw20zN59bxV5mIvSe6QuYYinqnfhXD67TObkz8K6anjgSxyb8wiz3HEpIhRxeHD
         k8U0aQzU9y2tJS9Z1wVMN9A+FfZUDUcJ6OIwQELX6I2+ZkDNDXRB91ymNjFfO38PPiLg
         tMqQp2otf/SJzDloDMhw8GC0CMAXo2bbGYAddLAPdHyhlFNS7u4ur7BdP8x118aaOAUh
         V9Wy3bhEUGX7meWMXriYGWG+DsCOW/05+wVCoTny76tDfskvVdNzYD07fnNBgXX47q2m
         5ZRswz/SG3JXxlGXu6pSrYeHyzb5TFtrTzHehT7GL+HxOlCCmsxtnHnbQsfm4opwLc0+
         Fnpg==
X-Gm-Message-State: AOAM5300vU8ZZVQb1xqoi5MBqjX0aWFB41/55teVUgmDnZB/hQrhW/T6
        UvOEZIKtcisLxZj6Mz4XAg7gmnBRg9+HPejvg3yqAg==
X-Google-Smtp-Source: ABdhPJxbViHHRDTisVJF/m/XNX2qAS8myfKLT5Ei6Azn3q5klVHXLd8fXceWXvmxhkhSsQwtbjfva+6qOVqoMRXL7yU=
X-Received: by 2002:a2e:3c0e:: with SMTP id j14mr10803410lja.25.1593526942071;
 Tue, 30 Jun 2020 07:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200421004749.GC26573@shao2-debian> <20200425012306.13516-1-hdanton@sina.com>
 <20200426124208.8872-1-hdanton@sina.com> <20200427113533.4688-1-hdanton@sina.com>
 <CAKfTPtABxPBmS6=qn96=7X5vfF0ae15M+RAiduH0sb11+gyKew@mail.gmail.com>
 <d50c9467-7b1b-346b-d4ab-107253a0a3ae@linux.intel.com> <BL0PR14MB377940B17C0889D725FF78599A9C0@BL0PR14MB3779.namprd14.prod.outlook.com>
 <d0faca7b-641a-e0e6-db89-443d88e2b3d8@linux.intel.com> <20200630074311.GA12788@vingu-book>
 <BL0PR14MB377920305EDF3047DCAF8B719A6F0@BL0PR14MB3779.namprd14.prod.outlook.com>
In-Reply-To: <BL0PR14MB377920305EDF3047DCAF8B719A6F0@BL0PR14MB3779.namprd14.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 30 Jun 2020 16:22:10 +0200
Message-ID: <CAKfTPtC6iTFGRQR-MHaBzv01=mscBLu14D4_R2esq2H5gYbPvQ@mail.gmail.com>
Subject: Re: [LKP] [sched/fair] 6c8116c914: stress-ng.mmapfork.ops_per_sec
 -38.0% regression
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Tue, 30 Jun 2020 at 11:41, Tao Zhou <ouwen210@hotmail.com> wrote:
>
> Hi,
>
> On Tue, Jun 30, 2020 at 09:43:11AM +0200, Vincent Guittot wrote:
> > Hi Tao,
> >
> > Le lundi 15 juin 2020 =C3=A0 16:14:01 (+0800), Xing Zhengjun a =C3=A9cr=
it :
> > >
> > >
> > > On 6/15/2020 1:18 PM, Tao Zhou wrote:
> >
> > ...
> >
> > > I apply the patch based on v5.7, the regression still existed.
> >
> >
> > Could you try the patch below  ? This patch is not a real fix because i=
t impacts performance of others benchmarks but it will at least narrow your=
 problem.
> >
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9f78eb76f6fb..a4d8614b1854 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8915,9 +8915,9 @@ find_idlest_group(struct sched_domain *sd, struct=
 task_struct *p, int this_cpu)
> >                  * and consider staying local.
> >                  */
> >
> > -               if ((sd->flags & SD_NUMA) &&
> > -                   ((idlest_sgs.avg_load + imbalance) >=3D local_sgs.a=
vg_load))
> > -                       return NULL;
> > +//             if ((sd->flags & SD_NUMA) &&
> > +//                 ((idlest_sgs.avg_load + imbalance) >=3D local_sgs.a=
vg_load))
> > +//                     return NULL;
>
> Just narrow to the fork (wakeup) path that maybe lead the problem, /me th=
ink.

The perf regression seems to be fixed with this patch on my setup.
According to the statistics that I have on the use case, groups are
overloaded but load is quite low and this low level hits this NUMA
specific condition

> Some days ago, I tried this patch:
>
>   https://lore.kernel.org/lkml/20200616164801.18644-1-peter.puhov@linaro.=
org/
>
> ---
>  kernel/sched/fair.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..abcbdf80ee75 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8662,8 +8662,14 @@ static bool update_pick_idlest(struct sched_group =
*idlest,
>
>         case group_has_spare:
>                 /* Select group with most idle CPUs */
> -               if (idlest_sgs->idle_cpus >=3D sgs->idle_cpus)
> +               if (idlest_sgs->idle_cpus > sgs->idle_cpus)
>                         return false;
> +
> +               /* Select group with lowest group_util */
> +               if (idlest_sgs->idle_cpus =3D=3D sgs->idle_cpus &&
> +                       idlest_sgs->group_util <=3D sgs->group_util)
> +                       return false;
> +
>                 break;
>         }
>
> --
>
> This patch is related to wake up slow path and group type is full_busy.

I tried it but haven't seen impacts on mmapfork test results

> What I tried that got improved:
>
> $> sysbench threads --threads=3D16 run
>
> The total num of event(high is better):
>
> v5.8-rc1      : 34020    34494     33561
> v5.8-rc1+patch: 35466    36184     36260
>
> $> perf bench -f simple sched pipe -l 4000000
>
> v5.8-rc1      : 16.203   16.238   16.150
> v5.8-rc1+patch: 15.757   15.930   15.819
>
> I also saw some regressions about other workloads(dont know much).
> So, suggest to test this patch about this stress-ng.mmapfork. I didn't do
> this yet.
>
> Another patch i want to mention here is this(merged to V5.7 now):
>
>   commit 68f7b5cc83 ("sched/cfs: change initial value of runnable_avg")
>
> And this regression happened based on V5.7. This patch is related to fork
> wake up path of overloaded type. Absolutely need to try then.
>
> Finally, I have given a patch that seems not related to fork wake up path=
,
> but I also tried it on some benchmark. But, did not saw improvement there=
.
> I also give this changed patch here(I realized that full_busy type idle c=
pu
> first but not sure). Maybe not need to try.
>
> Index: core.bak/kernel/sched/fair.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- core.bak.orig/kernel/sched/fair.c
> +++ core.bak/kernel/sched/fair.c
> @@ -9226,17 +9226,20 @@ static struct sched_group *find_busiest_
>                         goto out_balanced;
>
>                 if (busiest->group_weight > 1 &&
> -                   local->idle_cpus <=3D (busiest->idle_cpus + 1))
> -                       /*
> -                        * If the busiest group is not overloaded
> -                        * and there is no imbalance between this and bus=
iest
> -                        * group wrt idle CPUs, it is balanced. The imbal=
ance
> -                        * becomes significant if the diff is greater tha=
n 1
> -                        * otherwise we might end up to just move the imb=
alance
> -                        * on another group. Of course this applies only =
if
> -                        * there is more than 1 CPU per group.
> -                        */
> -                       goto out_balanced;
> +                   local->idle_cpus <=3D (busiest->idle_cpus + 1)) {
> +                       if (local->group_type =3D=3D group_has_spare) {
> +                               /*
> +                                * If the busiest group is not overloaded
> +                                * and there is no imbalance between this=
 and busiest
> +                                * group wrt idle CPUs, it is balanced. T=
he imbalance
> +                                * becomes significant if the diff is gre=
ater than 1
> +                                * otherwise we might end up to just move=
 the imbalance
> +                                * on another group. Of course this appli=
es only if
> +                                * there is more than 1 CPU per group.
> +                                */
> +                               goto out_balanced;
> +                       }
> +               }
>
>                 if (busiest->sum_h_nr_running =3D=3D 1)
>                         /*
>
>
> TBH, I don't know much about the below numbers.
>
> Thank you for the help!
>
> Thanks.
>
> >                 /*
> >                  * If the local group is less loaded than the selected
> >
> > --
> >
> >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/sc_pid_ma=
x/testtime/class/cpufreq_governor/ucode:
> > >
> > > lkp-bdw-ep6/stress-ng/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-=
7/100%/1HDD/4194304/1s/scheduler/performance/0xb000038
> > >
> > > commit:
> > >   e94f80f6c49020008e6fa0f3d4b806b8595d17d8
> > >   6c8116c914b65be5e4d6f66d69c8142eb0648c22
> > >   v5.7
> > >   c7e6d37f60da32f808140b1b7dabcc3cde73c4cc  (Tao's patch)
> > >
> > > e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c                        v=
5.7
> > > c7e6d37f60da32f808140b1b7da
> > > ---------------- --------------------------- ------------------------=
---
> > > ---------------------------
> > >          %stddev     %change         %stddev     %change %stddev     =
%change
> > > %stddev
> > >              \          |                \          |                =
\
> > > |                \
> > >     819250 =C2=B1  5%     -10.1%     736616 =C2=B1  8%     +41.2%    =
1156877 =C2=B1 3%
> > > +43.6%    1176246 =C2=B1  5%  stress-ng.futex.ops
> > >     818985 =C2=B1  5%     -10.1%     736460 =C2=B1  8%     +41.2%    =
1156215 =C2=B1 3%
> > > +43.6%    1176055 =C2=B1  5%  stress-ng.futex.ops_per_sec
> > >       1551 =C2=B1  3%      -3.4%       1498 =C2=B1  5%      -4.6%    =
   1480 =C2=B1 5%
> > > -14.3%       1329 =C2=B1 11%  stress-ng.inotify.ops
> > >       1547 =C2=B1  3%      -3.5%       1492 =C2=B1  5%      -4.8%    =
   1472 =C2=B1 5%
> > > -14.3%       1326 =C2=B1 11%  stress-ng.inotify.ops_per_sec
> > >      11292 =C2=B1  8%      -2.8%      10974 =C2=B1  8%      -9.4%    =
  10225 =C2=B1 6%
> > > -10.1%      10146 =C2=B1  6%  stress-ng.kill.ops
> > >      11317 =C2=B1  8%      -2.6%      11023 =C2=B1  8%      -9.1%    =
  10285 =C2=B1 5%
> > > -10.3%      10154 =C2=B1  6%  stress-ng.kill.ops_per_sec
> > >      28.20 =C2=B1  4%     -35.4%      18.22           -33.4%      18.=
77
> > > -27.7%      20.40 =C2=B1  9%  stress-ng.mmapfork.ops_per_sec
> > >    2999012 =C2=B1 21%     -10.1%    2696954 =C2=B1 22%     -88.5%    =
 344447 =C2=B1 11%
> > > -87.8%     364932        stress-ng.tee.ops_per_sec
> > >       7882 =C2=B1  3%      -5.4%       7458 =C2=B1  4%      -2.0%    =
   7724 =C2=B1 3%
> > > -2.2%       7709 =C2=B1  4%  stress-ng.vforkmany.ops
> > >       7804 =C2=B1  3%      -5.2%       7400 =C2=B1  4%      -2.0%    =
   7647 =C2=B1 3%
> > > -2.1%       7636 =C2=B1  4%  stress-ng.vforkmany.ops_per_sec
> > >   46745421 =C2=B1  3%      -8.1%   42938569 =C2=B1  3%      -5.2%   4=
4312072 =C2=B1 4%
> > > -2.3%   45648193        stress-ng.yield.ops
> > >   46734472 =C2=B1  3%      -8.1%   42926316 =C2=B1  3%      -5.2%   4=
4290338 =C2=B1 4%
> > > -2.4%   45627571        stress-ng.yield.ops_per_sec
> > >
> > >
> > >
> >
> > ...
> >
> > > --
> > > Zhengjun Xing
