Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC7BC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B25824673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veCaAinS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgAVRkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:40:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37544 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:40:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so8293657wru.4;
        Wed, 22 Jan 2020 09:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YCuxX5B+LZk2gzay8QkT0VIU8ORpD+VFHNEMbDjpEFo=;
        b=veCaAinSqOBpse+I9VPosGO7eE2nZcVQImF9+BOObpekwaHkvKVeARUB+VQJtMbYUi
         1/zWxDBFT15mvS+bQbMBuDbrG2r7MrdAHvmbxOTy6heZDCmlwSh3xeHwDLSO8IzD2qGH
         DSD5qVb65hZMggHD10ZyaPbrTo+xVqN9oJotzWC4wa/HUEPwzZnu8xQfNDkoJlkCt1G4
         Nx/2bdcX6tOpr3562ls7wJwgpzFrV6tNXlzzjEr6BFza8Rer6Zb9FMFQc5kJCehg6/an
         2qQNdnt60UTR+WKcS4qiYXnALLvBHme+7OtHOPsc3AtPJRU+q/AcNtzMPeHlxx6aXQOo
         /iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YCuxX5B+LZk2gzay8QkT0VIU8ORpD+VFHNEMbDjpEFo=;
        b=ubz0ysntyawGnjXvS+Yh/aCxZcWIjnIb6RzoC09iLXpN3nPtzeVFYnD5ug87AEnFsX
         JXeb4VvhM8xXtibQl8rrVpE8eG/4UWb+pIBHVWMHHMDuhbcAr7/vw2uuvN0RtKfwxvWk
         niU6TWlKr1l2esgYhU8U18yy190y9c4nj2+Hj0eDWzUdZVEBtBxCRNyrvCVoErux+dJy
         gkTohMPHX8aN0HenD//ZesP8+0AeFLkzhwprWSGmXpsSn+69TivZTY38lEGdpREBEFnr
         TETD0Jttd9Hrx+d/zD/fictlAUl3E3/l3z3M4dD2svxFtYQIMOHZuCTdbn5zAmXJIPwl
         mDsQ==
X-Gm-Message-State: APjAAAUv+RoLBoaXyEJbJGwiD/fskHPJMXmSgkAQRzv5pFhKojby3S4C
        vMicyltrnfbbgv0G7qugb+o=
X-Google-Smtp-Source: APXvYqyfvVqyU0v1yQIEPuBvGH0I79kAaZZSlKr6qK/oILeEtwZ2pMfbJjabHSUV+fO7SkJBmB6UpQ==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr12213836wrm.223.1579714816908;
        Wed, 22 Jan 2020 09:40:16 -0800 (PST)
Received: from localhost.localdomain (p5DCFF1C1.dip0.t-ipconnect.de. [93.207.241.193])
        by smtp.gmail.com with ESMTPSA id r68sm4684664wmr.43.2020.01.22.09.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 09:40:16 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8] dt-bindings: regulator: add document bindings for mpq7920
Date:   Wed, 22 Jan 2020 18:40:05 +0100
Message-Id: <20200122174005.17257-1-sravanhome@gmail.com>
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
    Changes on v8 :
      - fixed error reported by dt_binding_check
    
    Changes on v7 :
      - added regualtors child-node under patternProperties, added required
      - mps,buck-ovp-disable is not common property, regulator subsystem provides
        only over current protection support.

 .../bindings/regulator/mps,mpq7920.yaml       | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
new file mode 100644
index 000000000000..f2ace074f444
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -0,0 +1,121 @@
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
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint8"
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
+            allOf:
+              - $ref: "/schemas/types.yaml#/definitions/uint8"
+            enum: [ 0, 1, 2, 3 ]
+            description: |
+              defines the soft start time of this buck, must be one of the following
+              corresponding values 150us, 300us, 610us, 920us
+
+          mps,buck-phase-delay:
+            allOf:
+              - $ref: "/schemas/types.yaml#/definitions/uint8"
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

