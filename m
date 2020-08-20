Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89682076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmbca0gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHTHyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgHTHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:53:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92CAC061757;
        Thu, 20 Aug 2020 00:53:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so633310pjr.0;
        Thu, 20 Aug 2020 00:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L6XcNPt3VpQMDvZ0mNUdfcDjhf2wDDj8sz3vu9Nex4s=;
        b=Rmbca0gZkTga9MvR06LWAq4amNuEK44vVuzhKpGlOK66VbqaaQBcLcyZDHaacflRoX
         yMT92l+XipUiWyeRzF6Nr4iAWutE2EVR94uf8AooJr5QbCeXkVaguK4JHZqmKAcMheQy
         wBL6u1Qpm/Jc0H/DuKGaTJd4LjXghUXF5yS+Ywg35yfpnLdurC04ysrmuR17HNAh4Vzs
         JauwEupUVRAvoJVcPEURUOt2PVtQVYn2q7oWPXx86UUsEwSOKYK00VTZ40sZGIFIVtuY
         7zzxXIq/WOTfEtr7hRypMYrGO7nkgOGKy9Ckn2giVnMsiwfafrTUvxdcwCwGKAz7N0Xp
         iMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L6XcNPt3VpQMDvZ0mNUdfcDjhf2wDDj8sz3vu9Nex4s=;
        b=WDpJHL/FmqhzejRwWJQuxb3/RbAvwr2YQf9ZgEDBJcy+gBacaNWrtfAlj9DXXr/6Gi
         x8EDN2FVIx5O+fFrouMFQo+Kf7U3I+maAUE2BFnGYKGMaOG0BPUaEezeMUiK1f9ZNry9
         Li0Wl05rlfL+guqCpuZZDtx/ZpaP4D3VQTJa2lY1mqmZ+Mm4spkKz602Qs4tdZdaox5/
         2E8djOMv7G4KRXQF5ruT4zfKeP2G3tE6p8Ahi8o4eDJ/rMaJQRgzDlTyYUuDLlrUYgv+
         sw7xLkeAuBE8BZrPe8e3L0XuiNa2msAW04uYTEceZXQsrI/YWkgep4d2kD1ixAdY8QhE
         3cVw==
X-Gm-Message-State: AOAM530ss3WD2+PfukCMMMj7fSTOVB3Vkv822CppreH48ydRKj819JFe
        oyIuHW6M2eBC6j5HuaE2pxc=
X-Google-Smtp-Source: ABdhPJyJ6SpAgxr95yJjkgAkUw8N+YqFNffE0rdoXSym5kZQv1YxN7wJw739dZQmvbBPN5uP1snR/g==
X-Received: by 2002:a17:902:59dd:: with SMTP id d29mr1689481plj.170.1597910037468;
        Thu, 20 Aug 2020 00:53:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id q71sm1273832pjq.7.2020.08.20.00.53.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:53:56 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Subject: [PATCH v3 2/2] regulator: mt6360: Add DT binding documentation
Date:   Thu, 20 Aug 2020 15:53:42 +0800
Message-Id: <1597910022-22617-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add a devicetree binding documentation for the mt6360 regulator driver.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 .../bindings/regulator/mt6360-regulator.yaml       | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
new file mode 100644
index 0000000..bd66754
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mt6360-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6360 Regulator from MediaTek Integrated
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  list of regulators provided by this controller, must be named
+  after their hardware counterparts buck1/2 or ldo1/2/3/5/6/7
+
+properties:
+  compatible:
+    const: mediatek,mt6360-regulator
+
+  LDO_VIN3-supply:
+    description: Input supply phandle(s) for LDO3
+
+patternProperties:
+  "^buck[12]$":
+    $ref: "regulator.yaml#"
+
+  "^ldo[123567]$":
+    $ref: "regulator.yaml#"
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+    regulator {
+      compatible = "mediatek,mt6360-regulator";
+      LDO_VIN3-supply = <&BUCK2>;
+      buck1 {
+        regulator-compatible = "BUCK1";
+        regulator-name = "mt6360,buck1";
+        regulator-min-microvolt = <300000>;
+        regulator-max-microvolt = <1300000>;
+        regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+             MT6360_OPMODE_LP
+             MT6360_OPMODE_ULP>;
+      };
+      BUCK2: buck2 {
+        regulator-compatible = "BUCK2";
+        regulator-name = "mt6360,buck2";
+        regulator-min-microvolt = <300000>;
+        regulator-max-microvolt = <1300000>;
+        regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+             MT6360_OPMODE_LP
+             MT6360_OPMODE_ULP>;
+      };
+      ldo6 {
+        regulator-compatible = "LDO6";
+        regulator-name = "mt6360,ldo6";
+        regulator-min-microvolt = <500000>;
+        regulator-max-microvolt = <2100000>;
+        regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+             MT6360_OPMODE_LP>;
+      };
+      ldo7 {
+        regulator-compatible = "LDO7";
+        regulator-name = "mt6360,ldo7";
+        regulator-min-microvolt = <500000>;
+        regulator-max-microvolt = <2100000>;
+        regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+             MT6360_OPMODE_LP>;
+      };
+      ldo1 {
+        regulator-compatible = "LDO1";
+        regulator-name = "mt6360,ldo1";
+        regulator-min-microvolt = <1200000>;
+        regulator-max-microvolt = <3600000>;
+        regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+             MT6360_OPMODE_LP>;
+      };
+        ldo2 {
+        regulator-compatible = "LDO2";
+        regulator-name = "mt6360,ldo2";
+        regulator-min-microvolt = <1200000>;
+        regulator-max-microvolt = <3600000>;
+        regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+             MT6360_OPMODE_LP>;
+      };
+      ldo3 {
+        regulator-compatible = "LDO3";
+        regulator-name = "mt6360,ldo3";
+        regulator-min-microvolt = <1200000>;
+        regulator-max-microvolt = <3600000>;
+        regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+             MT6360_OPMODE_LP>;
+      };
+      ldo5 {
+        regulator-compatible = "LDO5";
+        regulator-name = "mt6360,ldo5";
+        regulator-min-microvolt = <2700000>;
+        regulator-max-microvolt = <3600000>;
+        regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+             MT6360_OPMODE_LP>;
+      };
+    };
+...
-- 
2.7.4

