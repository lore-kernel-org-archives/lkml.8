Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC370C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C86208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRo21g2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgEKIg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgEKIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:36:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6004EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 01:36:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so8490997ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTACYE7j0scanHP1lxZqHebprajc44vIBRsVz41w1FU=;
        b=IRo21g2UTz2wmtpeTcPJx7UUpRTtwLL1rFWgrmQzT9mraEXHG9ZK/MMBZ1qOnIxwdP
         o5BSUwO73QF94BWtOWI2uMunqOcho4CN4TW5LcsXlW6xhhaVG0Ly3mEcyZYuGjrEBBhT
         SPqTmmaIjGzwd6Km+xVXYH/zjVMKhCSuUtqSKDOKS5wPMgiGWbbNJAbW/qMRjd+mzVod
         qw234RUJl2cafH13spJTPpW/vd2MaZzm06P44efEahI4xa3bctvo9GW83Tb0+epDkv4b
         rFRZtnl08HNO4LghwwFRHSnUoRF6xHF5PqRSEB6THrwt59isxybZXHbtR0HdbxpWSaEK
         mx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTACYE7j0scanHP1lxZqHebprajc44vIBRsVz41w1FU=;
        b=oMKCE83t8+3yDdYB4qdJsmaTfWiqmodKpsk2MpYto4tCUW3fNDBQg3M1kkt/1mfZq/
         MAMgvp7x+6b2tlwCGAwI7cs33x+A8oBtr4sGKJixTR42FIL9zlD5QHcy3X/XpKU4WyAo
         DyplwFmQ7I3AibduOjl+k21V/g+WYwxH1aapxltOqoJEPlwSeSMjn/lr1SpCWJYFBuz+
         PXkdw3+kipBbqzGbwpbehw0I2+HSGHi4wfntauQTnUxt5ZJOUI+QpWG3HvVEv2KsDUR4
         S2Nwp9RlezggcHKOecw0e9Fyeo6b1BD4pezgWm2bwCDak+rXJ1JiQMcGA+P72nXnDkPX
         fkLA==
X-Gm-Message-State: AOAM530uNOGhuG64CceSSsxJgX+5nzt6xjCFODVMcGmX1n3T+yLEpYSJ
        f3n+rKoAU6Mj4W8cWM9siQApsLZ98GB8MzIfYp+HSg==
X-Google-Smtp-Source: ABdhPJztZwJvJ8ran123zF7xFEPIgEE2FXK5DJ8V4rnxI8D4hL96VJZqW9neFSjHxr2lnN20DmLboYSbcjDbc549mfU=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr9040662ljg.21.1589186215684;
 Mon, 11 May 2020 01:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com> <20200508151515.GA25974@geo.homenetwork>
 <CAKfTPtCeA1VcEierR5iyQJApU5JMFQqkMSR+2JGU4o5cG76opQ@mail.gmail.com> <20200508170213.GA27353@geo.homenetwork>
In-Reply-To: <20200508170213.GA27353@geo.homenetwork>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 May 2020 10:36:43 +0200
Message-ID: <CAKfTPtC_YFEPJukbvdo0TKSke1NW9Cw3VsNQFM5u_o4UPKG8=A@mail.gmail.com>
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

Hi Tao,

