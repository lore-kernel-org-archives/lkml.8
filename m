Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379F62075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DF06F1w9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHSLFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgHSLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:05:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87DAC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 04:05:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so24917804ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CNNvZSrpZe1na795UzZLdD0f0kb59Zd5OOwEuyJTVrM=;
        b=DF06F1w9ZkJlAhGKWH6IUQ9TDRzCqoxf9CllIH+0YcuG2PkhPXrEN81KsUe0qcnpBo
         sXsg3st6w21SrII+tovrMoiiWgdy09H+tasrcJmD7NPVnA80ABx/8l5D0o1uIfF0zWzG
         sOLMDlAaKqEwgpr7KePGYR45fD6BiZp2M5aAE77jp+uMvLNjNgit3Q/bI9tIMvCaGNjf
         DX1aS9dUkp33pMowVizRR9AyT2/IEh1ajbJiyfAE7HURqCEUag4A+VpJBAhQkfHDZOHx
         nUf0TMWwp0zcUzNB+JBfc0qfAOONMeUfcMUdscO82X6Rg4mesUcUrUHYy6y08CEIoey1
         w/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CNNvZSrpZe1na795UzZLdD0f0kb59Zd5OOwEuyJTVrM=;
        b=foWJFBP9bHVgMMmXaHQMP/8g74tTtD41BJKHL8W+tNb12nRtApm+nftSXVTh68zVu9
         Xp4/v0W3Q0ZOL3mHH9Etqy8ZMF9BRRWsWjMmqxDX1cKLAaEogJwT73ckHFS7YWPMscXQ
         AtU8yxTsSuR3bEyZPto/ByevzeHNVs753oXHgfqxVt94r9ZzgPeQK0ouw+rMdvjtYDff
         3ErzKQx80Y5pmdlfBWrOK9COtpFYPCQqqDelxBQjIuMcsDJjen2otCy/PR9IBF6tut/j
         6QVh8GYtVJZWPRFCDKgAn86XysjcxwhN++m+n/AqlHeki//0kYFeP9vY5YAtgOY96X5G
         0ZkQ==
X-Gm-Message-State: AOAM530q5KNOncB4itGl51ThlPM8lbjHcCC1TTs8O1Awp44CzXCjVTPt
        i77IcqxVceeIg1YU31u3SKlGtFz/FovotLjdrhnvUA==
X-Google-Smtp-Source: ABdhPJzj95wPmXG9dKhKiBcVHM02iqWsgBEupdaLJ2JF3f1Juk80QhgVehC2mukFJSq9dnQ0MDuq7HAxVujA2vaoBA0=
X-Received: by 2002:a2e:b045:: with SMTP id d5mr12619588ljl.111.1597835134136;
 Wed, 19 Aug 2020 04:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200801023248.90104-1-benbjiang@gmail.com> <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
 <592F24A7-BF43-457D-AC40-DC5E35279730@tencent.com> <8bef1f94-f9bf-08a5-2ff3-3485d7796a96@arm.com>
 <8629CB9F-AFC8-43D6-BD14-B60A0B85ADB3@tencent.com> <5f870781-1648-b4ac-6026-557dfc347109@arm.com>
 <CCA1D942-3669-4216-92BD-768967B1ECE5@tencent.com> <4964e359-afc5-a256-4950-853a9485eeff@arm.com>
 <70236E62-AA36-48C1-9382-86353649253C@tencent.com> <3a1047fc-a86a-014a-b17a-eae71f669da1@arm.com>
 <643B0ECE-D758-4D08-8B1B-C70F34DD9943@tencent.com> <55f04582-69d6-aeb4-85be-3e46a3b15beb@arm.com>
 <755BFAD0-9072-4D73-9CD7-AF4F74A79D21@tencent.com> <729675a2-b083-4211-62c0-f7ed7f483ae2@arm.com>
In-Reply-To: <729675a2-b083-4211-62c0-f7ed7f483ae2@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Aug 2020 13:05:22 +0200
Message-ID: <CAKfTPtATf94n4t6EnB5_76ygox26xd9EwvEHiv5cGN=E9BdLgg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Jiang Biao <benbjiang@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 at 12:46, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>
> On 17/08/2020 14:05, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >
> >
> >> On Aug 17, 2020, at 4:57 PM, Dietmar Eggemann <dietmar.eggemann@arm.co=
m> wrote:
> >>
> >> On 14/08/2020 01:55, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>> Hi,
> >>>
> >>>> On Aug 13, 2020, at 2:39 AM, Dietmar Eggemann <dietmar.eggemann@arm.=
com> wrote:
> >>>>
> >>>> On 12/08/2020 05:19, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>> Hi,
> >>>>>
> >>>>>> On Aug 11, 2020, at 11:54 PM, Dietmar Eggemann <dietmar.eggemann@a=
rm.com> wrote:
> >>>>>>
> >>>>>> On 11/08/2020 02:41, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>>> On Aug 10, 2020, at 9:24 PM, Dietmar Eggemann <dietmar.eggemann@=
arm.com> wrote:
> >>>>>>>>
> >>>>>>>> On 06/08/2020 17:52, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>> Hi,
> >>>>>>>>>
> >>>>>>>>>> On Aug 6, 2020, at 9:29 PM, Dietmar Eggemann <dietmar.eggemann=
@arm.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 03/08/2020 13:26, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>> On Aug 3, 2020, at 4:16 PM, Dietmar Eggemann <dietmar.eggema=
nn@arm.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 01/08/2020 04:32, Jiang Biao wrote:
> >>>>>>>>>>>>> From: Jiang Biao <benbjiang@tencent.com>
>
> [...]
>
> >> Are you sure about this?
> > Yes. :)
> >>
> >> The math is telling me for the:
> >>
> >> idle task:      (3 / (1024 + 1024 + 3))^(-1) * 4ms =3D 2735ms
> >>
> >> normal task: (1024 / (1024 + 1024 + 3))^(-1) * 4ms =3D    8ms
> >>
> >> (4ms - 250 Hz)
> > My tick is 1ms - 1000HZ, which seems reasonable for 600ms? :)
>
> OK, I see.
>
> But here the different sched slices (check_preempt_tick()->
> sched_slice()) between normal tasks and the idle task play a role to.
>
> Normal tasks get ~3ms whereas the idle task gets <0.01ms.

In fact that depends on the number of CPUs on the system
:sysctl_sched_latency =3D 6ms * (1 + ilog(ncpus)) . On a 8 cores system,
normal task will run around 12ms in one shoot and the idle task still
one tick period

Also, you can increase even more the period between 2 runs of idle
task by using cgroups and min shares value : 2

>
> So the idle task runs every ~680ms but only for 1 tick (1ms) (4 times
> less than the normal tasks). The condition 'if (delta_exec >
> ideal_runtime)' in check_preempt_tick() is only true at the 4th tick
> when a normal task runs even though the slice is 3ms.
>
> In the 250 Hz example the sched slice diffs are hidden behind the 4ms tic=
k.
>
> [...]
