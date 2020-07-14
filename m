Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB02EC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3B6221E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="X47Jq5jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGNGWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:22:43 -0400
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:6053
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgGNGWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:22:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMrXDXNZTqcVgJeqXfJ4DS6bb7tO3WoP8jS1vGqlg53+avxLx+nCmvJkJHhjgVSo4AQmqZCOMveiPAlAZpXr5iSuCoVon4TvvsVvNu1gnYoDm3xMcWOkH9RgOwOTvHPrHo68gOv1VL+E3YWxuzwW+yfK9WxFPw5V3HtaYq5Gmmt4pMPWOz59lYoey+QiZzYmUUJ5hwcFatrIrhiqB6tnGK8815R+YZcU4wsJ8JLdyndM4ztRVjQYTc46CL3lIqq0nvJL0tjTNUDm588rM4tzy2OY9Nbz9Fxj5dRO+RNDg88ZVSZKPYWTt50eejruaGhWxD/4pgHGqIOiIH6/UvQ/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK0adPOLWWsmYvHwDukhvpxR7l3vNAdCIKqM4F+wTd8=;
 b=HI4tTirzJ37nn+Zu7hmjadTpmZ00e6R9Kf6khupDIDK5qjv4ma9Jbr27Xa/deXZ7cDk6JaSs+UwjuzBylhCw0icwlLN7mRzxIiMpaQfXWyzEIrJr45AaCgk/v/7g3Es4JVpkWFgm0YG2/xyG0Sg9fVG8xorCnrm2F29oAWi1N6pJgxxAhis6Jh78ik78UInay7m3bmB1KRT+SRb/yuP/dDFwsk/FsmagdqREKX1VUJp3m0lPzMvOhirdKXr19Su99snL/WU3fpqCx+nASMbYYZbvB1OmPvCoZHymUdzpt7phb/Dzt8/iHkOwjI0DDF/9N9Jwi/lveKRL0R7TDr3gkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=avnet.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK0adPOLWWsmYvHwDukhvpxR7l3vNAdCIKqM4F+wTd8=;
 b=X47Jq5jrz6C1b9Li+tb0rn2EuFBPkybLUdfEB9UZpkXjFmDFDRK46gZuzEcyeODnzxvclKTmQR91mD48yfG7gqWp6cuEGEZ1/eGGe8UdmNeA3c03IGp7JygJsnkSKS+Kb+rVA6tbvknFcchgO1JEU9MfmzyetFd6u6Cnf/tR/K4=
Received: from CY4PR13CA0073.namprd13.prod.outlook.com (2603:10b6:903:152::11)
 by BL0PR02MB3668.namprd02.prod.outlook.com (2603:10b6:207:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 06:22:35 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:152:cafe::98) by CY4PR13CA0073.outlook.office365.com
 (2603:10b6:903:152::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend
 Transport; Tue, 14 Jul 2020 06:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; avnet.com; dkim=none (message not signed)
 header.d=none;avnet.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 06:22:34
 +0000
Received: from [149.199.38.66] (port=48879 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jvEJB-00033u-Ic; Mon, 13 Jul 2020 23:20:53 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jvEKo-00046G-03; Mon, 13 Jul 2020 23:22:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmis@xhdsaipava40.xilinx.com>)
        id 1jvEKn-000466-8h; Mon, 13 Jul 2020 23:22:33 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14964)
        id 5FBE013C0574; Tue, 14 Jul 2020 11:59:11 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        saikrishna12468@gmail.com,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal reset driver
