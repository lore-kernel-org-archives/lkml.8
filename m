Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E09F206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tWcv0R6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgF3Aa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:30:27 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:6188
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728258AbgF3AaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbKJMvszh3fU5uy7ehEFOh5EM6+W4vZ96797aUnc3JlLkYHcW756EwuMspA0B5Cun3nW0jrlhPYCBodofcYN6CNTqacOioW1icYs0l7hoG3bdqnZqTawATP8JzxX0RL7x2jwgNNzyaCh3Uj2B5beSDBevof8rp1Tlq7VnIwIr48apYTGXHBlS80X8bkY9AKeRyAaS8gG3WhfAxHKj+L9jkDDaVi0fSmGJHun1ryU7O3kjJzUwDQCgaYy+tFd+7QxdY8SPctlMUen+ghXhbx6lrHy2q1NoFB0XrGfp29hm23FydxMsQEX2p4jXI5qZrs83viHOOiDFhtKu+2Xz/EXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1DctMtyNABj1dyTAWmxhKD6HIXiLzU97ru2sSVURCw=;
 b=CQ2fIx3hyKTxq17EXmhwPnXpJIqjPFfoBxKy9cJewsv1sG5jeVYNvHWD//ckNPdSn0HJnDRM/or/0/BQmo+d8/oWkSpzVUJG8JhAJ2QxeiTkcvCafmOEp0BqB1gdDPehYHgh+vAo+ZfFv3PpOFdpMR5dFj+7Jrt9xrrUH+VYkikSioM4M4SEJWpRzYwa56aHQwq04WmijYw5G2eDXjkrr2+latuKl42YZSMK1lZlTKXI5Bum1Cpg++tN9oi3gtFIQNZ5Us8di1FiHuASkbPF9sQgsBaQnCxygW9fVLvRImuF3rGzuDf6Hdqaa6STRERdvgdgDlTWZlEtHT6HtYPnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1DctMtyNABj1dyTAWmxhKD6HIXiLzU97ru2sSVURCw=;
 b=tWcv0R6Aao+7G2EHYMhgUQgj0Cv8pMILwz2lsdO3G10jxz/4oh3uGXsM/nuvZLqE0KOCVjFjksHCq5BJ3XJhTPuK2uzFbcWT7NpB0IWIrBeiBU4D6/RqIWaZODVU0gteIS8AX6GWMypKRu5kE+PW63BQ6SY2PEfUT8/vhGVQjBE=
Received: from CY4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:903:c6::32)
 by DM6PR02MB4106.namprd02.prod.outlook.com (2603:10b6:5:9f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 00:30:19 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:c6:cafe::65) by CY4PR04CA0046.outlook.office365.com
 (2603:10b6:903:c6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Tue, 30 Jun 2020 00:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 00:30:19
 +0000
Received: from [149.199.38.66] (port=58515 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq48v-00054d-Px; Mon, 29 Jun 2020 17:28:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq4AF-0005bY-7l; Mon, 29 Jun 2020 17:30:19 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq4AC-0005YJ-44; Mon, 29 Jun 2020 17:30:16 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@codeaurora.org, sboyd@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH 0/3] clk: zynqmp: Add firmware specific clock flags
Date:   Mon, 29 Jun 2020 17:30:11 -0700
Message-Id: <1593477014-18443-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(136003)(396003)(346002)(46966005)(2616005)(336012)(316002)(2906002)(426003)(478600001)(81166007)(5660300002)(82740400003)(70586007)(70206006)(36756003)(47076004)(356005)(83380400001)(6666004)(8676002)(107886003)(9786002)(186003)(82310400002)(4326008)(26005)(8936002)(7696005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4891efb8-55ab-4b21-3620-08d81c8cc4c6
X-MS-TrafficTypeDiagnostic: DM6PR02MB4106:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4106685346086BCF2D1FE70BA76F0@DM6PR02MB4106.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFQEVBC2WaXjfxoFtbRAjDpb0Wtclat+Hii0fkToUvXt7+/tJqc3Bf0owtbMWj3ucw4L3VIIC+wh4ta4TGSFX9kOHrJuuEi2Hi5gkd5LFsQO45wX84LGZBV+0pCvyYolEUvZT9cBKCgpXR/Z+TkYERlsTICAilKTBk13uAmlvd0QnD5oQYEDCEsNzwZgkpvnGpD0rBKwOW3nd0FiIgHITuvJC/SMuu3AeLLjhn5tFLXbj95Go1Y5t+tkNSjxd+aeikPoa1aYKmbL27Z6dhawIyBsBs2r0eF9EJUr3nctDTe0y4Kj3s8B0kg2CqPOY5Ml4WzE/s98UWGCEc8Smc5aicchuB2Boe9vnB2qfTE6gvSzE2ghUbyY3uMR5tVajZk+MQgwryJ6YPFmjVWpf4d11w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 00:30:19.5138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4891efb8-55ab-4b21-3620-08d81c8cc4c6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds supports for firmware specific flags. These include
- Common Flags
- Divider Flags
- Mux Flags

The intent is to remove firmware's dependency on CCF flag values by
having firmware specific flags with independent values.

Rajan Vaja (3):
  clk: zynqmp: Use firmware specific common clock flags
  clk: zynqmp: Use firmware specific divider clock flags
  clk: zynqmp: Use firmware specific mux clock flags

 drivers/clk/zynqmp/clk-mux-zynqmp.c | 14 ++++++++++++-
 drivers/clk/zynqmp/clk-zynqmp.h     | 39 +++++++++++++++++++++++++++++++++=
++++
 drivers/clk/zynqmp/clkc.c           | 25 ++++++++++++++++++++++--
 drivers/clk/zynqmp/divider.c        | 16 ++++++++++++++-
 4 files changed, 90 insertions(+), 4 deletions(-)

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
