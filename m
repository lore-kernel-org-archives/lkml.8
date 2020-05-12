Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CC3C54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D07F206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mrwvrfQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgELNQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:16:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58642 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729917AbgELNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:16:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CDG5dT076528;
        Tue, 12 May 2020 08:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589289365;
        bh=K8NpP6+NKZm0oQ3CgA3d8ONX37b6p0pCLJMl6dgv8KM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mrwvrfQXvjhrUoo4REoTBXL1nUb6qThEj/fRmncaR8phELGjXRC0qO9+KnXeUpoaT
         Ott4MpZ+8h1dEMnJs135sqYuURFtpjRI5Br60C6xG2Ary7b6f97xgRVe9N+owHwvfW
         o//ZJ+CXteIX3stWIoe2LdgRjcEFLEUSDnWgMsCY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CDG5iB066042;
        Tue, 12 May 2020 08:16:05 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 08:16:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 08:16:05 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CDFxac079268;
        Tue, 12 May 2020 08:16:03 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] bindings: sound: Add documentation for TI j721e EVM (CPB and IVI)
Date:   Tue, 12 May 2020 16:16:32 +0300
Message-ID: <20200512131633.32668-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512131633.32668-1-peter.ujfalusi@ti.com>
References: <20200512131633.32668-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio support on the Common Processor Board board is using
pcm3168a codec connected to McASP10 serializers in parallel setup.

The Infotainment board plugs into the Common Processor Board, the support
of the extension board is extending the CPB audio support by adding
the two codecs on the expansion board.

The audio support on the Infotainment Expansion Board consists of McASP0
connected to two pcm3168a codecs with dedicated set of serializers to each.
The SCKI for pcm3168a is sourced from j721e AUDIO_REFCLK0 pin.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../bindings/sound/ti,j721e-cpb-audio.yaml    |  93 ++++++++++++
 .../sound/ti,j721e-cpb-ivi-audio.yaml         | 142 ++++++++++++++++++
 2 files changed, 235 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
