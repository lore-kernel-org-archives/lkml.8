Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD552C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A14207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qYE/2AT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHTHgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHTHgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:36:00 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B274C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:36:00 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v9so1000831ljk.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jhY7jQSIRXqAqE/qK3hnmZGj7G68p1VfW36/dFGhyXo=;
        b=qYE/2AT4aPIVrosYiM+YX8IPsRzTrnXm57n+ZSXVc9NtQHEMTVvZMoVdlJ+UM7xJgh
         DNLn6wM2unFXOTfR1z8Kap3wPcv0Ld79fgjSo3u1GGgBO42Ldtei1nPlBZoOYzvcRnta
         75R8piKkarTy5uGIH9SAqY88zqu09RSH6ggCjQKw3H5GAVzSr4iOy/5UMD0fapDL8Maw
         j/ax1VOpaMKH9DbT9NdIzCY0u9kRRuRcU8niZsXh3Ksj9RsMm2HvN5FHqFQidJyynoo1
         woL29iLTMcyy4d7k6F8SDre62kA6psjIUzZ4XUCofG7qzpUxPz5WMu2FEOCHU188qBxG
         084g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jhY7jQSIRXqAqE/qK3hnmZGj7G68p1VfW36/dFGhyXo=;
        b=J0tnme0onFJtAWtWPREVVOV+LQ/p54txIcbFcg288H0xL0/T4E7RGkMMJdL5hIPL/Z
         kKSyn7XCqi+Vd1L52/5cqxlMxIeRCDmWZ7VHuUM5Bm6QBCRlnTKPoNhYLjmGYncR5CNe
         iRdu3Hno56OAoHCr2Z1Ii3oxK6GN6yt9JGdiQJDjwvqoTEyxushnd+qzXivTnqIhrqEV
         pSpPHVxNydMEIaS7XCiv/DlyMk6iRrWn5BpFBs556Zedtg4K9XGu0NONmXJBeouY4RbN
         Ht2KINZE4LCBee5vFdOmqr44FJ9Us+pXuwF/hna0EwE/+P+FuSlk4p0anEnQg35XDc8B
         KYsg==
X-Gm-Message-State: AOAM533NGZbYjULjHPTmmR5XffoqrExe/C9th+tZev2LgnNdA2rO0Lp8
        a8rmXHlX3x2+BMs+fmGvf4sIl55/3O1JnmC3jA4dYg==
X-Google-Smtp-Source: ABdhPJxIueGc9nT7kqP8k7xAIe2QKuKZ5D5HUHao0VW6Ra7yIL/hn7C/Dy7sNSaXCrtse1u4dNmJQiQF8a58xGAC8ZY=
X-Received: by 2002:a2e:9990:: with SMTP id w16mr929513lji.156.1597908958592;
 Thu, 20 Aug 2020 00:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200801023248.90104-1-benbjiang@gmail.com> <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
 <592F24A7-BF43-457D-AC40-DC5E35279730@tencent.com> <8bef1f94-f9bf-08a5-2ff3-3485d7796a96@arm.com>
 <8629CB9F-AFC8-43D6-BD14-B60A0B85ADB3@tencent.com> <5f870781-1648-b4ac-6026-557dfc347109@arm.com>
 <CCA1D942-3669-4216-92BD-768967B1ECE5@tencent.com> <4964e359-afc5-a256-4950-853a9485eeff@arm.com>
 <70236E62-AA36-48C1-9382-86353649253C@tencent.com> <3a1047fc-a86a-014a-b17a-eae71f669da1@arm.com>
 <643B0ECE-D758-4D08-8B1B-C70F34DD9943@tencent.com> <55f04582-69d6-aeb4-85be-3e46a3b15beb@arm.com>
 <755BFAD0-9072-4D73-9CD7-AF4F74A79D21@tencent.com> <729675a2-b083-4211-62c0-f7ed7f483ae2@arm.com>
 <CAKfTPtATf94n4t6EnB5_76ygox26xd9EwvEHiv5cGN=E9BdLgg@mail.gmail.com>
 <bb7456af-6a4d-874c-e635-8d21e1ab3efc@arm.com> <A8E52241-0206-447D-9EA0-699F8F82AFAB@tencent.com>
 <CAKfTPtBiZHwkhCkMQs9iOF=eBLgubsJkARN5zOKZzmfo_jTJzg@mail.gmail.com> <3A85DD77-2A4B-466F-A1F4-1BF2AF02CF58@tencent.com>
In-Reply-To: <3A85DD77-2A4B-466F-A1F4-1BF2AF02CF58@tencent.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Aug 2020 09:35:46 +0200
Message-ID: <CAKfTPtATpDB+ihpMf854nTdDfy4Bw_BU=21PRHVczEcE42271Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
To:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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

