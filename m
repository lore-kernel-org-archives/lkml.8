Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEA8C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCED20722
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="d2CNb/Il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCUBcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:32:21 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52694 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbgCUBcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:32:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584754339; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=/FHA7+MQrxO1ynBN4KFge6gmC0i/oDr2iQWcxHPoxsE=; b=d2CNb/IlGA3hr6bzRI8g6CNz+hJAO2OKYd7qfD1ZWyqzyTzJUqZkURjriMRcviYJtL5rZBiE
 Vxn9HBEHw77A7jhaFcmkyw+GNCqYJ9gS3itl+Mg1y/A9DF9+RNR0Fb1LB4dOaprStH4XTmee
 uPjE7YHR9TzWxK2RUy6/fN5w+cs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e756ea3.7f2b6c7c0d88-smtp-out-n02;
 Sat, 21 Mar 2020 01:32:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 052C7C433CB; Sat, 21 Mar 2020 01:32:18 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00845C433BA;
        Sat, 21 Mar 2020 01:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00845C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org
Cc:     robh@kernel.org, psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 2/2] dt-bindings: remoteproc: Add documentation for SPSS remoteproc
Date:   Fri, 20 Mar 2020 18:32:10 -0700
Message-Id: <1584754330-445-2-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584754330-445-1-git-send-email-rishabhb@codeaurora.org>
References: <1584754330-445-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Secure Subsystem remote processor
support in remoteproc framework. This describes all the resources
needed by SPSS to boot and handle crash and shutdown scenarios.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 .../devicetree/bindings/remoteproc/qcom,spss.yaml  | 125 +++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml
new file mode 100644
index 0000000..9ca7947a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/qcom,spss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SPSS Peripheral Image Loader
+
+maintainers:
+  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
+description: |
+  This document defines the binding for a component that loads and boots firmware
+  on the Qualcomm Secure Peripheral Processor. This processor is booted in the
+  bootloader stage and it attaches itself to linux later on in the boot process.
+
+properties:
+  compatible:
+    enum:
+      "qcom,sm8250-spss-pas"
+
+  reg:
+    items:
+      - description: IRQ status register
+      - description: IRQ clear register
+      - description: IRQ mask register
+      - description: Error register
+      - description: Error spare register
+
+  reg-names:
+    items:
+      - const: sp2soc_irq_status
+      - const: sp2soc_irq_clr
+      - const: sp2soc_irq_mask
+      - const: rmb_err
+      - const: rmb_err_spare2
+
+  interrupts:
+    maxitems: 1
+    items:
+      - description: rx interrupt
+
+  clocks:
+    items:
+      - description:
+                    reference to the xo clock to be held on behalf
+                    of the booting Hexagon core
+
+  clock-names:
+    items:
+      - const: xo
+
+  cx-supply: true
+
+  px-supply: true
+
+  memory-region: true
+    items:
+      - description: reference to the reserved-memory for the SPSS
+
+  qcom,spss-scsr-bits:
+    - description: Bits that are set by remote processor in the irq status
+                   register region to represent different states during
+                   boot process
+
+  child-node:
+    description: Subnode named either "smd-edge" or "glink-edge" that
+                 describes the communication edge, channels and devices
+                 related to the SPSS.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+  - cx-supply
+  - px-supply
+  - memory-region
+  - qcom,spss-scsr-bits
+
+
+examples:
+  - |
+    spss {
+        compatible = "qcom,sm8250-spss-pil";
+        reg = <0x188101c 0x4>,
+                <0x1881024 0x4>,
+                <0x1881028 0x4>,
+                <0x188103c 0x4>,
+                <0x1882014 0x4>;
+        reg-names = "sp2soc_irq_status", "sp2soc_irq_clr",
+                    "sp2soc_irq_mask", "rmb_err", "rmb_err_spare2";
+        interrupts = <0 352 1>;
+
+        cx-supply = <&VDD_CX_LEVEL>;
+        cx-uV-uA = <RPMH_REGULATOR_LEVEL_TURBO 100000>;
+        px-supply = <&VDD_MX_LEVEL>;
+        px-uV = <RPMH_REGULATOR_LEVEL_TURBO 100000>;
+
+        clocks = <&clock_rpmh RPMH_CXO_CLK>;
+        clock-names = "xo";
+        qcom,proxy-clock-names = "xo";
+        status = "ok";
+
+        memory-region = <&pil_spss_mem>;
+        qcom,spss-scsr-bits = <24 25>;
+
+        glink-edge {
+                qcom,remote-pid = <8>;
+                transport = "spss";
+                mboxes = <&sp_scsr 0>;
+                mbox-names = "spss_spss";
+                interrupt-parent = <&intsp>;
+                interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>;
+
+                reg = <0x1885008 0x8>,
+                      <0x1885010 0x4>;
+                reg-names = "qcom,spss-addr",
+                            "qcom,spss-size";
+
+                label = "spss";
+                qcom,glink-label = "spss";
+        };
+    };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
