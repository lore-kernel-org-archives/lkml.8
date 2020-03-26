Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE703C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C2D20737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Igz90rJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCZNbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:31:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28695 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbgCZNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585229468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JszvOvoRUQGRKGqg0igxZKOZO39zKRLJjdSgTJKjaug=;
        b=Igz90rJc5cy0HfxA1hEv4PXQuuwxyL8x2ZG1KxzbU6TjCMjUeuUTtYK1MMdsykaCEcOZTG
        k5k3UnQ2KuX8QlCBDheJoTUKza7a9UFjjMNyHl1Lyg34v6B3iaQYd6tRvMSXwCj44Mfamd
        KmPUFqjYlpZ5v8ixFW0VzF1d/5lQxQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-GC-7odwjPjakEKZ5OgNsMQ-1; Thu, 26 Mar 2020 09:31:03 -0400
X-MC-Unique: GC-7odwjPjakEKZ5OgNsMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF44C107ACCA;
        Thu, 26 Mar 2020 13:31:01 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A1F10002A5;
        Thu, 26 Mar 2020 13:30:57 +0000 (UTC)
Date:   Thu, 26 Mar 2020 09:30:55 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
        vpillai@digitalocean.com, joel@joelfernandes.org,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Fix negative imbalance in imbalance
 calculation
Message-ID: <20200326133055.GA5537@lorien.usersys.redhat.com>
References: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 01:42:29PM +0800 Aubrey Li wrote:
> A negative imbalance value was observed after imbalance calculation,
> this happens when the local sched group type is group_fully_busy,
> and the average load of local group is greater than the selected
> busiest group. Fix this problem by comparing the average load of the
> local and busiest group before imbalance calculation formula.
> 
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Phil Auld <pauld@redhat.com>
> ---
>  kernel/sched/fair.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c1217bf..4a2ba3f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8761,6 +8761,14 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  
>  		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
>  				sds->total_capacity;
> +		/*
> +		 * If the local group is more loaded than the selected
> +		 * busiest group don't try to pull any tasks.
> +		 */
> +		if (local->avg_load >= busiest->avg_load) {
> +			env->imbalance = 0;
> +			return;
> +		}
>  	}
>  
>  	/*
> -- 
> 2.7.4
> 

I like this one better. Thanks!

Reviewed-by: Phil Auld <pauld@redhat.com>

-- 

