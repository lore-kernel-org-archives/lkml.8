Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA7C3402F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6E920801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581981836;
	bh=sDfs6Rya63GdiVLCpdtRhuNERReZPePVMOMqKNqMLQk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ukLbKR3RStsamY1mzF7rKaGQnKib5yvYpR0m46ZCZG5xkLB2mykYfHtrSM+A41LL2
	 PSU88mkt5bv+iVSsT49F5Xyov2cnIwrlIVaOJV21xbgQ7ZqOOAf4I9iyh//GZ6n5Cm
	 ybv0ppjSATfidRoXZ3MnYNUjFyyQ2IMzSwsjGJhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgBQXXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgBQXXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:23:54 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E700206E2;
        Mon, 17 Feb 2020 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581981834;
        bh=sDfs6Rya63GdiVLCpdtRhuNERReZPePVMOMqKNqMLQk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gMn9FqcahSPeHf8pBojukyalgPQiSj6YPALVPUvP+FkwBTV/S1qvTc9/MMZQSgU+5
         MTJ1bOgIKe8F4Q2DXeQ6VFhWKmD1qGzOLWXXE1Ptu87xSn6xmoULKXCDZjVOBsx8gH
         dhevFiCTBPPXHwcAi7z+G9ARMotG9D9LLkOJdWgo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F40C035227A8; Mon, 17 Feb 2020 15:23:53 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:23:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 3/7] rcu: remove useless special.b.deferred_qs
Message-ID: <20200217232353.GB17570@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-4-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-4-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 12:45:55PM +0000, Lai Jiangshan wrote:
> ->read_read_unlock_special.b.deferred_qs is set when
> ->read_read_unlock_special is non-zero, and it is cleared when
> ->read_read_unlock_special is cleared.
> 
> So it is useless.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

I have queued this on -rcu for further review and testing, thank you!

							Thanx, Paul

> ---
>  include/linux/sched.h    | 2 +-
>  kernel/rcu/tree_plugin.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2c2e56bd8913..3ba392d71de9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -604,7 +604,7 @@ union rcu_special {
>  		u8			blocked;
>  		u8			need_qs;
>  		u8			exp_hint; /* Hint for performance. */
> -		u8			deferred_qs;
> +		u8			pad; /* No garbage from compiler! */
>  	} b; /* Bits. */
>  	u32 s; /* Set of bits. */
>  };
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 2fab8be2061f..f2fd7d687bdb 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -622,7 +622,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
>  		}
> -		t->rcu_read_unlock_special.b.deferred_qs = true;
>  		local_irq_restore(flags);
>  		return;
>  	}
> -- 
> 2.20.1
> 
