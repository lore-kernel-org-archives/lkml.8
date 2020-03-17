Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CBFC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97236205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442976;
	bh=WmQMtFlFuWM8UAdTqDefAdqQWp5f7Yzm9W5ltalm9/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ToN2NLlz8WwBafQVFWcP5b17pWlQ2tlkvrNMUxu5Tzb++ef7N8nW9BG+odNrBtmQR
	 jmWSfvvFHwb9hrYXcTO8E27eV+BQ0NVXXaPodRs84bR0XcGvl2NaFetF9DJ1ccUBM1
	 2qDMqGVscv08/wZcRXOCU2EdIK+wPMa7xqRFDRgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgCQLCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgCQLCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:02:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C2D205ED;
        Tue, 17 Mar 2020 11:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442971;
        bh=WmQMtFlFuWM8UAdTqDefAdqQWp5f7Yzm9W5ltalm9/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOzGLU9p4JA/7asID+fqaLWyKjEE4XMX/99+l+T8OM0rLBWoTRAA49NrvGq7cIwst
         cnVgzN2M8ze4FnR+66qXv/lr3Vzmgu+5hHZ6QIhfws4JlDk6ix1AAuGLkUykdNWxOc
         R61thBL/a8THtkzZMoYreJi6WSqul5YcDnSTZRks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 052/123] net: phy: fix MDIO bus PM PHY resuming
Date:   Tue, 17 Mar 2020 11:54:39 +0100
Message-Id: <20200317103313.017171835@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 611d779af7cad2b87487ff58e4931a90c20b113c ]

So far we have the unfortunate situation that mdio_bus_phy_may_suspend()
is called in suspend AND resume path, assuming that function result is
the same. After the original change this is no longer the case,
resulting in broken resume as reported by Geert.

To fix this call mdio_bus_phy_may_suspend() in the suspend path only,
and let the phy_device store the info whether it was suspended by
MDIO bus PM.

Fixes: 503ba7c69610 ("net: phy: Avoid multiple suspends")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |    6 +++++-
 include/linux/phy.h          |    2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -284,6 +284,8 @@ static int mdio_bus_phy_suspend(struct d
 	if (!mdio_bus_phy_may_suspend(phydev))
 		return 0;
 
+	phydev->suspended_by_mdio_bus = 1;
+
 	return phy_suspend(phydev);
 }
 
@@ -292,9 +294,11 @@ static int mdio_bus_phy_resume(struct de
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
-	if (!mdio_bus_phy_may_suspend(phydev))
+	if (!phydev->suspended_by_mdio_bus)
 		goto no_resume;
 
+	phydev->suspended_by_mdio_bus = 0;
+
 	ret = phy_resume(phydev);
 	if (ret < 0)
 		return ret;
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -336,6 +336,7 @@ struct phy_c45_device_ids {
  * is_gigabit_capable: Set to true if PHY supports 1000Mbps
  * has_fixups: Set to true if this phy has fixups/quirks.
  * suspended: Set to true if this phy has been suspended successfully.
+ * suspended_by_mdio_bus: Set to true if this phy was suspended by MDIO bus.
  * sysfs_links: Internal boolean tracking sysfs symbolic links setup/removal.
  * loopback_enabled: Set true if this phy has been loopbacked successfully.
  * state: state of the PHY for management purposes
@@ -372,6 +373,7 @@ struct phy_device {
 	unsigned is_gigabit_capable:1;
 	unsigned has_fixups:1;
 	unsigned suspended:1;
+	unsigned suspended_by_mdio_bus:1;
 	unsigned sysfs_links:1;
 	unsigned loopback_enabled:1;
 


