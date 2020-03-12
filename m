Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D039C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D005720716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCLWKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:10:40 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60589 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgCLWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:10:40 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B395940002;
        Thu, 12 Mar 2020 22:10:37 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: phy: move the mscc driver to its own directory
Date:   Thu, 12 Mar 2020 23:10:31 +0100
Message-Id: <20200312221033.777437-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312221033.777437-1-antoine.tenart@bootlin.com>
References: <20200312221033.777437-1-antoine.tenart@bootlin.com>
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

