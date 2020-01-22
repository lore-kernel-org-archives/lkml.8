Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9489C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C435205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="AdLhwD7i";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="W9yJFjCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgAVKql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:46:41 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51522 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729550AbgAVKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:41 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAipjs016477;
        Wed, 22 Jan 2020 02:45:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=jt24LAgJoPuhisP7Pz4lQJFeCAfB/TZkGBR/VGkui3E=;
 b=AdLhwD7iPFoZAvzpP+LdYEv6CB/i43PvxgWTaqSQSmI4XAckbRkzlgLqubXTujVQPDng
 FRbZ6FIXU8sqEN3GDEICUWvI9utp9JtWYUXimXtqkZVEY4nl5PFitgqS+iHHazBk578c
 inuIJB2PpyV/zkR6xaj+DtYlc5L2+9g6uRQmB/gKnv3Myav0KTFhDpLY5imglzqsO1C5
 PrcjZw1YbutH7gKNYrE+F4Jv6UPA8GxuYW4AVERU6KJ6Mic6lSgKdSYkHKE64HhSdN7W
 bTVTZogwKvPNziqxV9H8Dl0Uoee6qnAgTb6MQu1rqzREE3cKMZiNGUJ9/WbllO6ECN3g kw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xkxg3vssy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q22fAU41QsItmUyBpO0YYWGdDf3dOzuKGjU73BTiIDt8vdNaPXx+7PT967FOn+Ys6xav9r1U20fYzDJiTS+f11+K5weihdgZzYyLS3nn+rWCaJohJ+AntcSUFSJg0uchHnz5q0rtaaI2IldoQBVQLkMpbVIkjHLM2aulCdvFdsrBS4scgGrFGc6GiNsXB5/1gpEkGs9bJ03KGHWgLXetKD1AK36AijKkzjjjV2v+V1fC0D5bXVawvQ0b9FGZSMEwMrKiWuS4UuEvN+EU4mQMue4e4EMajrL21Y45goZjf9SQbe5U9kh+OylAi8qCUZNwNLpnyHmBMMUO+ehG3E/Tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt24LAgJoPuhisP7Pz4lQJFeCAfB/TZkGBR/VGkui3E=;
 b=IdyRB/q3vYN05yUMR55EeFj93va2TDVS/4OFnMRXExIQd8nuZYf/k9sAHGeou2KSHnX9/NbKz9E78B0WsJOv5TMW5z3oGqrBgMX73ph5CK0YbHJa2uF73ETzwChncY3S4Z+tLCVM7bhAAWAJou0Jx8vwPhQ/TJnJeh84ifp6E7sz4+QHOtplo2liFrMKCkb9K4mVP2KXsrRt/UaPHypIeHqZyjGNGXdQaqceNSEiPVnrIiGn4HqKmn3O/zWmfFIX7mhbPWiJ5dQV+oapeLgekbZx74BjHX87yR48aA/EIn1CD9oAcylhXYGceyTJ7hZy+I45F/jNIkCIPIjkzrs2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt24LAgJoPuhisP7Pz4lQJFeCAfB/TZkGBR/VGkui3E=;
 b=W9yJFjCRiICgXz+TTe8zYOOsJlJAKR/2DwHRo4GcWW/2N6I87mFOveE23BUiGmMvpQlsoxGuj6FPegep7rsujRqJVgjpgLJgkK5+r1uZrq+c6dr9Iw+c37MVL2lG95tIQXjTYDnI9gorchTI4fyly4Hi193zBJ9Kby0/QmIYtdg=
