Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC93C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E1E2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFQQTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:19:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44332 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQQTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:19:34 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jlamb-000yiz-7I; Wed, 17 Jun 2020 18:19:25 +0200
Date:   Wed, 17 Jun 2020 18:19:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kevin Groeneveld <kgroeneveld@gmail.com>
Subject: Re: [PATCH net v1] net: phy: smsc: fix printing too many logs
Message-ID: <20200617161925.GE205574@lunn.ch>
References: <20200617153340.17371-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617153340.17371-1-zhengdejin5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:33:40PM +0800, Dejin Zheng wrote:
> Commit 7ae7ad2f11ef47 ("net: phy: smsc: use phy_read_poll_timeout()
> to simplify the code") will print a lot of logs as follows when Ethernet
> cable is not connected:
> 
> [    4.473105] SMSC LAN8710/LAN8720 2188000.ethernet-1:00: lan87xx_read_status failed: -110
> 
> So fix it by read_poll_timeout().

Do you have a more detailed explanation of what is going on here?

After a lot of thought, i think i can see how this happens. But the
commit message should really spell out why this is the correct fix.

Thanks
	Andrew
