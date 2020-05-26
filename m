Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B81C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65E820704
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bMJ9mdjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbgEZRs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:48:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53646 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388901AbgEZRsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:48:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04QHmkJn072451;
        Tue, 26 May 2020 12:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590515326;
        bh=5fyUlu/Zprub7RTCYkUniEyaqK7vEi3mHrO00+nEK+o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bMJ9mdjWZTKNNiINC8R3N6m7eWr8M/gwwPkYTynaWCVvZ2gMdlb98Rc+ufTzIHPw/
         OCmyfDthhlH8FTMy7vckz/2FfKQLDzjt7p0YShachFU7dAq3a9kQnbadiUQ4McOzAX
         8beXXNpTuyqZza47I3oiAIXLTNXCFUbO86hY9fqw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04QHmkRK124800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 12:48:46 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 12:47:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 12:47:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04QHlITL022891;
        Tue, 26 May 2020 12:47:18 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <robh@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v3 2/4] net: phy: Add a helper to return the index for of the internal delay
Date:   Tue, 26 May 2020 12:47:14 -0500
Message-ID: <20200526174716.14116-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526174716.14116-1-dmurphy@ti.com>
References: <20200526174716.14116-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function that will return the index in the array for the
passed in internal delay value.  The helper requires the array, size and
delay value.

The helper will then return the index for the exact match or return the
index for the index to the closest smaller value.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/phy/phy_device.c | 94 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  2 +
 2 files changed, 96 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6b30d205642f..667b510c8810 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2661,6 +2661,100 @@ void phy_get_pause(struct phy_device *phydev, bool *tx_pause, bool *rx_pause)
 }
 EXPORT_SYMBOL(phy_get_pause);
 
+static int phy_find_descending_delay(struct phy_device *phydev,
+				     int *delay_values, int size, int int_delay)
+{
+	int i;
+
+	if (int_delay > delay_values[0] || int_delay < delay_values[size - 1]) {
+		phydev_err(phydev, "Delay %d is out of range\n", int_delay);
+		return -EINVAL;
+	}
+
+	if (int_delay == delay_values[0])
+		return 0;
+
+	for (i = 1; i < size; i++) {
+		if (int_delay == delay_values[i])
+			return i;
+
+		/* Find an approximate index by looking up the table */
+		if (int_delay < delay_values[i - 1] &&
+		    int_delay > delay_values[i]) {
+			if (int_delay - delay_values[i - 1] >
+			    delay_values[i] - int_delay)
+				return i + 1;
+			else
+				return i;
+		}
+	}
+
+	phydev_err(phydev, "error finding internal delay index for %d\n",
+		   int_delay);
+	return -EINVAL;
+}
+
+static int phy_find_ascending_delay(struct phy_device *phydev,
+				    int *delay_values, int size, int int_delay)
+{
+	int i;
+
+	if (int_delay < delay_values[0] || int_delay > delay_values[size - 1]) {
+		phydev_err(phydev, "Delay %d is out of range\n", int_delay);
+		return -EINVAL;
+	}
+
+	if (int_delay == delay_values[0])
+		return 0;
+
+	for (i = 1; i < size; i++) {
+		if (int_delay == delay_values[i])
+			return i;
+
+		/* Find an approximate index by looking up the table */
+		if (int_delay > delay_values[i - 1] &&
+		    int_delay < delay_values[i]) {
+			if (int_delay - delay_values[i - 1] <
+			    delay_values[i] - int_delay)
+				return i - 1;
+			else
+				return i;
+		}
+	}
+
+	phydev_err(phydev, "error finding internal delay index for %d\n",
+		   int_delay);
+	return -EINVAL;
+}
+
+/**
+ * phy_get_delay_index - returns the index of the internal delay
+ * @phydev: phy_device struct
+ * @delay_values: array of delays the PHY supports
+ * @size: the size of the delay array
+ * @int_delay: the internal delay to be looked up
+ * @descending: if the delay array is in descending order
+ *
+ * Returns the index within the array of internal delay passed in.
+ * Return errno if the delay is invalid or cannot be found.
+ */
+s32 phy_get_delay_index(struct phy_device *phydev, int *delay_values, int size,
+			int int_delay, bool descending)
+{
+	if (int_delay < 0)
+		return -EINVAL;
+
+	if (size <= 0)
+		return -EINVAL;
+
+	if (descending)
+		return phy_find_descending_delay(phydev, delay_values, size,
+						 int_delay);
+
+	return phy_find_ascending_delay(phydev, delay_values, size, int_delay);
+}
+EXPORT_SYMBOL(phy_get_delay_index);
+
 static bool phy_drv_supports_irq(struct phy_driver *phydrv)
 {
 	return phydrv->config_intr && phydrv->ack_interrupt;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 2bcdf19ed3b4..1ba2c132b635 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1408,6 +1408,8 @@ void phy_set_asym_pause(struct phy_device *phydev, bool rx, bool tx);
 bool phy_validate_pause(struct phy_device *phydev,
 			struct ethtool_pauseparam *pp);
 void phy_get_pause(struct phy_device *phydev, bool *tx_pause, bool *rx_pause);
+int phy_get_delay_index(struct phy_device *phydev, int *delay_values,
+			int size, int delay, bool descending);
 void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
 		       bool *tx_pause, bool *rx_pause);
 
-- 
2.26.2