Date:   Tue, 14 Jul 2020 11:59:08 +0530
Message-Id: <1594708149-29944-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594708149-29944-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1594708149-29944-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(136003)(376002)(396003)(46966005)(82310400002)(36756003)(6666004)(6266002)(6636002)(107886003)(42186006)(81166007)(83380400001)(478600001)(316002)(110136005)(356005)(186003)(4326008)(5660300002)(82740400003)(2906002)(26005)(2616005)(70586007)(70206006)(8676002)(336012)(47076004)(8936002)(426003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 241974aa-dc06-491f-1fcd-08d827be4c35
X-MS-TrafficTypeDiagnostic: BL0PR02MB3668:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR02MB3668AD6D2811476B73F4FFA2BD610@BL0PR02MB3668.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pijjffJM2MR8e3A4vG/OOCdIuKhFBHmoe0qL9DylY7bjeq0X1gM1vV8V/3OaV0FHKos5c27tg/nOYw150jjAXLkNmqQNRBUygVi+YOrRwdRD+U1QuRuvyDw0Z//v1Sq/G7X37GxU0W4jMB7Xkgv/AHAf3sJMzCVk6EeCv2B+6FWL/PrWKCBmZgjjj6fZfuRSqlAOcGt1D2yMhLQRhcBoEzE6vCcyUcEmm4IiHcswCzcpFyx21hnSzh77T2Ti9NYX9ssmi1/sI8YKOIJdjxWoFR/Uj2sxjRTijsEcbm1OSShpsoAOehgXw7Uw77BWWOSkmmfu8e6aIjytuogBs4KwBNfvDd4E4+2cWBosFHpUmhVE/FqPjmreWOtpd/Aiz85RfQRSit+wQLAJKkqJt7wgcA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 06:22:34.8614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 241974aa-dc06-491f-1fcd-08d827be4c35
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation and Versal reset indices to describe
about Versal reset driver bindings.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 .../bindings/reset/xlnx,zynqmp-reset.txt      |  11 +-
 .../dt-bindings/reset/xlnx-versal-resets.h    | 105 ++++++++++++++++++
 2 files changed, 112 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/reset/xlnx-versal-resets.h

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
index 27a45fe5ecf1..ed836868dbf1 100644
--- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
@@ -1,7 +1,7 @@
 --------------------------------------------------------------------------
- =  Zynq UltraScale+ MPSoC reset driver binding =
+ =  Zynq UltraScale+ MPSoC and Versal reset driver binding =
 --------------------------------------------------------------------------
-The Zynq UltraScale+ MPSoC has several different resets.
+The Zynq UltraScale+ MPSoC and Versal has several different resets.
 
 See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
 about zynqmp resets.
@@ -10,7 +10,8 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 Required Properties:
-- compatible:	"xlnx,zynqmp-reset"
+- compatible:	"xlnx,zynqmp-reset" for Zynq UltraScale+ MPSoC platform
+		"xlnx,versal-reset" for Versal platform
 - #reset-cells:	Specifies the number of cells needed to encode reset
 		line, should be 1
 
@@ -37,8 +38,10 @@ Device nodes that need access to reset lines should
 specify them as a reset phandle in their corresponding node as
 specified in reset.txt.
 
-For list of all valid reset indicies see
+For list of all valid reset indices for Zynq UltraScale+ MPSoC see
 <dt-bindings/reset/xlnx-zynqmp-resets.h>
+For list of all valid reset indices for Versal see
+<dt-bindings/reset/xlnx-versal-resets.h>
 
 Example:
 
diff --git a/include/dt-bindings/reset/xlnx-versal-resets.h b/include/dt-bindings/reset/xlnx-versal-resets.h
new file mode 100644
index 000000000000..895424e9b0e5
--- /dev/null
+++ b/include/dt-bindings/reset/xlnx-versal-resets.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2020 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_VERSAL_RESETS_H
+#define _DT_BINDINGS_VERSAL_RESETS_H
+
+#define VERSAL_RST_PMC_POR			(0xc30c001U)
+#define VERSAL_RST_PMC				(0xc410002U)
+#define VERSAL_RST_PS_POR			(0xc30c003U)
+#define VERSAL_RST_PL_POR			(0xc30c004U)
+#define VERSAL_RST_NOC_POR			(0xc30c005U)
+#define VERSAL_RST_FPD_POR			(0xc30c006U)
+#define VERSAL_RST_ACPU_0_POR			(0xc30c007U)
+#define VERSAL_RST_ACPU_1_POR			(0xc30c008U)
+#define VERSAL_RST_OCM2_POR			(0xc30c009U)
+#define VERSAL_RST_PS_SRST			(0xc41000aU)
+#define VERSAL_RST_PL_SRST			(0xc41000bU)
+#define VERSAL_RST_NOC				(0xc41000cU)
+#define VERSAL_RST_NPI				(0xc41000dU)
+#define VERSAL_RST_SYS_RST_1			(0xc41000eU)
+#define VERSAL_RST_SYS_RST_2			(0xc41000fU)
+#define VERSAL_RST_SYS_RST_3			(0xc410010U)
+#define VERSAL_RST_FPD				(0xc410011U)
+#define VERSAL_RST_PL0				(0xc410012U)
+#define VERSAL_RST_PL1				(0xc410013U)
+#define VERSAL_RST_PL2				(0xc410014U)
+#define VERSAL_RST_PL3				(0xc410015U)
+#define VERSAL_RST_APU				(0xc410016U)
+#define VERSAL_RST_ACPU_0			(0xc410017U)
+#define VERSAL_RST_ACPU_1			(0xc410018U)
+#define VERSAL_RST_ACPU_L2			(0xc410019U)
+#define VERSAL_RST_ACPU_GIC			(0xc41001aU)
+#define VERSAL_RST_RPU_ISLAND			(0xc41001bU)
+#define VERSAL_RST_RPU_AMBA			(0xc41001cU)
+#define VERSAL_RST_R5_0				(0xc41001dU)
+#define VERSAL_RST_R5_1				(0xc41001eU)
+#define VERSAL_RST_SYSMON_PMC_SEQ_RST		(0xc41001fU)
+#define VERSAL_RST_SYSMON_PMC_CFG_RST		(0xc410020U)
+#define VERSAL_RST_SYSMON_FPD_CFG_RST		(0xc410021U)
+#define VERSAL_RST_SYSMON_FPD_SEQ_RST		(0xc410022U)
+#define VERSAL_RST_SYSMON_LPD			(0xc410023U)
+#define VERSAL_RST_PDMA_RST1			(0xc410024U)
+#define VERSAL_RST_PDMA_RST0			(0xc410025U)
+#define VERSAL_RST_ADMA				(0xc410026U)
+#define VERSAL_RST_TIMESTAMP			(0xc410027U)
+#define VERSAL_RST_OCM				(0xc410028U)
+#define VERSAL_RST_OCM2_RST			(0xc410029U)
+#define VERSAL_RST_IPI				(0xc41002aU)
+#define VERSAL_RST_SBI				(0xc41002bU)
+#define VERSAL_RST_LPD				(0xc41002cU)
+#define VERSAL_RST_QSPI				(0xc10402dU)
+#define VERSAL_RST_OSPI				(0xc10402eU)
+#define VERSAL_RST_SDIO_0			(0xc10402fU)
+#define VERSAL_RST_SDIO_1			(0xc104030U)
+#define VERSAL_RST_I2C_PMC			(0xc104031U)
+#define VERSAL_RST_GPIO_PMC			(0xc104032U)
+#define VERSAL_RST_GEM_0			(0xc104033U)
+#define VERSAL_RST_GEM_1			(0xc104034U)
+#define VERSAL_RST_SPARE			(0xc104035U)
+#define VERSAL_RST_USB_0			(0xc104036U)
+#define VERSAL_RST_UART_0			(0xc104037U)
+#define VERSAL_RST_UART_1			(0xc104038U)
+#define VERSAL_RST_SPI_0			(0xc104039U)
+#define VERSAL_RST_SPI_1			(0xc10403aU)
+#define VERSAL_RST_CAN_FD_0			(0xc10403bU)
+#define VERSAL_RST_CAN_FD_1			(0xc10403cU)
+#define VERSAL_RST_I2C_0			(0xc10403dU)
+#define VERSAL_RST_I2C_1			(0xc10403eU)
+#define VERSAL_RST_GPIO_LPD			(0xc10403fU)
+#define VERSAL_RST_TTC_0			(0xc104040U)
+#define VERSAL_RST_TTC_1			(0xc104041U)
+#define VERSAL_RST_TTC_2			(0xc104042U)
+#define VERSAL_RST_TTC_3			(0xc104043U)
+#define VERSAL_RST_SWDT_FPD			(0xc104044U)
+#define VERSAL_RST_SWDT_LPD			(0xc104045U)
+#define VERSAL_RST_USB				(0xc104046U)
+#define VERSAL_RST_DPC				(0xc208047U)
+#define VERSAL_RST_PMCDBG			(0xc208048U)
+#define VERSAL_RST_DBG_TRACE			(0xc208049U)
+#define VERSAL_RST_DBG_FPD			(0xc20804aU)
+#define VERSAL_RST_DBG_TSTMP			(0xc20804bU)
+#define VERSAL_RST_RPU0_DBG			(0xc20804cU)
+#define VERSAL_RST_RPU1_DBG			(0xc20804dU)
+#define VERSAL_RST_HSDP				(0xc20804eU)
+#define VERSAL_RST_DBG_LPD			(0xc20804fU)
+#define VERSAL_RST_CPM_POR			(0xc30c050U)
+#define VERSAL_RST_CPM				(0xc410051U)
+#define VERSAL_RST_CPMDBG			(0xc208052U)
+#define VERSAL_RST_PCIE_CFG			(0xc410053U)
+#define VERSAL_RST_PCIE_CORE0			(0xc410054U)
+#define VERSAL_RST_PCIE_CORE1			(0xc410055U)
+#define VERSAL_RST_PCIE_DMA			(0xc410056U)
+#define VERSAL_RST_CMN				(0xc410057U)
+#define VERSAL_RST_L2_0				(0xc410058U)
+#define VERSAL_RST_L2_1				(0xc410059U)
+#define VERSAL_RST_ADDR_REMAP			(0xc41005aU)
+#define VERSAL_RST_CPI0				(0xc41005bU)
+#define VERSAL_RST_CPI1				(0xc41005cU)
+#define VERSAL_RST_XRAM				(0xc30c05dU)
+#define VERSAL_RST_AIE_ARRAY			(0xc10405eU)
+#define VERSAL_RST_AIE_SHIM			(0xc10405fU)
+
+#endif
-- 
2.17.1

