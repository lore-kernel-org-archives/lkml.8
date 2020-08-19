Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339692083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6EQHRAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgHSO4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgHSO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:56:05 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09ABC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 07:56:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x24so12198192lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uWkXP70/enYrVZlkW0JQ8VwOBRfdj++9BTLJCNJzUCM=;
        b=k6EQHRAXD0q+WpwgpztejJjDo+4OodhkqN/mJnGdAc7qLS7CzvbyeJb92wfPF031g8
         F6T2jd28WDZ0xxOr4FRjt/iuAMR62tPTtVgiSdeQZ4BFzmrIe2GhuSXTi66HX1NMs4z6
         8oTp1E3Pur9a6SNDdDIC1ZrJQnfxHnEBw/F45dnKnV4SyOGDwvmVSA4xvit4t6id57ju
         PbfFySSHEDgol5E7u+0kSR0BoWq+o/qElg20xfGF9O1Ksl5c8ZvYqCrmOr/3zKkl7xOC
         ttD0F5eeuX4dmCqVwjWd/zKg40GT1ZCOBaapDAKMQHQM5qPiygF6qiTn6EFIbWio1vTz
         ji9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uWkXP70/enYrVZlkW0JQ8VwOBRfdj++9BTLJCNJzUCM=;
        b=HXqwvAp/RX57pe9RKEuwwnxm67ju/7jomVvtaMCz41B4QEbZjO4/tSVnyUEclzVnba
         juyE6nA477RQ3mNtiH9FsV8n9dUMyRdHAzlpIia7SSd1DS/79InWwzzcQNLr0PTUQtV6
         Z7YHIBQUL0xJi35aw3IMygOYHqKHA9J0xEaOEJUWXsjUNafZxAinCNnKZ70TmGTy+CBw
         1OeR3wX+zp/YzM8YgzL7zYp3kmg3/Q3+yzN2jejZ1KDvQCV+vl2eVGoIdMiCUCTZdoo7
         1eClZQcK3lB6NnQ4UmMFX66sTmCqkAFZhxRSOP5HrqnaRLax+RazV6+/3HxpV7gtrkzB
         ErKg==
X-Gm-Message-State: AOAM531crF5nxEatKDD8AnUr8LLwDvpzTKdxFviJhgDlWMSGICfWWO4Y
        oX2ve1rjvlQiKSqOLVu2vmjpfe00As8Oc1JdgBIS5Q==
X-Google-Smtp-Source: ABdhPJzBiqgy4FwdWgQ4l6X6mhDG9p9JW/Ra0zCCYpAA0aIajsUI8JVETVRj9c3DiUQX/rqkCP88/raUbAKH5YfS/fs=
X-Received: by 2002:a19:c68b:: with SMTP id w133mr12319418lff.189.1597848962026;
 Wed, 19 Aug 2020 07:56:02 -0700 (PDT)
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
In-Reply-To: <A8E52241-0206-447D-9EA0-699F8F82AFAB@tencent.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Aug 2020 16:55:49 +0200
Message-ID: <CAKfTPtBiZHwkhCkMQs9iOF=eBLgubsJkARN5zOKZzmfo_jTJzg@mail.gmail.com>
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

On Wed, 19 Aug 2020 at 16:27, benbjiang(=E8=92=8B=E5=BD=AA) <benbjiang@tenc=
ent.com> wrote:
>
>
>
> > On Aug 19, 2020, at 7:55 PM, Dietmar Eggemann <dietmar.eggemann@arm.com=
> wrote:
> >
> > On 19/08/2020 13:05, Vincent Guittot wrote:
> >> On Wed, 19 Aug 2020 at 12:46, Dietmar Eggemann <dietmar.eggemann@arm.c=
om> wrote:
> >>>
> >>> On 17/08/2020 14:05, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>
> >>>>
> >>>>> On Aug 17, 2020, at 4:57 PM, Dietmar Eggemann <dietmar.eggemann@arm=
.com> wrote:
> >>>>>
> >>>>> On 14/08/2020 01:55, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>>> On Aug 13, 2020, at 2:39 AM, Dietmar Eggemann <dietmar.eggemann@a=
rm.com> wrote:
> >>>>>>>
> >>>>>>> On 12/08/2020 05:19, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>>> On Aug 11, 2020, at 11:54 PM, Dietmar Eggemann <dietmar.eggeman=
n@arm.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 11/08/2020 02:41, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>>> On Aug 10, 2020, at 9:24 PM, Dietmar Eggemann <dietmar.eggema=
nn@arm.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On 06/08/2020 17:52, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>>>>> Hi,
> >>>>>>>>>>>>
> >>>>>>>>>>>>> On Aug 6, 2020, at 9:29 PM, Dietmar Eggemann <dietmar.eggem=
ann@arm.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On 03/08/2020 13:26, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On Aug 3, 2020, at 4:16 PM, Dietmar Eggemann <dietmar.egg=
emann@arm.com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On 01/08/2020 04:32, Jiang Biao wrote:
> >>>>>>>>>>>>>>>> From: Jiang Biao <benbjiang@tencent.com>
> >>>
> >>> [...]
> >>>
> >>>>> Are you sure about this?
> >>>> Yes. :)
> >>>>>
> >>>>> The math is telling me for the:
> >>>>>
> >>>>> idle task:      (3 / (1024 + 1024 + 3))^(-1) * 4ms =3D 2735ms
> >>>>>
> >>>>> normal task: (1024 / (1024 + 1024 + 3))^(-1) * 4ms =3D    8ms
> >>>>>
> >>>>> (4ms - 250 Hz)
> >>>> My tick is 1ms - 1000HZ, which seems reasonable for 600ms? :)
> >>>
> >>> OK, I see.
> >>>
> >>> But here the different sched slices (check_preempt_tick()->
> >>> sched_slice()) between normal tasks and the idle task play a role to.
> >>>
> >>> Normal tasks get ~3ms whereas the idle task gets <0.01ms.
> >>
> >> In fact that depends on the number of CPUs on the system
> >> :sysctl_sched_latency =3D 6ms * (1 + ilog(ncpus)) . On a 8 cores syste=
m,
> >> normal task will run around 12ms in one shoot and the idle task still
> >> one tick period
> >
> > True. This is on a single CPU.
> Agree. :)
>
> >
> >> Also, you can increase even more the period between 2 runs of idle
> >> task by using cgroups and min shares value : 2
> >
> > Ah yes, maybe this is what Jiang wants to do then? If his runtime does
> > not have other requirements preventing this.
> That could work for increasing the period between 2 runs. But could not
> reduce the single runtime of idle task I guess, which means normal task
> could have 1-tick schedule latency because of idle task.

Yes.  An idle task will preempt an always running task during 1 tick
every 680ms. But also you should keep in mind that a waking normal
task will preempt the idle task immediately which means that it will
not add scheduling latency to a normal task but "steal" 0.14% of
normal task throughput (1/680) at most

> OTOH, cgroups(shares) could introduce extra complexity. :)
>
> I wonder if there=E2=80=99s any possibility to make SCHED_IDLEs=E2=80=99 =
priorities absolutely
> lower than SCHED_NORMAL(OTHER), which means no weights/shares
> for them, and they run only when no other task=E2=80=99s runnable.
> I guess there may be priority inversion issue if we do that. But maybe we

Exactly, that's why we must ensure a minimum running time for sched_idle ta=
sk

> could avoid it by load-balance more aggressively, or it(priority inversio=
n)
> could be ignored in some special case.
>
> Thx.
> Regard,
> Jiang
>
> >
> > [...]
>
