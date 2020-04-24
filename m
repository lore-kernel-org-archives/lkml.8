Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A041EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A06215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YBacq1mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDXU6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:58:42 -0400
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:6268
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgDXU6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:58:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFsJFLhdXaHLRqoM17w+YbkctteE/zpzx8wUkSflZpd9gEhFs9rnJOQgutFzXG2vPUu89rmHRYTNeYR6Uixd7Ei7HnsmSSKQYuYTCQkwI8LgcBv1hhlqr/g0Kb1yTd57tCOCmSk7r+3E9eA5b88jSnNncFuKbFiQz3nfHCHnHLcYub4QQDeeXoC6FeF9BiRuG9NKrwXhkbTZKL6JoTu8SqyC/COPPtbtsOgtjWSO4s828vK125Hoq21n9QEr3i1HH6t6qLl7myDv2vTKCUR1bD9Eltkf26NyCwjBdblbHhyBF9ghouB1DgAFqoaKRI19hSX/PxfZZpCDLdg9HyfHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acWc2I6Xs67ghY7S/dwta4iGFi6tEzaOMLTDaIq1DeE=;
 b=dNGSogwUW5A974dGJpHZIuXC8XHl+tsxnXbVKftOKdnsHuvlSFoKod1qDfyGs4Dn0jCp5kYeOJazIPwSsRQBdO8hlugzcIpdqxUVsnMse9RZbirO0IpYu81LuC1NheuV6VAgCwBfEBLcD+NkZjccemXBxj8AQ0tTMHobk68owWIKX1PLJpT07BgQLCQIaMV5u6ImHN4TePzx5MgSBtMqOGnie7xG4IVRAYNCP/73h4FyUFHbQVxU/kr2cLR/8LBMsDRCwOsqgDAp0C2cDjYW3FmNMEEfVk35WgPKR1upqTekSV3C1WoBClKJYgefIvzYQOYUZjDmCqnO8czKVBSqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acWc2I6Xs67ghY7S/dwta4iGFi6tEzaOMLTDaIq1DeE=;
 b=YBacq1mRS5i9LHj2SpMhlQRjZ/EIAILUqEncWg9rqr4scTQB/032ijA/0dwLmWEYV4Iz9ajSWR0tJZrWU6xp+H5E4vZXOM8yHtX4q25TqDLdR8WoglqjtoMsRzO9byWlrxjVgwwTEmYtd3qMNMOAXq7OdmLqcP2KOxHEN6gSp6U=
