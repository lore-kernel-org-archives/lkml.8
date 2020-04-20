Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25FAC38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA1620CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587403914;
	bh=cT0OetYZ/YUt8aV+lPE7R4oJyBHx66QFKj3UJB9PhuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kR3W2+ZwslousVDqnHcwKpuhMio61p2hqw5pcSZ55koAfvRPeSseUl1+DScpHpEqJ
	 R0hePvrh2xHR522DIgedqorHCzhEP0CfDH/EkxaLhRhN1jgdIBSkFQ7SARv32wvcf6
	 oXaBvm+P246kNdLDrLGEP3k3+w4ZzyX9aBHPlVME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgDTRby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgDTRbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:31:53 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A37320782;
        Mon, 20 Apr 2020 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403912;
        bh=cT0OetYZ/YUt8aV+lPE7R4oJyBHx66QFKj3UJB9PhuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glAPmqV6jUTuEUBYfT5dT0mSTxIIx5QSGT6l2LTqTKhNfh/wgnGDhkudKEHMChS78
         27u7tV5HZjV/YhNtCRy/M2Rwoqv3nlFMdSRJTIo2Gxi09Gt9nbUbopfuKcxNa3v4A6
         x1J6wY0yb3fjCAryM9c6B/uP70wYV7Y9hbuUINic=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 2/6] ARM: dts: Add missing pinctrl entries for STM32MP15
Date:   Mon, 20 Apr 2020 23:01:20 +0530
Message-Id: <20200420173124.27416-3-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420173124.27416-1-mani@kernel.org>
References: <20200420173124.27416-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

These pinctrl definitions will be used by Stinger96/IoTBox boards
from Shiratech.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index aeddcaadb829..858c83038e5a 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1519,6 +1519,30 @@
 		};
 	};
 
+	usart2_pins_b: usart2-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
+				 <STM32_PINMUX('A', 1, AF7)>; /* USART2_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 4, AF7)>, /* USART2_RX */
+				 <STM32_PINMUX('E', 15, AF7)>; /* USART2_CTS_NSS */
+			bias-disable;
+		};
+	};
+
+	usart2_sleep_pins_b: usart2-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 5, ANALOG)>, /* USART2_TX */
+				 <STM32_PINMUX('A', 1, ANALOG)>, /* USART2_RTS */
+				 <STM32_PINMUX('F', 4, ANALOG)>, /* USART2_RX */
+				 <STM32_PINMUX('E', 15, ANALOG)>; /* USART2_CTS_NSS */
+		};
+	};
+
 	usart3_pins_a: usart3-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
@@ -1558,6 +1582,19 @@
 		};
 	};
 
+	uart4_pins_c: uart4-2 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+			bias-disable;
+		};
+	};
+
 	uart7_pins_a: uart7-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART4_TX */
@@ -1573,6 +1610,19 @@
 		};
 	};
 
+	uart7_pins_b: uart7-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 7, AF7)>; /* UART7_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 6, AF7)>; /* UART7_RX */
+			bias-disable;
+		};
+	};
+
 	uart8_pins_a: uart8-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('E', 1, AF8)>; /* UART8_TX */
@@ -1647,4 +1697,18 @@
 			bias-disable;
 		};
 	};
+
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
 };
-- 
2.17.1

