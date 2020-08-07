Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5208C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD7B22D71
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pEWZ5Mq7";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DZj/7sIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHGKNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:13:19 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:1980 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728160AbgHGKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:13:02 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0779vUW5023777;
        Fri, 7 Aug 2020 03:12:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DHo08LFANEggRsz72fESCNaJM8IK1HY9tqLDRrzJHsc=;
 b=pEWZ5Mq7DsH6EA6aeL8X0QaaKuflsF3nw4CTlrFj/NTfuiTlDIHYu7A4M/xaIs4IV9Pt
 I42++pm/5Jv5PJ+WU3/qH6YgKgjxUoauyI+SphA0psViF2cvnkcPcnidNURAAbPThPha
 nPpyF7t/WiNmmcidwk7UqOiV+ewvcqCsgiXFwC0wLNtmuPeTGVyoj2Mkyr3LoQ+H3vRv
 +ab5mFSIDWgoZggney+08pQNpxaPWcfQZpFlDF6HjTNYZevigo0/QCqRyUXcFpCP/nbC
 bjtxmdKwwvZylqJOOtBtOuvvnUyDeXQP80tvzoN9p+UNl+l4EE6jlneHTx7Jfpj98dHi bQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0m4s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 03:12:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcvXBy4G2yruHxOteF400aejI9tTMZIte5jKY6OQGMv1GrgoqjFDIimg44B4Di2hMWbtnW36CZ4ZjMoafgYIWAStd62zLltL9DR/xgi+rPymsRwXyDLElyEY8DD1Nz2p9d+OwWFbv8AlaCV/mwAvcNchNlIZUwhvuRdggoVkz/JsFYQDe2WlVXgGnfMb7X6JI2G0HQOTcepZ2eKl7vOy1c3JxxoP5L7acOGkH/archAAwfkqY8S+IEBiImf6QuoCUbmeibIsE/rwr4TZDf0+wy9FYv4sNalXD6t6hq0zsHX8Rs8fEZ08KGAnyIoNIIyhqf0FCfJecnOBh4R2wf22hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHo08LFANEggRsz72fESCNaJM8IK1HY9tqLDRrzJHsc=;
 b=Tx6CBaI5kSCkzBxTbgRgRkhFxPsBQ+TA77TsJ/+6i8U0bEZhnEDncXZ0l6WV1GsFBhmKbs/h60FHIGGf2nlPWgorUcaZ8ox6o84zJLT+s5j6Czu0NMJNJ2oEvASBe5i00+sZRm2FKxJinuizai3rZDhIpNt1qDfqvFfgSheYLjbFw65MD3ILjzrlRB0FqIoA1Eu8RCYq38Xu/SfNwV4IUFZiaw68mNCJCSs+OjIpWqRwwWO9JBSm78OYeR5T1i+2uIig8vh7l4FpVrHt/YXpLyT55Sro6VCkCoKlK3VN3VMp+ypPVvxjGHje/l6hNt9grXSyBAiktfWh80A3InmhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHo08LFANEggRsz72fESCNaJM8IK1HY9tqLDRrzJHsc=;
 b=DZj/7sIhxNkqBzlm64eZ3e/7/3drHwNuh4lHOkIcDSv7ogsnCoXAE2Z0N+VdGeU4Ay1QaRfmIEyqF4Gdb7IAv93plSD0afBIU9xHxBtB6pndfPZHQSw9hit0TuWncWU9Uf6UipeqjpajfAxdTKelm4/ZbBGbbY+esmp38HiBiQw=
Received: from DM5PR07CA0164.namprd07.prod.outlook.com (2603:10b6:3:ee::30) by
 DS7PR07MB7701.namprd07.prod.outlook.com (2603:10b6:5:2c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18; Fri, 7 Aug 2020 10:12:56 +0000
Received: from DM6NAM12FT014.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::7b) by DM5PR07CA0164.outlook.office365.com
 (2603:10b6:3:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend
 Transport; Fri, 7 Aug 2020 10:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT014.mail.protection.outlook.com (10.13.178.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 10:12:55 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACk5g021638
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 06:12:54 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077AClGT013407;
        Fri, 7 Aug 2020 12:12:47 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077ACkI1013406;
        Fri, 7 Aug 2020 12:12:46 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 7/7] dt-bindings: phy: cadence-torrent: Update Torrent PHY bindings for generic use
Date:   Fri, 7 Aug 2020 12:12:45 +0200
Message-ID: <1596795165-13341-8-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4218202f-eed7-42d1-8ae1-08d83aba7427
X-MS-TrafficTypeDiagnostic: DS7PR07MB7701:
X-Microsoft-Antispam-PRVS: <DS7PR07MB77013737923EB8176F8058C4C5490@DS7PR07MB7701.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4Xe7eLtP/xb5c531krlVfs/bFHpMqoYe0YwXgWebGD4hA/jQxnpFkGLTTl+enTKjOg53fAnW/EmNFkejvEO65ugkZ/pA6CQQV9hjwmOhac9XbjZzGfPQ/JRMEw8PIomV/gunmf1Q6lMzLBpexWZKHk8YyYesHP1QWLJDE3sEJUoUK+mV0reh3s0fPBpWxy/TK+z2dv07j/DchiCW7xGRaDDSIBDv64xAamZAjqK4xPDG0UkaG+BV7ZUmKhVpSzDr3xzmciTRmNKDHvTxL4VGnTPOnFOrtgx7AqQNtwEqnYx9iHA+3wgQ5z8Y7pYHhnMK3Zpe+wHQrcGe+Lpvp9aRz1yLn2xDgDqk9cdI1IT2N0K9oZHmxKgUKkGuPDkX1oF0oDzRT/Z6XJjXrn51+hcMEI+yl08dpORTc5BFEV6vmQ9VFqGJk6kU1xSFg4ruhWr4v6sN8djwNFE7Zp/5GZit1jvEMc9JxiFcFl6yo9jpTW9HY1e4dLm7nG5J2+jdr7RgkL7H0EWFEby9BophGjWUg==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36092001)(46966005)(8676002)(316002)(426003)(36906005)(42186006)(2906002)(8936002)(2616005)(478600001)(4326008)(70206006)(36756003)(26005)(5660300002)(336012)(82310400002)(15650500001)(83380400001)(47076004)(82740400003)(110136005)(54906003)(70586007)(186003)(356005)(81166007)(86362001)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 10:12:55.9302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4218202f-eed7-42d1-8ae1-08d83aba7427
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT014.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7701
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_06:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070075
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
index a7ee19d27c19..b2275712363d 100644
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
 
@@ -141,15 +145,51 @@ examples:
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
             };
+
+            link@2 {
+                reg = <2>;
+                resets = <&phyrst 4>;
+                #phy-cells = <0>;
+                cdns,phy-type = <PHY_TYPE_SGMII>;
+                cdns,num-lanes = <1>;
+                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
+           };
         };
     };
 ...
-- 
2.26.1

