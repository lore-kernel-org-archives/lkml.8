Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A943EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826BE2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGUa5+DQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFBKJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgFBKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:09:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73586C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 03:09:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b5so1986623pfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vautb822ZfqbgT9H1qhF7C4M74PWhQzgpsc/iQMPhyE=;
        b=MGUa5+DQjvlhtfr049c1/fZTWBfJSEvMFonHlxrFq/sQnDeuGeJcc19rbD1i2IUYFW
         wLdRgfi5usAEHgvKX+OpQiU8rU7Wukf4IBm7E1vRavICIGExstq2YzYucy2VItWJKOa+
         jeZPXSqL+224vtF1Uhg376HaG0Q77QkIazFNHY1K5ndrpRfNcOAE+wcbJszpvM3VA8b3
         yt4sy+m/l7mzThlR4/45Oxmf0iIzi3ZG4xs6tKIq/66HY8NrivhPSydQrhMaMdnSVgd5
         DZGaTpACkz+3blFLW4phCxLZByRK4jdSNCSvI1owaTzER2JWfPUn1eKbji0Gt/bMBP+7
         ZaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vautb822ZfqbgT9H1qhF7C4M74PWhQzgpsc/iQMPhyE=;
        b=kM1YtbLTXvMD9AFeR+/XdxRENrErA89KpBP+IBJsuACymmjQ0lVhtYWenYHrI6NvTW
         XzN/ugGKZpYBABp+590fEBnPY573C4XTdjyUg/9Uf+cs9nJx0VCV+vgteHddW5RIuiFC
         6IvymmORaqmQIIbs5eY1bPjtMd7yygR8J2r1bXGIpFhmERtvpL5klPCht5u4puXvWvqg
         mPz106YMauFpQC4eWfM+m2rIMeRy9s+/NuMDYNwd06iMt56SgIX7a6M3Vjou05Bmk6BZ
         oJ0tcjtyqhwH0SCQjnDdhbY9i3XLQjKZSt6eC7NPUj5ALdNXCbC+Y77OrPiSkvI6i7JT
         hm6w==
X-Gm-Message-State: AOAM530DNweXchqmjGcYhryZcojeHaYp9tRXl/HBCgGScoCunX4oMfLt
        Nhrj3XU0oTWaANPIkBbDfhxtDg==
X-Google-Smtp-Source: ABdhPJyvrxxge7r1kiYD3PJFB7Ec7P66SkuqUcn7jCBYLTysyG8pMddjI4b3PuPNg2NaNhrHragmnw==
X-Received: by 2002:a62:9242:: with SMTP id o63mr24360759pfd.310.1591092585950;
        Tue, 02 Jun 2020 03:09:45 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id d8sm1931276pgb.42.2020.06.02.03.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 03:09:45 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v4 2/5] dt-bindings: regulator: Add labibb regulator
Date:   Tue,  2 Jun 2020 15:39:21 +0530
Message-Id: <20200602100924.26256-3-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602100924.26256-1-sumit.semwal@linaro.org>
References: <20200602100924.26256-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nisha Kumari <nishakumari@codeaurora.org>

Adding the devicetree binding for labibb regulator.

Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
 [sumits: cleanup as per review comments and update to yaml]
--
v2: updated for better compatible string and names.
v3: moved to yaml
v4: fixed dt_binding_check issues
---
 .../regulator/qcom-labibb-regulator.yaml      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
new file mode 100644
index 000000000000..178820ec04c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom-labibb-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's LAB(LCD AMOLED Boost)/IBB(Inverting Buck Boost) Regulator
+
+maintainers:
+  - Sumit Semwal <sumit.semwal@linaro.org>
+
+description:
+  LAB can be used as a positive boost power supply and IBB can be used as a
+  negative boost power supply for display panels. Currently implemented for
+  pmi8998.
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: qcom,pmi8998-lab-ibb
+
+  lab:
+    type: object
+
+    properties:
+
+      interrupts:
+        maxItems: 1
+        description:
+          Short-circuit interrupt for lab.
+
+      interrupt-names:
+        const: sc-err
+
+    required:
+    - interrupts
+    - interrupt-names
+
+  ibb:
+    type: object
+
+    properties:
+
+      interrupts:
+        maxItems: 1
+        description:
+          Short-circuit interrupt for lab.
+
+      interrupt-names:
+        const: sc-err
+
+    required:
+    - interrupts
+    - interrupt-names
+
+required:
+  - compatible
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    labibb {
+      compatible = "qcom,pmi8998-lab-ibb";
+
+      lab {
+        interrupts = <0x3 0x0 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "sc-err";
+      };
+
+      ibb {
+        interrupts = <0x3 0x2 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "sc-err";
+      };
+    };
+
+...
-- 
2.26.2

