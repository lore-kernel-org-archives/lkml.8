Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9DFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3089A20791
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596929855;
	bh=n5BejSjOLaNTzyZ8gbGcxvwo3oVY7+1z+ltbc4YdsIE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xKF4TKVb50/NmSbHf0QTisSP0+R3e+yPh7nCSg10EBmDpiH4C88XhVeazL90xMsq6
	 jQW/VIa9UeqpTtHK/5p87+Yf96CEGjTb5z4ONel68oOlRP0D68+1cSJTJjz38BVqa4
	 Zm6d1uMc0a5/LuufNU0YRqwn12JiOAVYpgc4faEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHHXhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgHHXh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:37:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E49B2075D;
        Sat,  8 Aug 2020 23:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929846;
        bh=n5BejSjOLaNTzyZ8gbGcxvwo3oVY7+1z+ltbc4YdsIE=;
        h=From:To:Cc:Subject:Date:From;
        b=WotUL1i2ejVWD/YZk+P7yvZT/3r0jpOf0Cs3F3KYsgdSv6AnGc4b2DEYTg6ADSvXT
         geHelzUydwp3LvikxNFZv66q7akoZRNHD+IYTcA0eN5q8K8nIdZU1yK9j1yiJIvOU4
         ezZ3QzbDxcsJPDyEcqT8iOnL0GKZyKd8RIo5C7fU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Erwan Le Ray <erwan.leray@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 01/58] ARM: dts: stm32: fix uart7_pins_a comments in stm32mp15-pinctrl
Date:   Sat,  8 Aug 2020 19:36:27 -0400
Message-Id: <20200808233724.3618168-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erwan Le Ray <erwan.leray@st.com>

[ Upstream commit 391e437eedc0dab0a9f2c26997e68e040ae04ea3 ]

Fix uart7_pins_a comments to indicate UART7 pins instead of UART4 pins.

Fixes: bf4b5f379fed ("ARM: dts: stm32: Add missing pinctrl definitions for STM32MP157")

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 73c07f0dfad27..4b67b682dd53f 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1095,15 +1095,15 @@ pins2 {
 
 	uart7_pins_a: uart7-0 {
 		pins1 {
-			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART4_TX */
+			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART7_TX */
 			bias-disable;
 			drive-push-pull;
 			slew-rate = <0>;
 		};
 		pins2 {
-			pinmux = <STM32_PINMUX('E', 7, AF7)>, /* UART4_RX */
-				 <STM32_PINMUX('E', 10, AF7)>, /* UART4_CTS */
-				 <STM32_PINMUX('E', 9, AF7)>; /* UART4_RTS */
+			pinmux = <STM32_PINMUX('E', 7, AF7)>, /* UART7_RX */
+				 <STM32_PINMUX('E', 10, AF7)>, /* UART7_CTS */
+				 <STM32_PINMUX('E', 9, AF7)>; /* UART7_RTS */
 			bias-disable;
 		};
 	};
-- 
2.25.1

