Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E231DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1C4206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FRIiyQpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgFVOtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgFVOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:49:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71602C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:49:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so8524557pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuVK/v+1tvKBkmeEBcgyRggLJdKFuSM372gKzS+kAj0=;
        b=FRIiyQpTCdW5WobQ+AXqfYbhJ5kRK2CuYDTVZ33RvBx/tIQ1fYHC6bAe/a2dT4/8qL
         Kx5H0XeUGHBNiW3FUSwr1gij2+OpE2FXss6ZZgeZL4jYlnve6HimJ7+2WBHvB3BeQiLT
         PIgb8uHYqR8EK4YONhh7iCt1cuZLuRhs6Y2Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cuVK/v+1tvKBkmeEBcgyRggLJdKFuSM372gKzS+kAj0=;
        b=LKWFvGpCVEhpOEDuvrAldgYg2I1PzZONkr1qu1i7749zThE8dEflLE4fAn6wA0T2cD
         q4P8Ucw+mZNr0s8Uo7YH5FT9XAlr1GBxPWQZBZkoO8TTpwq+uMNFM0d8AYDhbnO9QjUH
         3xUbgCF32ZRDf4kkbISxi2gBXy0+cPAetTfDGbYDB2DXXaTB2C19hou0VbNDCLWK+6hl
         K0SV/WHFORW11rDC2au+aQN0RuJPzrT/gVj2L/ARFjF/SAVbckZJWeucovBAc3Q7J+hs
         wEFU+85ADft/1dk99xtg7qBzT/z82XmnPvK7rlhUo6f7FD4TJ4eGGr81+xM7RmnD/CBn
         rVQg==
X-Gm-Message-State: AOAM532tnN4B5eIMo7s/xchx/30uN5o5SDK1yu8tqLuLwlVwROrB7tQK
        8x0a7EtJ1zxZcZ7h0p/16oRs2Q==
X-Google-Smtp-Source: ABdhPJwh8qdfgB4PyHBvuylhtdevl3IsnTIVSD3vl0ZbQyJ6kVyPbEWXqMB3EfvjUDQiwvOmIo5W+g==
X-Received: by 2002:a65:6846:: with SMTP id q6mr12313795pgt.397.1592837389876;
        Mon, 22 Jun 2020 07:49:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 77sm13903018pfu.139.2020.06.22.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 07:49:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     mturney@codeaurora.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        rnayak@codeaurora.org, dhavalp@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sparate@codeaurora.org,
        linux-arm-msm@vger.kernel.org, mkurumel@codeaurora.org,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: nvmem: qfprom: Convert to yaml
Date:   Mon, 22 Jun 2020 07:49:26 -0700
Message-Id: <20200622074845.v4.1.Iea2704ec2cb40c00eca47781c310a6330ac5dd41@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622144929.230498-1-dianders@chromium.org>
References: <20200622144929.230498-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Kumar Bokka <rbokka@codeaurora.org>

This switches the bindings over from txt to yaml.

Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- Maintainer now listed as Srinivas.
- Example under "soc" to get #address-cells and #size-cells.

Changes in v3:
- Split conversion to yaml into separate patch new in v3.
- Use 'const' for compatible instead of a 1-entry enum.
- Changed filename to match compatible string.
- Add #address-cells and #size-cells to list of properties.
- Fixed up example.

 .../bindings/nvmem/qcom,qfprom.yaml           | 50 +++++++++++++++++++
 .../devicetree/bindings/nvmem/qfprom.txt      | 35 -------------
 2 files changed, 50 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.txt

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
new file mode 100644
index 000000000000..39f97c1c83a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/qcom,qfprom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc, QFPROM Efuse bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    const: qcom,qfprom
+
+  reg:
+    items:
+      - description: The corrected region.
+
+  # Needed if any child nodes are present.
+  "#address-cells":
+    const: 1
+  "#size-cells":
+    const: 1
+
+required:
+   - compatible
+   - reg
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      efuse@784000 {
+        compatible = "qcom,qfprom";
+        reg = <0 0x00784000 0 0x8ff>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        hstx-trim-primary@1eb {
+          reg = <0x1eb 0x1>;
+          bits = <1 4>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/qfprom.txt b/Documentation/devicetree/bindings/nvmem/qfprom.txt
deleted file mode 100644
index 26fe878d5c86..000000000000
--- a/Documentation/devicetree/bindings/nvmem/qfprom.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-= Qualcomm QFPROM device tree bindings =
-
-This binding is intended to represent QFPROM which is found in most QCOM SOCs.
-
-Required properties:
-- compatible: should be "qcom,qfprom"
-- reg: Should contain registers location and length
-
-= Data cells =
-Are child nodes of qfprom, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	qfprom: qfprom@700000 {
-		compatible 	= "qcom,qfprom";
-		reg		= <0x00700000 0x8000>;
-		...
-		/* Data cells */
-		tsens_calibration: calib@404 {
-			reg = <0x4404 0x10>;
-		};
-	};
-
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-For example:
-
-	tsens {
-		...
-		nvmem-cells = <&tsens_calibration>;
-		nvmem-cell-names = "calibration";
-	};
-- 
2.27.0.111.gc72c7da667-goog

