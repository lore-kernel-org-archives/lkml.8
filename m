Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57BFC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B50C207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuZYxy6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgEKJgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:36:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D19C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:36:38 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x73so6930691lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZCRMF2/Mc5tNQ7BKp3A1EJqxFWcIg8LW8tmexmzs48=;
        b=HuZYxy6J2ZkS5FZKxM9pdnuJVqjysWauuV2D5iWSQVp1aledpnDTittIQwaGmKRaaQ
         N1IBxfyfFxPuzsi7ZaGRPxo1L1OmaSlpjAvVp4GM3ATEJh5GfBu3dgzIkgpD5jlLbU5r
         aqfGthM55ihOYmvSt7j9k3GwDtIOTBtXHqh+clDvnBBUQQz0p9PZgtA5l5Yh+QSn29Hn
         oIg0kjLalUJmKpKUuWiICqQTBrGyZQwmtEerMovY+JOFGzOS3vjcxKyVwI0xfZBkkkn/
         pXrl1GFvEfBSUARGlqEbRCyvroAVaI9qo6kVBLYsVk3P1VfAXSRNd+XTMsb5Y05Ri8HS
         siwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZCRMF2/Mc5tNQ7BKp3A1EJqxFWcIg8LW8tmexmzs48=;
        b=lLqpnHwyZrr3YjyBsbJZjIn9aX45iwot2Q6tplXs21r/tgDsPiawnVcITP/5MimL40
         za56yE9wen3Fsp2jE7RtYplX60PVPscefSiHy78FDq6+SsWEnoIcbe0hVLLOpB7CufkU
         2xT59SMJUXuoU6D1FiyJ7EhFHseDQuQtGFxfHulB8DQn9rs2//WQSfKBaDmO6eDK/tuB
         dXaBPxo0BwjfDZpiqG1GMZzDmtMegz9HCQy8/K1EiOEdqn9fgjqNiAopBtC/OO/bcsQV
         FGsnjkiE+N7MgbQy2t5L0Z5yjbRXNmKNTFX0PM41GLDFdlrOnhcwPFpKp/7XrX4O2m6a
         aURw==
X-Gm-Message-State: AOAM5326f9sgglo5LUTzT4egPhkh2nOq2GpzCGuIIcB3IcQflHiHcGeO
        F0e7cT9epVtJCiDimnr370B5+rkw0rsz7yyBxV4dQw==
X-Google-Smtp-Source: ABdhPJwT41GQxfG4Rosu+MW5aPgQjZJB/NhcfXXX70DGKhnexGfAF68cbugxdC8dGM6UVKoMzmBOhGAwKrVJXxzU090=
X-Received: by 2002:ac2:46c1:: with SMTP id p1mr9898041lfo.25.1589189797122;
 Mon, 11 May 2020 02:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com> <20200508151515.GA25974@geo.homenetwork>
 <CAKfTPtCeA1VcEierR5iyQJApU5JMFQqkMSR+2JGU4o5cG76opQ@mail.gmail.com>
 <20200508170213.GA27353@geo.homenetwork> <801229de-200d-c9d5-7fd3-8556c5abc064@arm.com>
In-Reply-To: <801229de-200d-c9d5-7fd3-8556c5abc064@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 May 2020 11:36:24 +0200
Message-ID: <CAKfTPtAq9GDgvok5Z87mHL++ie+tiuyHHnruGea1+jvfffzpvw@mail.gmail.com>
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

