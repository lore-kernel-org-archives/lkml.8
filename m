Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C7E20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/TMaPAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbgFXJEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgFXJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:04:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F1C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:04:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n24so1709248lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W75Vyxutbx3kUBYjxcYLfUDoT9Gq5ndxaYo4aaQYbA8=;
        b=f/TMaPATghI6Y8C+kjh7zI0RupMMLaAD6+NPBHo+CirJoIHPWV3brfOtAz3LMyS0K2
         XG1Az7BYSTHcS3KZUMGwl26JQCu4RcZ4BZsz10thydmZri1ka70xg4Ywsm3c57IIWhI/
         6LpqqXuzHNNejjdk1l6Rn+/xsSH7DgtkaRvlEDXR9OxX/ChlIqQjdalYnChZp1JFBN/4
         3eUMcvfBV0rRz5HpZJMggbSGRyqkqoAcsTM8PldUgpCDRuMxgI1GFnCKAzH+q6rEzuFN
         dUrFOfJytbW9nXWjdpbNBGWoEPqpuJ/VCkDHGZVoXg1tNNRGOWwwbXPN2u+NQc5sbWF8
         rRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W75Vyxutbx3kUBYjxcYLfUDoT9Gq5ndxaYo4aaQYbA8=;
        b=dKD1v9rejjmq9jNE1ZiWfbaDBErf02FYBUQv94dY+/CadjVf5wtCInu5CIgZl5TY+H
         9IS4nGZmAM0IR+e8fThI/z+rkyfE+VyCx6OZdrUGprWbRfTEr3QbVs7CNjLl01ZZ8NtJ
         ouheHFO07XOwAQOBbAXiZ0B8QgXKYULh4WQuu7gAU8trKrExavyPQxeZxQmx8pGNJgw7
         qqit4Bf5dcJVYuxr0fv5QkXbFh+osd+GI0vUGHiO4hodUb2QXmz5spGSj03gPfY2+abU
         TlTkaW6C10mrMv+ZxxlkapU0YOJpIIeYEuuSbn6XAGWKPmYi7CAaA6GprLMF5Xjwt1Hg
         5g/g==
X-Gm-Message-State: AOAM530v5bJAbRlVXjVt24n/ptRNlio7udtY2NK+9SLpWUIU+8mBd/yk
        7TX9eEhnIuEt3WIbGKtAXGuvlpvKpKDzmQzubWc4Yw==
X-Google-Smtp-Source: ABdhPJzUsGWNLAWqDlwrozMpTeRmx1S40/m5sNUP0zYDWflbtU5BH6oXjgtsX+CrWeDEbbQVhS1ZuhImSMk7/Oq1fX0=
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr13839910ljp.177.1592989486852;
 Wed, 24 Jun 2020 02:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200319023819.GO11705@shao2-debian> <20200612110616.20264-1-hdanton@sina.com>
 <90f4036d-bb16-af67-8776-a2cbe67dfe7f@linux.intel.com> <20200615081041.GA16990@vingu-book>
 <d60343e9-b3a0-bdc7-84f4-e8c912f92c46@linux.intel.com> <20200616065432.GA18401@vingu-book>
 <3de4937b-1dcd-6d2e-836f-fed1c295dd7c@linux.intel.com> <20200617145725.GA12524@vingu-book>
 <987fd281-cf22-c17f-b156-4b6f904c5a5b@linux.intel.com> <CAKfTPtB3ay_q2XuAegszyt5gFdSVTz9ndGDemKkZ0iFihDXsPQ@mail.gmail.com>
In-Reply-To: <CAKfTPtB3ay_q2XuAegszyt5gFdSVTz9ndGDemKkZ0iFihDXsPQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 Jun 2020 11:04:35 +0200
Message-ID: <CAKfTPtA-7c+=3q-V6wG+tDp=0q+tm=kCqfAVERbvK5r-EazN8g@mail.gmail.com>
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

