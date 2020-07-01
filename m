Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB232C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909E7207F9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="NHxw0mcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgGANZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:25:49 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23944 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730954AbgGANZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:25:46 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061DOnul002514;
        Wed, 1 Jul 2020 15:25:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Qtjkenp1luntosfDrmrcRmxaJE1CtXuduIjGsuWvcRw=;
 b=NHxw0mcWRvblCnPSjL29QFflxIzogQjOY3CRadoxfCsSaugUO13kTwuiWRqJZ+YmqbNT
 PTB0e5wviT5x/IZ7sbdffYV3n8w3UsQ0WQKY84Snikji6R3yGdDhKPCXmJxTRaaqok1W
 v+Wv9rwG0A29AjksOePPVIHqQRcRwqdOkCwVXspu8xPfr0Dj2WIo2PCJVFnXwbZsqFkj
 gQ0z+8C248zKH+K/FijLWz8mHd2uHhkBMX2CEl38pHer6Cu+hm5VAeQaHaWWR3fZ/QE5
 iA7nwOuldeU7/rYLVfStWxAsPwJwlMu1Dd7a+LxPQSXy9SbpfphDcFAHFmchRrgfRS/Y iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31wuvwa835-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 15:25:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8517C10002A;
        Wed,  1 Jul 2020 15:25:31 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 76E682B6DD8;
        Wed,  1 Jul 2020 15:25:31 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Jul 2020 15:25:30
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stefano.stabellini@xilinx.com>,
        <tomase@xilinx.com>, <devicetree@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 3/5] dt-bindings: bus: Add STM32 ETZPC firewall controller
Date:   Wed, 1 Jul 2020 15:25:21 +0200
Message-ID: <20200701132523.32533-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200701132523.32533-1-benjamin.gaignard@st.com>
References: <20200701132523.32533-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document STM32 ETZPC firewall controller bindings

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/bus/stm32/st,stm32-etzpc.yaml         | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml

diff --git a/Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml b/Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml
new file mode 100644
index 000000000000..d92865fda40c
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/stm32/st,stm32-etzpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32 Extended TrustZone Protection controller
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+
+description: STMicroelectronics's STM32 firewall bus controller implementation
+
+allOf:
+  - $ref: "firewall-provider.yaml#"
+  - $ref: /schemas/simple-bus.yaml#
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - st,stm32-etzpc-bus
+
+  reg:
+   maxItems: 1
+
+  '#firewall-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - '#firewall-cells'
+
+examples:
+  - |
+    soc@5c007000 {
+      compatible = "st,stm32-etzpc-bus", "simple-bus";
+      reg = <0x5c007000 0x400>;
+      #firewall-cells = <2>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+    };
+
+...
-- 
2.15.0

