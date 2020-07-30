Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18DCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC69E2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="jvFCiK6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgG3KXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:23:09 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:60268 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbgG3KXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:23:08 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2020 06:23:07 EDT
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 5CE4BA0828;
        Thu, 30 Jul 2020 12:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1596104030;
        bh=zRbadOeZ+63tn6S8alO37yU2ZdtL1Il1uzwgccWCVMM=;
        h=From:To:Cc:Subject:Date:From;
        b=jvFCiK6RExGzZxG/NIMSTloiTeKF0BdkrvgzWwKqNZshZEDxIMy3g6IaD7Q2ZQOlD
         OmIwaI9kwG5JbHCM2iIWny04zvSau3DiF24LAUJ6apDiVefefKe6uDVMWRUK4q6YMI
         jvURNHhg/dI42T9EALGbkdF6GjQkdFIDuIJSS55E=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] ARM: dts: imx6dl-yapp4: Add ethernet aliases
Date:   Thu, 30 Jul 2020 12:13:46 +0200
Message-Id: <1596104026-21091-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add aliases for ethernet switch ports to allow bootloader to fix
MAC addresses to the ones stored in onboard configuration EEPROM.

Ursa has only one ethernet port populated (eth2) so alias for
the first port has to be removed on this board.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 9 +++++++--
 arch/arm/boot/dts/imx6dl-yapp4-ursa.dts    | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 999be02d1c03..508ee6adaff8 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -8,6 +8,11 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
+	aliases: aliases {
+		ethernet1 = &eth1;
+		ethernet2 = &eth2;
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
@@ -151,13 +156,13 @@
 					};
 				};
 
-				port@2 {
+				eth2: port@2 {
 					reg = <2>;
 					label = "eth2";
 					phy-handle = <&phy_port2>;
 				};
 
-				port@3 {
+				eth1: port@3 {
 					reg = <3>;
 					label = "eth1";
 					phy-handle = <&phy_port3>;
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-ursa.dts b/arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
index a1173bf5bff5..f6ae24efd4aa 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
+++ b/arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
@@ -17,6 +17,10 @@
 	};
 };
 
+&aliases {
+	/delete-property/ ethernet1;
+};
+
 &backlight {
 	status = "okay";
 };
-- 
2.1.4

