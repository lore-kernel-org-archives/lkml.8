Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FDCC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC4F2053B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930199;
	bh=QuTGwHFG4PfND3wv40WtsKr+cg9CyiMKlrNdZx2m/kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mPRlHMqg7w7MobQOr/SpufbgNlnf755tRUKPEDveoV1Gwosx0YuAXtUZ0u7aI+W2u
	 21CWwAN08G8gHSGvwaqrjr3DYEs7FmYe20OKK207iwHkDI8Apw6D/aI5skjv2bc/Tj
	 kqonpAPpCQmWSYJ83+2DhHtweZ8ev92P1D46ek7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgHHXnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbgHHXju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:39:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC022087C;
        Sat,  8 Aug 2020 23:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929989;
        bh=QuTGwHFG4PfND3wv40WtsKr+cg9CyiMKlrNdZx2m/kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpkzfhOHxxprJxSa/LCdP6Qr+W+5OOTcuaZzsfOd9dZddKfMFHKJJKMRCNXKIKFxq
         u/Fk+TCjGX+2FIYD5PymgyTb1Bel0dkfBGB6WvJXpUVDbX2w40cp5UZJEBvSZM13zd
         y/nJwgfcqrtQea6/fa5umjbyLHsT0uyjUOQoKsdY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 06/21] arm64: dts: rockchip: fix rk3399-puma gmac reset gpio
Date:   Sat,  8 Aug 2020 19:39:26 -0400
Message-Id: <20200808233941.3619277-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233941.3619277-1-sashal@kernel.org>
References: <20200808233941.3619277-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

[ Upstream commit 8a445086f8af0b7b9bd8d1901d6f306bb154f70d ]

The puma gmac node currently uses opposite active-values for the
gmac phy reset pin. The gpio-declaration uses active-high while the
separate snps,reset-active-low property marks the pin as active low.

While on the kernel side this works ok, other DT users may get
confused - as seen with uboot right now.

So bring this in line and make both properties match, similar to the
other Rockchip board.

Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Link: https://lore.kernel.org/r/20200603132836.362519-1-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index baacb6e227b95..b155f657292bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -156,7 +156,7 @@ &gmac {
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
-	snps,reset-gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
+	snps,reset-gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
-- 
2.25.1

