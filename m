Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E540C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B2720853
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662167;
	bh=AWCLOTsOVYlks3c11ILR2yy+m7XFAsly4FIalG791BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2yHV4Bt/Xsg8t05+oEyVryfae0jtQnF/ZOc5o3hbivlkn/jeJSmPjMBfUQ46BMW7
	 pMLp4TD6UBL5cuxGR7ZdeT6WAvCJ6lgxLTMPOW+oK9978i4OqHIYKdOV03piBXWFdn
	 sbmed9QJrOtNCKpyAhdkO3vVFSu/iFJ+fZ1vRC+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbgFIAWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgFHXRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:17:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C8E20872;
        Mon,  8 Jun 2020 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658245;
        bh=AWCLOTsOVYlks3c11ILR2yy+m7XFAsly4FIalG791BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPr1n6HQZtGSwh/hQP0I6CxN9ZJ3df6PZWJLSj5hXhQHVH0dW94iWDyLt39KnNA5B
         X/VT0I3hI6BUvRl1s4jkkFfZA86dsV3SZmRNcVzOT5FT65X1YDCb2iDTX6l8oDxmU4
         kbjr1tvIYxxU4AcOcbXtZLdsWjD2yRkcnkrjDS48=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 255/606] ARM: dts: rockchip: swap clock-names of gpu nodes
Date:   Mon,  8 Jun 2020 19:06:20 -0400
Message-Id: <20200608231211.3363633-255-sashal@kernel.org>
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

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit b14f3898d2c25a9b47a61fb879d0b1f3af92c59b ]

Dts files with Rockchip 'gpu' nodes were manually verified.
In order to automate this process arm,mali-utgard.txt
has been converted to yaml. In the new setup dtbs_check with
arm,mali-utgard.yaml expects clock-names values
in the same order, so fix that.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/20200425192500.1808-1-jbx6244@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3036.dtsi | 2 +-
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 arch/arm/boot/dts/rk3xxx.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index cf36e25195b4..8c4b8f56c9e0 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -128,7 +128,7 @@ gpu: gpu@10090000 {
 		assigned-clocks = <&cru SCLK_GPU>;
 		assigned-clock-rates = <100000000>;
 		clocks = <&cru SCLK_GPU>, <&cru SCLK_GPU>;
-		clock-names = "core", "bus";
+		clock-names = "bus", "core";
 		resets = <&cru SRST_GPU>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 4e90efdc9630..729119952c68 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -561,7 +561,7 @@ gpu: gpu@20000000 {
 				  "pp1",
 				  "ppmmu1";
 		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
-		clock-names = "core", "bus";
+		clock-names = "bus", "core";
 		resets = <&cru SRST_GPU_A>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 241f43e29c77..bb5ff10b9110 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -84,7 +84,7 @@ gpu: gpu@10090000 {
 		compatible = "arm,mali-400";
 		reg = <0x10090000 0x10000>;
 		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
-		clock-names = "core", "bus";
+		clock-names = "bus", "core";
 		assigned-clocks = <&cru ACLK_GPU>;
 		assigned-clock-rates = <100000000>;
 		resets = <&cru SRST_GPU>;
-- 
2.25.1

