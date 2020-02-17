Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB93C761A1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6905520732
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgBQJhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:37:17 -0500
Received: from inva020.nxp.com ([92.121.34.13]:51668 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgBQJhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:37:16 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 13B711A2B32;
        Mon, 17 Feb 2020 10:37:15 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C71D1A2B1A;
        Mon, 17 Feb 2020 10:37:09 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BF763402FB;
        Mon, 17 Feb 2020 17:37:02 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 3/7] ARM: dts: imx6sx-nitrogen6sx: Use new pin names with DCE/DTE for UART pins
Date:   Mon, 17 Feb 2020 17:31:22 +0800
Message-Id: <1581931886-12173-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581931886-12173-1-git-send-email-Anson.Huang@nxp.com>
References: <1581931886-12173-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new pin names containing DCE/DTE for UART RX/TX/RTS/CTS pins, this
is to distinguish the DCE/DTE functions.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Uwe Kleine-K枚nig <u.kleine-koenig@pengutronix.de>
---
No change.
---
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index 832b5c5..d84ea69 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -484,31 +484,31 @@
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
-			MX6SX_PAD_GPIO1_IO05__UART1_RX		0x1b0b1
+			MX6SX_PAD_GPIO1_IO04__UART1_DCE_TX		0x1b0b1
+			MX6SX_PAD_GPIO1_IO05__UART1_DCE_RX		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX6SX_PAD_GPIO1_IO06__UART2_TX		0x1b0b1
-			MX6SX_PAD_GPIO1_IO07__UART2_RX		0x1b0b1
+			MX6SX_PAD_GPIO1_IO06__UART2_DCE_TX		0x1b0b1
+			MX6SX_PAD_GPIO1_IO07__UART2_DCE_RX		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-			MX6SX_PAD_QSPI1B_SS0_B__UART3_TX	0x1b0b1
-			MX6SX_PAD_QSPI1B_SCLK__UART3_RX		0x1b0b1
+			MX6SX_PAD_QSPI1B_SS0_B__UART3_DCE_TX		0x1b0b1
+			MX6SX_PAD_QSPI1B_SCLK__UART3_DCE_RX		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart5: uart5grp {
 		fsl,pins = <
-			MX6SX_PAD_KEY_COL3__UART5_TX		0x1b0b1
-			MX6SX_PAD_KEY_ROW3__UART5_RX		0x1b0b1
-			MX6SX_PAD_SD3_DATA6__UART3_RTS_B	0x1b0b1
-			MX6SX_PAD_SD3_DATA7__UART3_CTS_B	0x1b0b1
+			MX6SX_PAD_KEY_COL3__UART5_DCE_TX		0x1b0b1
+			MX6SX_PAD_KEY_ROW3__UART5_DCE_RX		0x1b0b1
+			MX6SX_PAD_SD3_DATA6__UART3_DCE_RTS		0x1b0b1
+			MX6SX_PAD_SD3_DATA7__UART3_DCE_CTS		0x1b0b1
 		>;
 	};
 
-- 
2.7.4

