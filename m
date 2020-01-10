Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B6C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E748B2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vhBKJSyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgAJUHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:07:00 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58702 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgAJUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:06:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00AK6sSB128949;
        Fri, 10 Jan 2020 14:06:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578686814;
        bh=PIF2JGaqRnB1v2+yrLzg4ZEhayCQbvSjK4TRTvSQASw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vhBKJSyu7hMVjA0FhGfJy+uCJ708DVMFHRfJmxOG0BDEMRiQBubpVfeq3cPsWT1Lg
         CKOzYjBgV38OtDDmJSBltBQGEzi/sE6DXXaKJR5yUWKBaM95rbMEKGPaxqmTOHN6/y
         +UXRTFJGIHIZ0axjENTSS5Qj5kve0QP2WeBA08Ns=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00AK6sJw029455;
        Fri, 10 Jan 2020 14:06:54 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 10
 Jan 2020 14:06:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 10 Jan 2020 14:06:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00AK6sJt100535;
        Fri, 10 Jan 2020 14:06:54 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH netdev v2 2/2] net: phy: DP83822: Update Kconfig with DP83825I support
Date:   Fri, 10 Jan 2020 14:03:57 -0600
Message-ID: <20200110200357.26232-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200110200357.26232-1-dmurphy@ti.com>
References: <20200110200357.26232-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Kconfig description to indicate support for the DP83825I
device as well.

Fixes: 32b12dc8fde1  ("net: phy: Add DP83825I to the DP83822 driver")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index ed606194dbd0..8dc461f7574b 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -340,9 +340,9 @@ config DAVICOM_PHY
 	  Currently supports dm9161e and dm9131
 
 config DP83822_PHY
-	tristate "Texas Instruments DP83822 PHY"
+	tristate "Texas Instruments DP83822/825 PHYs"
 	---help---
-	  Supports the DP83822 PHY.
+	  Supports the DP83822 and DP83825I PHYs.
 
 config DP83TC811_PHY
 	tristate "Texas Instruments DP83TC811 PHY"
-- 
2.23.0

