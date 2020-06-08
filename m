Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE389C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0FB2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVa74QmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgFHOxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:53:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51643 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729938AbgFHOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591628002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=348O/stkX5rRAvU3hXLCDhwxnAdjbiqoKmblsaN//os=;
        b=MVa74QmQVF0pS1X4og5Z2tcYa/8mQFrtSN9DhvTnWIqkPQ9f9hus7htclCHjZ2XFajloqZ
        Ua/YF2ZmNzcao7OxewHPDNlgedDUdioA29UM5j0J3gFUqN0yxojkqkqSevLEBVxABEnob4
        XLaQjSv8b5jioBIny73j7XUfun/nlgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-0Kw7WqClMHKvPtuzdSvJmw-1; Mon, 08 Jun 2020 10:53:18 -0400
X-MC-Unique: 0Kw7WqClMHKvPtuzdSvJmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6F383DB78;
        Mon,  8 Jun 2020 14:53:07 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-117.phx2.redhat.com [10.3.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C6765D9E8;
        Mon,  8 Jun 2020 14:53:06 +0000 (UTC)
Date:   Mon, 8 Jun 2020 10:53:04 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] sched/fair: Remove distribute_running from CFS
 bandwidth
Message-ID: <20200608145304.GA24379@lorien.usersys.redhat.com>
References: <20200410225208.109717-3-joshdon@google.com>
 <158835733205.8414.9136130857443620621.tip-bot2@tip-bot2>
 <BL0PR14MB3779C02BB87DC4426C4761639A840@BL0PR14MB3779.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR14MB3779C02BB87DC4426C4761639A840@BL0PR14MB3779.namprd14.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 09:25:58AM +0800 Tao Zhou wrote:
> Hi,
> 
> On Fri, May 01, 2020 at 06:22:12PM -0000, tip-bot2 for Josh Don wrote:
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     ab93a4bc955b3980c699430bc0b633f0d8b607be
> > Gitweb:        https://git.kernel.org/tip/ab93a4bc955b3980c699430bc0b633f0d8b607be
> > Author:        Josh Don <joshdon@google.com>
> > AuthorDate:    Fri, 10 Apr 2020 15:52:08 -07:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 30 Apr 2020 20:14:38 +02:00
> > 
> > sched/fair: Remove distribute_running from CFS bandwidth
> > 
> > This is mostly a revert of commit:
> > 
> >   baa9be4ffb55 ("sched/fair: Fix throttle_list starvation with low CFS quota")
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
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > Tested-by: Phil Auld <pauld@redhat.com>
> > Link: https://lkml.kernel.org/r/20200410225208.109717-3-joshdon@google.com
> > ---
> >  kernel/sched/fair.c  | 13 +------------
> >  kernel/sched/sched.h |  1 -
> >  2 files changed, 1 insertion(+), 13 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0c13a41..3d6ce75 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4931,14 +4931,12 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
> >  	/*
> >  	 * This check is repeated as we release cfs_b->lock while we unthrottle.
> >  	 */
> > -	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
> > -		cfs_b->distribute_running = 1;
> > +	while (throttled && cfs_b->runtime > 0) {
> >  		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> >  		/* we can't nest cfs_b->lock while distributing bandwidth */
> >  		distribute_cfs_runtime(cfs_b);
> >  		raw_spin_lock_irqsave(&cfs_b->lock, flags);
> >  
> > -		cfs_b->distribute_running = 0;
> >  		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
> >  	}
> >  
> > @@ -5052,10 +5050,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >  	/* confirm we're still not at a refresh boundary */
> >  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> >  	cfs_b->slack_started = false;
> > -	if (cfs_b->distribute_running) {
> > -		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> > -		return;
> > -	}
> >  
> >  	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
> >  		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> > @@ -5065,9 +5059,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >  	if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
> >  		runtime = cfs_b->runtime;
> >  
> > -	if (runtime)
> > -		cfs_b->distribute_running = 1;
> > -
> >  	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> >  
> >  	if (!runtime)
> > @@ -5076,7 +5067,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >  	distribute_cfs_runtime(cfs_b);
> >  
> >  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > -	cfs_b->distribute_running = 0;
> >  	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> >  }
> 
> When I read the tip code, I found nothing between above lock/unlock.
> This commit removed distribute_running. Is there any reason to remain
> that lock/unlock there ? I feel that it is not necessary now, no ?
>

Yeah, that looks pretty useless :)

Do you want to spin up a patch?


Cheers,
Phil


> Thanks
> 
> > @@ -5218,7 +5208,6 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >  	cfs_b->period_timer.function = sched_cfs_period_timer;
> >  	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
> > -	cfs_b->distribute_running = 0;
> >  	cfs_b->slack_started = false;
> >  }
> >  
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index db3a576..7198683 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -349,7 +349,6 @@ struct cfs_bandwidth {
> >  
> >  	u8			idle;
> >  	u8			period_active;
> > -	u8			distribute_running;
> >  	u8			slack_started;
> >  	struct hrtimer		period_timer;
> >  	struct hrtimer		slack_timer;
> 

-- 

