Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D93C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 02:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE1C20757
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 02:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584844436;
	bh=a90y8WfnJ4fM/Ch9mAw2eF7j6grASnC/5kzHpFIk19k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1MVhP4i5L4RJ+ZGFWWAwuQ2k6mAGrDRL1WNidGLX5urttCpFRo9SPc8UimoMq92i0
	 5+7yd2XMKaLI8MLDsVAqMTKWC8HF/o/YFO8g8yOEqSkAkHVchjmY93PrGWpT89N0gB
	 B7prtpp7sEGrZtYkm/L9ZhlP5ZavDL+4SEQjfAOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgCVCde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 22:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgCVCdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 22:33:33 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD0C20754;
        Sun, 22 Mar 2020 02:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584844412;
        bh=a90y8WfnJ4fM/Ch9mAw2eF7j6grASnC/5kzHpFIk19k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DiDLzNQKwGBUHwKLGm0wjWHP8MwSLqjoeiSahiOG/YI7R6cRwtg3cPbZ+o8BMm+hy
         jAd583nYERNjjq48phK/Cz9VNNuvw1lq0ixOcBtoKiX59CW4EF6MpqkdhKLemGfZnq
         UU1uaKA6FoSWQnCysCLwb2lnEiO/WvS80/3gAnCA=
Date:   Sun, 22 Mar 2020 03:33:30 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Annotate irq_work
Message-ID: <20200322023329.GC9634@lenoir>
References: <20200321113242.643576700@linutronix.de>
 <158480602510.28353.4851999853077941579.tip-bot2@tip-bot2>
 <20200321164057.GA9634@lenoir>
 <20200321181249.vy7xxkgrd65piapw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321181249.vy7xxkgrd65piapw@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 07:12:49PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-03-21 17:40:58 [+0100], Frederic Weisbecker wrote:
> > > diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> > > index 9c17f9c..f23f540 100644
> > > --- a/include/linux/irqflags.h
> > > +++ b/include/linux/irqflags.h
> > > @@ -69,6 +69,17 @@ do {						\
> > >  			current->irq_config = 0;	\
> > >  	  } while (0)
> > >  
> > > +# define lockdep_irq_work_enter(__work)					\
> > > +	  do {								\
> > > +		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
> > > +			current->irq_config = 1;			\
> > 
> > So, irq_config == 1 means we are in a softirq? Are there other values for
> > irq_config? In which case there should be enums or something?
> > I can't find the patch that describes this.
> 
> 0 means as-is, 1 means threaded / sleeping locks are okay.

So that's the kind of comment we need :-)

Also how about current->irq_locking instead?

And something like:

enum {
    IRQ_LOCKING_NO_SLEEP,
    IRQ_LOCKING_CAN_SLEEP
}

> 
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -245,6 +245,7 @@ static void nohz_full_kick_func(struct irq_work *work)
> > >  
> > >  static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
> > >  	.func = nohz_full_kick_func,
> > > +	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
> > >  };
> > 
> > I get why these need to be in hardirq but some basic explanations for
> > ordinary mortals as to why those two specifically and not all the others
> > (and there are many) would have been nice.
> 
> Is the documentation patch in this series any good?

That describes the general rules but it doesn't tell anything about the
details of this patch. Especially why RCU and nohz_full irq works in particular
are special here and why it's fine for others to execute in softirq.

Thanks.

> > Thanks.
> 
> Sebastian
