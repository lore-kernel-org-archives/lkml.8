Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DD9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C1220835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kEIWqEi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgFLPYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgFLPYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:24:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8665C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:24:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so11474030lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bAh8721ff0zxVTQ7hlR9HkFMJiyxASog15I9PWqvhq8=;
        b=kEIWqEi1rhw0p7GStlsrxpf8GLksMlGZUeBltojOpr/EYUkGZ2PWxT+tLTSlG0K2bW
         Y5FdKykMFpqbZ5TDq2o/w6+VdCc1LNTjBP1V7ksVhGr0uM/wRmaIDPZIbcDhN3PnqBtz
         1cMjOEsy7TH1ONqkVOB9yP4Lh0LbN2MkmB85Ywq7RPp7HlaLc7LkB6lsZ6uxD/lbbHsb
         KaYdcIhgyjFc0Hw46BuykfJq7qWirHzvE66ad/+67/iL1Lv8+8SX8pL4k7T4MdCQpVte
         UN0jVk03qaVzEbRNfjw/59vnX3nqTU0VKHpMAgFY2rgvLfcT9616UDuh1gezZyy/O9Dj
         +/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bAh8721ff0zxVTQ7hlR9HkFMJiyxASog15I9PWqvhq8=;
        b=Zwne6cG044OI6ZnCyWU7NtZOP+Q8tbIYqplqPlZTy2zVkSdFJWLriFwAvjChYaxXVW
         NwvJGvX0HbdcgVusx7PJeCeTAZBekaJTmapQYRfQyygOjmlqrh+zNK7Dhu4jw8/7OO0g
         0EKHzxrAQ9Su70QyY4Z+iMVkOpa1IOukFLZOMigvPWsG17hSnlHQh6OCQfD+SNW8URq9
         mmokfT0Dhq3upcTDK8C6V9rH1FZQhOWvz8dNyObANo2Kxb6O0berNpxMQ1e7d8Rk1ctn
         BhdQz5YmXLdzxWFeIDk3RoBnTiSUIQQAJbH7f5NTYldmq4UKMWO0pt3Fu64BBkY5iEdP
         6+nw==
X-Gm-Message-State: AOAM532r9rSvDZgoQ4+RVwYQKF+jw6rEkkB9ak/DHsnDX9CBk6nmJzks
        +IQ0Nsz4WvY1cenKjkhg3R2KC2plV7KJkXrdHFDzpw==
X-Google-Smtp-Source: ABdhPJw+5sHsTXI/Olks1ieek5VgXIJV7Am3PhqA1N6TAqIrjwg8xQ9eUZxkepjywTI76vPbAleoKKbszkxWlli22ms=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr7149877ljz.423.1591975448109;
 Fri, 12 Jun 2020 08:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200319023819.GO11705@shao2-debian> <f5d91003-800c-5439-3159-67b5f7b6b744@linux.intel.com>
 <20200612110616.20264-1-hdanton@sina.com>
In-Reply-To: <20200612110616.20264-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 12 Jun 2020 17:23:56 +0200
Message-ID: <CAKfTPtAv8X7TsYz7OrG8qYHCGx3XUvBKKBMHX1mKNy26ctytvQ@mail.gmail.com>
Subject: Re: [LKP] [sched/fair] 070f5e860e: reaim.jobs_per_min -10.5% regression
To:     Hillf Danton <hdanton@sina.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
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

On Fri, 12 Jun 2020 at 13:06, Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Fri, 12 Jun 2020 14:36:49 +0800 Xing Zhengjun wrote:
> > Hi Vincent,
> >
> >    We test the regression still existed in v5.7, do you have time to
> > look at it? Thanks.
> >
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
> >
> > 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.=
7
> > ---------------- --------------------------- --------------------------=
-
> >           %stddev     %change         %stddev     %change         %stdd=
ev
> >               \          |                \          |                \
> >        0.69           -10.3%       0.62            -9.1%       0.62    =
 reaim.child_systime
> >        0.62            -1.0%       0.61            +0.5%       0.62    =
 reaim.child_utime
> >       66870           -10.0%      60187            -7.6%      61787    =
 reaim.jobs_per_min
> >       16717           -10.0%      15046            -7.6%      15446    =
 reaim.jobs_per_min_child
> >       97.84            -1.1%      96.75            -0.4%      97.43    =
 reaim.jti
> >       72000           -10.8%      64216            -8.3%      66000    =
 reaim.max_jobs_per_min
> >        0.36           +10.6%       0.40            +7.8%       0.39    =
 reaim.parent_time
> >        1.58 =C4=85  2%     +71.0%       2.70 =C4=85  2%     +26.9%     =
  2.01 =C4=85  2%  reaim.std_dev_percent
> >        0.00 =C4=85  5%    +110.4%       0.01 =C4=85  3%     +48.8%     =
  0.01 =C4=85  7%  reaim.std_dev_time
> >       50800            -2.4%      49600            -1.6%      50000    =
 reaim.workload
> >
> >
> > On 3/19/2020 10:38 AM, kernel test robot wrote:
> > > Greeting,
> > >
> > > FYI, we noticed a -10.5% regression of reaim.jobs_per_min due to comm=
it:
> > >
> > >
> > > commit: 070f5e860ee2bf588c99ef7b4c202451faa48236 ("sched/fair: Take i=
nto account runnable_avg to classify group")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> > >
> > > in testcase: reaim
> > > on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz wi=
th 4G memory
> > > with following parameters:
> > >
> > >     runtime: 300s
> > >     nr_task: 100%
> > >     test: five_sec
> > >     cpufreq_governor: performance
> > >     ucode: 0x21
> > >
> > > test-description: REAIM is an updated and improved version of AIM 7 b=
enchmark.
> > > test-url: https://sourceforge.net/projects/re-aim-7/
>
> Hi Xing
>
> After 070f5e860ee2 let's treat runnable the same way as util on
> comparing capacity in the assumption that
> (125 + 110 + 117) / 3 =3D 117 accounts for 105 within margin of error
> before any other proposal with some more reasons.
>
> thanks
> Hillf
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8215,12 +8215,8 @@ group_has_capacity(unsigned int imbalanc
>         if (sgs->sum_nr_running < sgs->group_weight)
>                 return true;
>
> -       if ((sgs->group_capacity * imbalance_pct) <
> -                       (sgs->group_runnable * 100))
> -               return false;
> -
> -       if ((sgs->group_capacity * 100) >
> -                       (sgs->group_util * imbalance_pct))
> +       if ((sgs->group_capacity * 100) > (sgs->group_util * imbalance_pc=
t) &&
> +           (sgs->group_capacity * 100) > (sgs->group_runnable * imbalanc=
e_pct))

This change amplifies what the original patch is doing by reducing the
threshold that move cases from "has spare capacity" to "is overloaded"
state

>                 return true;
>
>         return false;
> @@ -8240,12 +8236,8 @@ group_is_overloaded(unsigned int imbalan
>         if (sgs->sum_nr_running <=3D sgs->group_weight)
>                 return false;
>
> -       if ((sgs->group_capacity * 100) <
> -                       (sgs->group_util * imbalance_pct))
> -               return true;
> -
> -       if ((sgs->group_capacity * imbalance_pct) <
> -                       (sgs->group_runnable * 100))
> +       if ((sgs->group_capacity * 100) < (sgs->group_util * imbalance_pc=
t) ||
> +           (sgs->group_capacity * 100) < (sgs->group_runnable * imbalanc=
e_pct))
>                 return true;
>
>         return false;
>
