Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491ACC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F26D2467A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f01L+ITZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUTYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:24:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39621 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgAUTYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:24:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so4610579wrt.6;
        Tue, 21 Jan 2020 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d0px2i8+1RnbTOMeb6bSQy20/g4X1fdKW2WT1DhnaIc=;
        b=f01L+ITZtZQnYqNIoitmaZkjZI5eBo5Wo/P2W3JB3e3nK7fJYwwZKdXPJCdr66V6Lz
         YaNNMOeXa0raTDdJbpDUQPVpEoKgHiB+fe3fJWn6YDMamXwSbXIAaLtNefPZ3OuQoJB+
         XqSLkXuXp2fGZQPg56dya8vg4P8SeCDFXbssV54DM7BPs01XlJvLTixLe5S8SSsVi0Lz
         pLyH8TebcZ12YMZVdX0hYefWZjSmVurBomV6qBTRU7L6P1d1ICheUkuzLdRkK+KSBUdW
         Sru3hltXi+3gQAXVcLGPvDbRDsHlIRJseF2Mm8+4Cm3MLfu7sURrb942D9TM9Cx6EHDf
         LuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d0px2i8+1RnbTOMeb6bSQy20/g4X1fdKW2WT1DhnaIc=;
        b=ldv1vpdzXLfbNMOdqX0eqqmOCmnThbxRr4d2zNrCoG/X+m6bP6rnrLNuGIQpDpHoGG
         iAqyR5zl2qOyiqA4hSFhQtVR8hNkkIlrWxG5Uya9pPtq7YnIAepss+R1hDwey059mvWU
         Z1ZbDZDxTFrnM4ppT5+8UJi4mNlAZOjynyNI3zVk4PLk0uy7NYS/DT2B1SBBviErNzfq
         d/5XGXozbddScDipreA8/qbKDcLmJOdzSzDVkg0590MiCIcYJbg2ulCIAp6SM3OhDO4b
         GkoAt3JtlmLLVVcmQTE3k36ihrbolYiblQ3hWTIPItSKJoAEUMFPSPPZMeRZn0daltZH
         BA/Q==
X-Gm-Message-State: APjAAAXXGZSQ7H6Vc9tpH193F3hS6bWmzQzVSo8M4Mh0MwTS+PGGCTO0
        tZ/scFi0MsV1QsseCEy9fjk=
X-Google-Smtp-Source: APXvYqwLqk8ISBzNTYObgq4JlUegGB200/Ok27JHRpxFzpP5B4fMvG40Odn5sNRBHmQ41SUfOnLiwg==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr6843387wrn.5.1579634655451;
        Tue, 21 Jan 2020 11:24:15 -0800 (PST)
Received: from localhost.localdomain (p5B3F62F0.dip0.t-ipconnect.de. [91.63.98.240])
        by smtp.gmail.com with ESMTPSA id o1sm53401333wrn.84.2020.01.21.11.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 11:24:14 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7] dt-bindings: regulator: add document bindings for mpq7920
Date:   Tue, 21 Jan 2020 20:24:05 +0100
Message-Id: <20200121192405.25382-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for mpq7920 regulator driver.
Example bindings for mpq7920 are added.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---

Notes:
    Changes on v7 :
      - added regualtors child-node under patternProperties, added required
      - mps,buck-ovp-disable is not common property, regulator subsystem provides
        only over current protection support.

 .../bindings/regulator/mps,mpq7920.yaml       | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
new file mode 100644
index 000000000000..d853690f34c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mpq7920.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power System MPQ7920 PMIC
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+      - mps,mpq7920
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    allOf:
+      - $ref: regulator.yaml#
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
+
+    properties:
+      mps,switch-freq:
+        $ref: "/schemas/types.yaml#/definitions/uint8"
+        enum: [ 0, 1, 2, 3 ]
+        default: 2
+        description: |
+          switching frequency must be one of following corresponding value
+          1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
+
+    patternProperties:
+      "^ldo[1-4]$":
+        type: object
+        allOf:
+          - $ref: regulator.yaml#
+
+      "^ldortc$":
+        type: object
+        allOf:
+          - $ref: regulator.yaml#
+
+      "^buck[1-4]$":
+        type: object
+        allOf:
+          - $ref: regulator.yaml#
+
+        properties:
+          mps,buck-softstart:
+            $ref: "/schemas/types.yaml#/definitions/uint8"
+            enum: [ 0, 1, 2, 3 ]
+            description: |
+              defines the soft start time of this buck, must be one of the following
+              corresponding values 150us, 300us, 610us, 920us
+
+          mps,buck-phase-delay:
+            $ref: "/schemas/types.yaml#/definitions/uint8"
+            enum: [ 0, 1, 2, 3 ]
+            description: |
+              defines the phase delay of this buck, must be one of the following
+              corresponding values 0deg, 90deg, 180deg, 270deg
+
+          mps,buck-ovp-disable:
+            type: boolean
+            description: |
+              disables over voltage protection of this buck
+
+      additionalProperties: false
+    additionalProperties: false
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
+          compatible = "mps,mpq7920";
+          reg = <0x69>;
+
+          regulators {
+            mps,switch-freq = <1>;
+
+            buck1 {
+             regulator-name = "buck1";
+             regulator-min-microvolt = <400000>;
+             regulator-max-microvolt = <3587500>;
+             regulator-min-microamp  = <460000>;
+             regulator-max-microamp  = <7600000>;
+             regulator-boot-on;
+             mps,buck-ovp-disable;
+             mps,buck-phase-delay = /bits/ 8 <2>;
+             mps,buck-softstart = /bits/ 8 <1>;
+            };
+
+            ldo2 {
+             regulator-name = "ldo2";
+             regulator-min-microvolt = <650000>;
+             regulator-max-microvolt = <3587500>;
+            };
+         };
+       };
+     };
+...
-- 
2.17.1

