Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C757C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507D620707
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rZ2K57pY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgFZR4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:56:37 -0400
Received: from mail-eopbgr690083.outbound.protection.outlook.com ([40.107.69.83]:3321
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgFZR4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:56:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9zqxw1sER4PbdY0eBrGVL7/9MeMOSjMiHVoeXPyOErb2EhTniZY79R03QFFr/B+LE5Xgk7tDiAD/TlYbL1L1MS7PJZwx2IbjCAS19f+hu5kjlzp3++zexmaiwFmR8/ZqQ79kHVuATTQUh0Lt18JXKIPPV/2vV4jTlKR8SlvtWD/LIAIyTYxCCmiUG7e51z7T9kejG1jx6XMHKStySgOlTrLgLhdbG+M6W7tIeIMBNKr6rymWbUVBjnxwULztVKRFGbS2MSqrPbFJQ/vLyf1YLZFRf+HCR2X80I0H/hPEOZqGCzqRQ/vESGtFu3AzrRBT6c9MuBTepiBAOsNE2bsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIsywR3Ktlo3hc13C1nL4hDH+4WZ7uNglCBlnNTp9D4=;
 b=NDVXI6ESBfRnP3kvQam2ipea/r8gIteTn1MLC2YGefR9Pc5nEYZivPaV7hFmZhXMNhmXsU7NQdaXrGHgZLZygZzkwDbuvy+01J78na9rxC41PZBbvcOPHibvxRLBw/0gsblfSt6uVtprv7fdexJpbsnBhdz6wuZSQ5EdAMAUrZX8KSZSszS7T3NmW848lA7zOwA9xmuhL7IUh6d+foleY9jy3IMR61bF89puyb9CkEk0ZM3aNIsJlNxpQD04TXhKPx5O1ee7uk9Ufs+6FXnvnNsMU0OmghGiFsTcfl/V9UlFSj30RfGuZXLYPmW4d6ahA+lsdrjqcJDdjDclRdX8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIsywR3Ktlo3hc13C1nL4hDH+4WZ7uNglCBlnNTp9D4=;
 b=rZ2K57pYKkbGhyHbtMOBruUr1xWogn9IvHHA4ZcXxGht9OGjlkx5pYYK4q8HGIdO30j4ll9cDw5o5BnrjdPKKS3JqeJc+zX1v86vkQlUrkZB0y+n1/H3Mfmtjan15DH2GhpAsLdAN6pNvtdL4Kd60FKzU32S+FZF7xwwDvYfi4s=
Received: from MN2PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:160::21)
 by MN2PR02MB7006.namprd02.prod.outlook.com (2603:10b6:208:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 17:56:31 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:160:cafe::35) by MN2PR13CA0008.outlook.office365.com
 (2603:10b6:208:160::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.10 via Frontend
 Transport; Fri, 26 Jun 2020 17:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 17:56:31
 +0000
Received: from [149.199.38.66] (port=52942 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1josZF-0004fi-SG; Fri, 26 Jun 2020 10:55:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1josaU-0007qA-Q5; Fri, 26 Jun 2020 10:56:30 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05QHuT76000749;
        Fri, 26 Jun 2020 10:56:29 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1josaT-0007oR-35; Fri, 26 Jun 2020 10:56:29 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v4 0/8] clk: clockwizard: Driver updates
Date:   Fri, 26 Jun 2020 23:26:17 +0530
Message-Id: <1593194185-22394-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(396003)(39860400002)(136003)(346002)(46966005)(15650500001)(2616005)(316002)(47076004)(82310400002)(356005)(81166007)(336012)(82740400003)(26005)(186003)(426003)(8936002)(8676002)(9786002)(7696005)(36756003)(70586007)(2906002)(478600001)(44832011)(83380400001)(70206006)(5660300002)(6916009)(6666004)(107886003)(4326008);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5e77ff35-4edc-4ddb-899f-08d819fa41f6
X-MS-TrafficTypeDiagnostic: MN2PR02MB7006:
X-Microsoft-Antispam-PRVS: <MN2PR02MB7006504A6F3C1222BB8ABA5AAA930@MN2PR02MB7006.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxBCVrgUjsSfo0bZYGRv/ynrGCGrLpWo90LG+gY3CsOCtugdjAaGIcYCwiLGQvwWXko0qvrRkIVRxzY0EttCr2K1PbtkVM/0aFCoNqUWFHYrkZ+VeoMIRVTkuYBcjkhi0WbOA3gcQK4H3MR5lrCvMp0lGlQoKYNSyRssAG7sWSt1tx15Y/AhDQZsHf7fnddR1UwJkxYDpzf/b3oscbeFJdm8YX+j+PuhbYWM10pXGuM39MwHOMQzu7KDQe6NoPtf29+1bg7N/npAKWz6Mg4KLfiA4+0pLbPEtMT8DQbUOmRf1Vw55m+Uc+qoPoMvvuEO/n7G8NAAYFg27joTf4v4jFbAXk+8Jmq467H3iAZbb8Yuv5xVH6rM1ejlonS5k+yRJMH7vVzyzFnCNwOcnec6/A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 17:56:31.2009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e77ff35-4edc-4ddb-899f-08d819fa41f6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7006
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

v5:
Fix a mismerge

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

