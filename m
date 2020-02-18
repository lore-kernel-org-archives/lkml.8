Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD777C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B25D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AoJrD6o2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRMKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:10:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35094 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgBRMKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:10:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01ICAeaH043183;
        Tue, 18 Feb 2020 06:10:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582027840;
        bh=hghT9iQam6tM0rXGoSq9eUjSA8Ysq29n/W7kwiQbjmY=;
        h=From:To:CC:Subject:Date;
        b=AoJrD6o2LucjeNGnQlvONml5K1tkGi3KIKTC9ZXk16t08AwUVaCumVOCkdN+Igs2E
         c4eylGuVt3rWl3LxxG3x2fZLzo4VswZE+F6fGn4BiA0dUJ3EK53GMnWXbpRArmwk7f
         qK65hxRGn48c3JDwrE4J2X+LiJNaQ80/u08FinJQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01ICAe2N037620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Feb 2020 06:10:40 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 06:10:40 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 06:10:40 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01ICAbu4001526;
        Tue, 18 Feb 2020 06:10:38 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>, youling257 <youling257@gmail.com>
Subject: [PATCH] phy: core: Fix phy_get() to not return error on link creation failure
Date:   Tue, 18 Feb 2020 17:44:18 +0530
Message-ID: <20200218121418.6292-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 987351e1ea77 ("phy: core: Add consumer device link support")
added device link support between PHY consumer and PHY provider.
However certain peripherals (DWC3 ULPI) have cyclic dependency
between the PHY provider and PHY consumer causing the device link
creation to fail.

Instead of erroring out on failure to create device link, only add a
debug print to indicate device link creation failed to get USB
working again in multiple platforms.

Fixes: 987351e1ea77 ("phy: core: Add consumer device link support")
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-core.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index cd5a6c95dbdc..a27b8d578d7f 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -688,11 +688,9 @@ struct phy *phy_get(struct device *dev, const char *string)
 	get_device(&phy->dev);
 
 	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link) {
-		dev_err(dev, "failed to create device link to %s\n",
+	if (!link)
+		dev_dbg(dev, "failed to create device link to %s\n",
 			dev_name(phy->dev.parent));
-		return ERR_PTR(-EINVAL);
-	}
 
 	return phy;
 }
@@ -803,11 +801,9 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 	}
 
 	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link) {
-		dev_err(dev, "failed to create device link to %s\n",
+	if (!link)
+		dev_dbg(dev, "failed to create device link to %s\n",
 			dev_name(phy->dev.parent));
-		return ERR_PTR(-EINVAL);
-	}
 
 	return phy;
 }
@@ -852,11 +848,9 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 	devres_add(dev, ptr);
 
 	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
-	if (!link) {
-		dev_err(dev, "failed to create device link to %s\n",
+	if (!link)
+		dev_dbg(dev, "failed to create device link to %s\n",
 			dev_name(phy->dev.parent));
-		return ERR_PTR(-EINVAL);
-	}
 
 	return phy;
 }
-- 
2.17.1

