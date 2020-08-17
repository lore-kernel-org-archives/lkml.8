Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E83C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A372072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691469;
	bh=n5BejSjOLaNTzyZ8gbGcxvwo3oVY7+1z+ltbc4YdsIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VlpFfBunCNAsgV7IJTb+yZz59O/JVdMGQrT2yzutG/mikRbX5M4ufg46hRX0/NrF+
	 4jcXggAYaESsUXtVBIb5l9B4MSIJ21L6Z8Dj2ayfwEGFXFGATD159deA9OvPtYKg9k
	 OcaywicaopFVFwnSAwpRblxwClxl2RTbPtqozW5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbgHQTLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbgHQPl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:41:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0DD2075B;
        Mon, 17 Aug 2020 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678886;
        bh=n5BejSjOLaNTzyZ8gbGcxvwo3oVY7+1z+ltbc4YdsIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiiVKP0Kmat9+0w6eU9yIzk2gvCR/jPORO08SDjYuYnl+jmKNOuuqFZFDrKvOqelE
         BgdvtQBY0LfPmYLpaIzJ9FxNAcGLJHAo0tqmuKMO1hAw4+j/2AH+59nmMdWyxS56TX
         /hSqamxpZ7uPuni+K4Kgowb5r41BAxjuJt1DVNHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 005/393] ARM: dts: stm32: fix uart7_pins_a comments in stm32mp15-pinctrl
Date:   Mon, 17 Aug 2020 17:10:55 +0200
Message-Id: <20200817143819.852030792@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



