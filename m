Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC10C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944A920848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436289;
	bh=G3cyapIRwKdMmhugpqtvAsKyZAKHE9ncoBZFqld0HmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=osXn7NhFp5pJHHIBspZZDmrpqXEhKv4dgmSHUlET+H65FuB+XNUT21QJb+NzD3YGx
	 E799/sCHJTmdlZ0CE+JJ3kzhgN6AWx+HYh1IC2VzQVqKTK7mfFJUlJWJOg3ecK1+ey
	 RjUxN5W4NoEBOOObspFlzn56IMQ7XhNJZnFkSLCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgBKPv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:51:28 -0500
Received: from foss.arm.com ([217.140.110.172]:48814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbgBKPv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:51:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 006651045;
        Tue, 11 Feb 2020 07:51:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79A833F68E;
        Tue, 11 Feb 2020 07:51:26 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:51:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     broonie@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, mchehab+samsung@kernel.org,
        robh+dt@kernel.org, sravanhome@gmail.com
Subject: Applied "dt-bindings: regulator: add document bindings for mp5416" to the regulator tree
In-Reply-To: <20200204110419.25933-2-sravanhome@gmail.com>
Message-Id: <applied-20200204110419.25933-2-sravanhome@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: add document bindings for mp5416

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 65c38513528ffe673a0a9568593b475b16a7031c Mon Sep 17 00:00:00 2001
From: Saravanan Sekar <sravanhome@gmail.com>
Date: Tue, 4 Feb 2020 12:04:17 +0100
Subject: [PATCH] dt-bindings: regulator: add document bindings for mp5416

Add device tree binding information for mp5416 regulator driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200204110419.25933-2-sravanhome@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

