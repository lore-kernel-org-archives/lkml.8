Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA451C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6352076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bYKrbxNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgHLUHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgHLUHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:07:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E103DC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OfKJwmZqOeXST/MwyagBgte+Hq0/l/+1UU55fiK02V0=; b=bYKrbxNv1VanQ/sAkAW8gP5XVC
        g8MdonD4cffGOzKiYaWNI90q5Ekvz6O4/GkFPx/95QKPIhG6kWKW1DaVQlttXzh455BelpqUxk/N6
        RlKUa24ziDgPwi3QcyJVz9nmLEFKSH5u5Z30y6jEYwFOnlwHtdPFP4nHXqAgGl5qvqCVJT7NiIV75
        UYM4M1xgRllDEqVkbBfONU4onhnM94LbNgIOiLcK8XDkw/ezYu2EvOL+bzhJnjXfXD9Dw7xCp8Xm8
        dAefQFXIpkelc0fZyclac7KrhmxEw85jYnOLypB9v3FO5uSW8BSCMRPfjb+FvypU/AYuuv57u/uZX
        yHlGbO5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5x1T-0002fw-OD; Wed, 12 Aug 2020 20:06:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 050F5980C68; Wed, 12 Aug 2020 22:06:54 +0200 (CEST)
Date:   Wed, 12 Aug 2020 22:06:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] task_work: only grab task signal lock when needed
Message-ID: <20200812200653.GZ3982@worktop.programming.kicks-ass.net>
References: <0028d3ea-4d05-405f-b457-75c83d381d89@kernel.dk>
 <20200811152310.GF21797@redhat.com>
 <20200812145422.GA10232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812145422.GA10232@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 04:54:23PM +0200, Oleg Nesterov wrote:

> I see nothing better than the additional change below. Peter, do you see
> another solution?

Nope -- although I don't claim to understand the signal code much.

> This needs a comment to explain that this mb() pairs with another barrier
> provided by cmpxchg() in task_work_add(). It ensures that either get_signal()
> sees the new work added by task_work_add(), or task_work_add() sees the
> result of "&= ~JOBCTL_TASK_WORK".
> 
> Oleg.
> 
> --- x/kernel/signal.c
> +++ x/kernel/signal.c
> @@ -2541,7 +2541,7 @@ bool get_signal(struct ksignal *ksig)
>  
>  relock:
>  	spin_lock_irq(&sighand->siglock);
> -	current->jobctl &= ~JOBCTL_TASK_WORK;
> +	smp_store_mb(current->jobctl, current->jobctl & ~JOBCTL_TASK_WORK);
>  	if (unlikely(current->task_works)) {
>  		spin_unlock_irq(&sighand->siglock);
>  		task_work_run();
> 

I agree this should work; smp_store_mb() isn't my favourite primitive,
but yes, this seems as good a use of it as there is so why not.

