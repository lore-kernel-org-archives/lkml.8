Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA75C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5D22051A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQbfdZPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgBDLEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:04:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45918 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgBDLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:04:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id a6so22402437wrx.12;
        Tue, 04 Feb 2020 03:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lq/aNd5t/n/SsQ33A9X2QOBbDCCTY/Azoi8wa+8cOTk=;
        b=iQbfdZPctYYFYFe0aUyR/AN3T2OIAlD9LW+pbO2tB5Kd0khUBhrk2VCiZf7Pqzcn1q
         ZYKBmXwwpEX+fBcaqgm3v9nEVGlZhDp5/0hveaBDju6IHVy7jJHxgQoBXqvx/BUdXK25
         8QLroR/cZuEz6eKBdJ3O76fp6mxM1b/2L/GIPOEJQ1z0x8HX1mSNa4rvwy5YRVFZZ/+K
         GdxlxZHJGLzXHoI3BoJjcV03rxvagIv9ZwmauHytttmSrldBrCS5nm/Oz/FSOpUsuzu3
         3XZEh1mksOLi9kmyw6lub+ilm3rG+ALM0aaFk30qBt9aLO1m6//Cs0SwUPvzX1gLU9qv
         bsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lq/aNd5t/n/SsQ33A9X2QOBbDCCTY/Azoi8wa+8cOTk=;
        b=AY5wUr9pQeRa8i2n4Bi1xnBsRvNAKPVI6LIBEQIqVfMuCHUnUVw+6CM0k20OdKleMl
         5Cj+uzUcYFw0P+OHtbrdztZL0iVVSPQYTzQaZ27SIcg4PZj88pucsmUHlxxM72selZKy
         TgvpOslbP+IT1jOVSBtnUbSpqdtFp6Wj9FTs39VQEh7YgRNZxFhbRzBfK0QNsWhGtHFd
         SKki9l1R8z13iDnEqnvrhIqrej+NgQy4YFXLvP7zmBCGm2OP1rEwn1uPQqnetMr9a0S0
         LGK7zs/h8cCFaYQRCbh04DLPGBcgsrP2iAepOhNjyFJAkzLVKt+P/WWBUjQMUXSf8h0h
         MyGg==
X-Gm-Message-State: APjAAAWBo6ihT8IQb/ORuPwdn33UAPVjtBrXndBBhamhvCxKhsGYlrVe
        rVT7Gm+wVymgEb+wtuqrhQk=
X-Google-Smtp-Source: APXvYqw7YrquZWw+fpXAYpAvC1Luli9B6j7sqPME9mNfNKHYuOULgqqGyr10Ngrfrelur6/8Z2xiNw==
X-Received: by 2002:adf:f288:: with SMTP id k8mr23194202wro.301.1580814270682;
        Tue, 04 Feb 2020 03:04:30 -0800 (PST)
Received: from localhost.localdomain (p5B3F65E4.dip0.t-ipconnect.de. [91.63.101.228])
        by smtp.gmail.com with ESMTPSA id y185sm3476935wmg.2.2020.02.04.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 03:04:30 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: regulator: add document bindings for mp5416
Date:   Tue,  4 Feb 2020 12:04:17 +0100
Message-Id: <20200204110419.25933-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204110419.25933-1-sravanhome@gmail.com>
References: <20200204110419.25933-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for mp5416 regulator driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../bindings/regulator/mps,mp5416.yaml        | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
new file mode 100644
index 000000000000..f0acce2029fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mp5416.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power System MP5416 PMIC
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "^pmic@[0-9a-f]{1,2}$"
+  compatible:
+    enum:
+      - mps,mp5416
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4] and LDO[1-4]
+
+    patternProperties:
+      "^buck[1-4]$":
+        allOf:
+          - $ref: "regulator.yaml#"
+        type: object
+
+      "^ldo[1-4]$":
+        allOf:
+          - $ref: "regulator.yaml#"
+        type: object
+
+    additionalProperties: false
+  additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@69 {
+          compatible = "mps,mp5416";
+          reg = <0x69>;
+
+          regulators {
+
+            buck1 {
+             regulator-name = "buck1";
+             regulator-min-microvolt = <600000>;
+             regulator-max-microvolt = <2187500>;
+             regulator-min-microamp  = <3800000>;
+             regulator-max-microamp  = <6800000>;
+             regulator-boot-on;
+            };
+
+            ldo2 {
+             regulator-name = "ldo2";
+             regulator-min-microvolt = <800000>;
+             regulator-max-microvolt = <3975000>;
+            };
+         };
+       };
+     };
+...
-- 
2.17.1

