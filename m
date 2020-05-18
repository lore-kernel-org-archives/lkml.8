Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9A6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF17220674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824489;
	bh=QitNHxHhfqNdqMYNIxGf8Vj+yrlLbQAmtA1kEfXAlLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJOlJJ6ZPpGY5pcl6wPNMfynAXEMOJUjC+ZOzb0xG2CrKEdGmJpuszDvF5mBG2AGH
	 u/F7AvE0BR5yJUdYJxyUMGfcEmfn9+IgVgAxbR72CCRj0dThMzKBPkFGTmtvikPuGN
	 rCykrAw7D9tX88OaawLkWabq5/NCeSMwgQRJrLsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgERRys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731353AbgERRyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:54:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFCBF20829;
        Mon, 18 May 2020 17:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824485;
        bh=QitNHxHhfqNdqMYNIxGf8Vj+yrlLbQAmtA1kEfXAlLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dd/ANbirXY2Yhh0DN3Y2n/ibg3e4uIWiEBkxm3VAmYXHTy+T7sZaRFu99qRFtxv8U
         9V0QrHsQYZENagL5DV2wv57LkHkS5ln9/J58RjXkzONkFNnWoxwI3Ld9Zj1CGH2RM7
         FwYFnpQ1D+LMTh1uRpBuMR2p1FgDZD4u+pe+1sOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuiko Oshino <yuiko.oshino@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 003/147] net: phy: microchip_t1: add lan87xx_phy_init to initialize the lan87xx phy.
Date:   Mon, 18 May 2020 19:35:26 +0200
Message-Id: <20200518173513.537061282@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuiko Oshino <yuiko.oshino@microchip.com>

[ Upstream commit 63edbcceef612bdd95fa28ce100460c7b79008a4 ]

lan87xx_phy_init() initializes the lan87xx phy hardware
including its TC10 Wake-up and Sleep features.

Fixes: 3e50d2da5850 ("Add driver for Microchip LAN87XX T1 PHYs")
Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
v0->v1:
    - Add more details in the commit message and source comments.
    - Update to the latest initialization sequences.
    - Add access_ereg_modify_changed().
    - Fix access_ereg() to access SMI bank correctly.
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/microchip_t1.c | 171 +++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 001def4509c29..fed3e395f18e1 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -3,9 +3,21 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
 
+/* External Register Control Register */
+#define LAN87XX_EXT_REG_CTL                     (0x14)
+#define LAN87XX_EXT_REG_CTL_RD_CTL              (0x1000)
+#define LAN87XX_EXT_REG_CTL_WR_CTL              (0x0800)
+
+/* External Register Read Data Register */
+#define LAN87XX_EXT_REG_RD_DATA                 (0x15)
+
+/* External Register Write Data Register */
+#define LAN87XX_EXT_REG_WR_DATA                 (0x16)
+
 /* Interrupt Source Register */
 #define LAN87XX_INTERRUPT_SOURCE                (0x18)
 
@@ -14,9 +26,160 @@
 #define LAN87XX_MASK_LINK_UP                    (0x0004)
 #define LAN87XX_MASK_LINK_DOWN                  (0x0002)
 
+/* phyaccess nested types */
+#define	PHYACC_ATTR_MODE_READ		0
+#define	PHYACC_ATTR_MODE_WRITE		1
+#define	PHYACC_ATTR_MODE_MODIFY		2
+
+#define	PHYACC_ATTR_BANK_SMI		0
+#define	PHYACC_ATTR_BANK_MISC		1
+#define	PHYACC_ATTR_BANK_PCS		2
+#define	PHYACC_ATTR_BANK_AFE		3
+#define	PHYACC_ATTR_BANK_MAX		7
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX T1 PHY driver"
 
