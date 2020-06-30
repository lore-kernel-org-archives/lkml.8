Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C2FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550DF206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mYAMjLBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgF3Swk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgF3Swh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:52:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9BC061755;
        Tue, 30 Jun 2020 11:52:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dr13so21706231ejc.3;
        Tue, 30 Jun 2020 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BedfZLLtUv8+jct9K4ydZAXp2NUQdx/2FyFkLNGA7s=;
        b=mYAMjLBw/2y0mr1jSH/zEFiLJo8bQfT5+BFFD3Qwwq1rEDtfLtSZIW24XUh5Sv1xTk
         H+4wCzfvrI3uccwgxHbVSThPkzEptCuszQuiyVkbte9U/4HLbdZo/h8f4gi7s4ED9RXm
         ka8huNfGNCbdjvoeVpjG99TUXoZgf978BwsfGZ9FAGyDmoYV+uXPT/vohmujMBmABuMM
         e+CL9NfimYNVAxEmHXXJm0mPusi5hDGX4zuOvmPYEITIt5VSRZqeQbFHKtlaePpa7Qxk
         k0uI1ndIdhcvJnQ/Biw2Jzq3P/uA1GWWRbY3XuvEBMXU0hMyD4QsphiKtqhB7byba+zq
         ux5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BedfZLLtUv8+jct9K4ydZAXp2NUQdx/2FyFkLNGA7s=;
        b=itdikeyNyEdffixDvvTFp45LHuVvxz6+WSFb+DpxadXXo6aG9Hkr3pG5nRF2uSjsGn
         aRkMVm0c1MSh430PtNO3cA9ZiqscTVSP8F1EnMqQ0ySsVgiasctCVwR8mwYKfif3Gt/P
         LFaway0vOhGm19j76C0qaodYGYTzOkJ6JAPMMd8WVwy7q4b1o2e1Gxi/KFtnJ6w5EL0u
         tH43U77NH0MwXwCmDwiEdp4hOP7i5Fbui0A2Q/KuylwpiELjz+xFi4bZr/r0IleTQSqP
         K0Y3w8qaHfW7jLjKAEvnFvXbGZj+1w56S/dabz3XvOjkVyzHCSGTq++i5QHK0CfdMOBF
         ikAw==
X-Gm-Message-State: AOAM5311YC9BtcIyHs15l8p2L7MSN2Eqyy91S3mjd7rRigugQj+14JRl
        KMta9fxcKSUgFxKh3HW8+etggbpn
X-Google-Smtp-Source: ABdhPJx+eyl15x1xla7BzsqfkghEAqbQz4JHMkS3HsD9/rLOH4IXqQCIaSN9Qs3vwzkJwBM5ZUYhqQ==
X-Received: by 2002:a17:906:c35a:: with SMTP id ci26mr4299839ejb.451.1593543155481;
        Tue, 30 Jun 2020 11:52:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:bb9:bc00::fc])
        by smtp.googlemail.com with ESMTPSA id e16sm2677238ejt.14.2020.06.30.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:52:35 -0700 (PDT)
From:   Christoph Fritz <chf.fritz@googlemail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: regulator: Document bindings for fan53880
Date:   Tue, 30 Jun 2020 20:52:03 +0200
Message-Id: <20200630185203.22882-3-chf.fritz@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630185203.22882-1-chf.fritz@googlemail.com>
References: <20200630185203.22882-1-chf.fritz@googlemail.com>
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

