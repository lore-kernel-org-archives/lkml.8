Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B94C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49A3207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oiH5dcGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgH1Noj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:44:39 -0400
Received: from mail-co1nam11on2085.outbound.protection.outlook.com ([40.107.220.85]:34272
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729550AbgH1NkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:40:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAtiOIapAHkyQZwq7tGDUIJRolYqwcvWeIU3G+piB3yxkI5tplqY3RsqHrZtLG7pWcVKmAZbgiWqUsiLyBpVtigA3uumxNLgPhhAahfM6mM+orii3CpzLItLLG0pgVnuI8hiQqFx9+XHU1enPdZqUKgzOpP/SNTjrFSs+fWQKB0hj1F0GevhICrUNFYrdjgq9cajrlWX5aubJ6i/ZeJ6xa91bsHCZQPKQTwfQdoF1MGbXe0nV+Sv7yy9aQKbTQU3ENafbc+sqGif/b0p9GGozYVwsWwvnKrTHelrgDJcqoJfJqOehw+0eCoxHj9/WyXSma0mjjnprupSd39tjnWsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CWNw/uFzzcTbbb546rFGvYtEV7r5RGaHTN4/9EQwNQ=;
 b=BWA/BKnXL6mLIW4HcSC34Y8gZeV9M4PHUaATJBbmF5mafdGRdmIPhkVt01I1dD4akPswL1DCglx2YqvWq0BfpW73CVC8R6XxnNeFsfzybDv9AftVjjSwsb5/LCUNXYWPF9LN3jKenAgrrZ9r/T/pDA/Z7pXMpK26Xyuvj/rk9iA5RtvMkxBdBiNKSsmiaa7SFo/3l7us+4BFjBGIHtJcKkHblLSUal+rmA0j7fCkHUEdTLq6p6Fiop3K3lRpS0yVC/PaK74VFBc+jyQL25X+xkG6p8XqROB9NgdQ4HMpZFMB4fGSr8McRi/l/5ycvXhB8Sr7LF2f/YFDzkgFek721w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CWNw/uFzzcTbbb546rFGvYtEV7r5RGaHTN4/9EQwNQ=;
 b=oiH5dcGw4YyeKFZB9aznFaA7vBV3clQqEGsKk0eciR60801eoCRV7mV0wOoNYBgbvUDlA7H5SLXuoUf5gpGfcFOJVuvMWUqjLU7qSv4yQDgSS2TRp7nRXnlSjcUjUCyZBHcTIEiMvSZ1kNMPG5SAB+MDDTqAaK2qq90HYTgsr0I=
Received: from SA9PR11CA0018.namprd11.prod.outlook.com (2603:10b6:806:6e::23)
 by BN6PR02MB2643.namprd02.prod.outlook.com (2603:10b6:404:5c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 13:40:03 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::5a) by SA9PR11CA0018.outlook.office365.com
 (2603:10b6:806:6e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 13:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 13:40:02
 +0000
Received: from [149.199.38.66] (port=57271 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBebI-0004sA-Bs; Fri, 28 Aug 2020 06:39:28 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBebq-0005os-CT; Fri, 28 Aug 2020 06:40:02 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07SDe0EV028008;
        Fri, 28 Aug 2020 06:40:00 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1kBebo-0005it-0V; Fri, 28 Aug 2020 06:40:00 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, sboyd@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v6 0/8] clk: clk-wizard: clock-wizard: Driver updates
Date:   Fri, 28 Aug 2020 19:09:48 +0530
Message-Id: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4e119a77-58c4-4d54-5b62-08d84b57ddc4
X-MS-TrafficTypeDiagnostic: BN6PR02MB2643:
X-Microsoft-Antispam-PRVS: <BN6PR02MB264396CAB12E575E1278416FAA520@BN6PR02MB2643.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIhjjoO/trY2NVqXw0jtmRrui1tUvokzh5BCQh6ShmKvcha19aT3CCFdZuwgQ5HnAZkPo7NdisI3XvdSmPb/e+q0+Fs2rskLTMcv/lKYO79Ernx3hPPCJb71XtKj8Gq1eWlF6Pm/3kRdtiTjLM8lQqFcHSu+Oc4d2meIJzvQbjOT3FrB8tqIszu+FD/hdZc7Q0fJY7WK6KNlAxF4gkj2drclh/v9CcIcXBrMf5zKIt4qCPIPs2qYhsSd3xYW6lbcsg42MS44GwJD4blLYMHrQY80cIeuBXk//bXg8fGfqKuLnLO+E2r5ySI1w+SWudcKxAyWTCPcD7Q3+aHE65ySkrmP/2J6+2ZDj7nM3zkPovA5QnU4/XuNwzPg9ln5aw2olZFH5CiOfJ5VE1ZzR694TSY5S6J5Pxl2LRhDCQACGasN6A1f3qgT6Tul+DLru5fbmQfVYniFpPXzOvA5HjNzevXg+wNO4hQeR9cZwRlbTFZXr71kubiwsVlpRHsfIfyh
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(46966005)(4326008)(356005)(336012)(2616005)(8936002)(44832011)(9786002)(82310400002)(6916009)(8676002)(70586007)(81166007)(107886003)(966005)(186003)(5660300002)(15650500001)(426003)(478600001)(36756003)(7696005)(26005)(70206006)(6666004)(47076004)(82740400003)(2906002)(316002)(83380400001)(42866002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 13:40:02.7696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e119a77-58c4-4d54-5b62-08d84b57ddc4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the thread [1] Greg suggested that we move the driver
to the clk from the staging.
Add patches to address the concerns regarding the fractional and
set rate support in the TODO.

The patch set does the following
- Trivial fixes for kernel doc.
- Move the driver to the clk folder
- Add capability to set rate.
- Add fractional support.
- Add support for configurable outputs.
- Make the output names unique so that multiple instances
do not crib.

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

v6:
Fix the yaml warning
use poll timedout

[1] https://spinics.net/lists/linux-driver-devel/msg117326.html

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
 drivers/clk/clk-xlnx-clock-wizard.c                | 657 +++++++++++++++++++++
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/clocking-wizard/Kconfig            |  10 -
 drivers/staging/clocking-wizard/Makefile           |   2 -
 drivers/staging/clocking-wizard/TODO               |  12 -
 .../clocking-wizard/clk-xlnx-clock-wizard.c        | 333 -----------
 drivers/staging/clocking-wizard/dt-binding.txt     |  30 -
 11 files changed, 738 insertions(+), 390 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
 create mode 100644 drivers/clk/clk-xlnx-clock-wizard.c
 delete mode 100644 drivers/staging/clocking-wizard/Kconfig
 delete mode 100644 drivers/staging/clocking-wizard/Makefile
 delete mode 100644 drivers/staging/clocking-wizard/TODO
 delete mode 100644 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
 delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt

-- 
2.1.1

