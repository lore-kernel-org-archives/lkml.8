Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78515C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57942205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159533;
	bh=BYyPzYkx4ERUweSk9BWxGWyjc7yozBVun6QzBUsgIKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wLt/RmprRVA0bgoCgHcJ0WNU3L7DPTqIqUSpYmxqIL6OlXFXGa1vLApWpAHwwUr6V
	 bEDHnOrtlgAVIMlSnT3Tosor5CCHPHQ+SOLI5E9scWETGhBK+hERZPLcPk6o+Kods8
	 +3wEHaiPCFTymHoCGtzIEouDB3vzcEKxVbqa1DkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgEVOuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbgEVOuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4B92245D;
        Fri, 22 May 2020 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159012;
        bh=BYyPzYkx4ERUweSk9BWxGWyjc7yozBVun6QzBUsgIKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBAoQ5ccC+pfpDBZhy71LJSQBFNfUlwi1/tQ1973v5AITP7blSjw3z7w7hQEsKXbH
         9AlRGvMVoXP9Jo2WLtCvy1HTE5rDloQaKlpQCsYPNw9AMaOyZ9CsKKN3LzzYzrsPVe
         pPu5kHG1PAUb6/y9cq2bKTNWIqVfDEAijh8IDG4g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, maemo-leste@lists.dyne.org,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 11/41] ARM: dts: omap4-droid4: Fix occasional lost wakeirq for uart1
Date:   Fri, 22 May 2020 10:49:28 -0400
Message-Id: <20200522144959.434379-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522144959.434379-1-sashal@kernel.org>
References: <20200522144959.434379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 738b150ecefbffb6e55cfa8a3b66a844f777d8fb ]

Looks like using the UART CTS pin does not always trigger for a wake-up
when the SoC is idle.

This is probably because the modem first uses gpio_149 to signal the SoC
that data will be sent, and the CTS will only get used later when the
data transfer is starting.

Let's fix the issue by configuring the gpio_149 pad as the wakeirq for
UART. We have gpio_149 managed by the USB PHY for powering up the right
USB mode, and after that, the gpio gets recycled as the modem wake-up
pin. If needeed, the USB PHY can also later on be configured to use
gpio_149 pad as the wakeirq as a shared irq.

Let's also configure the missing properties for uart-has-rtscts and
current-speed for the modem port while at it. We already configure the
hardware flow control pins with uart1_pins pinctrl setting.

Cc: maemo-leste@lists.dyne.org
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index 01ea9a1e2c86..06fbffa81636 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -723,14 +723,18 @@
 };
 
 /*
- * As uart1 is wired to mdm6600 with rts and cts, we can use the cts pin for
- * uart1 wakeirq.
+ * The uart1 port is wired to mdm6600 with rts and cts. The modem uses gpio_149
+ * for wake-up events for both the USB PHY and the UART. We can use gpio_149
+ * pad as the shared wakeirq for the UART rather than the RX or CTS pad as we
+ * have gpio_149 trigger before the UART transfer starts.
  */
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
 	interrupts-extended = <&wakeupgen GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH
-			       &omap4_pmx_core 0xfc>;
+			       &omap4_pmx_core 0x110>;
+	uart-has-rtscts;
+	current-speed = <115200>;
 };
 
 &uart3 {
-- 
2.25.1

