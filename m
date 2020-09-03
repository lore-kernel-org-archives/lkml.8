Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA090C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BEE20897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="asoKpVlK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gdndLaGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgICIHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:07:49 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:58087 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728522AbgICIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4DCA2B19;
        Thu,  3 Sep 2020 04:03:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=6txcLK9XS/umD
        ai20rz0YaH0SugcRvZLRpEWcEN1jU0=; b=asoKpVlKc+1v01Yu3/H77bGv3Arpw
        sF/yNn7NpY3xp1tR7xx9EuKR8TbhHO28ELFI7bvz/SfxJFbEfC7jI6C5WpEv/4YY
        KCVA68GX7VXLQzID0z6n1snoHjr+OrB2hKch9S5yPBDf4iHW74sKVzLTwzG7B5H2
        NE2FqPJUAv8iZHrLq5iam7o11z6EraaaTstPUxvpeMgk3EezG0+gjBoxvNrjTtGp
        vzLost8f9NIE3JjD7HACcT0cz7toN1CjfrV7EBSr15T58p5qP4B6bILec27YGHzE
        2aYTakIVzDIZnbBKRNbjZxAsodIT3NlKTSci0Xna8Imo0cF9hbHsiGYOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=6txcLK9XS/umDai20rz0YaH0SugcRvZLRpEWcEN1jU0=; b=gdndLaGV
        9bjkoBpSQeY81lcl0AP/KyYs9Lkb15GPMb9yiMyN/v4F9oa7jk8JCTrP3UQtNk2N
        DSSRYgGNdCbSS2OZwaWC5VAardemN99OzVHzv+ukwUkyzWZUsns0Z5rn8BOT6crB
        MF3puEI69ZNADoDXq2wVy9oy25st49lV/upv5S6SF7o6J0mB9oam+6Zh29TNFgU5
        2v2NzLs64xXxz0lW6Fir7zQ+mW2RDl5FZoyPdM2MwXYSBrBaeptF/U/GxCzVMxcf
        LZCPEq9/AWN4JLhyn1nI06KN1sHcdJLq3JbwyLawVWGR+DYSKcvujnX9Sw0hKYAh
        su7EGLbEujo0qg==
X-ME-Sender: <xms:XqNQX645TScxcMwY5xPO_q0lXiSQnBN4UmJvJPx9_yIv13VaJBpN_g>
    <xme:XqNQXz7_EXZR10-heYEQfXoXt0PF65izT-l8d9luThieRQISFI5geYd-hP4AXT56l
    p46wXJIOw4He-o9DR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogevohgrshhtrghlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffo
    jghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomh
    grgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepveejieejtdev
    gfffgfejuefggfeutdelteekgeetueeftddutddtgfffhffgueffnecuffhomhgrihhnpe
    guvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestg
    gvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:XqNQX5e5g3lAglKBbbjJkl27rRRhv0Fs4asVXSKHAu32QSqHQppdOw>
    <xmx:XqNQX3Ib62OV-K-MDBT8fl7WGJJl8j0LQaSt3oWBRKRJR1H7LIE0-g>
    <xmx:XqNQX-LfHituxjPI8To9ohes_ILdcd-hjFRpST5u3JFnIGFl_8BzWQ>
    <xmx:XqNQXwDBGQWAzGdRp8EZ5npNoeVUwf0EUcq1PoSMtrX0JfAmQeVm48-PTB4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6B555306005E;
        Thu,  3 Sep 2020 04:03:42 -0400 (EDT)
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
        Rob Herring <robh@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 77/80] dt-bindings: display: vc4: hdmi: Add BCM2711 HDMI controllers bindings
Date:   Thu,  3 Sep 2020 10:01:49 +0200
Message-Id: <ecd686e9b2335275bfb1ccfe1878305367b34bf3.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI controllers found in the BCM2711 SoC need some adjustments to the
bindings, especially since the registers have been shuffled around in more
register ranges.

Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
new file mode 100644
index 000000000000..03a76729d26c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
@@ -0,0 +1,117 @@
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
+    items:
+      - description: The HDMI state machine clock
+      - description: The Pixel BVB clock
+      - description: The HDMI Audio parent clock
+      - description: The HDMI CEC parent clock
+
+  clock-names:
+    items:
+      - const: hdmi
+      - const: bvb
+      - const: audio
+      - const: cec
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
+        clocks = <&firmware_clocks 13>, <&firmware_clocks 14>, <&dvp 1>, <&clk_27MHz>;
+        clock-names = "hdmi", "bvb", "audio", "cec";
+        resets = <&dvp 0>;
+        ddc = <&ddc0>;
+    };
+
+...
-- 
git-series 0.9.1
