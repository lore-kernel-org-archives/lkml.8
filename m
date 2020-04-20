Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F86FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE70E20747
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgDTLWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:22:47 -0400
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:50684 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgDTLWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:22:46 -0400
X-Greylist: delayed 868 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2020 07:22:44 EDT
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 03KB7Z7j031036;
        Mon, 20 Apr 2020 14:07:40 +0300
Received: from oak.local (unknown [188.123.231.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 8DFB349CC;
        Mon, 20 Apr 2020 14:07:36 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: zynq: Fix ethernet PHY for v5 schematics
Date:   Mon, 20 Apr 2020 14:07:15 +0300
Message-Id: <20200420110715.12032-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are at least two different versions existing for MYIR Zturn:

 * v4 schematics has Atheros AR8035 PHY at 0b000
     http://www.myirtech.com/download/Zynq7000/Z-TURNBOARD_schematic.pdf
 * v5 schematics has Micrel KSZ9031 PHY at 0b011
     v5 schematics available at DVD disk supplied with the board

Specify both PHYs to make ethernet interface working for any board
revision. This commit relies on of_mdiobus_register() behaviour.

Before the patch:

[   28.295002] macb e000b000.ethernet eth0: Could not attach PHY (-19)

After the patch:

[   28.257365] macb e000b000.ethernet eth0: PHY [e000b000.ethernet-ffffffff:00] driver [Micrel KSZ9031 Gigabit PHY] (irq=POLL)
[   28.257384] macb e000b000.ethernet eth0: configuring for phy/rgmii-id link mode

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 arch/arm/boot/dts/zynq-zturn.dts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-zturn.dts b/arch/arm/boot/dts/zynq-zturn.dts
index 5ec616ebca08..07da9cf60d02 100644
--- a/arch/arm/boot/dts/zynq-zturn.dts
+++ b/arch/arm/boot/dts/zynq-zturn.dts
@@ -67,10 +67,17 @@
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
-	phy-handle = <&ethernet_phy>;
 
-	ethernet_phy: ethernet-phy@0 {
-		reg = <0x0>;
+	ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		max-speed = <1000>;
+	};
+
+	ethernet-phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <3>;
+		max-speed = <1000>;
 	};
 };
 
-- 
2.16.4

