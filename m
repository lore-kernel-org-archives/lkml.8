Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69174C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12ACB20C09
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599478664;
	bh=1jully7bPQ2FchgD+ghEArFdEFrPzNxnKoN/DYaezsY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PfAWrhsWYXvdOwK1cqQB5E6OWa6gPakle9U2FaQNHrxwUkZr33Hod2k5sPbADtYwM
	 Kuky6jhZt52b/rr+zTiFUkx9NXQL8EzkSfLBpEmbk4QtkBeArvhMvdeeztRjMRWELO
	 xkSWrE7sHoHU47qhPNQ7bdQmaP070PjJ9XACugsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgIGLcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgIGL1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:27:31 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA8F206D4;
        Mon,  7 Sep 2020 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599478050;
        bh=1jully7bPQ2FchgD+ghEArFdEFrPzNxnKoN/DYaezsY=;
        h=From:To:Cc:Subject:Date:From;
        b=gTG0Mr5GF6xbokSqvJI+yX9P5qytixd6j28/NL8fXckC6EHBmsIZOTpgT9SW1c6ny
         otXKv4jTA0O4gLFlCGrHmEnn3+x8CcmYLZJH6TTYi5S25A1540jw4hjbhhAiqEAFTe
         s+My98bF/kVwiyn/L4X4DW7gELGeSqUdI0t/ZI/4=
Received: by pali.im (Postfix)
        id 5A6E1814; Mon,  7 Sep 2020 13:27:28 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Andre Heider <a.heider@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch aliases
Date:   Mon,  7 Sep 2020 13:27:17 +0200
Message-Id: <20200907112718.5994-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Espressobin boards have 3 ethernet ports and some of them got assigned more
then one MAC address. MAC addresses are stored in U-Boot environment.

Since commit a2c7023f7075c ("net: dsa: read mac address from DT for slave
device") kernel can use MAC addresses from DT for particular DSA port.

Currently Espressobin DTS file contains alias just for ethernet0.

This patch defines additional ethernet aliases in Espressobin DTS files, so
bootloader can fill correct MAC address for DSA switch ports if more MAC
addresses were specified.

DT alias ethernet1 is used for wan port, DT aliases ethernet2 and ethernet3
are used for lan ports for both Espressobin revisions (V5 and V7).

Fixes: 5253cb8c00a6f ("arm64: dts: marvell: espressobin: add ethernet alias")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../dts/marvell/armada-3720-espressobin-v7-emmc.dts  | 10 ++++++++--
 .../boot/dts/marvell/armada-3720-espressobin-v7.dts  | 10 ++++++++--
 .../boot/dts/marvell/armada-3720-espressobin.dtsi    | 12 ++++++++----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
index 03733fd92732..215d2f702623 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
@@ -20,17 +20,23 @@
 	compatible = "globalscale,espressobin-v7-emmc", "globalscale,espressobin-v7",
 		     "globalscale,espressobin", "marvell,armada3720",
 		     "marvell,armada3710";
+
+	aliases {
+		/* ethernet1 is wan port */
+		ethernet1 = &switch0port3;
+		ethernet3 = &switch0port1;
+	};
 };
 
 &switch0 {
 	ports {
-		port@1 {
+		switch0port1: port@1 {
 			reg = <1>;
 			label = "lan1";
 			phy-handle = <&switch0phy0>;
 		};
 
-		port@3 {
+		switch0port3: port@3 {
 			reg = <3>;
 			label = "wan";
 			phy-handle = <&switch0phy2>;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
index 8570c5f47d7d..b6f4af8ebafb 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
@@ -19,17 +19,23 @@
 	model = "Globalscale Marvell ESPRESSOBin Board V7";
 	compatible = "globalscale,espressobin-v7", "globalscale,espressobin",
 		     "marvell,armada3720", "marvell,armada3710";
+
+	aliases {
+		/* ethernet1 is wan port */
+		ethernet1 = &switch0port3;
+		ethernet3 = &switch0port1;
+	};
 };
 
 &switch0 {
 	ports {
-		port@1 {
+		switch0port1: port@1 {
 			reg = <1>;
 			label = "lan1";
 			phy-handle = <&switch0phy0>;
 		};
 
-		port@3 {
+		switch0port3: port@3 {
 			reg = <3>;
 			label = "wan";
 			phy-handle = <&switch0phy2>;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index b97218c72727..0775c16e0ec8 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -13,6 +13,10 @@
 / {
 	aliases {
 		ethernet0 = &eth0;
+		/* for dsa slave device */
+		ethernet1 = &switch0port1;
+		ethernet2 = &switch0port2;
+		ethernet3 = &switch0port3;
 		serial0 = &uart0;
 		serial1 = &uart1;
 	};
@@ -120,7 +124,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			port@0 {
+			switch0port0: port@0 {
 				reg = <0>;
 				label = "cpu";
 				ethernet = <&eth0>;
@@ -131,19 +135,19 @@
 				};
 			};
 
-			port@1 {
+			switch0port1: port@1 {
 				reg = <1>;
 				label = "wan";
 				phy-handle = <&switch0phy0>;
 			};
 
-			port@2 {
+			switch0port2: port@2 {
 				reg = <2>;
 				label = "lan0";
 				phy-handle = <&switch0phy1>;
 			};
 
-			port@3 {
+			switch0port3: port@3 {
 				reg = <3>;
 				label = "lan1";
 				phy-handle = <&switch0phy2>;
-- 
2.20.1

