Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EB120780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593696745;
	bh=1rvDCpqbGKl8meh/wXhjL6bCNKPrpoWHWJLyQrROThc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xFrmFxoIDotnzkbiI+ugPidQdlk3Qm+A9SPt1qFypOmPo/rR42VY6eqtIC1JPiKq+
	 vSiOZ4i1/v48zJgr+TaGoozvlwEmCifXMztCcn7sAlcAENp+qRjU2vVH+7M9LW4Ali
	 8C57DV8cvHO3RPbYWGbgRjRkM/pdoabqiyZskVAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgGBNcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgGBNcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:32:23 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9C82088E;
        Thu,  2 Jul 2020 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593696743;
        bh=1rvDCpqbGKl8meh/wXhjL6bCNKPrpoWHWJLyQrROThc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pN4UCSN2v5xxAg1g+L5wcG2Iir32JmmxQnZaNCCHSmSU1Dtr67SFYl6wYxYXvZ7ww
         ynLmZ9fF6hSjYtwGZ4U0q3I8Ru0MEqCN6Rt+Lu9jsGNaJLTAv1Kvr9OLqBFpZwkIm2
         OfGw+6Q9GvsL5a0K1dEiD1v9BKVuB6VonlkBNGdc=
Date:   Thu, 2 Jul 2020 15:32:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 10/10] timer: Lower base clock forwarding threshold
Message-ID: <20200702133219.GA27417@lenoir>
References: <20200701011030.14324-1-frederic@kernel.org>
 <20200701011030.14324-11-frederic@kernel.org>
 <878sg2t5ls.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sg2t5ls.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:21:35PM +0200, Thomas Gleixner wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> > There is no apparent reason for not forwarding base->clk when it's 2
> > jiffies late, except perhaps for past optimizations. But since forwarding
> > has to be done at some point now anyway, this doesn't stand anymore.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >  kernel/time/timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index 439fee098e76..25a55c043297 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -883,7 +883,7 @@ static inline void forward_timer_base(struct timer_base *base)
> >  	 * Also while executing timers, base->clk is 1 offset ahead
> >  	 * of jiffies to avoid endless requeuing to current jffies.
> >  	 */
> > -	if ((long)(jnow - base->clk) < 2)
> > +	if ((long)(jnow - base->clk) < 1)
> >  		return;
> 
> The apparent reason is in the comment right above the condition ...

Hmm, that's a comment I added myself in the patch before.

The following part:

> >      * Also while executing timers, base->clk is 1 offset ahead
> >      * of jiffies to avoid endless requeuing to current jffies.
> >      */

relates to situation when (long)(jnow - base->clk) < 0
