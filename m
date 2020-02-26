Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74225C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52ED6222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgBZBL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:11:57 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50308 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgBZBL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:11:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id B1ED329F75;
        Tue, 25 Feb 2020 20:11:53 -0500 (EST)
Date:   Wed, 26 Feb 2020 12:11:55 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Greg Ungerer <gerg@linux-m68k.org>
cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
In-Reply-To: <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org>
Message-ID: <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com> <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com> <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Greg Ungerer wrote:

> Hi Afzal,
> 
> On 24/2/20 10:50 am, afzal mohammed wrote:
> > request_irq() is preferred over setup_irq(). The early boot setup_irq()
> > invocations happen either via 'init_IRQ()' or 'time_init()', while
> > memory allocators are ready by 'mm_init()'.
> > 
> > Per tglx[1], setup_irq() existed in olden days when allocators were not
> > ready by the time early interrupts were initialized.
> > 
> > Hence replace setup_irq() by request_irq().
> > 
> > Seldom remove_irq() usage has been observed coupled with setup_irq(),
> > wherever that has been found, it too has been replaced by free_irq().
> > 
> > [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> > 
> > Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> > Tested-by: Greg Ungerer <gerg@linux-m68k.org> # ColdFire
> > ---
> > 
> > v2:
> >   * Replace pr_err("request_irq() on %s failed" by
> >             pr_err("%s: request_irq() failed"
> >   * Commit message massage
> >   * remove now irrelevant comment lines at 3 places
> > 
> >   arch/m68k/68000/timers.c      | 11 ++---------
> >   arch/m68k/coldfire/pit.c      | 11 ++---------
> >   arch/m68k/coldfire/sltimers.c | 19 +++++--------------
> >   arch/m68k/coldfire/timers.c   | 21 +++++----------------
> >   4 files changed, 14 insertions(+), 48 deletions(-)
> > 
> > diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
> > index 71ddb4c98726..55a76a2d3d58 100644
> > --- a/arch/m68k/68000/timers.c
> > +++ b/arch/m68k/68000/timers.c
> > @@ -68,14 +68,6 @@ static irqreturn_t hw_tick(int irq, void *dummy)
> >     /***************************************************************************/
> >   -static struct irqaction m68328_timer_irq = {
> > -	.name	 = "timer",
> > -	.flags	 = IRQF_TIMER,
> > -	.handler = hw_tick,
> > -};
> > -
> > 
> > -/***************************************************************************/
> > -
> >   static u64 m68328_read_clk(struct clocksource *cs)
> >   {
> >   	unsigned long flags;
> > @@ -106,7 +98,8 @@ void hw_timer_init(irq_handler_t handler)
> >   	TCTL = 0;
> >     	/* set ISR */
> > -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> > +	if (request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL))
> > +		pr_err("%s: request_irq() failed\n", "timer");
> 
> Why not just:
> 
>                 pr_err("timer: request_irq() failed\n");
> 

I believe that the compiler would coalesce the two "timer" string 
constants in the patch from Afzal (as per my suggestion).

I suspect that your version costs a few extra bytes everywhere it appears 
(but I didn't check).

> And maybe would it be useful to print out the error return code from a 
> failed request_irq()?  What about displaying the requested IRQ number as 
> well? Just a thought.
> 

That error would almost always be -EBUSY, right?

Moreover, compare this change,

-	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
+	request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);

with this change,

+	int err;

-	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
+	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
+	if (err)
+		return err;

Isn't the latter change the more common pattern? It prints nothing.

And arguably, the former example is actually the change that's described 
in the commit description.

This patch seems to be making two orthogonal changes but I'll leave that 
question to the maintainer. (I'm not really trying to NAK this patch.)
