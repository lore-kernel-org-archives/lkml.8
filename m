Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213E9C7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020982072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBQD0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:26:40 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46126 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgBQD0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:26:38 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 479B01A1F2C;
        Mon, 17 Feb 2020 04:26:37 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 81E9F1A1F31;
        Mon, 17 Feb 2020 04:26:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CAAF74030D;
        Mon, 17 Feb 2020 11:26:15 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 2/7] clk: imx8: Add SCU and LPCG clocks for I2C in CM40 SS
Date:   Mon, 17 Feb 2020 11:19:16 +0800
Message-Id: <1581909561-12058-3-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCU and LPCG clocks for I2C in CM40 SS.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 include/dt-bindings/clock/imx8-clock.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 673a8c662340..84a442be700f 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -131,7 +131,12 @@
 #define IMX_ADMA_PWM_CLK				188
 #define IMX_ADMA_LCD_CLK				189
 
-#define IMX_SCU_CLK_END					190
+/* CM40 SS */
+#define IMX_CM40_IPG_CLK				200
+#define IMX_CM40_I2C_CLK				205
+
+#define IMX_SCU_CLK_END					220
+
 
 /* LPCG clocks */
 
@@ -290,4 +295,10 @@
 
 #define IMX_ADMA_LPCG_CLK_END				45
 
+/* CM40 SS LPCG */
+#define IMX_CM40_LPCG_I2C_IPG_CLK			0
+#define IMX_CM40_LPCG_I2C_CLK				1
+
+#define IMX_CM40_LPCG_CLK_END				2
+
 #endif /* __DT_BINDINGS_CLOCK_IMX_H */
-- 
2.17.1

