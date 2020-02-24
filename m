Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7BBC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9782120658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WysXComR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YaYzNuQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgBXJLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:11:11 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:56207 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728382AbgBXJK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:58 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 9C404616;
        Mon, 24 Feb 2020 04:10:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Oud9k5YAKLNlL
        n76NcHUsNmMIyu3RhEvhCjZPCxILhQ=; b=WysXComRQOrkzVlOkF0bcvuvALVz0
        rQ6dt34fmbM75rf+U5ZUnyHQiQRJWlMVRppvsg2UKvIl4jliYb4FFNsl7/hL/6yl
        vE8Ujrrk+msBRhzEd84CUO83HJnS+YNITQMxTcCRjG+POhHHCggMhdJ8GzQswaOj
        HXwFeOVPhfkL6UNu4A0ipulQMsfMpf9gjCGZpOieU8W5zwwBMI8DLVu/0NPLTzwF
        j6i1x4pz/i83EoZ0Jov3q2osUgvFSh8JidQ0T+wxjl6cowGLX2Lz6OMzZ/S5kUlr
        in+ofHGt2gtHJmYMBSq06ylie536CXk5aqsglvf+yCnyfulyNrBfiugQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Oud9k5YAKLNlLn76NcHUsNmMIyu3RhEvhCjZPCxILhQ=; b=YaYzNuQK
        e2tA4DzVHpnZCSZ/pcCU+WKFrQCbAkUj7+RBEly3ZW4bsxpmp2gy6GCOnd4SSNbk
        DiMh1GCh/LXsEXnKS6ULsNH0imQIgzPi3WpNZ1UaZlKVdI/3gXL8br8Y7SONvPYY
        18SPhLedLxTpG2SR5FZOrrL+VnejS7zB50cDZ/HfVnvOURMEBARbdrvAv60wzlU8
        T/2zV0UjIeTwzsLpNrgxPbk3I4eVGfGxJCMLQnODxac/5mprfqQIe87GXqW5OXq9
        IQ6t2nOaSmzq+6MAaTuGtecdZxYCXQZ9aVIyDhVF/hfJ7V8G8kstQb7CGUdpLDXv
        hST4qG21pqODwg==
X-ME-Sender: <xms:IJNTXrmqQf_QmKhXHa6PLjCt_aWxZvKV-BlbJhq-yD_jEe0g-QCneA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepvdejnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:IJNTXnpW99XgU9_zmu5L0K7fm8deu1fwXREmL4BCu2FMCxXbZbg0sg>
    <xmx:IJNTXokoTthE2z8foRhGg-mPt2MqINc2aVoTZmgqPbdMqXaV6JYu6w>
    <xmx:IJNTXtKNcUjqF3p-1FtLBqwjwtxiHsroAciYrQvGEEkGvHV_WwQ1oQ>
    <xmx:IJNTXlovYgJyGoTx1wGLxT-WYZbyOT9NWY1e7qKKMp4gMjNBgdtk1pXgGa0>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DDF17328005A;
        Mon, 24 Feb 2020 04:10:55 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 88/89] dt-bindings: display: vc4: hdmi: Add BCM2711 HDMI controllers bindings
Date:   Mon, 24 Feb 2020 10:07:30 +0100
Message-Id: <4c21dda4f0b73977de1e54d408d7bf6bf3b6d238.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI controllers found in the BCM2711 SoC need some adjustments to the
bindings, especially since the registers have been shuffled around in more
register ranges.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 109 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
index 52b3cdac0bdf..a9d24e1cf684 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
@@ -11,24 +11,58 @@ maintainers:
 
 properties:
   compatible:
-    const: brcm,bcm2835-hdmi
+    enum:
+      - brcm,bcm2835-hdmi
+      - brcm,bcm2711-hdmi0
+      - brcm,bcm2711-hdmi1
 
   reg:
+    oneOf:
+      - items:
+        - description: HDMI register range
+        - description: HD register range
+
+      - items:
+        - description: HDMI controller register range
+        - description: DVP register range
+        - description: HDMI PHY register range
+        - description: Rate Manager register range
+        - description: Packet RAM register range
+        - description: Metadata RAM register range
+        - description: CSC register range
+        - description: CEC register range
+        - description: HD register range
+
+  reg-names:
     items:
-      - description: HDMI register range
-      - description: HD register range
+      - const: hdmi
+      - const: dvp
+      - const: phy
+      - const: rm
+      - const: packet
+      - const: metadata
+      - const: csc
+      - const: cec
+      - const: hd
 
   interrupts:
     minItems: 2
 
   clocks:
-    items:
-      - description: The pixel clock
-      - description: The HDMI state machine clock
+    oneOf:
+      - items:
+        - description: The pixel clock
+        - description: The HDMI state machine clock
+
+      - items:
+        - description: The HDMI state machine clock
 
   clock-names:
-    items:
-      - const: pixel
+    oneOf:
+      - items:
+        - const: pixel
+        - const: hdmi
+
       - const: hdmi
 
   ddc:
@@ -51,15 +85,54 @@ properties:
   dma-names:
     const: audio-rx
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
   - ddc
 
 additionalProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - brcm,bcm2711-hdmi0
+          - brcm,bcm2711-hdmi1
+
+then:
+  properties:
+    reg:
+      minItems: 9
+
+    clocks:
+      maxItems: 1
+
+    clock-names:
+      maxItems: 1
+
+  required:
+    - reg-names
+    - resets
+
+else:
+  properties:
+    reg:
+      maxItems: 2
+
+    clocks:
+      minItems: 2
+
+    clock-names:
+      minItems: 2
+
+  required:
+    - interrupts
+
 examples:
   - |
     #include <dt-bindings/clock/bcm2835.h>
@@ -77,4 +150,31 @@ examples:
         clock-names = "pixel", "hdmi";
     };
 
+  - |
+    hdmi0: hdmi@7ef00700 {
+        compatible = "brcm,bcm2711-hdmi0";
+        reg = <0x7ef00700 0x300>,
+              <0x7ef00300 0x200>,
+              <0x7ef00f00 0x80>,
+              <0x7ef00f80 0x80>,
+              <0x7ef01b00 0x200>,
+              <0x7ef01f00 0x400>,
+              <0x7ef00200 0x80>,
+              <0x7ef04300 0x100>,
+              <0x7ef20000 0x100>;
+        reg-names = "hdmi",
+                    "dvp",
+                    "phy",
+                    "rm",
+                    "packet",
+                    "metadata",
+                    "csc",
+                    "cec",
+                    "hd";
+        clocks = <&firmware_clocks 13>;
+        clock-names = "hdmi";
+        resets = <&dvp 0>;
+        ddc = <&ddc0>;
+    };
+
 ...
-- 
git-series 0.9.1
