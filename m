Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08004C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF31420706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbgFWRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:35:17 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13814 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733078AbgFWRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:15 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHNRAN031405;
        Tue, 23 Jun 2020 13:35:13 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31uk3grq2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 13:35:13 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05NHZCa6031594
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 23 Jun 2020 13:35:12 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 23 Jun 2020 13:35:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 23 Jun 2020 13:35:11 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 23 Jun 2020 13:35:11 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05NHYxMW017521;
        Tue, 23 Jun 2020 13:35:08 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v4 7/7] dt-bindings: hwmon: Add bindings for ADM1266
Date:   Tue, 23 Jun 2020 20:36:59 +0300
Message-ID: <20200623173659.41358-8-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173659.41358-1-alexandru.tachici@analog.com>
References: <20200623173659.41358-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add bindings for the Analog Devices ADM1266 sequencer.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../bindings/hwmon/adi,adm1266.yaml           | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
new file mode 100644
index 000000000000..76b62be48d56
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,adm1266.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADM1266 Cascadable Super Sequencer with Margin
+  Control and Fault Recording
+
+maintainers:
+  - Alexandru Tachici <alexandru.tachici@analog.com>
+
+description: |
+  Analog Devices ADM1266 Cascadable Super Sequencer with Margin
+  Control and Fault Recording.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1266.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adm1266
+
+  reg:
+    description: |
+      I2C address of slave device.
+    items:
+      minimum: 0x40
+      maximum: 0x4F
+
+  avcc-supply:
+    description: |
+      Phandle to the Avcc power supply.
+
+  adi,master-adm1266:
+    description: |
+      Represents phandle of a master ADM1266 device cascaded through the IDB.
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adm1266@40 {
+                compatible = "adi,adm1266";
+                reg = <0x40>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+        };
+    };
+...
-- 
2.20.1

