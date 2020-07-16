Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE96C433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C91212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O31CALac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGPXJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgGPXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:08:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85063C08C5F7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1qAKoes74GlZe9USKnILAIURyyddaWhdldrIzkY97zA=; b=O31CALaczkJRmTQNtptd/MMXuw
        pAcvdqEjSDstR7JSBMD1BOY3DTjhIOU2R9Kw+ni+BoR/m51yAT6snWjFNiZApQGbq5vbRi8tWwGbC
        GeTY42Wv4CT90bKpF8MYtwoxXhvCuJIj4gkjpXG8N9XVQokVN875seOYSkK5q82hQkHocOO05HMqs
        ZZ1B7Wf5S0qEb04jVWtk68w8DO3E+ZSDv8IKouRaouslYSknkvfwZA03x6+sdQ1A6wB1D1CpPwFoE
        TZdEk9kCxoBIiA1IrnE4vsLVpWABDXlaBdRyCo6XYBBiM6eujfeIxKAnbWe43TJvUYKDf8SoPQuAX
        jjKziztQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwCi9-0003qZ-RV; Thu, 16 Jul 2020 22:50:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ED2F9817E0; Fri, 17 Jul 2020 00:50:34 +0200 (CEST)
Date:   Fri, 17 Jul 2020 00:50:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer
 timer handling to task_work
Message-ID: <20200716225034.GK5523@worktop.programming.kicks-ass.net>
References: <20200716201923.228696399@linutronix.de>
 <20200716202044.734067877@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716202044.734067877@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:19:26PM +0200, Thomas Gleixner wrote:

> @@ -1096,6 +1099,12 @@ static void __run_posix_cpu_timers(struc
>  	check_process_timers(tsk, &firing);
>  
>  	/*
> +	 * Allow new work to be scheduled. The expiry cache
> +	 * is up to date.
> +	 */
> +	posix_cpu_timers_enable_work(tsk);
> +
> +	/*
>  	 * We must release these locks before taking any timer's lock.
>  	 * There is a potential race with timer deletion here, as the
>  	 * siglock now protects our private firing list.  We have set

I think I would feel more comfortable if this was done at the very
beginning of that function, possibly even with:

> +static void __run_posix_cpu_timers(struct task_struct *tsk)
> +{
> +	struct posix_cputimers *pct = &tsk->posix_cputimers;
> +
> +	if (!test_and_set_bit(CPUTIMERS_WORK_SCHEDULED, &pct->flags))
> +		task_work_add(tsk, &pct->task_work, true);
> +}
> +
> +static inline void posix_cpu_timers_enable_work(struct task_struct *tsk)
> +{
> +	clear_bit(CPUTIMERS_WORK_SCHEDULED, &tsk->posix_cputimers.flags);
	/*
	 * Ensure we observe everything before a failing test_and_set()
	 * in __run_posix_cpu_timers().
	 */
	smp_mb__after_atomic();
> +}

Such that when another timer interrupt happens while we run this, we're
guaranteed to either see it, or get re-queued and thus re-run the
function.
