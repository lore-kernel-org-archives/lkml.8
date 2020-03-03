Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4626C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B80B2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dNLKl8/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgCCTxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:53:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbgCCTxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/XagQY7ezT4gY9tBsVdZa0FpZkAaDyUH4Veo3EaWB6A=; b=dNLKl8/ZzTARnUdwPRGHWuf1xB
        24tyChwJ7V5MWs+qKHO9HO6aBphfkosXFZhlo7vIeDfWdBlJE/b2slrINkNzYw8kPENkpNWtpzfrd
        KQrWvmGHnOQ6de4oyF1OuPUu2UYmjIayTIUDrkkjTSBF7SKtU5s5VKpQucCTULTMac0QGOHkCOFK4
        W78Leyb6bYEzOVcLjRqq964022LMMVfFDBL90LjB8RithwS0QT1Nb6Ff9KKr2gvT7INYZWr79YUYj
        g84E9PP1TBSrc+F9fgcU9iTVh8qsem/Tt1NVwmU8kI0WXLoMKU1xZ1Iev9AOPHHreF8grDJwUiio5
        m5pDR9yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9Day-0007vA-An; Tue, 03 Mar 2020 19:52:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2035F30110E;
        Tue,  3 Mar 2020 20:50:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 592B72021ECAF; Tue,  3 Mar 2020 20:52:45 +0100 (CET)
Date:   Tue, 3 Mar 2020 20:52:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq
 is too, small
Message-ID: <20200303195245.GF2596@hirez.programming.kicks-ass.net>
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:17:03PM +0800, 王贇 wrote:
> During our testing, we found a case that shares no longer
> working correctly, the cgroup topology is like:
> 
>   /sys/fs/cgroup/cpu/A		(shares=102400)
>   /sys/fs/cgroup/cpu/A/B	(shares=2)
>   /sys/fs/cgroup/cpu/A/B/C	(shares=1024)
> 
>   /sys/fs/cgroup/cpu/D		(shares=1024)
>   /sys/fs/cgroup/cpu/D/E	(shares=1024)
>   /sys/fs/cgroup/cpu/D/E/F	(shares=1024)
> 
> The same benchmark is running in group C & F, no other tasks are
> running, the benchmark is capable to consumed all the CPUs.
> 
> We suppose the group C will win more CPU resources since it could
> enjoy all the shares of group A, but it's F who wins much more.
> 
> The reason is because we have group B with shares as 2, which make
> the group A 'cfs_rq->load.weight' very small.
> 
> And in calc_group_shares() we calculate shares as:
> 
>   load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>   shares = (tg_shares * load) / tg_weight;
> 
> Since the 'cfs_rq->load.weight' is too small, the load become 0
> in here, although 'tg_shares' is 102400, shares of the se which
> stand for group A on root cfs_rq become 2.

Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
B->shares/nr_cpus.

> While the se of D on root cfs_rq is far more bigger than 2, so it
> wins the battle.
> 
> This patch add a check on the zero load and make it as MIN_SHARES
> to fix the nonsense shares, after applied the group C wins as
> expected.
> 
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 84594f8aeaf8..53d705f75fa4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>  	tg_shares = READ_ONCE(tg->shares);
> 
>  	load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
> +	if (!load && cfs_rq->load.weight)
> +		load = MIN_SHARES;
> 
>  	tg_weight = atomic_long_read(&tg->load_avg);

Yeah, I suppose that'll do. Hurmph, wants a comment though.

But that has me looking at other users of scale_load_down(), and doesn't
at least update_tg_cfs_load() suffer the same problem?
