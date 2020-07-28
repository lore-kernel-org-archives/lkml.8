Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80024C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6957F207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgG1RFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:05:38 -0400
Received: from out28-197.mail.aliyun.com ([115.124.28.197]:57868 "EHLO
        out28-197.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731484AbgG1RFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:05:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07438316|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0118884-0.000241417-0.98787;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16367;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I8uonft_1595955914;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I8uonft_1595955914)
          by smtp.aliyun-inc.com(10.147.44.145);
          Wed, 29 Jul 2020 01:05:30 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        colin.king@canonical.com, dan.carpenter@oracle.com,
        paul@crapouillou.net, prasannatsmkumar@gmail.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH 1/1] USB: PHY: JZ4770: Fix static checker warning.
Date:   Wed, 29 Jul 2020 01:02:51 +0800
Message-Id: <20200728170251.112484-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200728170251.112484-1-zhouyanjie@wanyeetech.com>
References: <20200728170251.112484-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new
Ingenic SoCs.") introduced the initialization function for different
chips, but left the relevant code involved in the resetting process
in the original function, resulting in uninitialized variable calls.
This problem can be solved by putting this part of the code into the
initialization function for each chip. Although the four processors
currently supported have the same reset code, let us can solve this
problem by adding the initialization of the reg variable to the
original function, but when other processors with different reset
methods (such as X2000) are introduced in the future, it will cause
inevitable condition judgments to complicate the function, which
violates the original intention of introducing initialization
functions for each processor.

Fixes: 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new
Ingenic SoCs.").

Reported-by: Colin Ian King <colin.king@canonical.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/usb/phy/phy-jz4770.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/usb/phy/phy-jz4770.c
index d4ee3cb721ea..23d38cbc150e 100644
--- a/drivers/usb/phy/phy-jz4770.c
+++ b/drivers/usb/phy/phy-jz4770.c
@@ -158,7 +158,6 @@ static int ingenic_usb_phy_init(struct usb_phy *phy)
 {
 	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
 	int err;
-	u32 reg;
 
 	err = regulator_enable(priv->vcc_supply);
 	if (err) {
@@ -174,11 +173,6 @@ static int ingenic_usb_phy_init(struct usb_phy *phy)
 
 	priv->soc_info->usb_phy_init(phy);
 
-	/* Wait for PHY to reset */
-	usleep_range(30, 300);
-	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
-	usleep_range(300, 1000);
-
 	return 0;
 }
 
@@ -205,6 +199,11 @@ static void jz4770_usb_phy_init(struct usb_phy *phy)
 		USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT | USBPCR_TXVREFTUNE_DFT |
 		USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	/* Wait for PHY to reset */
+	usleep_range(30, 300);
+	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
+	usleep_range(300, 1000);
 }
 
 static void jz4780_usb_phy_init(struct usb_phy *phy)
@@ -218,6 +217,11 @@ static void jz4780_usb_phy_init(struct usb_phy *phy)
 
 	reg = USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	/* Wait for PHY to reset */
+	usleep_range(30, 300);
+	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
+	usleep_range(300, 1000);
 }
 
 static void x1000_usb_phy_init(struct usb_phy *phy)
@@ -232,6 +236,11 @@ static void x1000_usb_phy_init(struct usb_phy *phy)
 		USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT |
 		USBPCR_COMMONONN | USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	/* Wait for PHY to reset */
+	usleep_range(30, 300);
+	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
+	usleep_range(300, 1000);
 }
 
 static void x1830_usb_phy_init(struct usb_phy *phy)
@@ -249,6 +258,11 @@ static void x1830_usb_phy_init(struct usb_phy *phy)
 	reg = USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |	USBPCR_TXPREEMPHTUNE |
 		USBPCR_COMMONONN | USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
+
+	/* Wait for PHY to reset */
+	usleep_range(30, 300);
+	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
+	usleep_range(300, 1000);
 }
 
 static const struct ingenic_soc_info jz4770_soc_info = {
-- 
2.11.0

