Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A560C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A40208A9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="D5bGoFQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgFEIec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:34:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40500 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgFEIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:34:16 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0558WAXu010401;
        Fri, 5 Jun 2020 10:33:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Qtjkenp1luntosfDrmrcRmxaJE1CtXuduIjGsuWvcRw=;
 b=D5bGoFQjnIOpItvQVGzcf66EUVa9d1feHtWPoJlLdeCtHlhcJF3BOiVxSgddvpzIp9mf
 xGV62uI8DCdgK/0A6vhsl43q3C3vXt6LxpEMNL/jSlTbIN7Oq29LfkmvL2+wuksorBOn
 9USe7oVVwxuLmITL43FerH2IsuI5lXZ6Izsv41VkWD7T49l/r/8AziijSQVqvj5npKMr
 5KqNU4EdH9ToO81YR4OCuR6uYOWEozTllBtcI+3NuGUTpqWbrkP9TV1K5vWdXKZMU+0P
 AydrDRRyZF2WG8iBTS4i0xhdQPJnQSzqdgme+Mthh2YSjIFKg8eHbCRiSCY5jKhaBTsQ Zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31faset4ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 10:33:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC6FC100039;
        Fri,  5 Jun 2020 10:33:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A082E2B21C0;
        Fri,  5 Jun 2020 10:33:54 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Jun 2020 10:33:54
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stefano.stabellini@xilinx.com>,
        <tomase@xilinx.com>, Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 3/5] dt-bindings: bus: Add STM32 ETZPC firewall controller
Date:   Fri, 5 Jun 2020 10:33:46 +0200
Message-ID: <20200605083348.13880-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200605083348.13880-1-benjamin.gaignard@st.com>
References: <20200605083348.13880-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_01:2020-06-04,2020-06-05 signatures=0
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

