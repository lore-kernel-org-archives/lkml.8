Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D86DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DD620723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgEVVbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:31:19 -0400
Received: from foss.arm.com ([217.140.110.172]:42338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731153AbgEVVbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:31:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F54E142F;
        Fri, 22 May 2020 14:31:12 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2849E3F68F;
        Fri, 22 May 2020 14:31:12 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        madalin.bucur@oss.nxp.com, calvin.johnson@oss.nxp.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 05/11] net: phy: Scan the entire MMD device space
Date:   Fri, 22 May 2020 16:30:53 -0500
Message-Id: <20200522213059.1535892-6-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200522213059.1535892-1-jeremy.linton@arm.com>
References: <20200522213059.1535892-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spec identifies devices in the top of
the 32-bit device space. Some phys are actually
responding that high. Lets try and capture their
information as well.

Starting at the reserved address 0, lets scan
every single possible MMD address. The spec
seems to indicate that every MMD should respond
with the same devices list. But it seems this
is being interpreted that only implemented MMDs
need respond. Since it doesn't appear to hurt to
scan reserved addresses, and the spec says that
access to unimplemented registers should return 0
(despite this some devices appear to be returning
0xFFFFFFFF) we are just going to ignore anything
that doesn't look like a valid return.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/phy/phy_device.c | 8 +++-----
 include/linux/phy.h          | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2d677490ecab..360c3a72c498 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -743,7 +743,8 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 	bool valid_id = false;
 
 	/* Find first non-zero Devices In package. Device zero is reserved
-	 * for 802.3 c45 complied PHYs, so don't probe it at first.
+	 * for 802.3 c45 complied PHYs, We will ask it for a devices list,
+	 * but later we won't ask for identification from it.
 	 */
 	for (i = 0; i < num_ids && *devs == 0; i++) {
 		ret = get_phy_c45_devs_in_pkg(bus, addr, i, devs);
@@ -756,10 +757,7 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 			 *  10G PHYs have zero Devices In package,
 			 *  e.g. Cortina CS4315/CS4340 PHY.
 			 */
-			phy_reg = get_phy_c45_devs_in_pkg(bus, addr, 0, devs);
-			if (phy_reg < 0)
-				return -EIO;
-			break;
+			*devs = 0;
 		}
 	}
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 2432ca463ddc..480a6b153227 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -346,7 +346,7 @@ enum phy_state {
  */
 struct phy_c45_device_ids {
 	u32 devices_in_package;
-	u32 device_ids[8];
+	u32 device_ids[32];
 };
 
 struct macsec_context;
-- 
2.26.2

