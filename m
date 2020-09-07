Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E91C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954B2208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497263;
	bh=WhEs5l16HJrcxCVT8+jiGeRbizmKVAf1pNc6obzvIWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2l6Ssq/foHI7yDwtyd+uWd/DgDp3soEWNEyd4uxVuvO436pkvJZ2PgAaDeb5Hi/6r
	 RGF/k0OALROxllsprLkYAVDLj/DjyTyZ5vWh+EPiRIIAFi/l9l3oJ2IDKmNlWq73eg
	 asiKJzZ0xJBMXv5baNgffPbv/vNyRRcm8MnXxITw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgIGQrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730563AbgIGQfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:35:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72CC621D90;
        Mon,  7 Sep 2020 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496518;
        bh=WhEs5l16HJrcxCVT8+jiGeRbizmKVAf1pNc6obzvIWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+86teF0Tq5yU5FVZzhHSWAM/PL2f7P/2ys/sHl+Dzpw2IMGTcA9B0eq5br2vI92L
         nUB54MEYlV00zRyIUwoyr5dhvPVT5es+7NbYpz+giZ72e1BTB7c/yuAVWQtywcz9Lh
         yJkgX+CTwNx0fCAEBwXQ/rfNSuKjifmWFEDscMXo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 13/17] ARC: [plat-hsdk]: Switch ethernet phy-mode to rgmii-id
Date:   Mon,  7 Sep 2020 12:34:56 -0400
Message-Id: <20200907163500.1281543-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163500.1281543-1-sashal@kernel.org>
References: <20200907163500.1281543-1-sashal@kernel.org>
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
index aeacea148793c..75aa3a8f9fdc9 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -163,7 +163,7 @@ ethernet@8000 {
 			reg = <0x8000 0x2000>;
 			interrupts = <10>;
 			interrupt-names = "macirq";
-			phy-mode = "rgmii";
+			phy-mode = "rgmii-id";
 			snps,pbl = <32>;
 			snps,multicast-filter-bins = <256>;
 			clocks = <&gmacclk>;
@@ -179,7 +179,7 @@ mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "snps,dwmac-mdio";
-				phy0: ethernet-phy@0 {
+				phy0: ethernet-phy@0 { /* Micrel KSZ9031 */
 					reg = <0>;
 					ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 					ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-- 
2.25.1

