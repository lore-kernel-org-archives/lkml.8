Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBECC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955D724687
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="YNTmuUYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgA1Piq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:38:46 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20632 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbgA1Pik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:38:40 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SFYHYD022173;
        Tue, 28 Jan 2020 16:38:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=yJR2C+EpBSzUw5sIIGNWwjdePietfS+B5xT/JfDleho=;
 b=YNTmuUYaa7lugZ+4sHsqXuUP8CPLAlxE23q2v2eGmLTxkcFVkUKugBH5tD5UrcVL7WXJ
 IcF1H47hp2rPZzXQpTr9JlNpvW6fHsjcLdJABgEHJYF+TXa+z5TGuPRoLLbu0lV+4nLD
 juKvw9VxdN/yji5FFE0KMvzMrNEuJsLxBDQWiWxw6ldyRku/gkMVp7oNHYZcOH9Od+vi
 tCR7FNg9S4bMKDw0zhwlyYyLv5gG7jjr9vYHq/xtaqJMiswYM5BeWgM8XzbKg1Jdh48w
 AVmx6U3k5rXeWHvjnZthCFdCiPDXfuoqg5lwKTcdAQqPZRHh+FX9RKTDhKL1I1s9wjAJ 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrc136p58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 16:38:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0321510002A;
        Tue, 28 Jan 2020 16:38:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E42052BF9D0;
        Tue, 28 Jan 2020 16:38:22 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 16:38:22
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <fabio.estevam@nxp.com>, <sudeep.holla@arm.com>, <lkml@metux.net>
CC:     <loic.pallardy@st.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-imx@nxp.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <system-dt@lists.openampproject.org>,
        <stefano.stabellini@xilinx.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 4/7] dt-bindings: bus: Add STM32 ETZPC firewall controller
Date:   Tue, 28 Jan 2020 16:38:03 +0100
Message-ID: <20200128153806.7780-5-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200128153806.7780-1-benjamin.gaignard@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document STM32 ETZPC firewall controller bindings

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2:
- use ymal file to describe the bindings
 .../bindings/bus/firewall/st,stm32-etzpc.yaml      | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/firewall/st,stm32-etzpc.yaml

diff --git a/Documentation/devicetree/bindings/bus/firewall/st,stm32-etzpc.yaml b/Documentation/devicetree/bindings/bus/firewall/st,stm32-etzpc.yaml
new file mode 100644
index 000000000000..a162e31e4529
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/firewall/st,stm32-etzpc.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/firewall/st,stm32-etzpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32 Extended TrustZone Protection controller
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+
+description: STMicroelectronics's STM32 firewall controller implementation
+
+allOf:
+  - $ref: "firewall-provider.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - st,stm32-etzpc
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
+    etzpc@5c007000 {
+      compatible = "st,stm32-etzpc";
+      reg = <0x5c007000 0x400>;
+      #firewall-cells = <2>;
+    };
+
+...
-- 
2.15.0

