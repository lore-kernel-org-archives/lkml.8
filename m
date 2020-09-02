Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C71207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QwIdredj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgIBQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:59:31 -0400
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:9664
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728498AbgIBQ6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxuFYuIUzkuICm7DmkiuiP0gFbW29aftTMDAV1xGor/QRdaHsc+AdSGmARQjCh8BpjlQRfVBJte6sbFDZtrn646Zh27SAJKqWdD1HlohxCsXC/Cs5V6C+JpRktKwsdfx2qE/oGJ8WsqvGHGjSpfDLfUqrvWbm06znYQYTO6Qom6jzdXBJoAJv/3VI5E5cndT4RU8j+9U9lgCpf0xhpIRE0o961c6YFbshGUk3UbN9aBJc8By7wFx8ycwbZq+b1ZsILqmDMaaCylByMztb/cjMC5V7cxlVRzx7HCsY7V7QPmMIHf/tPR2KkLqL6WxRXYthmCMmuXrg+BGBKjy8ccpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFu3WzMIziHiZ8y0z+ruSh+23SNKG5YNeGDocyU9P04=;
 b=FiPodsIi6MRjlQ/KTb+kHp38RiH0WCgrEuUQMupkeNRmWgihQacjpijV+QjsHIhRskQ91laSU691JGMO4AKFO2jCrFvHODzF4r/NtcfDqAt5vxWGNQemnSkSKWRVDe3YL6IYRnQi1HHkI/8iuhHdvzD+G0f90pqqFZCrG7OvACAS794IShQoxMK3F1jizZvdFtB7P/a3FYdlvqHjfEmzGg0jhGUTJStFJZ3NZ3tB7xFSk1Xuepw1Ri7lu2dbz79IA+5nrkAQiGQNX+6e4ABRBkPkS9bknFds4XVPJvmq1m9EnrUpxDrzUZueTRkwk2EC7PTQTgrXUQqLlCah+MrqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFu3WzMIziHiZ8y0z+ruSh+23SNKG5YNeGDocyU9P04=;
 b=QwIdredj6egyiaoZiv6oNA5gLssRa09IHW3FosZFFawdSoaTWgeA4Hw7IlOWZJk1y+sXVar5uVloxpCOdlksTYxRQD0WRL0m4km9TXaKekWSt40fwigZkIx/ai3atcAGlYllGXY1eicEaDU2QHehvkhYs0QuY8EjpRtRQQs+7FQ=
