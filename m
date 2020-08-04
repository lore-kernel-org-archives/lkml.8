Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FC6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B3E2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B3yTcRUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgHDK4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgHDK4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:56:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SL2IzDndId3GWn6/2W3OPatuM239OcLjh5vb98ipAS4=; b=B3yTcRUMHzFbnMJKuxvzYXLwWw
        YOW4lY0F2jJA5oJhatfzgkhxRqCZatc6osKix/HkFHg49DZHs5pSg1DyY//iXqUP22n9VOrWzPRBj
        WLOFOPrXMmBIOzYNanOW4RqOwYVVx2EztSzo/iMP8eRZJlcmUnMk4QVA3EGmEfO1LGJFDOvpwH5DU
        Vqb0wVwLZ5zGWqau070pFFM/77tL4/hh3+EOW6bHNsiU7oM/xBXJTFZxhfroy9N7AI/WdcEn5Nz8X
        mm8g5y4qVTnOtooY03pzrP2INnYpwUvkAsEdBpizsUijJuilILGLRng5FH8CO0hCZn2S08nTsv03N
        YrrF6a/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2ucF-0003NW-Td; Tue, 04 Aug 2020 10:56:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C79F3010D2;
        Tue,  4 Aug 2020 12:56:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BA222B94E74D; Tue,  4 Aug 2020 12:56:19 +0200 (CEST)
Date:   Tue, 4 Aug 2020 12:56:19 +0200
From:   peterz@infradead.org
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: ignore cache hotness for SMT migration
Message-ID: <20200804105619.GE2657@hirez.programming.kicks-ass.net>
References: <20200804000614.4176212-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804000614.4176212-1-joshdon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 05:06:14PM -0700, Josh Don wrote:
> SMT siblings share caches, so cache hotness should be irrelevant for
> cross-sibling migration.
> 
> Proposed-by: Venkatesh Pallipadi <venki@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2ba8f230feb9..5b203b55bcb2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7402,6 +7402,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>  	if (unlikely(task_has_idle_policy(p)))
>  		return 0;
>  
> +	if ((env->sd->flags & cpu_smt_flags()) == cpu_smt_flags())
> +		return 0;

I think that wants to be:

	if (env->sd->flags & SD_SHARE_CPUCAPACITY)

Also, perhaps stick a comment on top with the rationale for this.

> +
>  	/*
>  	 * Buddy candidates are cache hot:
>  	 */
> -- 
> 2.28.0.163.g6104cc2f0b6-goog
> 
