Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7A2C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2FD207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498286;
	bh=yvfnzkumOLeNZfCzoJKHdy3baNkUPfQBaVECQlvIDrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jLrzKqW/sTdu432gfNEC6+S17gBaBGF8oaMJGch6EnfIz8sX3X6jqyYvnnHg+5+Yn
	 121lQA1h/xNC+trxB6lJi26MHC9BtHN1tjg5dx1AehK/dc73coHEwzS8vHls/0RE3D
	 ePfuYDoUvSuu4oulfTVGWzMHT35pl7qHPzbJuBN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgIGREp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbgIGQdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:33:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9000221973;
        Mon,  7 Sep 2020 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496392;
        bh=yvfnzkumOLeNZfCzoJKHdy3baNkUPfQBaVECQlvIDrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1xBt7gLf7BCrHQ+tuuwPPhXyaHZjCpTjvlR0xSdkCi66iHckqV+m/RVn9Qm2K8s3
         1zHO03vUgO99sBQdsJkINLmqocCscZ1c1pa9qx578bQs6m1DDEV8c8jRpVce3gN8I0
         KzNHeY+s9e6FiZvf2BLOtL9TsD7U0b339u/B1Lh8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 41/53] ARC: [plat-hsdk]: Switch ethernet phy-mode to rgmii-id
Date:   Mon,  7 Sep 2020 12:32:07 -0400
Message-Id: <20200907163220.1280412-41-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>

[ Upstream commit 26907eb605fbc3ba9dbf888f21d9d8d04471271d ]

HSDK board has Micrel KSZ9031, recent commit
bcf3440c6dd ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
caused a breakdown of Ethernet.
Using 'phy-mode = "rgmii"' is not correct because accodring RGMII
specification it is necessary to have delay on RX (PHY to MAX)
which is not generated in case of "rgmii".
Using "rgmii-id" adds necessary delay and solves the issue.

Also adding name of PHY placed on HSDK board.

Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/boot/dts/hsdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 5d64a5a940ee6..dcaa44e408ace 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -210,7 +210,7 @@ gmac: ethernet@8000 {
 			reg = <0x8000 0x2000>;
 			interrupts = <10>;
 			interrupt-names = "macirq";
-			phy-mode = "rgmii";
+			phy-mode = "rgmii-id";
 			snps,pbl = <32>;
 			snps,multicast-filter-bins = <256>;
 			clocks = <&gmacclk>;
@@ -228,7 +228,7 @@ mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "snps,dwmac-mdio";
-				phy0: ethernet-phy@0 {
+				phy0: ethernet-phy@0 { /* Micrel KSZ9031 */
 					reg = <0>;
 				};
 			};
-- 
2.25.1

