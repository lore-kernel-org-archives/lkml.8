Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DE6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1977B2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863747;
	bh=dwWc+YA/NzjoWG3ST7dmjkFbGLgxkUbtwwN37lmLkg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cdcylazPyIwx+YB5aB++cHV0hT1jJOSJZ+VTYsm6DmFM68iP6Qi4VuulofLtIy+bv
	 PVIAgkyfuHjLHXqbM1ppocBKxs/EQ5siYlLI7XFfjkgmdso6ocS3aOCXmlE5XNYq8S
	 cQ2cd+5QINFW673DHsT0L/xtiMdx4tixFCyy95Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbgAXLC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:02:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733245AbgAXLCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:02:23 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FEDA2075D;
        Fri, 24 Jan 2020 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863743;
        bh=dwWc+YA/NzjoWG3ST7dmjkFbGLgxkUbtwwN37lmLkg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wwdjqfRVLppZjuOfrBYJK5Fd6Zc4DI0tffS6CAG9Zok7HAbA5YzYyAAooKvCRWFRT
         EzAfwC3fOc70cQALKEad67MMPUkM1YE6GZd3f7pvRk0LV2TDIQ1PgKa8tlwXgYPybZ
         AnbJ+8Zcs0E0V8zXmoWM8i5jzvtr6zheBU7h+Vv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/639] net: phy: Fix not to call phy_resume() if PHY is not attached
Date:   Fri, 24 Jan 2020 10:24:06 +0100
Message-Id: <20200124093056.914884857@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit ef1b5bf506b1f0ee3edc98533e1f3ecb105eb46a ]

This patch fixes an issue that mdio_bus_phy_resume() doesn't call
phy_resume() if the PHY is not attached.

Fixes: 803dd9c77ac3 ("net: phy: avoid suspending twice a PHY")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 43c4f358eeb8a..9c7e51443f6b6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -76,7 +76,7 @@ static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
 #ifdef CONFIG_PM
-static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
+static bool mdio_bus_phy_may_suspend(struct phy_device *phydev, bool suspend)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
 	struct phy_driver *phydrv = to_phy_driver(drv);
@@ -88,10 +88,11 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	/* PHY not attached? May suspend if the PHY has not already been
 	 * suspended as part of a prior call to phy_disconnect() ->
 	 * phy_detach() -> phy_suspend() because the parent netdev might be the
-	 * MDIO bus driver and clock gated at this point.
+	 * MDIO bus driver and clock gated at this point. Also may resume if
+	 * PHY is not attached.
 	 */
 	if (!netdev)
-		return !phydev->suspended;
+		return suspend ? !phydev->suspended : phydev->suspended;
 
 	if (netdev->wol_enabled)
 		return false;
@@ -126,7 +127,7 @@ static int mdio_bus_phy_suspend(struct device *dev)
 	if (phydev->attached_dev && phydev->adjust_link)
 		phy_stop_machine(phydev);
 
-	if (!mdio_bus_phy_may_suspend(phydev))
+	if (!mdio_bus_phy_may_suspend(phydev, true))
 		return 0;
 
 	return phy_suspend(phydev);
@@ -137,7 +138,7 @@ static int mdio_bus_phy_resume(struct device *dev)
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
-	if (!mdio_bus_phy_may_suspend(phydev))
+	if (!mdio_bus_phy_may_suspend(phydev, false))
 		goto no_resume;
 
 	ret = phy_resume(phydev);
-- 
2.20.1



