Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF41C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1192C217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0z00dx/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBFNeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:34:23 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43448 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728019AbgBFNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:34:15 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016DX36v016463;
        Thu, 6 Feb 2020 14:33:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=uw83YHkEimIhhPOEeMx2nLPySoUUuETqUW2sGayUiPM=;
 b=0z00dx/CAms+OVIefxU9IODEGW7IBlVO6dXKyAw4L/yLkKeQ/hJo5Bn7vm+yIETHS+ST
 Z/ZMksUD2k4oCF6k6wpCzzGT4Yo181tnKQLXcIs0+gsL8ts5zpyb3uqM022YIXveWptK
 9eai6YcIuHVvrFSm/w/g4sTHyOunPGXwytXayPEeC8R281Ixo3wfC2qmuea6f+dulzRb
 l4eWNPRc65ES71CgyoRxtRfK4mQL7HYi80QaZCK4M5Xd2daUZdyCsYvlrGsIG7MBvvmJ
 LM4zNz8uzt5hj2ZBxPZOdycdiKuBHXKjm3Ag6I2O2wcA/xQbFJGmoWHD3qXK1yXL+XCw 0Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xyhku156e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 14:33:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E536E10003B;
        Thu,  6 Feb 2020 14:33:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D75B72BC7DB;
        Thu,  6 Feb 2020 14:33:51 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Feb 2020 14:33:51
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <thierry.reding@gmail.com>, <sam@ravnborg.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <philippe.cornu@st.com>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 3/3] dt-bindings: panel: Convert orisetech,otm8009a to json-schema
Date:   Thu, 6 Feb 2020 14:33:44 +0100
Message-ID: <20200206133344.724-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200206133344.724-1-benjamin.gaignard@st.com>
References: <20200206133344.724-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert orisetech,otm8009a to json-schema.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/display/panel/orisetech,otm8009a.txt  | 23 ----------
 .../bindings/display/panel/orisetech,otm8009a.yaml | 53 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
deleted file mode 100644
index 203b03eefb68..000000000000
--- a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Orise Tech OTM8009A 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode)
-
-The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
-a MIPI-DSI video interface. Its backlight is managed through the DSI link.
-
-Required properties:
-  - compatible: "orisetech,otm8009a"
-  - reg: the virtual channel number of a DSI peripheral
-
-Optional properties:
-  - reset-gpios: a GPIO spec for the reset pin (active low).
-  - power-supply: phandle of the regulator that provides the supply voltage.
-
-Example:
-&dsi {
-	...
-	panel@0 {
-		compatible = "orisetech,otm8009a";
-		reg = <0>;
-		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
-		power-supply = <&v1v8>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
new file mode 100644
index 000000000000..6e6ac995c27b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/orisetech,otm8009a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Orise Tech OTM8009A 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode)
+
+maintainers:
+  - Philippe CORNU <philippe.cornu@st.com>
+
+description: |
+             The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
+             a MIPI-DSI video interface. Its backlight is managed through the DSI link.
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+
+  compatible:
+    const: orisetech,otm8009a
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  enable-gpios: true
+  port: true
+  power-supply: true
+
+  reset-gpios:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    dsi@0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      panel@0 {
+        compatible = "orisetech,otm8009a";
+        reg = <0>;
+        reset-gpios = <&gpiof 15 0>;
+        power-supply = <&v1v8>;
+      };
+    };
+...
+
-- 
2.15.0

