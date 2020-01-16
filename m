Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E952C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6E920730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194205;
	bh=QdBoVwWQMq0aqvMeaztun3dghZY+IZ7Q6+kCOypgPlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t3z149ytBvef3oDFEAeLwtnpu7TG884w0Q4kQmFqJcOeSRzXg21qahlQIwWpBHj3H
	 3oM4ectUTEKbWYw0IU8Jo/IeKbAXKOHwPnKuyF7K7vxSM82tCYUZ7zppkU9nmJJQCa
	 2MxS1MEkNo2QgGdYCMKUjF7XtUZ0TIBa2/+7r790=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbgAPRDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:03:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388586AbgAPRDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:03:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F5820730;
        Thu, 16 Jan 2020 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194190;
        bh=QdBoVwWQMq0aqvMeaztun3dghZY+IZ7Q6+kCOypgPlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsapOdpE39YLN4TQg661R73BwU8mLL9zPZomadHbCuyHs0gLN1mBFcx/RDY3QC7s3
         7974fOAPHmnRhT7iNDDV4YdT7+vdl48ENgkOxXVqk2HJOGPgWD4zkUnyh3IPYpqMhu
         Fd+PJArmXgOIL8gYcrHeW42SppzchEB7GRdwSdug=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 262/671] net: dsa: Avoid null pointer when failing to connect to PHY
Date:   Thu, 16 Jan 2020 11:52:51 -0500
Message-Id: <20200116165940.10720-145-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

[ Upstream commit 6146dd453e235c487d85ae4dc6cc08978a1c890f ]

When phylink_of_phy_connect fails, dsa_slave_phy_setup tries to save the
day by connecting to an alternative PHY, none other than a PHY on the
switch's internal MDIO bus, at an address equal to the port's index.

However this does not take into consideration the scenario when the
switch that failed to probe an external PHY does not have an internal
MDIO bus at all.

Fixes: aab9c4067d23 ("net: dsa: Plug in PHYLINK support")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/slave.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index b39720d0995d..8ee28b6016d8 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1219,9 +1219,9 @@ static int dsa_slave_phy_setup(struct net_device *slave_dev)
 		phy_flags = ds->ops->get_phy_flags(ds, dp->index);
 
 	ret = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
-	if (ret == -ENODEV) {
-		/* We could not connect to a designated PHY or SFP, so use the
-		 * switch internal MDIO bus instead
+	if (ret == -ENODEV && ds->slave_mii_bus) {
+		/* We could not connect to a designated PHY or SFP, so try to
+		 * use the switch internal MDIO bus instead
 		 */
 		ret = dsa_slave_phy_connect(slave_dev, dp->index);
 		if (ret) {
@@ -1233,7 +1233,7 @@ static int dsa_slave_phy_setup(struct net_device *slave_dev)
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct lock_class_key dsa_slave_netdev_xmit_lock_key;
-- 
2.20.1

