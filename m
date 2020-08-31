Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E2EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE5820767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="QG9Bcy4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHaOkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgHaOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:39:59 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6649FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:39:57 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id BDE1F5FC42;
        Mon, 31 Aug 2020 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1598884787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RdOFWohILbsEDDDJFVfgHhbn+dw2QRxvLWyTIr2kZpU=;
        b=QG9Bcy4D86OBecjJqWP/tcMdwIDTmE3hui2EQ3NEBrH3qBuuFq8y7TPOkYLJ74hzHCBfqO
        GdVDgwMDOXnAwgRC2dO/ece+hky352oQocmZjea1+DndpMN5MpSeAQ3HrfuD3Oge125XMv
        BA3xEHZYF/djXMSn2ohFAMZquyS9WN4=
Received: from localhost.localdomain (fttx-pool-217.61.158.151.bambit.de [217.61.158.151])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id EEE3C1005C3;
        Mon, 31 Aug 2020 14:39:46 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Alex Ryabchenko <d3adme4t@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chunkuang.hu@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH] arm: dts: mt7623: add lima related regulator
Date:   Mon, 31 Aug 2020 16:39:37 +0200
Message-Id: <20200831143937.28259-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Ryabchenko <d3adme4t@gmail.com>

GPU needs additional regulator, add it to devicetree of bpi-r2

Signed-off-by: Alex Ryabchenko <d3adme4t@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index f41f221e56ca..826912545ef1 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -79,6 +79,13 @@ reg_5v: regulator-5v {
 		regulator-always-on;
 	};
 
+	reg_vgpu: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_fixed_vgpu";
+		regulator-min-microvolt = <1150000>;
+		regulator-max-microvolt = <1150000>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -283,6 +290,11 @@ &i2c1 {
 	status = "okay";
 };
 
+&mali {
+	mali-supply = <&reg_vgpu>;
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default", "state_uhs";
 	pinctrl-0 = <&mmc0_pins_default>;
@@ -402,4 +414,3 @@ &u3phy1 {
 &u3phy2 {
 	status = "okay";
 };
-
-- 
2.25.1

