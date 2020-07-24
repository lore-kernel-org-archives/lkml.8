Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754A7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5800A2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgGXKuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:50:12 -0400
Received: from foss.arm.com ([217.140.110.172]:60134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgGXKuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:50:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA5830E;
        Fri, 24 Jul 2020 03:50:11 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A6B3F66E;
        Fri, 24 Jul 2020 03:50:09 -0700 (PDT)
Date:   Fri, 24 Jul 2020 11:50:07 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Doug Anderson <dianders@chromium.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] sched/uclamp: Fix a deadlock when enabling uclamp
 static key
Message-ID: <20200724105006.g42lu4a4g6pvusl4@e107158-lin.cambridge.arm.com>
References: <20200716110347.19553-1-qais.yousef@arm.com>
 <20200716110347.19553-4-qais.yousef@arm.com>
 <20200724091244.GX10769@hirez.programming.kicks-ass.net>
 <20200724094650.hgya5j7i7lbhrocy@e107158-lin.cambridge.arm.com>
 <20200724104120.GY10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724104120.GY10769@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/20 12:41, Peter Zijlstra wrote:
> On Fri, Jul 24, 2020 at 10:46:50AM +0100, Qais Yousef wrote:
> > On 07/24/20 11:12, Peter Zijlstra wrote:
> > > On Thu, Jul 16, 2020 at 12:03:47PM +0100, Qais Yousef wrote:
> > > 
> > > I've trimmed the Changelog to read like:
> > 
> > +1
> > 
> > Should we mention the ordering issue too? Or maybe I misinterpreted the
> > 'Possible unsafe locking scenario' part?
> 
> The lock inversion was, imo, secondary. It only existed because of the
> impossible lock ordering -- taking a blocking lock inside an atomic
> lock. Fixing the first, avoids the second etc.. So I left it out.
> 
> > This should work, but you'll need to sprinkle ifdef around the key. Or move it
> > to uclamp_validate()
> 
> Indeed, the patch now reads like:

Maybe s/deadlock/splat/ in the subject now? I clearly focused on the secondary
thing..

Sorry you had to modify the patch that much yourself.

Thanks!

--
Qais Yousef

> 
> ---
> Subject: sched/uclamp: Fix a deadlock when enabling uclamp static key
> From: Qais Yousef <qais.yousef@arm.com>
> Date: Thu, 16 Jul 2020 12:03:47 +0100
> 
> From: Qais Yousef <qais.yousef@arm.com>
> 
> The following splat was caught when setting uclamp value of a task:
> 
>   BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
> 
>    cpus_read_lock+0x68/0x130
>    static_key_enable+0x1c/0x38
>    __sched_setscheduler+0x900/0xad8
> 
> Fix by ensuring we enable the key outside of the critical section in
> __sched_setscheduler()
> 
> Fixes: 46609ce22703 ("sched/uclamp: Protect uclamp fast path code with static key")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200716110347.19553-4-qais.yousef@arm.com
> ---
>  kernel/sched/core.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1252,6 +1252,15 @@ static int uclamp_validate(struct task_s
>  	if (upper_bound > SCHED_CAPACITY_SCALE)
>  		return -EINVAL;
>  
> +	/*
> +	 * We have valid uclamp attributes; make sure uclamp is enabled.
> +	 *
> +	 * We need to do that here, because enabling static branches is a
> +	 * blocking operation which obviously cannot be done while holding
> +	 * scheduler locks.
> +	 */
> +	static_branch_enable(&sched_uclamp_used);
> +
>  	return 0;
>  }
>  
> @@ -1282,8 +1291,6 @@ static void __setscheduler_uclamp(struct
>  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>  		return;
>  
> -	static_branch_enable(&sched_uclamp_used);
> -
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>  			      attr->sched_util_min, true);
