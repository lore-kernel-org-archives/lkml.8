Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989CDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748EF20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p1xjo4m4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VA1QNbJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgGBL7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgGBL7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:59:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CECC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:59:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593691158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJxYs7MH4bwwMVrxhi268zFbPWqb0i3cnr8e5k3M83s=;
        b=p1xjo4m4FV1fTysAi+o6TMwkS7r/m9Tf8FulpMWUiE43sWXCVrkq6LLC5pfAUVJ4jNapC9
        dOdAvDY5emUFpR0QMzEi8Gau96ENXoOgRGEWNCWXDUFmx5pJXbQuyq+Vrgf0yXf/JuqRyY
        PwDNdXFYYKEe8zf6ZFaw2wiJMswXUUNWgkt3HNLGCW4Am0ayr2dRhnOpJJ2neURpx6AsTl
        y77wB16r/l7cmCmErpkyODo/OucCIot50yL7hGPtmiISG20W54TxwOzMW10KVemzb+EVq/
        lwy8reY2+kmy/MFY4Ex2h/CF7FUWS/DvAEKxMnMV9XhdoCFA7/N2xu3BxMsIWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593691158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJxYs7MH4bwwMVrxhi268zFbPWqb0i3cnr8e5k3M83s=;
        b=VA1QNbJVjVLxS4HMDaxh50VyU4DNxk0R7hp7239VhBkAxenXFNDM7xOmmBscRdSUrZ7PEC
        kPH+8zTT0yti9cAg==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 03/10] timer: Simplify LVL_START() and calc_index()
In-Reply-To: <20200701011030.14324-4-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org> <20200701011030.14324-4-frederic@kernel.org>
Date:   Thu, 02 Jul 2020 13:59:17 +0200
Message-ID: <87pn9e9lgq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> LVL_START() makes the first index of a level to start with what would be
> the value of all bits set of the previous level.
>
> For example level 1 starts at 63 instead of 64.
>
> To cope with that, calc_index() always adds one offset for the level
> granularity to the expiry passed in parameter.
>
> Yet there is no apparent reason for such fixups so simplify the whole
> thing.

You sure?

> @@ -158,7 +158,7 @@ EXPORT_SYMBOL(jiffies_64);
>   * The time start value for each level to select the bucket at enqueue
>   * time.
>   */
> -#define LVL_START(n)	((LVL_SIZE - 1) << (((n) - 1) * LVL_CLK_SHIFT))
> +#define LVL_START(n)	(LVL_SIZE << (((n) - 1) * LVL_CLK_SHIFT))

>  /* Size of each clock level */
>  #define LVL_BITS	6
> @@ -489,7 +489,7 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
>   */
>  static inline unsigned calc_index(unsigned expires, unsigned lvl)
>  {
> -	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
> +	expires >>= LVL_SHIFT(lvl);
>  	return LVL_OFFS(lvl) + (expires & LVL_MASK);
>  }

So with that you move the expiry of each timer one jiffie ahead vs. the
original code, which violates the guarantee that a timer sleeps at least
for one jiffie for real and not measured in jiffies.

base->clk = 1
jiffies = 0
 local_irq_disable()
                        -> timer interrupt is raised in HW
 timer->expires = 1
 add_timer(timer)
        ---> index == 1
 local_irq_enable()
 timer interrupt
    jiffies++;
    softirq()
        expire(timer);

So the off by one has a reason.

Thanks,

        tglx






