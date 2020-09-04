Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE87C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942502087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599215177;
	bh=y+HaSJ5DamzNsnw7uVNpEE+xv+fRAimb14ck/lGaCO4=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=JpMK4kmux3cbqeUU4cpFTzJUXh48T/4ddiy7NmGFzL0+HHruXX3/35LNdS/04mGW9
	 7wWryyeu+fqN5+YzXS3JlxXCDTF1BAjyTnBauVId04i4UtgayMVtWX4vI6/qJ0cYDI
	 pQ/1C3TPLqDEDiR3QsM9N0qSX5h7p6B9pW1E4jMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgIDK0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729946AbgIDKXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:37 -0400
Received: from mail.kernel.org (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4C3208CA;
        Fri,  4 Sep 2020 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215016;
        bh=y+HaSJ5DamzNsnw7uVNpEE+xv+fRAimb14ck/lGaCO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0uz0FWDNSvGb6Wa+ZBWKhAj11Me3AqpMrp0H3OS1n/3K7YJpvhMrt/JDW76CYgQm
         uASo5tZ4pbLWP0JImb96Wfi0k1MnYQ22Ht+FqGMKNvYonbMhxMgi1Q8YNkDRQUVshC
         yLfDrW8b47TrQ8I2izgSCq7hTyRfhUo2BGYPSX8o=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kE8sX-005SvI-RY; Fri, 04 Sep 2020 12:23:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC 06/10] dt-bindings: phy: convert phy-kirin970-usb3.txt to yaml
Date:   Fri,  4 Sep 2020 12:23:28 +0200
Message-Id: <b4eed7f3526f38e79e19220120cf2206999cc758.1599214329.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599214329.git.mchehab+huawei@kernel.org>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new YAML for this physical layer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/phy/hisilicon,hi3670-usb3.yaml   | 72 +++++++++++++++++++
 .../bindings/phy/phy-hi3670-usb3.txt          | 25 -------
 2 files changed, 72 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
new file mode 100644
index 000000000000..125a5d6546ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/hisilicon,hi3670-usb3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Kirin970 USB PHY
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+description: |+
+  Bindings for USB3 PHY on HiSilicon Kirin 970.
+
+properties:
+  compatible:
+    const: hisilicon,hi3670-usb-phy
+
+  "#phy-cells":
+    const: 0
+
+  hisilicon,pericrg-syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle of syscon used to control iso refclk.
+
+  hisilicon,pctrl-syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle of syscon used to control usb tcxo.
+
+  hisilicon,sctrl-syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle of syscon used to control phy deep sleep.
+
+  hisilicon,eye-diagram-param:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Eye diagram for phy.
+
+  hisilicon,tx-vboost-lvl:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TX level vboost for phy.
+
+required:
+  - compatible
+  - hisilicon,pericrg-syscon
+  - hisilicon,pctrl-syscon
+  - hisilicon,sctrl-syscon
+  - hisilicon,eye-diagram-param
+  - hisilicon,tx-vboost-lvl
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      usb3_otg_bc: usb3_otg_bc@ff200000 {
+        compatible = "syscon", "simple-mfd";
+        reg = <0x0 0xff200000 0x0 0x1000>;
+
+        usb_phy {
+          compatible = "hisilicon,hi3670-usb-phy";
+          #phy-cells = <0>;
+          hisilicon,pericrg-syscon = <&crg_ctrl>;
+          hisilicon,pctrl-syscon = <&pctrl>;
+          hisilicon,sctrl-syscon = <&sctrl>;
+          hisilicon,eye-diagram-param = <0xfdfee4>;
+          hisilicon,tx-vboost-lvl = <0x5>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
deleted file mode 100644
index 2fb27cb8beaf..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Hisilicon Kirin970 usb PHY
------------------------
-
-Required properties:
-- compatible: should be "hisilicon,hi3670-usb-phy"
-- #phy-cells: must be 0
-- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
-- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
-- hisilicon,sctrl-syscon: phandle of syscon used to control phy.
-- hisilicon,usb31-misc-syscon: phandle of syscon used to control phy.
-- eye-diagram-param: parameter set for phy
-- usb3-phy-tx-vboost-lvl: parameter set for phy
-Refer to phy/phy-bindings.txt for the generic PHY binding properties
-
-Example:
-	usb_phy: usbphy {
-		compatible = "hisilicon,hi3670-usb-phy";
-		#phy-cells = <0>;
-		hisilicon,pericrg-syscon = <&crg_ctrl>;
-		hisilicon,pctrl-syscon = <&pctrl>;
-		hisilicon,sctrl-syscon = <&sctrl>;
-		hisilicon,usb31-misc-syscon = <&usb31_misc>;
-		eye-diagram-param = <0xFDFEE4>;
-		usb3-phy-tx-vboost-lvl = <0x5>;
-	};
-- 
2.26.2

