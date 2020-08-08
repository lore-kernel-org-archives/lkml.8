Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50331C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFE320791
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930031;
	bh=b3ProMthpXoH87cVRKNxK4C2HYtOQ0Qt//W7bkqCIWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mfdRvOzGNKiUMyJmk9fU4SPGxOGguetmLLWncgEUhhadEyX7n/MgghALJm4/f3nCO
	 v+kC2I548fo8DVCf+DAwNmCcZeMoOqA/2auzSfk5nfor5ohdSFijVgKQtkTWIJK2LK
	 L1Z5PDcbD9CoVFF/rlkmvE4JM7RrEFsp2XbnTL2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgHHXk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728787AbgHHXkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:40:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD2D420716;
        Sat,  8 Aug 2020 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596930017;
        bh=b3ProMthpXoH87cVRKNxK4C2HYtOQ0Qt//W7bkqCIWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uig5cEoPwZmScsjEYQ1KlWW1Uil+u+j1RueOwgHXqR8SzjQk8iUKlwURrOPKAECvE
         RvGCmIlgKNntI2vXQfkJ9BWajyh+vkdbOLvZWff0YfbPhU51kHDSV/muKIUD4D6UGg
         Ts396mgNSrV4YU/fO31rCn/7KBfQR4XoIlj5fB40=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 03/14] arm64: dts: rockchip: fix rk3399-puma vcc5v0-host gpio
Date:   Sat,  8 Aug 2020 19:40:02 -0400
Message-Id: <20200808234013.3619541-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808234013.3619541-1-sashal@kernel.org>
References: <20200808234013.3619541-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

[ Upstream commit 7a7184f6cfa9279f1a1c10a1845d247d7fad54ff ]

The puma vcc5v0_host regulator node currently uses opposite active-values
for the enable pin. The gpio-declaration uses active-high while the
separate enable-active-low property marks the pin as active low.

While on the kernel side this works ok, other DT users may get
confused - as seen with uboot right now.

So bring this in line and make both properties match, similar to the
gmac fix.

Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Link: https://lore.kernel.org/r/20200604091239.424318-1-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 1fc5060d7027e..b08a998ca1024 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -138,7 +138,7 @@ vcc3v3_sys: vcc3v3-sys {
 
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_LOW>;
 		enable-active-low;
 		pinctrl-names = "default";
 		pinctrl-0 = <&vcc5v0_host_en>;
-- 
2.25.1

