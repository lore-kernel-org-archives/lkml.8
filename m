Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A4C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B9D2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OVaJfwr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJJgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:36:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgBJJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KWSALxgD8DPKs4l9QdTGtfSb74FtrWq0gjEnbifVqg8=; b=OVaJfwr6gYS4lvSTolSKQURRnZ
        bsUfpKOQXpyjcfuQ+GklUxLM+XPufwIZMez5WA9oXfzNCviUFc3Eci9Z6RbdboErXvezS5DW47NrS
        h87x6BwSNYCSd7QS0SqVwk9mmQNNOwYqkeSdjJq2f0ay0q68Mw3Qm6H9hCIbux1Jwmh1nUDzXhAQ3
        xf/TJEl+vBfQqP4JZCQkQxgcOU9y45+lDSkmGZGMbZj5oPNk0xBO99OacaScB7EqDQKeMUef8bfDi
        7m957y9dq4zemVJNKh7uGaRVTVd4sl0BILUhr5oKPsr0h+VeGr1vnUyB9FcfFkC+IJ7mCa+xxx3Mx
        HAFZmGnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j15UQ-0002wT-4b; Mon, 10 Feb 2020 09:36:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB5E73012D8;
        Mon, 10 Feb 2020 10:34:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15C602B1D5567; Mon, 10 Feb 2020 10:36:24 +0100 (CET)
Date:   Mon, 10 Feb 2020 10:36:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] events: Annotate parent_ctx with __rcu
Message-ID: <20200210093624.GB14879@hirez.programming.kicks-ass.net>
References: <20200208144648.18833-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208144648.18833-1-frextrite@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 08:16:49PM +0530, Amol Grover wrote:
> parent_ctx is used under RCU context in kernel/events/core.c,
> tell sparse about it aswell.
> 
> Fixes the following instances of sparse error:
> kernel/events/core.c:3221:18: error: incompatible types in comparison
> kernel/events/core.c:3222:23: error: incompatible types in comparison
> 
> This introduces the following two sparse errors:
> kernel/events/core.c:3117:18: error: incompatible types in comparison
> kernel/events/core.c:3121:30: error: incompatible types in comparison
> 
> Hence, use rcu_dereference() to access parent_ctx and silence
> the newly introduced errors.
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  include/linux/perf_event.h |  2 +-
>  kernel/events/core.c       | 11 ++++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 6d4c22aee384..e18a7bdc6f98 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -810,7 +810,7 @@ struct perf_event_context {
>  	 * These fields let us detect when two contexts have both
>  	 * been cloned (inherited) from a common ancestor.
>  	 */
> -	struct perf_event_context	*parent_ctx;
> +	struct perf_event_context __rcu	*parent_ctx;
>  	u64				parent_gen;
>  	u64				generation;
>  	int				pin_count;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2173c23c25b4..2a8c5670b254 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3106,26 +3106,31 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>  static int context_equiv(struct perf_event_context *ctx1,
>  			 struct perf_event_context *ctx2)
>  {
> +	struct perf_event_context *parent_ctx1, *parent_ctx2;
> +
>  	lockdep_assert_held(&ctx1->lock);
>  	lockdep_assert_held(&ctx2->lock);
>  
> +	parent_ctx1 = rcu_dereference(ctx1->parent_ctx);
> +	parent_ctx2 = rcu_dereference(ctx2->parent_ctx);

Bah.

Why are you  fixing all this sparse crap and making the code worse?
