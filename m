Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F302C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E132C2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zT5putki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgFSHPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgFSHPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:15:50 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833C8C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 00:15:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i8so4967807lfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 00:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zkAicpjq9L9xLhQdEyWyhP0mT7DTKktycqbV9ch9xM0=;
        b=zT5putkiBBfHKwC977rB4zGukGofPK9wfWDiXCo0xn5NJF3Li1rF8w6H0UOxKzkzfo
         Lac9k1kdd9J7FXeohFCfKXkjSFTeYf9Eba84pyQ5Te1hY4M7wHRFL9NaZOX2/weMe5Zl
         Xi1yjNzyHq3ss8ZzeSncY2fG/ATlfLoZW0DH6nxVhL1bLs2yG05HnOjO9XI4nsie4P3h
         HX6qs4Yn0t+ZxXI4H4GskpZ9GCkzGjAzK9qvQG2YlKXe1jET4NtvzXf/LFO4u9yE8faS
         JlJ90r0KwVLPy4IYlOjEdrOca+kxYvphd4rTeDGReB0HqD+lWunKi1HPua7C9Gh5in9v
         rKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zkAicpjq9L9xLhQdEyWyhP0mT7DTKktycqbV9ch9xM0=;
        b=jA/7RbFImvKFyN8IZGSjC7mOAhLztPGNFX6OiwawFMog/lbU4fNS5OWk+QJ2Op0VuN
         DbjRfFm2CbqWqXPsvTQNZs0fsihwLsLVcyqqrs3AUEZeHqUNI9tr3cezwbpGItdDa6r6
         o4CBgy1fbG/X5+MsSJPkmy+6CY+6q9yAH7DUf6/WJreK1ds8Qqpkf0edbLORkbRWjdzO
         qVZYWsCRrCqbGe+OTgQeU1h2euvLHgisxeu4HVY9dze23LSgYX2BNDBmo2DUsWUMR3US
         hvCoHuq6zkvCjXJeVQK2bafcb7iCq4S6uVx9AHxGjUgJmxQKzD4J2lRAK6qBxlR6qe4+
         LhvQ==
X-Gm-Message-State: AOAM531zZfkAd7KQhCCVpOFe0gWyB19DQdol75QOJsT+iPwXpWd1VLmI
        l9OKu009MHBmPDvZgT9sfbGKz0zZS7ojrdrzsIXuEw==
X-Google-Smtp-Source: ABdhPJwrYXK3b24No+gU+pZjhpbMG3Gans7SA9oZTOr6a6XXoCTp5DwFgoNwgYdVjB5Y++ICLK7C3xZGzmchLV87J24=
X-Received: by 2002:a19:2292:: with SMTP id i140mr1142209lfi.95.1592550947862;
 Fri, 19 Jun 2020 00:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200319023819.GO11705@shao2-debian> <20200612110616.20264-1-hdanton@sina.com>
 <90f4036d-bb16-af67-8776-a2cbe67dfe7f@linux.intel.com> <20200615081041.GA16990@vingu-book>
 <d60343e9-b3a0-bdc7-84f4-e8c912f92c46@linux.intel.com> <20200616065432.GA18401@vingu-book>
 <3de4937b-1dcd-6d2e-836f-fed1c295dd7c@linux.intel.com> <20200617145725.GA12524@vingu-book>
 <987fd281-cf22-c17f-b156-4b6f904c5a5b@linux.intel.com>
In-Reply-To: <987fd281-cf22-c17f-b156-4b6f904c5a5b@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Jun 2020 09:15:36 +0200
Message-ID: <CAKfTPtB3ay_q2XuAegszyt5gFdSVTz9ndGDemKkZ0iFihDXsPQ@mail.gmail.com>
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

On Fri, 19 Jun 2020 at 06:55, Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
> On 6/17/2020 10:57 PM, Vincent Guittot wrote:
> > Le mercredi 17 juin 2020 =C3=A0 08:30:21 (+0800), Xing Zhengjun a =C3=
=A9crit :

...

> > OK. So the regression disappears when the conditions on runnable_avg ar=
e removed.
> >
> > In the meantime, I have been able to understand more deeply what was ha=
ppeningi
> > for this bench and how it is impacted by
> >    commit: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to=
 classify group")
> >
> > This bench forks a new thread for each and every new step. But a newly =
forked
> > threads start with a load_avg and a runnable_avg set to max whereas the=
 threads
> > are running shortly before exiting. This makes the CPU to be set overlo=
aded in
> > some case whereas it isn't.
> >
> > Could you try the patch below ?
> > It fixes the problem on my setup (I have finally been able to reproduce=
 the problem)
> >
> > ---
> >   kernel/sched/fair.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0aeffff62807..b33a4a9e1491 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -807,7 +807,7 @@ void post_init_entity_util_avg(struct task_struct *=
p)
> >               }
> >       }
> >
> > -     sa->runnable_avg =3D cpu_scale;
> > +     sa->runnable_avg =3D sa->util_avg;
> >
> >       if (p->sched_class !=3D &fair_sched_class) {
> >               /*
> >
>
> I apply the patch above based on v5.7, the test result is as the followin=
g:

Thanks for the tests.

This patch fixes the regression on the test. I'm going to run more
tests to make sure that it doesn't regress others benchmarks. I
remember that some were slightly better with the original behavior but
others patches and fixes have been added in the meantime that might
change the results.

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
>    cbb4d668e7431479a7978fa79d64c2271adefab0 ( the test patch which modify
> post_init_entity_util_avg())
>
> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
> cbb4d668e7431479a7978fa79d6
> ---------------- --------------------------- ---------------------------
> ---------------------------
>           %stddev     %change         %stddev     %change
> %stddev     %change         %stddev
>               \          |                \          |                \
>          |                \
>        0.69           -10.3%       0.62            -9.1%       0.62
>        +0.6%       0.69        reaim.child_systime
>        0.62            -1.0%       0.61            +0.5%       0.62
>        -0.3%       0.62        reaim.child_utime
>       66870           -10.0%      60187            -7.6%      61787
>        +0.7%      67335        reaim.jobs_per_min



>       16717           -10.0%      15046            -7.6%      15446
>        +0.7%      16833        reaim.jobs_per_min_child
>       97.84            -1.1%      96.75            -0.4%      97.43
>        +0.2%      98.05        reaim.jti
>       72000           -10.8%      64216            -8.3%      66000
>        +0.0%      72000        reaim.max_jobs_per_min
>        0.36           +10.6%       0.40            +7.8%       0.39
>        -0.6%       0.36        reaim.parent_time
>        1.58 =C2=B1  2%     +71.0%       2.70 =C2=B1  2%     +26.9%       =
2.01 =C2=B1
> 2%      -8.8%       1.44 =C2=B1  2%  reaim.std_dev_percent
>        0.00 =C2=B1  5%    +110.4%       0.01 =C2=B1  3%     +48.8%       =
0.01 =C2=B1
> 7%     -24.6%       0.00 =C2=B1  7%  reaim.std_dev_time
>       50800            -2.4%      49600            -1.6%      50000
>        +0.0%      50800        reaim.workload
>
>
> --
> Zhengjun Xing
