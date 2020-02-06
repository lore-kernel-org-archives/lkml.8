Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D516C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF46214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZlFORDti";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CXa0CWSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgBFGMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:12:10 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:51894 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727804AbgBFGLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:25 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01667TD4008153;
        Wed, 5 Feb 2020 22:11:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=RUZ8hlR47Cj6943B0RoXfr60JiFnQMNfxQBSjBxj/wY=;
 b=ZlFORDtiUv8X3HiLaddNkID83LwY5ZsAQL/6eOuOkVo3MjADvYr7hxH5nLvCoT6XJybx
 8DRgELCsR1MprtKgb+6K2t32ymwX+se3E1Ypqm/xsiZnCj+Z0obxXdVf7vGWzOkqKJLc
 ochbUY0grGymnQRo//+iLbP+ZUJk4/E28NxgfkeGxrImcV2XObr9GsLrMIKD6cRlyKlj
 ui+w09ZzanD7Qzi1q43lOfCDObkyIFYlZd5zrwX3l37HQpPtnm23jOzge1xnQd5uuAlD
 Pz19U5hE/KNKhVkjJlH6Nda9Z1vTALLLSkxpzH2KbJBy0bET9b3EZ1N4rtQ0KsIhXnm/ Ig== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xyhkv5pj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcEz9Vk7oU5+qcuLvmK6D7E36SkN8UFIDI5/CtO42KXiTOYage4QurVGnwJYBVhF3uIUXufG4yFPnul2x98n4X079tq/ZJBqOlhNw0HpMHiiLABlfnXULyBe9lA+M/vwubr4tgTjLUMZhAvEajhP4qI7R+/aa0x9fLshyoIbme1PpxkSWEPVTvhp6PXaITZMsNg+Zb45NUK06BF2IPBwRk7DfnrmOBCFr7eHUSId2kK5zgm+VzVS91b3cogmoX1bL0CWM+MZdOcsIj24H2T4GwdUzWNuht0XnW1/9QqYV2C0su8K3IhRa1GeAYBXVg0E2klGUFLKV2BQCfSrb6B6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUZ8hlR47Cj6943B0RoXfr60JiFnQMNfxQBSjBxj/wY=;
 b=GyyDv7VfiFUltkZl6jfklkJ31fP8Sr69jhPdoWCy+bWmTXeRelxbFi/0iDfAYZsvnB3LfxG7yS3tvkqfNkU2CjY0/uO+qFYsqYQfsmD00u914k4aZGEwz8j6wVKMRUS2yAmehFiMpCfmgf2mHtvuuCdsqKh56i9WzlVxd2y3hRYH8MzYsIanI0ZPRQCxjvUVJKpRy0Qr4XyYfIG9oppzWKU/6YvnO69buutFmclrAJ/+mkpqeCCo8sRo7YhogktQIM9rxFln0Z8ylNPbvf9BHxo91paiHg0ewBEzUwyE+oHk8P4qN94ehACZPN4TdBt3Xzw9P5JTnlmoDSDImLQ0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUZ8hlR47Cj6943B0RoXfr60JiFnQMNfxQBSjBxj/wY=;
 b=CXa0CWSmLyRPwX3Sfkt0oRh41kTruekX/SGtQUnXMXWMGzXRO+C9iGEwzJBeB/hFidGALIHkg6tduL20ASxEdeDKkB+kXfn1ihdHcDBj+ubcwr7yrMQNahZM3yFFYG9pgo8IDnRhfEUOTXai8qdShODbIV4XbRYZO0axcsC2ECg=
