Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45C02074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660999;
	bh=wbYwXQ9fZ1bUQK204E1Xiyk8j1I9U0O1glk0foaH9KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vr0CdjQG7EzUlcm8b/DmBnG9py11hg3tmYzxPJdU7ynk0syBdedDS/evAbSuztFzB
	 8u2x6xeJPAexTk6S6t4DaoSpLdyagTvj5YBuikZZNAHNbbfxmlZijLNmlWR6ZSIIH1
	 QyTNNZnaFY2Db3eyrBCnsnwrv9lhsU4ic7iA1xYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgFHXV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbgFHXR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:17:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9C8208A7;
        Mon,  8 Jun 2020 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658249;
        bh=wbYwXQ9fZ1bUQK204E1Xiyk8j1I9U0O1glk0foaH9KA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0SEASelfM+C4d7IkTd1PyTfI/m0wLDoT4NIA+2laqkibphSVPLEjms4TQyesUPhGG
         tk6J53OiVwijcsstg4GFAHwpAvQnlAXsKDi69BN+bJL8hKcKINyx9WKg9HhHtTkPBE
         RYNB36HLXSVLfTRfvlF2QSAS0HSwUwMBs3oJOLRc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 259/606] ARM: dts: omap4-droid4: Fix flakey wlan by disabling internal pull for gpio
Date:   Mon,  8 Jun 2020 19:06:24 -0400
Message-Id: <20200608231211.3363633-259-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 30fa60c678eaa27b8f2a531920d77f7184658f73 ]

The wlan on droid4 is flakey on some devices, and experiments have shown this
gets fixed if we disable the internal pull for wlan gpio interrupt line.

The symptoms are that the wlan connection is very slow and almost useless
with lots of wlcore firmware reboot warnings in the dmesg.

In addition to configuring the wlan gpio pulls, let's also configure the rest
of the wlan sd pins. We have not configured those eariler as we're booting
using kexec.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/motorola-mapphone-common.dtsi    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index 9067e0ef4240..01ea9a1e2c86 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -367,6 +367,8 @@ &mmc2 {
 };
 
 &mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&wl12xx_vmmc>;
 	/* uart2_tx.sdmmc3_dat1 pad as wakeirq */
 	interrupts-extended = <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
@@ -472,6 +474,37 @@ OMAP4_IOPAD(0x09e, PIN_INPUT | MUX_MODE0)
 		>;
 	};
 
+	/*
+	 * Android uses PIN_OFF_INPUT_PULLDOWN | PIN_INPUT_PULLUP | MUX_MODE3
+	 * for gpio_100, but the internal pull makes wlan flakey on some
+	 * devices. Off mode value should be tested if we have off mode working
+	 * later on.
+	 */
+	mmc3_pins: pinmux_mmc3_pins {
+		pinctrl-single,pins = <
+		/* 0x4a10008e gpmc_wait2.gpio_100 d23 */
+		OMAP4_IOPAD(0x08e, PIN_INPUT | MUX_MODE3)
+
+		/* 0x4a100102 abe_mcbsp1_dx.sdmmc3_dat2 ab25 */
+		OMAP4_IOPAD(0x102, PIN_INPUT_PULLUP | MUX_MODE1)
+
+		/* 0x4a100104 abe_mcbsp1_fsx.sdmmc3_dat3 ac27 */
+		OMAP4_IOPAD(0x104, PIN_INPUT_PULLUP | MUX_MODE1)
+
+		/* 0x4a100118 uart2_cts.sdmmc3_clk ab26 */
+		OMAP4_IOPAD(0x118, PIN_INPUT | MUX_MODE1)
+
+		/* 0x4a10011a uart2_rts.sdmmc3_cmd ab27 */
+		OMAP4_IOPAD(0x11a, PIN_INPUT_PULLUP | MUX_MODE1)
+
+		/* 0x4a10011c uart2_rx.sdmmc3_dat0 aa25 */
+		OMAP4_IOPAD(0x11c, PIN_INPUT_PULLUP | MUX_MODE1)
+
+		/* 0x4a10011e uart2_tx.sdmmc3_dat1 aa26 */
+		OMAP4_IOPAD(0x11e, PIN_INPUT_PULLUP | MUX_MODE1)
+		>;
+	};
+
 	/* gpmc_ncs0.gpio_50 */
 	poweroff_gpio: pinmux_poweroff_pins {
 		pinctrl-single,pins = <
-- 
2.25.1

