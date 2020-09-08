Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40F2C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B2F208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595965;
	bh=T8bAQkHiIv+es4Wmgoj2fBeh0pHTyLqga1QKjLojgXs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SSSQyJAuF8CbLRvCTeT2nELZ7ENP+wQmBMgp/fUJvsSOXOfOahmmwBEMmfkSiZVoc
	 7fJA+h9c3fpbMg7Dv5cHovWM9bkcwFPTC812UFrMZbHuedBnYXjJkwX4govMdfi6Gf
	 2HvG3YBwl2KuWT8Ep3eh73wF2N9yxolDK+HkLMUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIHUM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729781AbgIHPLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:11:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FFED229C5;
        Tue,  8 Sep 2020 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577147;
        bh=T8bAQkHiIv+es4Wmgoj2fBeh0pHTyLqga1QKjLojgXs=;
        h=From:To:Cc:Subject:Date:From;
        b=TYyUoFNJp3sdQ5gGtcONTKVHKVQlzI1beFyBdXyPqKw/BUC1hdiKG+9kMCSYrfkou
         zXilq2DNWZK80k5A1lbuzIweWnlEhFB2gHlE5Kn1l2iF5sjfLZH3fZv/dK1wdMZ89b
         yk5s7Cfmd9en79mT3fmflqvtDJ5OMxPX8GV01bc8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Date:   Tue,  8 Sep 2020 16:59:00 +0200
Message-Id: <20200908145900.4423-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted some
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/mfd/act8945a.txt          | 2 +-
 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml    | 3 ++-
 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/act8945a.txt b/Documentation/devicetree/bindings/mfd/act8945a.txt
index e6f168db6c72..5ca75d888b4a 100644
--- a/Documentation/devicetree/bindings/mfd/act8945a.txt
+++ b/Documentation/devicetree/bindings/mfd/act8945a.txt
@@ -71,7 +71,7 @@ Example:
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 			interrupt-parent = <&pioA>;
-			interrupts = <45 GPIO_ACTIVE_LOW>;
+			interrupts = <45 IRQ_TYPE_LEVEL_LOW>;
 
 			active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
 			active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
index 9b6eb50606e8..e541eb0d02ed 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -147,6 +147,7 @@ required:
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -155,7 +156,7 @@ examples:
             compatible = "gw,gsc";
             reg = <0x20>;
             interrupt-parent = <&gpio1>;
-            interrupts = <4 GPIO_ACTIVE_LOW>;
+            interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
             interrupt-controller;
             #interrupt-cells = <1>;
             #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
index c3c02ce73cde..386eec06cf08 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
@@ -39,7 +39,7 @@ pmic: pmic@4b {
 	compatible = "rohm,bd70528";
 	reg = <0x4b>;
 	interrupt-parent = <&gpio1>;
-	interrupts = <29 GPIO_ACTIVE_LOW>;
+	interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 	clocks = <&osc 0>;
 	#clock-cells = <0>;
 	clock-output-names = "bd70528-32k-out";
-- 
2.17.1

