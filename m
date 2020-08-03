Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D792068F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgHCHhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:37:09 -0400
Received: from foss.arm.com ([217.140.110.172]:53472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCHhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:37:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8DC3D6E;
        Mon,  3 Aug 2020 00:37:07 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A6EC3F718;
        Mon,  3 Aug 2020 00:37:01 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/fair: Fix the logic about active_balance in
 load_balance()
To:     Qi Zheng <arch0.zheng@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
References: <20200802045141.130533-1-arch0.zheng@gmail.com>
Message-ID: <c9afe264-d453-1676-77c9-b29db3481107@arm.com>
Date:   Mon, 3 Aug 2020 09:36:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802045141.130533-1-arch0.zheng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2020 06:51, Qi Zheng wrote:
> I think the unbalance scenario here should be that we need to
> do active balance but it is not actually done. So fix it.
> 
> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2ba8f230feb9..6d8c53718b67 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9710,7 +9710,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  	} else
>  		sd->nr_balance_failed = 0;
>  
> -	if (likely(!active_balance) || voluntary_active_balance(&env)) {
> +	if (likely(!active_balance) && voluntary_active_balance(&env)) {
>  		/* We were unbalanced, so reset the balancing interval */
>  		sd->balance_interval = sd->min_interval;
>  	} else {
> 

Active balance is potentially already been done when we reach this code.

See 'if (need_active_balance(&env))' and 'if (!busiest->active_balance)'
further up.

Here we only reset sd->balance_interval in case:
(A) the last load balance wasn't an active one
(B) the reason for the active load balance was:
    (1) asym packing
    (2) capacity of src_cpu is reduced compared to the one of dst_cpu
    (3) misfit handling

(B) is done to not unnecessarily increase of balance interval, see
commit 46a745d90585 ("sched/fair: Fix unnecessary increase of balance
interval").
