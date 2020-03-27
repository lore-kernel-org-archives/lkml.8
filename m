Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7192FC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C42720848
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585278273;
	bh=WXqxkgQ1ud/hiEzSNH14Fo3ArHlfptlNHM75xEEiT1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=abHGbtTFOftbNp3k50zLkXyzOK1D0mzSB+7FmT9qzjkb4RFr1KXU0MuXm0J8+5UNN
	 atbfjug69oHqdvZkIShjVPMQ3F+lPQO1VX/6nujJwY542najGfmZHO/0EC3mVeIYSx
	 60kfFUTvTVQ7g/EP01dhmbC64QYv33Lu295Qn0BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgC0DEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgC0DEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:04:31 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA86208E4;
        Fri, 27 Mar 2020 03:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585278271;
        bh=WXqxkgQ1ud/hiEzSNH14Fo3ArHlfptlNHM75xEEiT1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVCsOvyapeqvkz2F2L7G6l7j024IAawq2lRTvlyHOyFOzqq/s9SzOsin71Oq4pCDy
         8ADjdoyaRtv+OBPEvLLsG0nIwgZUzVC/gkcksm12eFG1EpC0tdi2o9xxbkoYc3x6VK
         4bNYSxbnvZq/Ee797B0wJzOFUTBrU+7TGYaO0Xlo=
Received: by wens.tw (Postfix, from userid 1000)
        id 3B3905FBBF; Fri, 27 Mar 2020 11:04:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] arm64: dts: rockchip: rk3399-roc-pc: Fix MMC numbering for LED triggers
Date:   Fri, 27 Mar 2020 11:04:09 +0800
Message-Id: <20200327030414.5903-2-wens@kernel.org>
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

With SDIO now enabled, the numbering of the existing MMC host controllers
gets incremented by 1, as the SDIO host is the first one.

Increment the numbering of the MMC LED triggers to match.

Fixes: cf3c5397835f ("arm64: dts: rockchip: Enable sdio0 and uart0 on rk3399-roc-pc-mezzanine")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts | 8 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi          | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
index 2acb3d500fb9..f0686fc276be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
@@ -38,6 +38,10 @@ vcc3v3_pcie: vcc3v3-pcie {
 	};
 };
 
+&diy_led {
+	linux,default-trigger = "mmc2";
+};
+
 &pcie_phy {
 	status = "okay";
 };
@@ -91,3 +95,7 @@ &uart0 {
 	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
 	status = "okay";
 };
+
+&yellow_led {
+	linux,default-trigger = "mmc1";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 9f225e9c3d54..bc060ac7972d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -70,14 +70,14 @@ work-led {
 			linux,default-trigger = "heartbeat";
 		};
 
-		diy-led {
+		diy_led: diy-led {
 			label = "red:diy";
 			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 			linux,default-trigger = "mmc1";
 		};
 
-		yellow-led {
+		yellow_led: yellow-led {
 			label = "yellow:yellow-led";
 			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
-- 
2.25.1

