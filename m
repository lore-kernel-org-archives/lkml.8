Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94795C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D3D2081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npqkY1av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404450AbgFYMIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404222AbgFYMIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:08:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5911CC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:08:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so6203106ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8VCeG8CVZJE62G3OepGAp/AxnH7OVgFXH/aRSOH8684=;
        b=npqkY1avQHjiny6A92tzl3z9UAYdGy+uFBV2Aa97J4sPisdK69SFMbK5d+keVmof+x
         51zF0uzM72RT7jk7DY0hooF0wjd2gzYQh8pLcAmeLZkowS23fa4PE7HlNDr2St3X9qxE
         dcoYhGLVL6MXTvSL/HC70qKGeXkVj9wDomj03TNPa4ho5BJkOoMC+sHP0JDUio7ikzzQ
         kIiHPRk9bY3bcDNI/IcBtHshOZNQ+99hUgrpxbI8qcrrvFYeDVRL6oZcgmV9OmIC3H8Z
         R+hbvLyQRJXqJ9ZgBz5AxRcY7JS6pCqiWdCTpLhOjYrdgAlfsPbIj/zhb8jJKU1Fupw2
         mCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8VCeG8CVZJE62G3OepGAp/AxnH7OVgFXH/aRSOH8684=;
        b=kMjvqGGzp4BmFp5mGx+cvN2zZmUHrJCnGdAOVn9i8NtGNcqcg4j8kgzF3hBEfCKPAq
         EfxsIDQBw4WkHyDZruABerXauwZ8E7sp8YeI0TZQPiRZsLUf6esgVqUrhursxvPt3wZ4
         f2Jx0IeQHZCrwUTUEstbR/Do0mAqoYwfOk9tsAZjCLr50rV5g8aMAby2unnihZtdqTU8
         kWRgdgKwl92dTq3WBvYev4e02U7wcUnx5U4LrCXHOJSw0y2TBhKp4rWBomySAtr8i+s3
         DBBqpTaT6dWCG3XO2MTNq+mvi5c56WCEDP7zwPECIg87YQ+oO0/+y/FDxkXL5bk2ePL6
         +5eA==
X-Gm-Message-State: AOAM533jARbjaEsJ8K6odRZOmXeAmmTeQJp6THVpY/r8m49SFav3e5zh
        Yrg+Nel0Q4P2sPsDGMU9QavMkFs8o+Fne2W9lF92KA==
X-Google-Smtp-Source: ABdhPJzBzogeRB8sXaBfCWH7bH0b9Yc/0O4EU/pKh2VjKNmpdzBUyuKSvPVT3UlxcKo/WVoH90Eal1d4/axNQ3e7bHE=
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr17592449ljp.226.1593086893664;
 Thu, 25 Jun 2020 05:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200624154422.29166-1-vincent.guittot@linaro.org>
 <7f2b3135-328b-a510-ce23-49e3f5c20965@applied-asynchrony.com>
 <CAKfTPtD4+gUkz7Z2o9yyuK09M0bmP=Y+pZTYswNt=yVC4WVkyQ@mail.gmail.com> <c4574b9e-852d-8f04-91cb-0fbae9f89833@applied-asynchrony.com>
In-Reply-To: <c4574b9e-852d-8f04-91cb-0fbae9f89833@applied-asynchrony.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Jun 2020 14:08:02 +0200
Message-ID: <CAKfTPtAfMZOvE47EAa8pZE3EJBafQoAaGBZsj+z7XEXB980yqg@mail.gmail.com>
Subject: Re: [PATCH] sched/cfs: change initial value of runnable_avg
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 at 12:42, Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> On 2020-06-25 11:56, Vincent Guittot wrote:
> > On Thu, 25 Jun 2020 at 11:24, Holger Hoffst=C3=A4tte
> > <holger@applied-asynchrony.com> wrote:
> >>
> >> On 2020-06-24 17:44, Vincent Guittot wrote:
> >>> Some performance regression on reaim benchmark have been raised with
> >>>     commit 070f5e860ee2 ("sched/fair: Take into account runnable_avg =
to classify group")
> >>>
> >>> The problem comes from the init value of runnable_avg which is initia=
lized
> >>> with max value. This can be a problem if the newly forked task is fin=
ally
> >>> a short task because the group of CPUs is wrongly set to overloaded a=
nd
> >>> tasks are pulled less agressively.
> >>>
> >>> Set initial value of runnable_avg equals to util_avg to reflect that =
there
> >>> is no waiting time so far.
> >>>
> >>> Fixes: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to c=
lassify group")
> >>> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> ---
> >>>    kernel/sched/fair.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 0424a0af5f87..45e467bf42fc 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -806,7 +806,7 @@ void post_init_entity_util_avg(struct task_struct=
 *p)
> >>>                }
> >>>        }
> >>>
> >>> -     sa->runnable_avg =3D cpu_scale;
> >>> +     sa->runnable_avg =3D sa->util_avg;
> >>>
> >>>        if (p->sched_class !=3D &fair_sched_class) {
> >>>                /*
> >>>
> >>
> >> Something is wrong here. I woke up my machine from suspend-to-RAM this=
 morning
> >> and saw that a completely idle machine had a loadavg of ~7. According =
to my
> >
> > Just to make sure: Are you speaking about loadavg that is output by
> > /proc/loadavg or load_avg which is the PELT load ?
>
> /proc/loadavg
>
> >> monitoring system this happened to be the loadavg right before I suspe=
nded.
> >> I've reverted this, rebooted, created a loadavg >0, suspended and afte=
r wake up
> >> loadavg again correctly ranges between 0 and whatever, as expected.
> >
> > I'm not sure to catch why ~7 is bad compared to correctly ranges
> > between 0 and whatever. Isn't ~7 part of the whatever ?
>
> After wakeup the _baseline_ for loadavg seemed to be the last value befor=
e suspend,
> not 0. The 7 then was the base loadavg for a _mostly idle machine_ (just =
reading
> mail etc.), i.e. it never went below said baseline again, no matter the
> _actual_ load.
>
> Here's an image: https://imgur.com/a/kd2stqO
>
> Before 02:00 last night the load was ~7 (compiled something), then all pr=
ocesses
> were terminated and the machine was suspended. After wakeup the machine w=
as mostly
> idle (9am..11am), yet measured loadavg continued with the same value as b=
efore.
> I didn't notice this right away since my CPU meter on the desktop didn't =
show any
> *actual* activity (because there was none). The spike at ~11am is the rev=
ert/reboot.

you have reverted only this patch ?

TBH, there is no link between these 2 metrics and I don't see how the
init value of runnable_avg can impact loadavg. As explained, loadavg
is doing a snapshot of nr_running every 5 seconds whereas the impact
of changing this init value will have disappeared in far less than
300ms most of the time.

Let me try to reproduce this on my system


> After that loadavg became normal again, i.e. representative of the actual=
 load,
> even after suspend/resume cycles.
> I suspend/resume every night and the only thing that changed recently was=
 this
> patch, so.. :)
>
> -h
