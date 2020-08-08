Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD1DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C29E207BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596929902;
	bh=r9cARwlmRmQB2cn/JMr7t+CaD0wcuI04mAkfiugb6E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oWiN2W7jBGYMchHXx7QCwDqCMB9mRCt0Or7cgKmDnAAbykM7Gw/YbTCGMzoSOdiAE
	 HC4urJpkqHF3Ioer3zoPB/IQ7sPCWWQ+nH545LLuJFeHdC/rEhitwQgKIOOvTzB02E
	 +NFlU/rv+2oISZj4D3NVCMWclJHYyi55NJQs9kl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgHHXiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgHHXiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:38:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E0C20825;
        Sat,  8 Aug 2020 23:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929896;
        bh=r9cARwlmRmQB2cn/JMr7t+CaD0wcuI04mAkfiugb6E4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ym3y3Fp/ibDwaN9PZkfamxMrSGDdLGikQG+FbuRKZ/Z7JhkJ+AqZgKxPJpko9dvkq
         bCcuVXv4saxigxzHwlEIjCKiRL+sKUJdM7cdc+BPzBjXAs3wenrd94b9tM5+QqZSIZ
         hrxbPeDCzozHuRozdiZymIFa4tXiURudsqPF3nDg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 36/58] ARM: dts: sunxi: bananapi-m2-plus-v1.2: Fix CPU supply voltages
Date:   Sat,  8 Aug 2020 19:37:02 -0400
Message-Id: <20200808233724.3618168-36-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233724.3618168-1-sashal@kernel.org>
References: <20200808233724.3618168-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit e4dae01bf08b754de79072441c357737220b873f ]

The Bananapi M2+ uses a GPIO line to change the effective resistance of
the CPU supply regulator's feedback resistor network. The voltages
described in the device tree were given directly by the vendor. This
turns out to be slightly off compared to the real values.

The updated voltages are based on calculations of the feedback resistor
network, and verified down to three decimal places with a multi-meter.

Fixes: 6eeb4180d4b9 ("ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20200717160053.31191-4-wens@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
index a628b5ee72b65..235994a4a2ebb 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
@@ -16,12 +16,12 @@ reg_vdd_cpux: vdd-cpux {
 		regulator-type = "voltage";
 		regulator-boot-on;
 		regulator-always-on;
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1108475>;
+		regulator-max-microvolt = <1308475>;
 		regulator-ramp-delay = <50>; /* 4ms */
 		gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
 		gpios-states = <0x1>;
-		states = <1100000 0>, <1300000 1>;
+		states = <1108475 0>, <1308475 1>;
 	};
 };
 
-- 
2.25.1

