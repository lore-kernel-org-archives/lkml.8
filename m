Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39623C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181CC20753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAPOs+dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgEMAz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbgEMAzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:55:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D053C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:55:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u15so2191463plm.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etYHxN3ySLIwR6cL/4LlObYwmD9I/trb9bCtQEgj1mI=;
        b=vAPOs+dPJoqTXGl2f0d2ZiQWsvD5qMYGMtd+J7/radx3hoV5Cz7loihgG0t9H4rOIk
         8gjTOq0oNVGJ1Hqf8FHbsPH65BQfll79RXxraX3PsK2Ihfu2am0DaqEjyvUQwBKbWDkH
         Uar95Zege8VgBwuYeVpv62cXlyjcp3f2rOcpWtfVXS0oEn/puAvmmd2xi//It7mgiwBV
         /FM/3FyXRLaPT7+M1Hheq2sun/OdX0CqEW8pARly9cdfmJK4xoRmO5nyecLyLeUJ4UX5
         FC1Te1YRPgbOUHoC7Wx4rrocswWBb/zuXUQOo9Z985yKG71rx84EfCBWoBLGyR2U2tkS
         SYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etYHxN3ySLIwR6cL/4LlObYwmD9I/trb9bCtQEgj1mI=;
        b=O5dz7ijhn3FGltz0C9C471y+w9kxEpXk3Hh6le4jnLba+rXNPYX+bML0G4pU8JVss4
         YFbdMYitMS2LXNrrSDszaF/Bw+iupVrC4yaBDytcgF0arbc7eYrx9Oti41j7bIZWrDkH
         bO2V9xpVMiJpkAP69E7Um+405C6YSqOXR0xwoByZmg74lNZ0DSQaUSEY3Nxt8YhejO5b
         1RkP7FOAdh6gUNlCt3BUY0qPL5Sf3mXEDLy4UovhJAztZnv95/e6rBykZ3Se5Y34KewL
         oeVFBf/bcygXeLwBTm5q3J8tjUCOkTPK0NjqYGxyzy4IypO7A1R9W2RcSJl5pN+hD7Lv
         wkWQ==
X-Gm-Message-State: AGi0PuaL8DjOM5OyJABSvizGNySvS3A4Bn/pIcvO2bwYtGmrjcg73Ef0
        CiUO6cb/CFyvhLorDXnjMTmfWQ==
X-Google-Smtp-Source: APiQypJELEN+lza7wUergSkDB14XjiFt+gaaXMuPkWE6i6Jl1gi9geM7ftxaomx0XeS0zRkZgmeGrA==
X-Received: by 2002:a17:90a:2c08:: with SMTP id m8mr30936109pjd.102.1589331330776;
        Tue, 12 May 2020 17:55:30 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p2sm11057428pgh.25.2020.05.12.17.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:55:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: hwlock: qcom: Migrate binding to YAML
Date:   Tue, 12 May 2020 17:54:38 -0700
Message-Id: <20200513005441.1102586-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513005441.1102586-1-bjorn.andersson@linaro.org>
References: <20200513005441.1102586-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate the Qualcomm TCSR mutex binding to YAML to allow validation.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/hwlock/qcom-hwspinlock.yaml      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
new file mode 100644
index 000000000000..71e63b52edd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/qcom-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Hardware Mutex Block
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  The hardware block provides mutexes utilized between different processors on
+  the SoC as part of the communication protocol used by these processors.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sfpb-mutex
+      - qcom,tcsr-mutex
+
+  '#hwlock-cells':
+    const: 1
+
+  syscon:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description:
+      Should be a triple of phandle referencing the TCSR mutex syscon, offset
+      of first mutex within the syscon and stride between each mutex.
+
+required:
+  - compatible
+  - '#hwlock-cells'
+  - syscon
+
+additionalProperties: false
+
+examples:
+  - |
+        tcsr_mutex_block: syscon@fd484000 {
+                compatible = "syscon";
+                reg = <0xfd484000 0x2000>;
+        };
+
+        hwlock {
+                compatible = "qcom,tcsr-mutex";
+                syscon = <&tcsr_mutex_block 0 0x80>;
+
+                #hwlock-cells = <1>;
+        };
+...
-- 
2.26.2

