Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E67C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC815206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuLILASw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgEKROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbgEKROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:14:31 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD9CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:14:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so8157214lfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sb4ra23XyszA4AK865cfO4rcCikUbslE1rJprkW4Zw=;
        b=DuLILASwN0JEFSsNdlE/zTNjFmhZMRc2njVHMcx1kOx69kYDSl/ekdJxzBjvueJUcw
         3cAaqu9+8LKiUA4nWtBJvax2TNuqqAQXCZFZ3TpwVDdRZCeyzzfj8Pk8e/Q2r8gLeWUv
         mukZEmvPzbfIwuswhAW6jTlUge0tvpLYg+k037F0vR1EAfKqdeB2R5lm1Fxk7ygIZubI
         lSvraSoYjTmmHFgZy+pIq59ePNcwJmLjoBLWj0pVTlbj7ihhACY9HhtuIru3jIhD8RQh
         CxPTWOgXGRgtJbON5ZH8sYRvSoWXxE7HdWsPDiru2hukG3GKNlW8sKIBSKln1eG6wPr7
         WNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sb4ra23XyszA4AK865cfO4rcCikUbslE1rJprkW4Zw=;
        b=HtvCbaTsEduv09mlk0sE4g1kdIPGaOSCL5sigDtdfxgg0WShoximWjKUa0l4OC13qr
         4dGG8VrengvutLQ9Em2Q2x3SylGiLM0cZ3aorB467eyYYdsTQdS0m7ZwVZRV0A0CAhTo
         6q0GdrYKDiQq7HZfQ8WXTLlzUyESL4ADfK/VmZdkZtE6Gu4inXJsYqs254wnEfOydDUO
         kv4WlO+3RNuTXGlVIcwgpGILszMYnpLmvEOlHb2eVWA4YyQvnrRgfvvRK996c9aPQvhj
         el38WkldwwLCar/4c8sRsyHXbUB2P3+ltHPeglhkWXb8YoYE6lMVThMeJ/wKdPL7qQDh
         X9OA==
X-Gm-Message-State: AOAM532hzauFjFNzSg3BsFOONZKlIkEfAuGxaZHPX+vYvakvwp/st9mI
        o/Qtz9AvlaW3FhVPH5oM+QBtCG7ofN58hzZxI97e2w==
X-Google-Smtp-Source: ABdhPJxNqtxcMaJeK+AjAuHFyWUUOW8MA/tr2g4pW4qTtzOkYgd4k2IOz19My3C6u4IeoWqCe6LNqHqSv64uRIGkzlg=
X-Received: by 2002:a05:6512:44e:: with SMTP id y14mr11674238lfk.190.1589217267017;
 Mon, 11 May 2020 10:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com> <20200508151515.GA25974@geo.homenetwork>
 <CAKfTPtCeA1VcEierR5iyQJApU5JMFQqkMSR+2JGU4o5cG76opQ@mail.gmail.com>
 <20200508170213.GA27353@geo.homenetwork> <801229de-200d-c9d5-7fd3-8556c5abc064@arm.com>
 <CAKfTPtAq9GDgvok5Z87mHL++ie+tiuyHHnruGea1+jvfffzpvw@mail.gmail.com>
 <b452358a-afca-ce3f-ec56-cf194a0b6a50@arm.com> <CAKfTPtB71Ov8HkBsVWKnn+_-SmXGHB167oKOmgpyEzycuZbhWg@mail.gmail.com>
 <2a45d9ac-1d8a-da8c-a743-7e1f87724635@arm.com>
