Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC608C33CA9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83007207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 14:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="PeFHqgnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgALOA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 09:00:58 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:40841 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732953AbgALOA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 09:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=x/nFsgxdZk2EqfYZUP7PzEgKBJXPtYD799bZSXKee+k=; b=PeFHqgnJWiimG9LrZ3vLnHxqif
        oYhJwWGkITCb/A2EvB/FCHV1/EfHeVVA3JePB5swfYvm+mVI0ZnxlFCz0ZUcPuZ+G2XNKB5Gmbq4V
        XUh+2MiZxMMO1yExblF8UO+tqO0DPVONvEMNU8q6jEcI4p0wWptjevLW9W90qIqvOq1qR0/Bvw8ML
        X+6zlocRWHQZh4HV4i0uB0GxmrKVmKUWpjonBUha48JK4IhnFehltEcNDBquiLRwl+2E7ufZoeoTy
        lSaAN14TswxPNNcTHdYLmGgBEIMBBz28pNthx1MfE9ABK7aPMSmpAiUVS9XDLut1/6bJeMCi0Yo32
        sWqEe6yQ==;
Received: from puh7.kyla.fi ([82.130.43.239] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <aapo.vienamo@iki.fi>)
        id 1iqdnQ-0004c3-Q3; Sun, 12 Jan 2020 16:00:52 +0200
From:   Aapo Vienamo <aapo.vienamo@iki.fi>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Aapo Vienamo <aapo.vienamo@iki.fi>
Subject: [PATCH v3] ARM: mxs: Enable usbphy1 and usb1 on apx4devkit DTS
Date:   Sun, 12 Jan 2020 16:00:39 +0200
Message-Id: <20200112140039.25420-1-aapo.vienamo@iki.fi>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 82.130.43.239
X-SA-Exim-Mail-From: aapo.vienamo@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB host port on the APx4 development board.

Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>
---
 arch/arm/boot/dts/imx28-apx4devkit.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 3a184d13887b..c5acc19c982d 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -183,10 +183,20 @@ auart2: serial@8006e000 {
 				pinctrl-0 = <&auart2_2pins_a>;
 				status = "okay";
 			};
+
+			usbphy1: usbphy@8007e000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&usb1_pins_a>;
+				status = "okay";
+			};
 		};
 	};
 
 	ahb@80080000 {
+		usb1: usb@80090000 {
+		      status = "okay";
+		};
+
 		mac0: ethernet@800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
-- 
2.24.1

