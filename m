Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07FC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 06:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9F4206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 06:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgBZGkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 01:40:01 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35272 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgBZGkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 01:40:01 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E158C29E93;
        Wed, 26 Feb 2020 01:39:55 -0500 (EST)
Date:   Wed, 26 Feb 2020 17:39:57 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Greg Ungerer <gerg@linux-m68k.org>
cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
In-Reply-To: <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org>
Message-ID: <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com> <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com> <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org> <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
 <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Greg Ungerer wrote:

> > That error would almost always be -EBUSY, right?
> 
> I expect it will never fail this early in boot. 

If so, it suggests to me that tweaking the error message string is just 
bikeshedding and that adding these error messages across the tree is just 
bloat.

> But how will you know if it really is EBUSY if you don't print it out?
> 
> > Moreover, compare this change,
> > 
> > -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> > +	request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> > 
> > with this change,
> > 
> > +	int err;
> > 
> > -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> > +	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> > +	if (err)
> > +		return err;
> > 
> > Isn't the latter change the more common pattern? It prints nothing.
> 
> Hmm, in my experience the much more common pattern is:
> 
> > +	int err;
> > 
> > -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> > +	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> > +	if (err) {
> > +             pr_err("timer: request_irq() failed with err=%d\n", err);
> > +		return err;
> > +     }
> 
> Where the pr_err() could be one of pr_err, printk, dev_err, ...
> 

A rough poll using 'git grep' seems to agree with your assessment.

If -EBUSY means the end user has misconfigured something, printing 
"request_irq failed" would be helpful. But does that still happen?

Printing any error message for -ENOMEM is frowned upon, and printing -12 
is really unhelpful. So the most popular pattern isn't that great, though 
it is usually less verbose than the example you've given.

Besides, introducing local variables and altering control flow seems well 
out-of-scope for this kind of refactoring, right?

Anyway, if you're going to add an error message,
pr_err("%s: request_irq failed", foo) is unavoidable whenever foo isn't a 
string constant, so one can't expect to grep the source code for the 
literal error message from the log.

BTW, one of the benefits of "%s: request_irq failed" is that a compilation 
unit with multiple request_irq calls permits the compiler to coalesce all 
duplicated format strings. Whereas, that's not possible with
"foo: request_irq failed" and "bar: request_irq failed".