Received: from BYAPR07CA0063.namprd07.prod.outlook.com (2603:10b6:a03:60::40)
 by DM6PR07MB6555.namprd07.prod.outlook.com (2603:10b6:5:1c8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Wed, 22 Jan
 2020 10:45:31 +0000
Received: from DM6NAM12FT007.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::200) by BYAPR07CA0063.outlook.office365.com
 (2603:10b6:a03:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM6NAM12FT007.mail.protection.outlook.com (10.13.178.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBM001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:29 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:25 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:25 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjOVT007342;
        Wed, 22 Jan 2020 11:45:24 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjOaD007341;
        Wed, 22 Jan 2020 11:45:24 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 13/14] dt-bindings: phy: phy-cadence-torrent: Add subnode bindings.
Date:   Wed, 22 Jan 2020 11:45:17 +0100
Message-ID: <1579689918-7181-14-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(199004)(189003)(36092001)(246002)(107886003)(478600001)(8936002)(26826003)(7636002)(336012)(5660300002)(70206006)(26005)(186003)(70586007)(8676002)(86362001)(316002)(54906003)(2906002)(110136005)(2616005)(426003)(6666004)(42186006)(356004)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6555;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8403e19-6390-46e5-1274-08d79f283370
X-MS-TrafficTypeDiagnostic: DM6PR07MB6555:
X-Microsoft-Antispam-PRVS: <DM6PR07MB655522DB8106E54F663F70C5D20C0@DM6PR07MB6555.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mw6qCIiTWaNFvSiy/6rxKxWZXb9DO+NdTKCefwyEpKVktfnrCAmnM0mhChSqT9YRwGo9F1DqBpxD2Rv14BgTHLCMqJhfT3eEMAS2J7Ef2Y5NlX8j00IwBGvQuEy47P85wA7On14q8AfeTrgEbFi8HbCHc7VXaTUNgdqMfviP06LDqvsr04ioMfS0QlNkPubeqo6laTZqeAyRAErpTVvpLeL3KFpAi9CrcDVzg21c8UIsyfiM0tUIhz8o9RXxkWZQhBmburEQVXjcTBDuk9r/MzRVGhCiX+p3megOhBB4Iztj3B0HzQJnK91kzk3MoaN+pCl8S3myRHpaHcfds/fGAfx+48s47ePuvB/LYgBWPY+8lK0ZP6zRvqxbZdMMyTqLEWgnFCxhDzjz9asp3qTTEEkVsyf2S3FKT0sXnpGlQUQvL1s3f/PEzJHy+fvUCe3fkBm6uy2zdyVgNH6jEIxrhEVSC0EXCEMr3bqR+TPufk0UAfZOKT90n2+3ygvwgY6E
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:30.5606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8403e19-6390-46e5-1274-08d79f283370
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6555
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

From: Swapnil Jakhade <sjakhade@cadence.com>

Add sub-node bindings for each group of PHY lanes based on PHY
type. Only PHY_TYPE_DP is supported currently. Each sub-node
includes properties such as master lane number, link reset, phy
type, number of lanes etc.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../bindings/phy/phy-cadence-torrent.yaml          | 90 ++++++++++++++++++----
 1 file changed, 73 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index dbb8aa5..eb21615 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -19,6 +19,12 @@ properties:
       - cdns,torrent-phy
       - ti,j721e-serdes-10g
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   clocks:
     maxItems: 1
     description:
@@ -41,44 +47,94 @@ properties:
       - const: torrent_phy
       - const: dptx_phy
 
-  "#phy-cells":
-    const: 0
+  resets:
+    description:
+      Must contain an entry for each in reset-names.
+      See Documentation/devicetree/bindings/reset/reset.txt
 
-  num_lanes:
+  reset-names:
     description:
-      Number of DisplayPort lanes.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [1, 2, 4]
+      Must be "torrent_reset". It controls the reset to the
+      torrent PHY.
 
-  max_bit_rate:
+patternProperties:
+  '^torrent-phy@[0-7]+$':
+    type: object
     description:
-      Maximum DisplayPort link bit rate to use, in Mbps
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
+      Each group of PHY lanes with a single master lane should be represented as a sub-node.
+    properties:
+      reg:
+        description:
+          The master lane number. This is the lowest numbered lane in the lane group.
+
+      resets:
+        description:
+          Contains list of resets to get all the link lanes out of reset.
+
+      "#phy-cells":
+        description:
+          Generic PHY binding.
+        const: 0
+
+      cdns,phy-type:
+        description:
+          Should be PHY_TYPE_DP.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      cdns,num-lanes:
+        description:
+          Number of DisplayPort lanes.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [1, 2, 4]
+
+      cdns,max-bit-rate:
+        description:
+          Maximum DisplayPort link bit rate to use, in Mbps
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
+
+    required:
+      - reg
+      - resets
+      - "#phy-cells"
+      - cdns,phy-type
 
 required:
   - compatible
+  - "#address-cells"
+  - "#size-cells"
   - clocks
   - clock-names
   - reg
   - reg-names
-  - "#phy-cells"
+  - resets
+  - reset-names
 
 additionalProperties: false
 
 examples:
   - |
-    dp_phy: phy@f0fb500000 {
+    #include <dt-bindings/phy/phy.h>
+    torrent_phy: phy@f0fb500000 {
           compatible = "cdns,torrent-phy";
           reg = <0xf0 0xfb500000 0x0 0x00100000>,
                 <0xf0 0xfb030a00 0x0 0x00000040>;
           reg-names = "torrent_phy", "dptx_phy";
-          num_lanes = <4>;
-          max_bit_rate = <8100>;
-          #phy-cells = <0>;
+          resets = <&phyrst 0>;
+          reset-names = "torrent_reset";
           clocks = <&ref_clk>;
           clock-names = "refclk";
+          #address-cells = <1>;
+          #size-cells = <0>;
+          torrent_phy_dp: torrent-phy@0 {
+                    reg = <0>;
+                    resets = <&phyrst 1>;
+                    #phy-cells = <0>;
+                    cdns,phy-type = <PHY_TYPE_DP>;
+                    cdns,num-lanes = <4>;
+                    cdns,max-bit-rate = <8100>;
+          };
     };
 ...
-- 
2.4.5

