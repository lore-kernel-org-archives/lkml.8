Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA1C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF8020709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OHPg9CYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCFXtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:49:32 -0500
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:8128
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbgCFXsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:48:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIBZTyo7lIZvu7WssZUcAAC0tL1+PX2/BJBnqXVovqMtvUfFQC0NB3OhGYYS9+WrTgaCe2vQc4Vt13stVbAxEDfSy99qwFwu+qo8P0mVhBb34LW1hZqPgRH6hGf1vINySqkexlER1QRtgXvTCHiMb/f5VxauQB629Dc53Ax74TRrmpgxYk2vJrnVzxdnlxYQSLozkqeALYfARGF1HMV6oTe7OoeZwfDZELpmmSXs12g142ka2FRxqxPvDrMMeTGIjD/f5hvCJrnqamyRBEqIMAlGVN6R6tbKMREJbM3d3RFNdAfpwFBHYI/OJu+9Wfbfoetizi2Iy+qHNH/VI91zpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFyRL44kb7L9IF+WjTtCQ7auUAug8qJIeSDXwd8qJ4k=;
 b=ivJ16vMyZybxgG7KgOumaKCr3mDmpF/1+2b2DFG728GURL+5Mf9VkHrsIbxri6vkCZ2YxyUq6ePJA4C4DgWPqEbLxB5foJYuOwOe2fhq57Y1/XfTsbmRR/3+lqENk1854L6f3WWHHcxhY0ImUkbo0yrzrKQv9hy2PyaBtP9MifTZ4qGJFjji7MMpu3El8PqRlFvwTp1HBMK6jfW2cEYQg4cAjkJEeLD79Z2FjNMcQePuYn3AAZuw4/pIChye3/TTt1B+FBWf5txESUJonIRkADSqs9iuBMISY9VBUIR/rH4Ic1kvVhRyuUkv/+M6uL2rxl/EUg0dOD8Z1edc/IdJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFyRL44kb7L9IF+WjTtCQ7auUAug8qJIeSDXwd8qJ4k=;
 b=OHPg9CYe6GL0S8lem9os8zUJXenAHKdRqxtqqXng4q5OvYe/YWrJRQOAbKnKk5Divcv4lJQKdEA1nLa1mp23XXaK/dMEcLZ3WJf5TdEdiLPEoA2dv3DXH8m7T3Tinuun92agQ41SiYQmyHNOZ+4UltMrGPO9LGfZSRAJ5MlvH9k=
Received: from BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30) by
 CH2PR02MB7031.namprd02.prod.outlook.com (2603:10b6:610:88::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Fri, 6 Mar 2020 23:47:58 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:71:cafe::73) by BL0PR01CA0017.outlook.office365.com
 (2603:10b6:208:71::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Fri, 6 Mar 2020 23:47:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Fri, 6 Mar 2020 23:47:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMhB-0003Q6-Gv; Fri, 06 Mar 2020 15:47:57 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMh6-0002g8-Dl; Fri, 06 Mar 2020 15:47:52 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 026NljP0002385;
        Fri, 6 Mar 2020 15:47:45 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMgz-0002eg-KC; Fri, 06 Mar 2020 15:47:45 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v3 00/24] firmware: xilinx: Add xilinx specific sysfs interface
