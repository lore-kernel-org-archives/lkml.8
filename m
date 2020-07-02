Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4194C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996562073E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="xlSa82hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGBKag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgGBKaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:30:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98882C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 03:30:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so16258241wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AxFc8QsWQJwBLz/+3G2SEV6PK5N4TIC8ua8H9gJBdtc=;
        b=xlSa82hsahdngAPny0lKB8uTDhQzDBlapiTx2yqPh9kg/pQs10swtam2kBIEne+UYa
         3za3JmrV1SEVcj8FWiuHG1WpbQBJsPouR4pzrGdYkTnd3E8CWXKwFMaW2KodEOBTsqVq
         0i5wi1fvRV/YRHpT19CVezHYqN1eIW5y1Hvzc+Hy0ZlzgI5uDNkg9YOmsEjgdfVDEmNm
         IR8zTSi59S5vnq4Hnb3YTRJk52JvffXTzA1gpRdR7Xe+0WxN3+cUW6+DuuQLdFFiqKsl
         6aU4EA6XWlDqhiRvIP/jQHCd4gloNzfWyKktrQ6oMGu+mEBaSZXZmR4AFGhEgjyLN0eA
         lx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AxFc8QsWQJwBLz/+3G2SEV6PK5N4TIC8ua8H9gJBdtc=;
        b=XBJg7GdiME7bFGunNcIZ299lqpvi4B/uPcrLN6cBniaJPM75cfkuY6m+XTebWcBiDJ
         pO4dQrwoevxknUCIeTlnuJMMlExzxZeItqtaqww9GMs670xS7n6vBdjJ9+uV08S9+Ybh
         rsgmDOIYKteSGryWyS5i4wsah1mIQHoDkoVVIfkQxz8XU2ZFMRAs2z43qgvGdZO/ImfK
         cpelw68NxqLuQR6tr3GI9SK5pjtkMj8v3GjFc5N7Azha2egPC8ZKrlhqIkApdmPj1CzP
         qhk+SINl4tCnxPhUPu4q/2kFaXE6QCCqRIWi5lov2+pHkcNI3RueRKFUI+SAqQuhUU6b
         N0Kg==
X-Gm-Message-State: AOAM531xIrjtHc9zx61llhNjljs9v9/d9Ez2c4Q2iFiEEbzDdM3sga8R
        uCI+ope03U5Y615+9wVkbQaZ/Q==
X-Google-Smtp-Source: ABdhPJw1jcSvGoNPOCw6Zwm19skkWRwX+zU0rWJi7jrd2ukpW1FH4rV5FVJhvpsFJludrym9D5fB1A==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr29657960wro.375.1593685815245;
        Thu, 02 Jul 2020 03:30:15 -0700 (PDT)
Received: from localhost.localdomain (dh207-99-59.xnet.hr. [88.207.99.59])
        by smtp.googlemail.com with ESMTPSA id 68sm10406912wmz.40.2020.07.02.03.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:30:14 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [net-next,PATCH 3/4] net: mdio-ipq4019: add Clause 45 support
Date:   Thu,  2 Jul 2020 12:30:00 +0200
Message-Id: <20200702103001.233961-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702103001.233961-1-robert.marko@sartura.hr>
References: <20200702103001.233961-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While up-streaming the IPQ4019 driver it was thought that the controller had no Clause 45 support,
but it actually does and its activated by writing a bit to the mode register.

So lets add it as newer SoC-s use the same controller and Clause 45 compliant PHY-s.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/phy/mdio-ipq4019.c | 109 ++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/mdio-ipq4019.c b/drivers/net/phy/mdio-ipq4019.c
index 7660bf006da0..9143113d5a6b 100644
--- a/drivers/net/phy/mdio-ipq4019.c
+++ b/drivers/net/phy/mdio-ipq4019.c
@@ -13,6 +13,7 @@
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 
+#define MDIO_MODE_REG				0x40
 #define MDIO_ADDR_REG				0x44
 #define MDIO_DATA_WRITE_REG			0x48
 #define MDIO_DATA_READ_REG			0x4c
@@ -21,6 +22,12 @@
 #define MDIO_CMD_ACCESS_START		BIT(8)
 #define MDIO_CMD_ACCESS_CODE_READ	0
 #define MDIO_CMD_ACCESS_CODE_WRITE	1
+#define MDIO_CMD_ACCESS_CODE_C45_ADDR	0
+#define MDIO_CMD_ACCESS_CODE_C45_WRITE	1
+#define MDIO_CMD_ACCESS_CODE_C45_READ	2
+
+/* 0 = Clause 22, 1 = Clause 45 */
+#define MDIO_MODE_BIT				BIT(8)
 
 #define IPQ4019_MDIO_TIMEOUT	10000
 #define IPQ4019_MDIO_SLEEP		10
