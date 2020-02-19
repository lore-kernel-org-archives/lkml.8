Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C37C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9210024677
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgBSRBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:01:24 -0500
Received: from muru.com ([72.249.23.125]:56054 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgBSRBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:01:17 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C6BB4816A;
        Wed, 19 Feb 2020 17:02:01 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: omap4-droid4: Enable basic modem support
Date:   Wed, 19 Feb 2020 09:01:06 -0800
Message-Id: <20200219170106.38543-5-tony@atomide.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200219170106.38543-1-tony@atomide.com>
References: <20200219170106.38543-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows apps to use /dev/motmdm1 for voice call AT commands,
/dev/motmdm3 for sending SMS, and /dev/motmdm9 for reading SMS.

Voice call audio mixer and GNSS are not yet supported.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -689,6 +689,12 @@ &uart1 {
 	pinctrl-0 = <&uart1_pins>;
 	interrupts-extended = <&wakeupgen GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0xfc>;
+
+	modem {
+		compatible = "motorola,mapphone-mdm6600-serial";
+		phys = <&fsusb1_phy>;
+		phy-names = "usb";
+	};
 };
 
 &uart3 {
-- 
2.25.1
