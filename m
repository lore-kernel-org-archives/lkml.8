Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C5C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D43206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQKZE2oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEKMMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgEKMMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:12:50 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D42C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:12:49 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 8so4585517lfp.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQOTyYCriClwhL5kMMHkf2pHgjcWZeNqjWfK1A+40PQ=;
        b=rQKZE2oqiAp2v2n+wVdwzKRPTv0PDBavkNLblUaT4hFTrV5z66qfT1MTbXdzGvP9No
         AcMkbtPnjvaG5dCxoD22VTEE6BNW3/TmKGto1ZRBzfOsBd34V93IPITiguy13vfKSTI2
         bPHAC43FGrM0YE8CiweSNrB2Vbfc6Bq0vWwv5u5PjnhnJJV86Vi12fiOQas6ESYSVRvn
         ghryRWwsD3Gcjj4zTz+70JU4ADtmHHa/LmBvjESfFQO/DsKRdVdK7LInBHg09bPEvp4G
         dIYn0omLlppbjqjYC+EwJ5F8e6MQbwr0hZsXltB1gg7eCxMM0UFabGfanBWxo7/otQKj
         3oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQOTyYCriClwhL5kMMHkf2pHgjcWZeNqjWfK1A+40PQ=;
        b=f49EP/9B6Cw840fB1zzAyA+kvAVj2Tc2V0INnz87o3FGHGTPe7yT9WHib0kVuAVq41
         5aqD13P4Q8Zlf2reaOrua/2JZcfA6v0k7GWvCyT35U4b0ghhchu4nMu7Pybhwl8s1sPU
         3Tw/OKBLLjuIcsVdJHYoM7cQBQN43r6rcfvAOxCO68+2RDITKhHYeQJ48sgS8PUK2v4O
         9mCv8V+76XYLMIz3nNZ5ZIRTcFzftji55n5BAYwE/Llt3voi5TAHu7OxqBg9P+rixFkb
         B+1Y/Ebrr4uCLgvoBA2PDx8eu6dm/GJOgARHo2ZI4Qll6VeC4OwcV0/LpJgF34yNcBzE
         +21A==
X-Gm-Message-State: AOAM5330fcXN5H7zAXfAnlWkUe594p5vPsVCoHOIy9HoFYLdDoy1b+Lo
        i8Y4SDNv2vLTG4s1XW/4NS/T/gz5roFN0d/jjZqxXA==
X-Google-Smtp-Source: ABdhPJy46e7PKEvfZ5JdWyORzL8TSVK+6x7c+DLeKNI8wcNn3YauKiFzAguRE72nrW4Wwy9Ru5SAIgSA5bV7ZiixIvU=
X-Received: by 2002:ac2:563b:: with SMTP id b27mr10998447lff.149.1589199167157;
 Mon, 11 May 2020 05:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com> <20200508151515.GA25974@geo.homenetwork>
 <CAKfTPtCeA1VcEierR5iyQJApU5JMFQqkMSR+2JGU4o5cG76opQ@mail.gmail.com>
 <20200508170213.GA27353@geo.homenetwork> <801229de-200d-c9d5-7fd3-8556c5abc064@arm.com>
 <CAKfTPtAq9GDgvok5Z87mHL++ie+tiuyHHnruGea1+jvfffzpvw@mail.gmail.com> <b452358a-afca-ce3f-ec56-cf194a0b6a50@arm.com>
In-Reply-To: <b452358a-afca-ce3f-ec56-cf194a0b6a50@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 May 2020 14:12:35 +0200
Message-ID: <CAKfTPtB71Ov8HkBsVWKnn+_-SmXGHB167oKOmgpyEzycuZbhWg@mail.gmail.com>
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

On Mon, 11 May 2020 at 12:39, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/05/2020 11:36, Vincent Guittot wrote:
> > On Mon, 11 May 2020 at 10:40, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 08/05/2020 19:02, Tao Zhou wrote:
> >>> On Fri, May 08, 2020 at 05:27:44PM +0200, Vincent Guittot wrote:
> >>>> On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
> >>>>>
> >>>>> Hi Phil,
> >>>>>
> >>>>> On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
> >>>>>> sched/fair: Fix enqueue_task_fair warning some more
>
> [...]
>
> >> I'm not 100% sure if this is exactly what Tao pointed out here but I
> >> also had difficulties understanding understanding how this patch works:
> >>
> >>                        p.se
> >>                         |
> >>       __________________|
> >>       |
> >>       V
> >>      cfs_c -> tg_c ->  se_c (se->on_rq = 1)
> >>                         |
> >>       __________________|
> >>       |
> >>       v
> >>      cfs_b -> tg_b ->  se_b
> >>                         |
> >>       __________________|
> >>       |
> >>       V
> >>      cfs_a -> tg_a ->  se_a
> >>                         |
> >>       __________________|
> >>       |
> >>       V
> >>      cfs_r -> tg_r
> >>       |
> >>       V
> >>       rq
> >>
> >
> > In your example, which cfs_ rq has been throttled ? cfs_a ?
>
> Yes, cfs_a. 0xffffa085e48ce000 in Phil's trace.
>
> >
> >> (1) The incomplete update happens with cfs_c at the end of
> >>     enqueue_entity() in the first loop because of 'if ( .... ||
> >>     cfs_bandwidth_used())' (cfs_b->on_list=0 since cfs_a is throttled)
> >
> > so cfs_c is added with the 1st loop
>
> Yes.
>
> >> (2) se_c breaks out of the first loop (se_c->on_rq = 1)
> >>
> >> (3) With the patch cfs_b is added back to the list.
> >>     But only because cfs_a->on_list=1.
> >
> > hmm I don't understand the link between cfs_b been added and cfs_a->on_list=1
>
> cfs_b, 0xffffa085e48ce000 is the one which is now added in the 2. loop.
>
> Isn't the link between cfs_b and cfs_a the first if condition in

on_list is only there to say if the cfs_rq is already in the list but
there is not dependency with the child

> list_add_leaf_cfs_rq():
>
>   if (cfs_rq->tg->parent &&
>       cfs_rq->tg->parent->cfs_rq[cpu]->on_list)
>
> to 'connect the branch' or not (default, returning false case)?
>

In your example above if the parent is already on the list then we
know where to insert the child.

> > cfs_b is added with 2nd loop because its throttle_count > 0 due to
> > cfs_a been throttled (purpose of this patch)
> >
> >>
> >> But since cfs_a is throttled it should be cfs_a->on_list=0 as well.
> >
> > So 2nd loop breaks because cfs_a is throttled
>
> Yes.
>
> > The 3rd loop will add cfs_a
>
> Yes, but in the example, cfs_a->on_list=1, so we bail out of
> list_add_leaf_cfs_rq() early.

Because the cfs_rq is on the list already so we don't have to add it

>
> I don't grasp how can cfs_a->on_list=1, when cfs_a is throttled and
> cfs_b, cfs_c are in a throttled hierarchy?
>
> >> throttle_cfs_rq()->walk_tg_tree_from(..., tg_throttle_down, ...) should
> >> include cfs_a when calling list_del_leaf_cfs_rq().
> >>
> >> IMHO, throttle_cfs_rq() calls tg_throttle_down() for the throttled
> >> cfs_rq too.
> >>
> >>
> >> Another thing: Why don't we use throttled_hierarchy(cfs_rq) instead of
> >> cfs_bandwidth_used() in enqueue_entity() as well?
> >
> > Mainly to be conservative because as this patch demonstrates, there
> > are a lot of possible use cases and combinations and I can't ensure
> > that it is always safe to use the throttled_hierarchy.
>
> Maybe this deserves a comment then.
