Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF6CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5383C20643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUhpZbiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbgEMNZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:25:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:25:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g1so11855743ljk.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctNRDk9XGc9CHMoQDqvFHi5vxID2gsh5buG4nKb35qU=;
        b=bUhpZbiZX2ExbTaWxKBu12anjLM5QsTRXZlxtQ3J8phy61HMAdwQtD/ciJ+RZjbB4l
         TPiNYZ65LO4eOpef3IRXMgDqW9ncENwhQD1JgamCKjDODuXK56Uu4R1w8hyMfiCDsAo2
         VPg4XaBBY0T7VQYirgFnBafM3HyKbdlg6geDLIBI5fLzWoyp7j+lNuetuCdW/TwIpFac
         0y92eoZJ7VyFwMDiMpSCqsh6xgcCE21azzNivuZED4bgxqPL/9aJTikReB2bz2qrJYYl
         qllIyroLbq3nA7NUh5FsKfkowUcdK8FUA7DTLHdzanutUgrwV3jEpKZG/xFDwi4/+hv2
         6OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctNRDk9XGc9CHMoQDqvFHi5vxID2gsh5buG4nKb35qU=;
        b=dGKkjH6lu3hwTN7thG77qhPvau0fFGqI0HBKmi6iGoVUMwZDTI+eaFA8V5mcyfPC7L
         Ajk6aeIoyGyf8lCT5RByjTNHeSbfjBtQG9fzaQnWupCFHP9w6gP5RBFXMQ6NiUDQcjAc
         QdvDC2RdayNlw2LxoRmekyokZxGlBHapRxw9ztLYRDrcU2kL5ApY+z7KH6cKEWLfb7UE
         nYDmvaLzyOLG7rpXjfSaWXcYvjij+1lsBenD1AFL6apP3mgGc4lU9Im8RwQ1Tb2wWOla
         ThuxGrPTJS9yGVkGbNgvJ0c+W8BNqfMk8kS02Mvhn6nbLOzzU8Qu1UbPApcvtxGEfCao
         eqPQ==
X-Gm-Message-State: AOAM532+72XtAG5xuqA9dtkyIWPA/B6rg2pG/eWvXuYVlBZK7Th86yJE
        XO58pcXjhFzSoqLBpgVYpmrx4feAb5qnjzxCZbJJaQ==
X-Google-Smtp-Source: ABdhPJyqozVvtlkhNQ2kjPBoNrEpitOUatm0N2iEFAYkKpZxPDAQF/b9Bz5PZ5Dn8DuGzBpGrEQBjOxYYNoQxFqzAmk=
X-Received: by 2002:a2e:3209:: with SMTP id y9mr16226819ljy.154.1589376341852;
 Wed, 13 May 2020 06:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200513123335.28122-1-vincent.guittot@linaro.org>
 <20200513124540.GB12425@lorien.usersys.redhat.com> <CAKfTPtBFP5eAV-u02x42U2cQnWA56RP+wbj78rWpzj560OS+-g@mail.gmail.com>
 <20200513131337.GF12425@lorien.usersys.redhat.com> <CAKfTPtDYmi9wz3r1G8baG2cM3wh6004CDT11HaAu8L7-wWv=Gw@mail.gmail.com>
 <20200513131808.GG12425@lorien.usersys.redhat.com>
In-Reply-To: <20200513131808.GG12425@lorien.usersys.redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 May 2020 15:25:29 +0200
Message-ID: <CAKfTPtBpYWDz=ZeKKa1BGOVZ+PqM=kbbgSBQpn7msxMV_5v5uA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: enqueue_task_fair optimization
To:     Phil Auld <pauld@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tao Zhou <ouwen210@hotmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 15:18, Phil Auld <pauld@redhat.com> wrote:
>
> On Wed, May 13, 2020 at 03:15:53PM +0200 Vincent Guittot wrote:
> > On Wed, 13 May 2020 at 15:13, Phil Auld <pauld@redhat.com> wrote:
> > >
> > > On Wed, May 13, 2020 at 03:10:28PM +0200 Vincent Guittot wrote:
> > > > On Wed, 13 May 2020 at 14:45, Phil Auld <pauld@redhat.com> wrote:
> > > > >
> > > > > Hi Vincent,
> > > > >
> > > > > On Wed, May 13, 2020 at 02:33:35PM +0200 Vincent Guittot wrote:
> > > > > > enqueue_task_fair jumps to enqueue_throttle label when cfs_rq_of(se) is
> > > > > > throttled which means that se can't be NULL and we can skip the test.
> > > > > >
> > > > >
> > > > > s/be NULL/be non-NULL/
> > > > >
> > > > > I think.
> > > >
> > > > This sentence refers to the move of enqueue_throttle and the fact that
> > > > se can't be null when goto enqueue_throttle and we can jump directly
> > > > after the if statement, which is now removed in v2 because se is
> > > > always NULL if we don't use goto enqueue_throttle.
> > > >
> > > > I haven't change the commit message for the remove of if statement
> > > >
> > >
> > > Fair enough, it just seems backwards from the intent of the patch now.
> > >
> > > There is also an extra }  after the update_overutilized_status.
> >
> > don't know what I did but it's crap.  sorry about that
> >
>
> No worries. I didn't see it when I read it either. The compiler told me :)

