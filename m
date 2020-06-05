Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053FAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96F0206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ilwZxlO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgFEUvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:51:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33452 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgFEUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:51:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 055KpBnl035088;
        Fri, 5 Jun 2020 15:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591390271;
        bh=jUzHNLbPf81riWeo8eVPKgNd4GT0yaOWof+Kk6oh2ds=;
        h=From:To:CC:Subject:Date;
        b=ilwZxlO9voUaOt9E7uJLygZCrEXd+dXc5SpSXm/M1pLNnXk++FwaJHaflq6fRh6BN
         KiH/hfVoVFBVaj48GCiA6IXAGbmyXgJtCn6F7aafBdjrDy+vYj5VBhb5CZO2V3Y/TV
         VyEqgpJTbdOfCxIRlhRlHaYbwPjp2Xg25MugSQFs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 055KpBx6016456
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Jun 2020 15:51:11 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Jun
 2020 15:51:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Jun 2020 15:51:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 055Kp9BC033433;
        Fri, 5 Jun 2020 15:51:09 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net] net: dp83869: Reset return variable if PHY strap is read
Date:   Fri, 5 Jun 2020 15:51:03 -0500
Message-ID: <20200605205103.29663-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the PHY's strap register is read to determine if lane swapping is
needed the phy_read_mmd returns the value back into the ret variable.

If the call to read the strap fails the failed value is returned.  If
the call to read the strap is successful then ret is possibly set to a
non-zero positive number. Without reseting the ret value to 0 this will
cause the parse DT function to return a failure.

Fixes: c4566aec6e808 ("net: phy: dp83869: Update port-mirroring to read straps")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/phy/dp83869.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index df85ae5b79e4..53ed3abc26c9 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -218,10 +218,13 @@ static int dp83869_of_init(struct phy_device *phydev)
 		ret = phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_STRAP_STS1);
 		if (ret < 0)
 			return ret;
+
 		if (ret & DP83869_STRAP_MIRROR_ENABLED)
 			dp83869->port_mirroring = DP83869_PORT_MIRRORING_EN;
 		else
 			dp83869->port_mirroring = DP83869_PORT_MIRRORING_DIS;
+
+		ret = 0;
 	}
 
 	if (of_property_read_u32(of_node, "rx-fifo-depth",
-- 
2.26.2

