Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3587C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 22:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFE321473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 22:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgEIWmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 18:42:40 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:48244 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726771AbgEIWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 18:42:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0436318029123;
        Sat,  9 May 2020 22:42:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: force24_16f61c6693f2a
X-Filterd-Recvd-Size: 2622
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 May 2020 22:42:37 +0000 (UTC)
Message-ID: <fc5cf8da8e70ebb981a9fc3aec6834c74197f0ed.camel@perches.com>
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
From:   Joe Perches <joe@perches.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, fthain@telegraphics.com.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sat, 09 May 2020 15:42:36 -0700
In-Reply-To: <20200509111321.51419b19@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr>
         <20200508185402.41d9d068@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <50ef36cd-d095-9abe-26ea-d363d11ce521@wanadoo.fr>
         <20200509111321.51419b19@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-09 at 11:13 -0700, Jakub Kicinski wrote:
> On Sat, 9 May 2020 18:47:08 +0200 Christophe JAILLET wrote:
> > Le 09/05/2020 à 03:54, Jakub Kicinski a écrit :
> > > On Fri,  8 May 2020 19:25:57 +0200 Christophe JAILLET wrote:  
> > > > @@ -527,8 +531,9 @@ static int mac_sonic_platform_remove(struct platform_device *pdev)
> > > >   	struct sonic_local* lp = netdev_priv(dev);
> > > >   
> > > >   	unregister_netdev(dev);
> > > > -	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
> > > > -	                  lp->descriptors, lp->descriptors_laddr);
> > > > +	dma_free_coherent(lp->device,
> > > > +			  SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
> > > > +			  lp->descriptors, lp->descriptors_laddr);
> > > >   	free_netdev(dev);
> > > >   
> > > >   	return 0;  
> > > This is a white-space only change, right? Since this is a fix we should
> > > avoid making cleanups which are not strictly necessary.
> > 
> > Right.
> > 
> > The reason of this clean-up is that I wanted to avoid a checkpatch 
> > warning with the proposed patch and I felt that having the same layout 
> > in the error handling path of the probe function and in the remove 
> > function was clearer.
> > So I updated also the remove function.
> 
> I understand the motivation is good.

David, maybe I missed some notification about Jakub's role.

What is Jakub's role in relation to the networking tree?


