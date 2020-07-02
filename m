Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E63CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3490020836
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593692826;
	bh=uhyzd/UJP5NhJydsQvmRfX9zeMi8dyoLcJsJlsb4nOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ev4HShsbM1Gzxj6B38a4vE+ssF3dFHSX6KtmecHhGEnFGXI1Zsvgn+jdobfDqaLf3
	 2qFyBQt6kImLzu34SF5Goxnuy4MiH/Wz1c8yIzO278RS7Ve/E9tqDWTijpfAyJNpNh
	 gW94lL3KfKGeaVrNygltTGF8r+UqCpKCytCYQY3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgGBM1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGBM1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:27:04 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5A9207CD;
        Thu,  2 Jul 2020 12:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593692824;
        bh=uhyzd/UJP5NhJydsQvmRfX9zeMi8dyoLcJsJlsb4nOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caMd6ddOSZ7aGenotVJ/5jL2AfHYJHL/BGDG1v/8eEBN15EAOHsYX0GgfdePZTPZ3
         idCJYWNwDuxth2Km9OzD8zM0UOfr4nTxqy5pr5cbF/x1dz0PiAXt/1jldPEBEpXBdZ
         8W0zNz5JH+KnyySPmT1G3zDKOKN9eEdKvTnUshXQ=
Date:   Thu, 2 Jul 2020 14:27:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 03/10] timer: Simplify LVL_START() and calc_index()
Message-ID: <20200702122659.GB17670@lenoir>
References: <20200701011030.14324-1-frederic@kernel.org>
 <20200701011030.14324-4-frederic@kernel.org>
 <87pn9e9lgq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn9e9lgq.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:59:17PM +0200, Thomas Gleixner wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> > LVL_START() makes the first index of a level to start with what would be
> > the value of all bits set of the previous level.
> >
> > For example level 1 starts at 63 instead of 64.
> >
> > To cope with that, calc_index() always adds one offset for the level
> > granularity to the expiry passed in parameter.
> >
> > Yet there is no apparent reason for such fixups so simplify the whole
> > thing.
> 
> You sure?

No :o)

> 
> > @@ -158,7 +158,7 @@ EXPORT_SYMBOL(jiffies_64);
> >   * The time start value for each level to select the bucket at enqueue
> >   * time.
> >   */
> > -#define LVL_START(n)	((LVL_SIZE - 1) << (((n) - 1) * LVL_CLK_SHIFT))
> > +#define LVL_START(n)	(LVL_SIZE << (((n) - 1) * LVL_CLK_SHIFT))
> 
> >  /* Size of each clock level */
> >  #define LVL_BITS	6
> > @@ -489,7 +489,7 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
> >   */
> >  static inline unsigned calc_index(unsigned expires, unsigned lvl)
> >  {
> > -	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
> > +	expires >>= LVL_SHIFT(lvl);
> >  	return LVL_OFFS(lvl) + (expires & LVL_MASK);
> >  }
> 
> So with that you move the expiry of each timer one jiffie ahead vs. the
> original code, which violates the guarantee that a timer sleeps at least
> for one jiffie for real and not measured in jiffies.
> 
> base->clk = 1
> jiffies = 0
>  local_irq_disable()
>                         -> timer interrupt is raised in HW
>  timer->expires = 1
>  add_timer(timer)
>         ---> index == 1
>  local_irq_enable()
>  timer interrupt
>     jiffies++;
>     softirq()
>         expire(timer);
> 
> So the off by one has a reason.

Fair enough. I didn't know about the one jiffy sleep guarantee.
I'll convert this patch to a comment explaining that off by one,
using your above example.

Thanks!
