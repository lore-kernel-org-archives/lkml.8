Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A29C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137982078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="P55jw1aY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgFZMmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:42:03 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:54049
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726901AbgFZMl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:41:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzNStYu2xw/f1TNCZfTmwT8woItRQU/9+pzSfk1HYuXxwCSCQruJ0OwfFZbwEH3GMbzmY9nEfSrZXiXsCXFPLWRKsWZzITxA9eMhjvs9ehg03SYlpBEITTgGNORWG2WK8rtnN8/StKZQG74r0bvNyubNPCcDbLokFCbOCXEDQQ2F3V9kYMsM7sDxhYdxvdaQfuARt70OsxZAPmpEYqWSlP+N8jkZC5Q709bnwxe17IT2BCZTVz1ilkPyB0hdWrDu74/CuGUdQWgPalxjZ+2NxfYeceoCAEicGgX++akzzAcofVn/sIcOU1sY6TW/QTt8Kd7fehMOpeXBLH+s7A9lNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xttYxvx+tMaUfjxat+pezOzemmx8MFoAI0Yc1lI2Xzk=;
 b=eHbcVS5NXOnb6HobWO97wVX9K7Jv52Y9CEBqPg7bMWNcyNkQBzW9CkZWxiDyCoSj70cdwg0fB4lpAW/SLydHdbr3B+Uzbli3iHAiALWmToGSfHN8lembaDWxxuBbcrNKoIBuNhzvAflh8qNUAQVqUVxoUmKSpQLNyC4arEukFnRrXJkY+DbOSiRJPMQrKxCy7tFmI1cicGb9J4H7rQ2AKRdKISTkHw4OsuCKgwC28Lv3G4v+YkSGvWp9ALy77dB2y0JFNMSVJjvLzCnpR91rlyTMo7qd8xG6qcLhPDQbCT4b+1bHGT6D45yYYp+9xWQb4F8sZlq3VlzpEea61a5Odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xttYxvx+tMaUfjxat+pezOzemmx8MFoAI0Yc1lI2Xzk=;
 b=P55jw1aYB2iYsMKubu52jTRv2KwGfjA+UMhO1pp0olPqQJoXiA9cPFFAe0DoO3qJn7mPk9Mo7pjnp/WWcydkdmrKO08YigO6dXxmvbbw/JX31F7hWf/75OctGjEfkHnEIQMgs7PLJRj7CszuRdPppNlmALfxPIh9vSvr+OQPgyI=
Received: from SN4PR0701CA0008.namprd07.prod.outlook.com
 (2603:10b6:803:28::18) by DM6PR02MB5004.namprd02.prod.outlook.com
 (2603:10b6:5:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 12:41:55 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:28:cafe::98) by SN4PR0701CA0008.outlook.office365.com
 (2603:10b6:803:28::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Fri, 26 Jun 2020 12:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 12:41:54
 +0000
Received: from [149.199.38.66] (port=38319 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jonen-0003JR-K2; Fri, 26 Jun 2020 05:40:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jong2-0001Xt-7c; Fri, 26 Jun 2020 05:41:54 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QCfpcW028917;
        Fri, 26 Jun 2020 05:41:51 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jonfz-0001Wm-BM; Fri, 26 Jun 2020 05:41:51 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v4 1/8] dt-bindings: add documentation of xilinx clocking wizard
Date:   Fri, 26 Jun 2020 18:11:37 +0530
Message-Id: <1593175304-4876-2-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(39860400002)(136003)(46966005)(82740400003)(7696005)(6916009)(47076004)(36756003)(8676002)(82310400002)(966005)(5660300002)(478600001)(356005)(316002)(83380400001)(6666004)(8936002)(81166007)(336012)(70206006)(9786002)(2906002)(26005)(70586007)(107886003)(2616005)(186003)(4326008)(426003)(44832011);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b328831-6bf9-41a5-2407-08d819ce4e9d
X-MS-TrafficTypeDiagnostic: DM6PR02MB5004:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5004CDE17562719C2699F624AA930@DM6PR02MB5004.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWiNMEy/wyjbtkkmwx4Aa9i/PYqbwcjdDFOASvV3B/ACHL/qXOdin6VbX4vWv7Nk6nErePTlq9wFoy0MyC3sHwQ6fNABI54KRoI3AEZyQtN+VmB5tMX9qE8VTz3PSXP9lz2o+a5jDbLIWQspU1lofaeXnGuGSdK5AKaeHKdp/Lg0pSMDRKheSsb4JCr9N1g818mDbdgNsyx6X8hSwkFC66zkZPTPTrjXQF8xCObwPUildzJG3Ii6TTwnDPDU88pTo9TgFphBN05vffFjkMG+pMufAnedti8oNm3fakZw5x2A8ZtWVtrwuzv5JbiGGTXQZqcUt1DN5zVfMsLtowmtGakhBzm0Nw9Ee+Jq9h50+8StakM3Bd3DFnMNrbETxFjpuVqXB1ePoWWGW/iOcBDUmdbOA8F4efB3aIW9zWMeEeRZMxdoipJfrYRdy3tkudey8Lqxfnj+qymuwrPrQWEvMgxD0qpoAXgm4UG9eMMK29E=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 12:41:54.5693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b328831-6bf9-41a5-2407-08d819ce4e9d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree binding for the xilinx clocking wizard.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v4:
Move to yaml format

 .../bindings/clock/xlnx,clocking-wizard.yaml       | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
new file mode 100644
index 0000000..5a8e991
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/xlnx,clocking-wiz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx clocking wizard
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+
+description: |
+  The clocking wizard is a soft ip clocking block of Xilinx versal. It
+  reads required input clock frequencies from the devicetree and acts as clock
+  clock output.
+
+select: false
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,clocking-wizard
+          - xlnx,clocking-wizard-6.0
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    description: List of clock specifiers which are external input
+      clocks to the given clock controller.
+    items:
+      - description: clock input
+      - description: axi clock
+
+  clock-names:
+    items:
+      - const: clk_in1
+      - const: s_axi_aclk
+
+  speed-grade:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 2, 3]
+    description:
+      Speed grade of the device.
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - speed-grade
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-generator@40040000 {
+        #clock-cells = <1>;
+        reg = <0x40040000 0x1000>;
+        compatible = "xlnx,clk-wizard-1.0";
+        speed-grade = <1>;
+        clock-names = "clk_in1", "s_axi_aclk";
+        clocks = <&clkc 15>, <&clkc 15>;
+        clock-output-names = "clk_out1", "clk_out2",
+        "clk_out3", "clk_out4", "clk_out5",
+        "clk_out6", "clk_out7";
+    };
+...
-- 
2.1.1