@@ -39,7 +46,7 @@ static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
 	unsigned int busy;
 
 	return readl_poll_timeout(priv->membase + MDIO_CMD_REG, busy,
-				  (busy & MDIO_CMD_ACCESS_BUSY) == 0, 
+				  (busy & MDIO_CMD_ACCESS_BUSY) == 0,
 				  IPQ4019_MDIO_SLEEP, IPQ4019_MDIO_TIMEOUT);
 }
 
@@ -47,18 +54,43 @@ static int ipq4019_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
 	unsigned int cmd;
-
-	/* Reject clause 45 */
-	if (regnum & MII_ADDR_C45)
-		return -EOPNOTSUPP;
+	unsigned int data;
 
 	if (ipq4019_mdio_wait_busy(bus))
 		return -ETIMEDOUT;
 
-	/* issue the phy address and reg */
-	writel((mii_id << 8) | regnum, priv->membase + MDIO_ADDR_REG);
+	/* Clause 45 support */
+	if (regnum & MII_ADDR_C45) {
+		unsigned int mmd = (regnum >> 16) & 0x1F;
+		unsigned int reg = regnum & 0xFFFF;
+
+		/* Enter Clause 45 mode */
+		data = readl(priv->membase + MDIO_MODE_REG);
+
+		data |= MDIO_MODE_BIT;
+
+		writel(data, priv->membase + MDIO_MODE_REG);
+
+		/* issue the phy address and mmd */
+		writel((mii_id << 8) | mmd, priv->membase + MDIO_ADDR_REG);
+
+		/* issue reg */
+		writel(reg, priv->membase + MDIO_DATA_WRITE_REG);
+
+		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_ADDR;
+	} else {
+		/* Enter Clause 22 mode */
+		data = readl(priv->membase + MDIO_MODE_REG);
 
-	cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_READ;
+		data &= ~MDIO_MODE_BIT;
+
+		writel(data, priv->membase + MDIO_MODE_REG);
+
+		/* issue the phy address and reg */
+		writel((mii_id << 8) | regnum, priv->membase + MDIO_ADDR_REG);
+
+		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_READ;
+	}
 
 	/* issue read command */
 	writel(cmd, priv->membase + MDIO_CMD_REG);
@@ -67,6 +99,15 @@ static int ipq4019_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 	if (ipq4019_mdio_wait_busy(bus))
 		return -ETIMEDOUT;
 
+	if (regnum & MII_ADDR_C45) {
+		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_READ;
+
+		writel(cmd, priv->membase + MDIO_CMD_REG);
+
+		if (ipq4019_mdio_wait_busy(bus))
+			return -ETIMEDOUT;
+	}
+
 	/* Read and return data */
 	return readl(priv->membase + MDIO_DATA_READ_REG);
 }
@@ -76,22 +117,56 @@ static int ipq4019_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
 	unsigned int cmd;
-
-	/* Reject clause 45 */
-	if (regnum & MII_ADDR_C45)
-		return -EOPNOTSUPP;
+	unsigned int data;
 
 	if (ipq4019_mdio_wait_busy(bus))
 		return -ETIMEDOUT;
 
-	/* issue the phy address and reg */
-	writel((mii_id << 8) | regnum, priv->membase + MDIO_ADDR_REG);
+	/* Clause 45 support */
+	if (regnum & MII_ADDR_C45) {
+		unsigned int mmd = (regnum >> 16) & 0x1F;
+		unsigned int reg = regnum & 0xFFFF;
+
+		/* Enter Clause 45 mode */
+		data = readl(priv->membase + MDIO_MODE_REG);
+
+		data |= MDIO_MODE_BIT;
+
+		writel(data, priv->membase + MDIO_MODE_REG);
+
+		/* issue the phy address and mmd */
+		writel((mii_id << 8) | mmd, priv->membase + MDIO_ADDR_REG);
+
+		/* issue reg */
+		writel(reg, priv->membase + MDIO_DATA_WRITE_REG);
+
+		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_ADDR;
+
+		writel(cmd, priv->membase + MDIO_CMD_REG);
+
+		if (ipq4019_mdio_wait_busy(bus))
+			return -ETIMEDOUT;
+	} else {
+		/* Enter Clause 22 mode */
+		data = readl(priv->membase + MDIO_MODE_REG);
+
+		data &= ~MDIO_MODE_BIT;
+
+		writel(data, priv->membase + MDIO_MODE_REG);
+
+		/* issue the phy address and reg */
+		writel((mii_id << 8) | regnum, priv->membase + MDIO_ADDR_REG);
+	}
 
 	/* issue write data */
 	writel(value, priv->membase + MDIO_DATA_WRITE_REG);
-
-	cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_WRITE;
+
 	/* issue write command */
+	if (regnum & MII_ADDR_C45)
+		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_WRITE;
+	else
+		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_WRITE;
+
 	writel(cmd, priv->membase + MDIO_CMD_REG);
 
 	/* Wait write complete */
@@ -105,7 +180,7 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 {
 	struct ipq4019_mdio_data *priv;
 	struct mii_bus *bus;
-	struct device_node *np = pdev->dev.of_node; 
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
 	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*priv));
-- 
2.26.2

