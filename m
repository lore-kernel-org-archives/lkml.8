Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9379FC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F6F20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgCQK4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:56:39 -0400
Received: from foss.arm.com ([217.140.110.172]:35000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCQK4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:56:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35ECC1FB;
        Tue, 17 Mar 2020 03:56:35 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9F4D3F534;
        Tue, 17 Mar 2020 03:56:33 -0700 (PDT)
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
In-reply-to: <20200311202625.13629-1-daniel.lezcano@linaro.org>
Date:   Tue, 17 Mar 2020 10:56:11 +0000
Message-ID: <jhjy2rzntbo.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Daniel,

One more comment on the break even itself, ignoring the rest:

On Wed, Mar 11 2020, Daniel Lezcano wrote:
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index b743bf38f08f..3342e7bae072 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -19,7 +19,13 @@ extern char __cpuidle_text_start[], __cpuidle_text_end[];
>   */
>  void sched_idle_set_state(struct cpuidle_state *idle_state)
>  {
> -	idle_set_state(this_rq(), idle_state);
> +	struct rq *rq = this_rq();
> +
> +	idle_set_state(rq, idle_state);
> +
> +	if (idle_state)
> +		idle_set_break_even(rq, ktime_get_ns() +
> +				    idle_state->exit_latency_ns);

I'm not sure I follow why we go for entry time + exit latency. If this
is based on the minimum residency, shouldn't this be something depending
on the entry latency? i.e. something like

  break_even = now + entry_latency + idling_time
                     \_________________________/
                            min-residency

or am I missing something?

>  }
>
>  static int __read_mostly cpu_idle_force_poll;
