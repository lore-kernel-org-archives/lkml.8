Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1CCC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87B820776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587570696;
	bh=VEUvieAw+qJQrUH6Ra5u2Y75NjpLr4K5DcKACRlBHJ0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lMJWGOJW34rZzqo2H5BTex9dKTxWDnzBW5POHDPS05d6PYlFtKIqWncab8zsb3iYm
	 0dIBPsI5G/unIsV3EetZWxyQBXbNo0JlDYJP4dIi1/f80m+z8hIj0MOhlhDISZUg/i
	 naWkzRkjhirCoy3JlTzj3Bp1wLfm02XtKWU7y9kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgDVPvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgDVPvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:51:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360DE20767;
        Wed, 22 Apr 2020 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587570695;
        bh=VEUvieAw+qJQrUH6Ra5u2Y75NjpLr4K5DcKACRlBHJ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cz/zdu9yAgyUQye1V2xRKk4wKEUI7gelM7IBy7qa5KUIkDyHBveCOX5AvGzwZlueL
         qJqEgojLbmTBOBm0BAdm9PA9JyKCSblw0o1qdVxkiW37uNqSHCVglS0yiYGRRiR2qK
         +C3C2xrX5qk+as0A6NoIvsWkH3e9WgRAsv0Cv0MQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 12CAE35203BC; Wed, 22 Apr 2020 08:51:35 -0700 (PDT)
Date:   Wed, 22 Apr 2020 08:51:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH 18/23] sched,locktorture: Convert to sched_set_fifo()
Message-ID: <20200422155135.GT17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200422112719.826676174@infradead.org>
 <20200422112832.283981577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112832.283981577@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:27:37PM +0200, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively changes prio from 99 to 50.
> 
> Cc: paulmck@kernel.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/locking/locktorture.c |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -436,8 +436,6 @@ static int torture_rtmutex_lock(void) __
>  
>  static void torture_rtmutex_boost(struct torture_random_state *trsp)
>  {
> -	int policy;
> -	struct sched_param param;
>  	const unsigned int factor = 50000; /* yes, quite arbitrary */
>  
>  	if (!rt_task(current)) {
> @@ -448,8 +446,7 @@ static void torture_rtmutex_boost(struct
>  		 */
>  		if (trsp && !(torture_random(trsp) %
>  			      (cxt.nrealwriters_stress * factor))) {
> -			policy = SCHED_FIFO;
> -			param.sched_priority = MAX_RT_PRIO - 1;
> +			sched_set_fifo(current);
>  		} else /* common case, do nothing */
>  			return;
>  	} else {
> @@ -462,13 +459,10 @@ static void torture_rtmutex_boost(struct
>  		 */
>  		if (!trsp || !(torture_random(trsp) %
>  			       (cxt.nrealwriters_stress * factor * 2))) {
> -			policy = SCHED_NORMAL;
> -			param.sched_priority = 0;
> +			sched_set_normal(current, 0);
>  		} else /* common case, do nothing */
>  			return;
>  	}
> -
> -	sched_setscheduler_nocheck(current, policy, &param);
>  }
>  
>  static void torture_rtmutex_delay(struct torture_random_state *trsp)
> 
> 
