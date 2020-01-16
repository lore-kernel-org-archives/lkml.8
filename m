Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39573C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172CD2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198986;
	bh=E6QfXuqdB2fniCwvMGrbCsdwpbrf1m2W5G3PDH8jzcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WxFuSPqDz9epu/5zjNWNT2b5WybT5csE4EJewzY0hfhTFe7aK41mERwexTpnwQGuQ
	 b1Mqf9Ksjo/JnpVR1mm4sZ/aRTuTgSU4gU0s2iqDMCWh6EgztdOsec0A525cq8+9jR
	 pRhu5k5eASoNhixNr2m+mlT1o5n2uQ7LjBLiUYCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395541AbgAPSXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:23:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392178AbgAPR1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:27:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7262C246D0;
        Thu, 16 Jan 2020 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195640;
        bh=E6QfXuqdB2fniCwvMGrbCsdwpbrf1m2W5G3PDH8jzcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuf7NisuGM8wSNO5UfPj/3vHj1zwrA3j2LsR95DYn4Yo29SWPDiuwdf5FPu3VRasq
         HMk7Nkfbuys9m+GHw80jnYWiRUJGmGbNQXq7UEq9ASzCDM4MVG82AfifzrVabx7IV0
         ejutiJfY/tjKHh/YgUWW0pZmgeQtLU3cXLjWugfA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 205/371] ARM: dts: sun8i-h3: Fix wifi in Beelink X2 DT
Date:   Thu, 16 Jan 2020 12:21:17 -0500
Message-Id: <20200116172403.18149-148-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit ca0961011db57e39880df0b5708df8aa3339dc6f ]

mmc1 node where wifi module is connected doesn't have properly defined
power supplies so wifi module is never powered up. Fix that by
specifying additional power supplies.

Additionally, this STB may have either Realtek or Broadcom based wifi
module. One based on Broadcom module also needs external clock to work
properly. Fix that by adding clock property to wifi_pwrseq node.

Fixes: e582b47a9252 ("ARM: dts: sun8i-h3: Add dts for the Beelink X2 STB")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 10da56e86ab8..21b38c386f1b 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -79,6 +79,8 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
 	};
 
 	sound_spdif {
@@ -128,6 +130,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
-- 
2.20.1

