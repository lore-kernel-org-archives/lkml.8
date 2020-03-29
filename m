Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A6DC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DD820675
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgC2Jrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:47:35 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42026 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727503AbgC2Jrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:47:35 -0400
X-IronPort-AV: E=Sophos;i="5.72,319,1580770800"; 
   d="scan'208";a="442806325"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 11:47:33 +0200
Date:   Sun, 29 Mar 2020 11:47:33 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     John Wyatt <jbwyatt4@gmail.com>
cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with
 preferred usleep_range
In-Reply-To: <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
Message-ID: <alpine.DEB.2.21.2003291144460.2990@hadrien>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>  <alpine.DEB.2.21.2003291127230.2990@hadrien> <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Mar 2020, John Wyatt wrote:

> On Sun, 2020-03-29 at 11:28 +0200, Julia Lawall wrote:
> >
> > On Sun, 29 Mar 2020, John B. Wyatt IV wrote:
> >
> > > Fix style issue with usleep_range being reported as preferred over
> > > udelay.
> > >
> > > Issue reported by checkpatch.
> > >
> > > Please review.
> > >
> > > As written in Documentation/timers/timers-howto.rst udelay is the
> > > generally preferred API. hrtimers, as noted in the docs, may be too
> > > expensive for this short timer.
> > >
> > > Are the docs out of date, or, is this a checkpatch issue?
> > >
> > > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> > > ---
> > >  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > > b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > > index eeeeec97ad27..019c8cce6bab 100644
> > > --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > > +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > > @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
> > >  	dev_dbg(par->info->device, "%s()\n", __func__);
> > >
> > >  	gpiod_set_value(par->gpio.reset, 0);
> > > -	udelay(20);
> > > +	usleep_range(20, 20);
> >
> > usleep_range should have a range, eg usleep_range(50, 100);.  But it
> > is
> > hard to know a priori what the range should be.  So it is probably
> > better
> > to leave the code alone.
>
> Understood.
>
> With the question I wrote in the commit message:
>
> "As written in Documentation/timers/timers-howto.rst udelay is the
> generally preferred API. hrtimers, as noted in the docs, may be too
> expensive for this short timer.
>
> Are the docs out of date, or, is this a checkpatch issue?"
>
> Is usleep_range too expensive for this operation?
>
> Why does checkpatch favor usleep_range while the docs favor udelay?

I don't know the answer in detail, but it is quite possible that
checkpatch doesn't pay any attention to the delay argument.  Checkpatch is
a perl script that highlights things that may be of concern.  It is not a
precise static analsis tool.

As a matter of form, all of your Please review comments should have been
put below the ---.  Currently, if someone had wanted to apply the patch,
you would make them do extra work to remove this information.

julia

>
> >
> > julia
> >
> > >  	gpiod_set_value(par->gpio.reset, 1);
> > >  	mdelay(120);
> > >  }
> > > --
> > > 2.25.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google
> > > Groups "outreachy-kernel" group.
> > > To unsubscribe from this group and stop receiving emails from it,
> > > send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit
> > > https://groups.google.com/d/msgid/outreachy-kernel/20200329092204.770405-1-jbwyatt4%40gmail.com
> > > .
> > >
>
>
