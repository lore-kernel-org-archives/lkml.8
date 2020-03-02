Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF072C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777B722B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="D4JHE1Ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCBVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:44:04 -0500
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:6172
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbgCBVn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:43:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ7UmoSNFxu+yK6EeIiQ+cnxQ2W9ojDNL7D7I7gT0nLSKwCHP2xvN+IVdqLZ8ZKJkuCbI9stgNNbQxNQJsNtU2qmtUpN6EOiyMfePmhEW/VLvcVy0IFLw/Id3CLRL/30jALcLjVgKY3yhrfsi9QGjNSWRRwXgBdzEC/X89uw7vEp3ciBXbHp86e0kSZrTqs3fZ2l3aRmxTc+ZsICWTUOISIQ/fp0fQ7cMNmEtK+JGdDhDdj5BLqCvPB/cQUn7mH8tyHCgAle7XTueLnltkRao9mSgKc8ylgbn7ZYreVWX+b87uvCi1QiI56OtV5XFjpQhXlQkfWUeKRduwwGsfIvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeK3700B29Xrm0r+nrT9SHIBPOVlJzrE7oOOBaT0oJk=;
 b=oD7hk/nce0QIROeXsYdRXIc+72seRu9Xg5oEA/mZgYIAZXXx5FflsXHYP1fJwcZ7Hl9MXnbgkkbkvQVud1SN+5fVo74cn1TdV1UiyvBLvkbbcNpy2s4nQaTz/rws8r95tTAm3pcGcQpmxOcR8VIaAjPU5Ln5d0mBA5vB762k82EwVAvihw5JjbNV5mDxpsfsrwjd7vReDJRL7sx+cECr0icxR6hxPVO01T4n6ek/AvYUVUxvp4ImYemKTpC0+dEUnW0gXGaUTbLR2jQ5tnEjMoZH8efHcrDVUvZAifc+N+u8WLDg3s6P/2gSce4HZGgeCL9vxK7keRgts4JV60BKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=windriver.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeK3700B29Xrm0r+nrT9SHIBPOVlJzrE7oOOBaT0oJk=;
 b=D4JHE1CavJzdnJBA2zCkWVWqnPcuVDubqz1bDr7pJTGD96kweagKzrhQvia0nr+7YlkB0g1PG8WZzz8Kkqn89GZaFnJ9vpQVHrRzi/g0XUWyPbdm3PTzaR9q2ymP28EaqeQIELLJmei8MGUIsFhpU40WDxKarb26RAunkYoCpjA=
Received: from CY4PR1701CA0003.namprd17.prod.outlook.com
 (2603:10b6:910:5e::13) by BYAPR02MB4727.namprd02.prod.outlook.com
 (2603:10b6:a03:4b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 21:43:53 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:5e:cafe::be) by CY4PR1701CA0003.outlook.office365.com
 (2603:10b6:910:5e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 21:43:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 21:43:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8squ-00020E-EI; Mon, 02 Mar 2020 13:43:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sqp-00033f-Az; Mon, 02 Mar 2020 13:43:47 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 022LhiPt014635;
        Mon, 2 Mar 2020 13:43:45 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sqm-00032V-RJ; Mon, 02 Mar 2020 13:43:44 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@kernel.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 4/4] clk: zynqmp: fix memory leak in zynqmp_register_clocks
Date:   Mon,  2 Mar 2020 13:43:34 -0800
Message-Id: <1583185414-20106-5-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583185414-20106-1-git-send-email-jolly.shah@xilinx.com>
References: <1583185414-20106-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(478600001)(8676002)(4326008)(186003)(26005)(81166006)(81156014)(44832011)(9786002)(2906002)(426003)(316002)(336012)(2616005)(54906003)(70586007)(36756003)(70206006)(107886003)(7696005)(6666004)(356004)(5660300002)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4727;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e6142dc-0ec8-44ca-dbed-08d7bef2cd34
X-MS-TrafficTypeDiagnostic: BYAPR02MB4727:
X-Microsoft-Antispam-PRVS: <BYAPR02MB47279737EF195269DB33276AB8E70@BYAPR02MB4727.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/K0i9DW6uA9mruhsjonG43lIW6O7ygzqVrF2hHLEzZ6krY3kZ20okeBcGdoAL2Vu2i7qWNAXB7sMF8UZtv2n92HLIArYxqCFU2aTkRwebSv7PttPnZvh+9B8TeBnG+TopnYS8OUQtUPGumfpjpMLkvg9sRcrN1so9rCRZpW66HNlMWpzVAoyTg/FoYdWPg5d8TT8/JROnULi2eQ4SV1n7nwrHU2XQ0W6idNGXT7ntkfl51i/wt7i4i4FRrwYlnnWxvFgB5tZ9snYZzGXO32+0aOjAnPsqxh8dvtf3nyNKyUkS3YvK3+pTAfcgGQUDU+UaoyaalCSTQNUsAh5B2wbGn+JYkrzNAyFqUoQfsSRitN0r80KqpLfk3ERxyIjr0jByUV8Y6pDn8jcgwhQxdX6mFoeSPDs1/kTV6CmfOeCFEviPsSqVRNmzGKHqYC3oGIMGm27rRaSJMLwkN90H62b6pTkIAbPqWBUQgfQxRXMTCrjAd932chLCUUG5XHOaKi
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:43:52.8629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6142dc-0ec8-44ca-dbed-08d7bef2cd34
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4727
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

