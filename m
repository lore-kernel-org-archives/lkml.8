Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8D2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603F620723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbgF3Qjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:39:41 -0400
Received: from out28-101.mail.aliyun.com ([115.124.28.101]:34529 "EHLO
        out28-101.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732068AbgF3Qjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:39:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04479663|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0176947-0.000462366-0.981843;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HvJGFHX_1593535155;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HvJGFHX_1593535155)
          by smtp.aliyun-inc.com(10.147.43.230);
          Wed, 01 Jul 2020 00:39:29 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v3 2/3] clk: JZ4780: Reformat the code to align it.
Date:   Wed,  1 Jul 2020 00:38:51 +0800
Message-Id: <20200630163852.47267-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
References: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat the code (add one level of indentation before the values),
to align the code in the macro definition section.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v2:
    New patch.
    
    v2->v3:
    No change.

 drivers/clk/ingenic/jz4780-cgu.c | 90 ++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index cf3f7f87e7a6..abd8d6d78590 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -20,50 +20,50 @@
 
 /* CGU register offsets */
 #define CGU_REG_CLOCKCONTROL	0x00
-#define CGU_REG_LCR			0x04
-#define CGU_REG_APLL		0x10
-#define CGU_REG_MPLL		0x14
-#define CGU_REG_EPLL		0x18
-#define CGU_REG_VPLL		0x1c
-#define CGU_REG_CLKGR0		0x20
-#define CGU_REG_OPCR		0x24
-#define CGU_REG_CLKGR1		0x28
-#define CGU_REG_DDRCDR		0x2c
-#define CGU_REG_VPUCDR		0x30
-#define CGU_REG_USBPCR		0x3c
-#define CGU_REG_USBRDT		0x40
-#define CGU_REG_USBVBFIL	0x44
-#define CGU_REG_USBPCR1		0x48
-#define CGU_REG_LP0CDR		0x54
-#define CGU_REG_I2SCDR		0x60
-#define CGU_REG_LP1CDR		0x64
-#define CGU_REG_MSC0CDR		0x68
-#define CGU_REG_UHCCDR		0x6c
-#define CGU_REG_SSICDR		0x74
-#define CGU_REG_CIMCDR		0x7c
-#define CGU_REG_PCMCDR		0x84
-#define CGU_REG_GPUCDR		0x88
-#define CGU_REG_HDMICDR		0x8c
-#define CGU_REG_MSC1CDR		0xa4
-#define CGU_REG_MSC2CDR		0xa8
-#define CGU_REG_BCHCDR		0xac
-#define CGU_REG_CLOCKSTATUS	0xd4
+#define CGU_REG_LCR				0x04
+#define CGU_REG_APLL			0x10
+#define CGU_REG_MPLL			0x14
+#define CGU_REG_EPLL			0x18
+#define CGU_REG_VPLL			0x1c
+#define CGU_REG_CLKGR0			0x20
+#define CGU_REG_OPCR			0x24
+#define CGU_REG_CLKGR1			0x28
+#define CGU_REG_DDRCDR			0x2c
+#define CGU_REG_VPUCDR			0x30
+#define CGU_REG_USBPCR			0x3c
+#define CGU_REG_USBRDT			0x40
+#define CGU_REG_USBVBFIL		0x44
+#define CGU_REG_USBPCR1			0x48
+#define CGU_REG_LP0CDR			0x54
+#define CGU_REG_I2SCDR			0x60
+#define CGU_REG_LP1CDR			0x64
+#define CGU_REG_MSC0CDR			0x68
+#define CGU_REG_UHCCDR			0x6c
+#define CGU_REG_SSICDR			0x74
+#define CGU_REG_CIMCDR			0x7c
+#define CGU_REG_PCMCDR			0x84
+#define CGU_REG_GPUCDR			0x88
+#define CGU_REG_HDMICDR			0x8c
+#define CGU_REG_MSC1CDR			0xa4
+#define CGU_REG_MSC2CDR			0xa8
+#define CGU_REG_BCHCDR			0xac
+#define CGU_REG_CLOCKSTATUS		0xd4
 
 /* bits within the OPCR register */
-#define OPCR_SPENDN0		BIT(7)
-#define OPCR_SPENDN1		BIT(6)
+#define OPCR_SPENDN0			BIT(7)
+#define OPCR_SPENDN1			BIT(6)
 
 /* bits within the USBPCR register */
-#define USBPCR_USB_MODE		BIT(31)
+#define USBPCR_USB_MODE			BIT(31)
 #define USBPCR_IDPULLUP_MASK	(0x3 << 28)
-#define USBPCR_COMMONONN	BIT(25)
-#define USBPCR_VBUSVLDEXT	BIT(24)
+#define USBPCR_COMMONONN		BIT(25)
+#define USBPCR_VBUSVLDEXT		BIT(24)
 #define USBPCR_VBUSVLDEXTSEL	BIT(23)
-#define USBPCR_POR		BIT(22)
-#define USBPCR_SIDDQ		BIT(21)
-#define USBPCR_OTG_DISABLE	BIT(20)
+#define USBPCR_POR				BIT(22)
+#define USBPCR_SIDDQ			BIT(21)
+#define USBPCR_OTG_DISABLE		BIT(20)
 #define USBPCR_COMPDISTUNE_MASK	(0x7 << 17)
-#define USBPCR_OTGTUNE_MASK	(0x7 << 14)
+#define USBPCR_OTGTUNE_MASK		(0x7 << 14)
 #define USBPCR_SQRXTUNE_MASK	(0x7 << 11)
 #define USBPCR_TXFSLSTUNE_MASK	(0xf << 7)
 #define USBPCR_TXPREEMPHTUNE	BIT(6)
@@ -80,13 +80,13 @@
 #define USBPCR1_REFCLKDIV_48	(0x2 << USBPCR1_REFCLKDIV_SHIFT)
 #define USBPCR1_REFCLKDIV_24	(0x1 << USBPCR1_REFCLKDIV_SHIFT)
 #define USBPCR1_REFCLKDIV_12	(0x0 << USBPCR1_REFCLKDIV_SHIFT)
-#define USBPCR1_USB_SEL		BIT(28)
-#define USBPCR1_WORD_IF0	BIT(19)
-#define USBPCR1_WORD_IF1	BIT(18)
+#define USBPCR1_USB_SEL			BIT(28)
+#define USBPCR1_WORD_IF0		BIT(19)
+#define USBPCR1_WORD_IF1		BIT(18)
 
 /* bits within the USBRDT register */
-#define USBRDT_VBFIL_LD_EN	BIT(25)
-#define USBRDT_USBRDT_MASK	0x7fffff
+#define USBRDT_VBFIL_LD_EN		BIT(25)
+#define USBRDT_USBRDT_MASK		0x7fffff
 
 /* bits within the USBVBFIL register */
 #define USBVBFIL_IDDIGFIL_SHIFT	16
@@ -94,11 +94,11 @@
 #define USBVBFIL_USBVBFIL_MASK	(0xffff)
 
 /* bits within the LCR register */
-#define LCR_PD_SCPU			BIT(31)
-#define LCR_SCPUS			BIT(27)
+#define LCR_PD_SCPU				BIT(31)
+#define LCR_SCPUS				BIT(27)
 
 /* bits within the CLKGR1 register */
-#define CLKGR1_CORE1		BIT(15)
+#define CLKGR1_CORE1			BIT(15)
 
 static struct ingenic_cgu *cgu;
 
-- 
2.11.0

