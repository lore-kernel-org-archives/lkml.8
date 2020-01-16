Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5067C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13F4206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201907;
	bh=NQPAdyaAP2EytZnPVR+ZjNCeYN6ANWeK/buvrcz58cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sA4lZPCVEsOJCJ01MQEprqwVFf9N19M3qViKtAHKmkYoqBDlcjVtEpP2hrR0WTbOB
	 rDJSTdcW5OFKRyiOhV5JzrIEuGG3MCaY2OoxPKC4n0nJy+EMX/OIU2TcDT0V/M8ISh
	 2EDyPBTyZFiHDGGMDHGZkpMNYrG/EHPRLFX2o85c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbgAPTLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbgAPRAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:00:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767A820728;
        Thu, 16 Jan 2020 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194011;
        bh=NQPAdyaAP2EytZnPVR+ZjNCeYN6ANWeK/buvrcz58cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Id8BH3CTEFKri0EuSVhaY1q9FdPfmqfWpO3NgyOexQ6P2WAncm+HMA5ghb638hIMr
         /emxQpeUqNA6R/EsZdZFgGb2dt/+pTZi2BVD5ABGoe5myiOwH3Rly98s25k0AjYK9Q
         aKDkwgNJM+44uhoSkX+ncGtDiAqHHNK3Rsyqonro=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 135/671] arm64: dts: allwinner: h6: Move GIC device node fix base address ordering
Date:   Thu, 16 Jan 2020 11:50:44 -0500
Message-Id: <20200116165940.10720-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 52d9bcb3d0de3fa1e07aff3800f857836d30410d ]

The GIC device node was placed out of order in the initial device tree
submission. Move it so the nodes are correctly sorted by base address
again.

Fixes: e54be32d0273 ("arm64: allwinner: h6: add the basical Allwinner H6 DTSI file")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index cfa5fffcf62b..72813e7aefb8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -101,17 +101,6 @@
 			#reset-cells = <1>;
 		};
 
-		gic: interrupt-controller@3021000 {
-			compatible = "arm,gic-400";
-			reg = <0x03021000 0x1000>,
-			      <0x03022000 0x2000>,
-			      <0x03024000 0x2000>,
-			      <0x03026000 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-		};
-
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
@@ -149,6 +138,17 @@
 			};
 		};
 
+		gic: interrupt-controller@3021000 {
+			compatible = "arm,gic-400";
+			reg = <0x03021000 0x1000>,
+			      <0x03022000 0x2000>,
+			      <0x03024000 0x2000>,
+			      <0x03026000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
 		mmc0: mmc@4020000 {
 			compatible = "allwinner,sun50i-h6-mmc",
 				     "allwinner,sun50i-a64-mmc";
-- 
2.20.1

