Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99913C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A1206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="oCQzKRPO";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VK4hMYwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgH0Npm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:45:42 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:52738 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbgH0N3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:29:16 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RDS7t9004807;
        Thu, 27 Aug 2020 06:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=miwka1d2j2ZjmazIKD563V3VQqO6F8hQyfmmLTH4uqM=;
 b=oCQzKRPOUq5b7iHRgOyoU0oLLPHzZ67tmJh5uQV3k6Q24WfgbhtjVzKrRo9JDk2WI2fO
 Dhx4BeQOhPdbDrJsusGJpQ6yJyby2DI0N3J9bAdRKLpWhqbsgK+c/Q1AMcNr6GTxaDCa
 g4hcdGIJynqA3UORoC7lz8lsIzUDCzwi18RpC6P9U3un4BLp+rj9RyTQJpBcB66H/iFd
 Htfh1X9RbZm3nDBdXDVsRjz2jxJwMF0bdYrS3ePx4uR39RBorsCAAXLW6Az3T7p0lpZ3
 zmFjOEd9dID1s14qO+iAMxw2E+CHsEcfvFPa+yeRZJPKWGgCMxISeIonwqwYS7Tmb+eK CQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww45e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 06:29:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8Yxg9/IyXfhoj2ALv/rFx0ajuGgMPeyDZ0hVNya5sz1xTYNAaEJsZWBfKQByHhU7xy5b6IO8wwQhBnwWTJT865TsfhuQ8OyixY/XT4WtSDuNWtplbyk+Yqp4u8SpkbMvolD/DUqtvW0J5R4K5wXsKt3K3o/UdU9NekycUgFs5IdZ1Jd1PUawj/p8Mjo79EEuUuYH4vMcO+vySzUHL5WNgoTbPXwExzW6GIzaXXBZNAmEXR01zpOb9TtLdFrTih6e7ii35CWgqLR6FRgpXXKnFJKDX/lOu1TvXvM02wpFa7kmgZPZjbZ+lRnJRGpKLQ5TKKjzZvPjb1eiZsx+5MSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miwka1d2j2ZjmazIKD563V3VQqO6F8hQyfmmLTH4uqM=;
 b=UnNKflFB/wjJgdJdNXfRM/QfLZkZHrLUTgjNw3nPIhpPTkpHP1BNQw3jaSOLG1aS2hvih2/exnTSJKZI4+HwR0OulNPjbvDzg1lHkB2l/4loxxIyQ0JDhE53T3ApEM/sZ9KThwhNJyoiSu2WL+AJRjgeoO4h5AH3FU9YoGSyDWr4WDMHuQbFQsV3E32nhmu8kJQKt6MoUn82R2JECFYAAwma++CO5Qmcp/S70NQTcr634xvOv6ZUx1xrVGB/yExQD5ww8hOfkcj5NZSCbmLLTwe9K8G8KlUkgaJ0SuzFgAOuzq0X2zjTKlE5VnO2NUoBmuItMy/4I5j2YJLY79jjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miwka1d2j2ZjmazIKD563V3VQqO6F8hQyfmmLTH4uqM=;
 b=VK4hMYwtKRYIj5mbAzlaNznSaHT3WMg7LXIPbOCInd3df1xR1ahnNWY1ZbSIBRdbGOqSOT1cfA4cMVg00mQGE8eBL8kPAMlq5ypPJxTs5rTYDfvWDCshR1s1Yt64crkx8R/XwkM+HWMTfezfij0FHTEbrz4jm/Fu/XjKDd7cSWo=
Received: from DM5PR18CA0064.namprd18.prod.outlook.com (2603:10b6:3:22::26) by
 BL0PR07MB5043.namprd07.prod.outlook.com (2603:10b6:208:4c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Thu, 27 Aug 2020 13:29:07 +0000
Received: from DM6NAM12FT053.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::96) by DM5PR18CA0064.outlook.office365.com
 (2603:10b6:3:22::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Thu, 27 Aug 2020 13:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT053.mail.protection.outlook.com (10.13.179.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:29:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrRn001550
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 09:29:03 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSsHn018766;
        Thu, 27 Aug 2020 15:28:54 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RDSsND018765;
        Thu, 27 Aug 2020 15:28:54 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 7/7] dt-bindings: phy: cadence-torrent: Update Torrent PHY bindings for generic use
Date:   Thu, 27 Aug 2020 15:28:52 +0200
Message-ID: <1598534932-18693-8-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce2f86e9-4431-4696-5bd9-08d84a8d2b88
X-MS-TrafficTypeDiagnostic: BL0PR07MB5043:
X-Microsoft-Antispam-PRVS: <BL0PR07MB5043D3D2541BA006D6D94A31C5550@BL0PR07MB5043.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeFb/JCM87A0zGMnW4amVR0j8/jfm1UtiFO9t7Oc61GqUUCzmJEGXh1AU80lSugRCI+kmBfr313XIP+P/PWirFXHKvSoNk51PGrE5yJvOtYt43U2bjzN9VvRvz6pUqKdq1moCEe4wprUQoTSlXj42ru1nDXhGlns1OG+XClZxwiCWFKra84rP8+/6MK5o0Z/MYMja6zkrH6x134WtAfSUidNuufG2sFDGrXYHfaqs+fUeDoPTo7WeS/PPrCIWdJIK1bsuzSk6Cz99ncYmObZqCVtAd87SZXz4XejKD97J4K6ZUYnMxam5iukh8AqL0LkCBmP6f5LPv5Lr2UeyFzDiR4KzbUmccvICeHFwZUT4rJi8tU6q1aBf4si5AdmgqnkJmvp6ADM0yrcDgj8pYndqdRZFFu9XqWgL5MgCMmixWpuKh/vw53AnUVtS/Z6VRlaXAxa2wvoaMbAho5tn1t4JAEy0pExPiQd7KPngCXdwzayxJhuSbpSHz0bdqE6liEOqUL+9CSIuTAr6MYfv6z0Ag==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36092001)(46966005)(70206006)(4326008)(316002)(356005)(42186006)(70586007)(82310400002)(8676002)(54906003)(110136005)(83380400001)(2906002)(8936002)(26005)(426003)(82740400003)(86362001)(186003)(15650500001)(2616005)(36756003)(336012)(5660300002)(478600001)(81166007)(47076004)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:29:05.3456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2f86e9-4431-4696-5bd9-08d84a8d2b88
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT053.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5043
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=989 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent PHY can be used in different multi-link multi-protocol
configurations including protocols other than DisplayPort also,
such as PCIe, USB, SGMII, QSGMII etc. Update the bindings to have
support for these configurations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../bindings/phy/phy-cadence-torrent.yaml     | 76 ++++++++++++++-----
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index a7ee19d27c19..1b9e1231f8d8 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -4,11 +4,13 @@
 $id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Cadence Torrent SD0801 PHY binding for DisplayPort
