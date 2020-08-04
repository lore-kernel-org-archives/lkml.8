Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5795DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6047220781
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cZ0qyYow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgHDGpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:45:03 -0400
Received: from mail-dm6nam10on2074.outbound.protection.outlook.com ([40.107.93.74]:29152
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbgHDGoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCaYLcsx0lHW9iNy5tPqzVxgv+gTjQ83wnd0gsSewFQte5UCfjYWGYvpn9lE7O4qqTaTyuaKSO+By0D0GHZuv7WwyJszzjNJpam6ELVJ53y4xjj+acG4CSIKkG+9PHjIYPQTgO0TH3Y58gE9RRKK+yLHc7fBMirbWkaPcMknhjrx6FwIt8i+YN1mPRJe3jKb0gafALWSkGVI7sd1CCkcXxbbY039jC2hW2OOQorI0zQxmE1qkwo3p7ED4kJfEC9rAKFLM+yiGDql4YnkpfzXdnwLjqQJOj6BXN//QTszaOwJ/szJEl/HeRp4IscPFlxOJQVtvckSZG3L3mVRdep/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb25wN7iOEB7s87W7/6I8p7l4W4ei406Vj6NPcMcVYs=;
 b=b1bnW5vxQFZwfgybQwQLLp1ql/yfZqZm+sikuaOh8HiHW7hQeG1vdzgIStJrXO37WI/FCP7LKZGYW0i2UPEj7dSkmuDBOsKthT18Y6uNm/8diOEaJGGW+9f9yEdAKXtEoWFQ1+tHz79X7GpNyQLO75xEaRUmvuWdVGKb7jltI5yWKdrYpcoW56NLKg4tYLhFLJCiUT8siWrmnVfS/m9ZLhW6v3znFzZm0GX+3rCDGW18PsK4uwJsL6KVLBkUHYB6xw7C8q4PPDI+yy5JB9SkcNrV3bXX/nKK3G2LFM1iRdXJb3uTexwdZ91kfQRr/rRFeP6MVbNhbeG9yUALMUzgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb25wN7iOEB7s87W7/6I8p7l4W4ei406Vj6NPcMcVYs=;
 b=cZ0qyYowU+sOzgs3Hv3gOtQdI5HUZbQlGbx0jhLOy85o6XIC4pJK+tszRGmjKCc9GliSFHItDJK3yO3Qqs/UWqKWasG8/1XfGpjwCre2jiUa2F2Z+yzAC0teQv5Cbp6v3QJR8CPeul30zZqY+KN8sEOIcZU/Gz5587Ri80Zxv98=
Received: from CY4PR16CA0042.namprd16.prod.outlook.com (2603:10b6:910:60::29)
 by DM5PR02MB2185.namprd02.prod.outlook.com (2603:10b6:3:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 06:44:52 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:60:cafe::d7) by CY4PR16CA0042.outlook.office365.com
 (2603:10b6:910:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 4 Aug 2020 06:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 06:44:50
 +0000
Received: from [149.199.38.66] (port=42219 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgp-00022X-6x; Mon, 03 Aug 2020 23:44:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgs-0007mp-FC; Mon, 03 Aug 2020 23:44:50 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgl-0007l0-Ah; Mon, 03 Aug 2020 23:44:43 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v3 3/3] clk: zynqmp: Use firmware specific mux clock flags
Date:   Mon,  3 Aug 2020 23:44:17 -0700
Message-Id: <1596523457-40465-4-git-send-email-amit.sunil.dhamne@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: c14797b5-ae1a-4067-b2be-08d83841e319
X-MS-TrafficTypeDiagnostic: DM5PR02MB2185:
X-Microsoft-Antispam-PRVS: <DM5PR02MB218569B83DC5A3A21F9A004EA74A0@DM5PR02MB2185.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wILi2I0vUDzxrdxoTQnBf1Mv+tGVG9VVJ/WuOpt1yNb7p6XT0paxHq+mXCwte8stk4dYI0U5ZXZ7SVYd9siHUhpDmI2+zWh6LG4a4XVBiQTYXWoBl+n8axWGuWaZZ2Co8U+0FjplQGKYDjnSxFQPOP58a1RGngLMkspMT4lsWQkdduSnL9eK2DKKBOokG2mwG+DLsYvAEl7YgCcoleOdeqSDUppMv0+YV2S9V6SIvGQkDsnB7DXt4zSv4END+At42dCXZjZgTuIvChPWLjtrMX+pYWWXbINFNwNc/M8PfwsN2mAbXxj5H9Rv01AeW8MeuI/8tjGWwL8/hyX3NFiJjb/zBBpO120SSc1NFR06GUjAHn0Zgyzrx1r+n/drlxPIq/J6/EHwqTLIPudQR/kIpg==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(396003)(376002)(46966005)(82310400002)(83380400001)(316002)(70586007)(6666004)(7696005)(5660300002)(186003)(2906002)(9786002)(426003)(8676002)(26005)(8936002)(36756003)(81166007)(4326008)(107886003)(70206006)(54906003)(2616005)(336012)(356005)(478600001)(47076004)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 06:44:50.6977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14797b5-ae1a-4067-b2be-08d83841e319
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use ZynqMP specific mux clock flags instead of using CCF flags.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/clk-mux-zynqmp.c | 22 +++++++++++++++++++++-
 drivers/clk/zynqmp/clk-zynqmp.h     |  8 ++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-m=
ux-zynqmp.c
index a49b1c5..8a8c960 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -90,6 +90,26 @@ static const struct clk_ops zynqmp_clk_mux_ro_ops =3D {
        .get_parent =3D zynqmp_clk_mux_get_parent,
 };

+static inline unsigned long zynqmp_clk_map_mux_ccf_flags(
+                                      const u32 zynqmp_type_flag)
+{
+       unsigned long ccf_flag =3D 0;
+
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_MUX_INDEX_ONE) ?
+                     CLK_MUX_INDEX_ONE : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_MUX_INDEX_BIT) ?
+                     CLK_MUX_INDEX_BIT : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_MUX_HIWORD_MASK) ?
+                     CLK_MUX_HIWORD_MASK : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_MUX_READ_ONLY) ?
+                     CLK_MUX_READ_ONLY : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_MUX_ROUND_CLOSEST) ?
+                     CLK_MUX_ROUND_CLOSEST : 0;
+       ccf_flag |=3D (zynqmp_type_flag & ZYNQMP_CLK_MUX_BIG_ENDIAN) ?
+                     CLK_MUX_BIG_ENDIAN : 0;
+       return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_mux() - Register a mux table with the clock
  *                            framework
@@ -125,7 +145,7 @@ struct clk_hw *zynqmp_clk_register_mux(const char *name=
, u32 clk_id,

        init.parent_names =3D parents;
        init.num_parents =3D num_parents;
-       mux->flags =3D nodes->type_flag;
+       mux->flags =3D zynqmp_clk_map_mux_ccf_flags(nodes->type_flag);
        mux->hw.init =3D &init;
        mux->clk_id =3D clk_id;

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index 9b2ff35e..87a2e12 100644
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
