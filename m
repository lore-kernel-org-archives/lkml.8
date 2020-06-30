Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB628C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FAB206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pPdTYfKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgF3Aa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:30:28 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:6191
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgF3AaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrtECbstmkIz4vOHNZOiceAXr8fMEIkAJG6AkPTCmWAw+25jH9sVTsMghcebCYBZmjBiGnUCDRv6CC9TAZ0VKLUepyFIWfxTn8RDwuIuKxHxGHAvZeCtL1GJs+81Bkr4oDT8yKMUn8pVmVcOfSd1YR1Phmr9eIWI1xhlnIebl5Jz1QzKkqyLsk+suoDDIzmUg1lVq3BmUEWBQIqFt0Mjr726ou3CUyLmSZaQwmeTpPTGCYBApbVfa8MumSFz5Y2vxjwy22xetvCoDLaqvH1A8m+pjAliKBG8bZlrhStpnWtRsoIuRc9cJ1ArALsU4dE2+LjTlk95S3rh7kt3rgs1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwRMnH0svoTSDNBAdtT+uCArF6YTouahzWByTwT9074=;
 b=SfuoGTr6PQVh7Pc6zeX0PXxJBOR5+NAZVBArlD43oAe3WcMYlNZpSDLVyRPkTNQaDACFDyvjPSqbh5wFplBXjjfSXiVMOlAc9JRa2AIvoME/kQlfhnjAmYd2FJj2WJMRMDzLcaOcxwzRN5oICmXeYfwO989VQa+A5ga6cfuffF4qHGNBZ5o0EO577ENkjhHmSXwWw5KX20+nROhUkvY0irE1z3CYrMi6EEsAnNDus1YAwGSxqMU7o4XjFHmgVikJL8qAwqbeFVbNhVHun4ESotW/RuTrFvZW1y/ghvqQ7W0UgQcYTDIyr/5Dx76nBVVwNf8Sua+aylTyS86qG6L6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwRMnH0svoTSDNBAdtT+uCArF6YTouahzWByTwT9074=;
 b=pPdTYfKjr4BzUjgFoWGUeyb5Of2mk3VvLTeeGYwf5Nc9YlOuGoSPwEg1TaPaXF0NQoq97oes+VX0hI9syBdk5ovviuJb3w4YzH4HJmRO92RMq4ZIn1K4RJQM65d8jzNK/18VtgKJgGTClubjwVTB8htNs8HK2GXJwN5gC3TGapU=
