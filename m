Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85739C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5381B20672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930614;
	bh=iMAbjkb444Fs60V9JgSpamSFR5MPp1FyaSoD1MkeyFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vqXe9B7j1kW390DRGMXZeT4rFDgb8Fd34/Gzk17YPHIAdxlZpAjnamoGvYw/A/bpR
	 a/0jagJt5VK7F/VjWxoWvHW4wXO+70rF+hvIaqRQyihL8R0p7Qo4OBOc6yAb2SoH3r
	 2vKvLTTI0CiJD+NEHdVBLjcONtb2+QqfkZBHDCyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgHHXuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgHHXgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:36:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1995206C3;
        Sat,  8 Aug 2020 23:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929803;
        bh=iMAbjkb444Fs60V9JgSpamSFR5MPp1FyaSoD1MkeyFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbIoF6IoJOKUTaN8bV9Ycp/tofdKTp5Xz835SavrA6RjphauJYmG4TbkzFAMuHTCd
         bExa5wDItpzeOu4kzp7U8HMpuK8pi9IR6fndy4VpAM2JEOK2/4CzdAJBxO37bfP4XQ
         CiZoTrK4AayOCtzwrdD9yxgMwsSVC9mgHmYPgbRU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Patrick Delaunay <patrick.delaunay@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 41/72] ARM: dts: stm32: Fix spi4 pins in stm32mp15-pinctrl
Date:   Sat,  8 Aug 2020 19:35:10 -0400
Message-Id: <20200808233542.3617339-41-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Delaunay <patrick.delaunay@st.com>

[ Upstream commit 4fe663890ac5b3b099f458b20cce13fe8efec12b ]

Move spi4_pins_a nodes from pinctrl_z to pinctrl as the associated pins
are not in BANK Z.

Fixes: 498a7014989d ("ARM: dts: stm32: Add missing pinctrl entries for STM32MP15")

Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 49132921feeb9..cc505458da2fd 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1654,6 +1654,20 @@ pins2 {
 		};
 	};
 
+	spi4_pins_a: spi4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
+				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
+			bias-disable;
+		};
+	};
+
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
@@ -1776,18 +1790,4 @@ pins2 {
 			bias-disable;
 		};
 	};
-
-	spi4_pins_a: spi4-0 {
-		pins {
-			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
-				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
-			bias-disable;
-			drive-push-pull;
-			slew-rate = <1>;
-		};
-		pins2 {
-			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
-			bias-disable;
-		};
-	};
 };
-- 
2.25.1

