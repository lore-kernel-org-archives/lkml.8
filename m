Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10F5207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595515550;
	bh=F4WWn7fzC+PD1/9wuKxBOVGqVc3d9POvsbtDX2OiF40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AfjC0bVTnyINOdKTn9O6yG4LJ3I0EFXX1MvOBDVCqvZmNczFVdVCJj7otzDTQEDRH
	 0NBUxbfGiWa1+vwKaX8giRqBQpsNHDQY4Sa6Wm112zUkWeuIDmKXiY0OsqDmKiZruK
	 IbZuykW+DY8cVCGsYVTu9Gw12OuXb+4Jo1Uocpgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgGWOpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgGWOps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:45:48 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D146B20768;
        Thu, 23 Jul 2020 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595515548;
        bh=F4WWn7fzC+PD1/9wuKxBOVGqVc3d9POvsbtDX2OiF40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQDdKlAbskCFAQUYrjgaOoxpK875TXTio91pigeWyxyRvZXhfPGIdlNtJ9CcpxseW
         /KLKyk6R4zcPDtB/wPC9qgiXrXu0MrWVQ/ngZw/E9go3fJQRoTqacJShJUDaJnnjJa
         Kgf99ESdgCj0609G/Rd7e/O+kxDwDu1pQs2gMOoE=
Date:   Thu, 23 Jul 2020 16:45:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH] timers: Recalculate next timer interrupt only when
 necessary
Message-ID: <20200723144544.GC28401@lenoir>
References: <20200721000556.4709-1-frederic@kernel.org>
 <87a6zqxrqb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6zqxrqb.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:53:32PM +0200, Thomas Gleixner wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> >
> > Since recalculating the next_expiry isn't a free operation, especially
> > when we must climb up the last wheel level to find out that no timer
> > has
> 
> I'm climbing stairs or mountains :)

Arguably, climbing a wheel can be a never ending story :)

> 
> > been enqueued at all, lets reuse the next expiry cache when it is
> > known
> 
> lets? Come on, the changelog is about facts not what we might do.

Also since you applied the last patchset I have tried to quit using "we"
in the changelog and use "the code" as a subject or even the passive form.
But reading above, I did it again.

Too many habits :))

> 
> >  	unsigned long		clk;
> >  	unsigned long		next_expiry;
> > +	bool			next_expiry_recalc;
> >  	unsigned int		cpu;
> >  	bool			is_idle;
> 
> Care to stare at the output of
> 
>      pahole -C timer_base kernel/time/timer.o
> 
> before and after?

Ah right, I'll move the bool together.

Thanks.
