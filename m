Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953C1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A27E206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nyJAXOGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgGVHJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:09:59 -0400
Received: from mail-eopbgr690045.outbound.protection.outlook.com ([40.107.69.45]:32879
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728624AbgGVHJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:09:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTZ9jyEZ1Pr/wZ51ZH5Qx/T8EzNG6h/6RSHlneJ/K5boFZ5z1I5syGSXRyGK/Y1BiORGKOH9wUf+4lTAGSAtzhVO/CShs5kZxwujOjmAVYcX1Tmn7LfBLVxyVcZ/hhDgSpTLVRUiJqnCjoLFRJBC4CfwW7a3Wbidk28/uQOuRwVk2lpwzSimHZ6oqWIAY+RunNFsiV7MR/xQjuYnaLJbQhzTVW5BzLvfGXW4fHZsis/ynPyE9hhDrf7/NxR6ok3fuzjADexrNpUv/utIA5HCeIxTAd5MHlRV7AAuq7PT+nA5CcQGpTVk0XLOgHxP/o60nYXLoA4fsr6xyUBtvUz48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCr8Vo/3mylQ6cvDnmBofE5wdrnd86UXiDjzcbTx/44=;
 b=BhzBSDMzzt7SN4+SOyqokLsmwSP07r/NP/bVk76pjTt1p36t9FIaX7wjkeS8FZMDCer427GFoRY2s1W+hTHqPOwx+nYjXBgfyG+/WhFAfkqTyRA5vNlwz6QepvXNoJGRJhpCP+mCgtC/USUllh66lW5VExDjShjcnAjJb4AiMPVczTDEsTB/gib/lZF2DFADvrtSEOoZltwmnVQlvtndg964MDb/5ebjMcQNoyL8OR938OZmqsJNnytJ9nKK92ylSp5FF6pSTHPTcxDCZUJUpaQkmjKDzm6VrGIT0sHaQXC60ugrnFZ8tvfCN99OjU9bY7QG1IyblQStgd62xJKrcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=avnet.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCr8Vo/3mylQ6cvDnmBofE5wdrnd86UXiDjzcbTx/44=;
 b=nyJAXOGtPeClq0jEu4y/9EBq1enyNcPoD+RNyy0DzAvCrKuhLlQwgUCWmqS2Q5hPAlczRllxxe0HejHFUjkfmu4+XEmd8Sw5rumpRUItVnvTsQgVE6/o2+G0RusE84WlUK7aW6IOUTSEqM8nYPPjxi89nJ6dr0mPvg6Y/PcQE1w=
Received: from MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39)
 by BYAPR02MB6007.namprd02.prod.outlook.com (2603:10b6:a03:119::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 22 Jul
 2020 07:09:55 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::ec) by MN2PR07CA0029.outlook.office365.com
 (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Wed, 22 Jul 2020 07:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; avnet.com; dkim=none (message not signed)
 header.d=none;avnet.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 07:09:54
 +0000
Received: from [149.199.38.66] (port=60688 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jy8rB-0002Ju-Us; Wed, 22 Jul 2020 00:08:01 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1jy8sy-0001G7-96; Wed, 22 Jul 2020 00:09:52 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06M79oVc016845;
        Wed, 22 Jul 2020 00:09:51 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <lakshmis@xhdsaipava40.xilinx.com>)
        id 1jy8sw-0001Fp-NI; Wed, 22 Jul 2020 00:09:50 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14964)
        id 125DC13C0564; Wed, 22 Jul 2020 12:46:06 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        saikrishna12468@gmail.com,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH v2 0/2] reset: reset-zynqmp: Added Versal platform support
Date:   Wed, 22 Jul 2020 12:46:03 +0530
Message-Id: <1595402165-8282-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(396003)(46966005)(81166007)(8936002)(5660300002)(47076004)(4744005)(6636002)(4326008)(82310400002)(8676002)(83380400001)(42186006)(478600001)(426003)(356005)(336012)(70586007)(186003)(82740400003)(107886003)(6266002)(110136005)(2906002)(2616005)(6666004)(316002)(70206006)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3132e4e2-95ec-4ea9-df4b-08d82e0e3c0a
X-MS-TrafficTypeDiagnostic: BYAPR02MB6007:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR02MB600759E60827FF83FEE4EABABD790@BYAPR02MB6007.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hd1cR340PTLitUY5IC3wsjIKuyzCqsykfhrAuAjezUnBm4dSyR69sE8wY7hF3bwyGktQWbNsn08OnCWh7pIRCXHuUP4LSjUmIJovIXthkW7pgV9JBPIyCOfWhbsPEvcVhwICLJE2Aa4I9aYOiYIcukuIyaeRR0/rOt8cPEnxaqLLOsXB12u+Mg8ycZVialM6Uxr3QHvDBS5aQvM+UAJQ3t9DV1cphgMPvhFS6Yi3EhZFMo/E5GsqUK+6AGSta6oy8HmUWGeQdwpulbDEFLpC9q+oOm6sF7j5accjVfHBQox6dAASCpXWr67cY1P5QBXHsjYUWoniLutqddfOqxo2/m3ld3FRX0BSui3mQX31qEwCdhVQp+bZrNXZz3ZJ2i2sAcoS+UKt4i5nSN92SOgzWw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 07:09:54.4570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3132e4e2-95ec-4ea9-df4b-08d82e0e3c0a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extended the ZynqMP reset driver to support Versal platform, accordingly
updated the dt-binding with the Versal platform specific information
like compatible string and reset indices.

Changes in v2:
 - Updated 1/2 patch commit description with some explanation about
reset indices.
 - 2/2 patch, Created SOC specific data structure and initialize the
const data based on of_device_get_match_data.
 - Defined driver specific of_xlate callback.

Sai Krishna Potthuri (2):
  dt-bindings: reset: Updated binding for Versal reset driver
  reset: reset-zynqmp: Added support for Versal platform

 .../bindings/reset/xlnx,zynqmp-reset.txt      |  11 +-
 drivers/reset/reset-zynqmp.c                  |  50 ++++++++-
 .../dt-bindings/reset/xlnx-versal-resets.h    | 105 ++++++++++++++++++
 3 files changed, 156 insertions(+), 10 deletions(-)
 create mode 100644 include/dt-bindings/reset/xlnx-versal-resets.h

-- 
2.17.1

