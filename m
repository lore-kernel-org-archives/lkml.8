Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0123EC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7F1206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXToZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:44:25 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:35644 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgGXToZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:44:25 -0400
Date:   Fri, 24 Jul 2020 15:44:23 -0400
From:   Rich Felker <dalias@libc.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-ID: <20200724194423.GJ6949@brightrain.aerifal.cx>
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
 <20200722023840.GA55317@roeck-us.net>
 <20200722225239.GX14669@brightrain.aerifal.cx>
 <fa0456c9-cef0-45e7-59d7-ad652734b1d5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0456c9-cef0-45e7-59d7-ad652734b1d5@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 04:52:56PM -0700, Guenter Roeck wrote:
> Rich,
> 
> On 7/22/20 3:52 PM, Rich Felker wrote:
> > On Tue, Jul 21, 2020 at 07:38:40PM -0700, Guenter Roeck wrote:
> >> On Thu, Dec 12, 2019 at 11:38:43AM +0900, Kuninori Morimoto wrote:
> >>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>>
> >>> __delay() is used from kernel module.
> >>> We need EXPORT_SYMBOL(), otherwise we will get compile error.
> >>>
> >>> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
> >>>
> >>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>
> >> I must admit that this patch completely baffles me. __delay was
> >> already exported, only elsewhere in the file. With this patch
> >> in place, it is exported twice, and all sh builds in -next fail
> >> with
> >>
> >> In file included from include/linux/linkage.h:7,
> >>                  from arch/sh/include/asm/bug.h:5,
> >>                  from include/linux/bug.h:5,
> >>                  from include/linux/thread_info.h:12,
> >>                  from include/asm-generic/current.h:5,
> >>                  from ./arch/sh/include/generated/asm/current.h:1,
> >>                  from include/linux/sched.h:12,
> >>                  from arch/sh/lib/delay.c:8:
> >> include/linux/export.h:67:36: error: redefinition of '__ksymtab___delay'
> >>
> >> Guenter
> >>
> >>> ---
> >>>  arch/sh/lib/delay.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
> >>> index dad8e6a..540e670 100644
> >>> --- a/arch/sh/lib/delay.c
> >>> +++ b/arch/sh/lib/delay.c
> >>> @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
> >>>  		: "0" (loops)
> >>>  		: "t");
> >>>  }
> >>> +EXPORT_SYMBOL(__delay);
> >>>  
> >>>  inline void __const_udelay(unsigned long xloops)
> >>>  {
> > 
> > I presently have a revert of this commit in queue for next. If it's
> > sufficiently breaking (and especially if there are other regressions
> > that need to be fixed, see the pmd_free thing) I could try to get it
> > in for 5.8 still but that's getting a bit late.
> > 
> 
> The patch in mainline is ok. It appears that it has been applied
> again in -next.
> 
> "git log --oneline v5.7.. arch/sh/lib/delay.c" on top of next-20200721
> reports:
> 
> ee0e4f15dfd4 (origin/akpm) sh: add missing EXPORT_SYMBOL() for __delay
> d1f56f318d23 sh: add missing EXPORT_SYMBOL() for __delay
> 
> Maybe it just needs to be dropped from the akpm tree in -next ?

Could it be a bad merge or patch applied twice or something? I don't
see how the symbol is being exported twice. The argument to revert the
patch still seems correct.

Looking at current linux-next, ba722ca780 from akpm is re-adding the
patch after it gets reverted. Andrew, could you drop your copy of this
patch? It's already upstream as of 5.8-rc1 and now just needs to be
reverted upstream.

Rich