new file mode 100644
index 000000000000..0355ffc2b01b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,j721e-cpb-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments J721e Common Processor Board Audio Support
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+
+description: |
+  The audio support on the board is using pcm3168a codec connected to McASP10
+  serializers in parallel setup.
+  The pcm3168a SCKI clock is sourced from j721e AUDIO_REFCLK2 pin.
+  In order to support 48KHz and 44.1KHz family of sampling rates the parent
+  clock for AUDIO_REFCLK2 needs to be changed between PLL4 (for 48KHz) and
+  PLL15 (for 44.1KHz). The same PLLs are used for McASP10's AUXCLK clock via
+  different HSDIVIDER.
+
+properties:
+  compatible:
+    items:
+      - const: ti,j721e-cpb-audio
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  ti,cpb-mcasp:
+    description: phandle to McASP10
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,cpb-codec:
+    description: phandle to the pcm3168a codec used on the CPB
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  clocks:
+    items:
+      - description: PLL4 clock
+      - description: PLL15 clock
+      - description: McASP10 auxclk clock
+      - description: PLL4_HSDIV0 parent for McASP10 auxclk (for 48KHz)
+      - description: PLL15_HSDIV0 parent for McASP10 auxclk (for 44.1KHz)
+      - description: AUDIO_REFCLK2 clock
+      - description: PLL4_HSDIV2 parent for AUDIO_REFCLK2 clock (for 48KHz)
+      - description: PLL15_HSDIV2 parent for AUDIO_REFCLK2 clock (for 44.1KHz)
+
+  clock-names:
+    items:
+      - const: pll4
+      - const: pll15
+      - const: cpb-mcasp
+      - const: cpb-mcasp-48000
+      - const: cpb-mcasp-44100
+      - const: audio-refclk2
+      - const: audio-refclk2-48000
+      - const: audio-refclk2-44100
+
+required:
+  - compatible
+  - model
+  - ti,cpb-mcasp
+  - ti,cpb-codec
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |+
+    sound {
+        compatible = "ti,j721e-cpb-audio";
+        model = "j721e-cpb";
+
+        status = "okay";
+
+        ti,cpb-mcasp = <&mcasp10>;
+        ti,cpb-codec = <&pcm3168a_1>;
+
+        clocks = <&pll4>, <&pll15>,
+                 <&k3_clks 184 1>,
+                 <&k3_clks 184 2>, <&k3_clks 184 4>,
+                 <&k3_clks 157 371>,
+                 <&k3_clks 157 400>, <&k3_clks 157 401>;
+        clock-names = "pll4", "pll15",
+                      "cpb-mcasp",
+                      "cpb-mcasp-48000", "cpb-mcasp-44100",
+                      "audio-refclk2",
+                      "audio-refclk2-48000", "audio-refclk2-44100";
+    };
diff --git a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
new file mode 100644
index 000000000000..3951c1320fae
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,j721e-cpb-ivi-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments J721e Common Processor Board Audio Support
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+
+description: |
+  The Infotainment board plugs into the Common Processor Board, the support of the
+  extension board is extending the CPB audio support, decribed in:
+  sound/ti,j721e-cpb-audio.txt
+
+  The audio support on the Infotainment Expansion Board consists of McASP0
+  connected to two pcm3168a codecs with dedicated set of serializers to each.
+  The SCKI for pcm3168a is sourced from j721e AUDIO_REFCLK0 pin.
+
+  In order to support 48KHz and 44.1KHz family of sampling rates the parent clock
+  for AUDIO_REFCLK0 needs to be changed between PLL4 (for 48KHz) and PLL15 (for
+  44.1KHz). The same PLLs are used for McASP0's AUXCLK clock via different
+  HSDIVIDER.
+
+  Note: the same PLL4 and PLL15 is used by the audio support on the CPB!
+
+properties:
+  compatible:
+    items:
+      - const: ti,j721e-cpb-ivi-audio
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  ti,cpb-mcasp:
+    description: phandle to McASP10
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,cpb-codec:
+    description: phandle to the pcm3168a codec used on the CPB
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,ivi-mcasp:
+    description: phandle to McASP9
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,ivi-codec-a:
+    description: phandle to the pcm3168a-A codec on the expansion board
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,ivi-codec-b:
+    description: phandle to the pcm3168a-B codec on the expansion board
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  clocks:
+    items:
+      - description: PLL4 clock
+      - description: PLL15 clock
+      - description: McASP10 auxclk clock
+      - description: PLL4_HSDIV0 parent for McASP10 auxclk (for 48KHz)
+      - description: PLL15_HSDIV0 parent for McASP10 auxclk (for 44.1KHz)
+      - description: AUDIO_REFCLK2 clock
+      - description: PLL4_HSDIV2 parent for AUDIO_REFCLK2 clock (for 48KHz)
+      - description: PLL15_HSDIV2 parent for AUDIO_REFCLK2 clock (for 44.1KHz)
+      - description: McASP0 auxclk clock
+      - description: PLL4_HSDIV0 parent for McASP0 auxclk (for 48KHz)
+      - description: PLL15_HSDIV0 parent for McASP0 auxclk (for 44.1KHz)
+      - description: AUDIO_REFCLK0 clock
+      - description: PLL4_HSDIV2 parent for AUDIO_REFCLK0 clock (for 48KHz)
+      - description: PLL15_HSDIV2 parent for AUDIO_REFCLK0 clock (for 44.1KHz)
+
+  clock-names:
+    items:
+      - const: pll4
+      - const: pll15
+      - const: cpb-mcasp
+      - const: cpb-mcasp-48000
+      - const: cpb-mcasp-44100
+      - const: audio-refclk2
+      - const: audio-refclk2-48000
+      - const: audio-refclk2-44100
+      - const: ivi-mcasp
+      - const: ivi-mcasp-48000
+      - const: ivi-mcasp-44100
+      - const: audio-refclk0
+      - const: audio-refclk0-48000
+      - const: audio-refclk0-44100
+
+required:
+  - compatible
+  - model
+  - ti,cpb-mcasp
+  - ti,cpb-codec
+  - ti,ivi-mcasp
+  - ti,ivi-codec-a
+  - ti,ivi-codec-b
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |+
+    sound {
+        compatible = "ti,j721e-cpb-ivi-audio";
+        model = "j721e-cpb-ivi";
+
+        status = "okay";
+
+        ti,cpb-mcasp = <&mcasp10>;
+        ti,cpb-codec = <&pcm3168a_1>;
+
+        ti,ivi-mcasp = <&mcasp0>;
+        ti,ivi-codec-a = <&pcm3168a_a>;
+        ti,ivi-codec-b = <&pcm3168a_b>;
+
+        clocks = <&pll4>, <&pll15>,
+                 <&k3_clks 184 1>,
+                 <&k3_clks 184 2>, <&k3_clks 184 4>,
+                 <&k3_clks 157 371>,
+                 <&k3_clks 157 400>, <&k3_clks 157 401>,
+                 <&k3_clks 174 1>,
+                 <&k3_clks 174 2>, <&k3_clks 174 4>,
+                 <&k3_clks 157 301>,
+                 <&k3_clks 157 330>, <&k3_clks 157 331>;
+        clock-names = "pll4", "pll15",
+                      "cpb-mcasp",
+                      "cpb-mcasp-48000", "cpb-mcasp-44100",
+                      "audio-refclk2",
+                      "audio-refclk2-48000", "audio-refclk2-44100",
+                      "ivi-mcasp",
+                      "ivi-mcasp-48000", "ivi-mcasp-44100",
+                      "audio-refclk0",
+                      "audio-refclk0-48000", "audio-refclk0-44100";
+    };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

