Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8674FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A99E24683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="w42V4DNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgA1Piu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:38:50 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1501 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbgA1Pij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:38:39 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SFX6pi022000;
        Tue, 28 Jan 2020 16:38:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=M4shpoCyMVFctSdGUqHSe14SyK0jF9SpsbaZCxF6Fo8=;
 b=w42V4DNpKo+W2ut3+BCjBH2xBBfPxVeQqtwpjpDBEU+HcaBPDWhOg6acS2ibIoDaPO6B
 qOuLt9KSW+KhUwOItT9IxQ4tQ/dhSN11teay9/XN34y63WYqIBmv/k+6NnSYsk8OCvlU
 eKXBX7hibeKl6f45OOTi/5AepoN7y8Srsmj1zJGB0KANIzy+PWExAbKAjeJbMW1O1JvN
 KHZCBcr1ezdii+vVOC52WNZt2gqzlzRx1horm7wZPqSSc5O0hoCx6C8RK15j3xOv2+uO
 zPtmdUqqbb2m8cblZdmwak4PWkv6EWvGKmUXtCuxGtucyWK5c687KOynH/zKtozBzfU/ oA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcaxxmdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 16:38:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 04082100034;
        Tue, 28 Jan 2020 16:38:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D61962BF9D0;
        Tue, 28 Jan 2020 16:38:19 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 16:38:19
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
Subject: [PATCH v2 1/7] dt-bindings: bus: Add firewall bindings
Date:   Tue, 28 Jan 2020 16:38:00 +0100
Message-ID: <20200128153806.7780-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200128153806.7780-1-benjamin.gaignard@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add schemas for firewall consumer and provider.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2:
- describe bindings in yaml files
 .../bindings/bus/firewall/firewall-consumer.yaml   | 25 ++++++++++++++++++++++
 .../bindings/bus/firewall/firewall-provider.yaml   | 18 ++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/firewall/firewall-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/firewall/firewall-provider.yaml

diff --git a/Documentation/devicetree/bindings/bus/firewall/firewall-consumer.yaml b/Documentation/devicetree/bindings/bus/firewall/firewall-consumer.yaml
new file mode 100644
index 000000000000..ea7963c600f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/firewall/firewall-consumer.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/firewall/firewall-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Bus Firewall consumer binding
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
diff --git a/Documentation/devicetree/bindings/bus/firewall/firewall-provider.yaml b/Documentation/devicetree/bindings/bus/firewall/firewall-provider.yaml
new file mode 100644
index 000000000000..0f9a38b63fbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/firewall/firewall-provider.yaml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/firewall/firewall-provider.yaml#
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

