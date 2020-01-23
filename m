Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5FC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E52207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZTb5k7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAWVxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:53:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56054 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbgAWVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:53:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so4187903wmj.5;
        Thu, 23 Jan 2020 13:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ja0hiSxowstU3DYbi+J4Zvpbj+cNyzDgc6GiSVzHKjg=;
        b=BZTb5k7mSIAXODFZ2uDgRW3X4vNVHGFSfdHcLdvNJ/3DypcbhAOc6eMQwkcg4NmXvp
         wgJ+q7t+s3U7qpsP+MSyrHjPQxfM8yY+sIWhQ8sdBiSILJweLvUcRnafAAmein3pUOJb
         lI0jAFEOJorJHH0sfDuUofB+xkYfY03flq6L/ff+8t2v4tEt0qyzzBL1SEnuuobLIek+
         oheUW0+PhWaI/zrlfHdPAYi4nI9BYYcFVulm09E/VwTeNHo/CyrUrTQgaBEXExy2l8fo
         Elc0WPc7thyc+QnU/BoMcbj1gXlb60ZMTj0mjEX0iaL51/I4Ltsq9HE2rQAeHqdk0NQp
         FsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ja0hiSxowstU3DYbi+J4Zvpbj+cNyzDgc6GiSVzHKjg=;
        b=LC2DeCiOVwIMAq+3sl9blKog1OqEfXOAYlJS5FLs77FNzo5CQUeuzSWRYMEJDyYHGo
         sG6rMFumhdgDez64kKbH6W9GfkWEcccZS17PsnJQ36RVKrUxmyi/2I0dTIzUtc/CZ2JY
         bcJ7GeWViyxbthxEx2LWidslPmR/02IFrGaSTBuXjiNQ8IBnLp/cZ2B1DL0nuwUEGylR
         BafWitZsdXC9htcfaLs1pOh0PueeDB3+poqoI6Zki2IjScc5DSat+x6dOsUwty/yEDt0
         2zxh8fw3xyXVNP7lsfVjbuLhx9VAga9KtvZGtdn3g8sLRubJNEU+5U1WjcBU0PWN7Jhb
         ussQ==
X-Gm-Message-State: APjAAAUbRVHKKJ+Kc0S3vlwtc4UJmrhJXeCzU5UN6rTAsZFyfPUeGDK2
        kuwL7mf7WHONAh3IctShz+A=
X-Google-Smtp-Source: APXvYqwU629TkB+8VWqE5iMv63ZXWoblipC6XX9HhbVWxzMdWvIJJwB/NXsy6Rs62imNXly3a+Nebw==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr58942wmg.140.1579816425763;
        Thu, 23 Jan 2020 13:53:45 -0800 (PST)
Received: from localhost.localdomain (p5DCFE5A2.dip0.t-ipconnect.de. [93.207.229.162])
        by smtp.gmail.com with ESMTPSA id l15sm4398199wrv.39.2020.01.23.13.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 13:53:44 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9] dt-bindings: regulator: add document bindings for mpq7920
Date:   Thu, 23 Jan 2020 22:53:38 +0100
Message-Id: <20200123215338.11109-1-sravanhome@gmail.com>
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
    Changes on v9 :
      - fixed error reported by dt_binding_check
         "pmic@69: regulators:mps,switch-freq: missing size tag in [[1]]"
    
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
index 000000000000..a682af0dc67e
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
+            mps,switch-freq = /bits/ 8 <1>;
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

