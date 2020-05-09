Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6485C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFB221473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgEIXpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:45:13 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36424 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgEIXpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:45:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 38C3F2996C;
        Sat,  9 May 2020 19:45:09 -0400 (EDT)
Date:   Sun, 10 May 2020 09:45:04 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
In-Reply-To: <b7651b26-ac1e-6281-efb2-7eff0018b158@web.de>
Message-ID: <alpine.LNX.2.22.394.2005100922240.11@nippy.intranet>
References: <b7651b26-ac1e-6281-efb2-7eff0018b158@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020, Markus Elfring wrote:

> > While at it, rename a label in order to be slightly more informative and
> > split some too long lines.
> 
> Would you like to add the tag 'Fixes' to the change description?
> 

Sorry but I don't follow your reasoning here. Are you saying that this 
needs to be pushed out to -stable branches? If so, stable-kernel-rules.rst 
would seem to disagree as the bug is theoretical and isn't bothering 
people.

Is there a way to add a Fixes tag that would not invoke the -stable 
process? And was that what you had in mind?

> 
> > +++ b/drivers/net/ethernet/natsemi/macsonic.c
> > @@ -506,10 +506,14 @@ static int mac_sonic_platform_probe(struct platform_device *pdev)
> >
> >  	err = register_netdev(dev);
> >  	if (err)
> > -		goto out;
> > +		goto undo_probe1;
> >
> >  	return 0;
> >
> > +undo_probe1:
> > +	dma_free_coherent(lp->device,
> > +			  SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
> > +			  lp->descriptors, lp->descriptors_laddr);
> >  out:
> How do you think about the possibility to use the label 'free_dma'?

I think 'undo_probe1' is both descriptive and consistent with commit 
10e3cc180e64 ("net/sonic: Fix a resource leak in an error handling path in 
'jazz_sonic_probe()'").

Your suggestion, 'free_dma' is also good. But coming up with good 
alternatives is easy. If every good alternative would be considered there 
would be no obvious way to get a patch merged.
