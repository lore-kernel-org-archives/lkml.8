Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7595C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1BC246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgB0NSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:18:02 -0500
Received: from comms.puri.sm ([159.203.221.185]:39788 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgB0NR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:17:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 23444DFD30;
        Thu, 27 Feb 2020 05:17:59 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B4fOomCxCS8C; Thu, 27 Feb 2020 05:17:58 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 4/8] arm64: dts: librem5-devkit: allow modem to wake the system from suspend
Date:   Thu, 27 Feb 2020 14:17:29 +0100
Message-Id: <20200227131733.4228-5-martin.kepplinger@puri.sm>
In-Reply-To: <20200227131733.4228-1-martin.kepplinger@puri.sm>
References: <20200227131733.4228-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Connect the WoWWAN signal to a gpio key to wake up the system from suspend.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 84443e4857d5..823d5c60a8fa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -55,6 +55,15 @@
 			wakeup-source;
 			linux,code = <KEY_HP>;
 		};
+
+		wwan-wake {
+			label = "WWAN_WAKE";
+			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <8 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+			linux,code = <KEY_PHONE>;
+		};
 	};
 
 	leds {
@@ -576,6 +585,7 @@
 			MX8MQ_IOMUXC_SAI2_RXFS_GPIO4_IO21	0x16
 			MX8MQ_IOMUXC_SAI2_RXC_GPIO4_IO22	0x16
 			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20	0x180  /* HP_DET */
+			MX8MQ_IOMUXC_NAND_DATA02_GPIO3_IO8	0x80   /* nWoWWAN */
 		>;
 	};
 
-- 
2.20.1

