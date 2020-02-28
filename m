Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75780C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A82469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gRPlwvDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgB1P1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:27:18 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35210 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbgB1P1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:27:18 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SFJEm1017901;
        Fri, 28 Feb 2020 16:27:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=foC7UMQQei+fxPNT3xu96FfGnOI0+aWf4na6mkoAtxA=;
 b=gRPlwvDCj3eUqZxk0dQ6eZb5cH4fCPEQAC6A6lLeeouWIsE+ixsbHn2qICSp8+48N7fU
 +5JXCaiHNk2wHwaudJUmyQwScg2XGdVIkooqHH9LbMhx0Xzpu80l3M7Prk3qvGHqyCNM
 kA2qAauhwiqWfN0NAmc31wP/Tmg79mI4X2GEFz6of0+6F3P463h+JiBzuFfUEZjvks9/
 uMhMmLg+4egRqe0RbLZYkf8saksXFMiBo+L5yuYd02Bqo1o9r1R6RHf97872+AWKLCjs
 pLTdpOyHMCRtfi1lFdT7rQuft+yeuoZ05TWz1kykn0aA+WMUbS1FhKsR2rgzKbju1c3o VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yepvvcq9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Feb 2020 16:27:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 140ED10002A;
        Fri, 28 Feb 2020 16:27:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DE6162D3769;
        Fri, 28 Feb 2020 16:27:07 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 28 Feb 2020 16:27:07
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <olivier.moysan@st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] dt-bindings: sound: Convert cirrus,cs42l51 to json-schema
Date:   Fri, 28 Feb 2020 16:27:06 +0100
Message-ID: <20200228152706.29749-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_04:2020-02-28,2020-02-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert cirrus,cs42l51 to yaml format.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/sound/cirrus,cs42l51.yaml  | 69 ++++++++++++++++++++++
 .../devicetree/bindings/sound/cs42l51.txt          | 33 -----------
 2 files changed, 69 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
new file mode 100644
index 000000000000..efce847a3408
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs42l51.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CS42L51 audio codec DT bindings
+
+maintainers:
+  - Olivier Moysan <olivier.moysan@st.com>
+
+properties:
+  compatible:
+      const: cirrus,cs42l51
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: MCLK
+
+  reset-gpios:
+    maxItems: 1
+
+  VL-supply:
+    description: phandle to voltage regulator of digital interface section
+
+  VD-supply:
+    description: phandle to voltage regulator of digital internal section
+
+  VA-supply:
+    description: phandle to voltage regulator of analog internal section
+
+  VAHP-supply:
+    description: phandle to voltage regulator of headphone
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c@0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cs42l51@4a {
+        compatible = "cirrus,cs42l51";
+        reg = <0x4a>;
+        #sound-dai-cells = <0>;
+        clocks = <&mclk_prov>;
+        clock-names = "MCLK";
+        VL-supply = <&reg_audio>;
+        VD-supply = <&reg_audio>;
+        VA-supply = <&reg_audio>;
+        VAHP-supply = <&reg_audio>;
+        reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/sound/cs42l51.txt b/Documentation/devicetree/bindings/sound/cs42l51.txt
deleted file mode 100644
index acbd68ddd2cb..000000000000
--- a/Documentation/devicetree/bindings/sound/cs42l51.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-CS42L51 audio CODEC
-
-Required properties:
-
-  - compatible : "cirrus,cs42l51"
-
-  - reg : the I2C address of the device for I2C.
-
-Optional properties:
-  - VL-supply, VD-supply, VA-supply, VAHP-supply: power supplies for the device,
-    as covered in Documentation/devicetree/bindings/regulator/regulator.txt.
-
-  - reset-gpios : GPIO specification for the reset pin. If specified, it will be
-    deasserted before starting the communication with the codec.
-
-  - clocks : a list of phandles + clock-specifiers, one for each entry in
-    clock-names
-
-  - clock-names : must contain "MCLK"
-
-Example:
-
-cs42l51: cs42l51@4a {
-	compatible = "cirrus,cs42l51";
-	reg = <0x4a>;
-	clocks = <&mclk_prov>;
-	clock-names = "MCLK";
-	VL-supply = <&reg_audio>;
-	VD-supply = <&reg_audio>;
-	VA-supply = <&reg_audio>;
-	VAHP-supply = <&reg_audio>;
-	reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
-};
-- 
2.15.0

