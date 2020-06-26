Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ECAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F32078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FgfN13zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgFZMl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:41:59 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:7663
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgFZMl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:41:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBcM80Xm8GhFh27M4wKUJ9t+WmMxWWcE0aPZm272kfc9z0J9UDlwOtk8a05GUrKqNqTfPRM8TTz1emytL8Wka55fMdQEUAhrim9sLC8J8DHxi/XVBE1Sm5zHcURaEysDiHSuezNsd5/1VN7Xhr8t4FidneOs4QuKIw5JmeoWd2KxCOu+6EAgNbwZmyH9qhvVrEM/NNq3+uDG5M0KQECqmsb4mqlam9tCD+hu4HuIYtrMk0do72JVjgbF0cmbF3kQ9wTy8dfGMyhZ0jg9HbBUvUDn4/xYRLuNBaZHH81iIwZzcs7pc5COoTdRR/Bk8NJjGIAUmJnqmJRtTLVMJj9mgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C9jO54KhXvXkXe7t1q2Pc53IfnBYxCCz+i6/rzBXqY=;
 b=ZXxB3Vg+9qBrqf+xR/q5wUwDCtUnVfOf62QsOLUm+NExx4t6IvgUSEzNB6t/BTfWM2CG0XL/bKpaD7eOOZeMDupDFB0WFLkASek7rLzwvRVv9CDFe8kUx1Req7OWSyzpcx6Utj6TGtx8CElKV6+IlFf+zvqTtFYZsqaMFi7x/LpHfxmbkpSgcp4gUG3DFxvcOC1vfbo19UShYesCuZUJbGT7hTdqWhaLcOYetYgcmluw2SYNJIcX3/sMyXHYS9f8XWyuPoVf3HplMGezCiKDaLd3kNwRv/vpYuVsvllKGHIjrgRpzUQSRS/S4v9u4CCRQMcsKiVlsnWYd6jy/7XOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C9jO54KhXvXkXe7t1q2Pc53IfnBYxCCz+i6/rzBXqY=;
 b=FgfN13zXBLyxS+kNt9vMK4KsVwWNHTM//RLZ1lZZB5utZWqFMPaEGKJgXoBsIZECeSUHuZTfJFinBXiJ8GcBujLl7lOimt8niluYKsjooqJAz9CHQ1CDowruKXPfK8Cbx/24W9gbI/DhF9e43HumKhVnR4/jsb2SXnGEtNT+JPw=
Received: from SN4PR0201CA0066.namprd02.prod.outlook.com
 (2603:10b6:803:20::28) by DM6PR02MB6557.namprd02.prod.outlook.com
 (2603:10b6:5:1be::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 12:41:54 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:20::4) by SN4PR0201CA0066.outlook.office365.com
 (2603:10b6:803:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 12:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 12:41:54
 +0000
Received: from [149.199.38.66] (port=38327 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jonen-0003JV-O2; Fri, 26 Jun 2020 05:40:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jong2-0001Xt-C9; Fri, 26 Jun 2020 05:41:54 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QCfmrf029178;
        Fri, 26 Jun 2020 05:41:48 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1jonfw-0001Wm-9z; Fri, 26 Jun 2020 05:41:48 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v4 0/8] clk: clockwizard: Driver updates
Date:   Fri, 26 Jun 2020 18:11:36 +0530
Message-Id: <1593175304-4876-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(136003)(376002)(396003)(46966005)(44832011)(107886003)(356005)(82310400002)(26005)(83380400001)(36756003)(7696005)(4326008)(70586007)(186003)(2906002)(478600001)(81166007)(426003)(82740400003)(70206006)(2616005)(316002)(336012)(47076004)(9786002)(6916009)(5660300002)(8936002)(8676002)(15650500001)(6666004)(42866002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b173eb98-f08e-4708-d457-08d819ce4eaa
X-MS-TrafficTypeDiagnostic: DM6PR02MB6557:
X-Microsoft-Antispam-PRVS: <DM6PR02MB65570247CD6C344639045337AA930@DM6PR02MB6557.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcSStLGp7t8Zvffjm33TlTu0Duug+83rqIL35RaB0eIATNUxKLERomlcnBxALhlm2sqoElmDqtmx65XYTyYK5Os+fMyS/f9VbgxQEMfYw6edL6ZGda6hWYQMCIm0nDDGxFJyLB/hdYKP72eg+912O76/Vf4K784v67xMdHnrYJ0NMmAeSRGjmW3IETEi0cFMLSvcnWPNGaAbpifXCQK274K8+b2f0HZMSKs1QvDQNcWP8RqsIink/C8ovgWOXyZ84f7b1i625V/wXppwdrx1h4Z2ZsE+0eEbOAPD0X0GcBilx540ZOoL+YnQvXiqJN1abazcCAYQB3L8Dcsz4Bj5sF/6NWuV+jLAh/GAYriW3+NAmTZ0DAAB29s3kxOyGMM3e+Sqr7dC2EnaqfxiZ4RnrbK5N/1wEUyjO5s+pS0pdqA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 12:41:54.6590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b173eb98-f08e-4708-d457-08d819ce4eaa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg suggested that we move the driver
to the clk from the staging.
Add patches to address the concerns regarding the fractional and
set rate support in the TODO.

The patch set does the following
- Trivial fixes for kernel doc.
- Move the driver to the clk folder
- Add capability to set rate.
- Add fractional support.
- Add support for configurable outputs.

Changes in the v3:
Added the cover-letter.
Add patches for rate setting and fractional support
Add patches for warning.
Remove the driver from staging as suggested

v4:
Reorder the patches.
Merge the CLK_IS_BASIC patch.
Add the yaml form of binding document


Shubhrajyoti Datta (8):
  dt-bindings: add documentation of xilinx clocking wizard
  clk: clock-wizard: Add the clockwizard to clk directory
  clk: clock-wizard: Fix kernel-doc warning
  clk: clock-wizard: Add support for dynamic reconfiguration
  clk: clock-wizard: Add support for fractional support
  clk: clock-wizard: Remove the hardcoding of the clock outputs
  clk: clock-wizard: Update the fixed factor divisors
  staging: clocking-wizard: Delete the driver from the staging

 .../bindings/clock/xlnx,clocking-wizard.yaml       |  71 +++
 drivers/clk/Kconfig                                |   9 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-xlnx-clock-wizard.c                | 710 +++++++++++++++++++++
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/clocking-wizard/Kconfig            |  10 -
 drivers/staging/clocking-wizard/Makefile           |   2 -
 drivers/staging/clocking-wizard/TODO               |  12 -
 .../clocking-wizard/clk-xlnx-clock-wizard.c        | 333 ----------
 drivers/staging/clocking-wizard/dt-binding.txt     |  30 -
 11 files changed, 791 insertions(+), 390 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
 create mode 100644 drivers/clk/clk-xlnx-clock-wizard.c
 delete mode 100644 drivers/staging/clocking-wizard/Kconfig
 delete mode 100644 drivers/staging/clocking-wizard/Makefile
 delete mode 100644 drivers/staging/clocking-wizard/TODO
 delete mode 100644 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
 delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt

-- 
2.1.1

