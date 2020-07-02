Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2BAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0AC208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="neOCc8Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGBVKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBVKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:10:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4CEC08C5C1;
        Thu,  2 Jul 2020 14:10:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dp18so31434889ejc.8;
        Thu, 02 Jul 2020 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BedfZLLtUv8+jct9K4ydZAXp2NUQdx/2FyFkLNGA7s=;
        b=neOCc8Na9y+e/dxihMt1n/W5sPpq0Xa2v/yiLGXRoJpsLIgmilxcjiubzVjRhDZ2i2
         WJMolOqMMfnKwg+XXde8AV/uE5qIjeXvL/tTeRkB053knUpEVbBSJu2bb9mbFLkCVX+z
         Kf0OjPMel/Xmx54HLfdkaPb10ajbyZSz8H/J5l9Wdwxoj9Iix3OZl5Onye/utImcbrOx
         lU42IY+A6/UnUf0WrXbGGZpI61RUDFaFAc9QWDhrC6+kEkLGBVOMeNYeCzKQSX1FifAy
         xw20JrfCt39DvQ1o1GZG8vLy7BjeP3fxld8YO5uEKjuDeDJsdw1fcW49WOlaE+qvNNeE
         fFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BedfZLLtUv8+jct9K4ydZAXp2NUQdx/2FyFkLNGA7s=;
        b=MT2yM3MMOHvPmZ347SRd4eOAOd2AF73mifQxyXGK5I4Benjonvf+8sVFq02DLLZskK
         bJytsC3pmZnBH3VRwlusb7gKS8ahGepE9GchDzp496j8DLSNr7ETXYipJVsEy3PSLl57
         G+iCxS4iTxigjG/3OJg8U/UbGaQBKOsYCerzGqb1xxpAyXUw0E/Fl8EM5/ym2jZA+JCr
         fpX28AdZcGc2YoCCoXvJF0y8UIWUAeJybLvOTnEM3u9BZXfFnFJopJiCnN7c9H/2vqSa
         cxuEhUjalHn8SKPv2JY6HpFx8z7GnydUFZZNRlzhXIoQlHsyr9vX2QG5Pw4IDlqDikYG
         XY0A==
X-Gm-Message-State: AOAM532oEMWln4uidN3jOgmYxxA0hfyIzYSj+j7bpBFNe9raMMC3c59/
        9gj/w7pz8A3Dyy6bxVkiiVE=
X-Google-Smtp-Source: ABdhPJzcFVv+ZyTEeMYFa3T6ppFANThAYYmYUoxagvBjbEslqdeHSaQvfCWeL72bMnXGsLrbsKFC7g==
X-Received: by 2002:a17:906:aac1:: with SMTP id kt1mr30856158ejb.408.1593724239598;
        Thu, 02 Jul 2020 14:10:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:bb9:bc00::fc])
        by smtp.googlemail.com with ESMTPSA id x19sm10176353eds.43.2020.07.02.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 14:10:39 -0700 (PDT)
From:   Christoph Fritz <chf.fritz@googlemail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: regulator: Document bindings for fan53880
Date:   Thu,  2 Jul 2020 23:08:46 +0200
Message-Id: <20200702210846.31659-3-chf.fritz@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200702210846.31659-1-chf.fritz@googlemail.com>
References: <20200702210846.31659-1-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for fan53880 regulator driver.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 .../bindings/regulator/onnn,fan53880.yaml     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/onnn,fan53880.yaml

diff --git a/Documentation/devicetree/bindings/regulator/onnn,fan53880.yaml b/Documentation/devicetree/bindings/regulator/onnn,fan53880.yaml
new file mode 100644
index 000000000000..eb61e04ef852
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/onnn,fan53880.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/onnn,fan53880.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Onsemi FAN53880 PMIC
+
+maintainers:
+  - Christoph Fritz <chf.fritz@googlemail.com>
+
+description: |
+  The FAN53880 is an I2C porgrammable power management IC (PMIC)
+  that contains a BUCK (step-down converter), four low dropouts (LDO)
+  and one BOOST (step-up converter) output. It is designed for mobile
+  power applications.
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+      - onnn,fan53880
+
+  reg:
+    maxItems: 1
+
+  VIN12-supply:
+    description: Input supply phandle(s) for LDO1 and LDO2
+
+  VIN3-supply:
+    description: Input supply phandle(s) for LDO3
+
+  VIN4-supply:
+    description: Input supply phandle(s) for LDO4
+
+  PVIN-supply:
+    description: Input supply phandle(s) for BUCK and BOOST
+
+  regulators:
+    type: object
+    $ref: regulator.yaml#
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts LDO[1-4], BUCK and BOOST
+
+    patternProperties:
+      "^LDO[1-4]$":
+        type: object
+        $ref: regulator.yaml#
+
+      "^BUCK|BOOST$":
+        type: object
+        $ref: regulator.yaml#
+
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
+        pmic@35 {
+            compatible = "onnn,fan53880";
+            reg = <0x35>;
+
+            PVIN-supply = <&fixreg_example_vcc>;
+
+            regulators {
+                BUCK {
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+            };
+       };
+     };
+...
-- 
2.20.1

