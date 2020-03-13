Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C8CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CB6206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCMJuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:50:05 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55363 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:50:05 -0400
X-Originating-IP: 90.89.41.158
Received: from localhost (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D565860009;
        Fri, 13 Mar 2020 09:50:01 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/3] net: phy: move the mscc driver to its own directory
Date:   Fri, 13 Mar 2020 10:48:00 +0100
Message-Id: <20200313094802.82863-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313094802.82863-1-antoine.tenart@bootlin.com>
References: <20200313094802.82863-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSCC PHY driver is growing, with lots of space consuming features
(firmware support, full initialization, MACsec...). It's becoming hard
to read and navigate in its source code. This patch moves the MSCC
driver to its own directory, without modifying anything, as a
preparation for splitting up its features into dedicated files.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/Makefile                    | 2 +-
 drivers/net/phy/mscc/Makefile               | 5 +++++
 drivers/net/phy/{ => mscc}/mscc.c           | 0
 drivers/net/phy/{ => mscc}/mscc_fc_buffer.h | 0
 drivers/net/phy/{ => mscc}/mscc_mac.h       | 0
 drivers/net/phy/{ => mscc}/mscc_macsec.h    | 0
 6 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/mscc/Makefile
 rename drivers/net/phy/{ => mscc}/mscc.c (100%)
 rename drivers/net/phy/{ => mscc}/mscc_fc_buffer.h (100%)
 rename drivers/net/phy/{ => mscc}/mscc_mac.h (100%)
 rename drivers/net/phy/{ => mscc}/mscc_macsec.h (100%)

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 26f8039f300f..70774ab474e6 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -89,7 +89,7 @@ obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
 obj-$(CONFIG_MICROCHIP_T1_PHY)	+= microchip_t1.o
-obj-$(CONFIG_MICROSEMI_PHY)	+= mscc.o
+obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
 obj-$(CONFIG_NATIONAL_PHY)	+= national.o
 obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
diff --git a/drivers/net/phy/mscc/Makefile b/drivers/net/phy/mscc/Makefile
new file mode 100644
index 000000000000..e419ed1a3213
--- /dev/null
+++ b/drivers/net/phy/mscc/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for MSCC networking PHY driver
+
+obj-$(CONFIG_MICROSEMI_PHY) += mscc.o
diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc/mscc.c
similarity index 100%
rename from drivers/net/phy/mscc.c
rename to drivers/net/phy/mscc/mscc.c
diff --git a/drivers/net/phy/mscc_fc_buffer.h b/drivers/net/phy/mscc/mscc_fc_buffer.h
similarity index 100%
rename from drivers/net/phy/mscc_fc_buffer.h
rename to drivers/net/phy/mscc/mscc_fc_buffer.h
diff --git a/drivers/net/phy/mscc_mac.h b/drivers/net/phy/mscc/mscc_mac.h
similarity index 100%
rename from drivers/net/phy/mscc_mac.h
rename to drivers/net/phy/mscc/mscc_mac.h
diff --git a/drivers/net/phy/mscc_macsec.h b/drivers/net/phy/mscc/mscc_macsec.h
similarity index 100%
rename from drivers/net/phy/mscc_macsec.h
rename to drivers/net/phy/mscc/mscc_macsec.h
-- 
2.24.1

