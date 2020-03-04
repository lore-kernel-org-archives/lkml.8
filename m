Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF0BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C884B2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583331201;
	bh=6+11AtIN18pluPUxqh7ve0IXf9orA2eITm8Z3if7COg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=BMY+DjlIHvkkS4E/poJJzeuZi2HuWMEPKVN9V4yisEu126cOIPA+Qc3NENrD2GXTf
	 YUyUQSKxHlR28HS1ZqPiXscrSBkYkUKtzsepYdYKFeooaRQ1KwQnX4HINUdltRglq5
	 RwTEXG68cYu2X6ERyIgyRpGsJnhzEMbV6WEYYfFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgCDONV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:13:21 -0500
Received: from foss.arm.com ([217.140.110.172]:34832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbgCDONU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:13:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EFFD31B;
        Wed,  4 Mar 2020 06:13:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84ABA3F6CF;
        Wed,  4 Mar 2020 06:13:19 -0800 (PST)
Date:   Wed, 04 Mar 2020 14:13:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robh+dt@kernel.org
Subject: Applied "regulator: vqmmc-ipq4019-regulator: add binding document" to the regulator tree
In-Reply-To:  <20200122134023.1467806-1-robert.marko@sartura.hr>
Message-Id:  <applied-20200122134023.1467806-1-robert.marko@sartura.hr>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: vqmmc-ipq4019-regulator: add binding document

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From e177440a1bba09d3ff0b2f992d03dbab2640746f Mon Sep 17 00:00:00 2001
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 22 Jan 2020 14:40:24 +0100
Subject: [PATCH] regulator: vqmmc-ipq4019-regulator: add binding document

This patch adds bindings for the Qualcomm IPQ4019 VQMMC SD LDO driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Message-Id: <20200122134023.1467806-1-robert.marko@sartura.hr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../regulator/vqmmc-ipq4019-regulator.yaml    | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml b/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
new file mode 100644
index 000000000000..d1a79d2ffa1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/vqmmc-ipq4019-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ4019 VQMMC SD LDO regulator
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  Qualcomm IPQ4019 SoC-s feature a built a build SD/EMMC controller,
+  in order to support both 1.8 and 3V I/O voltage levels an LDO
+  controller is also embedded.
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: qcom,vqmmc-ipq4019-regulator
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    regulator@1948000 {
+      compatible = "qcom,vqmmc-ipq4019-regulator";
+      reg = <0x01948000 0x4>;
+      regulator-name = "vqmmc";
+      regulator-min-microvolt = <1500000>;
+      regulator-max-microvolt = <3000000>;
+      regulator-always-on;
+      status = "disabled";
+    };
+...
-- 
2.20.1

