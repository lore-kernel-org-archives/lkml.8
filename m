Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C04EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6700020739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXZh6+9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgFONer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgFONek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:34:40 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C95C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=27u+aslpGbbxT2/ao8LzkoAS94gMgtGGpixmRkO16yw=; b=GXZh6+9ppaEZPvsgVPReJkP861
        N2AoVKj7lQsfyO3QFcYsq5FFIIKI5ME6bm+OLfj8ebaleQ89yX7wTLy4PWCJH/fVuZcjj5nMqoJLO
        3B92qb6xhSlelPwMssdoZ7loUMyct0lO8yq5DHIYR2H91+/pfmhrpfyJwUoBArqnmigpJ04pqWMY9
        q7FDdDXJMfgx/3amEidcTJOhk4Jao8VT05Wax01QPrfMX3WsCCOIhW+jsozdYC9xb18+xkUQe83Up
        4jcaMGoi8Cp0+pK+HbYQIWOxOmYFzRf7twCOZTQDc9Iikmi1kkHCPEIr5M4c4vuYyAq8Q8q9X2bA9
        +r2B+kzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkpFb-0004qF-8H; Mon, 15 Jun 2020 13:34:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ECDF73060FD;
        Mon, 15 Jun 2020 15:34:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF9652392E715; Mon, 15 Jun 2020 15:34:09 +0200 (CEST)
Date:   Mon, 15 Jun 2020 15:34:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org
Subject: Re: [PATCH 1/6] sched: Fix ttwu_queue_cond()
Message-ID: <20200615133409.GS2531@hirez.programming.kicks-ass.net>
References: <20200615125654.678940605@infradead.org>
 <20200615131143.130326165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615131143.130326165@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 02:56:55PM +0200, Peter Zijlstra wrote:
> Where the condition:
> 
>   !cpus_share_cache(smp_processor_id(), cpu)
> 
> already implies 'cpu != smp_processor_id()', because a CPU always
> shares cache with itself, the secondary condition added in commit:
> 
>   2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> 
> voids that implication, resulting in attempting to do local wake-ups
> through the queue mechanism.
> 
> Fixes: 2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/sched/core.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2356,11 +2356,22 @@ bool cpus_share_cache(int this_cpu, int
>  
>  static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>  {
> +	int this_cpu = smp_processor_id();
> +
> +	/*
> +	 * Only ever queue for remote wakeups. The on_cpu case can only ever
> +	 * happen remotely, and for the normal case it makes no sense to

The 'funny' thing here is, that this must be false for this patch to
make any difference.. I just cannot see how.

Also, if this is false, and p->on_cpu == 1 and p->cpu == this_cpu, then
p _should_ be current, in which case we should never get here either,
due to the 'p == current' special case in try_to_wake_up().

The only other option is that 'p == next', but then we'd be doing
wakeups from the middle of __schedule() and seems 'unlikely' too, esp.
so since none of the actual stack-traces we have shows that.

So colour me terribly confused.

> +	 * involve IPIs here, and would be broken, as many architectures cannot
> +	 * trivially IPI self in any case.
> +	 */
> +	if (cpu == this_cpu)
> +		return false;
