Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C278C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF602078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CN/wEmnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGJMsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgGJMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:48:45 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11997C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:48:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t9so3123542lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FAm94GcaPOlyzYPJgr8ARkdG4/rF473t+fBKKsq/5Cs=;
        b=CN/wEmnzgzyOwpKiOj5PFGggQgRaEfhODmHk7IckMjC8x04g1CUuR3M5173Z8eBnWV
         4V6SLjiQKVlBW41fMgakrssvcWKI5qOr2CnJeYpu69iA8R/J9ipFV89sVMLv3Q89nH+K
         zgcwhbAgDoLtUsIu+YPIpc+Rax0PG1t/Fskmnly/9+BuD2Fi9osP4mFtYrPxo9bSSv7l
         1iX0CEPg4ZKYwK4qNHgq6uxrZP0LgIFEc8QM1QCi1wwfXvLaMvZ4f/XPLy3btUSPuVgo
         q5ppk+n3v32K9wSr+A/UbQ9TLs+3AsXBY/uXwaVqQ+Jkq4YIFCCcN5tELSMkSev1Oi9k
         WHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FAm94GcaPOlyzYPJgr8ARkdG4/rF473t+fBKKsq/5Cs=;
        b=NGFQl/F1vHk70BgNrwXdmgAPIykdgJoJ2OehX6H5lZWM5CT/z21N0FTlBAgf5Ur7zV
         RIywP6obhkbE9EyuuA2y+s4QX90qwgcNq7Ut09qx1uaKxIqQDs+3eFek7dMWZihHIrs8
         XE2IlKLkzEFwVSdeK5SHEav/1L/2lWCjpc75V9i5+T7lw9LhFTWD+wM8blZqXFqQsqFH
         XyVhDq3TBkJxNAwFCzMtjL/Qfqks9R9nv6qsUbPq8AOEn8uVX0PBKPWvIe/sSHSTg5Ls
         xpeWMbztC3I/fmDCZkzhu4ynYir1ENOPr9fH10b4z0w/PErLi3RhIve8nKKR9uffvFFE
         CgNg==
X-Gm-Message-State: AOAM530OMUnJ2lHtcYcrF/u4mi9/uc77vL3lf7vzaRhcPo2K+24RXrKn
        mtGlvz16ClU9kDk/T/x0k5iaNQEY0TK4ZabdE+4Jeg==
X-Google-Smtp-Source: ABdhPJwQQoS4CHuoezz/NL6dd9/ji2cRp+8Dm+PUbiiGm26PGCVe42sqPw3f3OzAyOzYxvFZ/FY2KCnHzi7WuiMbvmw=
X-Received: by 2002:a05:6512:3153:: with SMTP id s19mr30803670lfi.25.1594385323409;
 Fri, 10 Jul 2020 05:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200425012306.13516-1-hdanton@sina.com> <20200426124208.8872-1-hdanton@sina.com>
 <20200427113533.4688-1-hdanton@sina.com> <CAKfTPtABxPBmS6=qn96=7X5vfF0ae15M+RAiduH0sb11+gyKew@mail.gmail.com>
 <d50c9467-7b1b-346b-d4ab-107253a0a3ae@linux.intel.com> <BL0PR14MB377940B17C0889D725FF78599A9C0@BL0PR14MB3779.namprd14.prod.outlook.com>
 <d0faca7b-641a-e0e6-db89-443d88e2b3d8@linux.intel.com> <20200630074311.GA12788@vingu-book>
 <BL0PR14MB377920305EDF3047DCAF8B719A6F0@BL0PR14MB3779.namprd14.prod.outlook.com>
 <CAKfTPtC6iTFGRQR-MHaBzv01=mscBLu14D4_R2esq2H5gYbPvQ@mail.gmail.com> <BL0PR14MB37795DCF260BAF4EB2648BE89A650@BL0PR14MB3779.namprd14.prod.outlook.com>
In-Reply-To: <BL0PR14MB37795DCF260BAF4EB2648BE89A650@BL0PR14MB3779.namprd14.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Jul 2020 14:48:32 +0200
Message-ID: <CAKfTPtCVCAwBuY__vuginEACWHhShJ-j+Un_rogU7qx4Aj7JLQ@mail.gmail.com>
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

