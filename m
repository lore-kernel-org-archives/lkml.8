Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A5C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C36246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgB0Wic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:38:32 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33546 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgB0Wib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:38:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 67C4E2A160;
        Thu, 27 Feb 2020 17:38:28 -0500 (EST)
Date:   Fri, 28 Feb 2020 09:38:20 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
In-Reply-To: <20200227120618.GA6312@afzalpc>
Message-ID: <alpine.LNX.2.22.394.2002280927130.8@nippy.intranet>
References: <alpine.LNX.2.22.394.2002270908380.8@nippy.intranet> <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org> <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet> <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org> <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
 <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org> <20200227081805.GA5746@afzalpc> <CAMuHMdWVVWaoHA1Tie5APYBq3Pa3s4BAoWN1jAACAZZS65UA7w@mail.gmail.com> <20200227120618.GA6312@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020, afzal mohammed wrote:

> On Thu, Feb 27, 2020 at 09:32:46AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 27, 2020 at 9:18 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > > Since most of the existing setup_irq() didn't even check & handle 
> > > error return, my first thought was just s/setup_irq/request_irq, it 
> > > was easier from scripting pointing of view. i felt uncomfortable 
> > > doing nothing in case of error. Also noted that request_irq() 
> > > definition has a "__much_check", so decided to add it.
> > 
> > Most (all?) of the code calling setup_irq() is very old, and most of 
> > the calls happen very early, so any such failures are hard failures 
> > that prevent the system from booting at all.  Hence printing a message 
> > may be futile, as it may happen before the console has been 
> > initialized (modulo early-printk).
> 
> The main reason to at least acknowledge the return value was due to 
> __much_check in request_irq() definition, though w/ the compiler that i 
> used, there were no warnings, i feared that it might warn w/ some other 
> compilers & in some cases (may be W=[1-3] ?).
> 

This isn't new code, so I'd assume it's been "checked" in the sense of 
"reviewed and tested".

So the lack of an error message could be taken to mean that there's no 
need for an error message.

If you want to stop the compiler complaining about an unchecked return 
value, assuming that it does so, please consider using

	if (request_irq(...))
		pr_debug(...);

That way there is no penalty paid for adding error messages that the 
original author apparently did not want.
