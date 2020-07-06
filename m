Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F69C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856952084C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgGFT4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:56:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49804 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGFT4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:56:11 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jsXDf-003uPR-1e; Mon, 06 Jul 2020 21:56:03 +0200
Date:   Mon, 6 Jul 2020 21:56:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Kubecek <mkubecek@suse.cz>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: ethtool: Remove PHYLIB direct
 dependency
Message-ID: <20200706195603.GA893522@lunn.ch>
References: <20200706042758.168819-1-f.fainelli@gmail.com>
 <20200706042758.168819-4-f.fainelli@gmail.com>
 <20200706114000.223e27eb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706114000.223e27eb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 11:40:00AM -0700, Jakub Kicinski wrote:
> On Sun,  5 Jul 2020 21:27:58 -0700 Florian Fainelli wrote:
> > +	ops = ethtool_phy_ops;
> > +	if (!ops || !ops->start_cable_test) {
> 
> nit: don't think member-by-member checking is necessary. We don't
> expect there to be any alternative versions of the ops, right?

I would not like to see anything else registering an ops. So i think
taking an Opps would be a good indication somebody is doing something
wrong and needs fixing.

> We could even risk a direct call:
> 
> #if IS_REACHABLE(CONFIG_PHYLIB)
> static inline int do_x()
> {
> 	return __do_x();
> }
> #else
> static inline int do_x()
> {
> 	if (!ops)
> 		return -EOPNOTSUPP;
> 	return ops->do_x();
> }
> #endif
> 
> But that's perhaps doing too much...

I would say it is too far. Two ways of doing the same thing requires
twice as much testing. And these are not hot paths where we want to
eliminate as many instructions and trampolines as possible.

	  Andrew
