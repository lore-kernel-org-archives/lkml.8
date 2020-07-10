Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30540C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CA2206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594417506;
	bh=YPf8decqeTT5W5+yubykZEGeTB9T3V/vPIkboQrsm0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aHO6QSTJ4KYnE574DS2VqXs/nY6qvEqk0aB0F3Dz9Lidb7EOSHcbw4UmeWk7IClRc
	 PWaXBc3tdr55RuMnPwO/Aik6V8dTrf/xmVUylP4ng6jwtQn6+oQuw0USBX/k544qwQ
	 6pIN68Hzr9M2V4OmCHfFIrR3qv6yQcFG22N4bJF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgGJVpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgGJVpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:45:02 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3556A2075D;
        Fri, 10 Jul 2020 21:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594417501;
        bh=YPf8decqeTT5W5+yubykZEGeTB9T3V/vPIkboQrsm0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=phamNT+hkGwlLJAHZAUTUbwrxG3ovabV307+U2JfBrlm0sUPqKr5bEAbNZhEs17bE
         UYjaPLOp0Dvgv1WsWrMlZgeRz5YSbwx2eO48QWF4zMbS9ECBjq37v4zn1IYLL2c/91
         a91xtqw07d/l2QMpHeXRnNPiebl7E4htCdHxToHo=
Date:   Fri, 10 Jul 2020 23:44:59 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] timers: Use only bucket expiry for base->next_expiry
 value
Message-ID: <20200710214458.GA31351@lenoir>
References: <20200710154622.14989-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710154622.14989-1-anna-maria@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anna-Maria,

Nice change, it indeed makes more sense that way.
Just a few details below:

On Fri, Jul 10, 2020 at 05:46:22PM +0200, Anna-Maria Behnsen wrote:
> The bucket expiry time is the effective expriy time of timers and is
> greater than or equal to the requested timer expiry time. This is due
> to the guarantee that timers never expire early and the reduced expiry
> granularity in the secondary wheel levels.
> 
> When a timer is enqueued, trigger_dyntick_cpu() checks whether the
> timer is the new first timer. This check compares next_expiry with
> the requested timer expiry value and not with the effective expiry
> value of the bucket into which the timer was queued.
> 
> Storing the requested timer expiry value in base->next_expiry can lead
> to base->clk going backwards if the requested timer expiry value is
> smaller than base->clk. Commit 30c66fc30ee7 ("timer: Prevent base->clk
> from moving backward") worked around this by preventing the store when
> timer->expiry is before base->clk, but did not fix the underlying
> problem.
> 
> Use the expiry value of the bucket into which the timer is queued to
> do the new first timer check. This fixes the base->clk going backward
> problem and also prevents unnecessary softirq invocations when the
> timer->expiry is not equal to the bucket expiry time in case of a new
> first timer which is queued in a secondary wheel level.

I think there shouldn't be such unecessary softirq invocations. Either they
fire at the bucket expiry time or the timer expiry time, it doesn't make
much difference.

More important below:

> -static int calc_wheel_index(unsigned long expires, unsigned long clk)
> +static int calc_wheel_index(unsigned long expires, unsigned long clk,
> +			    unsigned long *bucket_expiry)
>  {
>  	unsigned long delta = expires - clk;
>  	unsigned int idx;
>  
>  	if (delta < LVL_START(1)) {
> -		idx = calc_index(expires, 0);
> +		idx = calc_index(expires, 0, bucket_expiry);
>  	} else if (delta < LVL_START(2)) {
> -		idx = calc_index(expires, 1);
> +		idx = calc_index(expires, 1, bucket_expiry);
>  	} else if (delta < LVL_START(3)) {
> -		idx = calc_index(expires, 2);
> +		idx = calc_index(expires, 2, bucket_expiry);
>  	} else if (delta < LVL_START(4)) {
> -		idx = calc_index(expires, 3);
> +		idx = calc_index(expires, 3, bucket_expiry);
>  	} else if (delta < LVL_START(5)) {
> -		idx = calc_index(expires, 4);
> +		idx = calc_index(expires, 4, bucket_expiry);
>  	} else if (delta < LVL_START(6)) {
> -		idx = calc_index(expires, 5);
> +		idx = calc_index(expires, 5, bucket_expiry);
>  	} else if (delta < LVL_START(7)) {
> -		idx = calc_index(expires, 6);
> +		idx = calc_index(expires, 6, bucket_expiry);
>  	} else if (LVL_DEPTH > 8 && delta < LVL_START(8)) {
> -		idx = calc_index(expires, 7);
> +		idx = calc_index(expires, 7, bucket_expiry);
>  	} else if ((long) delta < 0) {
>  		idx = clk & LVL_MASK;

You also need to handle that part. That's in fact the critical one  :)

I'll rebase my series on top of that.

Thanks!
