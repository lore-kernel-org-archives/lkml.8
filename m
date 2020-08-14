Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB82C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E443206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHNKcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:32:03 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:46754 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgHNKcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:32:02 -0400
X-Greylist: delayed 1673 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Aug 2020 06:32:02 EDT
Received: from [188.210.212.0] (helo=localhost.localdomain)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1k6WZD-000572-AB; Fri, 14 Aug 2020 11:04:07 +0100
From:   Thomas Preston <thomas.preston@codethink.co.uk>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     thomas.preston@codethink.co.uk
Subject: [PATCH 3/3] devicetree: mcp23s08: Remove interrupt-controller
Date:   Fri, 14 Aug 2020 11:03:57 +0100
Message-Id: <20200814100357.209340-4-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814100357.209340-1-thomas.preston@codethink.co.uk>
References: <20200814100357.209340-1-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mcp23s08 device and friends are interrupt /client/ nodes, and should
not reference the interrupt controller device tree properties
"interrupt-controller" and "interrupt-cells" [0].

Remove the confusing "interrupt-controller" and "interrupt-cells"
properties from the pinctrl-mcp23s08 devicetree bindings documentation.

[0] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
---
 .../devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt      | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
index 8b94aa8f5971..bb1b53030552 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
@@ -43,10 +43,6 @@ Required device specific properties (only for SPI chips):
 - spi-max-frequency = The maximum frequency this chip is able to handle
 
 Optional properties:
-- #interrupt-cells : Should be two.
-  - first cell is the pin number
-  - second cell is used to specify flags.
-- interrupt-controller: Marks the device node as a interrupt controller.
 - drive-open-drain: Sets the ODR flag in the IOCON register. This configures
         the IRQ output as open drain active low.
 
@@ -72,8 +68,6 @@ gpiom1: gpio@20 {
 
         interrupt-parent = <&gpio1>;
         interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
-        interrupt-controller;
-        #interrupt-cells=<2>;
         microchip,irq-mirror;
 };
 
@@ -130,8 +124,6 @@ gpio21: gpio@21 {
 	interrupt-parent = <&socgpio>;
 	interrupts = <0x17 0x8>;
 	interrupt-names = "mcp23017@21 irq";
-	interrupt-controller;
-	#interrupt-cells = <0x2>;
 	microchip,irq-mirror;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2cgpio0irq &gpio21pullups>;
-- 
2.26.2

