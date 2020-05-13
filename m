Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A52EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55278205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjFp963F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbgEMQDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbgEMQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:03:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC4C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:03:01 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so172481ljl.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L46DgZnTClQ40MRgR3Fy55eLVLR/68+f+CtyFcl8jlE=;
        b=OjFp963F77UEWS9UxESO45ymDIpXdHOuMouKZVcq6CK8aTZKh+yiRUpQLaDar4PALG
         K8/EQzwNQqcjCLq2sfM9TTqIEXAcOjwW9rO/ZEghisyWhA1KFzoupr9l9uBZKYJC6flr
         vrIRECRxtJBjX8w5yGcfHiPjjHbaPNgxZmJlxG0auBQBXCo36GThJv62XOWQb9pstcHb
         qaY36eXR6sPuRnjW4F1lq/7pxjxBrLEv079z44up2bYisZEPKpC/PP0q4ew2AjVSaBd2
         r8pS88PXh7eLmzZeKSa3LUUgN0IHQ8o4oVkRuhKTqufI2vOObWE0ZYAwOg0GT5EcT7rn
         KwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L46DgZnTClQ40MRgR3Fy55eLVLR/68+f+CtyFcl8jlE=;
        b=huV/wKivI31k0C2KFX0hE5nkNlj13OLWRPQ0ldrBaJFIn4t9O3QpHXI5yyKL2OTiZl
         oxue/G91w0ruRzspTTE6HS5hMwZFRWxojOmRGveggz16uALRuo3dlTCKO24OlO8PtQ47
         /hChGIFG8Y2vhe1eqCEqxGl4ByJDgGZQfp/M5YkO44Oa2TTF8ihhzkgnb0g466rocb2M
         L1SPe1+kbkj2sYcgpHM156Z6KiW7ID2lT0DHYUnPexweTp22T7thqu9kI+f+MdHODfCk
         X88NBUY2A/7ifAkyJo3vkbXSQeysktPGBxMMNx5A2E2Qj5Wm83HGCcg0kNCgesMM4C7S
         HJoQ==
X-Gm-Message-State: AOAM530GdPr52kdb4Zhab2sTgem9Fls7a60wVXgPV0rznVrmr3sNQNma
        VunGrAn9Ml+wFkucclA0JzHigjUZnDH4v/9OMHLtgg==
X-Google-Smtp-Source: ABdhPJxdn8CNQWBG9A/P2NC7c+6LyUcgNaeSHoFXa0PZQPR7P03UNFeiqz+02rVfn3ivXKj7ytdKwdtC+rb+uVys5Go=
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr18383425ljk.4.1589385779449;
 Wed, 13 May 2020 09:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200513135502.4672-1-vincent.guittot@linaro.org> <BL0PR14MB3779D98D96FA0D30B968B4519ABF0@BL0PR14MB3779.namprd14.prod.outlook.com>
In-Reply-To: <BL0PR14MB3779D98D96FA0D30B968B4519ABF0@BL0PR14MB3779.namprd14.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 May 2020 18:02:47 +0200
Message-ID: <CAKfTPtDbrt1phLaiVd71_gk=RYKJmyYwbNi4_UW9f9WFEzGWCw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: enqueue_task_fair optimization
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 17:51, Tao Zhou <ouwen210@hotmail.com> wrote:
>
> Hi Vincent,
>
> Sorry for the duplicate.
>
> On Wed, May 13, 2020 at 03:55:02PM +0200, Vincent Guittot wrote:
> > enqueue_task_fair jumps to enqueue_throttle label when cfs_rq_of(se) is
> > throttled which means that se can't be NULL in such case and we can move
> > the label after the if (!se) statement. Futhermore, the latter can be
> > removed because se is always NULL when reaching this point.
> >
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > v3 changes:
> >   - updated commit message
> >   - removed an extra }
> >
> >  kernel/sched/fair.c | 39 +++++++++++++++++++--------------------
> >  1 file changed, 19 insertions(+), 20 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9a58874ef104..4e586863827b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5512,28 +5512,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >                         list_add_leaf_cfs_rq(cfs_rq);
> >       }
> >
> > -enqueue_throttle:
> > -     if (!se) {
> > -             add_nr_running(rq, 1);
> > -             /*
> > -              * Since new tasks are assigned an initial util_avg equal to
> > -              * half of the spare capacity of their CPU, tiny tasks have the
> > -              * ability to cross the overutilized threshold, which will
> > -              * result in the load balancer ruining all the task placement
> > -              * done by EAS. As a way to mitigate that effect, do not account
> > -              * for the first enqueue operation of new tasks during the
> > -              * overutilized flag detection.
> > -              *
> > -              * A better way of solving this problem would be to wait for
> > -              * the PELT signals of tasks to converge before taking them
> > -              * into account, but that is not straightforward to implement,
> > -              * and the following generally works well enough in practice.
> > -              */
> > -             if (flags & ENQUEUE_WAKEUP)
> > -                     update_overutilized_status(rq);
> > +     /* At this point se is NULL and we are at root level*/
>
> The same as another patch, lack one blank at the end of above comment.
>
> When apply v3 of 'sched/fair: Fix enqueue_task_fair warning some more'
> We need to edit to align to, I don't know why. When I tried to pull some
> thing to a function not done yet.

I forgot to mention that this patch has been done on top of Phil's one
20200512135222.GC2201@lorien.usersys.redhat.com and apply on top of it

>
> Thanks,
> Tao
>
> > +     add_nr_running(rq, 1);
> >
> > -     }
> > +     /*
> > +      * Since new tasks are assigned an initial util_avg equal to
> > +      * half of the spare capacity of their CPU, tiny tasks have the
> > +      * ability to cross the overutilized threshold, which will
> > +      * result in the load balancer ruining all the task placement
> > +      * done by EAS. As a way to mitigate that effect, do not account
> > +      * for the first enqueue operation of new tasks during the
> > +      * overutilized flag detection.
> > +      *
> > +      * A better way of solving this problem would be to wait for
> > +      * the PELT signals of tasks to converge before taking them
> > +      * into account, but that is not straightforward to implement,
> > +      * and the following generally works well enough in practice.
> > +      */
> > +     if (flags & ENQUEUE_WAKEUP)
> > +             update_overutilized_status(rq);
> >
> > +enqueue_throttle:
> >       if (cfs_bandwidth_used()) {
> >               /*
> >                * When bandwidth control is enabled; the cfs_rq_throttled()
> > --
> > 2.17.1
