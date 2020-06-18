Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009F8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1392070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHnbzQNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgFRMfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgFRMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:35:50 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1AC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:35:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g139so2566607lfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oLgCwziopXCH577D68AEHtwfUvlf8aXb2mGhRu95Jdc=;
        b=MHnbzQNLtZ9AS8NhgZhO26iAl+Iyf13cOjfRhFaRg/fkYyXCRFA2RZoa6faSock/qG
         v8ybP4J29FdUA3Z7ACS1nOIlj9szfHxz9fC727ecwoXcMP2XNx88CyrRjiiTRRtGXwuw
         mPnK4qT/6EJ8PjDQzpnsN6x4dNX+ljwk1xhdpOdBMQ8IIwfMxiPOf4jia8X1/q0K3fbI
         1uTxtSs63FbiPub95FkFvudKQUbeCSSBlEitbUlhrx/vEjYiDLKUjydB4jmLA8zjzQ/t
         ehaV/ytiWntchnqYDOBldwrnkx4HJ4JkFKQOrYO9ieh2SJ4fH6wbYxlvRg9aQHNC5yuW
         aR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oLgCwziopXCH577D68AEHtwfUvlf8aXb2mGhRu95Jdc=;
        b=qUlHrhiL4Bi0n0W2i/g8RREaCsv1n4BvFYip2Go3S8wPI84xgd3DkED7lhg4Zf0KCq
         zcTzWexScST5n4o78Qh9FeCvaHBBAkvL3yJi6hkazyvzm+caYt+ufSXWI4C1jHIhluSu
         ezWboFcUx6wajn8OJV5hSMAQKd2oDQAxqr75mYykMq9LuWk6rnrNjYJ2RKfkkW+rwSiS
         xLfMyijVeyH0YZkFOaxFuMZM4bJUP6Nayq0VAXorb25j2toLRtzQJcoT4CVwDm6/YD2g
         GEtTfPOgt4ulRzP4lljjwx6SygPbsCDzXgzTrkmWQ3y0/Qp51Nn55gvAeMoKE9+gTQbU
         gLQw==
X-Gm-Message-State: AOAM5300xe7xJKV3t8yNVc8Rexk0KoeNz3ozpjnBCXlqMsK+W5P6Js78
        Yyq15p6vaTNh+zKTf9zPIbvvA/TcbkjTNmRNGPFeMA==
X-Google-Smtp-Source: ABdhPJzCyHQlXAI2ejRv1CgoJboqx8jP/Mjs8N9Np3FKjp77Zk2tNXmnTna/BYSNe6lH2sujmgQ48+7qlUVPFFZiY7w=
X-Received: by 2002:a19:8806:: with SMTP id k6mr1079090lfd.189.1592483747764;
 Thu, 18 Jun 2020 05:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200319023819.GO11705@shao2-debian> <20200612110616.20264-1-hdanton@sina.com>
 <90f4036d-bb16-af67-8776-a2cbe67dfe7f@linux.intel.com> <20200615081041.GA16990@vingu-book>
 <d60343e9-b3a0-bdc7-84f4-e8c912f92c46@linux.intel.com> <20200616065432.GA18401@vingu-book>
 <3de4937b-1dcd-6d2e-836f-fed1c295dd7c@linux.intel.com> <20200617145725.GA12524@vingu-book>
 <20200617162558.GA3253@vingu-book> <451eabaf-c425-8e05-f5d4-3074c867cea6@linux.intel.com>
In-Reply-To: <451eabaf-c425-8e05-f5d4-3074c867cea6@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 18 Jun 2020 14:35:36 +0200
Message-ID: <CAKfTPtCSGcx0_0b7PTWPNi9LnGqCCTpt4zswOBumVgr7CWAJbQ@mail.gmail.com>
Subject: Re: [LKP] [sched/fair] 070f5e860e: reaim.jobs_per_min -10.5% regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 at 04:45, Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
>
>

> >>
> >> This bench forks a new thread for each and every new step. But a newly=
 forked
