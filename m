Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732C8C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4412320857
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fDNp6Zp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgDKIDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:03:53 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:54469 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgDKIDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:03:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586592233; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=VjlPEUOrGWDrUxC+6AsNAeKsmpiOB6r2HdjVUP8QVQk=; b=fDNp6Zp1RtjfUGoQ0cv4XCaqDWyIwr02LG4yMQVZGSUxmytBScdQxidCRCK5rSfW7oexlQpH
 8p7jkj0nhKpvQ3FzRrdA878wAlYJCtOwGzuRBN0G9k7T6+IV5yfZft7z6HS9YWNZMQ0Rp4Y2
 9hQzq+l5PeUnE3SLSJK3HqpYnds=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9179df.7fac39203fb8-smtp-out-n04;
 Sat, 11 Apr 2020 08:03:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18F9FC433F2; Sat, 11 Apr 2020 08:03:43 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E40F5C433F2;
        Sat, 11 Apr 2020 08:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E40F5C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
From:   Ajit Pandey <ajitp@codeaurora.org>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: [PATCH 01/11] Documentation: device-tree: sound: Update lpass-cpu driver binding
Date:   Sat, 11 Apr 2020 13:32:41 +0530
Message-Id: <1586592171-31644-2-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Done the required cleanups to update lpass-cpu binding with newer
yaml formats.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 158 ---------------------
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 103 ++++++++++++++
 2 files changed, 103 insertions(+), 158 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
