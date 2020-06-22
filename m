Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DCEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60358206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgFVJLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:11:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:34164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgFVJLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:11:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A3C013ABD;
        Mon, 22 Jun 2020 09:11:36 +0000 (UTC)
Date:   Mon, 22 Jun 2020 10:11:22 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        paulmck@kernel.org, frederic@kernel.org
Subject: Re: [PATCH 1/6] sched: Fix ttwu_queue_cond()
Message-ID: <20200622091122.GG3129@suse.de>
References: <20200615125654.678940605@infradead.org>
 <20200615131143.130326165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200615131143.130326165@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 02:56:55PM +0200, Peter Zijlstra wrote:
> Where the condition:
> 
>   !cpus_share_cache(smp_processor_id(), cpu)
> 
> already implies 'cpu != smp_processor_id()', because a CPU always
> shares cache with itself, the secondary condition added in commit:
> 
>   2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> 
> voids that implication, resulting in attempting to do local wake-ups
> through the queue mechanism.
> 
> Fixes: 2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

Yep, I mistakenly though this would be covered by the self-wakeup check
early in try_to_wake_up() but it is not

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
