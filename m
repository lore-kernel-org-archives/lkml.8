Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1BDC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC2C20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCSKqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:46:25 -0400
Received: from foss.arm.com ([217.140.110.172]:33214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgCSKqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:46:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B09B31B;
        Thu, 19 Mar 2020 03:46:23 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C05B3F305;
        Thu, 19 Mar 2020 03:46:22 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 9/9] sched/topology: Define and use shortcut pointers
 for wakeup sd_flag scan
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
References: <20200311181601.18314-1-valentin.schneider@arm.com>
 <20200311181601.18314-10-valentin.schneider@arm.com>
Message-ID: <53763a32-0ce5-e267-9d5d-99e65c921d08@arm.com>
Date:   Thu, 19 Mar 2020 11:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311181601.18314-10-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.20 19:16, Valentin Schneider wrote:
> Reworking select_task_rq_fair()'s domain walk exposed that !want_affine
> wakeups only look for highest sched_domain with the required sd_flag
> set. This is something we can cache at sched domain build time to slightly
> optimize select_task_rq_fair(). Note that this isn't a "free" optimization:
> it costs us 3 pointers per CPU.
> 
> Add cached per-CPU pointers for the highest domains with SD_BALANCE_WAKE,
> SD_BALANCE_EXEC and SD_BALANCE_FORK. Use them in select_task_rq_fair().
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c     | 25 +++++++++++++------------
>  kernel/sched/sched.h    |  3 +++
>  kernel/sched/topology.c | 12 ++++++++++++
>  3 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a6fca6817e92..40fb97062157 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6595,17 +6595,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	int want_affine = 0;
>  	int sd_flag;
>  
> -	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
> -	case WF_TTWU:
> -		sd_flag = SD_BALANCE_WAKE;
> -		break;
> -	case WF_FORK:
> -		sd_flag = SD_BALANCE_FORK;
> -		break;
> -	default:
> -		sd_flag = SD_BALANCE_EXEC;
> -	}
> -
>  	if (wake_flags & WF_TTWU) {
>  		record_wakee(p);
>  
> @@ -6621,7 +6610,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  
>  	rcu_read_lock();
>  
> -	sd = highest_flag_domain(cpu, sd_flag);
> +	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
> +	case WF_TTWU:
> +		sd_flag = SD_BALANCE_WAKE;
> +		sd = rcu_dereference(per_cpu(sd_balance_wake, cpu));

IMHO, since we hard-code 0*SD_BALANCE_WAKE in sd_init(), sd would always
be NULL, so !want_affine (i.e. wake_wide()) would still go sis().

SD_BALANCE_WAKE is no a topology related sd_flag so it can't be set from
outside. Since the sd->flags sysctl is now read-only, wouldn't this case
be redundant?

[...]
