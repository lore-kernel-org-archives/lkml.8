Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E99C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526AC2465D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YQIzrUSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCBVn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:43:56 -0500
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:1600
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbgCBVnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:43:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4E5l0ybgyDjuXRdKZV/UvNKXYTmbru78/5q2l7JTj17SwBnUi5LJH7bhSJ5xtBSQI+FlpnucoZixqOQpApi4Kih7jPCZ98MJ0ENWskb7ugQMgI07SG+y1NtAtGRQqyKFY52j9/SXHxn9otEhJ1WuAHBrlHEOIzh02g2uBzSacmyINHEdvMpWVXi6eU/iNai9zN40nfCsUH6DnCH97NBuiFjJlUfgJ8u6YqxtWKOsqj7Xgg9rtGWnpJtAXEvPRl4NGtUlXuPk4XV4HnkqQBsAZgxvrLRw+gPDGNxlRwder/HUlIoIDD5+UweM8CI+dPTS7L3XHPDfiI0z6//GcKoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKguYXdmTR0W6sNGc8gK3q5BRscRZZWMCQvEaWccbXc=;
 b=BbxCcp1hXpeVl087mEhTwePfL1eo0JlOESD67BrLhmJ3eZH7/NUcics6XrErAA7/0H08LIdYuxWLyldaZtBy+rJ1ELPXmloYcXdcJyBww/tQn/yL0rdukKxpAELghg8TMs9wcDZhaccdKIhv/z0LeZBn81O0t8Y8EaAL7/EltCjWH/7Oa+oLavmsCm2/KP3DEAbstoME0g4jITPW+qyIKEs10cdilptAgVfCaIM2h1eR+tYUBWMfO0KnyTzArwQRM0Pk8CQn5Wow58cmF6KUPMD1JmVPyiz42yzQPa5CHP4QMM22ZyrJ64W4DXG7l9fs5u9niIsdsFlRsJd3YDZlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKguYXdmTR0W6sNGc8gK3q5BRscRZZWMCQvEaWccbXc=;
 b=YQIzrUSSvmCra/d/v+EOvVUx0D+lkMDyQmr/RA+QQfa2L9o5oDLqqtSCtCj9oH7jZg1QImL6Mwbc/LHqMah+1R29ZFCz7UKgIxSJggE9TbD9igPvULcSj6RMiHzi6L95sXn8ZgoLFFAhMDnIvvzMXC0SEkcyDbU4MjQzv0TeecI=
Received: from CY4PR21CA0015.namprd21.prod.outlook.com (2603:10b6:903:dd::25)
 by SN6PR02MB4432.namprd02.prod.outlook.com (2603:10b6:805:a5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 21:43:53 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:dd::4) by CY4PR21CA0015.outlook.office365.com
 (2603:10b6:903:dd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.4 via Frontend
 Transport; Mon, 2 Mar 2020 21:43:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 21:43:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8squ-00020C-8M; Mon, 02 Mar 2020 13:43:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sqp-00033f-5B; Mon, 02 Mar 2020 13:43:47 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 022LhiBa006053;
        Mon, 2 Mar 2020 13:43:44 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sqm-00032V-Kq; Mon, 02 Mar 2020 13:43:44 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@kernel.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 0/4] Clock driver fixes
Date:   Mon,  2 Mar 2020 13:43:30 -0800
Message-Id: <1583185414-20106-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(8676002)(4744005)(81166006)(26005)(81156014)(2616005)(2906002)(7696005)(426003)(8936002)(336012)(6666004)(356004)(9786002)(186003)(44832011)(36756003)(5660300002)(70586007)(107886003)(70206006)(4326008)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4432;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68a12ae4-d2fa-4c76-81b7-08d7bef2cd13
X-MS-TrafficTypeDiagnostic: SN6PR02MB4432:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4432EF31D00D5C4E7CA013F5B8E70@SN6PR02MB4432.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yasSRkDke6YFyEEFTgzHqNCJUwpHu6ombDDK4pYdrEQhmPb2z5yPbIjwfHPPWu5ZsqYBjlAkys0WqEi4ydNRWpC3v8qXJGaVJtdwsEA14Df+V1+xvptdSKp3iuv0UipeeVrFfyrkire4j5JiEOzMQp0w+uKPjcEDcK6Gc1Q+AtoQZ49TIDc/GWHPY4iSwURdzlz2vSehnJbp97JLwyDLN838GkirEYiX+g2Sj/jhbL+goRkU3ydWMUMFiccuDNMnko/bmvMyJfoefP31r3xxgD/9L/C0ymjDFeZzsXkzJ69FV89LHpRn356cULoO6+/nMbqlwtmrEcTu6h4vi+A8UaiQWa4/irPXCmOMSpQrK3nZMbFt/jvUryIhyu444wL84UTIxyzreXVcAH9bGjzVfMITPLvKfXq2OIpWszbKMlNnRQF/hvZ1zk1nL+w0bqo3
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:43:52.6894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a12ae4-d2fa-4c76-81b7-08d7bef2cd13
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes below fixes for clock driver
1> Fix Divider2 calculation 
2> Memory leak in clock registration
3> Fix invalid name queries
4> Limit bestdiv with maxdiv

Quanyang Wang (1):
  clk: zynqmp: fix memory leak in zynqmp_register_clocks

Rajan Vaja (2):
  clk: zynqmp: Limit bestdiv with maxdiv
  drivers: clk: Fix invalid clock name queries

Tejas Patel (1):
  drivers: clk: zynqmp: Fix divider2 calculation

 drivers/clk/zynqmp/clkc.c    | 20 ++++++++++++++------
 drivers/clk/zynqmp/divider.c | 19 ++++++++++++++-----
 2 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.7.4

