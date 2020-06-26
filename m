Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39860C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC532082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158949;
	bh=Z7q74NuEg6nB5QogV/A6u8EleRsTeIsfiwDh1MnapBo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bVuVnwWywA6U8lMVLTkfAGmx7S/MeT3ILz017vodiVjUKYhqm9K6Eo2x0YplViHcd
	 y3rEMZWd4tWWzSD9qVASzEn9NJtZ/WWndc4fiKLQCg4pmN74EWTokpxx6GYWMDbqX8
	 bj8p/6epK1QNq6bBY+MtJViBmq+nEkvvfNgFCSoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgFZIJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgFZIFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:05:39 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822F82076E;
        Fri, 26 Jun 2020 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158738;
        bh=Z7q74NuEg6nB5QogV/A6u8EleRsTeIsfiwDh1MnapBo=;
        h=From:To:Cc:Subject:Date:From;
        b=Z7T8/W+7jmcl7OD7rBOY93skqQN2HWJoYlIbL9hHSMTStui+d0wxKqY7menS6jlD4
         62amiFzRxaxh5o7ag+IhUO5/xam1oCDUmvWIQqxU38/PFkhIrNZZPKm6ha+6sMtv+7
         mN2qqcav/YDBHhBSd+/JUfCXokahevctoKIAHiuk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: arm-realview: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:05:34 +0200
Message-Id: <20200626080534.3400-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache: $nodename:0: 'l2-cache' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi | 2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts | 2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 2 +-
 arch/arm/boot/dts/arm-realview-pbx-a9.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
index 29b636fce23f..26783d053ac7 100644
--- a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
@@ -59,7 +59,7 @@
 			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		L2: l2-cache {
+		L2: cache-controller {
 			compatible = "arm,l220-cache";
 			reg = <0x1f002000 0x1000>;
 			interrupt-parent = <&intc>;
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 2625ce66f8e7..f925782f8560 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -323,7 +323,7 @@
 			      <0x10120000 0x100>;
 		};
 
-		L2: l2-cache {
+		L2: cache-controller {
 			compatible = "arm,l220-cache";
 			reg = <0x10110000 0x1000>;
 			interrupt-parent = <&intc_dc1176>;
diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index c69cf7ddbe61..9748e0fe800f 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -92,7 +92,7 @@
 		      <0x1f000100 0x100>;
 	};
 
-	L2: l2-cache {
+	L2: cache-controller {
 		compatible = "arm,l220-cache";
 		reg = <0x1f002000 0x1000>;
 		interrupt-parent = <&intc_tc11mp>;
diff --git a/arch/arm/boot/dts/arm-realview-pbx-a9.dts b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
index 90d00b407f85..85d3968fbb91 100644
--- a/arch/arm/boot/dts/arm-realview-pbx-a9.dts
+++ b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
@@ -60,7 +60,7 @@
 		};
 	};
 
-	L2: l2-cache {
+	L2: cache-controller {
 		compatible = "arm,pl310-cache";
 		reg = <0x1f002000 0x1000>;
 		cache-unified;
-- 
2.17.1

