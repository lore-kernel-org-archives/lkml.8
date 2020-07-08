Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAEC206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fcLpCkOC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SUWtXL5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGHRok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:44:40 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:60959 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgGHRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E33F92F3;
        Wed,  8 Jul 2020 13:44:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=WgxAC/8KE5/Bw
        WN24s3+59aM6OiasJVZShMLjmU3z0o=; b=fcLpCkOCczHZXKavl3imq1CJzXgMY
        fXTp6L1GIsYWPqrrjTjuuSdRYmmyAKc+cuZAM2n+OSHIjlS+j1cDSEICb8Oj36Xp
        tqB0rJeY2EMBMwoGnF/E4+0Px35sm7tRMDQa+8VXGzfZbQE7G1CCK3YYJNKjKlel
        1P3rW0bqzB8YH0xI8j5a4XDo874JaZS1MJtOjVSxHuZMywreQfLbu/OzqBxAhzN5
        a2j2F4JUX7FZGwlLg5ukZRS5vESkAUSy9h/NCu26313lx/FowUh7qZnKoMlnVQAv
        txttQ4rsP+u3CuHLmYaIOkn2nEfcG419Psit8gxdN+gfrgAKLXtwOIrPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=WgxAC/8KE5/BwWN24s3+59aM6OiasJVZShMLjmU3z0o=; b=SUWtXL5Z
        8FCcJHheGFKpYSRB9jauE82RW6aj1URfMTMaXqBAUpwXHtK3e1PJ2ro5ZnmrOw4b
        uhi2CCq8TAK1f72VUNQeLPj2hE5dkjQ5xkn1AK2j30BFe/kfUj8QA1kJLTMV0zKo
        kb2Cw8maJcyvbDIAjM3daRTaMvUnzU5nvYo+RxiPzj0yzq2ePOmovgVOd+VgpPYn
        ikmVPjfXlonNNc5KPXxiq64Kiu9iNuwqhXrApskGRquULz1iQZFqVsdudZqXzEPg
        o/mwKq8+5HBQa9bRUCdfwXElPY0ybcPOrYZ7f4GL/8squTOPzX5zAUwEXjuxfsjh
        EAbUyhMyEz/4PA==
X-ME-Sender: <xms:8wUGX7b4DaipZWuByFwCce9u--WmjylQqvrHFKUb7zM6UVa-YlvfMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    govehorghsthgrlhdqhfeguddvqddtvdculdduhedtmdenucfjughrpefhvffufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrg
    igihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeevjeeijedtvefg
    fffgjeeugffguedtleetkeegteeufedtuddttdfgfffhgfeuffenucffohhmrghinhepug
    gvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvg
    hrnhhordhtvggthh
X-ME-Proxy: <xmx:8wUGX6aFJH8lmWxj_D15BrtwV1chiGAZzabRUZy-6NBjAIHosxNhdA>
    <xmx:8wUGX99jCBN4-ff6LkkbuFmrCUEgavhQOrf2FeDPC-trmHCKMlhT-w>
    <xmx:8wUGXxpMxFyezU78EkTRStgIWtTJ5dMPKaRBs02tt0hKh60uPf9hlA>
    <xmx:8wUGXycCpP454bl5ep6EBGlFBGJqp6BJJJAHL_mqATLzrUcdkOjaIyaLMuY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1FA0130600A9;
        Wed,  8 Jul 2020 13:44:19 -0400 (EDT)
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 75/78] dt-bindings: display: vc4: hdmi: Add BCM2711 HDMI controllers bindings
Date:   Wed,  8 Jul 2020 19:42:23 +0200
Message-Id: <a174517d1f57b7a75eabd0361aef5365894d7c1a.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
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
