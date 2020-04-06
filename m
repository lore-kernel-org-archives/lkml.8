Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE6EC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCFE249BC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgDFRI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:08:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57220 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgDFRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:08:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6EC4415DA0AE6;
        Mon,  6 Apr 2020 10:08:25 -0700 (PDT)
Date:   Mon, 06 Apr 2020 10:08:23 -0700 (PDT)
Message-Id: <20200406.100823.2156599779063686930.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, kuba@kernel.org, andrew@lunn.ch,
        vivien.didelot@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: bcm_sf2: Do not register slave MDIO bus
 with OF
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200404213517.12783-1-f.fainelli@gmail.com>
References: <20200404213517.12783-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Apr 2020 10:08:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sat,  4 Apr 2020 14:35:17 -0700

> We were registering our slave MDIO bus with OF and doing so with
> assigning the newly created slave_mii_bus of_node to the master MDIO bus
> controller node. This is a bad thing to do for a number of reasons:
> 
> - we are completely lying about the slave MII bus is arranged and yet we
>   still want to control which MDIO devices it probes. It was attempted
>   before to play tricks with the bus_mask to perform that:
>   https://www.spinics.net/lists/netdev/msg429420.html but the approach
>   was rightfully rejected
> 
> - the device_node reference counting is messed up and we are effectively
>   doing a double probe on the devices we already probed using the
>   master, this messes up all resources reference counts (such as clocks)
> 
> The proper fix for this as indicated by David in his reply to the
> thread above is to use a platform data style registration so as to
> control exactly which devices we probe:
> https://www.spinics.net/lists/netdev/msg430083.html
> 
> By using mdiobus_register(), our slave_mii_bus->phy_mask value is used
> as intended, and all the PHY addresses that must be redirected towards
> our slave MDIO bus is happening while other addresses get redirected
> towards the master MDIO bus.
> 
> Fixes: 461cd1b03e32 ("net: dsa: bcm_sf2: Register our slave MDIO bus")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied and queued up for -stable.
