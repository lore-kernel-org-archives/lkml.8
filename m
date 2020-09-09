Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A388DC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0CB20C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RhkYeL63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgIITDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:03:41 -0400
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:47712
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgIITDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:03:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QD08pYF3AQmKNo/kND8wZOdJxY/NdoZEiwXRrummoIQ4O8LZPjKleK4QsSz/7uuCK4RxsvRyLmH4urrYP2Vma2XR9xehW1mh4SYBNNkBYaWd05qapBpOQuJrZsa1hJztH0aQdYoBJhDPkj8X1IIp8fCp5c5oWHBoZBnH5wbuXkSD3h2W4qZzuhgQWCxk4+Lnmi2SzeuxB6Lrm8QtVLrkqu4F6psX3yD37nuuNjV30LVMZcZUGXa0W8By+0J1ufhdzdhL66Ayaw5h+pknR5hSzRl2GuxBEwuMT9ais4j2wDT6InNLt91wA3b/hQ9f1aXTG+MVmHFISM0AB8NF8O5Izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhjealEO3BVKBna5Y8T3p0WIO9+ZjUIefbSJFBwpDss=;
 b=ZPdUVbLS7EBYrVjznmN5bJsw5RLyhPWzaBk07c/qVdfjn2WZgifidcj2SC4KD2GARJJkxllunDchgDDSC9XNeVa6uEx7gdKcCoMjj81voA6m9Xsu9+bvtrRtUytzyfKbaQYNyHkCsh6bi1sVKCKvYKP997VeDRPYvBYjf1jSI2ISG3Qg7oQ9xjcmBhwp9c42gMeym6EYbsvXuPMnGZbXUvfXJ8f/YiUV/JX1AWPPJYPNKxQxaNl1sYvxhkmc6TKnSDvsx/c3HpSOZjmWwSi3waYcEwj4Plscj7oFatyxTpfgQaTKwCobuVSfL20m7H3nWxHxYNHEC+sdc2SxdMbBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhjealEO3BVKBna5Y8T3p0WIO9+ZjUIefbSJFBwpDss=;
 b=RhkYeL63GzoUIeKg3oBIula7+DPmo+gN8pwsoMXpBOWw7tMZDzvCm/u2IjWq3vHvAwh161Au5Orticl6ZseeKyrVNR8LdzDE5oHhVhi9qMsvfkeVEnMdd8AYOgj5/h1NIp7sTnHxIDOq0ijXh029Em1jqSpGsCk35m9DTRn55cc=
Received: from SN4PR0801CA0010.namprd08.prod.outlook.com
 (2603:10b6:803:29::20) by BYAPR02MB5512.namprd02.prod.outlook.com
 (2603:10b6:a03:9a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 19:03:35 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::9e) by SN4PR0801CA0010.outlook.office365.com
 (2603:10b6:803:29::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 19:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 19:03:35
 +0000
Received: from [149.199.38.66] (port=46166 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kG5NF-0000KA-Jw; Wed, 09 Sep 2020 12:03:17 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kG5NV-0006pq-Nx; Wed, 09 Sep 2020 12:03:33 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1kG5NP-0006oy-85; Wed, 09 Sep 2020 12:03:27 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 76D561210F9; Thu, 10 Sep 2020 00:33:18 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3 Controller
Date:   Thu, 10 Sep 2020 00:33:04 +0530
Message-Id: <1599678185-119412-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
References: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e82c1e3-454b-4f65-81c8-08d854f30d83
X-MS-TrafficTypeDiagnostic: BYAPR02MB5512:
X-Microsoft-Antispam-PRVS: <BYAPR02MB551228B8151EEACD8C01D059C1260@BYAPR02MB5512.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: puPMsmDzAfiXraGczrwsfDiizZ/TpVlrDsL+Pd/6Ps7hOMj57a7eOXTAlkGy4fj99ZeRShRmgmCm508bEwJIOpFgiLT9nYgVZYYSslO35bS4cTVvXZHGwqS1ooKvD7EK6m2zZfEWFvAD2kz/YbuoAfLhhnj3JMMuDlYQaZ4UaEp4aCSfjcb/wd4sA+OwDFyUFhM1Y+1uUxiMQbrmBW/fJzqbXWeNkMdKnj6Zki5BlsnFuEKQDHJOzv2Tn9Fwp4D1/nOd5MMtZ0CcjTWxjGbPYLyEJl4Jf97ZZ4dabT8dNhxDH+CMzNv5tERlmZYNGPqQm94zGjmlxmB0HgaF4NDZwNFFgPPbsrZNnjkJchDI1e8ZM9KKKa+l4G0RBgsJC5T78+1+NDA78GS7hZppMro3TA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(46966005)(81166007)(83380400001)(44832011)(2616005)(47076004)(8936002)(336012)(478600001)(426003)(186003)(107886003)(4326008)(2906002)(26005)(6266002)(70586007)(70206006)(82310400003)(42186006)(8676002)(356005)(82740400003)(6666004)(316002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 19:03:35.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e82c1e3-454b-4f65-81c8-08d854f30d83
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Versal DWC3 controller. Add required property
'reg' for the same. Also add optional properties for snps,dwc3.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/usb/dwc3-xilinx.txt   | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
index 4aae5b2cef56..219b5780dbee 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
@@ -1,7 +1,8 @@
 Xilinx SuperSpeed DWC3 USB SoC controller
 
 Required properties:
-- compatible:	Should contain "xlnx,zynqmp-dwc3"
+- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-dwc3"
+- reg:		Base address and length of the register control block
 - clocks:	A list of phandles for the clocks listed in clock-names
 - clock-names:	Should contain the following:
   "bus_clk"	 Master/Core clock, have to be >= 125 MHz for SS
@@ -13,12 +14,24 @@ Required child node:
 A child node must exist to represent the core DWC3 IP block. The name of
 the node is not important. The content of the node is defined in dwc3.txt.
 
+Optional properties for snps,dwc3:
+- dma-coherent:	Enable this flag if CCI is enabled in design. Adding this
+		flag configures Global SoC bus Configuration Register and
+		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
+- snps,enable-hibernation: Add this flag to enable hibernation support for
+		peripheral mode.
+- interrupt-names: Should contain the following:
+  "dwc_usb3"	USB gadget mode interrupts
+  "otg"		USB OTG mode interrupts
+  "hiber"	USB hibernation interrupts
+
 Example device node:
 
 		usb@0 {
 			#address-cells = <0x2>;
 			#size-cells = <0x1>;
 			compatible = "xlnx,zynqmp-dwc3";
+			reg = <0x0 0xff9d0000 0x0 0x100>;
 			clock-names = "bus_clk" "ref_clk";
 			clocks = <&clk125>, <&clk125>;
 			ranges;
@@ -26,7 +39,10 @@ Example device node:
 			dwc3@fe200000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0xfe200000 0x40000>;
-				interrupts = <0x0 0x41 0x4>;
+				interrupt-names = "dwc_usb3", "otg", "hiber";
+				interrupts = <0 65 4>, <0 69 4>, <0 75 4>;
 				dr_mode = "host";
+				dma-coherent;
+				snps,enable-hibernation;
 			};
 		};
-- 
2.17.1