Received: from MN2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:208:e8::36)
 by BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 20:58:22 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::44) by MN2PR20CA0023.outlook.office365.com
 (2603:10b6:208:e8::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 20:58:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 20:58:22
 +0000
Received: from [149.199.38.66] (port=33308 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Nm-0002D9-PK; Fri, 24 Apr 2020 13:57:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Ov-0007N4-OZ; Fri, 24 Apr 2020 13:58:21 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OKwIYi030377;
        Fri, 24 Apr 2020 13:58:18 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Os-0007Lo-KJ; Fri, 24 Apr 2020 13:58:18 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v5 00/25] firmware: xilinx: Add xilinx specific sysfs interface
Date:   Fri, 24 Apr 2020 13:57:42 -0700
Message-Id: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(36756003)(8676002)(478600001)(82740400003)(316002)(5660300002)(7416002)(47076004)(6636002)(81156014)(26005)(966005)(7696005)(8936002)(2906002)(9786002)(336012)(426003)(2616005)(82310400002)(4326008)(44832011)(107886003)(70586007)(356005)(70206006)(6666004)(81166007)(186003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 266d1a6b-2a91-4552-3ff5-08d7e892396f
X-MS-TrafficTypeDiagnostic: BL0PR02MB4564:
X-Microsoft-Antispam-PRVS: <BL0PR02MB45648C0ECECC260A5676D2AAB8D00@BL0PR02MB4564.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeYmCMIAF83jSur9HQx8wgNtyZ3VRY+maPYMVo1LckeIxGvfeh2qzvfXdCCfwv7lbpYYIV0izv7F2kCiuUUdm1wU8YvVfYHob4J0ZVMFuYdU6kgG9uEoX2+gZ2rmMOz0eEyjY+QAU6zwu8+eCEG24MNV1nMIKpa8epk+6A/edQtWnQPj1fZ0oKffKcGrP8LBCXbj/lGIBt6wlDjpZAhfw+e2zYTqWfAJ4tASuT47YCr7RSZ59DG3tia+seWqLQESHwBa4vwuZ2S2V1ddZjkwXE96ea/qYgak+7Na9UZgCBvBTepsQPXDOFu7Iyj3H5aUOughiQ8tBLzs584PxV16HqwJD/HkpFToNLASVGTo4XRH+qajBSgijpWJCj+n0AJHQW/nKHjPT41Oeu1efAbKWqE+XftNJtcN8Kqs+oRSDz9+lIuyyi39+qG0dCATCMfuSnd40VnL/5I0vxMZQFz0EjbDnviSHJl1FKdkkxNkqcWgpfJ+iFT42+vlddqKotde+X0ULnwAfrxpRK93a5QBbzdNtdmpMAmJ0c0TOswSBqRGJh1mdfzjNBxNfV8lA6hUmv++uN93Sxrp3/na30RcUA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 20:58:22.2536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 266d1a6b-2a91-4552-3ff5-08d7e892396f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4564
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

It depends on below patchset which fixes firmware driver Kconfig dependency.
https://github.com/torvalds/linux/commit/d0384eedcde21276ac51f57c641f875605024b32#diff-96cbd6396181cd8c25ea5d838c5590ba

Rajan Vaja (25):
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
  firmware: xilinx: Remove eemi ops for aes engine
  firmware: xilinx: Remove eemi ops for fpga related APIs
  firmware: xilinx: Add APIs to read/write GGS/PGGS registers
  firmware: xilinx: Add sysfs interface
  firmware: xilinx: Add system shutdown API interface
  firmware: xilinx: Add sysfs to set shutdown scope
  firmware: xilinx: Add sysfs and API to set boot health status

 .../ABI/stable/sysfs-driver-firmware-zynqmp        | 103 ++++
 drivers/clk/zynqmp/clk-gate-zynqmp.c               |   9 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |   6 +-
 drivers/clk/zynqmp/clkc.c                          |  17 +-
 drivers/clk/zynqmp/divider.c                       |  12 +-
 drivers/clk/zynqmp/pll.c                           |  29 +-
 drivers/crypto/xilinx/zynqmp-aes-gcm.c             |  12 +-
 drivers/firmware/xilinx/zynqmp-debug.c             |   5 +-
 drivers/firmware/xilinx/zynqmp.c                   | 601 +++++++++++++++++----
 drivers/fpga/zynqmp-fpga.c                         |  14 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  38 +-
 drivers/nvmem/zynqmp_nvmem.c                       |  11 +-
 drivers/reset/reset-zynqmp.c                       |  26 +-
 drivers/soc/xilinx/zynqmp_pm_domains.c             |  26 +-
 drivers/soc/xilinx/zynqmp_power.c                  |  17 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   5 -
 include/linux/firmware/xlnx-zynqmp.h               | 237 ++++++--
 17 files changed, 862 insertions(+), 306 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-firmware-zynqmp

--
Changes in v5:
 - [PATCH 21/26]:
   - Fix compilation warning.
Changes in v4:
 - Rebased on latest repository.
 - Resolve compilation errors from patch #1 - #20.
 - Add patch #19 to remove eemi ops for aes engine.
 - [PATCH 11/25]:
   - Add API for SD DLL reset.
   - Rebase on latest repository.
 - [PATCH 21/25]:
   - Use explicit values for enums.
 - [PATCH 22/25]:
   - Remove function header for static functions.
   - Remove unnecessary condition checks.
   - Use one value per file.
   - Use ATTRIBUTE_GROUPS() macro for assigning attribute groups.
   - Remove unnecessary inclusion of header file.
 - [PATCH 23/25]:
   - Use explicit values for enums.
 - [PATCH 24/25]:
   - Use ATTRIBUTE_GROUPS() macro for assigning attribute groups.
 - [PATCH 25/25]:
   - Use dev_err() instead of pr_err().
   - Use ATTRIBUTE_GROUPS() macro for assigning attribute groups.
Changes in v3:
 - add patch #1/24 to #11/24 and #12/24 to #20/24 to remove eemi apis
   and use direct function call.
 - Add patch #11/24 to use ZynqMP APIs of IOCTLs instead of IOCTLs
   and remove IOCTLs for ZynqMP.
 - Add patch #20/24 to add APIs for read/write GGS and PGGS registers.
 - [PATCH 21/24]:
   - Add GGS sysfs interface in zynqmp.c file instead of zynqmp_ggs.c.
   - Use platform device directory for sysfs instead of creating new
     directory in firmware.
   - Change kernel version to 5.6.
   - Set count variable to the error value instead of testing ret
     variable at the end of function to store GGS/PGGS.
   - Use ZynqMP firmware API for write/read PGGS and GGS instead of
     ioctls.
   - Use platform device attribute off instead of creating new kobject.
   - Change Date field in documentation.
 - [PATCH 23/24]:
   - Use platform device directory for sysfs instead of creating new
     directory in firmware.
   - Change kernel version to 5.6.
   - Change Date field in documentation.
 - [PATCH 24/24]:
   - Use platform device directory for sysfs instead of creating new
     directory in firmware.
   - Change kernel version to 5.6.
   - Change Date field in documentation.
   - Add eemi API to set boot health status instead of IOCTL.
Changes in v2:
 - Removed patch #1 for register access sysfs.
 - Updated kernel version in documentation.
 - Used DEVICE_ATTR_* and ATTRIBUTE_GROUPS macros.
 - Correct typo
 - Free Kobject structure in case of error.
 - Resolved smatch errors.
 - Updated Signed-off-by sequence.
-- 
2.7.4

