Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060F2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5482088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgGBP4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:56:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:45312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgGBP4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:56:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6B05ACAE;
        Thu,  2 Jul 2020 15:56:52 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 42F986038B; Thu,  2 Jul 2020 17:56:52 +0200 (CEST)
Date:   Thu, 2 Jul 2020 17:56:52 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/4] net: ethtool: Untangle PHYLIB dependency
Message-ID: <20200702155652.ivokudjptoect6ch@lion.mk-sys.cz>
References: <20200702042942.76674-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702042942.76674-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 09:29:38PM -0700, Florian Fainelli wrote:
> Hi all,
> 
> This patch series untangles the ethtool netlink dependency with PHYLIB
> which exists because the cable test feature calls directly into PHY
> library functions. The approach taken here is to utilize a new set of
> net_device_ops function pointers which are automatically set to the PHY
> library variants when a network device driver attaches to a PHY device.

I'm not sure about the idea of creating a copy of netdev_ops for each
device using phylib. First, there would be some overhead (just checked
my 5.8-rc3 kernel, struct netdev_ops is 632 bytes). Second, there is
quite frequent pattern of comparing dev->netdev_ops against known
constants to check if a network device is of certain type; I can't say
for sure if it is also used with devices using phylib in existing code
but it feels risky.

As the two pointers are universal for all devices, couldn't we simply
use one global structure with them like we do for IPv6 (ipv6_stub) or
some netfilter modules (e.g. nf_ct_hook)?

Michal

> Florian Fainelli (4):
>   net: Add cable test netdevice operations
>   net: phy: Change cable test arguments to net_device
>   net: phy: Automatically set-up cable test netdev_ops
>   net: ethtool: Remove PHYLIB dependency
> 
>  drivers/net/phy/phy.c        | 18 ++++++++++++++----
>  drivers/net/phy/phy_device.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/netdevice.h    | 14 ++++++++++++++
>  include/linux/phy.h          | 10 ++++++----
>  net/Kconfig                  |  1 -
>  net/ethtool/cabletest.c      | 12 ++++++++----
>  6 files changed, 74 insertions(+), 13 deletions(-)
> 
> -- 
> 2.25.1
> 
