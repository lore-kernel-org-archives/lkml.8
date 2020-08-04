Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFAC82086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BKA+Ka+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgHDGo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:44:57 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:1793
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbgHDGoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:44:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYmxn6zr+jX2G3K/xmqoRMBfVO/2Kj66GtjzrFKQwPCn2jyTx/Nw7JWXZNay6k/OHfsHmsOdNfa+YkvHeHvFRzitrmc1Qewf4OCYGUKHcsC3eiCIROOqRzELEx5uUeUa8hyljYdBQspUsZ4OcX+a7EHj7ByD3o7DVhPyWHJcJk1HWa4h8bxDpgBaUnrnH/eq9+rx/VRP+LS9VUaNGNrs0bR3yi7ld4phNVlSehAL9sbIFuVCqNvhRKCEtePPGoV472G7Mb9Uz7QwKwW56o4UpUoOCohhdOe2yUi+JR4AYHQZT3KUD8LD4VS/DkUTVDU5TmHtMKRC4jsYXNqcpZvY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d5WSwkqjgB+9B/yWvRV8SciSLU/ka0eJIS3TIAqApo=;
 b=e5smOd/m6VH3yiIE36QwzK2gYUtEo0mO1ash0iOe4ZZ4WLJvsbaQhb3/2b495vAa6YI646q37QYLo9brkM2095wq+j9VnXpR0tgtPrFtex3BA7OTTBOPfTsLSD4dp15NLkG/sYk2HtyPyM5pLw+y+LF4c72ZmzfYBy77KYSA+iLL7Ex+1pLjgInjJM49zxoY0p+96YCKQhnsxQjV+5PUzkE+4LCMqxI71Pmasq/dK9FYPQDShACm6eeVb7npGrEd7RKHUWaHk8EJTCBd/c/khX0+jdZHc+vW1c1gfvax/r19ned52K2F8+A13m71QFUvHqy7q9ewgbTq5533yg1Y1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d5WSwkqjgB+9B/yWvRV8SciSLU/ka0eJIS3TIAqApo=;
 b=BKA+Ka+bliAeGwuiYRX8lcVFxPY+hfff81a3JFGBrqKi3a4hczaJ6vVYe70c2u3N7lCTNCyGcunHjisnp6e/pBldUM24IbCZUlg9ohqEx/wHxiknmCi3AHL4ykbK7yxVMvXIFi8ffDULGMD33wSF1amd1ib0aUGhb6lLm7OLoZg=
Received: from MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21) by
 CY4PR0201MB3553.namprd02.prod.outlook.com (2603:10b6:910:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 06:44:51 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23f:cafe::15) by MN2PR01CA0052.outlook.office365.com
 (2603:10b6:208:23f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Tue, 4 Aug 2020 06:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 06:44:51
 +0000
Received: from [149.199.38.66] (port=42247 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgp-00022b-Ai; Mon, 03 Aug 2020 23:44:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgs-0007mp-Ip; Mon, 03 Aug 2020 23:44:50 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgl-0007l0-8o; Mon, 03 Aug 2020 23:44:43 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v3 2/3] clk: zynqmp: Use firmware specific divider clock flags
Date:   Mon,  3 Aug 2020 23:44:16 -0700
Message-Id: <1596523457-40465-3-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596523457-40465-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1596523457-40465-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2804104d-f81c-43e2-fc26-08d83841e34e
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3553:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB35531BA6C78E551DA181B8C9A74A0@CY4PR0201MB3553.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpTiCSd3C14Iv4yJy7i+1J75D6LnIf9g7XOBNyAmHEfv5wqDMB27YnlGPJmijjVhub1iiMFtltYYffhVJ2pEJ7xnXFFG7S8LZgcd+sJgG1Ion5U0MFHgL2sV0O78BkX2dBF1V8nzDaBNS2BRucU1fAcvjy8ETJN8VwaDMMvJDMzvJBpAxgebs9yXf2EvxzEhk050E66wZgfp/RIe1wtcDQsrYgCG0/LWvQ/q2i+X1g2b1o1UNfuSp71E5i/1lzW/i+G1l7ujaMmJClfMzzQCBoe8gpBjI6u/8p2bkdXNOh32xYsxP6/jWKdeA+AuCT723c7lb8BOmVL7uHGeDGpFfBU9it2ZIbUcP+2Moxm/CCJcwj0dHgbtONRmDxQ7rjwbBja9e/Z/tTYe7HbJMuYtSQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(39860400002)(136003)(46966005)(36756003)(4326008)(70206006)(107886003)(81166007)(336012)(47076004)(82740400003)(54906003)(2616005)(356005)(478600001)(8936002)(7696005)(70586007)(83380400001)(316002)(26005)(82310400002)(8676002)(186003)(426003)(9786002)(5660300002)(6666004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 06:44:51.0469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2804104d-f81c-43e2-fc26-08d83841e34e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3553
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
 drivers/clk/zynqmp/divider.c    | 24 +++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index 974d3da..9b2ff35e 100644
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
index 775d54f..3b8fad0 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -283,6 +283,28 @@ static u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 =
type)
        return ret_payload[1];
 }

+static inline unsigned long zynqmp_clk_map_divider_ccf_flags(
+                                              const u32 zynqmp_type_flag)
+{
+       unsigned long ccf_flag =3D 0;
+
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_ONE_BASED) ?
+                     CLK_DIVIDER_ONE_BASED : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO) =
?
+                     CLK_DIVIDER_POWER_OF_TWO : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_ALLOW_ZERO) ?
+                     CLK_DIVIDER_ALLOW_ZERO : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO) =
?
+                     CLK_DIVIDER_HIWORD_MASK : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_ROUND_CLOSEST)=
 ?
+                     CLK_DIVIDER_ROUND_CLOSEST : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_READ_ONLY) ?
+                     CLK_DIVIDER_READ_ONLY : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO) ?
+                     CLK_DIVIDER_MAX_AT_ZERO : 0;
+       return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_divider() - Register a divider clock
  * @name:              Name of this clock
@@ -320,7 +342,7 @@ struct clk_hw *zynqmp_clk_register_divider(const char *=
name,
        /* struct clk_divider assignments */
        div->is_frac =3D !!((nodes->flag & CLK_FRAC) |
                          (nodes->custom_type_flag & CUSTOM_FLAG_CLK_FRAC))=
;
-       div->flags =3D nodes->type_flag;
+       div->flags =3D zynqmp_clk_map_divider_ccf_flags(nodes->type_flag);
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
