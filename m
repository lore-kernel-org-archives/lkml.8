Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC42C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96EE20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="tMn5/e2A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeBuWruY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgDXPhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:37:39 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:44281 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728119AbgDXPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:37:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 865171455;
        Fri, 24 Apr 2020 11:37:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FzciRgntrUVjR
        Spnb+QBb61aDq9QNcaXOAvosXqRwQ4=; b=tMn5/e2AbkJ6Bb5qdDKg4MieCXMFO
        lfdC7gflTgzHbmol55bMIqkfSpxcwH+k/dkDafHxo7otMKs/m7bO6LU9cYiqpNtE
        UX2A/m0lRe363maqxwCaBQs3MeE0RLDTlgBfu6ep4DJgCJ/EvZt4UO9NP6UgkwAi
        rhJXagWyGlV6d6HmfnppNOn4TGo5iiDBaWDwPli75H4BmuTZ9R/MOrGIWr4vh15J
        aUmuVRM/20XC5n8VLH1eF3ccV8qY37u2VA5ojuxp0nF0nJC3yGYe1xfNbkCLlvjb
        OENaC0ZdkwVMG8cFmsar3IoQSabr1emYFFkWBZ+PvfzFIHAsqGdepOTGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FzciRgntrUVjRSpnb+QBb61aDq9QNcaXOAvosXqRwQ4=; b=PeBuWruY
        GWa+BZy+5wtBqhfWMDD5PObCbstHMQRwKb2dnTHLGPyaICg8w1L+v5rigOHfKWTy
        FHRLkdToLbdokqhSTA9OnWJltIMvffbRtHoVpyCktRrxKRCCrEkDtupVKQ7dtWqh
        osXwvz3o75dXA/AZPgn/Y8VJgAXwTY6zsYxjuJISwQKsZufb5pmRgrl/0ZXcjKVn
        n6vwLy6O4Ypag0FnHqaiOaUwS4PC4wKa7gyr6BQxXV19gKATO4/YmzqQsRj5D87D
        w5hisOlHyqNIT710jnU6NsCp14GGfDW1p+pHkYZYa1DQwaP7bY1WYh0JfGf7I9RG
        Y3d+xGTW+UR1pA==
X-ME-Sender: <xms:twejXlpcHRijjQR8D9MlPfFte0qze1gvw1ngdSB1gn4W9CToVgP7YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    evohgrshhtrghlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgi
    himhgvsegtvghrnhhordhtvggthheqnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdr
    ohhrghenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:uAejXr4jlnVoWFqxG0QkCIaycK4lDjqDxfh6QmrjCAcwb-UusblkYw>
    <xmx:uAejXtPY3G1bAzgIIHZg6hYx4hyGkzgu2s6sUpliucpKrhvTo_QHNA>
    <xmx:uAejXlPtWB0ldfXuC5sUrhvwtQzZRtB6XUAXodyR2NqNqSJU-PfNmw>
    <xmx:uAejXlVUoA317VBkUWodXQqqEWSeRA9KzRmcUMgW2dG6U1RGjdve3dWtrdQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B1D81328005E;
        Fri, 24 Apr 2020 11:37:27 -0400 (EDT)
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
Subject: [PATCH v2 90/91] dt-bindings: display: vc4: hdmi: Add BCM2711 HDMI controllers bindings
Date:   Fri, 24 Apr 2020 17:35:11 +0200
Message-Id: <9bdee4024b3f95bed9b55c642f0f9415c22fc506.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
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
 Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
new file mode 100644
index 000000000000..6091fe3d315b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/brcm,bcm2711-hdmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2711 HDMI Controller Device Tree Bindings
+
+maintainers:
+  - Eric Anholt <eric@anholt.net>
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2711-hdmi0
+      - brcm,bcm2711-hdmi1
+
+  reg:
+    items:
+      - description: HDMI controller register range
+      - description: DVP register range
+      - description: HDMI PHY register range
+      - description: Rate Manager register range
+      - description: Packet RAM register range
+      - description: Metadata RAM register range
+      - description: CSC register range
+      - description: CEC register range
+      - description: HD register range
+
+  reg-names:
+    items:
+      - const: hdmi
+      - const: dvp
+      - const: phy
+      - const: rm
+      - const: packet
+      - const: metadata
+      - const: csc
+      - const: cec
+      - const: hd
+
+  clocks:
+    description: The HDMI state machine clock
+
+  clock-names:
+    const: hdmi
+
+  ddc:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      Phandle of the I2C controller used for DDC EDID probing
+
+  hpd-gpios:
+    description: >
+      The GPIO pin for the HDMI hotplug detect (if it doesn't appear
+      as an interrupt/status bit in the HDMI controller itself)
+
+  dmas:
+    maxItems: 1
+    description: >
+      Should contain one entry pointing to the DMA channel used to
+      transfer audio data.
+
+  dma-names:
+    const: audio-rx
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - resets
+  - ddc
+
+additionalProperties: false
+
+examples:
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
+...
-- 
git-series 0.9.1
