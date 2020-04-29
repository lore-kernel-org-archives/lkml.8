Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CABC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4609D20BED
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="ffDlUeuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgD2UrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:47:10 -0400
Received: from plaes.org ([188.166.43.21]:35024 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgD2Uq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:46:59 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:d397:940e:6b9e:3deb:3])
        by plaes.org (Postfix) with ESMTPSA id D789440AF0;
        Wed, 29 Apr 2020 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588193186; bh=vMo2TanI9GatNd59nOo9RI6zU3bToC+1dQv+F9Smax0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffDlUeufauuoxFHGEN5d8Qaun4h95SBfuOJN8ElGVTF3o8YKdyywlB63loQJbtjHN
         IFd7iDKB+op4gl/yfMubDxwnqxvKrtEdIpHlZguhjF49a3XB1n856GBtHPauRBl/ak
         w2n82M9FQK8yLCDrZfAGmjDCNy7FNNVRfIJNIY/pSQsjAmddr59JVCEET6i60zIQq5
         G0OaxCQuUVr0R4wbntqTRYjjLdML7HoTL2hKQANOI298gERNIfbIXmOTEKvgCXm/h0
         MRqyKswe28vDe2dGM1vJ3327ixfrD0CW8rmpcV9vKtjQmj1eQog5J8PL0llRtXHIJx
         GLKsU+M1cGKwQ==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v2 4/6] dt-bindings: net: sun7i-gmac: Add syscon support
Date:   Wed, 29 Apr 2020 23:46:10 +0300
Message-Id: <20200429204612.31883-5-plaes@plaes.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429204612.31883-1-plaes@plaes.org>
References: <20200429204612.31883-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that driver supports syscon-based regmap access, document also the
devicetree binding.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 .../bindings/net/allwinner,sun7i-a20-gmac.yaml    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
index 703d0d886884..c41d7c598c19 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
@@ -29,17 +29,26 @@ properties:
   clocks:
     items:
       - description: GMAC main clock
+
+      # Deprecated
       - description: TX clock
 
   clock-names:
     items:
       - const: stmmaceth
+
+      # Deprecated
       - const: allwinner_gmac_tx
 
   phy-supply:
     description:
       PHY regulator
 
+  syscon:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description:
+      Phandle to the device containing the GMAC clock register
+
 required:
   - compatible
   - reg
@@ -48,6 +57,7 @@ required:
   - clocks
   - clock-names
   - phy-mode
+  - syscon
 
 unevaluatedProperties: false
 
@@ -55,11 +65,12 @@ examples:
   - |
     gmac: ethernet@1c50000 {
         compatible = "allwinner,sun7i-a20-gmac";
+        syscon = <&syscon>;
         reg = <0x01c50000 0x10000>;
         interrupts = <0 85 1>;
         interrupt-names = "macirq";
-        clocks = <&ahb_gates 49>, <&gmac_tx>;
-        clock-names = "stmmaceth", "allwinner_gmac_tx";
+        clocks = <&ahb_gates 49>;
+        clock-names = "stmmaceth";
         phy-mode = "mii";
     };
 
-- 
2.26.2

