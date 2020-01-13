Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CBBC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F402D22314
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbgAMAdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:33:17 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57771 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbgAMAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 19:33:17 -0500
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00D0XE7i088571;
        Mon, 13 Jan 2020 09:33:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Mon, 13 Jan 2020 09:33:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00D0X8lX088530
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 13 Jan 2020 09:33:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] sched/core: fix illegal RCU from offline CPUs
To:     Qian Cai <cai@lca.pw>, peterz@infradead.org, mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200112161752.10492-1-cai@lca.pw>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <3ffaaf32-88b6-fdf1-c7c7-ab56292c047f@I-love.SAKURA.ne.jp>
Date:   Mon, 13 Jan 2020 09:33:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200112161752.10492-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/01/13 1:17, Qian Cai wrote:
> In the CPU-offline process, it calls mmdrop() after idle entry and the
> subsequent call to cpuhp_report_idle_dead(). Once execution passes the
> call to rcu_report_dead(), RCU is ignoring the CPU, which results in
> lockdep complaints when mmdrop() uses RCU from either memcg or
> debugobjects. Fix it by scheduling mmdrop() on another online CPU.
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 90e4b00ace89..41fb49f3dfce 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6194,7 +6194,8 @@ void idle_task_exit(void)
>  		current->active_mm = &init_mm;
>  		finish_arch_post_lock_switch();
>  	}
> -	mmdrop(mm);
> +	smp_call_function_single(cpumask_first(cpu_online_mask),
> +				(void (*)(void *))mmdrop, mm, 0);

mmdrop() might sleep, but

/*
 * smp_call_function_single - Run a function on a specific CPU
 * @func: The function to run. This must be fast and non-blocking.
 * @info: An arbitrary pointer to pass to the function.
 * @wait: If true, wait until function has completed on other CPUs.
 *
 * Returns 0 on success, else a negative status code.
 */

. Maybe mmdrop_async() instead?
