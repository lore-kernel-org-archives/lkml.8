Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D372FC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A586E20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCTNo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:44:58 -0400
Received: from foss.arm.com ([217.140.110.172]:49174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgCTNo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:44:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F09F11FB;
        Fri, 20 Mar 2020 06:44:57 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D38743F85E;
        Fri, 20 Mar 2020 06:44:56 -0700 (PDT)
Subject: Re: [PATCH] sched: Remove unused last_load_update_tick rq member
To:     vincent.donnefort@arm.com, mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1584710495-308969-1-git-send-email-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e400d0b1-173f-bcfd-40c0-2e473e14e7ae@arm.com>
Date:   Fri, 20 Mar 2020 14:44:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1584710495-308969-1-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Vincent Guittot

On 20.03.20 14:21, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> The commit 5e83eafbfd3b ("sched/fair: Remove the rq->cpu_load[] update
> code") eliminated the use case for rq->last_load_update_tick. Removing
> it.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1a9983d..c41ee26 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6685,7 +6685,6 @@ void __init sched_init(void)
>  
>  		rq_attach_root(rq, &def_root_domain);
>  #ifdef CONFIG_NO_HZ_COMMON
> -		rq->last_load_update_tick = jiffies;
>  		rq->last_blocked_load_update_tick = jiffies;
>  		atomic_set(&rq->nohz_flags, 0);
>  #endif
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 9ea6478..6e14fad 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -860,7 +860,6 @@ struct rq {
>  #endif
>  #ifdef CONFIG_NO_HZ_COMMON
>  #ifdef CONFIG_SMP
> -	unsigned long		last_load_update_tick;
>  	unsigned long		last_blocked_load_update_tick;
>  	unsigned int		has_blocked_load;
>  #endif /* CONFIG_SMP */

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
