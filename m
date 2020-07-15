Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6340DC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D84A206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="r3zP1eoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGOPd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:33:26 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:42177
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbgGOPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:33:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTrhICtaIFYoVP/NVtyaJxqdDJ7MHimTV3fUPBcLkYcFPca53p7EC5t+/4eB5O1KzQIQp86o9anJjpDvMifgJmRuOE7wEifbV2dZhfIFsoKu2Ysr4vCjVxkQMIYVNIiYPmCfsaWeBuf/jrobjnyb6gWnFleFignnK+0VCJklwB4qPF2DAQUjW2PTs7beBCyzO4ljpw/eIa7YbCmT7qUQQh4S4kVtOJfP2AJcRU9RLX+iXtxJnn/UHrhT6Yv7jiB+LU4enBs4blnIyNJBjB+ZgnrF7B+0NtTH7AXLi66IN3LXg2tZHlTeCG5OckjQgIikmDly05jFs8OwesH8+kjDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xaq65E5Ymew1qmOFlWLncCeqH7fbHsQ5vSuITJJWhFQ=;
 b=R9Rm5BF7Sj88duKUeyZwCHdL9EKDp58Y6KukUhoXN55PZzBA8iFQ9788inO6AyzQw7m8PLLHXCjd30lPvAAk+WsYJv9ndtAK5lDsZDdgvxArZyVbYpYXGGRdfOIg7M4B3TfXwSURD36RHxSBGy9TNl5Yim9if5jeOvTb1rXKA6/NgMYs1xtu+BGHluDG8VYuwV1vzHY61E3sZE8PWoHv8+85icoEygPi9YKhtnVlBNvkRUtZqIx0P+mKVi/uXTC0mW5jNLtR58Z9eQdXN3Bjic6fvDtZYRqf/na3d5w9ardckFyeJ0AN075D1ic5zn6H1WiRAq6Z6G4Rx2oGK8iphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xaq65E5Ymew1qmOFlWLncCeqH7fbHsQ5vSuITJJWhFQ=;
 b=r3zP1eoh/sfD9iUDMa34uv1OIftPtiCB1Daf1zZJcFejRztgxzeZW+ieclrqp92B6fc80T91Qse6Kg55v3aUWV/B0QKjf6Vo76zUcBj/xkWoSuKrAzS48goWylvLEhDZfS4D6UPgJgpWMOhD7lODCbjaMAKWvu0fIv+7gNZ6mjY=
Received: from DM6PR06CA0046.namprd06.prod.outlook.com (2603:10b6:5:54::23) by
 DM5PR0201MB3399.namprd02.prod.outlook.com (2603:10b6:4:76::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Wed, 15 Jul 2020 15:33:21 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::4c) by DM6PR06CA0046.outlook.office365.com
 (2603:10b6:5:54::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Wed, 15 Jul 2020 15:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 15:33:20
 +0000
Received: from [149.199.38.66] (port=39379 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjNh-0005fR-Da; Wed, 15 Jul 2020 08:31:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPM-0007rZ-4x; Wed, 15 Jul 2020 08:33:20 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPJ-0007qz-JJ; Wed, 15 Jul 2020 08:33:17 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        JOLLYS@xilinx.com, RAJANV@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        stefanos@xilinx.com
Subject: [PATCH v6 0/5] Provide basic driver to control Arm R5  co-processor found on
Date:   Wed, 15 Jul 2020 08:33:12 -0700
Message-Id: <20200715153317.25643-1-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(396003)(39860400002)(346002)(376002)(46966005)(426003)(2616005)(6666004)(44832011)(36756003)(186003)(336012)(4326008)(7696005)(70206006)(107886003)(70586007)(26005)(5660300002)(316002)(9786002)(47076004)(81166007)(8676002)(83380400001)(478600001)(82740400003)(2906002)(356005)(1076003)(82310400002)(8936002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 38009c0d-c0c8-4495-f208-08d828d46762
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3399:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3399B99C0D62B22C5498D223B57E0@DM5PR0201MB3399.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qoYZuHMxuZ8aKjwdCTtqxlITOHSLW4kdbvJB8+Jp7mF59gl0rOeMDfnffapFhcMO5GhkVlFSBcx78UfxY8e1nq0Ic/b4FqJTF80VJD59E7OZtzTgEf5WvnAnYo95SSZzal5pRCb54qkFFN2tgG/SR+Am5a3TTuHcC2FYG+ksNy7lmOMasLmLDiYbZKWgsu+tmEt+ZEqvkiAgJVXyupn5jK81UXIEcENJzlYaz9ReHY9R9hnyfIOvOcb6tKI4VIlO+b7I94UYAsmt6+OzETfpSgduk6abxV8Vz+hGuS16Mnn65PEVUOjKNg4Q5JEsSb80omDDArYNhcKpPQ9Duagb4Wt+Z8ixnVGFrPfEnlnD0W3bwcAZB3+jpg+Tqgf0yVQJoX16yHdQQjW47JeX0JcKw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 15:33:20.5520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38009c0d-c0c8-4495-f208-08d828d46762
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
v6:
- adding memory carveouts is handled much more similarly. All mem carveouts are
  now described in reserved memory as needed. That is, TCM nodes are not
  coupled to remoteproc anymore. This is reflected in the remoteproc R5 driver
  and the device tree binding.
- remove mailbox from device tree binding as it is not necessary for elf
  loading



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

