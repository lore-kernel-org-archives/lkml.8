Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE9EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2533A20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBGVoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:44:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36341 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgBGVoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:44:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so878107ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 13:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EOAH8ECFFZIEB14xaWnDlsgAybajvshaGmxwPNViUdI=;
        b=gCZa6GL2weSliSIKnpmwXrvkAsPVTlPfU2+W5v0zl4ZfitoxP0ZpPQdfE3zJ3jGRKO
         zVWUSHrZXInBXuQD/s6FtV/dMN/yhWYouyJ7utzrBzawQm8idfnhpzt0bWbgrAsEsLmq
         1Bh3kL4fX4aCdglyoqJuysfynAsZAw4MwWIHNGWV2gqbUW4QbdEoKrvVe48qVHG5ICFd
         GD3F6p7vgkyShD7utZ9fDbbrGdwuAK+2/gBmJuWM305ebRSTt3wYVcW+eLwKoiV2/rTv
         PclLSwW17hGItjZWkNL5NHn7VBMfB/uKhfERCFiIqv3ZkBbdvWdB/YYnZ86DTQYf0tzS
         XPPA==
X-Gm-Message-State: APjAAAV46scMiNbMuuJmQShE01YaQolFhJO/5SB41NwEC4tVDYNxQUiE
        jVz3GNbNWRPjtG0Fp1haMy0=
X-Google-Smtp-Source: APXvYqyqRay1JzqMue8324zWvBlZn36Bsx+1SbzjrClNU7YQnI+1xBtVh0bRWRxldia5Ejj6Q3ETKQ==
X-Received: by 2002:a2e:8651:: with SMTP id i17mr748079ljj.121.1581111859511;
        Fri, 07 Feb 2020 13:44:19 -0800 (PST)
Received: from [192.168.1.184] (128-68-70-109.broadband.corbina.ru. [128.68.70.109])
        by smtp.gmail.com with ESMTPSA id a28sm1606557lfg.86.2020.02.07.13.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 13:44:18 -0800 (PST)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH 1/1] timer: Improve the comment describing
 schedule_timeout()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     notify@kernel.org
References: <20200117225900.16340-1-alex.popov@linux.com>
From:   Alexander Popov <alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 j3lCqPk=
Message-ID: <5754e3ba-bb3c-fcce-132b-3b080c4cdc28@linux.com>
Date:   Sat, 8 Feb 2020 00:44:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117225900.16340-1-alex.popov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!
Could I have any feedback for this patch?
Thanks!

On 18.01.2020 01:59, Alexander Popov wrote:
> When we were preparing the patch 6dcd5d7a7a29c1e, we made a mistake noticed
> by Linus: schedule_timeout() was called without setting the task state to
> anything particular. It calls the scheduler, but doesn't delay anything,
> because the task stays runnable. That happens because sched_submit_work()
> does nothing for tasks in TASK_RUNNING state.
> 
> That turned out to be the intended behavior. Adding a WARN() is not useful.
> Let's improve the comment about schedule_timeout() and describe that
> more explicitly.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  kernel/time/timer.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 4820823515e9..cb34fac9d9f7 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1828,21 +1828,23 @@ static void process_timeout(struct timer_list *t)
>   * schedule_timeout - sleep until timeout
>   * @timeout: timeout value in jiffies
>   *
> - * Make the current task sleep until @timeout jiffies have
> - * elapsed. The routine will return immediately unless
> - * the current task state has been set (see set_current_state()).
> + * Make the current task sleep until @timeout jiffies have elapsed.
> + * The function behavior depends on the current task state
> + * (see also set_current_state() description):
>   *
> - * You can set the task state as follows -
> + * %TASK_RUNNING - the scheduler is called, but the task does not sleep
> + * at all. That happens because sched_submit_work() does nothing for
> + * tasks in %TASK_RUNNING state.
>   *
>   * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
>   * pass before the routine returns unless the current task is explicitly
> - * woken up, (e.g. by wake_up_process())".
> + * woken up, (e.g. by wake_up_process()).
>   *
>   * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
>   * delivered to the current task or the current task is explicitly woken
>   * up.
>   *
> - * The current task state is guaranteed to be TASK_RUNNING when this
> + * The current task state is guaranteed to be %TASK_RUNNING when this
>   * routine returns.
>   *
>   * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
> @@ -1850,7 +1852,7 @@ static void process_timeout(struct timer_list *t)
>   * value will be %MAX_SCHEDULE_TIMEOUT.
>   *
>   * Returns 0 when the timer has expired otherwise the remaining time in
> - * jiffies will be returned.  In all cases the return value is guaranteed
> + * jiffies will be returned. In all cases the return value is guaranteed
>   * to be non-negative.
>   */
>  signed long __sched schedule_timeout(signed long timeout)
> 

