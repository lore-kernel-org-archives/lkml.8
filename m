Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B071AC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1C0206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506151AbgDPLHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:07:34 -0400
Received: from foss.arm.com ([217.140.110.172]:58872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506009AbgDPLDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:03:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5631A113E;
        Thu, 16 Apr 2020 04:03:20 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9587E3F73D;
        Thu, 16 Apr 2020 04:03:17 -0700 (PDT)
Subject: Re: [PATCH v2] sched/core: Fix reset-on-fork from RT with uclamp
To:     Quentin Perret <qperret@google.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        ctheegal@codeaurora.org, dianders@chromium.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20200416085956.217587-1-qperret@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cf82cb73-b837-2365-9178-d56589c3ad44@arm.com>
Date:   Thu, 16 Apr 2020 13:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200416085956.217587-1-qperret@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.20 10:59, Quentin Perret wrote:
> uclamp_fork() resets the uclamp values to their default when the
> reset-on-fork flag is set. It also checks whether the task has a RT
> policy, and sets its uclamp.min to 1024 accordingly. However, during
> reset-on-fork, the task's policy is lowered to SCHED_NORMAL right after,
> hence leading to an erroneous uclamp.min setting for the new task if it
> was forked from RT.
> 
> Fix this by removing the unnecessary check on rt_task() in
> uclamp_fork() as this doesn't make sense if the reset-on-fork flag is
> set.
> 
> Fixes: 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks")
> Reported-by: Chitti Babu Theegala <ctheegal@codeaurora.org>
> Reviewed-by: Patrick Bellasi <patrick.bellasi@matbug.net>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
> Changes in v2:
>  - Added missing 'Fixes:' tag (Patrick)
>  - Removed unnecessary local variable (Doug, Patrick)
> ---
>  kernel/sched/core.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..9a2fbf98fd6f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1232,13 +1232,8 @@ static void uclamp_fork(struct task_struct *p)
>  		return;
>  
>  	for_each_clamp_id(clamp_id) {
> -		unsigned int clamp_value = uclamp_none(clamp_id);
> -
> -		/* By default, RT tasks always get 100% boost */
> -		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			clamp_value = uclamp_none(UCLAMP_MAX);
> -
> -		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
> +		uclamp_se_set(&p->uclamp_req[clamp_id],
> +			      uclamp_none(clamp_id), false);
>  	}
>  }

LGTM.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
