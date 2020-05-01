Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BABC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC87208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgEALDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:03:06 -0400
Received: from foss.arm.com ([217.140.110.172]:38702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbgEALDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:03:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F26EA30E;
        Fri,  1 May 2020 04:03:04 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7E213F73D;
        Fri,  1 May 2020 04:03:02 -0700 (PDT)
Date:   Fri, 1 May 2020 12:03:00 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200501110259.336krt63sqmc4y2l@e107158-lin.cambridge.arm.com>
References: <20200428164134.5588-1-qais.yousef@arm.com>
 <20200429113255.GA19464@codeaurora.org>
 <20200429123056.otyedhljlugyf5we@e107158-lin>
 <d3916860-6ee8-4d17-55ea-be5cada1302a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3916860-6ee8-4d17-55ea-be5cada1302a@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/20 20:21, Dietmar Eggemann wrote:
> On 29/04/2020 14:30, Qais Yousef wrote:
> > Hi Pavan
> > 
> > On 04/29/20 17:02, Pavan Kondeti wrote:
> >> Hi Qais,
> >>
> >> On Tue, Apr 28, 2020 at 05:41:33PM +0100, Qais Yousef wrote:
> 
> [...]
> 
> >>> @@ -907,8 +935,15 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
> >>>  static inline struct uclamp_se
> >>>  uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
> >>>  {
> >>> -	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
> >>> -	struct uclamp_se uc_max = uclamp_default[clamp_id];
> >>> +	struct uclamp_se uc_req, uc_max;
> >>> +
> >>> +	/*
> >>> +	 * Sync up any change to sysctl_sched_uclamp_util_min_rt_default value.
> >>> +	 */
> >>> +	uclamp_sync_util_min_rt_default(p);
> >>> +
> >>> +	uc_req = uclamp_tg_restrict(p, clamp_id);
> >>> +	uc_max = uclamp_default[clamp_id];
> >>
> >> We are calling uclamp_sync_util_min_rt_default() unnecessarily for
> >> clamp_id == UCLAMP_MAX case. Would it be better to have a separate
> > 
> > It was actually intentional to make sure we update the value ASAP. I didn't
> > think it's a lot of overhead. I can further protect with a check to verify
> > whether the value has changed if it seems heavy handed.
> 
> Users of uclamp_eff_value()->uclamp_eff_get() ((like
> rt_task_fits_capacity())) always call both ids.
> 
> So calling uclamp_sync_util_min_rt_default() only for UCLAMP_MIN would
> make sense. It's overhead in the fast path for rt tasks.
> 
> Since changes to sched_util_clamp_min_rt_default will be fairly rare,
> you might even want to consider only doing the uclamp_se_set(...,
> min_rt_default, ...) in case
> 
>   uc_se->value != sysctl_sched_uclamp_util_min_rt_default

Okay will do though I'm not convinced this micro optimization makes any
difference. p->uclamp_req[] is already read, so it should be cache hot.
uclamp_set_se() performs 3 writes on it, so I expect no stalls. Even if it
was a write-through cache, there's usually a write buffer that I think should
be able to hide the 3 writes. Write-through + linux is a bad idea in general.

In contrary, the complex if condition might make branch prediction less
effective, hence this micro optimization might create a negative effect.

So I don't see this a clear win and it would be hard to know without proper
measurement really. It is cheaper sometimes to always execute something than
sprinkle more branches to avoid executing this simple code.

I just realized though that I didn't define the
uclamp_sync_util_min_rt_default() as inline, which I should to avoid a function
call. Compiler *should* be smart though :p

Thanks

--
Qais Yousef
