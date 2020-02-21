Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189DEC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD482208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBUToM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:44:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40490 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBUToM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:44:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D038B14648EF7;
        Fri, 21 Feb 2020 11:44:11 -0800 (PST)
Date:   Fri, 21 Feb 2020 11:44:11 -0800 (PST)
Message-Id: <20200221.114411.2138437746889179289.davem@davemloft.net>
To:     dmurphy@ti.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: phy: dp83867: Add speed optimization
 feature
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200218141130.28825-1-dmurphy@ti.com>
References: <20200218141130.28825-1-dmurphy@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Feb 2020 11:44:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>
Date: Tue, 18 Feb 2020 08:11:30 -0600

> Set the speed optimization bit on the DP83867 PHY.
> This feature can also be strapped on the 64 pin PHY devices
> but the 48 pin devices do not have the strap pin available to enable
> this feature in the hardware.  PHY team suggests to have this bit set.
> 
> With this bit set the PHY will auto negotiate and report the link
> parameters in the PHYSTS register.  This register provides a single
> location within the register set for quick access to commonly accessed
> information.
> 
> In this case when auto negotiation is on the PHY core reads the bits
> that have been configured or if auto negotiation is off the PHY core
> reads the BMCR register and sets the phydev parameters accordingly.
> 
> This Giga bit PHY can throttle the speed to 100Mbps or 10Mbps to accomodate a
> 4-wire cable.  If this should occur the PHYSTS register contains the
> current negotiated speed and duplex mode.
> 
> In overriding the genphy_read_status the dp83867_read_status will do a
> genphy_read_status to setup the LP and pause bits.  And then the PHYSTS
> register is read and the phydev speed and duplex mode settings are
> updated.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Applied to net-next, thank you.
