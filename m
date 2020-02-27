Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E134C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83D024691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582832499;
	bh=k6N5oj36ZlppU4GOSyWAfOkeWWTZ5QFedDz1m1O+qSc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hBUqBId/v0XbERdmPlRG77wl6dp8F7Cv//UAHi3gurHzzSuFiEkc7q3iRvXX8e+1N
	 VzrmyRgdmUR7DfoRavXBc5sLyirmHMatQmjzfax9xSfvI22NVjboOLQiSA8TBTT1a4
	 qpQSN2Cz2YZA8U8hC3MgjpJWCVh9gR2KHKETSLzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgB0Tli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgB0Tli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:41:38 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABCE624690;
        Thu, 27 Feb 2020 19:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582832497;
        bh=k6N5oj36ZlppU4GOSyWAfOkeWWTZ5QFedDz1m1O+qSc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AqqDzSsSDHGCz710MPcIRq3W/0Vye8JiMnVtwZ/PDVo2C7hCCIc4eUTfhKmAFHwwe
         YBX6iY/vLgy7eqOi46xmxco2A309xzT6ZFlU6OZD8kgbYyDlTLcMsOH6oKRYCIIGDu
         z8icQmyH6CE5aPGAuPUt87EieYI5kotVYFCj4tBU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3217335211EA; Thu, 27 Feb 2020 11:41:37 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:41:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>, Qian Cai <cai@lca.pw>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/numa: Acquire RCU lock for checking idle cores
 during NUMA balancing
Message-ID: <20200227194137.GO2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200227191804.GJ3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227191804.GJ3818@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:18:04PM +0000, Mel Gorman wrote:
> Qian Cai reported the following
> 
>   The linux-next commit ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a
>   migration target instead of comparing tasks") introduced a boot warning,
> 
>   [   86.520534][    T1] WARNING: suspicious RCU usage
>   [   86.520540][    T1] 5.6.0-rc3-next-20200227 #7 Not tainted
>   [   86.520545][    T1] -----------------------------
>   [   86.520551][    T1] kernel/sched/fair.c:5914 suspicious rcu_dereference_check() usage!
>   [   86.520555][    T1]
>   [   86.520555][    T1] other info that might help us debug this:
>   [   86.520555][    T1]
>   [   86.520561][    T1]
>   [   86.520561][    T1] rcu_scheduler_active = 2, debug_locks = 1
>   [   86.520567][    T1] 1 lock held by systemd/1:
>   [   86.520571][    T1]  #0: ffff8887f4b14848 (&mm->mmap_sem#2){++++}, at: do_page_fault+0x1d2/0x998
>   [   86.520594][    T1]
>   [   86.520594][    T1] stack backtrace:
>   [   86.520602][    T1] CPU: 1 PID: 1 Comm: systemd Not tainted 5.6.0-rc3-next-20200227 #7
> 
> task_numa_migrate() checks for idle cores when updating NUMA-related statistics.
> This relies on reading a RCU-protected structure in test_idle_cores() via this
> call chain
> 
> task_numa_migrate
>   -> update_numa_stats
>     -> numa_idle_core
>       -> test_idle_cores
> 
> While the locking could be fine-grained, it is more appropriate to acquire
> the RCU lock for the entire scan of the domain. This patch removes the
> warning triggered at boot time.
> 
> Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

From an RCU viewpoint:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 10f9e6729fcf..1592b6d26239 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1595,6 +1595,7 @@ static void update_numa_stats(struct task_numa_env *env,
>  	memset(ns, 0, sizeof(*ns));
>  	ns->idle_cpu = -1;
>  
> +	rcu_read_lock();
>  	for_each_cpu(cpu, cpumask_of_node(nid)) {
>  		struct rq *rq = cpu_rq(cpu);
>  
> @@ -1614,6 +1615,7 @@ static void update_numa_stats(struct task_numa_env *env,
>  			idle_core = numa_idle_core(idle_core, cpu);
>  		}
>  	}
> +	rcu_read_unlock();
>  
>  	ns->weight = cpumask_weight(cpumask_of_node(nid));
>  