On Fri, 19 Jun 2020 at 09:15, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 19 Jun 2020 at 06:55, Xing Zhengjun
> <zhengjun.xing@linux.intel.com> wrote:
> > On 6/17/2020 10:57 PM, Vincent Guittot wrote:
> > > Le mercredi 17 juin 2020 =C3=A0 08:30:21 (+0800), Xing Zhengjun a =C3=
=A9crit :
>
> ...
>
> > > OK. So the regression disappears when the conditions on runnable_avg =
are removed.
> > >
> > > In the meantime, I have been able to understand more deeply what was =
happeningi
> > > for this bench and how it is impacted by
> > >    commit: 070f5e860ee2 ("sched/fair: Take into account runnable_avg =
to classify group")
> > >
> > > This bench forks a new thread for each and every new step. But a newl=
y forked
> > > threads start with a load_avg and a runnable_avg set to max whereas t=
he threads
> > > are running shortly before exiting. This makes the CPU to be set over=
loaded in
> > > some case whereas it isn't.
> > >
> > > Could you try the patch below ?
> > > It fixes the problem on my setup (I have finally been able to reprodu=
ce the problem)
> > >
> > > ---
> > >   kernel/sched/fair.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 0aeffff62807..b33a4a9e1491 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -807,7 +807,7 @@ void post_init_entity_util_avg(struct task_struct=
 *p)
> > >               }
> > >       }
> > >
> > > -     sa->runnable_avg =3D cpu_scale;
> > > +     sa->runnable_avg =3D sa->util_avg;
> > >
> > >       if (p->sched_class !=3D &fair_sched_class) {
> > >               /*
> > >
> >
> > I apply the patch above based on v5.7, the test result is as the follow=
ing:
>
> Thanks for the tests.
>
> This patch fixes the regression on the test. I'm going to run more
> tests to make sure that it doesn't regress others benchmarks. I
> remember that some were slightly better with the original behavior but
> others patches and fixes have been added in the meantime that might
> change the results.

I have run more test on large and small system and the results are
balanced. I might see a small regression on some hackbenchs results on
large system but it's in the range of the stdev and might not be
significant

I'm going to send  a clean patch with a commit message.

Thanks for your help
Vincent

>
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup=
/test/cpufreq_governor/ucode:
> >
> > lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s=
/100%/test/five_sec/performance/0x21
> >
> > commit:
> >    9f68395333ad7f5bfe2f83473fed363d4229f11c
> >    070f5e860ee2bf588c99ef7b4c202451faa48236
> >    v5.7
> >    cbb4d668e7431479a7978fa79d64c2271adefab0 ( the test patch which modi=
fy
> > post_init_entity_util_avg())
> >
> > 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.=
7
> > cbb4d668e7431479a7978fa79d6
> > ---------------- --------------------------- --------------------------=
-
> > ---------------------------
> >           %stddev     %change         %stddev     %change
> > %stddev     %change         %stddev
> >               \          |                \          |                \
> >          |                \
> >        0.69           -10.3%       0.62            -9.1%       0.62
> >        +0.6%       0.69        reaim.child_systime
> >        0.62            -1.0%       0.61            +0.5%       0.62
> >        -0.3%       0.62        reaim.child_utime
> >       66870           -10.0%      60187            -7.6%      61787
> >        +0.7%      67335        reaim.jobs_per_min
>
>
>
> >       16717           -10.0%      15046            -7.6%      15446
> >        +0.7%      16833        reaim.jobs_per_min_child
> >       97.84            -1.1%      96.75            -0.4%      97.43
> >        +0.2%      98.05        reaim.jti
> >       72000           -10.8%      64216            -8.3%      66000
> >        +0.0%      72000        reaim.max_jobs_per_min
> >        0.36           +10.6%       0.40            +7.8%       0.39
> >        -0.6%       0.36        reaim.parent_time
> >        1.58 =C2=B1  2%     +71.0%       2.70 =C2=B1  2%     +26.9%     =
  2.01 =C2=B1
> > 2%      -8.8%       1.44 =C2=B1  2%  reaim.std_dev_percent
> >        0.00 =C2=B1  5%    +110.4%       0.01 =C2=B1  3%     +48.8%     =
  0.01 =C2=B1
> > 7%     -24.6%       0.00 =C2=B1  7%  reaim.std_dev_time
> >       50800            -2.4%      49600            -1.6%      50000
> >        +0.0%      50800        reaim.workload
> >
> >
> > --
> > Zhengjun Xing
