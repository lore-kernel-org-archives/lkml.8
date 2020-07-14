Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21163C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88BE221E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HFWGEmDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGNGWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:22:45 -0400
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com ([40.107.243.71]:6030
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbgGNGWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ/kOvobLklZAAjbus/RsWLGvyJIk9WbhWYARboYnezzldSd5huuZ+OvLjZ3wagUvrXxLzPd3b4ErIaXqLKHLNzuIE8reX+lJ/IUe0pfUuitiphi/mFq4zThjMayMtVdjCXklhQ/h4SwuyHfiIv2eOiSmfkY4b7cX8zich/pBe+I4GvEziFYfMqCzwhInx9N7rtiQtYAKv2YMBNFOjVIUws0f37awmRMfu3kWEqwNdE9GoVozPYCzUXmiFZjkMi8l364wXu0oLr6+9j+qxkpVpbpaUnqUfXnGqaDqifqsNJTTxVC8MUBe5xCRXQnawDci7cau4fbAdPARQ9kzalSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRlIsH2YUSk3nNnlfDhaWl/g3zpeIx5dADi5CDH7xmY=;
 b=maYGUvit1e6sdlNcsdqUXL0G/LGsK1i+3UXglAHjh3nG9WkUB1TdpmZoZ1yYh+h+7QfrCLAt3dAFf9OVEnx8X+/XZZftaKRIu9CTE3NEzDQXuH5KjE8EUXbvAMKu20Gsq1SNE9ggJTFs2hnEYsXswPCUtAUdsHmKzR6FiSCWqM5KjXZXqu8V9M9haVfYCpplmAwOT4dWn0EQpl0oqImNUIhrzxMPHwacDbJlnrxMUjXsuVZa6xjEtcBhZOk7oTG3HQBklz/nmNdUK7w2g3KG3e7ULW979TU+Ko0/atZlhxtihJEqFU3e2KIBa50OhbMukNntbWu4gmeCjdNEEHoHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=avnet.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRlIsH2YUSk3nNnlfDhaWl/g3zpeIx5dADi5CDH7xmY=;
 b=HFWGEmDPJM8ZQycTwdtj0spXhu44j5fts6f0U3OL7pxZMGB5IbR38sqszqYpHHOkA0CrMTYovnSOMYmJLvhMGm5lJ6X42mEAvk8muvXGYrEcQrcxJYoN2hj3KYOnLurtV2jjrEkfMQyn7QtMaAZ9orAItFbNgxfQtf0GiLZGogk=
Received: from BL1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:256::13)
 by SN4PR0201MB3472.namprd02.prod.outlook.com (2603:10b6:803:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 06:22:35 +0000
Received: from BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:256:cafe::e5) by BL1PR13CA0008.outlook.office365.com
 (2603:10b6:208:256::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.10 via Frontend
 Transport; Tue, 14 Jul 2020 06:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; avnet.com; dkim=none (message not signed)
 header.d=none;avnet.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT045.mail.protection.outlook.com (10.152.77.16) with Microsoft SMTP
 Server id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 06:22:35
 +0000
Received: from [149.199.38.66] (port=48881 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jvEJB-000340-Ov; Mon, 13 Jul 2020 23:20:53 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jvEKo-00046B-6H; Mon, 13 Jul 2020 23:22:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmis@xhdsaipava40.xilinx.com>)
        id 1jvEKn-000465-8V; Mon, 13 Jul 2020 23:22:33 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14964)
        id 5B43F13C063E; Tue, 14 Jul 2020 11:59:11 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        saikrishna12468@gmail.com,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 0/2] reset: reset-zynqmp: Added Versal platform support
Date:   Tue, 14 Jul 2020 11:59:07 +0530
Message-Id: <1594708149-29944-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(376002)(346002)(396003)(46966005)(4744005)(70206006)(5660300002)(70586007)(36756003)(47076004)(26005)(82740400003)(478600001)(107886003)(4326008)(83380400001)(82310400002)(2906002)(2616005)(316002)(6666004)(81166007)(8936002)(6636002)(6266002)(110136005)(426003)(42186006)(8676002)(336012)(186003)(356005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d84401a-1c01-49ee-a580-08d827be4c73
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3472:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3472F8DEC352822F72241F03BD610@SN4PR0201MB3472.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFLGeau5EsedwPPHdRSWPMQ119wTNyed8dm9qcO8SmiXmhyMXbjTokhCZZxT1sV2lMxMceio6Q5VpyCXjSB4qh700AegmceAosTgkVFKWCnihMAYUqws0Mb0F9SV9xq4Vn4GtXDOu3mYCXww4QAhcJnL73Js6z0pfkAoIfMzHZhwp6dwbxqeiVZpCd84gYq8zg5tj2fRYMeOxymvjplHHaM4ttzg2amRO/65e/jXroPRCwmCd1PQ4Om2kCoKHGKe1h27jeLOD0hh44vYhsXCP0xgmGkUad1MwUslZ0rDPA+G3ViPo7pdjQ4nHBidGX31vlkyZhnWA8QzsIQ9ITmuHgmBdtJCssXjICM3Q5F4bl2LbjG3LCcOYu1SXabujaSwHjF2F73Wq65eNxZyLiitbg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 06:22:35.2702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d84401a-1c01-49ee-a580-08d827be4c73
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extended the ZynqMP reset driver to support Versal platform, accordingly
updated the dt-binding with the Versal platform specific information
like compatible string and reset indices.

Sai Krishna Potthuri (2):
  dt-bindings: reset: Updated binding for Versal reset driver
  reset: reset-zynqmp: Added support for Versal platform

 .../bindings/reset/xlnx,zynqmp-reset.txt      |  11 +-
 drivers/reset/reset-zynqmp.c                  |  24 +++-
 .../dt-bindings/reset/xlnx-versal-resets.h    | 105 ++++++++++++++++++
 3 files changed, 132 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/reset/xlnx-versal-resets.h

-- 
2.17.1

