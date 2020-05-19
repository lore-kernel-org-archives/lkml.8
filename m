Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF482C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939B2205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgESWmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:42:49 -0400
Received: from v6.sk ([167.172.42.174]:58678 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgESWmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:42:46 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 8EBF5612FD;
        Tue, 19 May 2020 22:42:14 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 12/13] dt-bindings: clock: Add Marvell MMP Audio Clock Controller binding
Date:   Wed, 20 May 2020 00:41:50 +0200
Message-Id: <20200519224151.2074597-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519224151.2074597-1-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes the bindings for a controller that generates master and bit
clocks for the I2S interface.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Fix commit message wording
- Define MMP2_CLK_AUDIO_NR_CLKS
- Make clock ids start at 0, not 1
- Fix dt-bindings/clock/marvell,mmp2-audio.h file name
- Rename node from "clocks" to "clock-controller"

 .../clock/marvell,mmp2-audio-clock.yaml       | 74 +++++++++++++++++++
 .../dt-bindings/clock/marvell,mmp2-audio.h    | 10 +++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
 create mode 100644 include/dt-bindings/clock/marvell,mmp2-audio.h

diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
new file mode 100644
index 000000000000..ab6e82d1d3a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/marvell,mmp2-audio-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP2 Audio Clock Controller
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+description: |
+  The audio clock controller generates and supplies the clocks to the audio
+  codec.
+
+  Each clock is assigned an identifier and client nodes use this identifier
+  to specify the clock which they consume.
+
+  All these identifiers could be found in
+  <dt-bindings/clock/marvell,mmp2-audio.h>.
+
+properties:
+  compatible:
+    enum:
+      - marvell,mmp2-audio-clock
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Audio subsystem clock
+      - description: The crystal oscillator clock
+      - description: First I2S clock
+      - description: Second I2S clock
+
+  clock-names:
+    items:
+      - const: audio
+      - const: vctcxo
+      - const: i2s0
+      - const: i2s1
+
+  '#clock-cells':
+    const: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/marvell,mmp2-audio.h>
+    #include <dt-bindings/power/marvell,mmp2.h>
+
+    clock-controller@d42a0c30 {
+      compatible = "marvell,mmp2-audio-clock";
+      reg = <0xd42a0c30 0x10>;
+      clock-names = "audio", "vctcxo", "i2s0", "i2s1";
+      clocks = <&soc_clocks MMP2_CLK_AUDIO>,
+               <&soc_clocks MMP2_CLK_VCTCXO>,
+               <&soc_clocks MMP2_CLK_I2S0>,
+               <&soc_clocks MMP2_CLK_I2S1>;
+      power-domains = <&soc_clocks MMP2_POWER_DOMAIN_AUDIO>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/marvell,mmp2-audio.h b/include/dt-bindings/clock/marvell,mmp2-audio.h
new file mode 100644
index 000000000000..20664776f497
--- /dev/null
+++ b/include/dt-bindings/clock/marvell,mmp2-audio.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
+#ifndef __DT_BINDINGS_CLOCK_MARVELL_MMP2_AUDIO_H
+#define __DT_BINDINGS_CLOCK_MARVELL_MMP2_AUDIO_H
+
+#define MMP2_CLK_AUDIO_SYSCLK		0
+#define MMP2_CLK_AUDIO_SSPA0		1
+#define MMP2_CLK_AUDIO_SSPA1		2
+
+#define MMP2_CLK_AUDIO_NR_CLKS		3
+#endif
-- 
2.26.2

