Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E3C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4330B206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UeqIdQrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFVU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:20:58 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52552 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:20:57 -0500
Received: by mail-pj1-f66.google.com with SMTP id lt1so1585244pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 13:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aWA0KDJLLB2h8niWQNr55OSE9WX64DdWT/E3eC2fLV4=;
        b=UeqIdQrl1JCsF6BXgRPAlToaAuWmDLUojYAdA+5AnAF9TjjwHmj1z3V7McYFXP4BU2
         TaisRvTQXy2nl7dwdrEaNMtXKfyy/h3VyYm9L9Z/7ixS1lFVvh4yNMvrGpm45zgRS2Py
         s4xFuE3IZILKz+ZzyxzbBnNdFz1G39ONiKzZeMbRgJfSJ09GKRDg16Wkuv4VO1Twh0Wq
         2UbTafUWHbe/Cax2u1TppYi//yHtGaP7qPd7c9wqAaQGBm/u3lnzDQj0VzZeyrkTUb5d
         sHVcxE1qNw+iBPxUJxuPInquukdH0wXKQpmvSkNjkeNbN3x9SBVejk+f2wKEreYiEEKg
         Smyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=aWA0KDJLLB2h8niWQNr55OSE9WX64DdWT/E3eC2fLV4=;
        b=bddqevyJyTjk31Q4rvHcSnFCDzRzgls68OYLBNOBmE3E6r9nJFRNccbFSxYVC2nFa9
         pxS/PJwX5U99yTeZyyuXq0l2v4Tr1fePr8zJsvmmtK478QHeRgevV2ZLyUHg4w3B6ETh
         xpKvEM4CkYzjJr5lem1kvbu2XqQoHm70qYuwkTPnYVrK/8Ed2CJGkqgxhqHWwM/B4MFF
         J/KOSp3KMTPjJa2NiP7kJecWNWnMqah2Dhr7TjaNgu8xMTBqgrKXPx/M+icwiYQ9ekIa
         BYyIgCrTc5Ygkv4b1nsru4COQgzDRV59sYV2eqdtKHRqZ/n7EbaR0n8pQazA38wq0h6R
         iplg==
X-Gm-Message-State: ANhLgQ076P17D168R/7SqXAkoO6EEs3U5kqTmkXaN2d2LEkjYbzoCaso
        gvduthY32T3XAAvtcrTM7IFC1Q==
X-Google-Smtp-Source: ADFU+vuF+Xb2jEuByngROV9YsJhqtQOtV/R823s1SCefnQ8gKJG2SHA6ZmN3xXvPi+6HFNbeSJoxSQ==
X-Received: by 2002:a17:90a:bf81:: with SMTP id d1mr5725511pjs.21.1583529656139;
        Fri, 06 Mar 2020 13:20:56 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id s126sm13532665pfb.143.2020.03.06.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 13:20:55 -0800 (PST)
From:   bsegall@google.com
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com,
        zhout@vivaldi.net
Subject: Re: [PATCH v3] sched/fair : fix reordering of enqueue/dequeue_task_fair
References: <20200306084208.12583-1-vincent.guittot@linaro.org>
Date:   Fri, 06 Mar 2020 13:20:53 -0800
In-Reply-To: <20200306084208.12583-1-vincent.guittot@linaro.org> (Vincent
        Guittot's message of "Fri, 6 Mar 2020 09:42:08 +0100")
Message-ID: <xm2636al41u2.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> Even when a cgroup is throttled, the group se of a child cgroup can still
> be enqueued and its gse->on_rq stays true. When a task is enqueued on such
> child, we still have to update the load_avg and increase
> h_nr_running of the throttled cfs. Nevertheless, the 1st
> for_each_sched_entity loop is skipped because of gse->on_rq == true and the
> 2nd loop because the cfs is throttled whereas we have to update both
> load_avg with the old h_nr_running and increase h_nr_running in such case.
>
> The same sequence can happen during dequeue when se moves to parent before
> breaking in the 1st loop.
>
> Note that the update of load_avg will effectively happen only once in order
> to sync up to the throttled time. Next call for updating load_avg will stop
> early because the clock stays unchanged.


Reviewed-by: Ben Segall <bsegall@google.com>

(though it seems I was too slow in actually testing this and it's in
tip, which confused me a bunch when I tried to apply the patch for testing)

>
> Fixes: 6d4d22468dae ("sched/fair: Reorder enqueue/dequeue_task_fair path")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> Changes since v2:
> - added similar changes into dequeue_task_fair as reported by Ben
>
>  kernel/sched/fair.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..ea2748a132a2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5431,16 +5431,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
>  
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> -			goto enqueue_throttle;
> -
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
>  		se_update_runnable(se);
>  		update_cfs_group(se);
>  
>  		cfs_rq->h_nr_running++;
>  		cfs_rq->idle_h_nr_running += idle_h_nr_running;
> +
> +		/* end evaluation on encountering a throttled cfs_rq */
> +		if (cfs_rq_throttled(cfs_rq))
> +			goto enqueue_throttle;
>  	}
>  
>  enqueue_throttle:
> @@ -5529,16 +5529,17 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
>  
> -		/* end evaluation on encountering a throttled cfs_rq */
> -		if (cfs_rq_throttled(cfs_rq))
> -			goto dequeue_throttle;
> -
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
>  		se_update_runnable(se);
>  		update_cfs_group(se);
>  
>  		cfs_rq->h_nr_running--;
>  		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
> +
> +		/* end evaluation on encountering a throttled cfs_rq */
> +		if (cfs_rq_throttled(cfs_rq))
> +			goto dequeue_throttle;
> +
>  	}
>  
>  dequeue_throttle:
