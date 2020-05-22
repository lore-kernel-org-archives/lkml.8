Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6288205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159569;
	bh=ANJLV3hUN0eVoqgiZj7BF9PIdjzd9Cn33TUSH8PQwo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rmKV77LQFSCnSSaMH9neuy0RLyDIo0hn2qggOct0OzYov0nRhY2PcFfwoeKnNW3/l
	 PLJCbKbv24ju0DJk3oe5gUDBEMd1rrm08wCI1zZ8jdIBtd5V5lFkr+BbL8HTwRcxau
	 qZuk0KGSWbbw6NfTEMk3damKl1BrChYOAzC2Lwvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgEVOuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730360AbgEVOuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A84223BF;
        Fri, 22 May 2020 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159007;
        bh=ANJLV3hUN0eVoqgiZj7BF9PIdjzd9Cn33TUSH8PQwo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4xN5nvElpK+kRLqf5GrgkigYJzZIMoo3zwDgRTsN5TJxyqHoERWrihMOiS0kLfCt
         AWoMKgaE2uYGcB9ncjdi+5bt1AFYa/RweMQbAgUY8oByOCA+cZl1GePO1E6TkpsrIE
         mZUujXxq7SnycIfZ+YgOzE/kvWxnA86vTGXqLwhE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 06/41] ARM: dts: rockchip: swap clock-names of gpu nodes
Date:   Fri, 22 May 2020 10:49:23 -0400
Message-Id: <20200522144959.434379-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522144959.434379-1-sashal@kernel.org>
References: <20200522144959.434379-1-sashal@kernel.org>
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
index 4e90efdc9630..729119952c68 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -561,7 +561,7 @@
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

