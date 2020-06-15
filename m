Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C50C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB84520936
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592253108;
	bh=/ZFfJJfrCWJSkrEMjVco8MOwBGhWUOxHrsp3cHOk8cg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jf2NgT4wGLV/nr5wxU2MfgWP1JmrfhCk3XZj5iJxOsguCatG/uocbzCFJhwwbAD8F
	 uYUMdgj3dnuh+Qh9oS3CPa6jOEFhGwFxOd02GV0HVv+qTkBomk63O7AFTzv9eXhKwW
	 /zBjyDYH0ooYYlmX/jdALK0InXxQ1t2+VGbzEtSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgFOUbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbgFOUbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:31:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417C52074D;
        Mon, 15 Jun 2020 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592253100;
        bh=/ZFfJJfrCWJSkrEMjVco8MOwBGhWUOxHrsp3cHOk8cg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Zk57CcXwhqHZxyP3HNWSUxLb8mPrwhP6wlY3eNqakErw8OsJS9VgNCgbF7z/EVDv0
         n5OldxnJQk5a4WfJR94GW0t1iv56jfXc3RwwEFB88CIZIhDbNLj2f8JUZfR1/lbhoo
         rX0ZmDFvauSZfoo6Lauy8tEJzNAmhFL5t3gRn9QA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2B2CD35218F0; Mon, 15 Jun 2020 13:31:40 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:31:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH] kernel/rcu/tree.c: fix kernel-doc warnings
Message-ID: <20200615203140.GN2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <6b6af324-1c81-5b8d-bfc1-e800e9792172@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b6af324-1c81-5b8d-bfc1-e800e9792172@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:28:05PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warnings:
> 
> ../kernel/rcu/tree.c:959: warning: Excess function parameter 'irq' description in 'rcu_nmi_enter'
> ../kernel/rcu/tree.c:3006: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'
> 
> Fixes: cf7614e13c8f ("rcu: Refactor rcu_{nmi,irq}_{enter,exit}()")
> Fixes: 9154244c1ab6 ("rcu/tree: Add a shrinker to prevent OOM due to kfree_rcu() batching")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Byungchul Park <byungchul.park@lge.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>

Someone beat you to the second hunk, but the first hunk is queued
and pushed, thank you!

							Thanx, Paul

> ---
> Note: The first Fixes: commit ID might be incorrect.
> 
>  kernel/rcu/tree.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- linux-next-20200615.orig/kernel/rcu/tree.c
> +++ linux-next-20200615/kernel/rcu/tree.c
> @@ -944,7 +944,6 @@ void __rcu_irq_enter_check_tick(void)
>  
>  /**
>   * rcu_nmi_enter - inform RCU of entry to NMI context
> - * @irq: Is this call from rcu_irq_enter?
>   *
>   * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
>   * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
> @@ -2986,6 +2985,7 @@ struct kfree_rcu_cpu_work {
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
>   * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
>   * @initialized: The @lock and @rcu_work fields have been initialized
> + * @count: Number of objects for which GP not started
>   *
>   * This is a per-CPU structure.  The reason that it is not included in
>   * the rcu_data structure is to permit this code to be extracted from
> @@ -3001,7 +3001,6 @@ struct kfree_rcu_cpu {
>  	struct delayed_work monitor_work;
>  	bool monitor_todo;
>  	bool initialized;
> -	// Number of objects for which GP not started
>  	int count;
>  };
>  
> 
> 
