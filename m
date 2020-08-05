Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA172C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D372250E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHEWJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:09:39 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:41776 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgHEWJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 18:09:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2C7F1837F24C;
        Wed,  5 Aug 2020 22:09:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crown94_0d0ff9c26fb2
X-Filterd-Recvd-Size: 2861
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Aug 2020 22:09:35 +0000 (UTC)
Message-ID: <912b806b7943a227e3c79ed747b2242b87a3fd50.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: update phylink/sfp keyword matching
From:   Joe Perches <joe@perches.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Date:   Wed, 05 Aug 2020 15:09:34 -0700
In-Reply-To: <20200805220215.GY1551@shell.armlinux.org.uk>
References: <E1k3KUx-0000da-In@rmk-PC.armlinux.org.uk>
         <CAHk-=whbLwN9GEVVt=7eYhPYk0t0Wh1xeuNEDD+xmQxBFjAQJA@mail.gmail.com>
         <20200805182250.GX1551@shell.armlinux.org.uk>
         <8977553d1b52e567f72abc2ccad0eb5bca62e242.camel@perches.com>
         <20200805220215.GY1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-05 at 23:02 +0100, Russell King - ARM Linux admin wrote:
> On Wed, Aug 05, 2020 at 11:54:25AM -0700, Joe Perches wrote:
> > On Wed, 2020-08-05 at 19:22 +0100, Russell King - ARM Linux admin wrote:
> > > On Wed, Aug 05, 2020 at 11:11:28AM -0700, Linus Torvalds wrote:
> > > > On Wed, Aug 5, 2020 at 7:34 AM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > > > > Is this something you're willing to merge directly please?
> > > > 
> > > > Done.
> > > > 
> > > > That said:
> > > > 
> > > > > -K:     phylink
> > > > > +K:     phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
> > > > 
> > > > That's a very awkward pattern. I wonder if there could be better ways
> > > > to express this (ie "only apply this pattern to these files" kind of
> > > > thing)
> > > 
> > > Yes, it's extremely awkward - I spent much of the morning with perl
> > > testing it out on the drivers/ subtree.
> > 
> > And perhaps easier to read would be to use multiple K: lines.
> > (?: used to avoid unnecessary capture groups)
> > 
> > K:	phylink\.h|struct\s+phylink
> > K:	(?:\.|\-\>)phylink_
> 
> That one is definitely incorrect.  It is not .phylink_ or ->phylink_,
> it was .phylink (without _) or >phylink_

Hi Russell.

I don't see the difference.

All uses of .phylink are followed with _
as far as I can tell.

$ git grep -Poh "\.phylink\S*"|sort|uniq -c
      1 .phylink_fixed_state
      2 .phylink_mac_an_restart
      9 .phylink_mac_config
      1 .phylink_mac_config.
     11 .phylink_mac_link_down
      6 .phylink_mac_link_state
      9 .phylink_mac_link_up
     38 .phylink_validate


