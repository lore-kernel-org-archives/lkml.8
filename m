Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1203C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB2624980
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CV42aVcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEHP16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgEHP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:27:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6AEC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:27:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h26so1735030lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFn8omqpPyP6yYWvRZAtzgNfdrHcBeFpZiqovJJI8PU=;
        b=CV42aVcRM8sgQyI+q9OkPrEsf4LJZVctUXQJK16eTt5EpHphq8vf1WA1AElg7OQc7h
         CP/H3kIw7ZT+sUhU4hKu1r/oUv+OGszR9YyNfdkx11IynL3/Zmz0V06yLyv+w3hTz5cv
         nbMWMzAWaN/K2Cs7QAGS2pP0E2TM3i4+d7QWDo2ggvSzVIZUtdn+BQc6U5bYLAGL7f9z
         hUYVw3qzESoPTFVTiOHKhH81SxwXXi4itbOXN+E8oMTsEcL8MRaUB5sNlF9RzCnuRPcW
         J8daQsgXRg+rXrkmxEn0KNwJxGD1pKNyvykx4+qc9NL+f2Jlw9sXkieWOeYloAZa1G4m
         vSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFn8omqpPyP6yYWvRZAtzgNfdrHcBeFpZiqovJJI8PU=;
        b=Icoipzg+ymN8Loe53LDqOQCEogVjJrF5gAtQDaI5iI8PgCY/xsPol3GIQ/3EVDmtb+
         PDd4B9O6ujoBxWdYO6V6o48FR2gB43q+G9el0disGjyZ3dsU86jLozs/4CMw0+blgfxJ
         4ErIdSJB9dWLhmRN0G2EGHaZYCLjWd92nLyH8xmTOfo8cjDTmQG3y4l3w2owXMX8V1vQ
         8EE46WMAJPoDrxFuSXLOlVmOfJa1a78iV1MF3ZNas4ChL7xuDOO1SN8BzRsMJehmW+51
         wyl3jjKrNAwxp5MULLe5qPvuPzi8GTYcn1XadKD9wGgHcodvnmXIZzP4tEHhJ0L4Y3iB
         qg/w==
X-Gm-Message-State: AOAM531OlKAV7Gw76OVGl0wBuhBP5Pj3N9lbn9Gc6MDjEf9H0GNeDxHV
        dIezvUz1puxBjI677DnVIeXuWCD0OutYctomeLjrRQ==
X-Google-Smtp-Source: ABdhPJwAvkEA+rVtDMXTbHoOcF4U8FdzXy3ETMayuUmcRg2UOX5TteY+yEWE/Or3RngmDI2LXblL2pOtLNV3c0XzhJw=
X-Received: by 2002:a05:6512:104a:: with SMTP id c10mr2358008lfb.184.1588951676023;
 Fri, 08 May 2020 08:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com> <20200508151515.GA25974@geo.homenetwork>
In-Reply-To: <20200508151515.GA25974@geo.homenetwork>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 May 2020 17:27:44 +0200
Message-ID: <CAKfTPtCeA1VcEierR5iyQJApU5JMFQqkMSR+2JGU4o5cG76opQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
To:     Tao Zhou <zohooouoto@zoho.com.cn>
Cc:     Phil Auld <pauld@redhat.com>,
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

On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
>
> Hi Phil,
>
> On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
> > sched/fair: Fix enqueue_task_fair warning some more
> >
> > The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> > did not fully resolve the issues with the rq->tmp_alone_branch !=
> > &rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
> > the first for_each_sched_entity loop exits due to on_rq, having incompletely
> > updated the list.  In this case the second for_each_sched_entity loop can
> > further modify se. The later code to fix up the list management fails to do
> > what is needed because se no longer points to the sched_entity which broke
> > out of the first loop.
> >
>
> > Address this by calling leaf_add_rq_list if there are throttled parents while
> > doing the second for_each_sched_entity loop.
>
> Thanks for your trace imformation and explanation. I
> truely have learned from this and that.
>
> s/leaf_add_rq_list/list_add_leaf_cfs_rq/
>
> >
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >  kernel/sched/fair.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..c6d57c334d51 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5479,6 +5479,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >               /* end evaluation on encountering a throttled cfs_rq */
> >               if (cfs_rq_throttled(cfs_rq))
> >                       goto enqueue_throttle;
> > +
> > +               /*
> > +                * One parent has been throttled and cfs_rq removed from the
> > +                * list. Add it back to not break the leaf list.
> > +                */
> > +               if (throttled_hierarchy(cfs_rq))
> > +                       list_add_leaf_cfs_rq(cfs_rq);
> >       }
>
> I was confused by why the throttled cfs rq can be on list.
> It is possible when enqueue a task and thanks to the 'threads'.
> But I think the above comment does not truely put the right
> intention, right ?
> If throttled parent is onlist, the child cfs_rq is ignored
> to be added to the leaf cfs_rq list me think.
>
> unthrottle_cfs_rq() follows the same logic if i am not wrong.
> Is it necessary to add the above to it ?

When a cfs_rq is throttled, its sched group is dequeued and all child
cfs_rq are removed from  leaf_cfs_rq list. But the sched group of the
child cfs_rq stay enqueued in the throttled cfs_rq so child sched
group->on_rq might be still set.

>
> Thanks,
> Tau
>
> >
> >  enqueue_throttle:
> > --
> > 2.18.0
> >
> > V2 rework the fix based on Vincent's suggestion. Thanks Vincent.
> >
> >
> > Cheers,
> > Phil
> >
> > --
> >
