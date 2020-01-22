Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203EFC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E139724688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="N0zpfQPq";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Aq+qV7Kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgAVKpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:45:43 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35826 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729388AbgAVKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:38 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAinv2016451;
        Wed, 22 Jan 2020 02:45:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GTgrlcBJQ5utvxYFpHxOCesmVtAdcOxwziNQwEUgOJI=;
 b=N0zpfQPq0ktzMYR0UdTTZ8xDVDKKBDb9hBefIdRrv9wOCqSt/IPEvJ31yTKbJjhaVjuL
 Q96YzqDXykAt7PSbDlNcS3TlWUOrM7Zv+KB5y4t7ZzxXXCqSMQpvbCBmticcv/sn1Tug
 JqPX6Nf/2rvM4nzUIk5b70SBRCXcJGbaotxdsfGEsjx7NwJ6qp/n+7C3niuUQ48wTkkb
 m3aPnYUb/uGp1ys22ewc5ofR2JhJSW9ELPp1h6zpwpfxSwbt5HgZ9spKTBX20ylBqc57
 plUQRARQuCILizx1MpjQWBmP0zrE8rrWgJvoxfeR3iiDq51Dcyr37l51bC1UZA9wUlKO Hg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xkxg3vssj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHEMG289X9wPXs/ckwErcnglIWTmTjZdmV0PqKBC3AK4rGwhqd5I/PRkW6BokMrOmUQMpjQm6tctRMu8BtPUzOKIWOWL0vtfEah0b5Jw31SWpdIUECGAFVGWyWAzpQMGTi+OAW8LATJYuEU+O5uq8vy1h52P/LD/pQuAMmQ+YZ1DRTeFhrj5wfo6JeuDCpQJRKBEsiiSF1MAEC9TXGwivZxUBP/RAW+svZ9jK+dSpON02FLcVVvmNjTqvt8iH3xhViN+CUoghLyq1Pn74hi1K7VPTmzHdkNQ79aoUBfdPyBzPTQj/+ldKg/iZnbHveuIPPUWPxu93b7KhqdQjHNiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTgrlcBJQ5utvxYFpHxOCesmVtAdcOxwziNQwEUgOJI=;
 b=FxEpTNfbLQNDJhw1B7NlN2BdMjxRTA4L7luRVva19N15smukLuZ/dC5epcHJt+07LTh9DaCL2WcpjTajz9HbJ2Q0P2GleGekxCqxrFl1fy0doSVgyENJS3AihLD1KW/fvIXj9IPTsHxgwUcIV/wugn1vEkeLZY8Q2SQuZSl+MEqEe/lGI27WtMOahkKc6KcPxDBjGKnIODISobkw2tnbKS9PVU2jBPI5vWx98P56Q0YSywL07PCOXJiAnWTeCc2bQoCfFeWGUmWF63P0deJaLMFrk4PZWu4p6ymRvyPybmvz4F6kSobPrz3oLmJfBJL/pvBxDLtprRqGvLgnMwACLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTgrlcBJQ5utvxYFpHxOCesmVtAdcOxwziNQwEUgOJI=;
 b=Aq+qV7KpJiZwx9FK6NqKUjaIq0Gi5hC2XI+B5UsS47hwOdyAvWqR4H/cJjyqAyouId8lWR7OcKGbosw/zNJ+DXlbBouqTK/l/Ib59xu0xS7EHESvfWZzPhiUyhe3DRRCogD3EVAKBIj8QF68V08UpZqB3pptMGGphZckbWToA7Y=
