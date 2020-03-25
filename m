Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DF4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDCC2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nkd4Y9/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgCYNnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:43:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39514 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727601AbgCYNnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585143792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVbrbZGlGCDobajD/IIk2GlPsshKfxDL55YzRA0OFDY=;
        b=Nkd4Y9/X9q6AmYpqpD1c+4Ng1DcVtUcka6pZfK5OcLWvKmiCRRjthtRFUFnSTv1dW6a+7d
        +atfONe4gS+htkLR3qQNaOe6A7gZYEqMojo8v1ya8Gj9jMMPaamqHWZ9jukKu4OgVEzm79
        OT+Nblm33xpDPReU3EjsWdrxR2cn4Js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217--6DSq4XrOoWnX8walcvo4Q-1; Wed, 25 Mar 2020 09:43:09 -0400
X-MC-Unique: -6DSq4XrOoWnX8walcvo4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB326107ACC9;
        Wed, 25 Mar 2020 13:43:06 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 848E65D9C5;
        Wed, 25 Mar 2020 13:43:02 +0000 (UTC)
Date:   Wed, 25 Mar 2020 09:43:00 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
        vpillai@digitalocean.com, joel@joelfernandes.org,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Don't pull task if local group is more
 loaded than busiest group
Message-ID: <20200325134300.GA30416@lorien.usersys.redhat.com>
References: <1585140388-61802-1-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585140388-61802-1-git-send-email-aubrey.li@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubrey,

On Wed, Mar 25, 2020 at 08:46:28PM +0800 Aubrey Li wrote:
> A huge number of load imbalance was observed when the local group
> type is group_fully_busy, and the average load of local group is
> greater than the selected busiest group, so the imbalance calculation
> returns a negative value actually. Fix this problem by comparing the
> average load before local group type check.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  kernel/sched/fair.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c1217bf..c524369 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8862,17 +8862,17 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  		goto out_balanced;
>  
>  	/*
> +	 * If the local group is more loaded than the selected
> +	 * busiest group don't try to pull any tasks.
> +	 */
> +	if (local->avg_load >= busiest->avg_load)
> +		goto out_balanced;
> +
> +	/*
>  	 * When groups are overloaded, use the avg_load to ensure fairness
>  	 * between tasks.
>  	 */
>  	if (local->group_type == group_overloaded) {
> -		/*
> -		 * If the local group is more loaded than the selected
> -		 * busiest group don't try to pull any tasks.
> -		 */
> -		if (local->avg_load >= busiest->avg_load)
> -			goto out_balanced;
> -
>  		/* XXX broken for overlapping NUMA groups */
>  		sds.avg_load = (sds.total_load * SCHED_CAPACITY_SCALE) /
>  				sds.total_capacity;
> -- 
> 2.7.4
> 

I'm not sure about this. I think this patch will undo a good bit of the
benefit of the load balancer rework.  Avg_load is really most useful
when things are overloaded. If we go back to looking at it here we may
fail to balance when needed.

There are cases where, due to group scheduler load scaling, local average
may be higher but have spare CPUs still whereas busiest may have extra
processes which be balanced.


Cheers,
Phil

-- 