+struct access_ereg_val {
+	u8  mode;
+	u8  bank;
+	u8  offset;
+	u16 val;
+	u16 mask;
+};
+
+static int access_ereg(struct phy_device *phydev, u8 mode, u8 bank,
+		       u8 offset, u16 val)
+{
+	u16 ereg = 0;
+	int rc = 0;
+
+	if (mode > PHYACC_ATTR_MODE_WRITE || bank > PHYACC_ATTR_BANK_MAX)
+		return -EINVAL;
+
+	if (bank == PHYACC_ATTR_BANK_SMI) {
+		if (mode == PHYACC_ATTR_MODE_WRITE)
+			rc = phy_write(phydev, offset, val);
+		else
+			rc = phy_read(phydev, offset);
+		return rc;
+	}
+
+	if (mode == PHYACC_ATTR_MODE_WRITE) {
+		ereg = LAN87XX_EXT_REG_CTL_WR_CTL;
+		rc = phy_write(phydev, LAN87XX_EXT_REG_WR_DATA, val);
+		if (rc < 0)
+			return rc;
+	} else {
+		ereg = LAN87XX_EXT_REG_CTL_RD_CTL;
+	}
+
+	ereg |= (bank << 8) | offset;
+
+	rc = phy_write(phydev, LAN87XX_EXT_REG_CTL, ereg);
+	if (rc < 0)
+		return rc;
+
+	if (mode == PHYACC_ATTR_MODE_READ)
+		rc = phy_read(phydev, LAN87XX_EXT_REG_RD_DATA);
+
+	return rc;
+}
+
+static int access_ereg_modify_changed(struct phy_device *phydev,
+				      u8 bank, u8 offset, u16 val, u16 mask)
+{
+	int new = 0, rc = 0;
+
+	if (bank > PHYACC_ATTR_BANK_MAX)
+		return -EINVAL;
+
+	rc = access_ereg(phydev, PHYACC_ATTR_MODE_READ, bank, offset, val);
+	if (rc < 0)
+		return rc;
+
+	new = val | (rc & (mask ^ 0xFFFF));
+	rc = access_ereg(phydev, PHYACC_ATTR_MODE_WRITE, bank, offset, new);
+
+	return rc;
+}
+
+static int lan87xx_phy_init(struct phy_device *phydev)
+{
+	static const struct access_ereg_val init[] = {
+		/* TX Amplitude = 5 */
+		{PHYACC_ATTR_MODE_MODIFY, PHYACC_ATTR_BANK_AFE, 0x0B,
+		 0x000A, 0x001E},
+		/* Clear SMI interrupts */
+		{PHYACC_ATTR_MODE_READ, PHYACC_ATTR_BANK_SMI, 0x18,
+		 0, 0},
+		/* Clear MISC interrupts */
+		{PHYACC_ATTR_MODE_READ, PHYACC_ATTR_BANK_MISC, 0x08,
+		 0, 0},
+		/* Turn on TC10 Ring Oscillator (ROSC) */
+		{PHYACC_ATTR_MODE_MODIFY, PHYACC_ATTR_BANK_MISC, 0x20,
+		 0x0020, 0x0020},
+		/* WUR Detect Length to 1.2uS, LPC Detect Length to 1.09uS */
+		{PHYACC_ATTR_MODE_WRITE, PHYACC_ATTR_BANK_PCS, 0x20,
+		 0x283C, 0},
+		/* Wake_In Debounce Length to 39uS, Wake_Out Length to 79uS */
+		{PHYACC_ATTR_MODE_WRITE, PHYACC_ATTR_BANK_MISC, 0x21,
+		 0x274F, 0},
+		/* Enable Auto Wake Forward to Wake_Out, ROSC on, Sleep,
+		 * and Wake_In to wake PHY
+		 */
+		{PHYACC_ATTR_MODE_WRITE, PHYACC_ATTR_BANK_MISC, 0x20,
+		 0x80A7, 0},
+		/* Enable WUP Auto Fwd, Enable Wake on MDI, Wakeup Debouncer
+		 * to 128 uS
+		 */
+		{PHYACC_ATTR_MODE_WRITE, PHYACC_ATTR_BANK_MISC, 0x24,
+		 0xF110, 0},
+		/* Enable HW Init */
+		{PHYACC_ATTR_MODE_MODIFY, PHYACC_ATTR_BANK_SMI, 0x1A,
+		 0x0100, 0x0100},
+	};
+	int rc, i;
+
+	/* Start manual initialization procedures in Managed Mode */
+	rc = access_ereg_modify_changed(phydev, PHYACC_ATTR_BANK_SMI,
+					0x1a, 0x0000, 0x0100);
+	if (rc < 0)
+		return rc;
+
+	/* Soft Reset the SMI block */
+	rc = access_ereg_modify_changed(phydev, PHYACC_ATTR_BANK_SMI,
+					0x00, 0x8000, 0x8000);
+	if (rc < 0)
+		return rc;
+
+	/* Check to see if the self-clearing bit is cleared */
+	usleep_range(1000, 2000);
+	rc = access_ereg(phydev, PHYACC_ATTR_MODE_READ,
+			 PHYACC_ATTR_BANK_SMI, 0x00, 0);
+	if (rc < 0)
+		return rc;
+	if ((rc & 0x8000) != 0)
+		return -ETIMEDOUT;
+
+	/* PHY Initialization */
+	for (i = 0; i < ARRAY_SIZE(init); i++) {
+		if (init[i].mode == PHYACC_ATTR_MODE_MODIFY) {
+			rc = access_ereg_modify_changed(phydev, init[i].bank,
+							init[i].offset,
+							init[i].val,
+							init[i].mask);
+		} else {
+			rc = access_ereg(phydev, init[i].mode, init[i].bank,
+					 init[i].offset, init[i].val);
+		}
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
 static int lan87xx_phy_config_intr(struct phy_device *phydev)
 {
 	int rc, val = 0;
@@ -40,6 +203,13 @@ static int lan87xx_phy_ack_interrupt(struct phy_device *phydev)
 	return rc < 0 ? rc : 0;
 }
 
+static int lan87xx_config_init(struct phy_device *phydev)
+{
+	int rc = lan87xx_phy_init(phydev);
+
+	return rc < 0 ? rc : 0;
+}
+
 static struct phy_driver microchip_t1_phy_driver[] = {
 	{
 		.phy_id         = 0x0007c150,
@@ -48,6 +218,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 
 		.features       = PHY_BASIC_T1_FEATURES,
 
+		.config_init	= lan87xx_config_init,
 		.config_aneg    = genphy_config_aneg,
 
 		.ack_interrupt  = lan87xx_phy_ack_interrupt,
-- 
2.20.1



