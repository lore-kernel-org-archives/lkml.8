Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F04C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685D22077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uA+VDZWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgAPQLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:11:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52017 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgAPQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:11:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so4357890wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/U9Wa/GoCLKm1Lbl8UlXZtWK4AHe8cmvv785pLgxmRI=;
        b=uA+VDZWp4GvEm4eqJpZWuhxrUBajKdpF2yxncEeUmOo4VCK6ccr286Heb3/MVMTiLV
         fxdOfqKQhz0NJ2v/iyCQTvh+TBHTFi0m00a/Woq4uBS/SJ+vUmvxn1cPuMbgyLNKHezd
         fSNLj1QFdbLfcclKhGa7nNtQsZg4iufcdloCmh5/GQPKo1JDdCHGdXV1osgPc0eH4bTB
         W0mB7RmIZH669FLKvCvKJEe7Gf0Fxp5G5aEzKndJF6PCFFleBJtFA5C89FiMyd7jz9OL
         kDI1xbwIm+H/mrca37yCsTymOq05QLBuD9/V9O7Mjy2CEwBytYCPZHyR6LuDXGIInR5M
         /PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/U9Wa/GoCLKm1Lbl8UlXZtWK4AHe8cmvv785pLgxmRI=;
        b=m61pPaLv59PxmsgdKcRvCaZfntT6MrX9aXkfvSXdieYEi/+S0d1BovPu1EC18ip9Xv
         wQb/VsOzO9fVApL5jOVMGzuBh8/3KSYidJLhrfFYq+dqhJ+ykTRrtghVkBH6r1V1hXPX
         6zlCk4nCmzlY8XDb/U06V7iPw3fPB1s2V3qiWFerJVbC9okUN0bg1kl60jbaZn8QVixL
         sXmxS9+jMqqjpBYuQbc5EZzqwlV6mXydAWKBD6+DQEte2FrS2peOdtkXcyMOfGMWC1yt
         lOZdOV1ENzZKjHzH5mR10jJmcMqqCIYOizWdeZ9X/rmTR0HzTG7Vj/pblwHOqX6weQ58
         8HzQ==
X-Gm-Message-State: APjAAAXHdFIxljhpi9MGckER+TfnIRPIpijSN+MqArnwsD3WFP4557fW
        fwx7Sn6edIhJTw/xmOdpI2LfuQ==
X-Google-Smtp-Source: APXvYqyDTuuTIXoCBeYNz7BfO8axebVvIJ8gUqCG/DSmRfR+PpFkIPjv77Ow/cZT36DuwftE2h6NZA==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr6899244wml.107.1579191078953;
        Thu, 16 Jan 2020 08:11:18 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g9sm30075740wro.67.2020.01.16.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:11:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Shyam Kumar Thella <sthella@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] dt-bindings: nvmem: add binding for QTI SPMI SDAM
Date:   Thu, 16 Jan 2020 16:10:59 +0000
Message-Id: <20200116161100.30637-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200116161100.30637-1-srinivas.kandagatla@linaro.org>
References: <20200116161100.30637-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shyam Kumar Thella <sthella@codeaurora.org>

QTI SDAM allows PMIC peripherals to access the shared memory that is
available on QTI PMICs. Add documentation for it.

Signed-off-by: Shyam Kumar Thella <sthella@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/qcom,spmi-sdam.yaml        | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
new file mode 100644
index 000000000000..7bbd4e62044e
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -0,0 +1,84 @@
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
+              maximum: 7
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
+          #address-cells = <1>;
+          #size-cells = <1>;
+          compatible = "qcom,spmi-sdam";
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
2.21.0

