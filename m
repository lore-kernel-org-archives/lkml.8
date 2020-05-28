Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A462EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724F12084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590709240;
	bh=kk35OEDgCoskWQ5BkKq+DIzRA811R/sfM9ATykL5fvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OLXDmMBOSaxYPakHxCIPNDImZELVpPDjqjNCjVUtrGjwomslDPeKL5GqNgXXE4jtQ
	 /8MAQn/y+bwpFQsJEaPJIyyREaBcUE1wylz3GKgVgcOPLMHumWE5C+yO0yoayVG3/q
	 EYgRWHeg+rAecE2yqVRMt9Kc30b7mRBkuqDW0OWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437644AbgE1Xkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437593AbgE1Xkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:40:35 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D392074B;
        Thu, 28 May 2020 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590709235;
        bh=kk35OEDgCoskWQ5BkKq+DIzRA811R/sfM9ATykL5fvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhlpWSFqONV6ey1TFLTxCLpOnT4c7xFhzBaaHRAqSr3rLMYrsvAtmcblX8boWQiX2
         OrAzw0nFfclqB5wI1qq3N2sZq85CxxHwdGzszLup1AcN3t7Lc/RW9XHBAlTBJ0ArTn
         UZ4HRRlwb47aNgIn38M14ltIbpAR8cllx0GhcOTc=
Date:   Fri, 29 May 2020 01:40:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 5/7] irq_work, smp: Allow irq_work on
 call_single_queue
Message-ID: <20200528234031.GB551@lenoir>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.011635912@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526161908.011635912@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:11:02PM +0200, Peter Zijlstra wrote:
> Currently irq_work_queue_on() will issue an unconditional
> arch_send_call_function_single_ipi() and has the handler do
> irq_work_run().
> 
> This is unfortunate in that it makes the IPI handler look at a second
> cacheline and it misses the opportunity to avoid the IPI. Instead note
> that struct irq_work and struct __call_single_data are very similar in
> layout, so use a few bits in the flags word to encode a type and stick
> the irq_work on the call_single_queue list.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/irq_work.h |    7 ++
>  include/linux/smp.h      |   23 ++++++++-
>  kernel/irq_work.c        |   53 +++++++++++---------
>  kernel/smp.c             |  119 ++++++++++++++++++++++++++++-------------------
>  4 files changed, 130 insertions(+), 72 deletions(-)
> 
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -13,6 +13,8 @@
>   * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
>   */
>  
> +/* flags share CSD_FLAG_ space */
> +
>  #define IRQ_WORK_PENDING	BIT(0)
>  #define IRQ_WORK_BUSY		BIT(1)
>  
> @@ -23,9 +25,12 @@
>  
>  #define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
>  
> +/*
> + * structure shares layout with single_call_data_t.
> + */
>  struct irq_work {
> -	atomic_t flags;
>  	struct llist_node llnode;
> +	atomic_t flags;


We should probably have:

struct csd_node {
       atomic_t flags;
       struct llist_node;
}

embed inside struct irq_work and struct __call_single_data. Relying on
structure layout for things to work doesn't really clarify things :-)

Thanks.
