Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6BBC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69FB20758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvnRJLKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgIBGAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:00:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40891 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIBGAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599026434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XX6T3Cd41nlFZHQTl+z885krmR2QfaHmGXWnSy4Jd1g=;
        b=PvnRJLKYJ3BSiJ++L6omyQGd4s4cH5b7w88Vu17Hg+tKqpH98MuClA2UkQnXytMwuQOKIQ
        jNOnIe56toxxrN6pmEhS83KHeSSaB/1KxmDvPHAcS7ygj2QtOePlot+1YvG43NIWMjw+TQ
        /SGm2ZxsfyUdMbyfia7gu1rpBg4lNy4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-IRA3oKnwNe6Z49dkb9PdAQ-1; Wed, 02 Sep 2020 02:00:29 -0400
X-MC-Unique: IRA3oKnwNe6Z49dkb9PdAQ-1
Received: by mail-wm1-f71.google.com with SMTP id x81so1391139wmg.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 23:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XX6T3Cd41nlFZHQTl+z885krmR2QfaHmGXWnSy4Jd1g=;
        b=rB01x1+1LIxN28NAPISttrnfHLNGxEXKcWU0BspPEDDw/BhF4EdRxyVKlwhz5oRmb3
         iUEknDl6Yd4XScS+7zUSxbHzB0/Unw7gQph4foIDLVOHOMc63T53+5WMPwaQlkm0zPfn
         OVs4utYfqmvFaephFSQj7S7oLgl7LvnzRc7YH+NaqgyXKqgqlSLNRVVf0ot+Hqvd6Ix6
         r+GP4t1ZeKIqXVIicyacWb3stzKdgCatjkIC0uZX6UNvr/XiX+ns3OTrIz6rwNdW+HUb
         jihtMBY+/vFQX5FtWywcy8DCCFn5BRSsaCNi8sM35rFkjkZ1YGnuGN+9rd9D10Om82Ke
         MKuQ==
X-Gm-Message-State: AOAM5324EEdjcYJakII8Q9qdODpiphAAWmB+rqIMl21Mv8c1s2r7AHo7
        BraU+s6Bk6is+u7nOQ/gsDsb5YLI48ewO8v19QcEvn4RST4fik59prY0lQChTuP+K1RQAsRTITu
        /40YxLSryiXdGosKm1jxl+7xV
X-Received: by 2002:a5d:574e:: with SMTP id q14mr5042755wrw.281.1599026428247;
        Tue, 01 Sep 2020 23:00:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFUS/8NIzm6LMDAtQecHFfl+rqXwDMNvLnXzZMDRomAXPEA7Fm44AMqaVmyNzUNuD6PfZJww==
X-Received: by 2002:a5d:574e:: with SMTP id q14mr5042729wrw.281.1599026428014;
        Tue, 01 Sep 2020 23:00:28 -0700 (PDT)
Received: from localhost.localdomain ([151.44.52.181])
        by smtp.gmail.com with ESMTPSA id 5sm4694529wmz.22.2020.09.01.23.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:00:27 -0700 (PDT)
Date:   Wed, 2 Sep 2020 08:00:24 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH] sched/deadline: Fix stale throttling on de-/boosted tasks
Message-ID: <20200902060024.GK16601@localhost.localdomain>
References: <20200831110719.2126930-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831110719.2126930-1-l.stach@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/08/20 13:07, Lucas Stach wrote:
> When a boosted task gets throttled, what normally happens is that it's
> immediately enqueued again with ENQUEUE_REPLENISH, which replenishes the
> runtime and clears the dl_throttled flag. There is a special case however:
> if the throttling happened on sched-out and the task has been deboosted in
> the meantime, the replenish is skipped as the task will return to its
> normal scheduling class. This leaves the task with the dl_throttled flag
> set.
> 
> Now if the task gets boosted up to the deadline scheduling class again
> while it is sleeping, it's still in the throttled state. The normal wakeup
> however will enqueue the task with ENQUEUE_REPLENISH not set, so we don't
> actually place it on the rq. Thus we end up with a task that is runnable,
> but not actually on the rq and neither a immediate replenishment happens,
> nor is the replenishment timer set up, so the task is stuck in
> forever-throttled limbo.
> 
> Clear the dl_throttled flag before dropping back to the normal scheduling
> class to fix this issue.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> This is the root cause and fix of the issue described at [1]. After working
> on other stuff for the last few months, I finally was able to circle back
> to this issue and gather the required data to pinpoint the failure mode.
> 
> [1] https://lkml.org/lkml/2020/3/20/765
> ---
>  kernel/sched/deadline.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3862a28cd05d..c19c1883d695 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1527,12 +1527,15 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
>  		pi_se = &pi_task->dl;
>  	} else if (!dl_prio(p->normal_prio)) {
>  		/*
> -		 * Special case in which we have a !SCHED_DEADLINE task
> -		 * that is going to be deboosted, but exceeds its
> -		 * runtime while doing so. No point in replenishing
> -		 * it, as it's going to return back to its original
> -		 * scheduling class after this.
> +		 * Special case in which we have a !SCHED_DEADLINE task that is going
> +		 * to be deboosted, but exceeds its runtime while doing so. No point in
> +		 * replenishing it, as it's going to return back to its original
> +		 * scheduling class after this. If it has been throttled, we need to
> +		 * clear the flag, otherwise the task may wake up as throttled after
> +		 * being boosted again with no means to replenish the runtime and clear
> +		 * the throttle.
>  		 */
> +		p->dl.dl_throttled = 0;
>  		BUG_ON(!p->dl.dl_boosted || flags != ENQUEUE_REPLENISH);
>  		return;
>  	}

Ah, right, thanks for looking into this issue!

Wonder if we should be calling __dl_clear_params() instead of just
clearing dl_throttled, but what you propose makes sense to me.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,

Juri