On Mon, 11 May 2020 at 10:40, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 08/05/2020 19:02, Tao Zhou wrote:
> > On Fri, May 08, 2020 at 05:27:44PM +0200, Vincent Guittot wrote:
> >> On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
> >>>
> >>> Hi Phil,
> >>>
> >>> On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
> >>>> sched/fair: Fix enqueue_task_fair warning some more
>
> [...]
>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index 02f323b85b6d..c6d57c334d51 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -5479,6 +5479,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>>>               /* end evaluation on encountering a throttled cfs_rq */
> >>>>               if (cfs_rq_throttled(cfs_rq))
> >>>>                       goto enqueue_throttle;
> >>>> +
> >>>> +               /*
> >>>> +                * One parent has been throttled and cfs_rq removed from the
> >>>> +                * list. Add it back to not break the leaf list.
> >>>> +                */
> >>>> +               if (throttled_hierarchy(cfs_rq))
> >>>> +                       list_add_leaf_cfs_rq(cfs_rq);
> >>>>       }
> >>>
> >>> I was confused by why the throttled cfs rq can be on list.
> >>> It is possible when enqueue a task and thanks to the 'threads'.
> >>> But I think the above comment does not truely put the right
> >>> intention, right ?
> >>> If throttled parent is onlist, the child cfs_rq is ignored
> >>> to be added to the leaf cfs_rq list me think.
> >>>
> >>> unthrottle_cfs_rq() follows the same logic if i am not wrong.
> >>> Is it necessary to add the above to it ?
> >>
> >> When a cfs_rq is throttled, its sched group is dequeued and all child
> >> cfs_rq are removed from  leaf_cfs_rq list. But the sched group of the
> >> child cfs_rq stay enqueued in the throttled cfs_rq so child sched
> >> group->on_rq might be still set.
> >
> > If there is a throttle of throttle, and unthrottle the child throttled
> > cfs_rq(ugly):
> >                                ...
> >                                 |
> >                       cfs_rq throttled (parent A)
> >                                 |
> >                                 |
> >                       cfs_rq in hierarchy (B)
> >                                 |
> >                                 |
> >                       cfs_rq throttled (C)
> >                                 |
> >                                ...
> >
> > Then unthrottle the child throttled cfs_rq C, now the A is on the
> > leaf_cfs_rq list. sched_group entity of C is enqueued to B, and
> > sched_group entity of B is on_rq and is ignored by enqueue but in
> > the throttled hierarchy and not add to leaf_cfs_rq list.
> > The above may be absolutely wrong that I miss something.
> >
> > Another thing :
> > In enqueue_task_fair():
> >
> >       for_each_sched_entity(se) {
> >               cfs_rq = cfs_rq_of(se);
> >
> >               if (list_add_leaf_cfs_rq(cfs_rq))
> >                       break;
> >       }
> >
> > In unthrottle_cfs_rq():
> >
> >       for_each_sched_entity(se) {
> >               cfs_rq = cfs_rq_of(se);
> >
> >               list_add_leaf_cfs_rq(cfs_rq);
> >       }
> >
> > The difference between them is that if condition, add if
> > condition to unthrottle_cfs_rq() may be an optimization and
> > keep the same.
> >
>
> I'm not 100% sure if this is exactly what Tao pointed out here but I
> also had difficulties understanding understanding how this patch works:
>
>                        p.se
>                         |
>       __________________|
>       |
>       V
>      cfs_c -> tg_c ->  se_c (se->on_rq = 1)
>                         |
>       __________________|
>       |
>       v
>      cfs_b -> tg_b ->  se_b
>                         |
>       __________________|
>       |
>       V
>      cfs_a -> tg_a ->  se_a
>                         |
>       __________________|
>       |
>       V
>      cfs_r -> tg_r
>       |
>       V
>       rq
>

In your example, which cfs_ rq has been throttled ? cfs_a ?

> (1) The incomplete update happens with cfs_c at the end of
>     enqueue_entity() in the first loop because of 'if ( .... ||
>     cfs_bandwidth_used())' (cfs_b->on_list=0 since cfs_a is throttled)

so cfs_c is added with the 1st loop

>
> (2) se_c breaks out of the first loop (se_c->on_rq = 1)
>
> (3) With the patch cfs_b is added back to the list.
>     But only because cfs_a->on_list=1.

hmm I don't understand the link between cfs_b been added and cfs_a->on_list=1

cfs_b is added with 2nd loop because its throttle_count > 0 due to
cfs_a been throttled (purpose of this patch)

>
> But since cfs_a is throttled it should be cfs_a->on_list=0 as well.

So 2nd loop breaks because cfs_a is throttled

The 3rd loop will add cfs_a

> throttle_cfs_rq()->walk_tg_tree_from(..., tg_throttle_down, ...) should
> include cfs_a when calling list_del_leaf_cfs_rq().
>
> IMHO, throttle_cfs_rq() calls tg_throttle_down() for the throttled
> cfs_rq too.
>
>
> Another thing: Why don't we use throttled_hierarchy(cfs_rq) instead of
> cfs_bandwidth_used() in enqueue_entity() as well?

Mainly to be conservative because as this patch demonstrates, there
are a lot of possible use cases and combinations and I can't ensure
that it is always safe to use the throttled_hierarchy.
