Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from elvis.franken.de ([193.175.24.41]:34571 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbgCKQDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:03:39 -0400
Date: Wed, 11 Mar 2020 17:03:07 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: afzal mohammed <afzal.mohd.ma@gmail.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH v4] MIPS: Replace setup_irq() by request_irq()
Message-ID: <20200311160307.GA15464@alpha.franken.de>
References: <20200304203144.GA4323@alpha.franken.de>
 <20200305115759.3186-1-afzal.mohd.ma@gmail.com>
 <20200311053126.GA48442@ubuntu-m2-xlarge-x86>
 <20200311090308.GA5060@afzalpc>
 <20200311104217.GA10615@alpha.franken.de>
 <20200311131210.GA5115@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311131210.GA5115@afzalpc>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 11, 2020 at 06:42:10PM +0530, afzal mohammed wrote:
> Hi Thomas,
> 
> On Wed, Mar 11, 2020 at 11:42:17AM +0100, Thomas Bogendoerfer wrote:
> > On Wed, Mar 11, 2020 at 02:33:08PM +0530, afzal mohammed wrote:
> 
> > > diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> 
> > >  int r4k_clockevent_init(void)
> > >  {
> > > -	unsigned long flags = IRQF_PERCPU | IRQF_TIMER | IRQF_SHARED;
> > > +	unsigned long flags = IRQF_PERCPU | IRQF_TIMER;
> 
> > I don't see why this should help. In my tree only sgi-ip30 removes
> > IRQF_SHARED from flags, but then it uses setup_percpu_irq().
> > What do I miss ?
> 
> You did not miss anything. Though it works, i took a wrong route
> following the tags & arrived at that solution in a hurry.
> (struct irqaction used in sgi-ip30 was used here earlier w/ setup_irq).
> 
> The problem is sanity checks in request_irq() [ rather in
> request_thread_iq() ]
> 
> 
> 	if (((irqflags & IRQF_SHARED) && !dev_id) ||
> 	    (!(irqflags & IRQF_SHARED) && (irqflags & IRQF_COND_SUSPEND)) ||
> 	    ((irqflags & IRQF_NO_SUSPEND) && (irqflags & IRQF_COND_SUSPEND)))
> 		return -EINVAL;
> 
> If IRQF_SHARED is passed, it exepcts a non-NULL dev_id, here it is
> NULL, setup_irq() doesn't have any check like that.

so request_irq() is not a 1:1 replacement for our current setup_irq().
Or put it the another way our setup_irq() might be buggy, when used for
shared interrupts.

> So i think proper solution is to add a non NULL dev_id, as removing
> IRQF_SHARED might affect some platforms that might be using that
> interrupt line shared.
> 
> Patch with non-NULL dev_id below, it works w/ Nathan's test case.

I'm not sure, I like the adding of string pointers as dev_id arguments
in your patch. How can we make sure they are unique enough for the use
case ? I guess using handler as dev_id does a better job here.

And before doing that, lets clean up some of the IRQF_SHARED usage first.
All sni IRQF_SHARED can go away, the interrupt lines are exclusive there. 

loongson2ef/lemote-2f/irq.c: looks like the only user of
LOONGSON_NORTH_BRIDGE_IRQ, so IRQF_SHARED could go as well.
Could someone confirm that ?

All other need to stay, IMHO.

And v4 is already in mips-next, so I need an incremental patch please.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

