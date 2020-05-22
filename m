Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4323BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2404920723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbgEVVbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:31:16 -0400
Received: from foss.arm.com ([217.140.110.172]:42348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731157AbgEVVbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:31:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B70541FB;
        Fri, 22 May 2020 14:31:12 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFFF53F68F;
        Fri, 22 May 2020 14:31:12 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        madalin.bucur@oss.nxp.com, calvin.johnson@oss.nxp.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 06/11] net: phy: Hoist no phy detected state
Date:   Fri, 22 May 2020 16:30:54 -0500
Message-Id: <20200522213059.1535892-7-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200522213059.1535892-1-jeremy.linton@arm.com>
References: <20200522213059.1535892-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default initializing the phy_id to "invalid" allows
us to avoid setting it on the error returns.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/phy/phy_device.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 360c3a72c498..b2cd22d6315c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -742,6 +742,7 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 	bool c22_present = false;
 	bool valid_id = false;
 
+	*phy_id = 0xffffffff;
 	/* Find first non-zero Devices In package. Device zero is reserved
 	 * for 802.3 c45 complied PHYs, We will ask it for a devices list,
 	 * but later we won't ask for identification from it.
@@ -762,10 +763,8 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 	}
 
 	/* no reported devices */
-	if (!valid_phy_id(*devs)) {
-		*phy_id = 0xffffffff;
+	if (!valid_phy_id(*devs))
 		return 0;
-	}
 
 	/* Bit 0 doesn't represent a device, it indicates c22 regs presence */
 	c22_present = *devs & BIT(0);
@@ -783,10 +782,9 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 			valid_id = true;
 	}
 
-	if (!valid_id && c22_present) {
-		*phy_id = 0xffffffff;
+	if (!valid_id && c22_present)
 	        return 0;
-	}
+
 	*phy_id = 0;
 	return 0;
 }
-- 
2.26.2

