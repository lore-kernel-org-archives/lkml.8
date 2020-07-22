Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360EEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C994206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tMawQQHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbgGVGzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:55:45 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:21376
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728005AbgGVGzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:55:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iii6Aob57OnAbrz9EQidcxWuGSevwqD8pomlfP8aCm3TekXwcsY1Fy3bLUgRYYtKion1XcfSb2lVHp3iPw8Ijc4tnW02srbZ+V0sv3F9uNtD8PLq8D6C/GocH/HYVAxiZAFwMktP9d6cpjhO6OQ7tJCRj0AOyuRTyA2YEvlqLQqZMnHNRgWqRXa7R9wmu9GJv127unNleKjNRCJeEUPdxlCPH6z9nZ2Kc87i1dwsnHFvvOrQZtxFYPkMLyuav34IO2M8xvoJ9nHkTYXuEz9P5VYIw2GADPVisbb4zCgT3+Byt7nuTyC98Rbje81bS+lOaDRIwQOKRkyh7Qv85VHggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb/ocuA9UwVTJ+GNaE09qFqDBAOhHOQ0jmeJ+M287+g=;
 b=iriHuIpTLYazJWrtah9USV5cnhrWPk295kZmRSXkTvYwtqZ78FAFXXdipXSJ/oaPQd7cq0CH6sRwvHRWyZxgPVU4m+2eVUqsinMSzjS4rY5x+yP5MfRZZiBkI+e0+/SGU6WYUlRSZ26cM1TNOPO7nd1LSLWoXhfNWvzYHPfTYJKwWpehE7U2H5z9FqhXK1N18RG3Rvd/4a3g79O32D7oc3u6EPfP7Y1hq7VvM9VD4+/7ysWAEXBmexTwzHIaXSy5BwTEbxeXUy7q1ao1sCdQ5lkH0YUfDrr9gcEkIQty/m0e438Ob7XtKI/NvBIU7QpnzXvXGUjBoLD3/Z+CfmYofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb/ocuA9UwVTJ+GNaE09qFqDBAOhHOQ0jmeJ+M287+g=;
 b=tMawQQHXBqUkwnZtfS7htqHbkJMSOlBvd84bZsTTsHRb4IYZl3NxzT9A4oK5hK8pAS3nmftjejI7JSPUunNPO4lYAe0JNWowtxz5a0owkn7vLglR5yF8wIpzYEFWOSji4Mw5ELtTgnUVrFBWQZh49gsWkKLHbqmfsmjOnD1XLec=
