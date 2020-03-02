Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C4B22B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bydHTUIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCBVvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:51:07 -0500
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:42849
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbgCBVvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:51:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDKUhgpGMof3YErKCQn0/OjZCPtz8MTSuPpDjeeovPHTUhaJn78CHPAjfK4H0geIHrx0UD6bTaNjIHEQ4EjkF/eYypSBbXHMpZKg8JF4vFdeE8UbP/AeWPZ/NeRIo7rG9K2Kzc9oL80igYHiZUFLtFkSu3L+worxEvRGQw9SckSNiaRUpAxHlODYv4gjvl0MwL6H+m4Wz2/73JtnW10pp+PX9MAXXrMC0f7OF3Fvl0cYa2523k45IJ75oQjC/Q4RlJZLLgUMUvfCJdy4B29xKZPVUdZQ5VogpxV7NuaYUKPzt47shwE3PHJJDAx8YIte6ytThlB4wMrW8KyWwOVBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeK3700B29Xrm0r+nrT9SHIBPOVlJzrE7oOOBaT0oJk=;
 b=Nde0RgFNdwts6Z8JU+iT57EOOZtjfu4nDsYCTckL9PGl+XPSZAAY5veM8fI7vPeoP00wsJvx4wzivctcC4eVW58U/CSlFq3F3bxmgcU3Zbj3X6Ax8Y5I2mlEUqFoVCIB3GYLwE2Ha9TXxQTBODGvkiaS2FzQzzpAjc/2jmSewCXZ397goGLV51B91h2zJYMYKcoWG1lnVtpNuPIaYDgV/TMF0bmQIaxM5LAgXbDeElr0dIN3PisM4/9MEnZ5yfJFkVV7WPmx4ntsWI0XipYUT1QGbrmWJPpEYC28kEsf4LzFEgHpcA8LSfgoLIDD3uzDkiNqg1o7yJfJtdBrDN1oyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=windriver.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeK3700B29Xrm0r+nrT9SHIBPOVlJzrE7oOOBaT0oJk=;
 b=bydHTUIGovcavaYYP6NS8CTnjJGWqV8fBM1LlQQ5yrdlkl6qZ75rDXbSrFMcjFj/JYxmNhKhs+MH80kQOwL20xAvBtU1jdxfa+YMraFbWa4YgeO2GWoPq/zxDNpgQMk9zvLFCS7MLyCKmpVMGs0sCnHlj6N7xRNY1uVVNovvZ48=
Received: from DM6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:5:1b3::26)
 by DM5PR02MB3702.namprd02.prod.outlook.com (2603:10b6:4:b3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 21:51:04 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::fe) by DM6PR17CA0013.outlook.office365.com
 (2603:10b6:5:1b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 21:51:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 21:51:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxr-00022X-Pp; Mon, 02 Mar 2020 13:51:03 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxm-0005jv-Mj; Mon, 02 Mar 2020 13:50:58 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 022Lopoo009844;
        Mon, 2 Mar 2020 13:50:52 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxf-0005fm-PL; Mon, 02 Mar 2020 13:50:51 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@kernel.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v2 4/4] drivers: clk: zynqmp: fix memory leak in zynqmp_register_clocks
Date:   Mon,  2 Mar 2020 13:50:43 -0800
Message-Id: <1583185843-20707-5-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(5660300002)(54906003)(70586007)(186003)(336012)(426003)(26005)(316002)(70206006)(2616005)(356004)(6666004)(4326008)(44832011)(107886003)(8936002)(81166006)(81156014)(8676002)(9786002)(2906002)(7696005)(36756003)(478600001)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3702;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b906819b-7952-403d-c5d3-08d7bef3ce69
X-MS-TrafficTypeDiagnostic: DM5PR02MB3702:
X-Microsoft-Antispam-PRVS: <DM5PR02MB37024135B3FBE9E1D9FAC0F2B8E70@DM5PR02MB3702.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ovpOR00TZ+sBHoTaATXcuolrFFg7dsiE6R2GokATg0aGrAXBZc4nuXA5tKR4ruSPg/OA0CTnRXyiq4EdxHXq1+N7t8dai3Bzrhqef9PceIlCXRXPRhqD/Ut7lu0Rg2XAyV4YcT19cuTYJRdTMiZQkA8peQ/3NLxZyQ4WySU0kKZjFZE35Mv7bRFAbCbBzRqgv7htnu+8zaWvmGf/fcGCk/xnR11wtM0RII/XuuvzJG8/pzlwiKgGU1STQBidaIuqTIByyICOvHBpjCcm7kuTUgEzTa9x7rrqEPvCfHYdrnWlb+sdywD4W4sQNi6LSdlpMCIt1HnbOq/GF+Bw+J9vy3NJLQA/TOrrDwQhJjk010Gg3DqunA9SKb5sIBn94+AYqQf06Mxm7MGN2Xsj9M9C5Mtb/OIuQM6gKinT/uFn6b+JJIpZf/uXJk713EQE+4qO9KBsrfx5p9XEKqhTv11HtsP1IZBPo2xipo3YcoG+I6hQ4ThR45D/IS2rw+3T8A7
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:51:04.3851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b906819b-7952-403d-c5d3-08d7bef3ce69
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

