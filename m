Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2850C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0C62465A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgAPDqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:46:05 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52832 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728905AbgAPDqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:46:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TnrK-DZ_1579146361;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnrK-DZ_1579146361)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jan 2020 11:46:02 +0800
Subject: Re: [PATCH] sched/cputime: remove irqtime_account_idle_ticks
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <1579144650-161327-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <5c95e93d-c44c-b19e-62c0-b7c45c60e9e0@linux.alibaba.com>
Date:   Thu, 16 Jan 2020 11:44:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579144650-161327-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/1/16 ÉÏÎç11:17, Alex Shi Ð´µÀ:
> irqtime_account_idle_ticks just add longer call path w/o enough meaning.
> We don't bother remove this function to simply code and reduce a
> bit object size of kernel.

Sorry, above commit log need to revise as following:

irqtime_account_idle_ticks just add longer call path w/o enough meaning.
We'd better to remove this function to simply code and reduce a bit object
size of kernel.

> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Peter Zijlstra <peterz@infradead.org> 
> Cc: Juri Lelli <juri.lelli@redhat.com> 
> Cc: Vincent Guittot <vincent.guittot@linaro.org> 
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com> 
> Cc: Steven Rostedt <rostedt@goodmis.org> 
> Cc: Ben Segall <bsegall@google.com> 
> Cc: Mel Gorman <mgorman@suse.de> 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  kernel/sched/cputime.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index cff3e656566d..17640d145e44 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -390,12 +390,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
>  	}
>  }
>  
> -static void irqtime_account_idle_ticks(int ticks)
> -{
> -	irqtime_account_process_tick(current, 0, ticks);
> -}
>  #else /* CONFIG_IRQ_TIME_ACCOUNTING */
> -static inline void irqtime_account_idle_ticks(int ticks) { }
>  static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
>  						int nr_ticks) { }
>  #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
> @@ -505,7 +500,7 @@ void account_idle_ticks(unsigned long ticks)
>  	u64 cputime, steal;
>  
>  	if (sched_clock_irqtime) {
> -		irqtime_account_idle_ticks(ticks);
> +		irqtime_account_process_tick(current, 0, ticks);
>  		return;
>  	}
>  
> 
