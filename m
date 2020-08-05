Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A16DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33D12086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XcUD2GWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHEWCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgHEWCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 18:02:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8075EC061575;
        Wed,  5 Aug 2020 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gHN40y1hz2o1t/wXONj6TmlkjSeV2FEzsrbsp11iVTY=; b=XcUD2GWA8fmvquFqlUxObJ+UM
        aa4xSUHftwsdrhmegiwrhRyG08X/Rcs6s/eyBT7itnQtNBD7idKKcRxezDe3K8ExBN43pbUnr/5D3
        ergkTlDkMVSJlbd109kSM4OpgY7Xvf+pJSPdykjieJnWGWGYmVp81QMOwKSvfQrTjy/1e+WD6PglD
        4eKvI9zUp+sxp4nsiVNp+Z1lcM9HRRYLWauFbxPoXdn5M2JQSzHJ+XKhJm7ZzSTXEeKoQ0+mxHH2u
        6wKEbpOIp/1YweqqE4DQvWr7wImOBWArO9PMDT/PJT48NnwBz0SHQma82CUfVvCpGw4NgtUeVsr3W
        V6G39G9DA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48804)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k3RUG-0003xu-Tf; Wed, 05 Aug 2020 23:02:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k3RUG-0005Tt-23; Wed, 05 Aug 2020 23:02:16 +0100
Date:   Wed, 5 Aug 2020 23:02:16 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update phylink/sfp keyword matching
Message-ID: <20200805220215.GY1551@shell.armlinux.org.uk>
References: <E1k3KUx-0000da-In@rmk-PC.armlinux.org.uk>
 <CAHk-=whbLwN9GEVVt=7eYhPYk0t0Wh1xeuNEDD+xmQxBFjAQJA@mail.gmail.com>
 <20200805182250.GX1551@shell.armlinux.org.uk>
 <8977553d1b52e567f72abc2ccad0eb5bca62e242.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8977553d1b52e567f72abc2ccad0eb5bca62e242.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 11:54:25AM -0700, Joe Perches wrote:
> On Wed, 2020-08-05 at 19:22 +0100, Russell King - ARM Linux admin wrote:
> > On Wed, Aug 05, 2020 at 11:11:28AM -0700, Linus Torvalds wrote:
> > > On Wed, Aug 5, 2020 at 7:34 AM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > > > Is this something you're willing to merge directly please?
> > > 
> > > Done.
> > > 
> > > That said:
> > > 
> > > > -K:     phylink
> > > > +K:     phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
> > > 
> > > That's a very awkward pattern. I wonder if there could be better ways
> > > to express this (ie "only apply this pattern to these files" kind of
> > > thing)
> > 
> > Yes, it's extremely awkward - I spent much of the morning with perl
> > testing it out on the drivers/ subtree.
> 
> And perhaps easier to read would be to use multiple K: lines.
> (?: used to avoid unnecessary capture groups)
> 
> K:	phylink\.h|struct\s+phylink
> K:	(?:\.|\-\>)phylink_

That one is definitely incorrect.  It is not .phylink_ or ->phylink_,
it was .phylink (without _) or >phylink_

> K:	phylink_(?:autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
> 
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
