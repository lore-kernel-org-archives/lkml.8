Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7123C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CE7206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCEZsrWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbgEKUoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:44:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51519 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731484AbgEKUoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589229858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZSsTo12sNfLcLW4C8bXE0PdAIzevXxbTDUHfGa+8M0A=;
        b=bCEZsrWfhAxN4RtHG4Gv1qryGwA2JTCMjlV2MF5u72uzSWKXR9QwPdLbSsGUKJmo025Rs7
        iPg8G77IRzGidEsml3LlyUlwbRx6dNhOn6/5wfMEPW1d0qp0uzYeB1L2cQ81rQ3ESSlwy4
        8gtn4FQRWr78zvh6I8HA0Bw2URd5Zd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474--GD640-qNbuCx3TwYPyBHQ-1; Mon, 11 May 2020 16:44:16 -0400
X-MC-Unique: -GD640-qNbuCx3TwYPyBHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0B66100CD15;
        Mon, 11 May 2020 20:44:15 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-152.phx2.redhat.com [10.3.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78A7360FB9;
        Mon, 11 May 2020 20:44:12 +0000 (UTC)
Date:   Mon, 11 May 2020 16:44:10 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
Message-ID: <20200511204410.GI13245@lorien.usersys.redhat.com>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com>
 <CAKfTPtAztaT_===uTs6feFp4ZwPX=+UJKHwOoTOVSdsERNG3WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAztaT_===uTs6feFp4ZwPX=+UJKHwOoTOVSdsERNG3WQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:25:43PM +0200 Vincent Guittot wrote:
> On Thu, 7 May 2020 at 22:36, Phil Auld <pauld@redhat.com> wrote:
> >
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
> > Address this by calling leaf_add_rq_list if there are throttled parents while
> > doing the second for_each_sched_entity loop.
> >
> 
> Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> 
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> 
> With the Fixes tag and the typo mentioned by Tao
>

Right, that last line of the commit message should read "list_add_leaf_cfs_rq"


> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks Vincent.

Peter/Ingo, do you want me to resend or can you fix when applying?


Thanks,
Phil

> 
> > ---
> >  kernel/sched/fair.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..c6d57c334d51 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5479,6 +5479,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >                 /* end evaluation on encountering a throttled cfs_rq */
> >                 if (cfs_rq_throttled(cfs_rq))
> >                         goto enqueue_throttle;
> > +
> > +               /*
> > +                * One parent has been throttled and cfs_rq removed from the
> > +                * list. Add it back to not break the leaf list.
> > +                */
> > +               if (throttled_hierarchy(cfs_rq))
> > +                       list_add_leaf_cfs_rq(cfs_rq);
> >         }
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
> 

-- 

