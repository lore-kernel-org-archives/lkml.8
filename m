Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF74DC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE282073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsDEm32O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgCFH7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:59:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39846 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgCFH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:59:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id f10so1193220ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+9x/+Rv6B091EmUBSuDn0M0YpoJ1ACikH1DqvGhK1E=;
        b=TsDEm32OHm/8enBQ0Jqdq+wVh+j5y0RaPVMgoua+trcT90whpgsPpdr2cdsc6gwcWm
         /aMObU8+kC6v5qoeINrKw7xVJI8HwRNqF3hjG0ZrxQ4vQmgamPFttcK1R70u54wshSdn
         8Fmg4f1fW723TqyruZZBmTWYi7FFONfhVGPdWCEvh+jyqbUYVR5MFUk8TZZaUqctD/Uk
         1y7BBRLnVSFO7H3YCoBt168vB0ShCI5iLWEl5KkuxyyaK9pkUkCeYm9HDpvZ6LSTHS/h
         Bvz6SL1huImQTbdpnFPcqal+crGL/B/7/0G4pCESarHHJAWaAq+4TaPVTA+xjeLnC3H8
         Qpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+9x/+Rv6B091EmUBSuDn0M0YpoJ1ACikH1DqvGhK1E=;
        b=ja+0NS2TjiYBcc+MgahuTsVB8n/vA+xitxQHW/bnf41tUw2QnpI94aQDFUff+dUWv6
         a/73O/w96nSxCsbQj/rpMuD9hoNPMc9vLi3gV3mbLSd5vvGVHzamJ5IBO01e7cjl/Mb0
         6IXJ3i/dQf+rP3PuKMqofhHeTLjyg/fFo/kTkes5f+Mm3+5nDoZ8GUPsXLZuU0bNEqgW
         PAuYMXGkCJV7T5swM4zWlZhSJEdViTPd26cZC307UEKEZ5SGz+INkIMw/50p07uIVYbp
         K9ueS/fhsF6IUZ8RIx0oCcKTIoTr/uUgSyEFSpiWmX8qV6W9vGMfxym6FS7CUeUHwinl
         P4dA==
X-Gm-Message-State: ANhLgQ0Q1px2mqJY2he1Fz/yK0+ye1kky9DbRl1sN3HZLgrDUnWlf3R4
        VNQ/0x/V/nySl9DqY43Eec6nM5ebHUuQoWQO6jqeDQ==
X-Google-Smtp-Source: ADFU+vsWPIAYMdvcMqPQdSXP0ZBb2EMAvRdvp+Vkx8Yvjim380I6R3J03ZDloNqOhYEaUE7Hu9gS/x6q5ai4+6WckAw=
X-Received: by 2002:a2e:8546:: with SMTP id u6mr1216504ljj.21.1583481561282;
 Thu, 05 Mar 2020 23:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20200305074829.22792-1-vincent.guittot@linaro.org> <xm26k13y4pek.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm26k13y4pek.fsf@bsegall-linux.svl.corp.google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Mar 2020 08:59:06 +0100
Message-ID: <CAKfTPtCfRr+BB1v8VcKHSkoaVPhMYg-N8m6a158_KVxaLhKj_A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair : fix reordering of enqueue_task_fair
To:     Ben Segall <bsegall@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>, Tao Zhou <zhout@vivaldi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 19:39, <bsegall@google.com> wrote:
>
> Vincent Guittot <vincent.guittot@linaro.org> writes:
>
> > Even when a cgroup is throttled, the group se of a child cgroup can still
> > be enqueued and its gse->on_rq stays true. When a task is enqueued on such
> > child, we still have to update the load_avg and increase
> > h_nr_running of the throttled cfs. Nevertheless, the 1st
> > for_each_sched_entity loop is skipped because of gse->on_rq == true and the
> > 2nd loop because the cfs is throttled whereas we have to update both
> > load_avg with the old h_nr_running and increase h_nr_running in such case.
> > Note that the update of load_avg will effectively happen only once in order
> > to sync up to the throttled time. Next call for updating load_avg will stop
> > early because the clock stays unchanged.
> >
> > Fixes: 6d4d22468dae ("sched/fair: Reorder enqueue/dequeue_task_fair path")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fcc968669aea..5b232d261842 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5431,16 +5431,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >       for_each_sched_entity(se) {
> >               cfs_rq = cfs_rq_of(se);
> >
> > -             /* end evaluation on encountering a throttled cfs_rq */
> > -             if (cfs_rq_throttled(cfs_rq))
> > -                     goto enqueue_throttle;
> > -
> >               update_load_avg(cfs_rq, se, UPDATE_TG);
> >               se_update_runnable(se);
> >               update_cfs_group(se);
> >
> >               cfs_rq->h_nr_running++;
> >               cfs_rq->idle_h_nr_running += idle_h_nr_running;
> > +
> > +             /* end evaluation on encountering a throttled cfs_rq */
> > +             if (cfs_rq_throttled(cfs_rq))
> > +                     goto enqueue_throttle;
> >       }
> >
> >  enqueue_throttle:
>
>
> I think there's an equivalent issue on dequeue as well, though that's
> much rarer to trigger (but still possible). I think the same fix works
> there too?

I thought it was not needed because we don't have the "if (se->on_rq)
break" in dequeue but :
  /* Avoid re-evaluating load for this entity: */
  se = parent_entity(se);
It creates similar behavior for the parent

I'm going to add it.
Thanks
