Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DCBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F94C2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxH5JeBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgHTOhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgHTOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:36:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE4C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:36:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v9so2348412ljk.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/vxfGRi1Z4Dl56Vx6+iX1Qfn/fKXqk6lsIAXkxtBVrE=;
        b=DxH5JeBv4kpvcBxr4M/HvoLb1tGs53J48PmDAp8MUvEKJnkXFigZToa/+R+HWzDWpr
         eCzDGukrCJdhGDuXGUGt04IBfgcZLSZ2a/fTp3Sy8MVHkbEy6vSxyOrXjKNvrlW2OuUZ
         yzTW0NHkQiBJ4TAwxXE3KGNHEhjIL/jnHPx2WOSajqGVU/+aroVV+6Fs1Yq4uYGn2JBj
         FnVFEfu/aVeR5C99K7dxbTw20u7Q0R4GLFbZQtQoT2oThUP/1CKnIssKKSJQsMh+92a0
         r84YL7xzju05KuLJQask4psyST0lYBo+0APlmLg7g/wtaxN/AqtdXE9FEHf4d2tRkT5f
         6+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/vxfGRi1Z4Dl56Vx6+iX1Qfn/fKXqk6lsIAXkxtBVrE=;
        b=Ee1CmDmk1jOq+CPj5LIkCp9xZSFw6My+mO38xihYOyX8hQpmkMlD1Q4u9Tpx1Se72i
         fFCRg8eTWwQjkDk4PnNrNzSbzT+qw/Hr5ObTCSbU+bAudt0mHJm3m5yNh+4Oy5B09a/F
         b8AMvd1ChvnGvXxWBe3h9YuTyVD5YnJ8ZlOXYFTD3NizbJDuykXexR3U/PQwBqkXY+Fv
         lUOR6y17owirGkt+W2cXTA9nGyk2ssHF9xf7pW9CkNjj9TGrnJbReWK98GMN0Pi44DpW
         exU7qYAZdsImtwAtEH2S/89Yw13arTajY/BxZBsNNpxO3NXYEtvYtvoK29bI7lx/bBeA
         I9vw==
X-Gm-Message-State: AOAM531KFt+uEkojszRK5fqz/Ukcs4Ox/nMyhlYk6fYeMzXwjGza2S5q
        75f8MA1abCVzibkH9FKDf6pHLphcSo8sshXyvYm4tg==
X-Google-Smtp-Source: ABdhPJx9ejA7SlCoMH6R5LaXcPbhYxKgaSomdJsUCvvl1+SUyHMwM7cB+Yxsup6GzCG5BVAFQEkopPYF4jHsB1kAy5c=
X-Received: by 2002:a2e:9b99:: with SMTP id z25mr1864983lji.226.1597934216150;
 Thu, 20 Aug 2020 07:36:56 -0700 (PDT)
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
 <CAKfTPtBiZHwkhCkMQs9iOF=eBLgubsJkARN5zOKZzmfo_jTJzg@mail.gmail.com>
 <3A85DD77-2A4B-466F-A1F4-1BF2AF02CF58@tencent.com> <CAKfTPtATpDB+ihpMf854nTdDfy4Bw_BU=21PRHVczEcE42271Q@mail.gmail.com>
 <D80F1584-F569-4CEE-8DCC-7841CF7E159F@tencent.com> <CAKfTPtA_QtEbYT7iBxAZWBq_w=PGAuvg7LsxsccOSRBk19bW8Q@mail.gmail.com>
 <CAPJCdBnkdvj12ritf46ZzxikvKRz7fcnijR0ca210QQnsG-Q_w@mail.gmail.com>
In-Reply-To: <CAPJCdBnkdvj12ritf46ZzxikvKRz7fcnijR0ca210QQnsG-Q_w@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Aug 2020 16:36:44 +0200
Message-ID: <CAKfTPtBNcTm2C+7x8GBJ8M9uqnUhcOgpLZvP=0Q4K6rbT8EFiQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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