Date:   Fri,  6 Mar 2020 15:47:08 -0800
Message-Id: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(356004)(6666004)(70206006)(6636002)(4326008)(9786002)(107886003)(70586007)(316002)(7416002)(478600001)(44832011)(36756003)(8676002)(2616005)(336012)(186003)(2906002)(81166006)(81156014)(26005)(7696005)(5660300002)(8936002)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB7031;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cfb587c-f4f2-472e-37e8-08d7c228cc96
X-MS-TrafficTypeDiagnostic: CH2PR02MB7031:
X-Microsoft-Antispam-PRVS: <CH2PR02MB7031692052305D7E4B5E0DA6B8E30@CH2PR02MB7031.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0334223192
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99zQs4Y3ARsCGCYEHon/V6ClVe9twUzVw6mxZGbkFpm1KkkU83mWo+/oEIqa/MoQRwE4x/jU+eLOLuazdot/IPV9rlWUz38djJmUbAYSMNHACALk7Ba36W8wq2BXfzV2hJF8cJqTPHfzJzWPaIlXInEmYhU5/HjGBICBP/lvxYR/8+AfTe/KkuA3cvD8ep9ttTs3l9k5PskQwcZIDDzlN0lRK8rK855/VrvJgPdU9/LfGJaeKqWgoQcjgEaop8AZQriklYucsFIaqRtxLnv65Ea9v9WYqZrLRQXlNnzKaQvEVnOlukF//Da1fVDzkVVWkkRIxg5xPHGNkdK9F1HM9t3IdvVA268+YP3d4SX4GPMwA3zGY7FKXa+xZETyx1d62kNI+O+bXqLN++915rbJiMkGgtZ0/wTe/hJUmGbfa0s565rAbSE0gnsj6DXjtZeT
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:47:58.0689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfb587c-f4f2-472e-37e8-08d7c228cc96
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds xilinx specific sysfs interface for below
purposes:
- Register access
- Set shutdown scope
- Set boot health status bit

Also this patch series removes eemi ops and adds API
corresponding to each eemi ops.

v3:
 - Remove eemi ops function pointers and call real functions
 - For ioctl eemi calls, make actual function calls rather than ioctl api
 
Rajan Vaja (24):
  firmware: xilinx: Remove eemi ops for get_api_version
  firmware: xilinx: Remove eemi ops for get_chipid
  firmware: xilinx: Remove eemi ops for query_data
  firmware: xilinx: Remove eemi ops for clock_enable
  firmware: xilinx: Remove eemi ops for clock_disable
  firmware: xilinx: Remove eemi ops for clock_getstate
  firmware: xilinx: Remove eemi ops for clock_setdivider
  firmware: xilinx: Remove eemi ops for clock_getdivider
  firmware: xilinx: Remove eemi ops for clock set/get rate
  firmware: xilinx: Remove eemi ops for clock set/get parent
  firmware: xilinx: Use APIs instead of IOCTLs
  firmware: xilinx: Remove eemi ops for reset_assert
  firmware: xilinx: Remove eemi ops for reset_get_status
  firmware: xilinx: Remove eemi ops for init_finalize
  firmware: xilinx: Remove eemi ops for set_suspend_mode
  firmware: xilinx: Remove eemi ops for request_node
  firmware: xilinx: Remove eemi ops for release_node
  firmware: xilinx: Remove eemi ops for set_requirement
  firmware: xilinx: Remove eemi ops for fpga related APIs
  firmware: xilinx: Add APIs to read/write GGS/PGGS registers
  firmware: xilinx: Add sysfs interface
  firmware: xilinx: Add system shutdown API interface
  firmware: xilinx: Add sysfs to set shutdown scope
  firmware: xilinx: Add sysfs and API to set boot health status

 .../ABI/stable/sysfs-driver-firmware-zynqmp        | 103 +++
 drivers/clk/zynqmp/clk-gate-zynqmp.c               |   9 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |   6 +-
 drivers/clk/zynqmp/clkc.c                          |  17 +-
 drivers/clk/zynqmp/divider.c                       |  12 +-
 drivers/clk/zynqmp/pll.c                           |  29 +-
 drivers/firmware/xilinx/zynqmp-debug.c             |   5 +-
 drivers/firmware/xilinx/zynqmp.c                   | 806 ++++++++++++++++++---
 drivers/fpga/zynqmp-fpga.c                         |  12 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  33 +-
 drivers/nvmem/zynqmp_nvmem.c                       |  11 +-
 drivers/reset/reset-zynqmp.c                       |  26 +-
 drivers/soc/xilinx/zynqmp_pm_domains.c             |  26 +-
 drivers/soc/xilinx/zynqmp_power.c                  |  17 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   5 -
 include/linux/firmware/xlnx-zynqmp.h               | 102 +--
 16 files changed, 924 insertions(+), 295 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-firmware-zynqmp

-- 
2.7.4

