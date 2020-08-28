Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC8C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C922207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 21:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UFLpHquk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgH1V0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1V0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 17:26:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8407FC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lFwnOAOwVQrLQAFvcv4Oug1mxlMMRvjAZ3gCwjdeiHg=; b=UFLpHqukM7IqThVL2pMDfUwEl0
        SHzNa3mMiYYBGHvi29viUO7r52p7DCv4rAZ6zuP2i20bkCnoMhFQOXZJZBTCuJp94zuoDxaSlmVTp
        puH/vYtADNQ2ExnjW+YMESwH8oUIMij0ZnUi6ViRTe4mFEvrUOlJO/qGu6As3nvVJZ/VJkdvCMJIc
        CeUj+oKUCHDL0+XYqMIWI9hatRdfWOVlvhIPib72K2fYpBwVB/84kqP4eDt8LQFX0JdO/U0NGgjqZ
        oRcnj4bw6/Pshs9bYDyj7DadsXVjCIWPLddxsefijO1ZJMhHtJUZkl6uiqVmgnFKRRhqgUevtjv0w
        XGeN4s9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBlsi-0004Nh-1X; Fri, 28 Aug 2020 21:25:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56BE7980D81; Fri, 28 Aug 2020 23:25:54 +0200 (CEST)
Date:   Fri, 28 Aug 2020 23:25:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: Re: [RFC PATCH v7 09/23] sched/fair: Fix forced idle sibling
 starvation corner case
Message-ID: <20200828212554.GD29142@worktop.programming.kicks-ass.net>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <7d50f038cef452c78213b7c513a98b3286476701.1598643276.git.jdesfossez@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d50f038cef452c78213b7c513a98b3286476701.1598643276.git.jdesfossez@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:51:10PM -0400, Julien Desfossez wrote:
> +/*
> + * If runqueue has only one task which used up its slice and if the sibling
> + * is forced idle, then trigger schedule to give forced idle task a chance.
> + */
> +static void resched_forceidle_sibling(struct rq *rq, struct sched_entity *se)
> +{
> +	int cpu = cpu_of(rq), sibling_cpu;
> +
> +	if (rq->cfs.nr_running > 1 || !__entity_slice_used(se))
> +		return;
> +
> +	for_each_cpu(sibling_cpu, cpu_smt_mask(cpu)) {
> +		struct rq *sibling_rq;
> +		if (sibling_cpu == cpu)
> +			continue;
> +		if (cpu_is_offline(sibling_cpu))
> +			continue;
> +
> +		sibling_rq = cpu_rq(sibling_cpu);
> +		if (sibling_rq->core_forceidle) {
> +			resched_curr(sibling_rq);
> +		}
> +	}

The only pupose of this loop seem to be to find if we have a forceidle;
surely we can avoid that by storing this during the pick.

> +}

static void task_tick_core(struct rq *rq)
{
	if (sched_core_enabled(rq))
		resched_forceidle_sibling(rq, &rq->curr->se);
}

#else

static void task_tick_core(struct rq *rq) { }

> +#endif
> +
>  /*
>   * scheduler tick hitting a task of our scheduling class.
>   *
> @@ -10654,6 +10688,11 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  
>  	update_misfit_status(curr, rq);
>  	update_overutilized_status(task_rq(curr));
> +
> +#ifdef CONFIG_SCHED_CORE
> +	if (sched_core_enabled(rq))
> +		resched_forceidle_sibling(rq, &curr->se);
> +#endif

Then you can ditch the #ifdef here

>  }
>  
>  /*
> -- 
> 2.17.1
> 