Received: from CY1PR07CA0036.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::46) by DM6PR07MB7340.namprd07.prod.outlook.com
 (2603:10b6:5:21d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Wed, 22 Jan
 2020 10:45:24 +0000
Received: from DM6NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::206) by CY1PR07CA0036.outlook.office365.com
 (2a01:111:e400:c60a::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM6NAM12FT058.mail.protection.outlook.com (10.13.179.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBA001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:22 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:19 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:19 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjJag007238;
        Wed, 22 Jan 2020 11:45:19 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjJAu007237;
        Wed, 22 Jan 2020 11:45:19 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 01/14] dt-bindings: phy: Convert Cadence MHDP PHY bindings to YAML.
Date:   Wed, 22 Jan 2020 11:45:05 +0100
Message-ID: <1579689918-7181-2-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(36092001)(189003)(199004)(2906002)(246002)(4326008)(86362001)(8676002)(7636002)(186003)(5660300002)(426003)(2616005)(336012)(8936002)(26005)(6666004)(107886003)(110136005)(54906003)(316002)(356004)(42186006)(70586007)(26826003)(70206006)(478600001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB7340;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 181ff02a-4692-421f-0655-08d79f282f84
X-MS-TrafficTypeDiagnostic: DM6PR07MB7340:
X-Microsoft-Antispam-PRVS: <DM6PR07MB734000D52636986E96C3A5E3D20C0@DM6PR07MB7340.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q405xZUgxC7pSx8l9TvV9g49+9U9lnUBa9k7aJYyhESHJjzVA0Jqy0kk9nx8zEqBR3r/zzUHcB9zk3p2Ewz3yluURAHJAyP1IyhK4dJa4xrrHCS0pkRtIoM/wdsjblaDgh9RrM5SWMw9lk5aNwCxQyIP3dwhe2mcZmaF3d1V71PbzeDbFzim3SGTyzSNQAKchvmoG5Kqaeh/YhNvfe0qDzGeZIxkcjNfjhDs300EQw8fvKANP4gsMAZ65ksUGTfN21It2aRNJw9hJf81HTKdvywHX7RNnZTwZis/0V8v/0RY+y5F692R5owz79Lg3kHjgNlnZwVMuQ5I2ZxNMMMy9OCw1QwExv1AQYFn9bsma7Msa14CFJjyrGrnKSC2G5i/waLRGZ0WZLRzHyZwoIPD7r7KUGRv6hY6ddFxe/bzKhZ9vT7ViOUVxSyo/CWFKwW1bXHM9z3wPvd7qFiou3qtMme+GM8YyLHO/QDK/9LnN9zsua5KbZaJDmVJFuys6nS2OnxCtfOFJvWGvosuMx8FAA==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:23.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 181ff02a-4692-421f-0655-08d79f282f84
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7340
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Convert the MHDP PHY devicetree bindings to yaml schemas.
- Rename DP PHY to have generic Torrent PHY nomrnclature.
- Add Torrent PHY reference clock bindings.
- Rename compatible string from "cdns,dp-phy" to "cdns,torrent-phy".
  This will not affect ABI as the driver has never been functional,
  and therefore do not exist in any active use case

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-dp.txt     | 30 --------
 .../bindings/phy/phy-cadence-torrent.yaml          | 82 ++++++++++++++++++++++
 2 files changed, 82 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
deleted file mode 100644
index 7f49fd54e..0000000
--- a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Cadence MHDP DisplayPort SD0801 PHY binding
-===========================================
-
-This binding describes the Cadence SD0801 PHY hardware included with
-the Cadence MHDP DisplayPort controller.
-
--------------------------------------------------------------------------------
-Required properties (controller (parent) node):
-- compatible	: Should be "cdns,dp-phy"
-- reg		: Defines the following sets of registers in the parent
-		  mhdp device:
-			- Offset of the DPTX PHY configuration registers
-			- Offset of the SD0801 PHY configuration registers
-- #phy-cells	: from the generic PHY bindings, must be 0.
-
-Optional properties:
-- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
-- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
-		  2430, 2700, 3240, 4320, 5400 or 8100)
--------------------------------------------------------------------------------
-
-Example:
-	dp_phy: phy@f0fb030a00 {
-		compatible = "cdns,dp-phy";
-		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
-		      <0xf0 0xfb500000 0x0 0x00100000>;
-		num_lanes = <4>;
-		max_bit_rate = <8100>;
-		#phy-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
new file mode 100644
index 0000000..eb633d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -0,0 +1,82 @@
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
+    const: cdns,torrent-phy
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
+  "#phy-cells":
+    const: 0
+
+  num_lanes:
+    description:
+      Number of DisplayPort lanes.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 2, 4]
+
+  max_bit_rate:
+    description:
+      Maximum DisplayPort link bit rate to use, in Mbps
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - reg
+  - reg-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    dp_phy: phy@f0fb500000 {
+          compatible = "cdns,torrent-phy";
+          reg = <0xf0 0xfb500000 0x0 0x00100000>,
+                <0xf0 0xfb030a00 0x0 0x00000040>;
+          reg-names = "torrent_phy", "dptx_phy";
+          num_lanes = <4>;
+          max_bit_rate = <8100>;
+          #phy-cells = <0>;
+          clocks = <&ref_clk>;
+          clock-names = "refclk";
+    };
+...
-- 
2.4.5

