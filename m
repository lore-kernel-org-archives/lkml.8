Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992EBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703BE20772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MFeykc2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgFCOtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:49:53 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:63200
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgFCOtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:49:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQNH4n4ssZG1xk0zz8+FDrfQ0Fd5PDnssubA5tw8LVMJ94Sk0QceMQw/pNV9woYTtu8NazA2qxumjlUdBJqSap18tFMSrd/pq15RALHGC7UDrgQ0iu9pfnOjfaH4TnTVMego+4n2GPbbMjBYwIltUqioNBaIlyCFTJFrQ9FLtdDM1Syx4BCU7gJOzqs+/dU1cx72nRbHdaz0sAc1MKHENjJbo0Wt/W/jPE8DNER2jotfDkqxFgFyx5SsD+TcX9B/7o/23yFywj0rEH6x9P1845Q2rGNMNRYTob1TmuKoUBOiD6sjSD6ynhbLJ0eqRsWNpUBxVvordwZvZmpqUUgFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCpM65CewYisrkWp7fZipWZ113RLvwQy7sFbztUNZT8=;
 b=QWgNuFV36JZudAwXgb4xTJYpVUC+pxVtiRG9JFC1btax9BDNOKSANPZBfuVzk7WAo0WRTTfuHudHYj44DZWrugzyFAjlHEuK5s1J6UIYYyoCoNGqdhn3iirMhk04MNL/ZUOPsse8HmWKg3kiwcnzOgdpRyE1/IbyHqxKoO8SC65ONByZTlusJ7gBRzVyxfROGQNIHBAV6dW7KVyJewfgJeVh2L5P+EFO376q8dvwFRe+sV2ZuzxzEKuIWys4cHSr3n4S20w9r3Fv0gDM8I6dErOjewOlnO1qSdYy/pn2BvS2kYPdgYo0sS4C60uWIGXjdBWvwXb2DWBL2oQ7h8MqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCpM65CewYisrkWp7fZipWZ113RLvwQy7sFbztUNZT8=;
 b=MFeykc2jBp2y/oisnDFF7kSaKYWEQIpk68ZjVnk3youSlf9StU8UGMk6fxZK5UYTQbC0XFZbApUgQVvPGYe8NA/6uEmPG6dtJlefidsB10rWNwJZRSeLJxX90RlhSbr2qQdKA3M/LyLhE5pen/bfkljii82d6Zmbow5CvQwcMyY=
Received: from SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26)
 by BYAPR02MB4215.namprd02.prod.outlook.com (2603:10b6:a02:f4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.25; Wed, 3 Jun
 2020 14:49:48 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::b7) by SA9PR10CA0021.outlook.office365.com
 (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Wed, 3 Jun 2020 14:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server id 15.20.3045.17 via Frontend Transport; Wed, 3 Jun 2020 14:49:48
 +0000
Received: from [149.199.38.66] (port=60688 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUhR-0007G4-Nw; Wed, 03 Jun 2020 07:49:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUiB-000515-HL; Wed, 03 Jun 2020 07:49:47 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 053Enh5s015305;
        Wed, 3 Jun 2020 07:49:43 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUi7-00050a-6C; Wed, 03 Jun 2020 07:49:43 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        jollys@xilinx.com, rajanv@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] remoteproc: Add zynqmp_r5 driver
Date:   Wed,  3 Jun 2020 07:49:38 -0700
Message-Id: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(396003)(136003)(46966005)(4326008)(478600001)(316002)(47076004)(186003)(8936002)(82740400003)(8676002)(2906002)(36756003)(7696005)(26005)(9786002)(81166007)(356005)(2616005)(82310400002)(83380400001)(336012)(426003)(70586007)(70206006)(44832011)(5660300002)(6666004);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eafe4e0e-4e08-4251-58e3-08d807cd5ced
X-MS-TrafficTypeDiagnostic: BYAPR02MB4215:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4215A422C276D125DC80AE0AB5880@BYAPR02MB4215.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6m2CW8B6/gWQvaoMaqws3XUT0OtEPYwMX10Wu4uYK2zNAY0vE0KfYrQhe1n549g1r76nSy2sp/RbXY+WH+HM7nxlWb6ySUSXBBqpkQydwRzvSCOZE3IIve2XBH6MBXAtPO0BE1mpCfVehbfYgL9micd8Wl2vYOXltJFyoHhKsiuN6Z1+P+W76uWaTpbVbW4rAfYoqbQXSrRNVQUkuqd+K36ZLbrdioZU2UL3jzLMgNwQyBVCAsGA0wwFmlrGuWkagn2oCVh5qyZwOhwa88GJiETqPwm4eL5cFjPYlj9mofNznbk0YUg/mqb4Ixk4mWPkcJ19YCUZaOJMYH1S3/mxUhm3GR45pnOdxrX3shqGsGod+rRNwh5B9IHxonWxDB4qXzKhNA7wyQgIUKfGJduRQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 14:49:48.1524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eafe4e0e-4e08-4251-58e3-08d807cd5ced
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide basic driver to control Arm R5  co-processor found on
Xilinx ZynqMP UltraScale+ and Versal MPSoC's.

Currently it is able to start, stop and load elf on to the
processor.

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


Ben Levinsky (5):
  firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
    configuration.
  firmware: xilinx: Add shutdown/wakeup APIs
  firmware: xilinx: Add RPU configuration APIs
  dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc
    bindings
  remoteproc: Add initial zynqmp R5 remoteproc driver

 .../remoteproc/xilinx,zynqmp-r5-remoteproc.yaml    | 126 +++
 drivers/firmware/xilinx/zynqmp.c                   | 134 +++
 drivers/remoteproc/Kconfig                         |  10 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c          | 902 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  75 ++
 6 files changed, 1248 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

-- 
2.7.4

