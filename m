Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E126AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF44F2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFPVzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:55:12 -0400
Received: from v6.sk ([167.172.42.174]:48428 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgFPVzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:55:12 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D0CD661635;
        Tue, 16 Jun 2020 21:54:40 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: phy: Drop reset-gpios from marvell,mmp3-hsic-phy
Date:   Tue, 16 Jun 2020 23:54:33 +0200
Message-Id: <20200616215435.987899-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616215435.987899-1-lkundrak@v3.sk>
References: <20200616215435.987899-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been added in error -- the PHY block doesn't have a reset pin.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v2:
- Add Rob's Reviewed-by tag

 .../devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml     | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
index 00609ace677c9..30e290c579308 100644
--- a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
@@ -18,27 +18,20 @@ properties:
     maxItems: 1
     description: base address of the device
 
-  reset-gpios:
-    maxItems: 1
-    description: GPIO connected to reset
-
   "#phy-cells":
     const: 0
 
 required:
   - compatible
   - reg
-  - reset-gpios
   - "#phy-cells"
 
 additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     hsic-phy@f0001800 {
             compatible = "marvell,mmp3-hsic-phy";
             reg = <0xf0001800 0x40>;
-            reset-gpios = <&gpio 63 GPIO_ACTIVE_HIGH>;
             #phy-cells = <0>;
     };
-- 
2.26.2

