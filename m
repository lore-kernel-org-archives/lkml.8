Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9069FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7374320760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgF3Apv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:45:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38336 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbgF3Apv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:45:51 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jq4P9-002ult-87; Tue, 30 Jun 2020 02:45:43 +0200
Date:   Tue, 30 Jun 2020 02:45:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robh+dt@kernel.org, frowand.list@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: of_mdio: count number of regitered phys
Message-ID: <20200630004543.GB597495@lunn.ch>
References: <1593415596-9487-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593415596-9487-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:26:36AM +0300, Claudiu Beznea wrote:
> In case of_mdiobus_register_phy()/of_mdiobus_register_device()
> returns -ENODEV for all PHYs in device tree or for all scanned
> PHYs there is a chance that of_mdiobus_register() to
> return success code although no PHY devices were registered.
> Add a counter that increments every time a PHY was registered
> to avoid the above scenario.

Hi Claudiu

There is a danger here this will break something. Without this patch,
an empty bus is O.K. But with this patch, a bus without a PHY is a
problem.

Take for example FEC. It often comes in pairs. Each has an MDIO
bus. But to save pins, there are some designs which place two PHYs on
one bus, leaving the other empty. The driver unconditionally calls
of_mdiobus_register() and if it returns an error, it will error out
the probe. So i would not be too surprised if you get reports of
missing interfaces with this patch.

	Andrew