Yeah, but i thought that i compiled it which is obviously not true

>
>
> > Let me prepare a v3
> >
> > >
> > >
> > > Cheers,
> > > Phil
> > >
> > >
> > >
> > > > >
> > > > > It's more like if it doesn't jump to the label then se must be NULL for
> > > > > the loop to terminate.  The final loop is a NOP if se is NULL. The check
> > > > > wasn't protecting that.
> > > > >
> > > > > Otherwise still
> > > > >
> > > > > > Reviewed-by: Phil Auld <pauld@redhat.com>
> > > > >
> > > > > Cheers,
> > > > > Phil
> > > > >
> > > > >
> > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > v2 changes:
> > > > > > - Remove useless if statement
> > > > > >
> > > > > >  kernel/sched/fair.c | 39 ++++++++++++++++++++-------------------
> > > > > >  1 file changed, 20 insertions(+), 19 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > > index a0c690d57430..b51b12d63c39 100644
> > > > > > --- a/kernel/sched/fair.c
> > > > > > +++ b/kernel/sched/fair.c
> > > > > > @@ -5513,28 +5513,29 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > > > >                         list_add_leaf_cfs_rq(cfs_rq);
> > > > > >       }
> > > > > >
> > > > > > -enqueue_throttle:
> > > > > > -     if (!se) {
> > > > > > -             add_nr_running(rq, 1);
> > > > > > -             /*
> > > > > > -              * Since new tasks are assigned an initial util_avg equal to
> > > > > > -              * half of the spare capacity of their CPU, tiny tasks have the
> > > > > > -              * ability to cross the overutilized threshold, which will
> > > > > > -              * result in the load balancer ruining all the task placement
> > > > > > -              * done by EAS. As a way to mitigate that effect, do not account
> > > > > > -              * for the first enqueue operation of new tasks during the
> > > > > > -              * overutilized flag detection.
> > > > > > -              *
> > > > > > -              * A better way of solving this problem would be to wait for
> > > > > > -              * the PELT signals of tasks to converge before taking them
> > > > > > -              * into account, but that is not straightforward to implement,
> > > > > > -              * and the following generally works well enough in practice.
> > > > > > -              */
> > > > > > -             if (flags & ENQUEUE_WAKEUP)
> > > > > > -                     update_overutilized_status(rq);
> > > > > > +     /* At this point se is NULL and we are at root level*/
> > > > > > +     add_nr_running(rq, 1);
> > > > > > +
> > > > > > +     /*
> > > > > > +      * Since new tasks are assigned an initial util_avg equal to
> > > > > > +      * half of the spare capacity of their CPU, tiny tasks have the
> > > > > > +      * ability to cross the overutilized threshold, which will
> > > > > > +      * result in the load balancer ruining all the task placement
> > > > > > +      * done by EAS. As a way to mitigate that effect, do not account
> > > > > > +      * for the first enqueue operation of new tasks during the
> > > > > > +      * overutilized flag detection.
> > > > > > +      *
> > > > > > +      * A better way of solving this problem would be to wait for
> > > > > > +      * the PELT signals of tasks to converge before taking them
> > > > > > +      * into account, but that is not straightforward to implement,
> > > > > > +      * and the following generally works well enough in practice.
> > > > > > +      */
> > > > > > +     if (flags & ENQUEUE_WAKEUP)
> > > > > > +             update_overutilized_status(rq);
> > > > > >
> > > > > >       }
> > > > > >
> > > > > > +enqueue_throttle:
> > > > > >       if (cfs_bandwidth_used()) {
> > > > > >               /*
> > > > > >                * When bandwidth control is enabled; the cfs_rq_throttled()
> > > > > > --
> > > > > > 2.17.1
> > > > > >
> > > > >
> > > > > --
> > > > >
> > > >
> > >
> > > --
> > >
> >
>
> --
>
