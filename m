Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCCAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AD62074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFCUDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:03:52 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:45917 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgFCUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:03:51 -0400
Received: from [78.134.115.170] (port=37458 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jgZc3-005dPA-Q3; Wed, 03 Jun 2020 22:03:47 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [RFC 2/4] regulator: lp87565: dt: remove duplicated section
Date:   Wed,  3 Jun 2020 22:03:17 +0200
Message-Id: <20200603200319.16184-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200603200319.16184-1-luca@lucaceresoli.net>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Required properties:" section is copied verbatim for each of the two
supported chips. In preparation to add a new chip variant make it a common
section and keep the two examples to differentiate between the two chips.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 .../devicetree/bindings/mfd/lp87565.txt       | 21 ++++---------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
index 41671e0dc26b..b75ae23a1ef3 100644
--- a/Documentation/devicetree/bindings/mfd/lp87565.txt
+++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
@@ -1,7 +1,7 @@
 TI LP87565 PMIC MFD driver
 
 Required properties:
-  - compatible:	"ti,lp87565", "ti,lp87565-q1"
+  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1"
   - reg:		I2C slave address.
   - gpio-controller:	Marks the device node as a GPIO Controller.
   - #gpio-cells:	Should be two.  The first cell is the pin number and
@@ -10,7 +10,8 @@ Required properties:
   - xxx-in-supply:	Phandle to parent supply node of each regulator
 			populated under regulators node. xxx should match
 			the supply_name populated in driver.
-Example:
+
+Example for the TI LP87565-Q1 PMIC (dual 2-phase output configuration):
 
 lp87565_pmic: pmic@60 {
 	compatible = "ti,lp87565-q1";
@@ -42,21 +43,7 @@ lp87565_pmic: pmic@60 {
 	};
 };
 
-TI LP87561 PMIC:
-
-This is a single output 4-phase regulator configuration
-
-Required properties:
-  - compatible:	"ti,lp87561-q1"
-  - reg:		I2C slave address.
-  - gpio-controller:	Marks the device node as a GPIO Controller.
-  - #gpio-cells:	Should be two.  The first cell is the pin number and
-			the second cell is used to specify flags.
-			See ../gpio/gpio.txt for more information.
-  - xxx-in-supply:	Phandle to parent supply node of each regulator
-			populated under regulators node. xxx should match
-			the supply_name populated in driver.
-Example:
+Example for the TI LP87561 PMIC (single 4-phase output configuration):
 
 lp87561_pmic: pmic@62 {
 	compatible = "ti,lp87561-q1";
-- 
2.27.0

