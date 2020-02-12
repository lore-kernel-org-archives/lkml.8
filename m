Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77126C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1C02082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581518522;
	bh=Ph7c857eirFez6JYBKw+nD34hjDRRznioR/hKPDkqX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mjDYpnW16RsIDyfY3hdO6Exw9amfmfiN7+KNpR0j1znJk8fl/NVBtdH7OhaXt6o5a
	 KDke/U9wIxcz2hnNwNCzyjTXQW6w5LADV2SrTJGbCLdRHIZoy0T3bIm13wI/n5aiWk
	 0Wvcj9N0GATZ5zPQL5FndHrr5kGZv/i2aJitzucI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBLOmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgBLOl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:41:58 -0500
Received: from localhost.localdomain (unknown [213.195.124.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8020B20873;
        Wed, 12 Feb 2020 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581518518;
        bh=Ph7c857eirFez6JYBKw+nD34hjDRRznioR/hKPDkqX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOvgS3FdeuRKRMI2pJPKem39t6r1MDHwwdqyKWnHVLy2sq3/rhTb+KtFPcwtuziRT
         s3SE2qM/GQ0JkuV03paHVWxkU0p0sjOjcwX8IlTZPjYMvgArMQ9ineWDpQ4J5F1OiE
         6o+J6+pPVBkqom/N2WnF/iC90v92z5IkNWl+qQ7Y=
From:   matthias.bgg@kernel.org
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/2] arm64: dts: mediatek: rename scpsys nodes to power-controller
Date:   Wed, 12 Feb 2020 15:41:45 +0100
Message-Id: <20200212144145.25407-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212144145.25407-1-matthias.bgg@kernel.org>
References: <20200212144145.25407-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The nodes with name scpsys actually implement a power-controller.
Rename the nodes to match the bindings description.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 2 +-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi  | 2 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi  | 2 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 43307bad3f0d..a00c5caa1915 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -278,7 +278,7 @@ pio: pinctrl@10005000 {
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	scpsys: scpsys@10006000 {
+	scpsys: power-controller@10006000 {
 		compatible = "mediatek,mt2712-scpsys", "syscon";
 		#power-domain-cells = <1>;
 		reg = <0 0x10006000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 2b2a69c7567f..136ef9527a0d 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -157,7 +157,7 @@ pins1 {
 		};
 	};
 
-	scpsys: scpsys@10006000 {
+	scpsys: power-controller@10006000 {
 		compatible = "mediatek,mt6797-scpsys";
 		#power-domain-cells = <1>;
 		reg = <0 0x10006000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index dac51e98204c..339dc9f88f43 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -230,7 +230,7 @@ pericfg: pericfg@10002000 {
 		#reset-cells = <1>;
 	};
 
-	scpsys: scpsys@10006000 {
+	scpsys: power-controller@10006000 {
 		compatible = "mediatek,mt7622-scpsys",
 			     "syscon";
 		#power-domain-cells = <1>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 8b4e806d5119..9ab22dac925d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -436,7 +436,7 @@ pins1 {
 			};
 		};
 
-		scpsys: scpsys@10006000 {
+		scpsys: power-controller@10006000 {
 			compatible = "mediatek,mt8173-scpsys";
 			#power-domain-cells = <1>;
 			reg = <0 0x10006000 0 0x1000>;
-- 
2.24.1