Received: from DM5PR07CA0151.namprd07.prod.outlook.com (2603:10b6:3:ee::17) by
 DM5PR0201MB3494.namprd02.prod.outlook.com (2603:10b6:4:78::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Wed, 2 Sep 2020 16:58:50 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::d9) by DM5PR07CA0151.outlook.office365.com
 (2603:10b6:3:ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 2 Sep 2020 16:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 16:58:50
 +0000
Received: from [149.199.38.66] (port=52898 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5t-0004kT-Ph; Wed, 02 Sep 2020 09:58:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5y-0004Hg-Bm; Wed, 02 Sep 2020 09:58:50 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 082GwkgO032478;
        Wed, 2 Sep 2020 09:58:46 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kDW5u-0004H9-8H; Wed, 02 Sep 2020 09:58:46 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefanos@xilinx.com, michals@xilinx.com, michael.auchter@ni.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v11 0/5] Provide basic driver to control Arm R5 co-processor found on Xilinx ZynqMP
Date:   Wed,  2 Sep 2020 09:58:41 -0700
Message-Id: <20200902165846.3366-1-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1c5f613a-d3e4-4a3e-956c-08d84f617763
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3494:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3494A514334A68E45A2D9055B52F0@DM5PR0201MB3494.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3zptoJLI16dlocfqfg4YgFWIOYkcL8r0f41W6VkiL8FB48aUGt+w6TN083VIFwheMfxcxYf2waYd1DL6XKJT6MQaDkbEndg3s29H0iwNgObKF2U8wGMq7QIHuK/luH+Pupq1g5lC++cN3m/KE7M0BxV1AStTZPLVCzAtIAYf/JDBtgJpK1f4fjALkGLSt7y5j/q64rBGaMsiVB0WrqU4b3mMsjYiUIey0U7/ZlR+Ok8gVB9utNmNwgyl6jzAQJAt660yRznLL2OH/gDmvnxuA6/Gr/+Qj9dKHuC5hlbfeySatr8/ekgDMg9KHQaKzl2f/uCl1NGUdvKqTFGqztNByQWexiB5QxAHKASE/x4paoyCNjLGNVSp4zOVj1DCZWZAeV6v8Xs+3YiqwvP9g/5wg==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(46966005)(6666004)(1076003)(83380400001)(8676002)(82310400003)(70206006)(186003)(70586007)(336012)(44832011)(2906002)(426003)(26005)(7696005)(47076004)(316002)(5660300002)(478600001)(9786002)(82740400003)(8936002)(4326008)(356005)(2616005)(36756003)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 16:58:50.6262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5f613a-d3e4-4a3e-956c-08d84f617763
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was tested on Xilinx ZynqMP QEMU

For sake of ease of review, only support ZynqMP. Once accepted, then
add support for Versal platform and R5 loading onto OCM.

v2:
- remove domain struct
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
- fix formatting as per checkpatch.pl --strict. Note that 1 warning and
  1 check are still raised as each is due to fixing the warning
  results in that particular line going over 80 characters.
- remove warning '/example-0/rpu@ff9a0000/r5@0: 
  node has a unit name, but no reg or ranges property'
  by adding reg to r5 node.
v5:
- update device tree sample and yaml parsing to not raise any warnings
- description for memory-region in yaml parsing
- compatible string in yaml parsing for TCM
- parse_fw change from use of rproc_of_resm_mem_entry_init to
  rproc_mem_entry_init and use of alloc/release
- var's of type zynqmp_r5_pdata all have same local variable name
- use dev_dbg instead of dev_info
v6:
- adding memory carveouts is handled much more similarly.
  All mem carveouts are now described in reserved memory as needed.
  That is, TCM nodes are not coupled to remoteproc anymore.
  This is reflected in the remoteproc R5 driver and the device tree
  binding.
- remove mailbox from device tree binding as it is not necessary for elf
  loading 
v7:
- remove unused headers
- zynqmp_r5_remoteproc_probe:lockstep_mode from u32* to u32
- device-tree binding "lockstep-mode"  to "xlnx,cluster-mode"
- remove zynqmp_r5_mem_probe and loop to Probe R5 memory devices at
  probe()
- remove is_r5_mode_set from  zynqmp rpu remote processor private data
- do not error out if no mailbox is provided since mailboxes are optional
- remove zynqmp_r5_remoteproc_probe call of platform_set_drvdata as pdata
  is handled in zynqmp_r5_remoteproc_remove
v8:
- remove old acks, reviewed-by's in commit message
v9:
- if zynqmp_r5_remoteproc.c pdata->tx_mc_skbs not initialized, then do not
  call skb_queue_empty
- update arguments and documentation for zynqmp_pm_set_rpu_mode
- in fn zynqmp_pm_force_powerdown, change arg 'target' to 'node'
- zynqmp_pm_request_wakeup update code style
- edit 3/5 patch commit message
- document zynqmp_pm_set_tcm_config and zynqmp_pm_get_rpu_mode
  documentation to include expected return val
- remove unused fn zynqmp_pm_get_node_status
- update 5/5 patch commit message to document supported configurations
  and how they are booted by the driver.
- remove copyrights other than SPDX from zynqmp_r5_remoteproc.c
- compilation warnings no longer raised
- remove unused includes from zynqmp_r5_remoteproc.c
- remove unused  var autoboot from zynqmp_r5_remoteproc.c
- reorder zynqmp_r5_pdata fpr small mem savings due to alignment
- zynqmp_pm_set_tcm_config and zynqmp_pm_set_rpu_mode uses second arg
- zynqmp_r5_remoteproc.c use of zynqmp_pm_set_tcm_config now does not
  have output arg
- in tcm handling, unconditionally use &= 0x000fffff mask since all nodes
  in this fn are for tcm
- update comments for translating dma field in tcm handling to device
  address
- update calls to rproc_mem_entry_init in parse_mem_regions so that there
  are only 2 cases for types of carveouts instead of 3
- in parse_mem_regions, check if device tree node is null before using it
- add example device tree nodes used in parse_mem_regions and tcm parsing
- add comment for vring id node length
- add check for string length so that vring id is at least min length
- move tcm nodes from reserved mem to instead own device tree nodes
   and only use them if enabled in device tree
- add comment for explaining handling of rproc_elf_load_rsc_table
- remove obsolete check for "if (vqid < 0)" in zynqmp_r5_rproc_kick
- remove unused field mems in struct zynqmp_r5_pdata
- remove call to zynqmp_r5_mem_probe and the fn itself as tcm handling
  is done by zyqmp_r5_pm_request_tcm
- remove obsolete setting of dma_ops and parent device dma_mask
- remove obsolete use of of_dma_configure
- add comment for call to r5_set_mode fn
- make mbox usage optional and gracefully inform user via dev_dbg if not
  present
- change lockstep_mode from u32* to u32
- update zynqmp_pm_set_rpu_mode and zynqmp_pm_set_rpu_mode documentation
  and remove unused args
v10:
- add include types.h to xlnx-zynqmp.h for compilation
v11:
- update usage of zynqmp_pm_get_rpu_mode to return rpu mode in enum
- update zynqmp_pm_set_tcm_config and zynqmp_pm_set_rpu_mode arguments to
  remove unused args
- use enums instead of u32 where possible in zynqmp_r5_remoteproc
- zynqmp_r5_remoteproc: update prints to not use carriage return, just newline
- zynqmp_r5_remoteproc: look up tcm banks via property instead of string name
- print device tree nodes with %pOF instead of %s with node name field
- update tcm release to unmap VA
- handle r5-1 use case
- device tree binding r5 node to have link to TCMs via meta-memory-regions
  property
- fix device tree binding so no warnings from 'make dt_binding_check'

Ben Levinsky (5):
  firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
    configuration.
  firmware: xilinx: Add shutdown/wakeup APIs
  firmware: xilinx: Add RPU configuration APIs
  dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc
    bindings
  remoteproc: Add initial zynqmp R5 remoteproc driver

 .../xilinx,zynqmp-r5-remoteproc.yaml          | 123 +++
 drivers/firmware/xilinx/zynqmp.c              |  94 ++
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c     | 898 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  60 ++
 6 files changed, 1186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

-- 
2.17.1

