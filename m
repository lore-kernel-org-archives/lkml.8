Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66B0C34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AD822B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRIuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:50:54 -0500
Received: from comms.puri.sm ([159.203.221.185]:39850 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgBRIuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:50:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4DD70E1145;
        Tue, 18 Feb 2020 00:50:52 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v_J22nh3zXtn; Tue, 18 Feb 2020 00:50:51 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 5/9] arm64: dts: librem5-devkit: add a vbus supply to usb0
Date:   Tue, 18 Feb 2020 09:49:38 +0100
Message-Id: <20200218084942.4884-6-martin.kepplinger@puri.sm>
In-Reply-To: <20200218084942.4884-1-martin.kepplinger@puri.sm>
References: <20200218084942.4884-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Without a VBUS supply the dwc3 driver won't go into otg mode.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Sigend-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 9c81b07f43f3..acd68e8fb43e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -870,6 +870,7 @@
 };
 
 &usb3_phy0 {
+	vbus-supply = <&reg_5v_p>;
 	status = "okay";
 };
 
-- 
2.20.1

