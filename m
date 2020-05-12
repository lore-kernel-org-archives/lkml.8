Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69DCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755712054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZd6jb/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgELQD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:03:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34605 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725992AbgELQD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589299436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zOD1ZMsJH+6+YOeIeEjkmiXARILcJYCNRieBUs4BWZs=;
        b=GZd6jb/2sR594E4dl2zS22h9CmpAFV3BZ7Vw94z39Dx8wwdNTbUotVBh/rVj6c4nJmCx6E
        VlajLBXxqkoNE9i5df1CGWAOwBFurydW4lDiEhBWnqSxMbBq4e+f2/68Y1l1ecY6q2nwKP
        hHYCu7DhGCoex3sPgzWZcVllerah5js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-ERroi7vNOuSCGEBY1tfB1Q-1; Tue, 12 May 2020 12:03:52 -0400
X-MC-Unique: ERroi7vNOuSCGEBY1tfB1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC31A473;
        Tue, 12 May 2020 16:03:50 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-4.phx2.redhat.com [10.3.114.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2629B100EBAE;
        Tue, 12 May 2020 16:03:46 +0000 (UTC)
Date:   Tue, 12 May 2020 12:03:44 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
Message-ID: <20200512160344.GC4256@lorien.usersys.redhat.com>
References: <20200511191320.31854-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511191320.31854-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:13:20PM +0200 Vincent Guittot wrote:
> Although not exactly identical, unthrottle_cfs_rq() and enqueue_task_fair()
> are quite close and follow the same sequence for enqueuing an entity in the
> cfs hierarchy. Modify unthrottle_cfs_rq() to use the same pattern as
> enqueue_task_fair(). This fixes a problem already faced with the latter and
> add an optimization in the last for_each_sched_entity loop.
> 
> Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> Reported-by Tao Zhou <zohooouoto@zoho.com.cn>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> This path applies on top of 20200507203612.GF19331@lorien.usersys.redhat.com
> and fixes similar problem for unthrottle_cfs_rq()
> 
>  kernel/sched/fair.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e2450c2e0747..4b73518aa25c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4803,26 +4803,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	idle_task_delta = cfs_rq->idle_h_nr_running;
>  	for_each_sched_entity(se) {
>  		if (se->on_rq)
> -			enqueue = 0;
> +			break;
> +		cfs_rq = cfs_rq_of(se);
> +		enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
>  
> +		cfs_rq->h_nr_running += task_delta;
> +		cfs_rq->idle_h_nr_running += idle_task_delta;
> +
> +		/* end evaluation on encountering a throttled cfs_rq */
> +		if (cfs_rq_throttled(cfs_rq))
> +			goto unthrottle_throttle;
> +	}
> +
> +	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> -		if (enqueue) {
> -			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> -		} else {
> -			update_load_avg(cfs_rq, se, 0);
> -			se_update_runnable(se);
> -		}
> +
> +		update_load_avg(cfs_rq, se, UPDATE_TG);
> +		se_update_runnable(se);
>  
>  		cfs_rq->h_nr_running += task_delta;
>  		cfs_rq->idle_h_nr_running += idle_task_delta;
>  
> +
> +		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
> -			break;
> +			goto unthrottle_throttle;
> +
> +		/*
> +		 * One parent has been throttled and cfs_rq removed from the
> +		 * list. Add it back to not break the leaf list.
> +		 */
> +		if (throttled_hierarchy(cfs_rq))
> +			list_add_leaf_cfs_rq(cfs_rq);
>  	}
>  
>  	if (!se)
>  		add_nr_running(rq, task_delta);
>  
> +unthrottle_throttle:
>  	/*
>  	 * The cfs_rq_throttled() breaks in the above iteration can result in
>  	 * incomplete leaf list maintenance, resulting in triggering the
> @@ -4831,7 +4849,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
>  
> -		list_add_leaf_cfs_rq(cfs_rq);
> +		if (list_add_leaf_cfs_rq(cfs_rq))
> +			break;
>  	}
>  
>  	assert_list_leaf_cfs_rq(rq);
> -- 
> 2.17.1
> 

I ran my reproducer test with this one as well. As expected, since
the first patch fixed the issue I was seeing and I wasn't hitting
the assert here anyway, I didn't hit the assert.

But I also didn't hit any other issues, new or old. 

It makes sense to use the same logic flow here as enqueue_task_fair.

Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil
-- 

