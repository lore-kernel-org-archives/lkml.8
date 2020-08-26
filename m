Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19040C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0B6206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnrqKy6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgHZKug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgHZKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:49:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E3C061757;
        Wed, 26 Aug 2020 03:49:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so706976plr.0;
        Wed, 26 Aug 2020 03:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fNxSfFiY1tuDXOCkxl1KwXHZGTRpS8Bl3VyT4+22yAo=;
        b=LnrqKy6kUV8a9EKcK25PoRKI9k6qjlOBP+xLiHlzbrZettbU0f4DgQtgLdNC70ibBC
         lK/Ehv7u5BEtVEnpEdZF6c+jdXIq2UTFBgNmFEFhR2dKt5ec+qQty6/Dmj0gkThl8LTh
         /XVDkNNHvdJhaRRzHFx3w45IZP6adC8/MPVU66BJ8ZdCGpvIBBdpzs3TX3f0vDkuCRSX
         +BymyRY9VnnzxBQqnNpejZJhjsVSu9bvBq9+GMcZ2UtRlVSvmRTdTIfm2Db+dAZyktGX
         JQXQRNrIACVJV61C9+SiGGI/N7xv/5h8MVQBneqoHKWQVJnpu2IsAjW7X5rZ2oOUZ/4m
         GTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fNxSfFiY1tuDXOCkxl1KwXHZGTRpS8Bl3VyT4+22yAo=;
        b=CyWMzrMRgjHMqWp//p+g+V2mUa48DlBc054M6xDN218LN6FwC1crJG37EKaetiMfU+
         wi4E1dIf3rBRVFIto7rgWsG4Q8bo6uWk+2H3tQOS22zkrVWTb0lJb7d8fkxwy78DCpKV
         tXZ3TmV9YGqR8bW20oUET6oWxIVbbEWxId4Pu59VGCRwCBoQCR6yscIEJUZQwkCatIYf
         IlmDimh4SMWnfC+NR78veSGwnGlJfAbDO6QaXFwqdl1ml+xmIU+a0RaHfCi8R8XoAywG
         lmdt6oFzs1tH2JP/gduCVvUhtKiCW0Ubc5jcserpLSKQM3QenHezdcSkHkBouvWDcWsK
         sm4g==
X-Gm-Message-State: AOAM530srJ8GKapvrErirSr1wc1ssToY6dXaa9tKBPT+nen6bAUAmZEZ
        HHasHLpi6IT+y4DU7PQg0rc=
X-Google-Smtp-Source: ABdhPJwtA/oSnHx0Arv0mc9TbHEnQGYbVoG5raqyiIQx3CBTlOSm4BqHHLhZxJ02XDVfMRSXGVAX6Q==
X-Received: by 2002:a17:90b:410d:: with SMTP id io13mr5052761pjb.63.1598438982873;
        Wed, 26 Aug 2020 03:49:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:2197:d2eb:7e49:dfa1:a882])
        by smtp.gmail.com with ESMTPSA id d127sm2540349pfc.175.2020.08.26.03.49.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 03:49:42 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH v4 2/2] dt-bindings: regulator: mt6360: Add DT binding documentation
Date:   Wed, 26 Aug 2020 18:49:18 +0800
Message-Id: <1598438958-26802-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598438958-26802-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1598438958-26802-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add a devicetree binding documentation for the mt6360 regulator driver.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 .../bindings/regulator/mt6360-regulator.yaml       | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
new file mode 100644
index 0000000..a462d99
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
@@ -0,0 +1,113 @@
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
+  LDO_VIN1-supply:
+    description: Input supply phandle(s) for LDO1/2/3
+  LDO_VIN2-supply:
+    description: Input supply phandle(s) for LDO5
+  LDO_VIN3-supply:
+    description: Input supply phandle(s) for LDO6/7
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

