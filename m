Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443B720748
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589496226;
	bh=51ufzMz+fg40/oTc7CWo6MQoCrv8BYsmfMrnl581nTY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=wn0cWd6mEjU2AR1jyx85hwP1w4rHInKaAKGV2lrxlF2Wp13QElpdTDLtsEX7OUWct
	 Sttc4W3lP6AavHooOUWagQSyjUyFjqOoTgKP60G8H70rNTRG7NyyRYYrbxHRMHUB+T
	 Z/tdYGqIBiDnD2LNfY90LvpeM2e1jpC7bWvIZUdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgENWnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgENWnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:43:45 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A10D820709;
        Thu, 14 May 2020 22:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589496224;
        bh=51ufzMz+fg40/oTc7CWo6MQoCrv8BYsmfMrnl581nTY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PyvD1ol2DQSaEJYbd+Ob2sHbbIsoJw3uJK8DpO1d/0VF47syshVe0gwLm2YQT2Rlx
         oL3BMAri0jRVs2KwhnnOC55gJxnL9D34PrgW97z+Mr/WnWubUb9EsafapkJPo8JJwi
         yvlUWsGbhNIx0XtpuBHYHlRAhXj67/BcffXmQoPE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8E84135229C8; Thu, 14 May 2020 15:43:44 -0700 (PDT)
Date:   Thu, 14 May 2020 15:43:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lihao Liang <lihaoliang@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: Update comment from rsp->rcu_gp_seq to rsp->gp_seq
Message-ID: <20200514224344.GX2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200514203434.22274-1-lihaoliang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514203434.22274-1-lihaoliang@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 09:34:34PM +0100, Lihao Liang wrote:
> Signed-off-by: Lihao Liang <lihaoliang@google.com>

Good eyes!!!  Applied, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 2d7fcb9bdd34..508c46421eb3 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -41,7 +41,7 @@ struct rcu_node {
>  	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
>  					/*  some rcu_state fields as well as */
>  					/*  following. */
> -	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
> +	unsigned long gp_seq;	/* Track rsp->gp_seq. */
>  	unsigned long gp_seq_needed; /* Track furthest future GP request. */
>  	unsigned long completedqs; /* All QSes done for this node. */
>  	unsigned long qsmask;	/* CPUs or groups that need to switch in */
> @@ -149,7 +149,7 @@ union rcu_noqs {
>  /* Per-CPU data for read-copy update. */
>  struct rcu_data {
>  	/* 1) quiescent-state and grace-period handling : */
> -	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
> +	unsigned long	gp_seq;		/* Track rsp->gp_seq counter. */
>  	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
>  	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
>  	bool		core_needs_qs;	/* Core waits for quiesc state. */
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 