Received: from BN8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:ac::21)
 by SN6PR07MB4816.namprd07.prod.outlook.com (2603:10b6:805:2d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Thu, 6 Feb
 2020 06:11:11 +0000
Received: from MW2NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::209) by BN8PR07CA0008.outlook.office365.com
 (2603:10b6:408:ac::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:11 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT048.mail.protection.outlook.com (10.13.180.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5F1174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:10 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B3ti017029;
        Thu, 6 Feb 2020 07:11:03 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B3RM017028;
        Thu, 6 Feb 2020 07:11:03 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 02/13] dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.
Date:   Thu, 6 Feb 2020 07:10:50 +0100
Message-ID: <1580969461-16981-3-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(36092001)(189003)(199004)(336012)(356004)(2906002)(6666004)(110136005)(42186006)(70206006)(70586007)(54906003)(316002)(5660300002)(36906005)(86362001)(4326008)(8936002)(81156014)(81166006)(426003)(2616005)(8676002)(186003)(26005)(36756003)(107886003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4816;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f9de5df-f2d6-444b-f03c-08d7aacb5d00
X-MS-TrafficTypeDiagnostic: SN6PR07MB4816:
X-Microsoft-Antispam-PRVS: <SN6PR07MB481623216AF3E0B178621DDAD21D0@SN6PR07MB4816.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KEqGGjPDG3sMCrUpw4l9H6bYuDX7+YYTq84oANTg3iAiD7lu3VxgA4UNljqM/Ddn6VzCXSg7+YkBqmZgqVDtLDfx1GxoCe3h8ZWINUaQEWsJLdhFLuqZa7pcY52JLskTyJBjomaBDZisWL5FxX2Tk2Vf3yqgnAIkqioUr/iUhoMDLwZfz42WRWxB3SGoL8ED2r/DwDP+MqtxqJcX9WHOOn2BRWkmO1MV4oM8xL9DRk4f1XEnDE1po4ZPyRf/X9xWc0rHK3VqtQ+ltTAAx4DIywF2dOQ14Lw7az9esXly5hNIKMY6eIDw6n7pSM8zmrPrQwiMjNQg9VGqIBXGA5Ut5cle9rRF7gOnkC6peZUgG3hd13yIO0aaqPbqCvhjex94fExqPLsalP+pjv0nbzN1fxKkhxSmj6QEhQwC3AEcOjXOV0gc2bAT0oVWM2J+QvnLs2GDbfRJ8EHr2CCSrBwfN5F4mV7RF8Iugd5qnZ9RmffacCzxt/otxp4/LMHprJ8Z2KPCFkkikKTgkkShd6iEpItbuwcXJL0X24ZN+lQZJaTwc3YAHe1cOAmd5zagHp6
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:11.1080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9de5df-f2d6-444b-f03c-08d7aacb5d00
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4816
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add Cadence MHDP PHY bindings in YAML format.
- Add Torrent PHY reference clock bindings.
- Add sub-node bindings for each group of PHY lanes based on PHY type.
  Each sub-node includes properties such as master lane number, link reset,
  phy type, number of lanes etc.
- Add reset support including PHY reset and individual lane reset.
- Add a new compatible string used for TI SoCs using Torrent PHY.
This will not affect ABI as the driver has never been functional,
and therefore do not exist in any active use case.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 .../bindings/phy/phy-cadence-torrent.yaml     | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
new file mode 100644
index 000000000000..9f94be1dce6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence Torrent SD0801 PHY binding for DisplayPort
+
+description:
+  This binding describes the Cadence SD0801 PHY (also known as Torrent PHY)
+  hardware included with the Cadence MHDP DisplayPort controller.
+
+maintainers:
+  - Swapnil Jakhade <sjakhade@cadence.com>
+  - Yuti Amonkar <yamonkar@cadence.com>
+
+properties:
+  compatible:
+    enum:
+      - cdns,torrent-phy
+      - ti,j721e-serdes-10g
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  clocks:
+    maxItems: 1
+    description:
+      PHY reference clock. Must contain an entry in clock-names.
+
+  clock-names:
+    const: refclk
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Offset of the Torrent PHY configuration registers.
+      - description: Offset of the DPTX PHY configuration registers.
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: torrent_phy
+      - const: dptx_phy
+
+  resets:
+    maxItems: 1
+    description:
+      Torrent PHY reset.
+      See Documentation/devicetree/bindings/reset/reset.txt
+
+patternProperties:
+  '^phy@[0-7]+$':
+    type: object
+    description:
+      Each group of PHY lanes with a single master lane should be represented as a sub-node.
+    properties:
+      reg:
+        description:
+          The master lane number. This is the lowest numbered lane in the lane group.
+
+      resets:
+        minItems: 1
+        maxItems: 4
+        description:
+          Contains list of resets, one per lane, to get all the link lanes out of reset.
+
+      "#phy-cells":
+        const: 0
+
+      cdns,phy-type:
+        description:
+          Specifies the type of PHY for which the group of PHY lanes is used.
+          Refer include/dt-bindings/phy/phy.h. Constants from the header should be used.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [1, 2, 3, 4, 5, 6]
+
+      cdns,num-lanes:
+        description:
+          Number of DisplayPort lanes.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [1, 2, 4]
+        default: 4
+
+      cdns,max-bit-rate:
+        description:
+          Maximum DisplayPort link bit rate to use, in Mbps
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
+        default: 8100
+
+    required:
+      - reg
+      - resets
+      - "#phy-cells"
+      - cdns,phy-type
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - clocks
+  - clock-names
+  - reg
+  - reg-names
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/phy.h>
+    torrent_phy: phy@f0fb500000 {
+          compatible = "cdns,torrent-phy";
+          reg = <0xf0 0xfb500000 0x0 0x00100000>,
+                <0xf0 0xfb030a00 0x0 0x00000040>;
+          reg-names = "torrent_phy", "dptx_phy";
+          resets = <&phyrst 0>;
+          clocks = <&ref_clk>;
+          clock-names = "refclk";
+          #address-cells = <1>;
+          #size-cells = <0>;
+          torrent_phy_dp: phy@0 {
+                    reg = <0>;
+                    resets = <&phyrst 1>, <&phyrst 2>,
+                             <&phyrst 3>, <&phyrst 4>;
+                    #phy-cells = <0>;
+                    cdns,phy-type = <PHY_TYPE_DP>;
+                    cdns,num-lanes = <4>;
+                    cdns,max-bit-rate = <8100>;
+          };
+    };
+...
-- 
2.20.1