On Thu, 20 Aug 2020 at 16:28, Jiang Biao <benbjiang@gmail.com> wrote:
>
> On Thu, 20 Aug 2020 at 20:46, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 20 Aug 2020 at 13:28, benbjiang(=E8=92=8B=E5=BD=AA) <benbjiang@=
tencent.com> wrote:
> > >
> > >
> > >
> > > > On Aug 20, 2020, at 3:35 PM, Vincent Guittot <vincent.guittot@linar=
o.org> wrote:
> > > >
> > > > On Thu, 20 Aug 2020 at 02:13, benbjiang(=E8=92=8B=E5=BD=AA) <benbji=
ang@tencent.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >>> On Aug 19, 2020, at 10:55 PM, Vincent Guittot <vincent.guittot@li=
naro.org> wrote:
> > > >>>
> > > >>> On Wed, 19 Aug 2020 at 16:27, benbjiang(=E8=92=8B=E5=BD=AA) <benb=
jiang@tencent.com> wrote:
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>>> On Aug 19, 2020, at 7:55 PM, Dietmar Eggemann <dietmar.eggemann=
@arm.com> wrote:
> > > >>>>>
> > > >>>>> On 19/08/2020 13:05, Vincent Guittot wrote:
> > > >>>>>> On Wed, 19 Aug 2020 at 12:46, Dietmar Eggemann <dietmar.eggema=
nn@arm.com> wrote:
> > > >>>>>>>
> > > >>>>>>> On 17/08/2020 14:05, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> > > >>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>>> On Aug 17, 2020, at 4:57 PM, Dietmar Eggemann <dietmar.egge=
mann@arm.com> wrote:
> > > >>>>>>>>>
> > > >>>>>>>>> On 14/08/2020 01:55, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> > > >>>>>>>>>> Hi,
> > > >>>>>>>>>>
> > > >>>>>>>>>>> On Aug 13, 2020, at 2:39 AM, Dietmar Eggemann <dietmar.eg=
gemann@arm.com> wrote:
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> On 12/08/2020 05:19, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> > > >>>>>>>>>>>> Hi,
> > > >>>>>>>>>>>>
> > > >>>>>>>>>>>>> On Aug 11, 2020, at 11:54 PM, Dietmar Eggemann <dietmar=
.eggemann@arm.com> wrote:
> > > >>>>>>>>>>>>>
> > > >>>>>>>>>>>>> On 11/08/2020 02:41, benbjiang(=E8=92=8B=E5=BD=AA) wrot=
e:
> > > >>>>>>>>>>>>>> Hi,
> > > >>>>>>>>>>>>>>
> > > >>>>>>>>>>>>>>> On Aug 10, 2020, at 9:24 PM, Dietmar Eggemann <dietma=
r.eggemann@arm.com> wrote:
> > > >>>>>>>>>>>>>>>
> > > >>>>>>>>>>>>>>> On 06/08/2020 17:52, benbjiang(=E8=92=8B=E5=BD=AA) wr=
ote:
> > > >>>>>>>>>>>>>>>> Hi,
> > > >>>>>>>>>>>>>>>>
> > > >>>>>>>>>>>>>>>>> On Aug 6, 2020, at 9:29 PM, Dietmar Eggemann <dietm=
ar.eggemann@arm.com> wrote:
> > > >>>>>>>>>>>>>>>>>
> > > >>>>>>>>>>>>>>>>> On 03/08/2020 13:26, benbjiang(=E8=92=8B=E5=BD=AA) =
wrote:
> > > >>>>>>>>>>>>>>>>>>
> > > >>>>>>>>>>>>>>>>>>
> > > >>>>>>>>>>>>>>>>>>> On Aug 3, 2020, at 4:16 PM, Dietmar Eggemann <die=
tmar.eggemann@arm.com> wrote:
> > > >>>>>>>>>>>>>>>>>>>
> > > >>>>>>>>>>>>>>>>>>> On 01/08/2020 04:32, Jiang Biao wrote:
> > > >>>>>>>>>>>>>>>>>>>> From: Jiang Biao <benbjiang@tencent.com>
> > > >>>>>>>
> > > >>>>>>> [...]
> > > >>>>>>>
> > > >>>>>>>>> Are you sure about this?
> > > >>>>>>>> Yes. :)
> > > >>>>>>>>>
> > > >>>>>>>>> The math is telling me for the:
> > > >>>>>>>>>
> > > >>>>>>>>> idle task:      (3 / (1024 + 1024 + 3))^(-1) * 4ms =3D 2735=
ms
> > > >>>>>>>>>
> > > >>>>>>>>> normal task: (1024 / (1024 + 1024 + 3))^(-1) * 4ms =3D    8=
ms
> > > >>>>>>>>>
> > > >>>>>>>>> (4ms - 250 Hz)
> > > >>>>>>>> My tick is 1ms - 1000HZ, which seems reasonable for 600ms? :=
)
> > > >>>>>>>
> > > >>>>>>> OK, I see.
> > > >>>>>>>
> > > >>>>>>> But here the different sched slices (check_preempt_tick()->
> > > >>>>>>> sched_slice()) between normal tasks and the idle task play a =
role to.
> > > >>>>>>>
> > > >>>>>>> Normal tasks get ~3ms whereas the idle task gets <0.01ms.
> > > >>>>>>
> > > >>>>>> In fact that depends on the number of CPUs on the system
> > > >>>>>> :sysctl_sched_latency =3D 6ms * (1 + ilog(ncpus)) . On a 8 cor=
es system,
> > > >>>>>> normal task will run around 12ms in one shoot and the idle tas=
k still
> > > >>>>>> one tick period
> > > >>>>>
> > > >>>>> True. This is on a single CPU.
> > > >>>> Agree. :)
> > > >>>>
> > > >>>>>
> > > >>>>>> Also, you can increase even more the period between 2 runs of =
idle
> > > >>>>>> task by using cgroups and min shares value : 2
> > > >>>>>
> > > >>>>> Ah yes, maybe this is what Jiang wants to do then? If his runti=
me does
> > > >>>>> not have other requirements preventing this.
> > > >>>> That could work for increasing the period between 2 runs. But co=
uld not
> > > >>>> reduce the single runtime of idle task I guess, which means norm=
al task
> > > >>>> could have 1-tick schedule latency because of idle task.
> > > >>>
> > > >>> Yes.  An idle task will preempt an always running task during 1 t=
ick
> > > >>> every 680ms. But also you should keep in mind that a waking norma=
l
> > > >>> task will preempt the idle task immediately which means that it w=
ill
> > > >>> not add scheduling latency to a normal task but "steal" 0.14% of
> > > >>> normal task throughput (1/680) at most
> > > >> That=E2=80=99s true. But in the VM case, when VM are busy(MWAIT pa=
ssthrough
> > > >> or running cpu eating works), the 1-tick scheduling latency could =
be
> > > >> detected by cyclictest running in the VM.
> > > >>
> > > >> OTOH, we compensate vruntime in place_entity() to boot waking
> > > >> without distinguish SCHED_IDLE task, do you think it=E2=80=99s nec=
essary to
> > > >> do that? like
> > > >>
> > > >> --- a/kernel/sched/fair.c
> > > >> +++ b/kernel/sched/fair.c
> > > >> @@ -4115,7 +4115,7 @@ place_entity(struct cfs_rq *cfs_rq, struct s=
ched_entity *se, int initial)
> > > >>                vruntime +=3D sched_vslice(cfs_rq, se);
> > > >>
> > > >>        /* sleeps up to a single latency don't count. */
> > > >> -       if (!initial) {
> > > >> +       if (!initial && likely(!task_has_idle_policy(task_of(se)))=
) {
> > > >>                unsigned long thresh =3D sysctl_sched_latency;
> > > >
> > > > Yeah, this is a good improvement.
> > > Thanks, I=E2=80=99ll send a patch for that. :)
> > >
> > > > Does it solve your problem ?
> > > >
> > > Not exactly. :)  I wonder if we can make SCHED_IDLE more pure(harmles=
s)?
> >
> > We can't prevent it from running time to time. Proxy execution feature
> > could be a step for considering to relax this constraint
> >
> Could you please help to explain more about the *Proxy execution feature*=
?
> I'm not sure I got the right point.

https://lwn.net/Articles/820575/
https://lwn.net/Articles/793502/

>
> Thanks a lot.
> Regards,
> Jiang
