Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C97C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD05720781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XwOsYz8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgF3Aaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:30:30 -0400
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:13892
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728420AbgF3AaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:30:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2TLAQA4UObwcgICnVUCxVMk+SNFlh7H9DnY6H7CSi0Zhb1IbanFjOrUaUnrRu8Rl6+ATVTRZAve3Qmn4u27iqOeglTn1PE5oEMUiG1UVwwMGcanDkVrvXGtDnAIGsZqWZN0SFHI2FbIERJOw6XhoY7LXtX6eCUsL8fQjmMT4+7mrlBZh5kuM5hBsjKIXzjCUSJBDsKQ9Zi31bVbJ/1KQt4SfXch175SurZh6m/5E/vnOQf+HYzu/Lq/goHD2k5/M6T5KqHHL5zQ4SWkzGGyIN9GH82J0PQrEPpbH6zECYdB4ooz1hDXevf6lT20V9GZLD4sZHpJSob+BmS0OpAubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG2jO2bAZPk1XXO2WlZNTAz4gDvNsEiwH0Xh1g1WXQU=;
 b=c0o276yDHNiCCyp59sFMKwmQoNJAco043vFvXuPiJk24IDfS8tkAunxJOuMaCFPNg8cRhqtfJqAJ8kDUn5NJOz0UgKUPvnDsR45mOO0mWRaD4N5lkm98tJiFAXchw412WzAixLBfJVHMUyRMVhoMUBMjM74ARLP2tpthjt235OAYzsD+VgVFEahEmTAPQnnjBhYfYazwvx5iXbifSdzgn8BIYYzrokjsR9ZCeiMrxi/0r/tA6cCkZQUxRA2WDOGH5KuAq3F51XflYWf08Lcm9yrlU+0BlbBk1Dvm8O/4vKSPH0+zIbt+MDKxF7YMtf4F6LDsexGnyQkSWt1E7IAwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG2jO2bAZPk1XXO2WlZNTAz4gDvNsEiwH0Xh1g1WXQU=;
 b=XwOsYz8H/5XcQoxzEgR/5KCGi4uNKWd4PE79AVQWTXvdP+4yBzvATqlSsSpCif2xwyO3+nth9A/u6RwR0Ie0lzMuOF0IjkTDmomjeFPrk/zB0M3fOk+8YXSPvhyVTn+NRwJfgBK4DOvDNa1XbpdkNqs8zUX5bTZeJ6Uz7PcWVJs=
Received: from BL0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:91::30)
 by CY4PR02MB2502.namprd02.prod.outlook.com (2603:10b6:903:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Tue, 30 Jun
 2020 00:30:20 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::5f) by BL0PR05CA0020.outlook.office365.com
 (2603:10b6:208:91::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.10 via Frontend
 Transport; Tue, 30 Jun 2020 00:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 00:30:20
 +0000
Received: from [149.199.38.66] (port=58555 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq48w-00054q-4x; Mon, 29 Jun 2020 17:28:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq4AF-0005bY-JU; Mon, 29 Jun 2020 17:30:19 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq4AC-0005YJ-6I; Mon, 29 Jun 2020 17:30:16 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@codeaurora.org, sboyd@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH 2/3] clk: zynqmp: Use firmware specific divider clock flags
Date:   Mon, 29 Jun 2020 17:30:13 -0700
Message-Id: <1593477014-18443-3-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593477014-18443-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1593477014-18443-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(136003)(39860400002)(346002)(396003)(46966005)(426003)(186003)(70586007)(336012)(82740400003)(4326008)(36756003)(54906003)(8936002)(70206006)(9786002)(2906002)(107886003)(5660300002)(8676002)(82310400002)(83380400001)(2616005)(26005)(316002)(356005)(6666004)(478600001)(47076004)(7696005)(81166007);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 34a247de-dec1-474d-67b1-08d81c8cc512
X-MS-TrafficTypeDiagnostic: CY4PR02MB2502:
X-Microsoft-Antispam-PRVS: <CY4PR02MB250230A6350155CA6A0C4984A76F0@CY4PR02MB2502.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQFhAS7c7+f6d+tmk89nTkhcsjnpdgTwB37GWF1cFzEHeQZxqOfEs/8nJcH1pfYsMteGWJg/iqBBzxId5d+rItJjGU2o+NveeyI6jb4rIBT590ztHwIedPUMeZoEg4YN2UbYh1VjJormvce6cyqZRGR7/mlJA8taPYQqs9Buo6RYTVXjM03wqDamq+Al6gSSL57cfC2/qK7kADERnjdTg5XvwePhKVWlw/jndcPKwUlyfT8YE33hbKTDCS7I5+qDKnsVeKCcsA1biylEP1WrIv9bFetIBZGhg27Ke+j/CEg9onQ73XNVgraoqBewl1cVz0W2t/o/dEcUlKAN4khQvtCAYKcmmLog8IPtUEbt2sLjedjKBqfQrmbFjGseM/yHQ718MDn/GyyEYe2WAVsXbg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 00:30:20.0142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a247de-dec1-474d-67b1-08d81c8cc512
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use ZynqMP specific divider clock flags instead of using CCF flags.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/clk-zynqmp.h |  9 +++++++++
 drivers/clk/zynqmp/divider.c    | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index d8e580b..ade5e9e 100644
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
index 66da02b..f15d6b7 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -319,7 +319,21 @@ struct clk_hw *zynqmp_clk_register_divider(const char =
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
