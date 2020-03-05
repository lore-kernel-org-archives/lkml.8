Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE51AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99DA20728
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgCEV0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:26:40 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:36150 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgCEV0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:26:40 -0500
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1j9y0q-0000s7-IQ; Thu, 05 Mar 2020 22:26:36 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] ARM: dts: imx25-pinfunc: add config for kpp rows 4 to 7
Date:   Thu,  5 Mar 2020 22:26:24 +0100
Message-Id: <20200305212623.5601-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX25's Keypad Port (KPP) can be used with a key pad matrix of up to
8 x 8 keys. Add pin configurations for rows 4 to 7.

The new defines have been tested on an out-of-tree board.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/boot/dts/imx25-pinfunc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
index b5a12412440e..111bfdcbe552 100644
--- a/arch/arm/boot/dts/imx25-pinfunc.h
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -255,10 +255,12 @@
 
 #define MX25_PAD_LD12__LD12			0x0f8 0x2f0 0x000 0x00 0x000
 #define MX25_PAD_LD12__CSPI2_MOSI		0x0f8 0x2f0 0x4a0 0x02 0x000
+#define MX25_PAD_LD12__KPP_ROW6			0x0f8 0x2f0 0x544 0x04 0x000
 #define MX25_PAD_LD12__FEC_RDATA3		0x0f8 0x2f0 0x510 0x05 0x001
 
 #define MX25_PAD_LD13__LD13			0x0fc 0x2f4 0x000 0x00 0x000
 #define MX25_PAD_LD13__CSPI2_MISO		0x0fc 0x2f4 0x49c 0x02 0x000
+#define MX25_PAD_LD13__KPP_ROW7			0x0fc 0x2f4 0x548 0x04 0x000
 #define MX25_PAD_LD13__FEC_TDATA2		0x0fc 0x2f4 0x000 0x05 0x000
 
 #define MX25_PAD_LD14__LD14			0x100 0x2f8 0x000 0x00 0x000
@@ -516,9 +518,11 @@
 
 #define MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x1d8 0x3d0 0x000 0x00 0x000
 #define MX25_PAD_FEC_TX_EN__GPIO_3_9		0x1d8 0x3d0 0x000 0x05 0x000
+#define MX25_PAD_FEC_TX_EN__KPP_ROW4		0x1d8 0x3d0 0x53c 0x06 0x000
 
 #define MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x1dc 0x3d4 0x000 0x00 0x000
 #define MX25_PAD_FEC_RDATA0__GPIO_3_10		0x1dc 0x3d4 0x000 0x05 0x000
+#define MX25_PAD_FEC_RDATA0__KPP_ROW5 		0x1dc 0x3d4 0x540 0x06 0x000
 
 #define MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x1e0 0x3d8 0x000 0x00 0x000
 /*
-- 
2.20.1

