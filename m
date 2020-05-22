Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0BBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00652240A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159098;
	bh=6hL+ivj3rYrMJO2OGFWOhbOEztvulwmcwF/BhZn/yPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UdmdoT8XBKKMY88KAKb70o0oogq+lzlfSbZVrPainRiD4AFwCIdWf7iASnXTdDqoj
	 VH3HHWxNssO6h0Aha9xIOyFU66z/TOh7J36Q8xB3SjIvCWtSL+tqp4t1I/MVfIfJfR
	 qdNbeHBY2IB82hJbVI1X3mfEzJ2bISTCWZNkwQH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgEVOvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730999AbgEVOv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:51:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB3FF22259;
        Fri, 22 May 2020 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159085;
        bh=6hL+ivj3rYrMJO2OGFWOhbOEztvulwmcwF/BhZn/yPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GArSbYIAfV/M24NCNJ0JAw0oemJAgo1mn0N4GzfLEASl5YFZIPNMlm/48um4EqSGM
         fBt64unnwArnjyXI/D6AXbtYF4CZfVIP/qkMejwxG6fsrgNGxECCGBr3h3AmXV2XcY
         5I/L0MeUB5voE0CoEG0MHemhJu4QcQqsAHHK9sNw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/19] ARM: dts: rockchip: swap clock-names of gpu nodes
Date:   Fri, 22 May 2020 10:51:05 -0400
Message-Id: <20200522145120.434921-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145120.434921-1-sashal@kernel.org>
References: <20200522145120.434921-1-sashal@kernel.org>
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
index d560fc4051c5..db612271371b 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -128,7 +128,7 @@
 		assigned-clocks = <&cru SCLK_GPU>;
 		assigned-clock-rates = <100000000>;
 		clocks = <&cru SCLK_GPU>, <&cru SCLK_GPU>;
-		clock-names = "core", "bus";
+		clock-names = "bus", "core";
 		resets = <&cru SRST_GPU>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index cd8f2a3b0e91..bada942ef38d 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -539,7 +539,7 @@
 				  "pp1",
 				  "ppmmu1";
 		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
-		clock-names = "core", "bus";
+		clock-names = "bus", "core";
 		resets = <&cru SRST_GPU_A>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index d752dc611fd7..86a0d98d28ff 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -84,7 +84,7 @@
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