> >> threads start with a load_avg and a runnable_avg set to max whereas th=
e threads
> >> are running shortly before exiting. This makes the CPU to be set overl=
oaded in
> >> some case whereas it isn't.
> >>
> >> Could you try the patch below ?
> >> It fixes the problem on my setup (I have finally been able to reproduc=
e the problem)
> >>
> >> ---
> >>   kernel/sched/fair.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 0aeffff62807..b33a4a9e1491 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -807,7 +807,7 @@ void post_init_entity_util_avg(struct task_struct =
*p)
> >>              }
> >>      }
> >>
> >> -    sa->runnable_avg =3D cpu_scale;
> >> +    sa->runnable_avg =3D sa->util_avg;
> >>
> >>      if (p->sched_class !=3D &fair_sched_class) {
> >>              /*
> >> --
> >> 2.17.1
> >>
> >
> > The patch above tries to move back to the group in the same classificat=
ion as
> > before but this could harm other benchmarks.
> >
> > There is another way to fix this by easing the migration of task in the=
 case
> > of migrate_util imbalance.
> >
> > Could you also try the patch below instead of the one above ?
> >
> > ---
> >   kernel/sched/fair.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0aeffff62807..fcaf66c4d086 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7753,7 +7753,8 @@ static int detach_tasks(struct lb_env *env)
> >               case migrate_util:
> >                       util =3D task_util_est(p);
> >
> > -                     if (util > env->imbalance)
> > +                     if (util/2 > env->imbalance &&
> > +                         env->sd->nr_balance_failed <=3D env->sd->cach=
e_nice_tries)
> >                               goto next;
> >
> >                       env->imbalance -=3D util;
> > --
> > 2.17.1
> >
> >
>
> I apply the patch based on v5.7, the test result is as the following:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/t=
est/cpufreq_governor/ucode:
>
> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/1=
00%/test/five_sec/performance/0x21
>
> commit:
>    9f68395333ad7f5bfe2f83473fed363d4229f11c
>    070f5e860ee2bf588c99ef7b4c202451faa48236
>    v5.7
>    69c81543653bf5f2c7105086502889fa019c15cb  (the test patch)
>
> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
> 69c81543653bf5f2c7105086502
> ---------------- --------------------------- ---------------------------
> ---------------------------
>           %stddev     %change         %stddev     %change
> %stddev     %change         %stddev
>               \          |                \          |                \
>          |                \
>        0.69           -10.3%       0.62            -9.1%       0.62
>        -7.6%       0.63        reaim.child_systime
>        0.62            -1.0%       0.61            +0.5%       0.62
>        +1.9%       0.63        reaim.child_utime
>       66870           -10.0%      60187            -7.6%      61787
>        -5.9%      62947        reaim.jobs_per_min

There is an improvement but not at the same level as on my setup.
I'm not sure with patch you tested here. Is it the last one that
modify detach_tasks() or the previous one that modify
post_init_entity_util_avg() ?

Could you also try the other one ? Both patches were improving results
on y setup but the behavior doesn't seem to be the same on your setup.


>       16717           -10.0%      15046            -7.6%      15446
>        -5.9%      15736        reaim.jobs_per_min_child
>       97.84            -1.1%      96.75            -0.4%      97.43
>        -0.4%      97.47        reaim.jti
>       72000           -10.8%      64216            -8.3%      66000
>        -5.7%      67885        reaim.max_jobs_per_min
>        0.36           +10.6%       0.40            +7.8%       0.39
>        +6.0%       0.38        reaim.parent_time
>        1.58 =C2=B1  2%     +71.0%       2.70 =C2=B1  2%     +26.9%       =
2.01 =C2=B1
> 2%     +23.6%       1.95 =C2=B1  3%  reaim.std_dev_percent
>        0.00 =C2=B1  5%    +110.4%       0.01 =C2=B1  3%     +48.8%       =
0.01 =C2=B1
> 7%     +43.2%       0.01 =C2=B1  5%  reaim.std_dev_time
>       50800            -2.4%      49600            -1.6%      50000
>        -0.8%      50400        reaim.workload
>
>
> >>
> >>
...
> >>>>>
> >>>>> --
> >>>>> Zhengjun Xing
> >>>
> >>> --
> >>> Zhengjun Xing
>
> --
> Zhengjun Xing
