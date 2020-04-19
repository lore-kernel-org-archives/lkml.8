Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A14C5321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B869722240
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDSRMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:12:22 -0400
Received: from v6.sk ([167.172.42.174]:43908 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgDSRMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:12:19 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id B5ED4610B6;
        Sun, 19 Apr 2020 17:12:18 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 07/15] ARM: dts: pxa*: Fix up encoding of the /rtc interrupts property
Date:   Sun, 19 Apr 2020 19:11:49 +0200
Message-Id: <20200419171157.672999-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419171157.672999-1-lkundrak@v3.sk>
References: <20200419171157.672999-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way the device tree validator learns that each cell of the property
constitutes a separate item. Otherwise it gets unnecessairly upset:

  pxa168-aspenite.dt.yaml: rtc@d4010000: interrupts: [[5, 6]] is too short
  pxa910-dkb.dt.yaml: rtc@d4010000: interrupts: [[5, 6]] is too short

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/pxa168.dtsi | 2 +-
 arch/arm/boot/dts/pxa910.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index 550cd372d7c9f..4fe7735c7c588 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -143,7 +143,7 @@ twsi2: i2c@d4025000 {
 			rtc: rtc@d4010000 {
 				compatible = "mrvl,mmp-rtc";
 				reg = <0xd4010000 0x1000>;
-				interrupts = <5 6>;
+				interrupts = <5>, <6>;
 				interrupt-names = "rtc 1Hz", "rtc alarm";
 				clocks = <&soc_clocks PXA168_CLK_RTC>;
 				resets = <&soc_clocks PXA168_CLK_RTC>;
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index f59f593acff40..352a393578103 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -155,7 +155,7 @@ twsi2: i2c@d4037000 {
 			rtc: rtc@d4010000 {
 				compatible = "mrvl,mmp-rtc";
 				reg = <0xd4010000 0x1000>;
-				interrupts = <5 6>;
+				interrupts = <5>, <6>;
 				interrupt-names = "rtc 1Hz", "rtc alarm";
 				clocks = <&soc_clocks PXA910_CLK_RTC>;
 				resets = <&soc_clocks PXA910_CLK_RTC>;
-- 
2.26.0

