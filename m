Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0001122B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aKks50wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCBVvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:51:21 -0500
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:50881
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726700AbgCBVvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:51:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTLzRpNB1i3/5zvz4mJ9oErqZ1lgDat7y21oEzbPntfYkCxBVtpAW8wMIw6pjbUItpbclPoW8xjWVlecaduBUCO3rhaWuRAWMwuU3lp0q2zjCDVvYIOtHK+6I4Y2JR3g9h3RoA1CVlxf7aDxFoTvC8ewqKdUjdemwstcnjQfOpIzSxAjF+vY1kX6lghzxuo0xWoucA0zxf4PqimVvZR+BZjEkR8S9up+Z8Dl8nOO4lFlSvZZi65IuO0tER52leXrOYvoN8IzrvekgmjFnF7N81YVJ7hTWVXb+m+GY5Ebju0RYmZBVR64LBSYMSxZd7D2khzCsFMBEd9HBYodPzj6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqm49iQ2f8b5JNhlyypmPgKznqUkoQ8PeMoIK2kXNy0=;
 b=MVkirSrFuc5jgqqCRv63Cax7+I6tK+n8bGpIVZ/sy5IHSiSv3jzdzktUmx11piHSNFECcFo5G84tliWdQeL095Rb22DSSyWcGCXXkLBJkVymGfXPRDsYbPbflhkn3/DUiVEZu14mU+zB/5MElJY7Fta8staIHDzoL3QMQoyxfltJ/6UKBMEMUhLgyROBQeRQ22/QDlzk+kIlsyuubJQCzOu3ZiuOwkVMc6AxtPQ4kwJ+0btLhNiwo6aoEreOvtLUSlUUuXaPg4kJbvTGlKtw5a9jDcabvwjAYYymRH7UBXk8Ci0A3kEEp+lkXY3SAmkO5U4USdWWacIW8zsVOA3LIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqm49iQ2f8b5JNhlyypmPgKznqUkoQ8PeMoIK2kXNy0=;
 b=aKks50wlII2dhklK6Roj0gcmz7VquefHnUHPeaV40vjDmmRgRoyMk9Izzu9WQoBw/Yh/otjSGqC4xF17Wec255XCy3etmKgUwBdO4RHZmX3T+Bo8yAZfeTxK1NPIoVoPW5CTvTBk57oF1DunXI3ssH2UYrfWuFf8fs0P8pyqXc0=
Received: from MN2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:208:e8::33)
 by DM6PR02MB5340.namprd02.prod.outlook.com (2603:10b6:5:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 21:51:05 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::86) by MN2PR20CA0020.outlook.office365.com
 (2603:10b6:208:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Mon, 2 Mar 2020 21:51:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 21:51:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxr-00022Z-Vu; Mon, 02 Mar 2020 13:51:03 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxm-0005jv-Se; Mon, 02 Mar 2020 13:50:58 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 022LopGL018613;
        Mon, 2 Mar 2020 13:50:51 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxf-0005fm-NP; Mon, 02 Mar 2020 13:50:51 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@kernel.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v2 3/4] drivers: clk: zynqmp: Fix invalid clock name queries
Date:   Mon,  2 Mar 2020 13:50:42 -0800
Message-Id: <1583185843-20707-4-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(107886003)(316002)(478600001)(2616005)(336012)(8936002)(8676002)(81156014)(81166006)(44832011)(36756003)(9786002)(426003)(2906002)(186003)(26005)(6666004)(54906003)(70586007)(5660300002)(4326008)(7696005)(356004)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5340;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c7d54bd-edb9-478b-637c-08d7bef3ce90
X-MS-TrafficTypeDiagnostic: DM6PR02MB5340:
X-Microsoft-Antispam-PRVS: <DM6PR02MB53407F4545114F0D29CE233DB8E70@DM6PR02MB5340.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0WrAVdh41JsP0iULhWJkTQMqwRu/kj10/+t0Znh+qwxWT0NuVak5YOaYHajLQ9EG6i3weXIRm8pquLuOFpIT6ojRStl7/TwLuba9vnnRVtaaTXnAM/o0mhD9nbl15Z4meGyldl4dN6GKxJgL77Xympt0zXWu4hNYNL1OlcYeBW44AsqN3trHLpWQi5V/Ut4TGJRK/BFDiHGUeas+JMzRqcbyunPnR96OdqnVPUyEd0a3bQE60LVGaQFhAdfWLADy7XNlWdnDR9kp2QOpYjbeVan81jwo2cKdPgpPN4EVdw+NVwXDGjEtrtFtmeHawioYE8/VqHEhsw48Z8cp3Ge8EUnXQpanGQ4xTImuW7eOTyuF3zsk+rm+AhtMxymWIzR8M3hciqJEgQt/eY/OAvF4NynFXZYgH9tHL/fYo1aPB3Dh6rCVpc4vBatLz66zdql
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:51:04.5862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7d54bd-edb9-478b-637c-08d7bef3ce90
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

The clock driver makes EEMI call to get the name of invalid clk
when executing versal_get_clock_info() function. This results in
error messages.
Added check for validating clock before saving clock attribute and
calling zynqmp_pm_clock_get_name() in versal_get_clock_info() function.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/clkc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index 4dd8413..ff2d229 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -667,6 +667,11 @@ static void zynqmp_get_clock_info(void)
 			continue;
 
 		clock[i].valid = FIELD_GET(CLK_ATTR_VALID, attr.attr[0]);
+		/* skip query for Invalid clock */
+		ret = zynqmp_is_valid_clock(i);
+		if (ret != CLK_ATTR_VALID)
+			continue;
+
 		clock[i].type = FIELD_GET(CLK_ATTR_TYPE, attr.attr[0]) ?
 			CLK_TYPE_EXTERNAL : CLK_TYPE_OUTPUT;
 
-- 
2.7.4

