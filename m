Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F09BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0542078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="A9MOVtUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgHZSpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:45:00 -0400
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:1856
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbgHZSo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:44:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEvVhLYL9kJpfffw8kJ5G45zxEkvTuehdl7oeaQxFAaEQ98NwT4dIQwSrhcobqmofYnySWdSOocwSViJnBebQKIt3Qi7KPd4e3vYdCKIq1C5FliSTTyLhpAnkEdDpAHZ5XWwdzkBGCke9PRuK+ks2X11jesNd0z0vB3HUhXK7NygxrwboRgmZmDkw81OFn5ymzVkc9578n2pXlj9gRfw5OfB+ySSf9gG0cZN5sLA1bR7/zD54w2LBifUe4qs7XkqerndKvZezru0VjTkc6N99Gp8Si+BiSvav8Aoq3Qdj14UEK9F2/hkXwu8QCnz5hrlSZaNgiCB389NO7CwgA3moA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpHGlYodSNLJW9Wkf6iuj1QvEy5dG85QvCKTkIywIg0=;
 b=MYTcAmb15yO6sG9uxGiUtPzscI/ZY1Fp75GyM9NEe9Lk6bIzj0naOI8QaS1opo4ke9+rwZJSBSX9j0KtsKSbe9a+p9ipDYLtrTH2/q1tn5JBO5eKWWVIAwH2Zmh2AUrkuHdqLAYpxFlyS5GHjWc34TUWqI/perrIPOF3jp62lAY7aG59Xr9FXIz3vFdWZd2VoIEvSrkX7iIP7iahBqxw8e5VsGpb0Ja5opB1Dph5GUm8ZLW1a6WvNngJZhQx32b9IkudPNC+/NBKqskK6fa5V87FW1EC58lFphqkYl1sG/BeRfcZpk7ns3EfrODyVDExlQF8Canp1c8MQI6yB9i9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpHGlYodSNLJW9Wkf6iuj1QvEy5dG85QvCKTkIywIg0=;
 b=A9MOVtUX+S+LsvM9RKjgg2k0ycA4cAS7IDGcTzfGLA33NEBaXXcfhhneYU13UhSf4Zv7Vqma3ot30Nphc1UGaKJYQMePmCg345VNhAQrlhYeh5aEEola9gkS1+bho6o+AqC0pr8WkoWtpqvwMRcAmSQnTbU5nqiFC4hlA9+XhjE=
Received: from BL0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:2d::19)
 by BY5PR02MB6290.namprd02.prod.outlook.com (2603:10b6:a03:1b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 18:44:53 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2d:cafe::e) by BL0PR03CA0006.outlook.office365.com
 (2603:10b6:208:2d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 18:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 18:44:52
 +0000
Received: from [149.199.38.66] (port=58352 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kB0PE-0000lw-Sa; Wed, 26 Aug 2020 11:44:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kB0Pj-0008RA-W7; Wed, 26 Aug 2020 11:44:52 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07QIifbe011691;
        Wed, 26 Aug 2020 11:44:41 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1kB0PZ-0008Pe-Bs; Wed, 26 Aug 2020 11:44:41 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 6BF5F12116C; Thu, 27 Aug 2020 00:14:29 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3 Controller
Date:   Thu, 27 Aug 2020 00:14:00 +0530
Message-Id: <1598467441-124203-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e53ee87e-adb1-4db6-eb4a-08d849f01e6a
X-MS-TrafficTypeDiagnostic: BY5PR02MB6290:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6290A93EF74737237B6A1600C1540@BY5PR02MB6290.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YZpm+LEhj9hEIy1meyLfAmw8GCjZmi7DbqFY9e6eHjoaDdOMUIdR+y8IMhY5/ZonFQdfPfw7u2+hFvz6RQbcVTxT6Lm1s/HC+OVPapBYBOVlOcowbPL3s784DzEuWgo9FBOO79SejvtTH3Rgap+bjSTPXRexad9cbNMSHNKCgXjCAsPN0XGJgzp+y8o9N6nPHEAR08bPwsn7t6gHjvFNkLkFTOkDTPGuc1Gtt9SkPDwefEYrdMPykBXY3ohA6bqnv5+wLzU9LotDnKB2nf6vmT1avvEOaPIoi6lleHzQsfERfWMmfPoI/ld5UsfX5s8GTRtVVH1HpemnBvC16cqsnAYUnuFULO4+PuBsZPulxpltkBvYJScNP6YngKsAxPHbM8SW8m2lBQjvNFTizmCmQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:ErrorRetry;CAT:NONE;SFS:(346002)(396003)(136003)(39860400002)(376002)(46966005)(186003)(8676002)(42186006)(6666004)(316002)(26005)(336012)(36756003)(47076004)(82740400003)(82310400002)(107886003)(356005)(70586007)(83380400001)(426003)(8936002)(81166007)(70206006)(2616005)(4326008)(6266002)(5660300002)(44832011)(2906002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 18:44:52.3927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e53ee87e-adb1-4db6-eb4a-08d849f01e6a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Versal DWC3 controller. Add required property
'reg' for the same. Also add optional properties for snps,dwc3.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/usb/dwc3-xilinx.txt          | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
index 4aae5b2cef56..dd41ed831411 100644
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
@@ -13,12 +14,19 @@ Required child node:
 A child node must exist to represent the core DWC3 IP block. The name of
 the node is not important. The content of the node is defined in dwc3.txt.
 
+Optional properties for snps,dwc3:
+- dma-coherent:	Enable this flag if CCI is enabled in design. Adding this
+		flag configures Global SoC bus Configuration Register and
+		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
+- interrupt-names: This property provides the names of the interrupt ids used
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
@@ -26,7 +34,9 @@ Example device node:
 			dwc3@fe200000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0xfe200000 0x40000>;
+				interrupt-name = "dwc_usb3";
 				interrupts = <0x0 0x41 0x4>;
 				dr_mode = "host";
+				dma-coherent;
 			};
 		};
-- 
2.17.1

