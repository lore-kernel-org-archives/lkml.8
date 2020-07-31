Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2F6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D502245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ohn08pLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbgGaQsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:48:31 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:41632
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732658AbgGaQsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:48:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrmQ0M3xFsM3HJcfwLkk8FBT8IsvGcbwF39pBWoJBhH+ANvilQKQN7Bm7oP3Muuqj+4Wl25dD868wgDaUDrmqlJ58gFDuZUkKu7VRv5683bz+5p+22DaZ1QMkfKvLPvl0Uyu5l/PrZ2V+U9XHo1vLUQ+jU3AeWR1OvCIUwjEntmVy+pGYeummtmiVGmfoDg5c5vhI+0etIt8gORCsjE0FtpN0xKo1HYe1jFXIuf0NIvnN4ycjaHKDBYW2Fql7wMEMxyXAuVENLLJl3fBqO6LtGlcA03/4oBLEZc6KJqfX/7qunYx66C9fCtHC7DpQgX9l1hLAG7ll3d2wG8Lz2k1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5d94TgSa4M8MQ1VX9OA8UHgRroMxWhC2XC1oYMNfl4=;
 b=UMpZHnU8NU20xhRenQav8TOPCmxGA8vFS2Ubz4lccfy7UzF+LZpnkP7t2Ozc5iXc8UMk7sPfcR+tCsPFr2TeVSHavuLdmvnPFQXhgSp+dTU0aF+l/rzFvYlW/qeJ/+zARRnIZC0RKhDpxbkrb2YHfOvQiGVPzj7fBfGNaLS/k2a7XvYP4frNQCl9KyT0nYV7VW3x2fvoimn4dNV60zGxtMNrPWetXrz2WaKD/LhmgvIgg6oop+btEeSQjOYij8Z3c7WNHs1ow5K2IbYIypSA/n1AA9Kwm0Yyh3BDieQ/pyFDE6uHGWeXDjPySvyXF3Xj7YgqCRUkf5SUvsnHaTam0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5d94TgSa4M8MQ1VX9OA8UHgRroMxWhC2XC1oYMNfl4=;
 b=Ohn08pLCXDt+P1zz6KpXYMy0v9p3nakhjH5bLnXc5PgBu23BDItJ6bzZCaHDAQCH7PVIkHyRdcBYBYpiuEg6/uNer/yb7ouqWhGH6yJBBNlJfANdTEdEqCdkctQLjZv4rxNUqY15N3TO3lmoDR2lR9WeQ+guPScIfLXLd8V5gYg=
Received: from MN2PR19CA0003.namprd19.prod.outlook.com (2603:10b6:208:178::16)
 by CH2PR02MB6711.namprd02.prod.outlook.com (2603:10b6:610:ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 16:48:06 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:178:cafe::de) by MN2PR19CA0003.outlook.office365.com
 (2603:10b6:208:178::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Fri, 31 Jul 2020 16:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 16:48:06
 +0000
Received: from [149.199.38.66] (port=41019 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YAS-0006bs-G1; Fri, 31 Jul 2020 09:46:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCU-0007o7-2n; Fri, 31 Jul 2020 09:48:06 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06VGlt5i021512;
        Fri, 31 Jul 2020 09:47:55 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCI-0007jL-Tg; Fri, 31 Jul 2020 09:47:54 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michal.simek@xilinx.com
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] Provide basic driver to control Arm R5 co-processor found on
Date:   Fri, 31 Jul 2020 09:47:49 -0700
Message-Id: <20200731164754.20505-1-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d4fcc4d3-4f8d-4d84-2f0a-08d835717fcb
X-MS-TrafficTypeDiagnostic: CH2PR02MB6711:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6711126E8AF5283CAAFD2557B54E0@CH2PR02MB6711.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK5wO7mGLAd1F9uqY073kO/k8N2yzmpY8F8ijsPqzryN6yu9bCx1eNNBerPDf/385lfHqghfzlFBDA2+1dhzp0sh9fU0b1fxnUxXWG8UfWgPeKaqY4WHt/L/UEl1XBUVaryZBfF6ehDMIquBCTR/EWSudbNvJP0ukS3Oo5Mb02fY5k/SGQCuSiscRQKvTDDz+QdHaCmdWqVzgDDZi/yPqIIcuYol7SEsISMqeVL+DCN0BhSIhrc0cVl3zBfPNzbLvdLu2tRQ/kK3skGO4+gaDcOfqPk8YLX/bz7aN1FXKywYGMKjwyh6sgigBUvjhRj9eG3qEzjJi4Uo9zc58sFotKfFZg9PbbL08WigX/gd7TyaaCf7Dm4nBtnPbcyWZUGI1CjLMwjgplpCZOueeWWtVw==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(46966005)(356005)(2616005)(316002)(2906002)(6666004)(7696005)(8676002)(82310400002)(4326008)(70206006)(82740400003)(44832011)(5660300002)(8936002)(6636002)(36756003)(9786002)(47076004)(26005)(336012)(1076003)(81166007)(83380400001)(426003)(186003)(70586007)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 16:48:06.4444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fcc4d3-4f8d-4d84-2f0a-08d835717fcb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was tested on Xilinx ZynqMP and Versal.

v2:
- remove domain struct as per review from Mathieu
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
- update zynqmp_r5 yaml parsing to not raise warnings for extra
  information in children of R5 node. The warning "node has a unit
  name, but no reg or ranges property" will still be raised though 
  as this particular node is needed to describe the
  '#address-cells' and '#size-cells' information.
v4:
- add default values for enums
- fix formatting as per checkpatch.pl --strict. Note that 1 warning and 1 check
  are still raised as each is due to fixing the warning results in that
particular line going over 80 characters.
- remove warning '/example-0/rpu@ff9a0000/r5@0: 
  node has a unit name, but no reg or ranges property'
  by adding reg to r5 node.
v5:
- update device tree sample and yaml parsing to not raise any warnings
- description for memory-region in yaml parsing
- compatible string in yaml parsing for TCM
- parse_fw change from use of rproc_of_resm_mem_entry_init to rproc_mem_entry_init and use of alloc/release
- var's of type zynqmp_r5_pdata all have same local variable name
- use dev_dbg instead of dev_info
v6:
- adding memory carveouts is handled much more similarly. All mem carveouts are
  now described in reserved memory as needed. That is, TCM nodes are not
  coupled to remoteproc anymore. This is reflected in the remoteproc R5 driver
  and the device tree binding.
- remove mailbox from device tree binding as it is not necessary for elf
  loading 
v7:
- remove unused headers
- zynqmp_r5_remoteproc_probe:lockstep_mode from u32* to u32
- device-tree binding "lockstep-mode"  to "xlnx,cluster-mode"
- remove zynqmp_r5_mem_probe and loop to Probe R5 memory devices at probe()
- remove is_r5_mode_set from  zynqmp rpu remote processor private data
- do not error out if no mailbox is provided since mailboxes are optional
- remove zynqmp_r5_remoteproc_probe call of platform_set_drvdata as pdata is
  handled in zynqmp_r5_remoteproc_remove
	


Ben Levinsky (5):
  firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
    configuration.
  firmware: xilinx: Add shutdown/wakeup APIs
  firmware: xilinx: Add RPU configuration APIs
  dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc
    bindings
  remoteproc: Add initial zynqmp R5 remoteproc driver

 .../xilinx,zynqmp-r5-remoteproc.yaml          |  73 ++
 drivers/firmware/xilinx/zynqmp.c              | 134 +++
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c     | 847 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  75 ++
 6 files changed, 1140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

-- 
2.17.1