deleted file mode 100644
index a49b878..00000000
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
+++ /dev/null
@@ -1,158 +0,0 @@
-* Qualcomm Technologies LPASS CPU DAI binding
-
-Low-Power Audio SubSystem (LPASS) consist of MI2S interfaces for audio data
-transfer on external codec. LPASS cpu driver is a common code to configure
-MI2S related CPU dai's across different version of LPASS architecture.
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: compatible string corresponds to lpass variants driver
-		    must be "qcom, lpass-cpu-sc7180" for sc7180 lpass
-		    must be "qcom,apq8016-lpass-cpu" for apq8016 lpass
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must specify the base address and size of the LPAIF CORE
-		    region of lpass variant.
-- reg-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "lpass-lpaif"
-
-- iommus:
-        Usage: required for "qcom, lpass-cpu-sc7180" compatible string
-        Value type: <prop-encoded-array>
-        Definition: sid mask for lpaif memory region to apps_smmu
-                    must be <&apps_smmu 0x1020 0>
-
-- power-domains:
-	Usage: required for "qcom, lpass-cpu-sc7180" compatible string
-	Value type: <phandle>
-	Definition: reference to power-domains
-		    must be <&lpass_hm LPASS_CORE_HM_GDSCR>
-
-- clocks:
-        Usage: required
-	Value type: <phandle>
-	Definition: reference to the clocks that match clock-names
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: The clocks needed depend on the compatible string:
-	qcom,lpass-cpu-apq8016:
-		must be "ahbix-clk", "mi2s-osr-clk", "mi2s-bit-clk0",
-		mi2s-bit-clk1", "mi2s-bit-clk2", "mi2s-bit-clk3",
-		"pcnoc-mport-clk", "pcnoc-sway-clk"
-	qcom, lpass-cpu-sc7180:
-		must be "noc", "audio-core", "mclk0", "sysnoc_mport",
-		"pri_ibit", "sec_ibit"
-
-- #sound-dai-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 1
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the interrupts that match interrupt-names
-
-- interrupt-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "lpass-irq-lpaif"
-
-- qcom,adsp:
-        Usage: optional
-        Value type: <phandle>
-	Definition: Phandle for the audio DSP node
-
-= MI2S DAIs (Digial Audio Interface)
-"dais" child node of the lpass node. It represents mi2s dais, each mi2s dai is
-subnode of "dais" representing board specific dai setup & required dai clocks.
-"dais" node should have following properties.
-
-- id:
-	Usage: required for mi2s interface
-	Value type: <u32>
-	Definition: Must be dai id defined in lpass bindings like MI2S_PRIMARY
-
-- qcom,bitclk-name:
-	Usage: required for mi2s interface
-	Value type: <stringlist>
-	Definition: bitclk name corresponds to MI2S of lpass version
-
-- qcom,mclk-name:
-        Usage: optional for mi2s interface
-        Value type: <stringlist>
-        Definition: external mclk name corresponds to MI2S of lpass version
-
-- qcom,osrclk-name:
-        Usage: optional for mi2s interface
-        Value type: <stringlist>
-        Definition: osrclk name corresponds to MI2S of lpass version
-
-- qcom,spkmode-mask:
-        Usage: optional for mi2s interface
-        Value type: <u32>
-        Definition: board specific property to change default spkmode mask
-                    of MI2S dai based on dataline connection on board.
-
-- qcom,micmode-mask:
-        Usage: optional for mi2s interface
-        Value type: <u32>
-        Definition: board specific property to change default micmode mask
-                    of MI2S dai based on dataline connection on board.
-
-- qcom,loopback-mask:
-        Usage: optional for mi2s interface
-        Value type: <u32>
-        Definition: board specific property to change default loopback mask
-                    of MI2S dai as per requirement.
-
-- qcom,wssrc-mask:
-        Usage: optional for mi2s interface
-        Value type: <u32>
-        Definition: board specific property to change default wssrc mask
-                    of MI2S dai based as per requirement.
-
-Example:
-
-lpass_cpu: lpass {
-	compatible = "qcom, lpass-cpu-sc7180";
-
-	reg = <0 0x62F00000 0 0x29000>;
-	reg-names = "lpass-lpaif";
-
-	iommus = <&apps_smmu 0x1020 0>;
-
-	power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
-
-	clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
-		 <&lpasscorecc LPASS_AUDIO_CORE_CORE_CLK>,
-		 <&lpasscorecc LPASS_AUDIO_CORE_EXT_MCLK0_CLK>,
-		 <&lpasscorecc LPASS_AUDIO_CORE_SYSNOC_MPORT_CORE_CLK>,
-		 <&lpasscorecc LPASS_AUDIO_CORE_LPAIF_PRI_IBIT_CLK>,
-		 <&lpasscorecc LPASS_AUDIO_CORE_LPAIF_SEC_IBIT_CLK>;
-
-	clock-names = "noc", "audio-core", "mclk0", "sysnoc_mport",
-		      "pri_ibit", "sec_ibit";
-
-	#sound-dai-cells = <1>;
-
-	interrupts = <0 160 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "lpass-irq-lpaif";
-
-	prim-mi2s@0 {
-		id = <MI2S_PRIMARY>;
-		qcom,bitclk-name = "pri_ibit";
-		qcom,mclk-name = "mclk0";
-	};
-
-	sec-mi2s@1 {
-		id = <MI2S_SECONDARY>;
-		qcom,bitclk-name = "sec_ibit";
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
new file mode 100644
index 00000000..a87a406
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,lpass-cpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm LPASS CPU dai driver bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+  - Ajit Pandey <ajitp@codeaurora.org>
+
+description: |
+  Qualcomm SOC Low-Power Audio SubSystem (LPASS) that consist of MI2S interface
+  for audio data transfer on external codecs. LPASS cpu driver is a module to
+  configure Low-Power Audio Interface(LPAIF) core registers across different
+  IP versions.
+
+properties:
+  compatible:
+    enum:
+      - qcom,lpass-cpu
+      - qcom,apq8016-lpass-cpu
+
+  reg:
+    items:
+      - description: LPAIF core registers
+
+  reg-names:
+    items:
+      - const: lpass-lpaif
+
+  clocks:
+    items:
+      - description: AHBIX core clock for IPQ806X
+      - description: oscillator clock for MI2S external interfaces
+      - description: Bit clock for single MI2S dai in IPQ806X
+      - description: Bit clock for MI2S_PRIMARY dai interface
+      - description: Bit clock for MI2S_SECONDARY dai interface
+      - description: Bit clock for MI2S_TERTIARY dai interface
+      - description: Bit clock for MI2S_QUATERNARY dai interface
+      - description: NOC MPORT clock of LPASS core
+      - description: NOC SWAY clock of LPASS core
+
+  clock-names:
+    items:
+      - const: ahbix-clk
+      - const: mi2s-osr-clk
+      - const: mi2s-bit-clk
+      - const: mi2s-bit-clk0
+      - const: mi2s-bit-clk1
+      - const: mi2s-bit-clk2
+      - const: mi2s-bit-clk3
+      - const: pcnoc-mport-clk
+      - const: pcnoc-sway-clk
+
+  interrupts:
+    items:
+      - description: LPAIF DMA buffer interrupt
+
+  interrupt-names:
+    items:
+      - const: lpass-irq-lpaif
+
+  qcom,adsp:
+    maxItems: 1
+    description: Phandle for the audio DSP node
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - sound-dai-cells
+
+optional:
+  - qcom,adsp
+
+examples:
+  lpass@28100000 {
+	compatible = "qcom,lpass-cpu";
+	clocks = <&lcc AHBIX_CLK>,
+		 <&lcc MI2S_OSR_CLK>,
+		 <&lcc MI2S_BIT_CLK>;
+
+	clock-names = "ahbix-clk",
+		      "mi2s-osr-clk",
+		      "mi2s-bit-clk";
+
+	interrupts = <0 85 1>;
+	interrupt-names = "lpass-irq-lpaif";
+
+	reg = <0x28100000 0x10000>;
+	reg-names = "lpass-lpaif";
+	#sound-dai-cells = <1>;
+	qcom,adsp = <&adsp>;
+
-- 
1.9.1
