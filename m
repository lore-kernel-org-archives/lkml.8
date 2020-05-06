Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9934820747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3UU9rpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgEFSFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:05:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30873 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728682AbgEFSFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588788332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHh+nyiaovUtsewof3hFxcOQHEqs/oTwxaJkt5/V9bw=;
        b=A3UU9rpGDv0xvaDPm4em/EOTeCUd7DpZeYujFP15w9pxry0pKxNawVE7q+OFFLv3Euis/Z
        2hV0YrFri3lg1XjpDk0oD7LBIsmj0CmqVoUDbsA8f27ouPTbiT5NMO+umCBjdvpP18j88+
        7bvTzJSox1kIZ0/cYJvxP+w8jZrhasE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-egSDVML2PzSQ16uj4ntZBA-1; Wed, 06 May 2020 14:05:28 -0400
X-MC-Unique: egSDVML2PzSQ16uj4ntZBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD6951800D4A;
        Wed,  6 May 2020 18:05:26 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-141.phx2.redhat.com [10.3.114.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FFA9707A2;
        Wed,  6 May 2020 18:05:23 +0000 (UTC)
Date:   Wed, 6 May 2020 14:05:21 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: Fix enqueue_task_fair warning some more
Message-ID: <20200506180521.GC9773@lorien.usersys.redhat.com>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <CAKfTPtADSaFmxE_-qtfgYEQw0A90oma2tEwH=XrE7r=qfRVsaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtADSaFmxE_-qtfgYEQw0A90oma2tEwH=XrE7r=qfRVsaA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Thanks for taking a look. More below...

On Wed, May 06, 2020 at 06:36:45PM +0200 Vincent Guittot wrote:
> Hi Phil,
> 
> - reply to all this time
> 
> On Wed, 6 May 2020 at 16:18, Phil Auld <pauld@redhat.com> wrote:
> >
> > sched/fair: Fix enqueue_task_fair warning some more
> >
> > The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> > did not fully resolve the issues with the (rq->tmp_alone_branch !=
> > &rq->leaf_cfs_rq_list) warning in enqueue_task_fair. There is a case where
> > the first for_each_sched_entity loop exits due to on_rq, having incompletely
> > updated the list.  In this case the second for_each_sched_entity loop can
> > further modify se. The later code to fix up the list management fails to do
> 
> But for the 2nd  for_each_sched_entity, the cfs_rq should already be
> in the list, isn't it ?

No. In this case we hit the parent not on list case in list_add_leaf_cfs_rq
which sets rq-tmp_alone_branch to cfs_rq->leaf_cfs_rq_list which is not
the same. It returns false expecting the parent to be added later.

But then the parent doens't get there because it's on_rq. 

> 
> The third for_each_entity loop is there for the throttled case but is
> useless for other case
>

There actually is a throttling involved usually. The second loop breaks out
early because one of the parents is throttled. But not before it advances
se at least once. 

Then the 3rd loop doesn't fix the tmp_alone_branch because it doesn't start
with the right se.

> Could you provide us some details about the use case that creates such
> a situation ?
>

I admit I had to add trace_printks to get here. Here's what it showed (sorry
for the long lines...)

1)  sh-6271  [044]  1271.322317: bprint: enqueue_task_fair: se 0xffffa085e7e30080 on_rq 0 cfs_rq = 0xffffa085e93da200
2)  sh-6271  [044]  1271.322320: bprint: enqueue_entity: Add_leaf_rq: cpu 17: nr_r 2; cfs 0xffffa085e93da200 onlist 0 tmp_a_b = 0xffffa085ef92c868 &rq->l_c_r_l = 0xffffa085ef92c868
3)  sh-6271  [044]  1271.322322: bprint: enqueue_entity: Add_leaf_rq: cpu 17: nr_r 2: parent not onlist  Set t_a_branch to 0xffffa085e93da340 rq->l_c_r_l = 0xffffa085ef92c868
4)  sh-6271  [044]  1271.322323: bprint: enqueue_task_fair: se 0xffffa085e93d8800 on_rq 1 cfs_rq = 0xffffa085dbfaea00
5)  sh-6271  [044]  1271.322324: bprint: enqueue_task_fair: Done enqueues, se=0xffffa085e93d8800, pid=3642
6)  sh-6271  [044]  1271.322326: bprint: enqueue_task_fair: update: cfs 0xffffa085e48ce000 throttled, se = 0xffffa085dbfafc00
7)  sh-6271  [044]  1271.322326: bprint: enqueue_task_fair: current se = 0xffffa085dbfafc00, orig_se = 0xffffa085e7e30080
8)  sh-6271  [044]  1271.322327: bprint: enqueue_task_fair: Add_leaf_rq: cpu 17: nr_r 2; cfs 0xffffa085e48ce000 onlist 1 tmp_a_b = 0xffffa085e93da340 &rq->l_c_r_l = 0xffffa085ef92c868
9)  sh-6271  [044]  1271.322328: bprint: enqueue_task_fair: Add_leaf_rq: cpu 17: nr_r 0; cfs 0xffffa085ef92bf80 onlist 1 tmp_a_b = 0xffffa085e93da340 &rq->l_c_r_l = 0xffffa085ef92c868
10) sh-6271  [044]  1271.672599: bprint: enqueue_task_fair: cpu 17: rq->tmp_alone_branch = 0xffffa085e93da340 != &rq->leaf_cfs_rq_list = 0xffffa085ef92c868


lines 1 and 4 are from the first loop in enqueue_task_fair. Line 2 and 3 are from the
first call to list_add_leaf_rq with line 2 being at the start and line 3 showing which
of the 3 cases we hit.

Line 5 is right after the first loop.

Line 6 is the second trip through the 2nd loop and is in the if(throttled) condition.
Line 7 is right below the enqueue_throttle label.

Lines 8 and 9 are from the fixup loop and since onlist is set for both of these it doesn't
do anything. But we've left rq->tmp_alone_branch pointing to the cfs_rq->leaf_cfs_rq_list
from the one call to list_add_leaf_rq that did something and so the cleanup doesn't work.

Based on the comment at the clean up, it looked like it expected the se to be what it was
when the first loop broke not whatever it was left at after the second loop.  Could have
been NULL there too I guess but I didn't hit that case.

This is 100% reproducible. And completely gone with the fix. I have a trace showing that.

Does that make more sense?



Cheers,
Phil


> > what is needed because se does not point to the sched_entity which broke out
> > of the first loop.
> >
> > Address this issue by saving the se pointer when the first loop exits and
> > resetting it before doing the fix up, if needed.
> >
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >  kernel/sched/fair.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..719c996317e3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5432,6 +5432,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >         struct cfs_rq *cfs_rq;
> >         struct sched_entity *se = &p->se;
> > +       struct sched_entity *saved_se = NULL;
> >         int idle_h_nr_running = task_has_idle_policy(p);
> >
> >         /*
> > @@ -5466,6 +5467,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >                 flags = ENQUEUE_WAKEUP;
> >         }
> >
> > +       saved_se = se;
> >         for_each_sched_entity(se) {
> >                 cfs_rq = cfs_rq_of(se);
> >
> > @@ -5510,6 +5512,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >                  * leaf list maintenance, resulting in triggering the assertion
> >                  * below.
> >                  */
> > +               if (saved_se)
> > +                       se = saved_se;
> >                 for_each_sched_entity(se) {
> >                         cfs_rq = cfs_rq_of(se);
> >
> > --
> > 2.18.0
> >
> >
> > Cheers,
> > Phil
> >
> 

-- 