On Thu, 20 Aug 2020 at 02:13, benbjiang(=E8=92=8B=E5=BD=AA) <benbjiang@tenc=
ent.com> wrote:
>
>
>
> > On Aug 19, 2020, at 10:55 PM, Vincent Guittot <vincent.guittot@linaro.o=
rg> wrote:
> >
> > On Wed, 19 Aug 2020 at 16:27, benbjiang(=E8=92=8B=E5=BD=AA) <benbjiang@=
tencent.com> wrote:
> >>
> >>
> >>
> >>> On Aug 19, 2020, at 7:55 PM, Dietmar Eggemann <dietmar.eggemann@arm.c=
om> wrote:
> >>>
> >>> On 19/08/2020 13:05, Vincent Guittot wrote:
> >>>> On Wed, 19 Aug 2020 at 12:46, Dietmar Eggemann <dietmar.eggemann@arm=
.com> wrote:
> >>>>>
> >>>>> On 17/08/2020 14:05, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>
> >>>>>>
> >>>>>>> On Aug 17, 2020, at 4:57 PM, Dietmar Eggemann <dietmar.eggemann@a=
rm.com> wrote:
> >>>>>>>
> >>>>>>> On 14/08/2020 01:55, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>>> On Aug 13, 2020, at 2:39 AM, Dietmar Eggemann <dietmar.eggemann=
@arm.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 12/08/2020 05:19, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>>> On Aug 11, 2020, at 11:54 PM, Dietmar Eggemann <dietmar.eggem=
ann@arm.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On 11/08/2020 02:41, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>>>>> Hi,
> >>>>>>>>>>>>
> >>>>>>>>>>>>> On Aug 10, 2020, at 9:24 PM, Dietmar Eggemann <dietmar.egge=
mann@arm.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On 06/08/2020 17:52, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On Aug 6, 2020, at 9:29 PM, Dietmar Eggemann <dietmar.egg=
emann@arm.com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On 03/08/2020 13:26, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> On Aug 3, 2020, at 4:16 PM, Dietmar Eggemann <dietmar.e=
ggemann@arm.com> wrote:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> On 01/08/2020 04:32, Jiang Biao wrote:
> >>>>>>>>>>>>>>>>>> From: Jiang Biao <benbjiang@tencent.com>
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>> Are you sure about this?
> >>>>>> Yes. :)
> >>>>>>>
> >>>>>>> The math is telling me for the:
> >>>>>>>
> >>>>>>> idle task:      (3 / (1024 + 1024 + 3))^(-1) * 4ms =3D 2735ms
> >>>>>>>
> >>>>>>> normal task: (1024 / (1024 + 1024 + 3))^(-1) * 4ms =3D    8ms
> >>>>>>>
> >>>>>>> (4ms - 250 Hz)
> >>>>>> My tick is 1ms - 1000HZ, which seems reasonable for 600ms? :)
> >>>>>
> >>>>> OK, I see.
> >>>>>
> >>>>> But here the different sched slices (check_preempt_tick()->
> >>>>> sched_slice()) between normal tasks and the idle task play a role t=
o.
> >>>>>
> >>>>> Normal tasks get ~3ms whereas the idle task gets <0.01ms.
> >>>>
> >>>> In fact that depends on the number of CPUs on the system
> >>>> :sysctl_sched_latency =3D 6ms * (1 + ilog(ncpus)) . On a 8 cores sys=
tem,
> >>>> normal task will run around 12ms in one shoot and the idle task stil=
l
> >>>> one tick period
> >>>
> >>> True. This is on a single CPU.
> >> Agree. :)
> >>
> >>>
> >>>> Also, you can increase even more the period between 2 runs of idle
> >>>> task by using cgroups and min shares value : 2
> >>>
> >>> Ah yes, maybe this is what Jiang wants to do then? If his runtime doe=
s
> >>> not have other requirements preventing this.
> >> That could work for increasing the period between 2 runs. But could no=
t
> >> reduce the single runtime of idle task I guess, which means normal tas=
k
> >> could have 1-tick schedule latency because of idle task.
> >
> > Yes.  An idle task will preempt an always running task during 1 tick
> > every 680ms. But also you should keep in mind that a waking normal
> > task will preempt the idle task immediately which means that it will
> > not add scheduling latency to a normal task but "steal" 0.14% of
> > normal task throughput (1/680) at most
> That=E2=80=99s true. But in the VM case, when VM are busy(MWAIT passthrou=
gh
> or running cpu eating works), the 1-tick scheduling latency could be
> detected by cyclictest running in the VM.
>
> OTOH, we compensate vruntime in place_entity() to boot waking
> without distinguish SCHED_IDLE task, do you think it=E2=80=99s necessary =
to
> do that? like
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4115,7 +4115,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se, int initial)
>                 vruntime +=3D sched_vslice(cfs_rq, se);
>
>         /* sleeps up to a single latency don't count. */
> -       if (!initial) {
> +       if (!initial && likely(!task_has_idle_policy(task_of(se)))) {
>                 unsigned long thresh =3D sysctl_sched_latency;

Yeah, this is a good improvement.
Does it solve your problem ?

>
> >
> >> OTOH, cgroups(shares) could introduce extra complexity. :)
> >>
> >> I wonder if there=E2=80=99s any possibility to make SCHED_IDLEs=E2=80=
=99 priorities absolutely
> >> lower than SCHED_NORMAL(OTHER), which means no weights/shares
> >> for them, and they run only when no other task=E2=80=99s runnable.
> >> I guess there may be priority inversion issue if we do that. But maybe=
 we
> >
> > Exactly, that's why we must ensure a minimum running time for sched_idl=
e task
>
> Still for VM case, different VMs have been much isolated from each other,
> priority inversion issue could be very rare, we=E2=80=99re trying to make=
 offline tasks
> absoultly harmless to online tasks. :)
>
> Thanks a lot for your time.
> Regards,
> Jiang
>
> >
> >> could avoid it by load-balance more aggressively, or it(priority inver=
sion)
> >> could be ignored in some special case.
> >>
> >>>
>
