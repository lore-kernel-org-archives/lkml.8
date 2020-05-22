Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B59C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2984620757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgEVVbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:31:36 -0400
Received: from foss.arm.com ([217.140.110.172]:42348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731174AbgEVVbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:31:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FBE5143B;
        Fri, 22 May 2020 14:31:14 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48A573F68F;
        Fri, 22 May 2020 14:31:14 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        madalin.bucur@oss.nxp.com, calvin.johnson@oss.nxp.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 09/11] net: phy: Refuse to consider phy_id=0 a valid phy
Date:   Fri, 22 May 2020 16:30:57 -0500
Message-Id: <20200522213059.1535892-10-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200522213059.1535892-1-jeremy.linton@arm.com>
References: <20200522213059.1535892-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another one of those questionable commits. In this
case a bus tagged C45_FIRST refuses to create phys
where the phy id is invalid. In general this is probably a
good idea, but might cause problems. Another idea might be to
create an additional flag (MDIOBUS_STRICT_ID?) for this case.

Or we just ignore it and accept that the probe logic as it
stands potentially creates bogus phy devices, to avoid the
case where an actual phy exists but isn't responding correctly.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/phy/phy_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index acdada865864..e74f2ef6f12b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -789,7 +789,9 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 	if (!valid_id && c22_present)
 	        return 0;
 
-	*phy_id = 0;
+	if (valid_id || bus->probe_capabilities != MDIOBUS_C45_FIRST)
+		*phy_id = 0;
+
 	return 0;
 }
 
@@ -853,6 +855,10 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 	if ((phy_id & 0x1fffffff) == 0x1fffffff)
 		return ERR_PTR(-ENODEV);
 
+	/* Strict scanning should also ignore phy_id = 0 */
+	if (phy_id == 0 && bus->probe_capabilities == MDIOBUS_C45_FIRST)
+		return ERR_PTR(-ENODEV);
+
 	return phy_device_create(bus, addr, phy_id, is_c45, &c45_ids);
 }
 EXPORT_SYMBOL(get_phy_device);
-- 
2.26.2

