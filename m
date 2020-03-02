Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C816C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0B122B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="W5rwAl3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCBVvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:51:13 -0500
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:6263
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbgCBVvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:51:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk5EKzCCW71VsyqBOoebQrpm20hQDQ6T3Do2X1DJPFOthTbNniSISTwnhV26GNCDSqleg6iUUihc0k5K5Bd6d1AnTCGDl2Xurtjk3kEGju2Sa06v+ampwfv0wm+LRV+vSyAsWUqUQIALiyKtOgvIIPyELlyewq9g+xZeVCnqgjGE4wkKcyw4w6lZ1Dp1QqPJ5NWfK+OERiqU2TTmpWNiW/YyoiCGj8RM/wlzIWZeGSSe8ROjxPfL6ctYrGiOE1PkrujJe3vxcDGrUbWdGaCAm5DTgum2G6coMfplefiUbNKYhCf0ydL0RrSVp5UBiJouizp4G4gPqcxEVmcVX7mtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VG7ik2C7rir9fl79CtmCZpJuok1GFhef3IymL9aXR4=;
 b=n2eufz7n6EXpnhYElwBWJMFoUD4NehtD7fidWmZWP/aziS/p692SeE+UJ06H35K+yNQHQ9KL2SOdQQTqJisLeQhr2m0VNqLxA5i2F/hQUi9aD0mdBRvmekzfHJW+4XM6sy2MnSmRsXhtVBjYEO6m1LgImxfj6jePwQs/QJtKuq7/ep+6jT5YnXNa0eKB2sDozD6DqTsmwvjyKysD6O3qlGe4slJblFBD9V62hNux4mBr5M1is5LgAYnbtyzE7mIFK2JMpnXhQKpGxoAvMSm5hMU11HVENTNzua8+0A1vZVU5D1U9vJ54D+6E8Mv5UhOBHyJCvMI4r5MJb6brJeKa+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VG7ik2C7rir9fl79CtmCZpJuok1GFhef3IymL9aXR4=;
 b=W5rwAl3quEQFKzmu02tTD9yuT+P/2izWBnr1ptanbqjmEjQj4DsvK/Uoa6qTsuKnDxsR9Eie8C1iObyNPR+ZFXGLrKgJ/gaJOS7HOkhOU0lpjpc9xCBiitPvb9eU2GaY2aGyi2cJJUeZ/oxvyEEGz7BqdypZvjdJnRgI1g+bb0Y=
Received: from CY4PR18CA0068.namprd18.prod.outlook.com (2603:10b6:903:13f::30)
 by CH2PR02MB6680.namprd02.prod.outlook.com (2603:10b6:610:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 21:51:04 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::48) by CY4PR18CA0068.outlook.office365.com
 (2603:10b6:903:13f::30) with Microsoft SMTP Server (version=TLS1_2,
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
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Mon, 2 Mar 2020 21:51:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxs-00022a-2g; Mon, 02 Mar 2020 13:51:04 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxm-0005jv-Vs; Mon, 02 Mar 2020 13:50:59 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 022LopMZ009834;
        Mon, 2 Mar 2020 13:50:51 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sxf-0005fm-HV; Mon, 02 Mar 2020 13:50:51 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@kernel.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v2 0/4] drivers: clk: zynqmp: minor bux fixes for zynqmp clock driver
Date:   Mon,  2 Mar 2020 13:50:39 -0800
Message-Id: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(36756003)(26005)(5660300002)(8936002)(356004)(6666004)(9786002)(4744005)(186003)(81156014)(8676002)(81166006)(2906002)(7696005)(70206006)(478600001)(70586007)(426003)(107886003)(4326008)(44832011)(336012)(2616005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6680;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a49cdfc2-c762-4e48-d031-08d7bef3ce76
X-MS-TrafficTypeDiagnostic: CH2PR02MB6680:
X-Microsoft-Antispam-PRVS: <CH2PR02MB668093D284456AC97EE6572BB8E70@CH2PR02MB6680.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnqcDcTVub6ENu/L/fS9IqoOT4yqdas/4b5R0ThEx/Kl2Xu66LdWqPX3e5zh1NdoKbXFB1gYjG64gmGU9JFcGnTXcegx6wMiulWrfQMvwiach5bsMeJ9rR8AVcBp6BWkCwHdZzN1OGUy8O5v8EafIweN7khUFAvcfowA8Vu2R10nYdNzPsoNGkVT75QcNXV9Mfu6uaqfSBvJphdRMYtAdAD99Vhs10uR9ZO4odNK6ESBQoHYnx2/bZlYqlTBF3ojqxBjmyAIDyFsQ6PL33BA6GK3aqhOT6vST8Q0RHhyouqukavm56nAPn04x/NNhqdCT0nf5dJN76D+F7w1muZJ5JQoSU/x0ZDbnr7F7tt6c2i6HtqjzKcTCvU0EJZQ4Ke63C/yQHnmrxI+GDi0Nx5/T4HT+ndmKL/IC9NoWHAUZNTK4+huAlYhWqGXUINAgRrQ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:51:04.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a49cdfc2-c762-4e48-d031-08d7bef3ce76
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes below fixes for clock driver
1> Fix Divider2 calculation
2> Memory leak in clock registration
3> Fix invalid name queries
4> Limit bestdiv with maxdiv

v2:
 - Updated subject for cover letter and patches 
   to add prefix

Quanyang Wang (1):
  drivers: clk: zynqmp: fix memory leak in zynqmp_register_clocks

Rajan Vaja (2):
  drivers: clk: zynqmp: Limit bestdiv with maxdiv
  drivers: clk: zynqmp: Fix invalid clock name queries

Tejas Patel (1):
  drivers: clk: zynqmp: Fix divider2 calculation

 drivers/clk/zynqmp/clkc.c    | 20 ++++++++++++++------
 drivers/clk/zynqmp/divider.c | 19 ++++++++++++++-----
 2 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.7.4