+title: Cadence Torrent SD0801 PHY binding
 
 description:
   This binding describes the Cadence SD0801 PHY (also known as Torrent PHY)
-  hardware included with the Cadence MHDP DisplayPort controller.
+  hardware included with the Cadence MHDP DisplayPort controller. Torrent
+  PHY also supports multilink multiprotocol combinations including protocols
+  such as PCIe, USB, SGMII, QSGMII etc.
 
 maintainers:
   - Swapnil Jakhade <sjakhade@cadence.com>
@@ -49,13 +51,14 @@ properties:
       - const: dptx_phy
 
   resets:
-    maxItems: 1
-    description:
-      Torrent PHY reset.
-      See Documentation/devicetree/bindings/reset/reset.txt
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Torrent PHY reset.
+      - description: Torrent APB reset. This is optional.
 
 patternProperties:
-  '^phy@[0-7]+$':
+  '^link@[0-7]+$':
     type: object
     description:
       Each group of PHY lanes with a single master lane should be represented as a sub-node.
@@ -78,13 +81,13 @@ patternProperties:
           Specifies the type of PHY for which the group of PHY lanes is used.
           Refer include/dt-bindings/phy/phy.h. Constants from the header should be used.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [1, 2, 3, 4, 5, 6]
+        enum: [1, 2, 3, 4, 5, 6, 7, 8, 9]
 
       cdns,num-lanes:
         description:
-          Number of DisplayPort lanes.
+          Number of lanes.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [1, 2, 4]
+        enum: [1, 2, 3, 4]
         default: 4
 
       cdns,ssc-mode:
@@ -108,6 +111,7 @@ patternProperties:
       - resets
       - "#phy-cells"
       - cdns,phy-type
+      - cdns,num-lanes
 
     additionalProperties: false
 
@@ -141,14 +145,50 @@ examples:
             clock-names = "refclk";
             #address-cells = <1>;
             #size-cells = <0>;
-            phy@0 {
-                      reg = <0>;
-                      resets = <&phyrst 1>, <&phyrst 2>,
-                               <&phyrst 3>, <&phyrst 4>;
-                      #phy-cells = <0>;
-                      cdns,phy-type = <PHY_TYPE_DP>;
-                      cdns,num-lanes = <4>;
-                      cdns,max-bit-rate = <8100>;
+            link@0 {
+                reg = <0>;
+                resets = <&phyrst 1>, <&phyrst 2>,
+                         <&phyrst 3>, <&phyrst 4>;
+                #phy-cells = <0>;
+                cdns,phy-type = <PHY_TYPE_DP>;
+                cdns,num-lanes = <4>;
+                cdns,max-bit-rate = <8100>;
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/phy/phy-cadence-torrent.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        torrent-phy@f0fb500000 {
+            compatible = "cdns,torrent-phy";
+            reg = <0xf0 0xfb500000 0x0 0x00100000>;
+            reg-names = "torrent_phy";
+            resets = <&phyrst 0>, <&phyrst 1>;
+            clocks = <&ref_clk>;
+            clock-names = "refclk";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            link@0 {
+                reg = <0>;
+                resets = <&phyrst 2>, <&phyrst 3>;
+                #phy-cells = <0>;
+                cdns,phy-type = <PHY_TYPE_PCIE>;
+                cdns,num-lanes = <2>;
+                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
+            };
+
+            link@2 {
+                reg = <2>;
+                resets = <&phyrst 4>;
+                #phy-cells = <0>;
+                cdns,phy-type = <PHY_TYPE_SGMII>;
+                cdns,num-lanes = <1>;
+                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
             };
         };
     };
-- 
2.26.1