In-Reply-To: <2a45d9ac-1d8a-da8c-a743-7e1f87724635@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 May 2020 19:14:15 +0200
Message-ID: <CAKfTPtBZs_+5bM7qqLFV-2TU3xSnTd-oBxqQ6GVCQc_oK-8mhg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Tao Zhou <zohooouoto@zoho.com.cn>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tao Zhou <ouwen210@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 at 19:02, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/05/2020 14:12, Vincent Guittot wrote:
> > On Mon, 11 May 2020 at 12:39, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 11/05/2020 11:36, Vincent Guittot wrote:
> >>> On Mon, 11 May 2020 at 10:40, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> On 08/05/2020 19:02, Tao Zhou wrote:
> >>>>> On Fri, May 08, 2020 at 05:27:44PM +0200, Vincent Guittot wrote:
> >>>>>> On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
> >>>>>>>
> >>>>>>> Hi Phil,
> >>>>>>>
> >>>>>>> On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
> >>>>>>>> sched/fair: Fix enqueue_task_fair warning some more
> >>
> >> [...]
> >>
> >>>> I'm not 100% sure if this is exactly what Tao pointed out here but I
> >>>> also had difficulties understanding understanding how this patch works:
> >>>>
> >>>>                        p.se
> >>>>                         |
> >>>>       __________________|
> >>>>       |
> >>>>       V
> >>>>      cfs_c -> tg_c ->  se_c (se->on_rq = 1)
> >>>>                         |
> >>>>       __________________|
> >>>>       |
> >>>>       v
> >>>>      cfs_b -> tg_b ->  se_b
> >>>>                         |
> >>>>       __________________|
> >>>>       |
> >>>>       V
> >>>>      cfs_a -> tg_a ->  se_a
> >>>>                         |
> >>>>       __________________|
> >>>>       |
> >>>>       V
> >>>>      cfs_r -> tg_r
> >>>>       |
> >>>>       V
> >>>>       rq
> >>>>
> >>>
> >>> In your example, which cfs_ rq has been throttled ? cfs_a ?
> >>
> >> Yes, cfs_a. 0xffffa085e48ce000 in Phil's trace.
> >>
> >>>
> >>>> (1) The incomplete update happens with cfs_c at the end of
> >>>>     enqueue_entity() in the first loop because of 'if ( .... ||
> >>>>     cfs_bandwidth_used())' (cfs_b->on_list=0 since cfs_a is throttled)
> >>>
> >>> so cfs_c is added with the 1st loop
> >>
> >> Yes.
> >>
> >>>> (2) se_c breaks out of the first loop (se_c->on_rq = 1)
> >>>>
> >>>> (3) With the patch cfs_b is added back to the list.
> >>>>     But only because cfs_a->on_list=1.
> >>>
> >>> hmm I don't understand the link between cfs_b been added and cfs_a->on_list=1
> >>
> >> cfs_b, 0xffffa085e48ce000 is the one which is now added in the 2. loop.
> >>
> >> Isn't the link between cfs_b and cfs_a the first if condition in
> >
> > on_list is only there to say if the cfs_rq is already in the list but
> > there is not dependency with the child
>
> Yes, I agree. But coming back to what the patch does in the example:
>
> W/ the patch, list_add_leaf_cfs_rq() is now called for cfs_b and since
> cfs_b->tg->parent->cfs_a and cfs_a->on_list=1 the 'branch is now
> connected' which means 'rq->tmp_alone_branch = &rq->leaf_cfs_rq_list'.
>
> I.e. assert_list_leaf_cfs_rq() at the end of enqueue_task_fair() is not
> barfing anymore.
>
> W/o the patch, list_add_leaf_cfs_rq() called w/ cfs_c left the 'branch
> open', it's not called on cfs_b and since cfs_a->on_list=1, the 3rd
> for_each_sched_entity() in enqueue_task_fair() doesn't 'connect the
> branch' so the assert fires.
>
> What I don't immediately see is how can cfs_a be throttled (which causes
> cfs_b -> cfs_c being a throttled hierarchy) and be on the list
> (cfs_a->on_list=1) at the same time.
>
> So the only thing how this could happen is when there was a task enqueue
> in a parallel cfs_b' (another child of cfs_a) sub hierarchy just before
> the example.

Yes. A task has been enqueued on another child (cfs_b') and cfs_a has
been be added back to ensure that cfs are correctly ordered

>
> >> list_add_leaf_cfs_rq():
> >>
> >>   if (cfs_rq->tg->parent &&
> >>       cfs_rq->tg->parent->cfs_rq[cpu]->on_list)
> >>
> >> to 'connect the branch' or not (default, returning false case)?
> >>
> >
> > In your example above if the parent is already on the list then we
> > know where to insert the child.
>
> True, we go the 2nd if() condition in list_add_leaf_cfs_rq().
>
> >>> cfs_b is added with 2nd loop because its throttle_count > 0 due to
> >>> cfs_a been throttled (purpose of this patch)
> >>>
> >>>>
> >>>> But since cfs_a is throttled it should be cfs_a->on_list=0 as well.
> >>>
> >>> So 2nd loop breaks because cfs_a is throttled
> >>
> >> Yes.
> >>
> >>> The 3rd loop will add cfs_a
> >>
> >> Yes, but in the example, cfs_a->on_list=1, so we bail out of
> >> list_add_leaf_cfs_rq() early.
> >
> > Because the cfs_rq is on the list already so we don't have to add it
>
> Yes.
>
> [...]