Received: from DM3PR12CA0124.namprd12.prod.outlook.com (2603:10b6:0:51::20) by
 DM5PR02MB3372.namprd02.prod.outlook.com (2603:10b6:4:63::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.26; Tue, 30 Jun 2020 00:30:18 +0000
Received: from CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::d1) by DM3PR12CA0124.outlook.office365.com
 (2603:10b6:0:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Tue, 30 Jun 2020 00:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT061.mail.protection.outlook.com (10.152.75.30) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 00:30:18
 +0000
Received: from [149.199.38.66] (port=58356 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq48u-000545-NN; Mon, 29 Jun 2020 17:28:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq4AE-0005bY-5V; Mon, 29 Jun 2020 17:30:18 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq4AC-0005YJ-8C; Mon, 29 Jun 2020 17:30:16 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@codeaurora.org, sboyd@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH 3/3] clk: zynqmp: Use firmware specific mux clock flags
Date:   Mon, 29 Jun 2020 17:30:14 -0700
Message-Id: <1593477014-18443-4-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593477014-18443-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1593477014-18443-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(396003)(376002)(136003)(46966005)(107886003)(356005)(9786002)(7696005)(8936002)(26005)(47076004)(81166007)(82310400002)(82740400003)(186003)(478600001)(426003)(336012)(5660300002)(2616005)(83380400001)(4326008)(36756003)(54906003)(70586007)(316002)(8676002)(2906002)(70206006);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 969e3e5c-e76d-4ce4-d340-08d81c8cc422
X-MS-TrafficTypeDiagnostic: DM5PR02MB3372:
X-Microsoft-Antispam-PRVS: <DM5PR02MB337250E15AE51FD17D606A8BA76F0@DM5PR02MB3372.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIhrX6uzMK2EamhVbj0KhuzWLgNGtBtvUoV3uYv9A0pzvkW4JUDxZaUcvmg18R4ABEdpEB0ONstxGWPFAMe36ZNWGd11Y3JS/8q4ptgL/KoyAxVzgGyhqysP2GHS+Fq8HD+8OD6yKxNLZzlUawoSCltIuxBjEBF6dHNnCOwBcmi/ufxDJbDzLn2r4Cd1XlBlF4iUxh5yOfzxpIqkYwimoCd5Kuhjy6SKog/vrqFW8pLJdyrZT3HLFbq46MaucWAJ3iyGWZkwL7onUZI6T+DqqRgZbVcXfWi+YvOMiiLEL2LD6eozl2hXRBsLICbpvnyRosWSdRPg4TwSIoJaLcHGLe1ikmMibZmuq0/PTpNVUEqk/jphZGZ77IhP8BPURkuoxQKedrHiFZG74nwy+/5oBQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 00:30:18.4441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 969e3e5c-e76d-4ce4-d340-08d81c8cc422
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use ZynqMP specific mux clock flags instead of using CCF flags.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/clk-mux-zynqmp.c | 14 +++++++++++++-
 drivers/clk/zynqmp/clk-zynqmp.h     |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-m=
ux-zynqmp.c
index 0619414..9e365e7 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -123,7 +123,19 @@ struct clk_hw *zynqmp_clk_register_mux(const char *nam=
e, u32 clk_id,
        init.flags =3D nodes->flag;
        init.parent_names =3D parents;
        init.num_parents =3D num_parents;
-       mux->flags =3D nodes->type_flag;
+       mux->flags =3D 0;
+       mux->flags |=3D (nodes->type_flag & ZYNQMP_CLK_MUX_INDEX_ONE) ?
+                     CLK_MUX_INDEX_ONE : 0;
+       mux->flags |=3D (nodes->type_flag & ZYNQMP_CLK_MUX_INDEX_BIT) ?
+                     CLK_MUX_INDEX_BIT : 0;
+       mux->flags |=3D (nodes->type_flag & ZYNQMP_CLK_MUX_HIWORD_MASK) ?
+                     CLK_MUX_HIWORD_MASK : 0;
+       mux->flags |=3D (nodes->type_flag & ZYNQMP_CLK_MUX_READ_ONLY) ?
+                     CLK_MUX_READ_ONLY : 0;
+       mux->flags |=3D (nodes->type_flag & ZYNQMP_CLK_MUX_ROUND_CLOSEST) ?
+                     CLK_MUX_ROUND_CLOSEST : 0;
+       mux->flags |=3D (nodes->type_flag & ZYNQMP_CLK_MUX_BIG_ENDIAN) ?
+                     CLK_MUX_BIG_ENDIAN : 0;
        mux->hw.init =3D &init;
        mux->clk_id =3D clk_id;

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index ade5e9e..a29ab43 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -41,6 +41,14 @@
 #define ZYNQMP_CLK_DIVIDER_READ_ONLY           BIT(5)
 #define ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO         BIT(6)

+/* Type Flags for mux clock */
+#define ZYNQMP_CLK_MUX_INDEX_ONE               BIT(0)
+#define ZYNQMP_CLK_MUX_INDEX_BIT               BIT(1)
+#define ZYNQMP_CLK_MUX_HIWORD_MASK             BIT(2)
+#define ZYNQMP_CLK_MUX_READ_ONLY               BIT(3)
+#define ZYNQMP_CLK_MUX_ROUND_CLOSEST           BIT(4)
+#define ZYNQMP_CLK_MUX_BIG_ENDIAN              BIT(5)
+
 enum topology_type {
        TYPE_INVALID,
        TYPE_MUX,
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
