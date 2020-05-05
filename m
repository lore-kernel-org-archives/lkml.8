Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C6C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE5020721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wq54FGb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgEEHdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:33:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42312 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgEEHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:33:43 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0457RaST021748;
        Tue, 5 May 2020 09:33:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=95ku3/6d1RqLRL3+9BXCw/qoEPmvHEydQikv3nokkHE=;
 b=wq54FGb2PUTIfZ0Z4HWOhJtYsxNX08QLoHAcCvalnRvHeOwIkMrGccNgOT5kIC7rpGdW
 7R20/3opU85slWnUWzV9CcVaryFNqiNQyPU4nOfznM5dmRkJvTMxsXLGqxsKKo58MFO1
 DYKOXEfDQeCMx6J9oX8CpMHedKRokE8ZCBoNDUqzf8rwl5Sut/CaDYpHjd2WwCJHoaEU
 mcL9aUEizkntHgg/ldYqosPhOVgLvwXBCYCodWa0ULgrxL58W+WxtbJN3fPKOamuaNim
 rVrAio9RVpA8NxQAw0bdW73n6EH3dnulJG1bLvldrmhSAyK9eYR0xE963eYNdiHmgAN5 Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30ryrj6f49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 09:33:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B30F10002A;
        Tue,  5 May 2020 09:33:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EEE642A4927;
        Tue,  5 May 2020 09:33:25 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 May 2020 09:33:25
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <gregkh@linuxfoundation.org>,
        <loic.pallardy@st.com>, <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 1/5] dt-bindings: bus: Add firewall bindings
Date:   Tue, 5 May 2020 09:33:04 +0200
Message-ID: <20200505073308.22914-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200505073308.22914-1-benjamin.gaignard@st.com>
References: <20200505073308.22914-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_04:2020-05-04,2020-05-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add schemas for firewall consumer and provider.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
version 3:
- add description in firewall consumer bindings
- add Linus reviewed-by tag

 .../bindings/bus/stm32/firewall-consumer.yaml      | 36 ++++++++++++++++++++++
 .../bindings/bus/stm32/firewall-provider.yaml      | 18 +++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/stm32/firewall-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/stm32/firewall-provider.yaml

diff --git a/Documentation/devicetree/bindings/bus/stm32/firewall-consumer.yaml b/Documentation/devicetree/bindings/bus/stm32/firewall-consumer.yaml
new file mode 100644
index 000000000000..d3d76f99b38d
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/stm32/firewall-consumer.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/stm32/firewall-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Bus Firewall consumer binding
+
+description: |
+  Firewall properties provide the possible firewall bus controller
+  configurations for a device.
+  Bus firewall controllers are typically used to control if a hardware
+  block can perform read or write operations on bus.
+  The contents of the firewall bus configuration properties are defined by
+  the binding for the individual firewall controller device.
+
+  The first configuration 'firewall-0' or the one named 'default' is
+  applied before probing the device itself.
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+
+# always select the core schema
+select: true
+
+properties:
+  firewall-0: true
+
+  firewall-names: true
+
+patternProperties:
+  "firewall-[0-9]":
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+
+dependencies:
+  firewall-names: [ firewall-0 ]
diff --git a/Documentation/devicetree/bindings/bus/stm32/firewall-provider.yaml b/Documentation/devicetree/bindings/bus/stm32/firewall-provider.yaml
new file mode 100644
index 000000000000..299824c620ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/stm32/firewall-provider.yaml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/stm32/firewall-provider.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Bus Firewall provider binding
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@st.com>
+
+properties:
+  '#firewall-cells':
+     $ref: /schemas/types.yaml#/definitions/uint32
+     description: Number of cells in a bus firewall specifier
+
+required:
+  - '#firewall-cells'
-- 
2.15.0

