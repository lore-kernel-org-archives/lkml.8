Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DFFC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A9C24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ybmuOAx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgANLVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:21:19 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:54334 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbgANLVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:21:19 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EBKPhD020029;
        Tue, 14 Jan 2020 06:20:33 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xfbvb7cg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 06:20:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehtQta8TqSp70wFXLht6X/VYR7ZfeHvjqAFWCB2zeMHebtmJU5aBVa/KX951NHSzSa5l6ES/PWWOh2WCdU54yuqdwWQ6uHLFGWuRnrFM1k10klgTs3CCfNFqsSzDh4slq0PQ75WWvx4EcsDNshW1cAkqPzCuPKkJMmdLC4FQTp+nl3dgMhpopK5qo8FfPtsD/JNwkWA9DJlxuWHFeslb/Z9S8RpiaHNkca09yzZGQWhaxCgHMw6i+mOFby12QTm4VMQARo3YcUXbRnFddIH0Ff9AEcmQ8qIVQ3sZgHATpxmkrcSg6N46phC+SXRDonA8OaxXmHg5MgVOZOWX151tqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRQwcOYHTJOYZ80uoP+5xGXrAJpxABvWGBDm+D5iEGA=;
 b=bZ5+oOtsVg1n9Xr6lqwrvecsARtGnC8mD4SrcXBchNUt5m6Oa31csKhX5uUTVL2CAL6y25lYHgR5Bp0fE63HX4x+Ns3eNBPvSKh4IFZg1CJv/JcUueuDqk/L1vSYIKkhjpZPazXyyPgigXC+cwtIu3LJwrEI+A7TkB8/jLnj8EewKdu29cEvg41AEG2klJ4YTPaohybKlMmTU7O4DiYk+oGGpXdtKIXmUDWWYspgiWz7oOG/E7O5JbrnSuWNaAOujL1JAsCFImaKjAs+qrw+2xUgyV8OvWcSYkZzbHRwWDpApdnYGOlFuSSp+LKIo24ywM9VXq32Sy5S+MfMiKzMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRQwcOYHTJOYZ80uoP+5xGXrAJpxABvWGBDm+D5iEGA=;
 b=ybmuOAx4bb/pHswF4TES8xSF0Tl7DjcWIVndJ8wN4xdWx7+zw5WYKDOLfKQ2xG4+JEcEFQrjT88nqE/e/lFYT7sIdPBEURKaaRHpzLhMjO3P/IyDzo044hhr6LD1k/4vmsOkeJOTjJELu7mmk91+GSszldc7n8BTB7s1U1A3ndg=
Received: from BN3PR03CA0081.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::41) by BN7PR03MB4466.namprd03.prod.outlook.com
 (2603:10b6:408:3f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Tue, 14 Jan
 2020 11:20:31 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN3PR03CA0081.outlook.office365.com
 (2a01:111:e400:7a4d::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Tue, 14 Jan 2020 11:20:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Tue, 14 Jan 2020 11:20:30 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 00EBKIq2018144
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 14 Jan 2020 03:20:18 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 14 Jan
 2020 03:20:28 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 14 Jan 2020 03:20:27 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00EBKJnL022085;
        Tue, 14 Jan 2020 06:20:24 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v4 2/3] dt-binding: hwmon: Add documentation for ADM1177
Date:   Tue, 14 Jan 2020 13:21:58 +0200
Message-ID: <20200114112159.25998-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114112159.25998-1-beniamin.bia@analog.com>
References: <20200114112159.25998-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(1076003)(44832011)(356004)(6666004)(336012)(5660300002)(86362001)(246002)(8936002)(4326008)(2906002)(8676002)(426003)(6916009)(26005)(7636002)(70586007)(70206006)(2616005)(186003)(107886003)(7696005)(478600001)(316002)(54906003)(36756003)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB4466;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e78bbff2-996d-4db8-ac87-08d798e3c3f3
X-MS-TrafficTypeDiagnostic: BN7PR03MB4466:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4466A6897C77FE8AE7B2273AF0340@BN7PR03MB4466.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 028256169F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJjKasKOVG6txd8Qdxf3bmgI23/Xbw3d7SeMhvKmv+FpV1z26lIWFp/zU5YimKbh606D4NSU+JYnzjlcnVPay3etOF46pq49LkBI4hiwZ2iNQ13tZT211DK+1pFbJzZbjlUguorsGGyJe59/5xUTRUzf1ecB5XZJNFkEzQvT2OomculD7JGXqubUjSbAccIPn8JE42pEaRHAh1OmfGgOZ3QmNQuqb9u0qG9unHfmiJslawo82YyN/ALrHEucsX9vGhCD9Zh5DGURPZApgLTr2l0FgSOrzh1Ow/+69528UgISwY8OR3eccOUskIcO0ptkKT1kpoC7AUs/DUGISQIstpf52HxMd8qSm28cQrUcwV8z2ggjN5MhDlMMBf79E/XbiE2J7SV3KVXN1bbIBK1ixd82dZZ7TgneDk+q1Fos8VBsV+Yv3/fBuHQPUhL/XmMCwa3CgaRgAMAb4QcCTpmagkhWO+OiIZ1a2Ias+ueREw52CetKbOg1jpI5eLVBUuwnWJnyexa/n/2TQKk+YqiFWg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 11:20:30.8258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78bbff2-996d-4db8-ac87-08d798e3c3f3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4466
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for ADM1177 was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v4:
-complains about using tab instead of space fixed

 .../bindings/hwmon/adi,adm1177.yaml           | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
new file mode 100644
index 000000000000..2a9822075b36
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,adm1177.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Beniamin Bia <beniamin.bia@analog.com>
+
+description: |
+  Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adm1177
+
+  reg:
+    maxItems: 1
+
+  avcc-supply:
+    description:
+      Phandle to the Avcc power supply
+
+  shunt-resistor-micro-ohms:
+    description:
+      The value of curent sense resistor in microohms. If not provided,
+      the current reading and overcurrent alert is disabled.
+
+  adi,shutdown-threshold-microamp:
+    description:
+      Specifies the current level at which an over current alert occurs.
+      If not provided, the overcurrent alert is configured to max ADC range
+      based on shunt-resistor-micro-ohms.
+
+  adi,vrange-high-enable:
+    description:
+      Specifies which internal voltage divider to be used. A 1 selects
+      a 7:2 voltage divider while a 0 selects a 14:1 voltage divider.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pwmon@5a {
+                compatible = "adi,adm1177";
+                reg = <0x5a>;
+                shunt-resistor-micro-ohms = <50000>; /* 50 mOhm */
+                adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
+                adi,vrange-high-enable;
+        };
+    };
+...
-- 
2.17.1

