Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDB0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B092078B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoYSDEdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbgFIA2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:28:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28342 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729029AbgFIA2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591662497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8YdZT4xGi2PaOg+u614DetnWTer32tF+hyfp7Up5Wc=;
        b=KoYSDEdmPkY5ExxNMQmKMqjDbWdBGw55MNQ0t6DCreaM0oychEQeghiXWkOCRrUU/h5j5N
        HNxZDpF6OuyJm8ASXaRN6kiEZ3qDQ8pYE+E8iNQJn04Wl0YjKy7qNPqqbW4nVpbXxVeIaV
        oH+TlAQtAZt0/idCglvYWwUaMNU+/Ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-c1WduLTvP9GIIPkl3hYOZA-1; Mon, 08 Jun 2020 20:28:14 -0400
X-MC-Unique: c1WduLTvP9GIIPkl3hYOZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FD558018A7;
        Tue,  9 Jun 2020 00:28:13 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-117.phx2.redhat.com [10.3.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE76B5C1C3;
        Tue,  9 Jun 2020 00:28:12 +0000 (UTC)
Date:   Mon, 8 Jun 2020 20:28:11 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] sched/fair: Remove distribute_running from CFS
 bandwidth
Message-ID: <20200609002811.GB24379@lorien.usersys.redhat.com>
References: <20200410225208.109717-3-joshdon@google.com>
 <158835733205.8414.9136130857443620621.tip-bot2@tip-bot2>
 <BL0PR14MB3779C02BB87DC4426C4761639A840@BL0PR14MB3779.namprd14.prod.outlook.com>
 <20200608145304.GA24379@lorien.usersys.redhat.com>
 <BL0PR14MB3779AD967619031948957C549A850@BL0PR14MB3779.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR14MB3779AD967619031948957C549A850@BL0PR14MB3779.namprd14.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jun 09, 2020 at 07:05:38AM +0800 Tao Zhou wrote:
