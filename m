Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A066C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11B5207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TKbAZYjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgAMJYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:24:08 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:41416 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgAMJYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:24:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578907445; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=E2fgNtG+WIKahbblJ85apQtJqKTonOXKBjBUc4D+Mb8=; b=TKbAZYjlRIrdZ/JY7pB86x8kV3A8RrOWQ57xHHp//ct8y5KCNzgXsl9sAaeC4sJQ9XnQo/Fp
 c25G+MjgX+3olNtqMMX2wcaw788yndBEOt9qg02QHsR5cczLDdZrhFPovq8ud9q07ksTTmxL
 ODzmy2r/zmFWmrHFaZPytKY7OWk=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1c3732.7fd053feb998-smtp-out-n02;
 Mon, 13 Jan 2020 09:24:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D95EC447A2; Mon, 13 Jan 2020 09:24:02 +0000 (UTC)
Received: from sthella-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sthella)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1811C433CB;
        Mon, 13 Jan 2020 09:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1811C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sthella@codeaurora.org
From:   Shyam Kumar Thella <sthella@codeaurora.org>
To:     agross@kernel.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Shyam Kumar Thella <sthella@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: nvmem: add binding for QTI SPMI SDAM
Date:   Mon, 13 Jan 2020 14:53:50 +0530
Message-Id: <1578907430-2941-1-git-send-email-sthella@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QTI SDAM allows PMIC peripherals to access the shared memory that is
available on QTI PMICs. Add documentation for it.

Signed-off-by: Shyam Kumar Thella <sthella@codeaurora.org>
---
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
new file mode 100644
index 0000000..4526fbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/qcom,spmi-sdam.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SPMI SDAM DT bindings
+
+maintainers:
+  - Shyam Kumar Thella <sthella@codeaurora.org>
+
+description: |
+  The SDAM provides scratch register space for the PMIC clients. This
+  memory can be used by software to store information or communicate
+  to/from the PBUS.
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,spmi-sdam
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+required:
+  - compatible
+  - reg
+  - ranges
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    properties:
+      reg:
+        maxItems: 1
+        description:
+          Offset and size in bytes within the storage device.
+
+      bits:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        maxItems: 1
+        items:
+          items:
+            - minimum: 0
+              description:
+                Offset in bit within the address range specified by reg.
+            - minimum: 1
+              description:
+                Size in bit within the address range specified by reg.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+examples:
+  - |
+      sdam_1: nvram@b000 {
+         #address-cells = <1>;
+         #size-cells = <1>;
+         compatible = "qcom,spmi-sdam";
+          reg = <0xb000 0x100>;
+          ranges = <0 0xb000 0x100>;
+
+          /* Data cells */
+          restart_reason: restart@50 {
+              reg = <0x50 0x1>;
+              bits = <6 2>;
+          };
+      };
+...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project
