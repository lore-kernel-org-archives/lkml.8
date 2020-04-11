Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D3C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7375A20787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646438;
	bh=IT2dpvuhQRgPNvyLZRD7w/pa0g6v4inA8jgzzkKTuvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TZ8MqumI3vd9/p1ZiUDu7uMA2+LoU2QLXD15DPRPgOvoA+2mOYYfIiRnjyyXR08Uc
	 U57/N/VOJNLsdpq4awq77lgXnsSxC+zCzFGGMd3HO4fmCKI6fFpmccUhqyfOtt25ZG
	 o1T9Cme8DocLCDneRD/wknZPj8NamRqqKredsBuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgDKXHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgDKXHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E3D320708;
        Sat, 11 Apr 2020 23:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646431;
        bh=IT2dpvuhQRgPNvyLZRD7w/pa0g6v4inA8jgzzkKTuvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcdomg0+k5DwbTl/XLxMzY74iMsbxR72RlDJJA6R+b/eJ1UGcJ6STe7asl5uV0F7v
         hiwDnhrBhof7SJH5aQ7rYs6em6fimugYL08hwlpJyk9RTjmi25V7wFoBueeesQHZ2H
         PCeGUyWk1y7pjoYVTw3nXZlFr/sxmeoka90tpi34=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 004/121] net: phy: probe PHY drivers synchronously
Date:   Sat, 11 Apr 2020 19:05:09 -0400
Message-Id: <20200411230706.23855-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 16983507742cbcaa5592af530872a82e82fb9c51 ]

If we have scenarios like

mdiobus_register()
	-> loads PHY driver module(s)
	-> registers PHY driver(s)
	-> may schedule async probe
phydev = mdiobus_get_phy()
<phydev action involving PHY driver>

or

phydev = phy_device_create()
	-> loads PHY driver module
	-> registers PHY driver
	-> may schedule async probe
<phydev action involving PHY driver>

then we expect the PHY driver to be bound to the phydev when triggering
the action. This may not be the case in case of asynchronous probing.
Therefore ensure that PHY drivers are probed synchronously.

Default still is sync probing, except async probing is explicitly
requested. I saw some comments that the intention is to promote
async probing for more parallelism in boot process and want to be
prepared for the case that the default is changed to async probing.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index fe34e85c0e163..634b4c89f8c8b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2527,6 +2527,7 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.probe = phy_probe;
 	new_driver->mdiodrv.driver.remove = phy_remove;
 	new_driver->mdiodrv.driver.owner = owner;
+	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
 	retval = driver_register(&new_driver->mdiodrv.driver);
 	if (retval) {
-- 
2.20.1

