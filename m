Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2D8C3F2D8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B722465D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Y1b1dIR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgCBVvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:51:08 -0500
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:34247
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgCBVvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:51:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOZq6tTRqiBdP+y9eiYIGjybgFYZbzNQZV+Qt/holNV0LhiVK1Ba0+QQhC5kT9z1rVUkpUI2l0Unj1c9eF3Jm9yz9tFtks2+rBiw35rfFgTJ8twKzDK6syDKs9Ze4C/PuVinGUF15aUfW7Y0kzTRhOwz/eHGs0nDzHZzRbSQaFg8nxiPn9+vRn3MwXPZ/lb9DagFQ9sJOiKKdbwvRuBf/rw+CwKjEN0mGUk3ZVb3MA8doxw9dld0MgLf9NrpeiY4e1Ay7zp4DUBBlT6lQ8L25hUMnpR475W1sqCMrd3/sPltAmFBHcXGvKO0K5/bv9C+kXkaqizV9PQyusRLTQVEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/xVlYc/R+TRQOYmwrrZgcBT+Cj5ANkycUcVaN5jcRg=;
 b=S1Bk+4vBeOqvM5lEIebaS5f2y6gXZjoWiz+ptsjPjAvh5C1YPtwsFFHShZ4QyB/NR7e4hN5lP2kD6eMS1FjV7WZUfiFvMEY+gpjvW/uSQhUcRHGnzOmRBe+C4fWB4owr8NjzxAezSFGpfDUWZadYCgXi6PTvU5C9ablm9AOztOOUfrDCQpifAuTXDEE6y8RQmRP5jj6YSEImGZStJRa9hy4V4N3tWw2spTuDV9fiiASfSTSXjsBUSPXQzd+0YGK14tRr+WSwyOA/F+6LhRV6vCPd7KldtLXDK+eNYW+c/bLtKLfY2jSSuYadol7j/FS9cwwr8tI5BP8TnsLOkCGOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/xVlYc/R+TRQOYmwrrZgcBT+Cj5ANkycUcVaN5jcRg=;
 b=Y1b1dIR7GetVB9CE9bFytF3WS51jekDqI+ymSX3dHwijiOycHuAdqNL2kTG4wVhurhhLM9r1AbcyHVf71sfEoUmbTpAlc3lJMZz3uNHvuTMbTaoMnaehjhvpRl3aXxqTO2Iuv4gi6HUAPyC3dJs+e1tWDNiEVKE3Gg/D+ZP98lg=
Received: from CY4PR21CA0022.namprd21.prod.outlook.com (2603:10b6:903:dd::32)
 by DM5PR0201MB3607.namprd02.prod.outlook.com (2603:10b6:4:77::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 21:51:05 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:dd:cafe::74) by CY4PR21CA0022.outlook.office365.com
 (2603:10b6:903:dd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.2 via Frontend
 Transport; Mon, 2 Mar 2020 21:51:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 21:51:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxr-00022Y-RF; Mon, 02 Mar 2020 13:51:03 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxm-0005jv-OF; Mon, 02 Mar 2020 13:50:58 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 022Lops6009838;
        Mon, 2 Mar 2020 13:50:51 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxf-0005fm-JR; Mon, 02 Mar 2020 13:50:51 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@kernel.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v2 1/4] drivers: clk: zynqmp: Limit bestdiv with maxdiv
Date:   Mon,  2 Mar 2020 13:50:40 -0800
Message-Id: <1583185843-20707-2-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(107886003)(336012)(5660300002)(2906002)(356004)(6666004)(4744005)(316002)(70206006)(44832011)(8936002)(426003)(478600001)(36756003)(9786002)(70586007)(81156014)(81166006)(8676002)(7696005)(186003)(26005)(54906003)(2616005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3607;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ac7238-35b9-413c-85c1-08d7bef3ce99
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3607:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3607A8F4077ADBFDE19ED1D5B8E70@DM5PR0201MB3607.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agpgrUPPk6TKZQvp8603OK+YBXQrhHSe2WUqi7DWwrPgH+Le8XpWL7VWlfzYc9N/4PGTP8PxVb5apN/DuIHqogTckFB6mABYJWoTREKJy7ZkMY0aqb5/+er9b/2s4RbQhXPB2vZKBOqxv0jxHfbTzlH9o3JzrWDGL1RNwx7SEHgzsInSGWJg+g/S3zZidU01r+cHCBaY/jYIw6w3g445H6ocw3JNL8GKQrKRu5JW4bOnhhJttc/frXbJ07LRfxMbxAriW9JfbhBXUMtXh1TuS2gr5qep3H2i0HILVOF2D3ZSUuXAxX4Q2HVYN7L5HFkb/tVOut0eDMaD3GmrYdg9nO7lKL/nJBqbPQ3YnwcQkNKSfxz2hHArVSCNr9y9P1hsrnLlSrIlKhVkYap2m8iDDDLH9VO6cjagAx16KrvqogdG7UTll540LOzyaiaxcfaH
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:51:04.7421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ac7238-35b9-413c-85c1-08d7bef3ce99
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Clock divider value should not be greater than maximum divider value.
So use minimum of best divider or maximum divider value.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 973cdf0..7d2cb61 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -198,6 +198,8 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 
 	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
 		bestdiv = rate % *prate ? 1 : bestdiv;
+
+	bestdiv = min_t(u32, bestdiv, divider->max_div);
 	*prate = rate * bestdiv;
 
 	return rate;
-- 
2.7.4

