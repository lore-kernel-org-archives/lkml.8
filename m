Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C811EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E58A20787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585278290;
	bh=V/fC1s0Q0SdYajkzSHAZo9jmk8ASCYhLB1BiZ+BO75U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OfB8kEsquO+LfpYhzfUkoR0kkF4hWk2SgodtmUPG0pBPM/uAxNzBALYTNtcP1A98q
	 kuLsctQjFMNpTnQWqUytDuRnpPwuIjK+wrBc5LtHBzv/XyoksLNAaJrEM3lrVfkdr1
	 EFtjUV9P9Jh1JTtX/xoKODwXn8FEGjKhkqr7e/uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgC0DEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgC0DEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:04:31 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7002082D;
        Fri, 27 Mar 2020 03:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585278271;
        bh=V/fC1s0Q0SdYajkzSHAZo9jmk8ASCYhLB1BiZ+BO75U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+SPVg5T+ck0Nktn8JpcqtzoI88jHl5Up/wFoIQ0EGU4ST0H1f4h6X4hoS27uzP1F
         z5iCMazRxImpPtRrTMmhw3Z9wgHjBvf6wmealZ+NZHsjLzRq0fYQQjZGjkeMbUL3h3
         dZ1B59HZv+jOBdysdDqIC01TnGR3I+iPEY3H4sr4=
Received: by wens.tw (Postfix, from userid 1000)
        id 461785FDC0; Fri, 27 Mar 2020 11:04:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: rockchip: rk3328: drop non-existent gmac2phy pinmux options
Date:   Fri, 27 Mar 2020 11:04:11 +0800
Message-Id: <20200327030414.5903-4-wens@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327030414.5903-1-wens@kernel.org>
References: <20200327030414.5903-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

When gmac2phy was added, a whole bunch of pinmux options were added.
Turns out some of these don't exist on the actual product, based on
the publicly available TRM.

Remove them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 7e88d88aab98..b861b4fd75e6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1794,10 +1794,6 @@ rmiim1_pins: rmiim1-pins {
 		};
 
 		gmac2phy {
-			fephyled_speed100: fephyled-speed100 {
-				rockchip,pins = <0 RK_PD7 1 &pcfg_pull_none>;
-			};
-
 			fephyled_speed10: fephyled-speed10 {
 				rockchip,pins = <0 RK_PD6 1 &pcfg_pull_none>;
 			};
@@ -1806,18 +1802,6 @@ fephyled_duplex: fephyled-duplex {
 				rockchip,pins = <0 RK_PD6 2 &pcfg_pull_none>;
 			};
 
-			fephyled_rxm0: fephyled-rxm0 {
-				rockchip,pins = <0 RK_PD5 1 &pcfg_pull_none>;
-			};
-
-			fephyled_txm0: fephyled-txm0 {
-				rockchip,pins = <0 RK_PD5 2 &pcfg_pull_none>;
-			};
-
-			fephyled_linkm0: fephyled-linkm0 {
-				rockchip,pins = <0 RK_PD4 1 &pcfg_pull_none>;
-			};
-
 			fephyled_rxm1: fephyled-rxm1 {
 				rockchip,pins = <2 RK_PD1 2 &pcfg_pull_none>;
 			};
-- 
2.25.1

