Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8969DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552CD2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595447987;
	bh=BV3a5aekYRte5/BllvL1km1l0MspmW13pUEjE0GxoBo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rQqpdo9uRikJ1HeqNpwzt38quo4FZ5gKCmKFzPVx3mrLzeAGIjNFSGwg6LK8WHPla
	 zuJMEhXFohL54UjXhyTyhMZNt8/YphMsK0jzFLZ/I90gbkw1ED+LXBBT0E/1m8vvWe
	 u5Cybp46TTOKxh5ihlKPwjBmINb95gW7EpsMksd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbgGVT7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgGVT7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:59:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9C520771;
        Wed, 22 Jul 2020 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595447983;
        bh=BV3a5aekYRte5/BllvL1km1l0MspmW13pUEjE0GxoBo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zOwCUzk4rt+lOZb+uHwUMzY+ucHL/PaI9xg4aadH2nri5nocqxgj/ZtlOghcfP8UL
         HpY6HgpgQ+bRPVDX+9f6Ya71oMFOkjT0H1GrbQPRw6nJztaXFiA6VzKKLFPkZZy7ls
         tFSvizUMAd/V+TKvrHFCw/qLqisFsnsW4pU918+8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C152A3522AB9; Wed, 22 Jul 2020 12:59:43 -0700 (PDT)
Date:   Wed, 22 Jul 2020 12:59:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 5/9] irq_work: Provide irq_work_queue_remote()
Message-ID: <20200722195943.GA23360@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200722150149.525408253@infradead.org>
 <20200722153017.311972826@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722153017.311972826@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:01:54PM +0200, Peter Zijlstra wrote:
> While the traditional irq_work relies on the ability to self-IPI, it
> makes sense to provide an unconditional irq_work_queue_remote()
> interface.
> 
> This can be used to replace the plagued smp_call_function_single_async().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/irq_work.h |   17 ++++--
>  kernel/irq_work.c        |  129 ++++++++++++++++++++++++++++-------------------
>  kernel/rcu/tree.c        |    6 +-
>  3 files changed, 95 insertions(+), 57 deletions(-)

[ . . . ]

> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c

[ . . . ]

> @@ -196,17 +237,5 @@ void irq_work_tick(void)
>  	irq_work_run_list(this_cpu_ptr(&lazy_list));
>  }
>  
> -/*
> - * Synchronize against the irq_work @entry, ensures the entry is not
> - * currently in use.
> - */
> -void irq_work_sync(struct irq_work *work)
> -{
> -	lockdep_assert_irqs_enabled();
> -
> -	while (irq_work_is_busy(work))
> -		cpu_relax();
> -}
> -EXPORT_SYMBOL_GPL(irq_work_sync);
> -
>  #endif /* CONFIG_IRQ_WORK */
> +

FYI, "git am" complains about this blank line.

						Thanx, Paul
