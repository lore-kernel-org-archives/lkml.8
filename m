Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ECBC43635
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E0B22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgGWGOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:14:01 -0400
Received: from out28-100.mail.aliyun.com ([115.124.28.100]:56697 "EHLO
        out28-100.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGWGN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:13:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07494332|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0273549-0.000814196-0.971831;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I6H78tB_1595484804;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I6H78tB_1595484804)
          by smtp.aliyun-inc.com(10.147.40.7);
          Thu, 23 Jul 2020 14:13:53 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v5 2/4] USB: PHY: JZ4770: Unify code style and simplify code.
Date:   Thu, 23 Jul 2020 14:12:59 +0800
Message-Id: <20200723061301.82583-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200723061301.82583-1-zhouyanjie@wanyeetech.com>
References: <20200723061301.82583-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Modify the macro definition to unify "#define USBPCR_XXXX n"
  into the "#define USBPCR_XXXX (n << USBPCR_XXXX_LSB)" style,
  so as to unify the code style in the "jz4770_phy_init()" and
  simplify the code.
2.Remove unused macro definitions to simplify the code.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Suggested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v5:
    New patch.

 drivers/usb/phy/phy-jz4770.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/usb/phy/phy-jz4770.c
index 8f62dc2a90ff..00209d5469d3 100644
--- a/drivers/usb/phy/phy-jz4770.c
+++ b/drivers/usb/phy/phy-jz4770.c
@@ -20,8 +20,6 @@
 /* USBPCR */
 #define USBPCR_USB_MODE		BIT(31)
 #define USBPCR_AVLD_REG		BIT(30)
-#define USBPCR_INCRM		BIT(27)
-#define USBPCR_CLK12_EN		BIT(26)
 #define USBPCR_COMMONONN	BIT(25)
 #define USBPCR_VBUSVLDEXT	BIT(24)
 #define USBPCR_VBUSVLDEXTSEL	BIT(23)
@@ -32,45 +30,39 @@
 
 #define USBPCR_IDPULLUP_LSB	28
 #define USBPCR_IDPULLUP_MASK	GENMASK(29, USBPCR_IDPULLUP_LSB)
-#define USBPCR_IDPULLUP_ALWAYS	(3 << USBPCR_IDPULLUP_LSB)
-#define USBPCR_IDPULLUP_SUSPEND	(1 << USBPCR_IDPULLUP_LSB)
-#define USBPCR_IDPULLUP_OTG	(0 << USBPCR_IDPULLUP_LSB)
+#define USBPCR_IDPULLUP_ALWAYS	(0x2 << USBPCR_IDPULLUP_LSB)
+#define USBPCR_IDPULLUP_SUSPEND	(0x1 << USBPCR_IDPULLUP_LSB)
+#define USBPCR_IDPULLUP_OTG	(0x0 << USBPCR_IDPULLUP_LSB)
 
 #define USBPCR_COMPDISTUNE_LSB	17
 #define USBPCR_COMPDISTUNE_MASK	GENMASK(19, USBPCR_COMPDISTUNE_LSB)
-#define USBPCR_COMPDISTUNE_DFT	4
+#define USBPCR_COMPDISTUNE_DFT	(0x4 << USBPCR_COMPDISTUNE_LSB)
 
 #define USBPCR_OTGTUNE_LSB	14
 #define USBPCR_OTGTUNE_MASK	GENMASK(16, USBPCR_OTGTUNE_LSB)
-#define USBPCR_OTGTUNE_DFT	4
+#define USBPCR_OTGTUNE_DFT	(0x4 << USBPCR_OTGTUNE_LSB)
 
 #define USBPCR_SQRXTUNE_LSB	11
 #define USBPCR_SQRXTUNE_MASK	GENMASK(13, USBPCR_SQRXTUNE_LSB)
-#define USBPCR_SQRXTUNE_DFT	3
+#define USBPCR_SQRXTUNE_DFT	(0x3 << USBPCR_SQRXTUNE_LSB)
 
 #define USBPCR_TXFSLSTUNE_LSB	7
 #define USBPCR_TXFSLSTUNE_MASK	GENMASK(10, USBPCR_TXFSLSTUNE_LSB)
-#define USBPCR_TXFSLSTUNE_DFT	3
+#define USBPCR_TXFSLSTUNE_DFT	(0x3 << USBPCR_TXFSLSTUNE_LSB)
 
 #define USBPCR_TXRISETUNE_LSB	4
 #define USBPCR_TXRISETUNE_MASK	GENMASK(5, USBPCR_TXRISETUNE_LSB)
-#define USBPCR_TXRISETUNE_DFT	3
+#define USBPCR_TXRISETUNE_DFT	(0x3 << USBPCR_TXRISETUNE_LSB)
 
 #define USBPCR_TXVREFTUNE_LSB	0
 #define USBPCR_TXVREFTUNE_MASK	GENMASK(3, USBPCR_TXVREFTUNE_LSB)
-#define USBPCR_TXVREFTUNE_DFT	5
+#define USBPCR_TXVREFTUNE_DFT	(0x5 << USBPCR_TXVREFTUNE_LSB)
 
 /* USBRDT */
 #define USBRDT_VBFIL_LD_EN	BIT(25)
 #define USBRDT_IDDIG_EN		BIT(24)
 #define USBRDT_IDDIG_REG	BIT(23)
 
-#define USBRDT_USBRDT_LSB	0
-#define USBRDT_USBRDT_MASK	GENMASK(22, USBRDT_USBRDT_LSB)
-
-/* USBPCR1 */
-#define USBPCR1_UHC_POWON	BIT(5)
-
 struct jz4770_phy {
 	struct usb_phy phy;
 	struct usb_otg otg;
@@ -136,12 +128,8 @@ static int jz4770_phy_init(struct usb_phy *phy)
 	}
 
 	reg = USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
-		(USBPCR_COMPDISTUNE_DFT << USBPCR_COMPDISTUNE_LSB) |
-		(USBPCR_OTGTUNE_DFT << USBPCR_OTGTUNE_LSB) |
-		(USBPCR_SQRXTUNE_DFT << USBPCR_SQRXTUNE_LSB) |
-		(USBPCR_TXFSLSTUNE_DFT << USBPCR_TXFSLSTUNE_LSB) |
-		(USBPCR_TXRISETUNE_DFT << USBPCR_TXRISETUNE_LSB) |
-		(USBPCR_TXVREFTUNE_DFT << USBPCR_TXVREFTUNE_LSB) |
+		USBPCR_COMPDISTUNE_DFT | USBPCR_OTGTUNE_DFT | USBPCR_SQRXTUNE_DFT |
+		USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT | USBPCR_TXVREFTUNE_DFT |
 		USBPCR_POR;
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
 
-- 
2.11.0

