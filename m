Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A29920659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660651;
	bh=kHnwlx9BCRreA8gSpamAv5AUS0PWWZVe+8Pj/JLgOwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ylesc4G2rGdzJztj8LLHhAQ/UhrLirohY35ch1BIOJZJK8oimVOK3FAKy0ZKZg4pq
	 QIhxTIlXFrSDXT6zmt2KAJ9skMw1IT8pDiBley+eOdNa7zvSeCAlq16ehX7fRb40vh
	 8KhGIc+zxc5ZxqzlFzMAN1tPTVcdrnqFSpA5aMwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgFHXX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgFHXS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21C02088E;
        Mon,  8 Jun 2020 23:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658305;
        bh=kHnwlx9BCRreA8gSpamAv5AUS0PWWZVe+8Pj/JLgOwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mr0MEHwvY1KKWj4DljtbQrNio5LtuHRBDWVbr8a0smgLDOuywmXaP78DCzIZcSsY2
         KEIUjwsrBZn6AV+y9XdnSHw+0LptDfMNkPXhZoMCnvctA8h8zJv7QdK5dM4fNhYuPO
         3DZlTTuUBZN5qFp6QjLMoovMrKlZxfNJnkgG9qu8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Ian Ray <ian.ray@ge.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 307/606] ARM: dts/imx6q-bx50v3: Set display interface clock parents
Date:   Mon,  8 Jun 2020 19:07:12 -0400
Message-Id: <20200608231211.3363633-307-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Beckett <bob.beckett@collabora.com>

[ Upstream commit 665e7c73a7724a393b4ec92d1ae1e029925ef2b7 ]

Avoid LDB and IPU DI clocks both using the same parent. LDB requires
pasthrough clock to avoid breaking timing while IPU DI does not.

Force IPU DI clocks to use IMX6QDL_CLK_PLL2_PFD0_352M as parent
and LDB to use IMX6QDL_CLK_PLL5_VIDEO_DIV.

This fixes an issue where attempting atomic modeset while using
HDMI and display port at the same time causes LDB clock programming
to destroy the programming of HDMI that was done during the same
modeset.

Cc: stable@vger.kernel.org
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
[Use IMX6QDL_CLK_PLL2_PFD0_352M instead of IMX6QDL_CLK_PLL2_PFD2_396M
 originally chosen by Robert Beckett to avoid affecting eMMC clock
 by DRM atomic updates]
Signed-off-by: Ian Ray <ian.ray@ge.com>
[Squash Robert's and Ian's commits for bisectability, update patch
 description and add stable tag]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6q-b450v3.dts  |  7 -------
 arch/arm/boot/dts/imx6q-b650v3.dts  |  7 -------
 arch/arm/boot/dts/imx6q-b850v3.dts  | 11 -----------
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 15 +++++++++++++++
 4 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
index 95b8f2d71821..fb0980190aa0 100644
--- a/arch/arm/boot/dts/imx6q-b450v3.dts
+++ b/arch/arm/boot/dts/imx6q-b450v3.dts
@@ -65,13 +65,6 @@ panel_in_lvds0: endpoint {
 	};
 };
 
-&clks {
-	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
-				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
-};
-
 &ldb {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
index 611cb7ae7e55..8f762d9c5ae9 100644
--- a/arch/arm/boot/dts/imx6q-b650v3.dts
+++ b/arch/arm/boot/dts/imx6q-b650v3.dts
@@ -65,13 +65,6 @@ panel_in_lvds0: endpoint {
 	};
 };
 
-&clks {
-	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
-				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
-};
-
 &ldb {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index e4cb118f88c6..1ea64ecf4291 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -53,17 +53,6 @@ chosen {
 	};
 };
 
-&clks {
-	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
-			  <&clks IMX6QDL_CLK_IPU1_DI0_PRE_SEL>,
-			  <&clks IMX6QDL_CLK_IPU2_DI0_PRE_SEL>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
-				 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
-				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
-				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>;
-};
-
 &ldb {
 	fsl,dual-channel;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index fa27dcdf06f1..1938b04199c4 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -377,3 +377,18 @@ pci_root: root@0,0 {
 		#interrupt-cells = <1>;
 	};
 };
+
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
+			  <&clks IMX6QDL_CLK_IPU1_DI0_PRE_SEL>,
+			  <&clks IMX6QDL_CLK_IPU1_DI1_PRE_SEL>,
+			  <&clks IMX6QDL_CLK_IPU2_DI0_PRE_SEL>,
+			  <&clks IMX6QDL_CLK_IPU2_DI1_PRE_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
+				 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD0_352M>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD0_352M>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD0_352M>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD0_352M>;
+};
-- 
2.25.1

