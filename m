Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900E5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1942088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BEYw8e9m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UU8G9SGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgGBNVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:21:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49682 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGBNVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:21:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593696096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dr+rwKS8kMHxBGCrHdWXmIO5ZUZ2IrLOttV64ewpf9c=;
        b=BEYw8e9mK7WOC37cATlq0VbQtfE0rEwVPiQez5FOdRNuZ0PQn/oKvm2R2ICpYhf45GhuJI
        qucX4pIB+2EnqobtZceTNtrTvZDQg6GJeWJ27dfLG1wHu+RjY7y5BsRsv7YFUFydw6MsGL
        l80DWnPWxYxE+oaGFqlEJCs/728ZNKLGdc64Wy+S6UG34uafo1NJMLXfrXRMZHP/XZyciD
        pY2QgLqHidEMoc18ij2W+3eFspIQzpqwSx2SV3D5vjvTHpF5LE/dZWyRch1XRcv3XejCSP
        N4EkOxfAw84J8qr0b9NEPy6EsG6mQrx+TLRsTeGhOKNsynNgr/LP2II7gz9Z6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593696096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dr+rwKS8kMHxBGCrHdWXmIO5ZUZ2IrLOttV64ewpf9c=;
        b=UU8G9SGcGPn4CxxyR+BGOu0SmXsEWigEdMDKdLMPQqbBG2qeFvK6bJOoPmiQ2l3d5PDZ7o
        8NNafAPZ/Bh9VxDg==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 10/10] timer: Lower base clock forwarding threshold
In-Reply-To: <20200701011030.14324-11-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org> <20200701011030.14324-11-frederic@kernel.org>
Date:   Thu, 02 Jul 2020 15:21:35 +0200
Message-ID: <878sg2t5ls.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> There is no apparent reason for not forwarding base->clk when it's 2
> jiffies late, except perhaps for past optimizations. But since forwarding
> has to be done at some point now anyway, this doesn't stand anymore.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/time/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 439fee098e76..25a55c043297 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -883,7 +883,7 @@ static inline void forward_timer_base(struct timer_base *base)
>  	 * Also while executing timers, base->clk is 1 offset ahead
>  	 * of jiffies to avoid endless requeuing to current jffies.
>  	 */
> -	if ((long)(jnow - base->clk) < 2)
> +	if ((long)(jnow - base->clk) < 1)
>  		return;

The apparent reason is in the comment right above the condition ...

Thanks,

        tglx
