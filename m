Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094CBC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66CA20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442575;
	bh=3s+7XsyloAUsmHodKZGkHSPBfDLX5+udWxEX9S0g9h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mLlS16WT9x4NvYRUC8ygE10gFh1dNKieNsTKRz/2WvsqddU5cVC6gzwX8EKLcooQn
	 LtZdoAmTooyM/LKIHtH2x8bgDso44LUFFm+XTM1jayEtFa7EtI7WA0Im5sY9itVnWk
	 Xq+LVSELeXQWKOQBdZGCxKali4yLIWTkO4muLkHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgCQK4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgCQK4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:56:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46CF220714;
        Tue, 17 Mar 2020 10:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442573;
        bh=3s+7XsyloAUsmHodKZGkHSPBfDLX5+udWxEX9S0g9h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2OlCdjx/ELTPDVTfm4ASH8r94ERo2oZP0OkLgMKafg/LdKtjVThPyNoBMNDvkXht
         42R5YsjXtYBb0o2c3QmWgtpPw8/isPugs5Ak30ltSfmQQ/u3DcN10hkvWgYbqSjmrq
         3X+IPnp85nrWef/u3OnDDRa+R1xWxRflLOaouVc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 01/89] phy: Revert toggling reset changes.
Date:   Tue, 17 Mar 2020 11:54:10 +0100
Message-Id: <20200317103259.926774121@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David S. Miller <davem@davemloft.net>

commit 7b566f70e1bf65b189b66eb3de6f431c30f7dff2 upstream.

This reverts:

ef1b5bf506b1 ("net: phy: Fix not to call phy_resume() if PHY is not attached")
8c85f4b81296 ("net: phy: micrel: add toggling phy reset if PHY is not  attached")

Andrew Lunn informs me that there are alternative efforts
underway to fix this more properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
[just take the ef1b5bf506b1 revert - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/phy/phy_device.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -76,7 +76,7 @@ static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
 #ifdef CONFIG_PM
-static bool mdio_bus_phy_may_suspend(struct phy_device *phydev, bool suspend)
+static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
 	struct phy_driver *phydrv = to_phy_driver(drv);
@@ -88,11 +88,10 @@ static bool mdio_bus_phy_may_suspend(str
 	/* PHY not attached? May suspend if the PHY has not already been
 	 * suspended as part of a prior call to phy_disconnect() ->
 	 * phy_detach() -> phy_suspend() because the parent netdev might be the
-	 * MDIO bus driver and clock gated at this point. Also may resume if
-	 * PHY is not attached.
+	 * MDIO bus driver and clock gated at this point.
 	 */
 	if (!netdev)
-		return suspend ? !phydev->suspended : phydev->suspended;
+		return !phydev->suspended;
 
 	if (netdev->wol_enabled)
 		return false;
@@ -127,7 +126,7 @@ static int mdio_bus_phy_suspend(struct d
 	if (phydev->attached_dev && phydev->adjust_link)
 		phy_stop_machine(phydev);
 
-	if (!mdio_bus_phy_may_suspend(phydev, true))
+	if (!mdio_bus_phy_may_suspend(phydev))
 		return 0;
 
 	return phy_suspend(phydev);
@@ -138,7 +137,7 @@ static int mdio_bus_phy_resume(struct de
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
-	if (!mdio_bus_phy_may_suspend(phydev, false))
+	if (!mdio_bus_phy_may_suspend(phydev))
 		goto no_resume;
 
 	ret = phy_resume(phydev);