This is detected by kmemleak running on zcu102 board:

unreferenced object 0xffffffc877e48180 (size 128):
comm "swapper/0", pid 1, jiffies 4294892909 (age 315.436s)
hex dump (first 32 bytes):
64 70 5f 76 69 64 65 6f 5f 72 65 66 5f 64 69 76 dp_video_ref_div
31 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1...............
backtrace:
[<00000000c9be883b>] __kmalloc_track_caller+0x200/0x380
[<00000000f02c3809>] kvasprintf+0x7c/0x100
[<00000000e51dde4d>] kasprintf+0x60/0x80
[<0000000092298b05>] zynqmp_register_clocks+0x29c/0x398
[<00000000faaff182>] zynqmp_clock_probe+0x3cc/0x4c0
[<000000005f5986f0>] platform_drv_probe+0x58/0xa8
[<00000000d5810136>] really_probe+0xd8/0x2a8
[<00000000f5b671be>] driver_probe_device+0x5c/0x100
[<0000000038f91fcf>] __device_attach_driver+0x98/0xb8
[<000000008a3f2ac2>] bus_for_each_drv+0x74/0xd8
[<000000001cb2783d>] __device_attach+0xe0/0x140
[<00000000c268031b>] device_initial_probe+0x24/0x30
[<000000006998de4b>] bus_probe_device+0x9c/0xa8
[<00000000647ae6ff>] device_add+0x3c0/0x610
[<0000000071c14bb8>] of_device_add+0x40/0x50
[<000000004bb5d132>] of_platform_device_create_pdata+0xbc/0x138

This is because that when num_nodes is larger than 1, clk_out is
allocated using kasprintf for these nodes but only the last node's
clk_out is freed.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/clkc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index ff2d229..bfc1e7d 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -562,7 +562,7 @@ static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
 {
 	int j;
 	u32 num_nodes, clk_dev_id;
-	char *clk_out = NULL;
+	char *clk_out[MAX_NODES];
 	struct clock_topology *nodes;
 	struct clk_hw *hw = NULL;
 
@@ -576,16 +576,16 @@ static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
 		 * Intermediate clock names are postfixed with type of clock.
 		 */
 		if (j != (num_nodes - 1)) {
-			clk_out = kasprintf(GFP_KERNEL, "%s%s", clk_name,
+			clk_out[j] = kasprintf(GFP_KERNEL, "%s%s", clk_name,
 					    clk_type_postfix[nodes[j].type]);
 		} else {
-			clk_out = kasprintf(GFP_KERNEL, "%s", clk_name);
+			clk_out[j] = kasprintf(GFP_KERNEL, "%s", clk_name);
 		}
 
 		if (!clk_topology[nodes[j].type])
 			continue;
 
-		hw = (*clk_topology[nodes[j].type])(clk_out, clk_dev_id,
+		hw = (*clk_topology[nodes[j].type])(clk_out[j], clk_dev_id,
 						    parent_names,
 						    num_parents,
 						    &nodes[j]);
@@ -594,9 +594,12 @@ static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
 				     __func__,  clk_dev_id, clk_name,
 				     PTR_ERR(hw));
 
-		parent_names[0] = clk_out;
+		parent_names[0] = clk_out[j];
 	}
-	kfree(clk_out);
+
+	for (j = 0; j < num_nodes; j++)
+		kfree(clk_out[j]);
+
 	return hw;
 }
 
-- 
2.7.4