> Hi Phil,
> 
> On Mon, Jun 08, 2020 at 10:53:04AM -0400, Phil Auld wrote:
> > On Sun, Jun 07, 2020 at 09:25:58AM +0800 Tao Zhou wrote:
> > > Hi,
> > > 
> > > On Fri, May 01, 2020 at 06:22:12PM -0000, tip-bot2 for Josh Don wrote:
> > > > The following commit has been merged into the sched/core branch of tip:
> > > > 
> > > > Commit-ID:     ab93a4bc955b3980c699430bc0b633f0d8b607be
> > > > Gitweb:        https://git.kernel.org/tip/ab93a4bc955b3980c699430bc0b633f0d8b607be
> > > > Author:        Josh Don <joshdon@google.com>
> > > > AuthorDate:    Fri, 10 Apr 2020 15:52:08 -07:00
> > > > Committer:     Peter Zijlstra <peterz@infradead.org>
> > > > CommitterDate: Thu, 30 Apr 2020 20:14:38 +02:00
> > > > 
> > > > sched/fair: Remove distribute_running from CFS bandwidth
> > > > 
> > > > This is mostly a revert of commit:
> > > > 
> > > >   baa9be4ffb55 ("sched/fair: Fix throttle_list starvation with low CFS quota")
> > > > 
> > > > The primary use of distribute_running was to determine whether to add
> > > > throttled entities to the head or the tail of the throttled list. Now
> > > > that we always add to the tail, we can remove this field.
> > > > 
> > > > The other use of distribute_running is in the slack_timer, so that we
> > > > don't start a distribution while one is already running. However, even
> > > > in the event that this race occurs, it is fine to have two distributions
> > > > running (especially now that distribute grabs the cfs_b->lock to
> > > > determine remaining quota before assigning).
> > > > 
> > > > Signed-off-by: Josh Don <joshdon@google.com>
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Reviewed-by: Phil Auld <pauld@redhat.com>
> > > > Tested-by: Phil Auld <pauld@redhat.com>
> > > > Link: https://lkml.kernel.org/r/20200410225208.109717-3-joshdon@google.com
> > > > ---
> > > >  kernel/sched/fair.c  | 13 +------------
> > > >  kernel/sched/sched.h |  1 -
> > > >  2 files changed, 1 insertion(+), 13 deletions(-)
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 0c13a41..3d6ce75 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -4931,14 +4931,12 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
> > > >  	/*
> > > >  	 * This check is repeated as we release cfs_b->lock while we unthrottle.
> > > >  	 */
> > > > -	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
> > > > -		cfs_b->distribute_running = 1;
> > > > +	while (throttled && cfs_b->runtime > 0) {
> > > >  		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> > > >  		/* we can't nest cfs_b->lock while distributing bandwidth */
> > > >  		distribute_cfs_runtime(cfs_b);
> > > >  		raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > > >  
> > > > -		cfs_b->distribute_running = 0;
> > > >  		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
> > > >  	}
> > > >  
> > > > @@ -5052,10 +5050,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> > > >  	/* confirm we're still not at a refresh boundary */
> > > >  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > > >  	cfs_b->slack_started = false;
> > > > -	if (cfs_b->distribute_running) {
> > > > -		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> > > > -		return;
> > > > -	}
> > > >  
> > > >  	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
> > > >  		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> > > > @@ -5065,9 +5059,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> > > >  	if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
> > > >  		runtime = cfs_b->runtime;
> > > >  
> > > > -	if (runtime)
> > > > -		cfs_b->distribute_running = 1;
> > > > -
> > > >  	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> > > >  
> > > >  	if (!runtime)
> > > > @@ -5076,7 +5067,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> > > >  	distribute_cfs_runtime(cfs_b);
> > > >  
> > > >  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > > > -	cfs_b->distribute_running = 0;
> > > >  	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> > > >  }
> > > 
> > > When I read the tip code, I found nothing between above lock/unlock.
> > > This commit removed distribute_running. Is there any reason to remain
> > > that lock/unlock there ? I feel that it is not necessary now, no ?
> > >
> > 
> > Yeah, that looks pretty useless :)
> > 
> > Do you want to spin up a patch?
> 
> Thanks for your reply, I prepared a patch for that indeed.
> 
> Attached below:
> 
> From 9ce12d6ab5542041e5adab7b200874c789cfd6e6 Mon Sep 17 00:00:00 2001
> From: Tao Zhou <ouwen210@hotmail.com>
> Date: Sat, 6 Jun 2020 23:08:58 +0800
> Subject: [PATCH] sched/fair: remove the residual cfs_b lock/unlock
> 
> After commit ab93a4bc955b, cfs_b->distribute_running is not used and
> removed. The lock/unlock protecting it are not removed and remain in
> the code. One benefit of removing them is that it can elimite the code
> size a little.
> 
> Fixes: ab93a4bc955b ("sched/fair: Remove distribute_running from CFS bandwidth")
> ---
>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 35f4cc024dcf..cc2e1e839e03 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5089,9 +5089,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  		return;
>  
>  	distribute_cfs_runtime(cfs_b);
> -
> -	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> -	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  }
>  
>  /*
> --


Thanks Tao.

Reviewed-by: Phil Auld <pauld@redhat.com>

> 
> Thanks,
> Tao
> 
> > Cheers,
> > Phil
> > 
> > 
> > > Thanks
> > > 
> > > > @@ -5218,7 +5208,6 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> > > >  	cfs_b->period_timer.function = sched_cfs_period_timer;
> > > >  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > > >  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
> > > > -	cfs_b->distribute_running = 0;
> > > >  	cfs_b->slack_started = false;
> > > >  }
> > > >  
> > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > index db3a576..7198683 100644
> > > > --- a/kernel/sched/sched.h
> > > > +++ b/kernel/sched/sched.h
> > > > @@ -349,7 +349,6 @@ struct cfs_bandwidth {
> > > >  
> > > >  	u8			idle;
> > > >  	u8			period_active;
> > > > -	u8			distribute_running;
> > > >  	u8			slack_started;
> > > >  	struct hrtimer		period_timer;
> > > >  	struct hrtimer		slack_timer;
> > > 
> > 
> > -- 
> 

-- 

