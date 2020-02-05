Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B6C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A40218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgBEObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:31:25 -0500
Received: from comms.puri.sm ([159.203.221.185]:49106 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbgBEObW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:31:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id BAF15E0E8A;
        Wed,  5 Feb 2020 06:31:21 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T2ynE6JqBJDL; Wed,  5 Feb 2020 06:31:21 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v1 10/12] arm64: dts: librem5-devkit: configure VSELECT
Date:   Wed,  5 Feb 2020 15:30:01 +0100
Message-Id: <20200205143003.28408-11-martin.kepplinger@puri.sm>
In-Reply-To: <20200205143003.28408-1-martin.kepplinger@puri.sm>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

use vselect to set the io voltage to 1.8V

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index fbc7062c4633..8f920c554ebd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -789,6 +789,7 @@
 			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xc3
 			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xc3
 			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xc3
+			MX8MQ_IOMUXC_GPIO1_IO04_GPIO1_IO4	0xc1
 		>;
 	};
 
@@ -800,6 +801,7 @@
 			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xcd
 			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xcd
 			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xcd
+			MX8MQ_IOMUXC_GPIO1_IO04_GPIO1_IO4	0xc1
 		>;
 	};
 
@@ -811,6 +813,7 @@
 			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1	0xcf
 			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2	0xcf
 			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3	0xcf
+			MX8MQ_IOMUXC_GPIO1_IO04_GPIO1_IO4	0xc1
 		>;
 	};
 
-- 
2.20.1

