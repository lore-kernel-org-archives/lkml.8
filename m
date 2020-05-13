Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81673CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A12206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beYiwgyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbgEMM4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:56:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38522 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733058AbgEMM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589374576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rg6JkW5pd+D3Jw1ike2ImD0WSry7w4HYlBO089Hj5fo=;
        b=beYiwgydbZMA0AdjWKt6NwgSpHan2RIwTJiPK4lmXuGaNjbrlJyeldpelSjprOEEF2S7Ys
        CBHTaaw9+QSnS7jA2bfXqMliVNL9+z+bk/j0o9riaCao4BqWw1cN52N9wRvN4+4jcFNudC
        GSutHiECzbgZ9KO2A08PdN7qTMyFo6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-IKGYLsVMMAyDhyUHlrG70w-1; Wed, 13 May 2020 08:56:13 -0400
X-MC-Unique: IKGYLsVMMAyDhyUHlrG70w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE4F108BD0B;
        Wed, 13 May 2020 12:56:11 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-165.phx2.redhat.com [10.3.113.165])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52B9C2E033;
        Wed, 13 May 2020 12:56:02 +0000 (UTC)
Date:   Wed, 13 May 2020 08:56:00 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        ouwen210@hotmail.com, pkondeti@codeaurora.org
Subject: Re: [PATCH v2] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
Message-ID: <20200513125600.GC12425@lorien.usersys.redhat.com>
References: <20200513123422.28299-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513123422.28299-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wed, May 13, 2020 at 02:34:22PM +0200 Vincent Guittot wrote:
> Although not exactly identical, unthrottle_cfs_rq() and enqueue_task_fair()
> are quite close and follow the same sequence for enqueuing an entity in the
> cfs hierarchy. Modify unthrottle_cfs_rq() to use the same pattern as
> enqueue_task_fair(). This fixes a problem already faced with the latter and
> add an optimization in the last for_each_sched_entity loop.
> 
> Reported-by Tao Zhou <zohooouoto@zoho.com.cn>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> v2 changes:
> - Remove useless if statement
> 
>  kernel/sched/fair.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4e12ba882663..a0c690d57430 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4816,26 +4816,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	idle_task_delta = cfs_rq->idle_h_nr_running;
>  	for_each_sched_entity(se) {
>  		if (se->on_rq)
> -			enqueue = 0;

Can probably drop the now-unused enqueue variable too.


Cheers,
Phil



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
> -	if (!se)
> -		add_nr_running(rq, task_delta);
> +	/* At this point se is NULL and we are at root level*/
> +	add_nr_running(rq, task_delta);
>  
> +unthrottle_throttle:
>  	/*
>  	 * The cfs_rq_throttled() breaks in the above iteration can result in
>  	 * incomplete leaf list maintenance, resulting in triggering the
> @@ -4844,7 +4862,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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

-- 

