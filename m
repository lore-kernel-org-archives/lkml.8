Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0F520885
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O76nyJuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHNP1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgHNP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:27:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C4C061384;
        Fri, 14 Aug 2020 08:27:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kr4so4565608pjb.2;
        Fri, 14 Aug 2020 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H3Sj2RA4VzKEVF5wDfAwtb0zeDgeFHLqIYqBkdSYJfs=;
        b=O76nyJuh6dYc3AfGQiI2e4GIdFCY3x7gmOVCCsTTQV0lAgkJw+1y/MMb5FedAKzsuo
         aj/CwOywfjMuI8YUACO2TJpCrLKyOhQbe/Wa8j5jqTkaU4ckLZolvTt1GHcpR2QKdxry
         j/zzN5BU+cbWzQ6Lk7AAcl9CQE49t8MsuQDTQJqSItqVZa2gSO5BGYVfSxIeUXCpQ1xR
         0KlwM4wclq7JMyAFpH2Pa3zn0ZM4CrUryyzn30NfR6jJhlyMyhKlhHzBOjt8eqQaoLjh
         e3gnB4ho7UILB7rgWRwLuy7oBJ/FhpprDcMUDGoPhyE9Kt2nhy41OA2NfYNHW2KgSk3q
         aIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H3Sj2RA4VzKEVF5wDfAwtb0zeDgeFHLqIYqBkdSYJfs=;
        b=Bs84XP1lrwRV8xJP7RZJduyWFXlNHNHtI9d6pf/bZBEN26kw8hie+6867td7dnI69E
         EikQzsEWNML0DsxRloya0h+HCjdx2ihxRVoZycSpwsNMLyO0T0Mg0NzslNW8Fd2gGN8y
         Tq1w4PJ6ibBJvnroX3GdCjEs/wggPhOwPHE8sqDon/Nl1iirjkfTu6DldJwRAcCUmcXD
         ThQamZ+FuiO2aEOpOjfxDLt2KLnfLdjTtpLhzF84yqGh6w2BdaepF+dheBAKLt9k+dgh
         IzZglDf8SSkKjLRz7IsDKAzxZPeJNWXOj2g+pvZczXogus6Jp2n6KbC7vzCHp/prPeOl
         Yoaw==
X-Gm-Message-State: AOAM533de9J8dAPZbC/BWjozZVzbsFVRuC+b/NTV+UI9FQX4GKB0uS7M
        3rtglpzSv7nBiP0pEJXXlxmfz14Scuj/nA==
X-Google-Smtp-Source: ABdhPJy07YWFlf32d911u1V/Z3Dit1CKk0fwAUiZ1rNlw48UgAyEdE/vzK+F1KnB6yLxG345YBvwng==
X-Received: by 2002:a17:90b:2092:: with SMTP id hb18mr2805438pjb.118.1597418851374;
        Fri, 14 Aug 2020 08:27:31 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.91])
        by smtp.gmail.com with ESMTPSA id e29sm9746680pfj.92.2020.08.14.08.27.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 08:27:30 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] regulator: rt4801: Add DT binding documentation
Date:   Fri, 14 Aug 2020 23:27:04 +0800
Message-Id: <1597418824-15906-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597418824-15906-1-git-send-email-u0084500@gmail.com>
References: <1597418824-15906-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add a devicetree binding documentation for the rt4801 regulator driver.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rt4801-regulator.yaml        | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
new file mode 100644
index 00000000..28d30e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt4801-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4801 Display Bias regulators
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Regulator nodes should be named to DSVP and DSVN. The
+  definition for each of these nodes is defined using the standard
+  binding for regulators at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4801H/DS4801H-00.pdf
+
+#The valid names for RT4801 regulator nodes are:
+#DSVP, DSVN
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt4801
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIOs to use to enable DSVP/DSVN regulator.
+      The first one is ENP to enable DSVP, and second one is ENM to enable DSVN.
+      Number of GPIO in the array list could be 1 or 2.
+      If only one gpio is specified, only one gpio used to control ENP/ENM.
+      Else both are spefied, DSVP/DSVN could be controlled individually.
+      Othersie, this property not specified. treat both as always-on regulator.
+    minItems: 1
+    maxItems: 2
+
+patternProperties:
+  "^DSV(P|N)$":
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single display bias regulator.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties:
+  - enable-gpios
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rt4801@73 {
+            compatible = "richtek,rt4801";
+            reg = <0x73>;
+            enable-gpios = <&gpio26 2 0>, <&gpio26 3 0>;
+
+            dsvp: DSVP {
+                regulator-name = "rt4801,dsvp";
+                regulator-min-microvolt = <4000000>;
+                regulator-max-microvolt = <6000000>;
+                regulator-boot-on;
+            };
+            dsvn: DSVN {
+                regulator-name = "rt4801,dsvn";
+                regulator-min-microvolt = <4000000>;
+                regulator-max-microvolt = <6000000>;
+                regulator-boot-on;
+            };
+
+        };
+    };
-- 
2.7.4

