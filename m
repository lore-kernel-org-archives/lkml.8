Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A9120757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgEVVbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:31:13 -0400
Received: from foss.arm.com ([217.140.110.172]:42324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731128AbgEVVbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:31:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E850E106F;
        Fri, 22 May 2020 14:31:09 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0C5D3F68F;
        Fri, 22 May 2020 14:31:09 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        madalin.bucur@oss.nxp.com, calvin.johnson@oss.nxp.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 02/11] net: phy: Simplify MMD device list termination
Date:   Fri, 22 May 2020 16:30:50 -0500
Message-Id: <20200522213059.1535892-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200522213059.1535892-1-jeremy.linton@arm.com>
References: <20200522213059.1535892-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are already checking for *devs == 0 after
the loop terminates, we can add a mostly F's check
as well. With that change we can simplify the return/break
sequence inside the loop.

Add a valid_phy_id() macro for this, since we will be using it
in a couple other places.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/phy/phy_device.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 245899b58a7d..7746c07b97fe 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -695,6 +695,11 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
 	return 0;
 }
 
+static bool valid_phy_id(int val)
+{
+	return (val > 0 && ((val & 0x1fffffff) != 0x1fffffff));
+}
+
 /**
  * get_phy_c45_ids - reads the specified addr for its 802.3-c45 IDs.
  * @bus: the target MII bus
@@ -732,18 +737,12 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 			phy_reg = get_phy_c45_devs_in_pkg(bus, addr, 0, devs);
 			if (phy_reg < 0)
 				return -EIO;
-			/* no device there, let's get out of here */
-			if ((*devs & 0x1fffffff) == 0x1fffffff) {
-				*phy_id = 0xffffffff;
-				return 0;
-			} else {
-				break;
-			}
+			break;
 		}
 	}
 
 	/* no reported devices */
-	if (*devs == 0) {
+	if (!valid_phy_id(*devs)) {
 		*phy_id = 0xffffffff;
 		return 0;
 	}
-- 
2.26.2

