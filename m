Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61101C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C9820774
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha1viH90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgDMOt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:49:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728185AbgDMOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586789364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5eENFL+xFtZoGHWDZ5E8Yp9YG5Rnosv7zY1Jfb/mgA=;
        b=Ha1viH909cYt7UakKVGJDGDmSCJYq6myaoE1gGJHHEL3l/3/XtnAYCKkVqpdrMRtq2/ek0
        7d81GrOTGMvsD0+syrMgQ7AqsU219jgGcVjWXVPWJDW52EPh6/1XRE8aCyethK0otb0dsQ
        sfAm9lmG7hZfy7r0LIc211QstZJt9Ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-FbJpKWs6NdC9QrrkNG3y5w-1; Mon, 13 Apr 2020 10:49:22 -0400
X-MC-Unique: FbJpKWs6NdC9QrrkNG3y5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2CB2107ACC9;
        Mon, 13 Apr 2020 14:49:20 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-48.phx2.redhat.com [10.3.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2F9D5D9C9;
        Mon, 13 Apr 2020 14:49:16 +0000 (UTC)
Date:   Mon, 13 Apr 2020 10:49:15 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched: remove distribute_running from CFS bandwidth
Message-ID: <20200413144915.GB2517@lorien.usersys.redhat.com>
References: <20200410225208.109717-1-joshdon@google.com>
 <20200410225208.109717-3-joshdon@google.com>
 <CABk29NtBxtJeAowLTGC4xQRD5MNtoiKLTLV7O3zLWp1CtW4nvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NtBxtJeAowLTGC4xQRD5MNtoiKLTLV7O3zLWp1CtW4nvg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Sat, Apr 11, 2020 at 07:01:45PM -0700 Josh Don wrote:
> On Fri, Apr 10, 2020 at 3:52 PM Josh Don <joshdon@google.com> wrote:
> >
> > This is mostly a revert of baa9be4ff.
> >
> > The primary use of distribute_running was to determine whether to add
> > throttled entities to the head or the tail of the throttled list. Now
> > that we always add to the tail, we can remove this field.
> >
> > The other use of distribute_running is in the slack_timer, so that we
> > don't start a distribution while one is already running. However, even
> > in the event that this race occurs, it is fine to have two distributions
> > running (especially now that distribute grabs the cfs_b->lock to
> > determine remaining quota before assigning).
> >
> > Signed-off-by: Josh Don <joshdon@google.com>

Nice. This was more or less a hack. It's good to be able to remove it.
I re-ran my test cases that originally caused the need for the
distribute_running.  As expected, since there is no adding to the head
of the queue, the behavior is the same as before this series.

Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil

> > ---
> >  kernel/sched/fair.c  | 13 +------------
> >  kernel/sched/sched.h |  1 -
> >  2 files changed, 1 insertion(+), 13 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 3fb986c52825..24b5e12efb40 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4930,14 +4930,12 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
> >         /*
> >          * This check is repeated as we release cfs_b->lock while we unthrottle.
> >          */
> > -       while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
> > -               cfs_b->distribute_running = 1;
> > +       while (throttled && cfs_b->runtime > 0) {
> >                 raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> >                 /* we can't nest cfs_b->lock while distributing bandwidth */
> >                 distribute_cfs_runtime(cfs_b);
> >                 raw_spin_lock_irqsave(&cfs_b->lock, flags);
> >
> > -               cfs_b->distribute_running = 0;
> >                 throttled = !list_empty(&cfs_b->throttled_cfs_rq);
> >         }
> >
> > @@ -5051,10 +5049,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >         /* confirm we're still not at a refresh boundary */
> >         raw_spin_lock_irqsave(&cfs_b->lock, flags);
> >         cfs_b->slack_started = false;
> > -       if (cfs_b->distribute_running) {
> > -               raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> > -               return;
> > -       }
> >
> >         if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
> >                 raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> > @@ -5064,9 +5058,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >         if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
> >                 runtime = cfs_b->runtime;
> >
> > -       if (runtime)
> > -               cfs_b->distribute_running = 1;
> > -
> >         raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> >
> >         if (!runtime)
> > @@ -5075,7 +5066,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >         distribute_cfs_runtime(cfs_b);
> >
> >         raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > -       cfs_b->distribute_running = 0;
> >         raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> >  }
> >
> > @@ -5217,7 +5207,6 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >         cfs_b->period_timer.function = sched_cfs_period_timer;
> >         hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >         cfs_b->slack_timer.function = sched_cfs_slack_timer;
> > -       cfs_b->distribute_running = 0;
> >         cfs_b->slack_started = false;
> >  }
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index db3a57675ccf..7198683b2869 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -349,7 +349,6 @@ struct cfs_bandwidth {
> >
> >         u8                      idle;
> >         u8                      period_active;
> > -       u8                      distribute_running;
> >         u8                      slack_started;
> >         struct hrtimer          period_timer;
> >         struct hrtimer          slack_timer;
> > --
> > 2.26.0.110.g2183baf09c-goog
> >
> 
> +pauld@redhat.com
> 

-- 

