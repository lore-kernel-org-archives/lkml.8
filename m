Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A394C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B3024980
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEHP2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:28:13 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25712 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbgEHP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:28:13 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2020 11:28:12 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1588950703; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=MxW5v52xcq0A5kULWBjxUxVLX5f1DdhVGOUmuPzPYagup1eWLNpgfdhEX+6ufwp8hzcswpfhLh/1S2PhYX88hNL2MNf8L956Ge16BwnD5k+6vaWoZlfM6Vzymr9rmdwVLX/gItokhryfeOz3lgmi5ltjAwKNAVjZzfi0Hzskk+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1588950703; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LXiJi/pjLi+NErqUytW+W7VHUMkYIAAPd+1qtwXS4BQ=; 
        b=dQyn4nH/bmv3E61yA33TIPq3Xeu50yxLuB17LXJ1TFuId3KdwvgyZkDMO6eW/cwT4nB/BHseKXoNMKaQBoi9eE4VIfDHh1Eu6z8GhzKjqfgtFo4cPLSWnWY6by1ygXbIsvyA9cmXZ/hVuf4gM0THGEZrs6Clv1GNaAxDKgxDztk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        spf=pass  smtp.mailfrom=zohooouoto@zoho.com.cn;
        dmarc=pass header.from=<zohooouoto@zoho.com.cn> header.from=<zohooouoto@zoho.com.cn>
Received: from localhost (122.194.88.39 [122.194.88.39]) by mx.zoho.com.cn
        with SMTPS id 1588950698707564.4527268969009; Fri, 8 May 2020 23:11:38 +0800 (CST)
Date:   Fri, 8 May 2020 23:15:15 +0800
From:   Tao Zhou <zohooouoto@zoho.com.cn>
To:     Phil Auld <pauld@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, ouwen210@hotmail.com
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
Message-ID: <20200508151515.GA25974@geo.homenetwork>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507203612.GF19331@lorien.usersys.redhat.com>
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
> sched/fair: Fix enqueue_task_fair warning some more
> 
> The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> did not fully resolve the issues with the rq->tmp_alone_branch !=
> &rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
> the first for_each_sched_entity loop exits due to on_rq, having incompletely
> updated the list.  In this case the second for_each_sched_entity loop can
> further modify se. The later code to fix up the list management fails to do
> what is needed because se no longer points to the sched_entity which broke
> out of the first loop.
> 

> Address this by calling leaf_add_rq_list if there are throttled parents while
> doing the second for_each_sched_entity loop.

Thanks for your trace imformation and explanation. I
truely have learned from this and that.

s/leaf_add_rq_list/list_add_leaf_cfs_rq/

> 
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..c6d57c334d51 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5479,6 +5479,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
>  			goto enqueue_throttle;
> +
> +               /*
> +                * One parent has been throttled and cfs_rq removed from the
> +                * list. Add it back to not break the leaf list.
> +                */
> +               if (throttled_hierarchy(cfs_rq))
> +                       list_add_leaf_cfs_rq(cfs_rq);
>  	}

I was confused by why the throttled cfs rq can be on list.
It is possible when enqueue a task and thanks to the 'threads'.
But I think the above comment does not truely put the right
intention, right ?
If throttled parent is onlist, the child cfs_rq is ignored
to be added to the leaf cfs_rq list me think.

unthrottle_cfs_rq() follows the same logic if i am not wrong.
Is it necessary to add the above to it ?

Thanks,
Tau

>  
>  enqueue_throttle:
> -- 
> 2.18.0
> 
> V2 rework the fix based on Vincent's suggestion. Thanks Vincent.
> 
> 
> Cheers,
> Phil
> 
> -- 
> 
