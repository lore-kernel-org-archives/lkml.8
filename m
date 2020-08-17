Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA9BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C161120658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693865;
	bh=OSBbNWTMY2Y785oTTliEJuQjhRr8+lsvQKyr6/Eo6lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dyZa2HpqY5xcNDjZCfCc4tvXjO8dlZFwU0tj8Sg0EhPuYB4NtCW74wz3UnS9QPrQY
	 7efStHij4lAr7pzsDw3fPE+dJwUUAbR1e88bPpcy/0z9B2c9at4WomXoNQpVoNrNh2
	 8hrOfNaAo73JmYnkHFUddKCZLUy8tKXJdJufpW8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgHQTvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbgHQPTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:19:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3591720709;
        Mon, 17 Aug 2020 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677546;
        bh=OSBbNWTMY2Y785oTTliEJuQjhRr8+lsvQKyr6/Eo6lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0zCfQFfd98fl+jbAr992NJDVypp3ZMxh8vrc8rN3l6IIjoAdBWOBblt8LO61kmFK
         n2pEcy4YFVKdhZhDbL47F5cjCV7I9BZaaumnzPOYCJjhf7PbfV6jWbomDlqo/UsUMd
         UXK1UM0BzgZgU5g5P5Bi7L99xluq9FFKfYshq5OY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 006/464] ARM: dts: stm32: fix uart7_pins_a comments in stm32mp15-pinctrl
Date:   Mon, 17 Aug 2020 17:09:19 +0200
Message-Id: <20200817143834.050687684@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
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
index b31923a9498b5..49132921feeb9 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1615,15 +1615,15 @@ pins2 {
 
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