Received: from MN2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:208:15e::40)
 by CY4PR02MB2661.namprd02.prod.outlook.com (2603:10b6:903:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 06:55:42 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:15e:cafe::ec) by MN2PR17CA0027.outlook.office365.com
 (2603:10b6:208:15e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Wed, 22 Jul 2020 06:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 06:55:41
 +0000
Received: from [149.199.38.66] (port=59653 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8dR-00024l-5P; Tue, 21 Jul 2020 23:53:49 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8fF-00037V-Ae; Tue, 21 Jul 2020 23:55:41 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06M6tZmD011758;
        Tue, 21 Jul 2020 23:55:35 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8f9-00036T-6D; Tue, 21 Jul 2020 23:55:35 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@codeaurora.org, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v2 2/3] clk: zynqmp: Use firmware specific divider clock flags
Date:   Tue, 21 Jul 2020 23:55:31 -0700
Message-Id: <1595400932-303612-3-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(346002)(39860400002)(46966005)(36756003)(2616005)(83380400001)(426003)(26005)(478600001)(5660300002)(356005)(186003)(107886003)(4326008)(81166007)(336012)(82310400002)(8936002)(7696005)(6666004)(9786002)(47076004)(316002)(82740400003)(8676002)(70206006)(70586007)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b4bae31b-de41-4d07-7757-08d82e0c3fbf
X-MS-TrafficTypeDiagnostic: CY4PR02MB2661:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2661EE1C2139BAAD02CFCF44A7790@CY4PR02MB2661.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yt2bK1elrbCIvqbScRp+NCEw7Te4U+W9eoOWG0qTyaXvjZOOtd45wsZKyyYHP+veBYw175Rd3KqgcrYYdRTCNFN9pe8lbVsmiey/zf3ChJmkAwkvGbwtYrNac8Tl9724YVpSnd6DZGPLVzuoXsM6X1ubzKYbqP1kZoC+WnjEnVxGql35Ki19jk8iyNEz4NprhCfbcxqjbfRr/2m0rvCWeTFRrIKJQ4MS2dpKUF5pdlDlEgfADmsFGPnYR2rHeih31lgNS7esGwaIxZpsd4s4CtwiYMGOkfrkOLp7941U0GrFUwngEvMN86DJomRsVdQPxu1xrq7Ykzv22Rcab6maemc/RFNwHgaojqdpd814rSo7njnbVKACkyLd3elDD5QGORTKn7CuvzBSUUmGpZc1zA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 06:55:41.6790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bae31b-de41-4d07-7757-08d82e0c3fbf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use ZynqMP specific divider clock flags instead of using CCF flags.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/clk-zynqmp.h |  9 +++++++++
 drivers/clk/zynqmp/divider.c    | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index 3cb6149..ec33525 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -32,6 +32,15 @@
 /* do not gate, ever */
 #define ZYNQMP_CLK_IS_CRITICAL         BIT(11)

+/* Type Flags for divider clock */
+#define ZYNQMP_CLK_DIVIDER_ONE_BASED           BIT(0)
+#define ZYNQMP_CLK_DIVIDER_POWER_OF_TWO                BIT(1)
+#define ZYNQMP_CLK_DIVIDER_ALLOW_ZERO          BIT(2)
+#define ZYNQMP_CLK_DIVIDER_HIWORD_MASK         BIT(3)
+#define ZYNQMP_CLK_DIVIDER_ROUND_CLOSEST       BIT(4)
+#define ZYNQMP_CLK_DIVIDER_READ_ONLY           BIT(5)
+#define ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO         BIT(6)
+
 enum topology_type {
        TYPE_INVALID,
        TYPE_MUX,
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 3ab57d9..86cb785 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -320,7 +320,21 @@ struct clk_hw *zynqmp_clk_register_divider(const char =
*name,
        /* struct clk_divider assignments */
        div->is_frac =3D !!((nodes->flag & CLK_FRAC) |
                          (nodes->custom_type_flag & CUSTOM_FLAG_CLK_FRAC))=
;
-       div->flags =3D nodes->type_flag;
+       div->flags =3D 0;
+       div->flags |=3D (nodes->type_flag & ZYNQMP_CLK_DIVIDER_ONE_BASED) ?
+                     CLK_DIVIDER_ONE_BASED : 0;
+       div->flags |=3D (nodes->type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO=
) ?
+                     CLK_DIVIDER_POWER_OF_TWO : 0;
+       div->flags |=3D (nodes->type_flag & ZYNQMP_CLK_DIVIDER_ALLOW_ZERO) =
?
+                     CLK_DIVIDER_ALLOW_ZERO : 0;
+       div->flags |=3D (nodes->type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO=
) ?
+                     CLK_DIVIDER_HIWORD_MASK : 0;
+       div->flags |=3D (nodes->type_flag & ZYNQMP_CLK_DIVIDER_ROUND_CLOSES=
T) ?
+                     CLK_DIVIDER_ROUND_CLOSEST : 0;
+       div->flags |=3D (nodes->type_flag & ZYNQMP_CLK_DIVIDER_READ_ONLY) ?
+                     CLK_DIVIDER_READ_ONLY : 0;
+       div->flags |=3D (nodes->type_flag & ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO)=
 ?
+                     CLK_DIVIDER_MAX_AT_ZERO : 0;
        div->hw.init =3D &init;
        div->clk_id =3D clk_id;
        div->div_type =3D nodes->type;
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
