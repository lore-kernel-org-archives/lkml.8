Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE733C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCC221473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgEIXwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:52:22 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36590 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgEIXwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:52:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 36E062996C;
        Sat,  9 May 2020 19:52:17 -0400 (EDT)
Date:   Sun, 10 May 2020 09:52:24 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Jakub Kicinski <kuba@kernel.org>
cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
In-Reply-To: <20200508185402.41d9d068@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <alpine.LNX.2.22.394.2005100946241.11@nippy.intranet>
References: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr> <20200508185402.41d9d068@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020, Jakub Kicinski wrote:

> On Fri,  8 May 2020 19:25:57 +0200 Christophe JAILLET wrote:
> > @@ -527,8 +531,9 @@ static int mac_sonic_platform_remove(struct platform_device *pdev)
> >  	struct sonic_local* lp = netdev_priv(dev);
> >  
> >  	unregister_netdev(dev);
> > -	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
> > -	                  lp->descriptors, lp->descriptors_laddr);
> > +	dma_free_coherent(lp->device,
> > +			  SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
> > +			  lp->descriptors, lp->descriptors_laddr);
> >  	free_netdev(dev);
> >  
> >  	return 0;
> 
> This is a white-space only change, right? Since this is a fix we should
> avoid making cleanups which are not strictly necessary.
> 

I think it is harmless if it doesn't create any merge conflicts. Any merge 
conflict created by the whitespace change would have happened anyway, 
because all of the changes in this patch are very closely related. That's 
why I was happy to put a 'reviewed-by' tag on this.