On Fri, 8 May 2020 at 18:58, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
>
> On Fri, May 08, 2020 at 05:27:44PM +0200, Vincent Guittot wrote:
> > On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
> > >
> > > Hi Phil,
> > >
> > > On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
> > > > sched/fair: Fix enqueue_task_fair warning some more
> > > >
> > > > The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> > > > did not fully resolve the issues with the rq->tmp_alone_branch !=
> > > > &rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
> > > > the first for_each_sched_entity loop exits due to on_rq, having incompletely
> > > > updated the list.  In this case the second for_each_sched_entity loop can
> > > > further modify se. The later code to fix up the list management fails to do
> > > > what is needed because se no longer points to the sched_entity which broke
> > > > out of the first loop.
> > > >
> > >
> > > > Address this by calling leaf_add_rq_list if there are throttled parents while
> > > > doing the second for_each_sched_entity loop.
> > >
> > > Thanks for your trace imformation and explanation. I
> > > truely have learned from this and that.
> > >
> > > s/leaf_add_rq_list/list_add_leaf_cfs_rq/
> > >
> > > >
> > > > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > > ---
> > > >  kernel/sched/fair.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 02f323b85b6d..c6d57c334d51 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -5479,6 +5479,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > >               /* end evaluation on encountering a throttled cfs_rq */
> > > >               if (cfs_rq_throttled(cfs_rq))
> > > >                       goto enqueue_throttle;
> > > > +
> > > > +               /*
> > > > +                * One parent has been throttled and cfs_rq removed from the
> > > > +                * list. Add it back to not break the leaf list.
> > > > +                */
> > > > +               if (throttled_hierarchy(cfs_rq))
> > > > +                       list_add_leaf_cfs_rq(cfs_rq);
> > > >       }
> > >
> > > I was confused by why the throttled cfs rq can be on list.
> > > It is possible when enqueue a task and thanks to the 'threads'.
> > > But I think the above comment does not truely put the right
> > > intention, right ?
> > > If throttled parent is onlist, the child cfs_rq is ignored
> > > to be added to the leaf cfs_rq list me think.
> > >
> > > unthrottle_cfs_rq() follows the same logic if i am not wrong.
> > > Is it necessary to add the above to it ?
> >
> > When a cfs_rq is throttled, its sched group is dequeued and all child
> > cfs_rq are removed from  leaf_cfs_rq list. But the sched group of the
> > child cfs_rq stay enqueued in the throttled cfs_rq so child sched
> > group->on_rq might be still set.
>
> If there is a throttle of throttle, and unthrottle the child throttled
> cfs_rq(ugly):
>                                ...
>                                 |
>                       cfs_rq throttled (parent A)
>                                 |
>                                 |
>                       cfs_rq in hierarchy (B)
>                                 |
>                                 |
>                       cfs_rq throttled (C)
>                                 |
>                                ...
>
> Then unthrottle the child throttled cfs_rq C, now the A is on the
> leaf_cfs_rq list. sched_group entity of C is enqueued to B, and
> sched_group entity of B is on_rq and is ignored by enqueue but in
> the throttled hierarchy and not add to leaf_cfs_rq list.
> The above may be absolutely wrong that I miss something.

several things:

your example above is safe IMO because when C is unthrottle, It's
group se will be enqueued on B which will be added to leaf_cfs_rq
list.
Then the group se of B is already on_rq but A is throttled and the 1st
loop break.  The 2nd loop will ensure that A is added to leaf_cfs_rq
list

Now, if we add one more level between C and A, we have a problem and
we should add something similar in the else

Finally, while checking the unthrottle_cfs_rq, the test if
(!cfs_rq->load.weight) return"  skips all the for_each_entity loop and
can break the leaf_cfs_rq

We need to jump to the last loop in such case

>
> Another thing :
> In enqueue_task_fair():
>
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
>                 if (list_add_leaf_cfs_rq(cfs_rq))
>                         break;
>         }
>
> In unthrottle_cfs_rq():
>
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
>                 list_add_leaf_cfs_rq(cfs_rq);
>         }
>
> The difference between them is that if condition, add if
> condition to unthrottle_cfs_rq() may be an optimization and
> keep the same.

Yes we can do the same kind of optimization

>
> > >
> > > Thanks,
> > > Tau
> > >
> > > >
> > > >  enqueue_throttle:
> > > > --
> > > > 2.18.0
> > > >
> > > > V2 rework the fix based on Vincent's suggestion. Thanks Vincent.
> > > >
> > > >
> > > > Cheers,
> > > > Phil
> > > >
> > > > --
> > > >
