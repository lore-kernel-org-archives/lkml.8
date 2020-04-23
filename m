Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D92C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021702076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lshx1wWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgDWTaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgDWTaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:30:03 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6DC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wW7kfjmoIyiH/efnfs36TWPAJN5BAR8J0sx1TkhdOHk=; b=Lshx1wWqlErHOf6pvnt+vGTshH
        xPClY/A9iBYc+81Et8Mziz/AVPobzYZKeOjwrZZTmVpyzGhyK6IeW+MquzvpG6npKrQBw0yydLTPP
        99NFGcacMwq7LBr4SFD+2tTDCL6sVU0hgvDAVWwGybkNgLv7XO/XpbTaaKGEMJPfxuveNcHJb0jHj
        DvijphPVp6mvT/6toDkwZw/vFI/H/2KSJCrBJLJTxlH0xiFAxkvpUuS+BfhNTd5ejt+LN4xdwfmmA
        komegV+nW2BMLeSGZ3sL+g4bPQj/1rtQkQMk3x8XFMMnwN0yKVYUIPcKklz6IQ+1wWwEMP8/SWmmy
        4hAh51vQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRhXR-0007Hs-QX; Thu, 23 Apr 2020 19:29:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68F719836F8; Thu, 23 Apr 2020 21:29:30 +0200 (CEST)
Date:   Thu, 23 Apr 2020 21:29:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/pelt: sync util/runnable_sum with PELT window when
 propagating
Message-ID: <20200423192930.GY2483@worktop.programming.kicks-ass.net>
References: <20200422151401.9147-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422151401.9147-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:14:01PM +0200, Vincent Guittot wrote:
> update_tg_cfs_util/runnable() propagate the impact of the attach/detach of
> an entity down into the cfs_rq hierarchy which must keep the sync with
> the current pelt window.
> 
> Even if we can't sync child rq and its group se, we can sync the group se
> and parent cfs_rq with current PELT window. In fact, we must keep them sync
> in order to stay also synced with others se and group se that are already
> attached to the cfs_rq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..ca6aa89c88f2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3441,52 +3441,38 @@ static inline void
>  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
>  {
>  	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
> +	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
>  
>  	/* Nothing to update */
>  	if (!delta)
>  		return;
>  
> -	/*
> -	 * The relation between sum and avg is:
> -	 *
> -	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> -	 *
> -	 * however, the PELT windows are not aligned between grq and gse.
> -	 */

Instead of deleting this, could we perhaps extend it?
