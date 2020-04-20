Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B76C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4B12078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NhPCZefw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgDTW1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:27:23 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:6255
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbgDTW1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU3QGoMAo2+thwoidNRJ6Veeq+lyNvQJDqtHGoLBPsGBjS69oPJLyWGoPhi6XBt2lN6FAmvW1O8rghrZft8rV/2fPk8p4jBLtjFfcdcQtwnnfsGp2WxdkICfs6cF6VyQooYvz8VtSMsPxr7dqbkUukYgY5yMhTwnZ6At0fejSu1Ly+KewzYwlIma88j9pZ3DTSWNbSLe6JBBt/K2H55gogZJ2LedRVzxAQbg11r/CNrAs1IfLlT+EnSimdX5swz5xdZFaZrXF6lKRs2USweRP9RZciUwkIqwKsZcbUPEkvp6UxvUnGwVx5ctK+NC5fTO8JbJp8eSfbrw2lDffVDATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkJ0Pi7+LqukkEKtVYWgWpMj1h7fSTsb0NmMPElDMFA=;
 b=mHf2IOoHHc9tyxaQmi/zsGcDY0YU0RhFAyB0cJWpo3aG8/Hzk9rVEkTuwLxoynNQypXRugJRCfJfWIaq/kcQ+NrJOozEopLFLaldK1s5OdOYiDFZeVYORPOzlbCblukeq+hJlDlpvyOg6tLpLTOT9jZbq4DsguxfTgNmT4SfgeazKMD4WhRn9yeL6swFubcmusen3f/vlq4KmjkPDYnAXcER3OBN717FPoW43WT6cSQrJXcy7/eSYlK62dvN/3kGLfVTdkKa0NrAKR0a5BxwDMLYAWPXxYrGbKGfHBlUhYEwgCuClkSvAwpfy8nJqop84wiD5B+Vd5lYb2gZUskjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkJ0Pi7+LqukkEKtVYWgWpMj1h7fSTsb0NmMPElDMFA=;
 b=NhPCZefwFqgzWXaXG0imsUaURpEQx5db3F5lmp7BWPodtcBC+xxG+NaEHB/9C5zAn6qNg2l+0aLc4JVDNHQ8AWI7nRZVKAuWPdwRUogzqjlsrxsf3i412nxWx3jSFmpHK6eBBOl6mBS88olr5wfCDSX2L6y01ls86+AWv2z5Jkg=
Received: from SN4PR0701CA0003.namprd07.prod.outlook.com
 (2603:10b6:803:28::13) by BY5PR02MB6802.namprd02.prod.outlook.com
 (2603:10b6:a03:207::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 22:27:20 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:28:cafe::79) by SN4PR0701CA0003.outlook.office365.com
 (2603:10b6:803:28::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 22:27:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 22:27:19
 +0000
Received: from [149.199.38.66] (port=33665 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jQers-0000Sh-8o; Mon, 20 Apr 2020 15:26:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jQesp-0008OD-Dq; Mon, 20 Apr 2020 15:27:19 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03KMR99e020366;
        Mon, 20 Apr 2020 15:27:09 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jQesf-0008MN-5M; Mon, 20 Apr 2020 15:27:09 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] remoteproc: Add zynqmp_r5 driver
Date:   Mon, 20 Apr 2020 15:27:04 -0700
Message-Id: <1587421629-914-1-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966005)(316002)(81156014)(9786002)(8676002)(4326008)(36756003)(26005)(6666004)(478600001)(7696005)(186003)(5660300002)(2906002)(8936002)(2616005)(70206006)(47076004)(81166007)(44832011)(70586007)(336012)(426003)(82740400003)(356005);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a52bf89-63f8-40ff-7d72-08d7e579fd2d
X-MS-TrafficTypeDiagnostic: BY5PR02MB6802:
X-Microsoft-Antispam-PRVS: <BY5PR02MB680273DB8121CD3AD98C6858B5D40@BY5PR02MB6802.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03793408BA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uj9Qg+Hy79giPiFvlxBHEfVj7HtF0GLDSqFCxJB8VPA4BmXkrRlYcCIvM1dXjkyiaHm8Lrl9n90C9R4k5MN8GCr8r6H6eMzm4q74H8cpoViiz17Wz/HOsaNpO/UxXGiTrc/fjHyiH34oH0qatzvzhz8N6OsNjCQGbl6qC9iAYnOGmoQc3EdAKnC40CbtQENhyNNLcCJVrPJEp0rqcBkl2qtU4A/11cKgGq8OkKKOc+C8pOetHe4RtbSZ+ljGu/0Ca8PNj/SWEcuTNpgFVqokV7T9B4u/xB2BoOFXq6o8z7VTpA6nR4LWlFZDYqxY1l5fAhRBE4flmBW8HOJ6OKwNPVh3bZUREvg5288OfwZNiguEVPJDg7EEPGA7PJIMmHRH/7MgcfwcPrBww/WtyapsxhFOtbTPlTJatX6fAHnbqAp2VJ/aKEG9qx8VOiDsLcExDlufZ5lIzZpLcTgE/nX6sinoYaTna7wO9UaAeDZ/0x2ZhPp5bW8Pu64WORHUJwoNpdaYD0GotjY5vtpaMHcL9A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 22:27:19.7484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a52bf89-63f8-40ff-7d72-08d7e579fd2d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are Cortex-R5 processors on Xilinx ZynqMP UltraScale+
MPSoC.
This patch is to add an Xilinx ZynqMP R5 remoteproc driver to
enable Linux kernel to bringup R5, and enable communication
between Linux kernel and R5.

There are Cortex-R5 processors on the Xilinx ZynqMP UltraScale+ MPSoC.
This patch adds a Xilinx ZynqMP R5 remoteproc driver to enable the
Linux kernel to bring up the R5s, and to enable communication
between the Linux kernel and R5s.

Ben Levinsky (5):
  firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
    configuration.
  firmware: xilinx: Add shutdown/wakeup APIs
  firmware: xilinx: Add RPU configuration APIs
  dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc
    bindings
  remoteproc: Add initial zynqmp R5 remoteproc driver

Changes since v1:
	- remove domain struct as pre review from Matheiu

Changes since v2:
	- update zynqmp_r5 yaml parsing to not raise warnings for extra
	 information in children of R5 node. The warning "node has a unit
	 name, but no reg or ranges property" will still be raised
	 though as this particular node is needed to describe the
	 '#address-cells' and '#size-cells' information.
	- add xilinx-related platform mgmt fn's instead of wrapping around
		function pointer in xilinx eemi ops struct

 .../remoteproc/xilinx,zynqmp-r5-remoteproc.yaml    | 126 +++
 drivers/firmware/xilinx/zynqmp.c                   | 136 ++++
 drivers/remoteproc/Kconfig                         |  10 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c          | 902 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  69 ++
 6 files changed, 1244 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

-- 
2.7.4

