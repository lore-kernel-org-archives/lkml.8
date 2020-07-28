Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7614C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E702074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgG1J2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:28:11 -0400
Received: from foss.arm.com ([217.140.110.172]:59398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgG1J2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:28:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD0830E;
        Tue, 28 Jul 2020 02:28:10 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D6EE3F66E;
        Tue, 28 Jul 2020 02:28:08 -0700 (PDT)
Subject: Re: [PATCH] sched: loadavg: delete useless param ticks for
 calc_global_load
To:     Wang Wenhu <wenhu.wang@vivo.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <20200728085809.60132-1-wenhu.wang@vivo.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <940ac672-8fed-66f0-c37a-87f9ed2c5dd4@arm.com>
Date:   Tue, 28 Jul 2020 11:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728085809.60132-1-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2020 10:58, Wang Wenhu wrote:
> The only parameter "unsigned long ticks" for calc_global_load is
> never used inside the function definition. Delete it now.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
>  include/linux/sched/loadavg.h | 2 +-
>  kernel/sched/loadavg.c        | 2 +-
>  kernel/time/timekeeping.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/loadavg.h b/include/linux/sched/loadavg.h
> index 4859bea47a7b..83ec54b65e79 100644
> --- a/include/linux/sched/loadavg.h
> +++ b/include/linux/sched/loadavg.h
> @@ -43,6 +43,6 @@ extern unsigned long calc_load_n(unsigned long load, unsigned long exp,
>  #define LOAD_INT(x) ((x) >> FSHIFT)
>  #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
>  
> -extern void calc_global_load(unsigned long ticks);
> +extern void calc_global_load(void);
>  
>  #endif /* _LINUX_SCHED_LOADAVG_H */
> diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
> index de22da666ac7..d2a655643a02 100644
> --- a/kernel/sched/loadavg.c
> +++ b/kernel/sched/loadavg.c
> @@ -347,7 +347,7 @@ static inline void calc_global_nohz(void) { }
>   *
>   * Called from the global timer code.
>   */
> -void calc_global_load(unsigned long ticks)
> +void calc_global_load(void)
>  {
>  	unsigned long sample_window;
>  	long active, delta;
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index d20d489841c8..63a632f9896c 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2193,7 +2193,7 @@ EXPORT_SYMBOL(ktime_get_coarse_ts64);
>  void do_timer(unsigned long ticks)
>  {
>  	jiffies_64 += ticks;
> -	calc_global_load(ticks);
> +	calc_global_load();
>  }
>  
>  /**

There is already commit 46132e3ac58c ("sched: nohz: stop passing around
unused "ticks" parameter.") in linux-next master.
