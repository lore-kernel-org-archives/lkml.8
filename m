Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68F3C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BD42082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBDVxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:53:15 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:42144 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbgBDVxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:53:14 -0500
Received: from dslb-188-097-045-114.188.097.pools.vodafone-ip.de ([188.97.45.114] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1iz680-0005J0-K3; Tue, 04 Feb 2020 22:53:04 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] ARM: dts: imx25-pinfunc: add another cspi3 config
Date:   Tue,  4 Feb 2020 22:52:29 +0100
Message-Id: <20200204215229.32485-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds defines for another cspi3 configuration.
The defines have been tested on an out-of-tree board.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/boot/dts/imx25-pinfunc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
index f4516ccf2c1a..b5a12412440e 100644
--- a/arch/arm/boot/dts/imx25-pinfunc.h
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -82,6 +82,7 @@
 #define MX25_PAD_EB0__EB0			0x040 0x258 0x000 0x00 0x000
 #define MX25_PAD_EB0__AUD4_TXD			0x040 0x258 0x464 0x04 0x000
 #define MX25_PAD_EB0__GPIO_2_12			0x040 0x258 0x000 0x05 0x000
+#define MX25_PAD_EB0__CSPI3_SS0			0x040 0x258 0x4bc 0x06 0x000
 
 #define MX25_PAD_EB1__EB1			0x044 0x25c 0x000 0x00 0x000
 #define MX25_PAD_EB1__AUD4_RXD			0x044 0x25c 0x460 0x04 0x000
@@ -102,11 +103,13 @@
 #define MX25_PAD_CS4__NF_CE1			0x054 0x264 0x000 0x01 0x000
 #define MX25_PAD_CS4__UART5_CTS			0x054 0x264 0x000 0x03 0x000
 #define MX25_PAD_CS4__GPIO_3_20			0x054 0x264 0x000 0x05 0x000
+#define MX25_PAD_CS4__CSPI3_MOSI		0x054 0x264 0x4b8 0x06 0x000
 
 #define MX25_PAD_CS5__CS5			0x058 0x268 0x000 0x00 0x000
 #define MX25_PAD_CS5__NF_CE2			0x058 0x268 0x000 0x01 0x000
 #define MX25_PAD_CS5__UART5_RTS			0x058 0x268 0x574 0x03 0x000
 #define MX25_PAD_CS5__GPIO_3_21			0x058 0x268 0x000 0x05 0x000
+#define MX25_PAD_CS5__CSPI3_MISO		0x058 0x268 0x4b4 0x06 0x000
 
 #define MX25_PAD_NF_CE0__NF_CE0			0x05c 0x26c 0x000 0x00 0x000
 #define MX25_PAD_NF_CE0__GPIO_3_22		0x05c 0x26c 0x000 0x05 0x000
@@ -114,6 +117,7 @@
 #define MX25_PAD_ECB__ECB			0x060 0x270 0x000 0x00 0x000
 #define MX25_PAD_ECB__UART5_TXD			0x060 0x270 0x000 0x03 0x000
 #define MX25_PAD_ECB__GPIO_3_23			0x060 0x270 0x000 0x05 0x000
+#define MX25_PAD_ECB__CSPI3_SCLK		0x060 0x270 0x4ac 0x06 0x000
 
 #define MX25_PAD_LBA__LBA			0x064 0x274 0x000 0x00 0x000
 #define MX25_PAD_LBA__UART5_RXD			0x064 0x274 0x578 0x03 0x000
-- 
2.20.1

