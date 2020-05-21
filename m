Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFFBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1504E20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590101524;
	bh=0cgjxbgdf1dAlWpOp4qiOnxKy9uvXiWwlhLg2SV0Qzw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=1Wb1dcZjA480lFLxW+o3Ljk79gY3wDMBgL2PlyWokU8YVGnE4E1323nNFjPtFw9vo
	 k8ABt3STwtgyq5doBbicAC0ymeH7QVH4/+12/YCNyS9Uwbu6RMX3jGb7Pl39+z/HpE
	 azYQNRQ5ngNeWGP0007CsP8pQv7pM0SqlkFGnVsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgEUWwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgEUWwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:52:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F1A820814;
        Thu, 21 May 2020 22:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590101522;
        bh=0cgjxbgdf1dAlWpOp4qiOnxKy9uvXiWwlhLg2SV0Qzw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XdgKGyhvjEg8urysaMMMP921Tr+50/lWKCda8lBBzMe2avEykhyHSOIqm/qdyRYym
         BrAUz0e3cHXsdUM1X7I/hcI66rBKUpGI0lYuZMUQJhv7OHDcy7G42ZiMe+eK0G/5F3
         n3kmqkVvxlqd/X6fHUzZtM6qctBDu/qdx5NSldjQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 861C93522FEB; Thu, 21 May 2020 15:52:02 -0700 (PDT)
Date:   Thu, 21 May 2020 15:52:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH RFC] sched: Use sched-RCU in core-scheduling balancing
 logic
Message-ID: <20200521225202.GD2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520224818.78930-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520224818.78930-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:48:18PM -0400, Joel Fernandes (Google) wrote:
> rcu_read_unlock() can incur an infrequent deadlock in
> sched_core_balance(). Fix this by using sched-RCU instead.
> 
> This fixes the following spinlock recursion observed when testing the
> core scheduling patches on PREEMPT=y kernel on ChromeOS:
> 
> [    3.240891] BUG: spinlock recursion on CPU#2, swapper/2/0
> [    3.240900]  lock: 0xffff9cd1eeb28e40, .magic: dead4ead, .owner: swapper/2/0, .owner_cpu: 2
> [    3.240905] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.4.22htcore #4
> [    3.240908] Hardware name: Google Eve/Eve, BIOS Google_Eve.9584.174.0 05/29/2018
> [    3.240910] Call Trace:
> [    3.240919]  dump_stack+0x97/0xdb
> [    3.240924]  ? spin_bug+0xa4/0xb1
> [    3.240927]  do_raw_spin_lock+0x79/0x98
> [    3.240931]  try_to_wake_up+0x367/0x61b
> [    3.240935]  rcu_read_unlock_special+0xde/0x169
> [    3.240938]  ? sched_core_balance+0xd9/0x11e
> [    3.240941]  __rcu_read_unlock+0x48/0x4a
> [    3.240945]  __balance_callback+0x50/0xa1
> [    3.240949]  __schedule+0x55a/0x61e
> [    3.240952]  schedule_idle+0x21/0x2d
> [    3.240956]  do_idle+0x1d5/0x1f8
> [    3.240960]  cpu_startup_entry+0x1d/0x1f
> [    3.240964]  start_secondary+0x159/0x174
> [    3.240967]  secondary_startup_64+0xa4/0xb0
> [   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]
> 
> Cc: vpillai <vpillai@digitalocean.com>
> Cc: Aaron Lu <aaron.lwe@gmail.com>
> Cc: Aubrey Li <aubrey.intel@gmail.com>
> Cc: peterz@infradead.org
> Cc: paulmck@kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Change-Id: I1a4bf0cd1426b3c21ad5de44719813ad4ee5805e

With some luck, the commit removing the need for this will hit
mainline during the next merge window.  Fingers firmly crossed...

						Thanx, Paul

> ---
>  kernel/sched/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 780514d03da47..b8ca6fcaaaf06 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4897,7 +4897,7 @@ static void sched_core_balance(struct rq *rq)
>  	struct sched_domain *sd;
>  	int cpu = cpu_of(rq);
>  
> -	rcu_read_lock();
> +	rcu_read_lock_sched();
>  	raw_spin_unlock_irq(rq_lockp(rq));
>  	for_each_domain(cpu, sd) {
>  		if (!(sd->flags & SD_LOAD_BALANCE))
> @@ -4910,7 +4910,7 @@ static void sched_core_balance(struct rq *rq)
>  			break;
>  	}
>  	raw_spin_lock_irq(rq_lockp(rq));
> -	rcu_read_unlock();
> +	rcu_read_unlock_sched();
>  }
>  
>  static DEFINE_PER_CPU(struct callback_head, core_balance_head);
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 