On Fri, 10 Jul 2020 at 14:08, Tao Zhou <ouwen210@hotmail.com> wrote:
>
> Hi Vincent,
>
> Sorry for this so late reply.
>
> On Tue, Jun 30, 2020 at 04:22:10PM +0200, Vincent Guittot wrote:
> > Hi Tao,
> >
> > On Tue, 30 Jun 2020 at 11:41, Tao Zhou <ouwen210@hotmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Jun 30, 2020 at 09:43:11AM +0200, Vincent Guittot wrote:
> > > > Hi Tao,
> > > >
> > > > Le lundi 15 juin 2020 =C3=A0 16:14:01 (+0800), Xing Zhengjun a =C3=
=A9crit :
> > > > >
> > > > >
> > > > > On 6/15/2020 1:18 PM, Tao Zhou wrote:
> > > >
> > > > ...
> > > >
> > > > > I apply the patch based on v5.7, the regression still existed.
> > > >
> > > >
> > > > Could you try the patch below  ? This patch is not a real fix becau=
se it impacts performance of others benchmarks but it will at least narrow =
your problem.
> > > >
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 9f78eb76f6fb..a4d8614b1854 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -8915,9 +8915,9 @@ find_idlest_group(struct sched_domain *sd, st=
ruct task_struct *p, int this_cpu)
> > > >                  * and consider staying local.
> > > >                  */
> > > >
> > > > -               if ((sd->flags & SD_NUMA) &&
> > > > -                   ((idlest_sgs.avg_load + imbalance) >=3D local_s=
gs.avg_load))
> > > > -                       return NULL;
> > > > +//             if ((sd->flags & SD_NUMA) &&
> > > > +//                 ((idlest_sgs.avg_load + imbalance) >=3D local_s=
gs.avg_load))
> > > > +//                     return NULL;
> > >
> > > Just narrow to the fork (wakeup) path that maybe lead the problem, /m=
e think.
> >
> > The perf regression seems to be fixed with this patch on my setup.
> > According to the statistics that I have on the use case, groups are
> > overloaded but load is quite low and this low level hits this NUMA
> > specific condition
>
> My box has 1 Socket, 4 Core, 2 Threads per core and 2x4 CPUS.
> (x86_64 Intel(R) Core(TM) i7-6700HQ)

The change above only applies to NUMA system which doesn't seems to be
the case for your setup

>
> stress-ng.mmapfork
>
> v5.8-rc4:
>
> stress-ng: info:  [7158] dispatching hogs: 8 mmapfork
> stress-ng: info:  [7158] successful run completed in 1.09s
> stress-ng: info:  [7158] stressor       bogo ops real time  usr time  sys=
 time   bogo ops/s   bogo ops/s
> stress-ng: info:  [7158]                           (secs)    (secs)    (s=
ecs)   (real time) (usr+sys time)
> stress-ng: info:  [7158] mmapfork             32      1.09      2.48     =
 6.01        29.36         3.77
> stress-ng: info:  [7158] for a 1.09s run time:
> stress-ng: info:  [7158]       8.73s available CPU time
> stress-ng: info:  [7158]       2.52s user time   ( 28.86%)
> stress-ng: info:  [7158]       6.07s system time ( 69.52%)
> stress-ng: info:  [7158]       8.59s total time  ( 98.38%)
> stress-ng: info:  [7158] load average: 0.52 0.26 0.10
>
> v5.8-rc4 w/ above patch:
>
> stress-ng: info:  [5126] dispatching hogs: 8 mmapfork
> stress-ng: info:  [5126] successful run completed in 1.07s
> stress-ng: info:  [5126] stressor       bogo ops real time  usr time  sys=
 time   bogo ops/s   bogo ops/s
> stress-ng: info:  [5126]                           (secs)    (secs)    (s=
ecs)   (real time) (usr+sys time)
> stress-ng: info:  [5126] mmapfork             32      1.07      2.45     =
 5.96        29.88         3.80
> stress-ng: info:  [5126] for a 1.07s run time:
> stress-ng: info:  [5126]       8.58s available CPU time
> stress-ng: info:  [5126]       2.49s user time   ( 29.02%)
> stress-ng: info:  [5126]       6.02s system time ( 70.17%)
> stress-ng: info:  [5126]       8.51s total time  ( 99.19%)
> stress-ng: info:  [5126] load average: 0.31 0.22 0.09
>
> No obvious changes.

Yeah, the problem happens for system with several numa nodes

>
> And I traced and also tried to find the task_h_load =3D 0 after the patch=
 you sent.
>
> I used the command:
>
> trace-cmd record -e sched -e irq -e cpu_idle -e cpu_frequency -e timer cg=
exec -g cpu:A\
> stress-ng --timeout 1 --times --verify--metrics-brief --sequential 8 --cl=
ass scheduler\
> --exclude (all exclude but mmapfork)
>
>            <...>-26132 [000]  6571.361156: bprint:               task_h_l=
oad: cfs_rq->h_load:119, p->load_avg:26, cfs_rq->load_avg:14487
>            <...>-26132 [000]  6571.361156: bprint:               load_bal=
ance: detach_task migrate_load: task_h_load orginal: 0
>
> If cgroup has three levels(first tried), I can not find the task_h_load =
=3D 0 case.

