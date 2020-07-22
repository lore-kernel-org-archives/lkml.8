Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82247C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4579A20825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbgGVWwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:52:44 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:35116 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVWwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:52:43 -0400
Date:   Wed, 22 Jul 2020 18:52:39 -0400
From:   Rich Felker <dalias@libc.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-ID: <20200722225239.GX14669@brightrain.aerifal.cx>
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
 <20200722023840.GA55317@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722023840.GA55317@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 07:38:40PM -0700, Guenter Roeck wrote:
> On Thu, Dec 12, 2019 at 11:38:43AM +0900, Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > __delay() is used from kernel module.
> > We need EXPORT_SYMBOL(), otherwise we will get compile error.
> > 
> > ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> I must admit that this patch completely baffles me. __delay was
> already exported, only elsewhere in the file. With this patch
> in place, it is exported twice, and all sh builds in -next fail
> with
> 
> In file included from include/linux/linkage.h:7,
>                  from arch/sh/include/asm/bug.h:5,
>                  from include/linux/bug.h:5,
>                  from include/linux/thread_info.h:12,
>                  from include/asm-generic/current.h:5,
>                  from ./arch/sh/include/generated/asm/current.h:1,
>                  from include/linux/sched.h:12,
>                  from arch/sh/lib/delay.c:8:
> include/linux/export.h:67:36: error: redefinition of '__ksymtab___delay'
> 
> Guenter
> 
> > ---
> >  arch/sh/lib/delay.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
> > index dad8e6a..540e670 100644
> > --- a/arch/sh/lib/delay.c
> > +++ b/arch/sh/lib/delay.c
> > @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
> >  		: "0" (loops)
> >  		: "t");
> >  }
> > +EXPORT_SYMBOL(__delay);
> >  
> >  inline void __const_udelay(unsigned long xloops)
> >  {

I presently have a revert of this commit in queue for next. If it's
sufficiently breaking (and especially if there are other regressions
that need to be fixed, see the pmd_free thing) I could try to get it
in for 5.8 still but that's getting a bit late.

Rich
