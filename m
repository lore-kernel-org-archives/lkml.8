Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3000F206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JRL2z0J5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgHKDcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:32:25 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:60000
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727819AbgHKDcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:32:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8LO9E5XwfP2kBo41uVlkqEuB7DlJRrS5GqoNdXYrCt9gv+0VA+Q7vGKSUPj4kfK/7S4eO/450c5lKg/5zshI+el1cnHF4r8GjUd+Xk7G0nHIAeVR1lAzO1+lBmNVIQKYy4og8dlk6wnXD3HN8OMx5H+8C+II3xKL+Xr8d/PwJ8BQzich/qU4jg5NgmSSosMJi4du4XeTUBuZw79NUp5udYXyefRFYuheFpYuOV+cvETmQmIy39Te+9IvUQR0aZ0ALU/5szFOxRHphC5uKONIsu5oGUgZdLda1misMDnSPOXRB7jM1o1pXNbU8YHUIsSTM5T944sulTh+mv/yCyvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APCF3OMAj9RRWuMkmuLW2pfOxQL5o9KQxoWV0lbzI7A=;
 b=mvDqmPk3bJYUZNsOeLGnshPBET4/+BTnJv3yaQR3RZ9YaynLW3s/wqZmY5CSnBhzwrhRdIUZIbrOEaIucE1jt/hfQ7Rfpvq6YpUvR0CiyIlmX2OwBAw/9nKl1Or8OXi7bgmnd4W4PmkvCa3TDJ9OvSa7HZJawkPi1rTPx+kox7PQRpGg64sf+56coXa7ckZ4K1YgHZIZlEc2HKlOfKREYKD06oQ57YeR0NK9zkRGeuS9miiH7ARGt5YVC6aWza7OuOZYJb+RNgK0O0qCTGvHC1fudkPoLEHAFf9l3vKSbpl+x7OHn6NGGWKmbnEWgMSdiJ7PRMmjqP+XqqDUjxpIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APCF3OMAj9RRWuMkmuLW2pfOxQL5o9KQxoWV0lbzI7A=;
 b=JRL2z0J5xehJCxnx7KNUIYE2z2gSHmjLfuiimKHUN/D5Axe3RZOIr7fSgsmnTj8YbSXzjBFnIFz0SPsKKUS6ozj3YKCkiLDm5saO1da/YJNrmb20j4h7MjzaHQYL/Zfy/Bztyb3FrOdz0+30FD61RQ4fB/J1J5F6vL+H7aVMhU4=
Received: from DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35) by
 MW2PR02MB3868.namprd02.prod.outlook.com (2603:10b6:907:3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.20; Tue, 11 Aug 2020 03:32:21 +0000
Received: from CY1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::c9) by DM6PR01CA0030.outlook.office365.com
 (2603:10b6:5:296::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Tue, 11 Aug 2020 03:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT023.mail.protection.outlook.com (10.152.74.237) with Microsoft SMTP
 Server id 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 03:32:21
 +0000
Received: from [149.199.38.66] (port=60897 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1K-0000i5-Oc; Mon, 10 Aug 2020 20:32:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1R-0004hE-B4; Mon, 10 Aug 2020 20:32:21 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k5L1J-0004gc-3x; Mon, 10 Aug 2020 20:32:13 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefanos@xilinx.com, michals@xilinx.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        ed.mooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wendy.liang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 0/5] Provide basic driver to control Arm R5 co-processor found on Xilinx ZynqMP
Date:   Mon, 10 Aug 2020 20:32:08 -0700
Message-Id: <20200811033213.20088-1-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fcdcddf3-4205-4094-ef8c-08d83da7282c
X-MS-TrafficTypeDiagnostic: MW2PR02MB3868:
X-Microsoft-Antispam-PRVS: <MW2PR02MB38687636206A5C9E73CBEF79B5450@MW2PR02MB3868.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEtZI5iU/mtsfie+mHRzznHBmblRHUy33hgJapcOad/fe8LIVdX5eNEi+mcCwq5oNRJsKKSnUL+TfR6zfE25KpzYCCFvlHKoE/tewT9CiHZm+nsT9EXWrXrTCS88yaetD+/AIk34yB0BoelR8pufu6J6OuiJFqRXZjCdkrrFgTVngt3IRfUFqyBGcGcMnZmpl3ICtvxY1yZ4vKJsTdVmX5i5cqNWID88H5vTawfvUh/8CyFhBi37rqDF00LUOHAJVV17sxFQ4cjZ4A/xNSqvw1g3NyIrDMef3IuU2bRGAanBTcAy6txscHwB9yFMmYxal2xXiqMPmTiKnJ71I0k7QyAF4alA703Cj0IsfmGofQZA4h/XYB1I89aHHXYs8IZAj9IsG92XxZYfPZ3WFZGnTA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(346002)(136003)(376002)(46966005)(82310400002)(186003)(6666004)(2906002)(2616005)(26005)(426003)(356005)(9786002)(1076003)(81166007)(316002)(336012)(7696005)(83380400001)(8936002)(82740400003)(4326008)(36756003)(44832011)(5660300002)(70586007)(70206006)(6636002)(8676002)(478600001)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:32:21.5711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdcddf3-4205-4094-ef8c-08d83da7282c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3868
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
v8:
- remove old acks, reviewed-by's in commit message


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
 drivers/remoteproc/zynqmp_r5_remoteproc.c     | 911 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  75 ++
 6 files changed, 1204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

-- 
2.17.1

