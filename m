Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F017BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E482465D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qrV0tdp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCBVbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:31:16 -0500
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:3717
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbgCBVbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:31:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjkirfE0Xa5lYrCRoOb5jBuet90bhF4FdEuV/JE8c8AQ+hJf37kXzx0bjTqHxn0gDgEACIE/rm0xVnHFMFLbQduzjy+rw5nJd0IfbEbW3Aqjo47bcgCPacOQ/Bmm7womeZBNoSVPPdnAM2bbX3EJqEedoblZf71TkZ1GTVYjFeTcbU1hC9asL7IE4DXb8Isxl84jaFZHN3dA8xtl7E/yjt0v5HJtBN4orGE1E4jsOzwKSAxnJqiJfkQRAAuTQG1GO8P1brWilVD103/VqXRIWRKkrws4GpjwqDk3x7uXzKzEeXH7lbWRzn+FpHXG68wyKWnkjkb7vnUupXes1FVVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HrgVz3/y0ySSDq7JQZ7fcwCoDpoGXyO9ayyNroquOA=;
 b=JUu9fpQwhOp0XslKNlYxj9Psq69u48/dd72pOzwVJnb/31hFFHgvXuRnQlrSLX+dRoqTV+1Lp0XGGY1dSstP4LzeckygLh0H9+Eae5EXfu4pabAd1sgII8OBFZLj2QSMtN0d1F11YyLtFCrndnxEwF44SYSctpESFrR7LO1sUffjktxdE4uJ58xEdUYDk21XHp6MXKfnr8R8MULTTIQK8f9e+dgEGf/ZvCNz2NC8F2WphRig0c2AQJ+p6V79o1t6JOjsTbO4BZ2cPvj5yIwK3VYSO4stHvp+M4HqlniK7g0X91i7QAANdKeANxBJmwfoD/XmYo3OqH/aMeNsE7x8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HrgVz3/y0ySSDq7JQZ7fcwCoDpoGXyO9ayyNroquOA=;
 b=qrV0tdp1y0DRF7lb2jJNODuZPOK6jMK4vXSACY3P1MAblawJKhY3auNkPwqfLq9Fhw1Uxx+p3aWg8QA/WMjur6iR3/J8nSnji1mX8Qfezk4hmx7/t2YwW1CiCb1g9Q8wtOc4tIOcg5NayvHRJg0+U+PW1aX354tylOSJQqjy/aU=
Received: from BL0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:207:3d::33)
 by DM5PR02MB2540.namprd02.prod.outlook.com (2603:10b6:3:48::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Mon, 2 Mar 2020 21:31:12 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3d:cafe::b8) by BL0PR02CA0056.outlook.office365.com
 (2603:10b6:207:3d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 21:31:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 21:31:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8seb-0001v9-FZ; Mon, 02 Mar 2020 13:31:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8seW-0005hD-CT; Mon, 02 Mar 2020 13:31:04 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 022LUxLn007040;
        Mon, 2 Mar 2020 13:31:00 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8seR-0005dg-Nn; Mon, 02 Mar 2020 13:30:59 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@codeaurora.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 0/2] drivers: clk: zynqmp: Update fraction clock check from custom type flags
Date:   Mon,  2 Mar 2020 13:30:41 -0800
Message-Id: <1583184643-19191-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(8936002)(6666004)(7696005)(356004)(478600001)(15650500001)(186003)(2906002)(26005)(107886003)(316002)(5660300002)(9786002)(426003)(2616005)(36756003)(4744005)(336012)(44832011)(81156014)(81166006)(70206006)(8676002)(4326008)(70586007)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2540;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca3614d-4609-4ef8-8f2e-08d7bef10765
X-MS-TrafficTypeDiagnostic: DM5PR02MB2540:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2540D9F0C1EB6227E0529C0AB8E70@DM5PR02MB2540.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsplRS0lzGjbOL9eAEFqe9zJpDjkrk9Ez1ynPZhbdWavffdnhI939Bpt2poSRKqCnT+uYc+PzS8T+yAiZiB4iIiQQm/yVNVNuQ59OoF+fyFlNb83zNtdl8RcGFWYsqtGgZ8J9qHrFa1FIwOtHpGNw3RUHNK+xacviNrw3dURch2nrJ5G/ImLVEj3POIuLxRtRN3+MDAO0QKtJsasNEIhcZQyvibJjYvpmczk2/tfW3SuokLaS/dC3Hb5Jr1TqAhJsaOENFbmc8pBy1PQogHb7Y3anLVMd9I+Eh9TN/nr+Z8l+loRq6BKIY7sHwplfQec3dodiuse0FHbygdzyRuOsT6D/8mepJPbDxn3XxOM+AXh7fIQlEl5nGcvQpgsTIvrQzLl6lcTzqMzCDfvhKSa/fTSfyOCMkG4c/0jlpSe8iso7uGfM81VhzwsIKmcxA7H8H4csM+6EUYMGtqCWCmMzPb+zmv0p73IGIHNvspvwSA6SuYcWNGwrI8I9GXBmXQh
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:31:11.4935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca3614d-4609-4ef8-8f2e-08d7bef10765
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2540
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for custom type flags passed from
firmware. It also update  fraction clock check from custom type
flags since new firmware pass CLK_FRAC flag as a part of custom flags
instead of clkflags as CLK_FRAC is not common clock framework flag.

This patch series maintains backward compatibility with older version
of firmware.

Rajan Vaja (1):
  drivers: clk: zynqmp: Add support for custom type flags

Tejas Patel (1):
  drivers: clk: zynqmp: Update fraction clock check from custom type
    flags

 drivers/clk/zynqmp/clk-zynqmp.h | 1 +
 drivers/clk/zynqmp/clkc.c       | 4 ++++
 drivers/clk/zynqmp/divider.c    | 6 ++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.7.4

