Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3413CC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E7D2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="QkPepq9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD3L5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:57:50 -0400
Received: from plaes.org ([188.166.43.21]:37082 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgD3L5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:57:46 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:d397:940e:6b9e:3deb:3])
        by plaes.org (Postfix) with ESMTPSA id D017B4092D;
        Thu, 30 Apr 2020 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588247834; bh=vMo2TanI9GatNd59nOo9RI6zU3bToC+1dQv+F9Smax0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkPepq9jRIHzXYSDHzmANJ+RqWrN2Do7/VE3yhAEqeTTI/ddCGQF3C5E55wE/Wpk6
         ETVZ7nf+ZlG6jVnqeNNpbWJwCHZpcjzVkNXa9YEK6Aeirv272bl10ne4TgEan1X9tU
         6UZnTnma0bOmJP7Ls8Vb3PcNVMfP1uoPkHI9GROJnbK7St8rcR+sqPwSUShjQTxLeC
         eFpwtNQGmlpsoQtfbI+6x9rhEZ1k3+24xq9FxVr0rU18bdHgSlYQ32YaS13OhL1qmx
         5e8Zuz6RWT9bMmIPwXynHtWIu4Ip167IeoVqKE2Dy34d4Ff+Gjv+pK5IupeH0i5raY
         XSkvGP8QXQ4jw==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v3 4/6] dt-bindings: net: sun7i-gmac: Add syscon support
Date:   Thu, 30 Apr 2020 14:57:00 +0300
Message-Id: <20200430115702.5768-5-plaes@plaes.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430115702.5768-1-plaes@plaes.org>
References: <20200430115702.5768-1-plaes@plaes.org>
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