Your system is is not large enough to face the problem

> group se's weight is relate to the task_group's share.
> task's weight is its weight.
>
>         if (!tg->parent) {
>                 load =3D cpu_rq(cpu)->load.weight;
>         } else {
>                 load =3D tg->parent->cfs_rq[cpu]->h_load;
>                 load *=3D tg->cfs_rq[cpu]->shares;
>                 load /=3D tg->parent->cfs_rq[cpu]->load.weight + 1;
>         }
>
> I must reply to you even not find any clue. I falled in the trace flow.
>
> Thanks,
> Tao
>
> > > Some days ago, I tried this patch:
> > >
> > >   https://lore.kernel.org/lkml/20200616164801.18644-1-peter.puhov@lin=
aro.org/
> > >
> > > ---
> > >  kernel/sched/fair.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 02f323b85b6d..abcbdf80ee75 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8662,8 +8662,14 @@ static bool update_pick_idlest(struct sched_gr=
oup *idlest,
> > >
> > >         case group_has_spare:
> > >                 /* Select group with most idle CPUs */
> > > -               if (idlest_sgs->idle_cpus >=3D sgs->idle_cpus)
> > > +               if (idlest_sgs->idle_cpus > sgs->idle_cpus)
> > >                         return false;
> > > +
> > > +               /* Select group with lowest group_util */
> > > +               if (idlest_sgs->idle_cpus =3D=3D sgs->idle_cpus &&
> > > +                       idlest_sgs->group_util <=3D sgs->group_util)
> > > +                       return false;
> > > +
> > >                 break;
> > >         }
> > >
> > > --
> > >
> > > This patch is related to wake up slow path and group type is full_bus=
y.
> >
> > I tried it but haven't seen impacts on mmapfork test results
> >
> > > What I tried that got improved:
> > >
> > > $> sysbench threads --threads=3D16 run
> > >
> > > The total num of event(high is better):
> > >
> > > v5.8-rc1      : 34020    34494     33561
> > > v5.8-rc1+patch: 35466    36184     36260
> > >
> > > $> perf bench -f simple sched pipe -l 4000000
> > >
> > > v5.8-rc1      : 16.203   16.238   16.150
> > > v5.8-rc1+patch: 15.757   15.930   15.819
> > >
> > > I also saw some regressions about other workloads(dont know much).
> > > So, suggest to test this patch about this stress-ng.mmapfork. I didn'=
t do
> > > this yet.
> > >
> > > Another patch i want to mention here is this(merged to V5.7 now):
> > >
> > >   commit 68f7b5cc83 ("sched/cfs: change initial value of runnable_avg=
")
> > >
> > > And this regression happened based on V5.7. This patch is related to =
fork
> > > wake up path of overloaded type. Absolutely need to try then.
> > >
> > > Finally, I have given a patch that seems not related to fork wake up =
path,
> > > but I also tried it on some benchmark. But, did not saw improvement t=
here.
> > > I also give this changed patch here(I realized that full_busy type id=
le cpu
> > > first but not sure). Maybe not need to try.
> > >
> > > Index: core.bak/kernel/sched/fair.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- core.bak.orig/kernel/sched/fair.c
> > > +++ core.bak/kernel/sched/fair.c
> > > @@ -9226,17 +9226,20 @@ static struct sched_group *find_busiest_
> > >                         goto out_balanced;
> > >
> > >                 if (busiest->group_weight > 1 &&
> > > -                   local->idle_cpus <=3D (busiest->idle_cpus + 1))
> > > -                       /*
> > > -                        * If the busiest group is not overloaded
> > > -                        * and there is no imbalance between this and=
 busiest
> > > -                        * group wrt idle CPUs, it is balanced. The i=
mbalance
> > > -                        * becomes significant if the diff is greater=
 than 1
> > > -                        * otherwise we might end up to just move the=
 imbalance
> > > -                        * on another group. Of course this applies o=
nly if
> > > -                        * there is more than 1 CPU per group.
> > > -                        */
> > > -                       goto out_balanced;
> > > +                   local->idle_cpus <=3D (busiest->idle_cpus + 1)) {
> > > +                       if (local->group_type =3D=3D group_has_spare)=
 {
> > > +                               /*
> > > +                                * If the busiest group is not overlo=
aded
> > > +                                * and there is no imbalance between =
this and busiest
> > > +                                * group wrt idle CPUs, it is balance=
d. The imbalance
> > > +                                * becomes significant if the diff is=
 greater than 1
> > > +                                * otherwise we might end up to just =
move the imbalance
> > > +                                * on another group. Of course this a=
pplies only if
> > > +                                * there is more than 1 CPU per group=
.
> > > +                                */
> > > +                               goto out_balanced;
> > > +                       }
> > > +               }
> > >
> > >                 if (busiest->sum_h_nr_running =3D=3D 1)
> > >                         /*
> > >
> > >
> > > TBH, I don't know much about the below numbers.
> > >
> > > Thank you for the help!
> > >
> > > Thanks.
> > >
> > > >                 /*
> > > >                  * If the local group is less loaded than the selec=
ted
> > > >
> > > > --
> > > >
> > > >
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/sc_pi=
d_max/testtime/class/cpufreq_governor/ucode:
> > > > >
> > > > > lkp-bdw-ep6/stress-ng/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/=
gcc-7/100%/1HDD/4194304/1s/scheduler/performance/0xb000038
> > > > >
> > > > > commit:
> > > > >   e94f80f6c49020008e6fa0f3d4b806b8595d17d8
> > > > >   6c8116c914b65be5e4d6f66d69c8142eb0648c22
> > > > >   v5.7
> > > > >   c7e6d37f60da32f808140b1b7dabcc3cde73c4cc  (Tao's patch)
> > > > >
> > > > > e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c                     =
   v5.7
> > > > > c7e6d37f60da32f808140b1b7da
> > > > > ---------------- --------------------------- --------------------=
-------
> > > > > ---------------------------
> > > > >          %stddev     %change         %stddev     %change %stddev =
    %change
> > > > > %stddev
> > > > >              \          |                \          |            =
    \
> > > > > |                \
> > > > >     819250 =C2=B1  5%     -10.1%     736616 =C2=B1  8%     +41.2%=
    1156877 =C2=B1 3%
> > > > > +43.6%    1176246 =C2=B1  5%  stress-ng.futex.ops
> > > > >     818985 =C2=B1  5%     -10.1%     736460 =C2=B1  8%     +41.2%=
    1156215 =C2=B1 3%
> > > > > +43.6%    1176055 =C2=B1  5%  stress-ng.futex.ops_per_sec
> > > > >       1551 =C2=B1  3%      -3.4%       1498 =C2=B1  5%      -4.6%=
       1480 =C2=B1 5%
> > > > > -14.3%       1329 =C2=B1 11%  stress-ng.inotify.ops
> > > > >       1547 =C2=B1  3%      -3.5%       1492 =C2=B1  5%      -4.8%=
       1472 =C2=B1 5%
> > > > > -14.3%       1326 =C2=B1 11%  stress-ng.inotify.ops_per_sec
> > > > >      11292 =C2=B1  8%      -2.8%      10974 =C2=B1  8%      -9.4%=
      10225 =C2=B1 6%
> > > > > -10.1%      10146 =C2=B1  6%  stress-ng.kill.ops
> > > > >      11317 =C2=B1  8%      -2.6%      11023 =C2=B1  8%      -9.1%=
      10285 =C2=B1 5%
> > > > > -10.3%      10154 =C2=B1  6%  stress-ng.kill.ops_per_sec
> > > > >      28.20 =C2=B1  4%     -35.4%      18.22           -33.4%     =
 18.77
> > > > > -27.7%      20.40 =C2=B1  9%  stress-ng.mmapfork.ops_per_sec
> > > > >    2999012 =C2=B1 21%     -10.1%    2696954 =C2=B1 22%     -88.5%=
     344447 =C2=B1 11%
> > > > > -87.8%     364932        stress-ng.tee.ops_per_sec
> > > > >       7882 =C2=B1  3%      -5.4%       7458 =C2=B1  4%      -2.0%=
       7724 =C2=B1 3%
> > > > > -2.2%       7709 =C2=B1  4%  stress-ng.vforkmany.ops
> > > > >       7804 =C2=B1  3%      -5.2%       7400 =C2=B1  4%      -2.0%=
       7647 =C2=B1 3%
> > > > > -2.1%       7636 =C2=B1  4%  stress-ng.vforkmany.ops_per_sec
> > > > >   46745421 =C2=B1  3%      -8.1%   42938569 =C2=B1  3%      -5.2%=
   44312072 =C2=B1 4%
> > > > > -2.3%   45648193        stress-ng.yield.ops
> > > > >   46734472 =C2=B1  3%      -8.1%   42926316 =C2=B1  3%      -5.2%=
   44290338 =C2=B1 4%
> > > > > -2.4%   45627571        stress-ng.yield.ops_per_sec
> > > > >
> > > > >
> > > > >
> > > >
> > > > ...
> > > >
> > > > > --
> > > > > Zhengjun Xing
