Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F577C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14B92076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587570720;
	bh=erYIPpCttlAKmVk7+ZuIu29yGQ+f83fJdaXrHXypskw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FaAYR8hfX0yQ2l9T55EhjGpa1+B/Pm1gZacxe3d5DkEja/KQNud8cnyNcT3bDQFs/
	 KQ/uZdwz6g3pzPDjAKGCm9cH8GEowNwf7VqSJ4x7BSU4/AgcJybh99oyJJ6WfH1EWE
	 fL+WYVKX9tIduE+tnWk6AnNB2yp++uEuptJ5fAVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgDVPv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgDVPv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:51:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFE620767;
        Wed, 22 Apr 2020 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587570718;
        bh=erYIPpCttlAKmVk7+ZuIu29yGQ+f83fJdaXrHXypskw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eV+ic6cqswM4lN5NJv1zQbMoM/AXh3IbzYdwfvkGqAONMViojH7CxDYQ9wtGoyHLM
         iGSIP25KHmrOqCQNVHEJOhOpE+7obhFd5JbMZ3qkbsHPodNUtqLAyy4lL2lusUkAHY
         cQTyl672L9aXMPGUP6UWAH0epvHiEDnE6hSyhaHk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6002335203BC; Wed, 22 Apr 2020 08:51:58 -0700 (PDT)
Date:   Wed, 22 Apr 2020 08:51:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH 20/23] sched,rcutorture: Convert to sched_set_fifo_low()
Message-ID: <20200422155158.GV17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200422112719.826676174@infradead.org>
 <20200422112832.403795265@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112832.403795265@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:27:39PM +0200, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively no change.
> 
> Cc: paulmck@kernel.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcutorture.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -802,13 +802,11 @@ static int rcu_torture_boost(void *arg)
>  	unsigned long endtime;
>  	unsigned long oldstarttime;
>  	struct rcu_boost_inflight rbi = { .inflight = 0 };
> -	struct sched_param sp;
>  
>  	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
>  
>  	/* Set real-time priority. */
> -	sp.sched_priority = 1;
> -	if (sched_setscheduler(current, SCHED_FIFO, &sp) < 0) {
> +	if (sched_set_fifo_low(current) < 0) {
>  		VERBOSE_TOROUT_STRING("rcu_torture_boost RT prio failed!");
>  		n_rcu_torture_boost_rterror++;
>  	}
> 
> 
