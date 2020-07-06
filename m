Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B165220715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgGFNqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:46:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49012 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgGFNqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:46:50 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jsRSB-003rc7-La; Mon, 06 Jul 2020 15:46:39 +0200
Date:   Mon, 6 Jul 2020 15:46:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/3]  net: ethtool: Untangle PHYLIB dependency
Message-ID: <20200706134639.GA919533@lunn.ch>
References: <20200706042758.168819-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706042758.168819-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 09:27:55PM -0700, Florian Fainelli wrote:
> Hi all,
> 
> This patch series untangles the ethtool netlink dependency with PHYLIB
> which exists because the cable test feature calls directly into PHY
> library functions. The approach taken here is to introduce
> ethtool_phy_ops function pointers which can be dynamically registered
> when PHYLIB loads.
 
Hi Florian

This looks good. I would suggest leaving it a day or two for 0-day to
randconfig it for a while.

	   Andrew
