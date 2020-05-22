Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC019C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFDE2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgEVVbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:31:55 -0400
Received: from foss.arm.com ([217.140.110.172]:42348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbgEVVbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:31:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9267C13A1;
        Fri, 22 May 2020 14:31:11 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B6DE3F68F;
        Fri, 22 May 2020 14:31:11 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        madalin.bucur@oss.nxp.com, calvin.johnson@oss.nxp.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 04/11] net: phy: Handle c22 regs presence better
Date:   Fri, 22 May 2020 16:30:52 -0500
Message-Id: <20200522213059.1535892-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200522213059.1535892-1-jeremy.linton@arm.com>
References: <20200522213059.1535892-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until this point, we have been sanitizing the c22
regs presence bit out of all the MMD device lists.
This is incorrect as it causes the 0xFFFFFFFF checks
to incorrectly fail. Further, it turns out that we
want to utilize this flag to make a determination that
there is actually a phy at this location and we should
be accessing it using c22.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/phy/phy_device.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f0761fa5e40b..2d677490ecab 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -689,9 +689,6 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
 		return -EIO;
 	*devices_in_package |= phy_reg;
 
-	/* Bit 0 doesn't represent a device, it indicates c22 regs presence */
-	*devices_in_package &= ~BIT(0);
-
 	return 0;
 }
 
@@ -742,6 +739,8 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 	int i;
 	const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
 	u32 *devs = &c45_ids->devices_in_package;
+	bool c22_present = false;
+	bool valid_id = false;
 
 	/* Find first non-zero Devices In package. Device zero is reserved
 	 * for 802.3 c45 complied PHYs, so don't probe it at first.
@@ -770,6 +769,10 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 		return 0;
 	}
 
+	/* Bit 0 doesn't represent a device, it indicates c22 regs presence */
+	c22_present = *devs & BIT(0);
+	*devs &= ~BIT(0);
+
 	/* Now probe Device Identifiers for each device present. */
 	for (i = 1; i < num_ids; i++) {
 		if (!(c45_ids->devices_in_package & (1 << i)))
@@ -778,6 +781,13 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 		ret = _get_phy_id(bus, addr, i, &c45_ids->device_ids[i], true);
 		if (ret < 0)
 			return ret;
+		if (valid_phy_id(c45_ids->device_ids[i]))
+			valid_id = true;
+	}
+
+	if (!valid_id && c22_present) {
+		*phy_id = 0xffffffff;
+	        return 0;
 	}
 	*phy_id = 0;
 	return 0;
-- 
2.26.2

