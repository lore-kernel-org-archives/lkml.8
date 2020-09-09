Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CE2C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4D320665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BtCLWo03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgIIUpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:45:17 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:7641
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729986AbgIIUpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra7A1eTiLuj30iXnFbEZsut9H3lH/ZPpTUIPX+g1wu81/xFU1gMSFnPwSFDYke8epeo1uBm5HVClz7UWmIYGAs8nc72u1trwnCIacR7lnEbBGwTJIuhfIhFBipk7+9WMZmciMbDqcx6ltJLRgCMXSPiw6gFq+yHRf+cQeKNYj5PsCe4XwW0D/Ic6NYuU0zVeDyrlexZf1FIMLNaArFZQzrPMRv/MltdQnldHZ/DKEhbFrzon9xESjgguJ0ioP+ni1RgeXGbv+I7XAKh/CcaX82XOTDfKxJLy3KrT/Jbid8MCQ88QAlXXsSSdjl6mblFXMOylb7ToM4iWFELuwlxfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM1VryKH+n0t0tM5vUbDmaqbzjNnNhJztsFboYXue8s=;
 b=g3mVFTXaIkyXpXOFhOouNRhpzV+Gs2KAODhwTJLLdjn/i0ZUDnkMre7/3+/uoYMKxK/9i9Hy2t0wH5FEIWuqgUCJghiCdh11tQKk90bl69Jya1L6eSfwXoIiyPuGyVEsxKIt6yYWu6DRlliQGbEqtHAbKFnA0wO+xBvdg+Umz+zAAeKfUmP7mrWX7WX1OJ8W+XxH1fxqAE1feCRUdqi8mN/twxUspYL+TJG+4Qs8025MQqFV6XBqcRm7nGLH8tZPiC4ACXQ6m5RqAhV4E6zoc0c4N+S2eso7jE8IiSOaM21leo1ubuurinrNmamcM9qoxQI9QREQXtfZdQDzewhabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM1VryKH+n0t0tM5vUbDmaqbzjNnNhJztsFboYXue8s=;
 b=BtCLWo03HsqJBgy1GdHskfFphZ/HRdtovAi6X9YqJJX9dsBFV/NJRNKVtAE2Y9jZX2gVG3SxuokBNyXYEY06akFrbsPQtYaUURED7+8LNwww0XjdCLUdmUTmjiZihwfOuy5jMY0yUKNbOM6fEjLR2yLUPIQFCxzLKLXAzJfC8j4=
Received: from CY4PR16CA0030.namprd16.prod.outlook.com (2603:10b6:910:60::17)
 by SN6PR02MB5102.namprd02.prod.outlook.com (2603:10b6:805:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 20:45:00 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:60:cafe::ce) by CY4PR16CA0030.outlook.office365.com
 (2603:10b6:910:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 20:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 20:45:00
 +0000
Received: from [149.199.38.66] (port=53384 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xP-0001xR-Ko; Wed, 09 Sep 2020 13:44:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xf-0007dx-S3; Wed, 09 Sep 2020 13:44:59 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 089KisL3028426;
        Wed, 9 Sep 2020 13:44:54 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xa-0007dJ-8c; Wed, 09 Sep 2020 13:44:54 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v4 1/3] clk: zynqmp: Use firmware specific common clock flags
Date:   Wed,  9 Sep 2020 13:44:46 -0700
Message-Id: <1599684288-20917-2-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599684288-20917-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1599684288-20917-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e125bc2e-b1e0-4412-f211-08d855013851
X-MS-TrafficTypeDiagnostic: SN6PR02MB5102:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5102CAB530D619D030D0AA91A7260@SN6PR02MB5102.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfVf3X437snjZa9K9lFyms4EQ+wqsnRBB02FJj67P1RsX++oYFokukzmhhlqujUqLFWtqZqFs1JQ00ECpb1bMpMM5JRvbw6O7MilNWuLRk+R6gIi0+G7boI4P8vcQjdAoLS6zDPp09oQQBPfuUPUV4tvgKQTW8n1moYC8vG9K+XEtptA3Vn43qs7Zmz7Iltzeihokomq9/ihtjvu4/E4Bm24LJ8DfTWII3PRleYxOihS4t8aC3g3Jt2bZ/8/NJtJUVLSvYGi9D8uRHwlc99RLrKAP7C+mf0LOuwilOjHoOE81hVjDKT+OAEevjM/ak7nmZN6e7l3DO/2CxjqnLc8uwmP7mey6wVJHAu8r+fF6aB6MTAiakYV9DKO8wEpsneQlFSoxyZxW3zYCrE88A8foQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(376002)(39860400002)(396003)(346002)(46966005)(6666004)(9786002)(70586007)(5660300002)(82310400003)(7696005)(316002)(54906003)(2906002)(26005)(36756003)(8676002)(186003)(70206006)(2616005)(478600001)(426003)(47076004)(81166007)(82740400003)(107886003)(356005)(336012)(4326008)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 20:45:00.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e125bc2e-b1e0-4412-f211-08d855013851
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Currently firmware passes CCF specific flags to ZynqMP clock driver.
So firmware needs to be updated if CCF flags are changed. The firmware
should have its own 'flag number space' that is distinct from the
common clk framework's 'flag number space'. So define and use ZynqMP
specific common clock flags instead of using CCF flags.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/clk-gate-zynqmp.c |  4 +++-
 drivers/clk/zynqmp/clk-mux-zynqmp.c  |  4 +++-
 drivers/clk/zynqmp/clk-zynqmp.h      | 24 ++++++++++++++++++++++++
 drivers/clk/zynqmp/clkc.c            | 33 ++++++++++++++++++++++++++++++++=
-
 drivers/clk/zynqmp/divider.c         |  5 +++--
 drivers/clk/zynqmp/pll.c             |  4 +++-
 6 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-=
gate-zynqmp.c
index 10c9b88..695feaa 100644
--- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -121,7 +121,9 @@ struct clk_hw *zynqmp_clk_register_gate(const char *nam=
e, u32 clk_id,

        init.name =3D name;
        init.ops =3D &zynqmp_clk_gate_ops;
-       init.flags =3D nodes->flag;
+
+       init.flags =3D zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
        init.parent_names =3D parents;
        init.num_parents =3D 1;

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-m=
ux-zynqmp.c
index 0619414..a49b1c5 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -120,7 +120,9 @@ struct clk_hw *zynqmp_clk_register_mux(const char *name=
, u32 clk_id,
                init.ops =3D &zynqmp_clk_mux_ro_ops;
        else
                init.ops =3D &zynqmp_clk_mux_ops;
-       init.flags =3D nodes->flag;
+
+       init.flags =3D zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
        init.parent_names =3D parents;
        init.num_parents =3D num_parents;
        mux->flags =3D nodes->type_flag;
diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index 5beeb41..974d3da 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -10,6 +10,28 @@

 #include <linux/firmware/xlnx-zynqmp.h>

+/* Common Flags */
+/* must be gated across rate change */
+#define ZYNQMP_CLK_SET_RATE_GATE       BIT(0)
+/* must be gated across re-parent */
+#define ZYNQMP_CLK_SET_PARENT_GATE     BIT(1)
+/* propagate rate change up one level */
+#define ZYNQMP_CLK_SET_RATE_PARENT     BIT(2)
+/* do not gate even if unused */
+#define ZYNQMP_CLK_IGNORE_UNUSED       BIT(3)
+/* do not use the cached clk rate */
+#define ZYNQMP_CLK_GET_RATE_NOCACHE    BIT(6)
+/* don't re-parent on rate change */
+#define ZYNQMP_CLK_SET_RATE_NO_REPARENT        BIT(7)
+/* do not use the cached clk accuracy */
+#define ZYNQMP_CLK_GET_ACCURACY_NOCACHE        BIT(8)
+/* recalc rates after notifications */
+#define ZYNQMP_CLK_RECALC_NEW_RATES    BIT(9)
+/* clock needs to run to set rate */
+#define ZYNQMP_CLK_SET_RATE_UNGATE     BIT(10)
+/* do not gate, ever */
+#define ZYNQMP_CLK_IS_CRITICAL         BIT(11)
+
 enum topology_type {
        TYPE_INVALID,
        TYPE_MUX,
@@ -33,6 +55,8 @@ struct clock_topology {
        u8 custom_type_flag;
 };

+unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag);
+
 struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
                                       const char * const *parents,
                                       u8 num_parents,
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index db8d0d7..af06a19 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -271,6 +271,34 @@ static int zynqmp_pm_clock_get_topology(u32 clock_id, =
u32 index,
        return ret;
 }

+unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag)
+{
+       unsigned long ccf_flag =3D 0;
+
+       if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_GATE)
+               ccf_flag |=3D CLK_SET_RATE_GATE;
+       if (zynqmp_flag & ZYNQMP_CLK_SET_PARENT_GATE)
+               ccf_flag |=3D CLK_SET_PARENT_GATE;
+       if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_PARENT)
+               ccf_flag |=3D CLK_SET_RATE_PARENT;
+       if (zynqmp_flag & ZYNQMP_CLK_IGNORE_UNUSED)
+               ccf_flag |=3D CLK_IGNORE_UNUSED;
+       if (zynqmp_flag & ZYNQMP_CLK_GET_RATE_NOCACHE)
+               ccf_flag |=3D CLK_GET_RATE_NOCACHE;
+       if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_NO_REPARENT)
+               ccf_flag |=3D CLK_SET_RATE_NO_REPARENT;
+       if (zynqmp_flag & ZYNQMP_CLK_GET_ACCURACY_NOCACHE)
+               ccf_flag |=3D CLK_GET_ACCURACY_NOCACHE;
+       if (zynqmp_flag & ZYNQMP_CLK_RECALC_NEW_RATES)
+               ccf_flag |=3D CLK_RECALC_NEW_RATES;
+       if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_UNGATE)
+               ccf_flag |=3D CLK_SET_RATE_UNGATE;
+       if (zynqmp_flag & ZYNQMP_CLK_IS_CRITICAL)
+               ccf_flag |=3D CLK_IS_CRITICAL;
+
+       return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_fixed_factor() - Register fixed factor with the
  *                                     clock framework
@@ -292,6 +320,7 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const c=
har *name, u32 clk_id,
        struct zynqmp_pm_query_data qdata =3D {0};
        u32 ret_payload[PAYLOAD_ARG_CNT];
        int ret;
+       unsigned long flag;

        qdata.qid =3D PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
        qdata.arg1 =3D clk_id;
@@ -303,9 +332,11 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const =
char *name, u32 clk_id,
        mult =3D ret_payload[1];
        div =3D ret_payload[2];

+       flag =3D zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
        hw =3D clk_hw_register_fixed_factor(NULL, name,
                                          parents[0],
-                                         nodes->flag, mult,
+                                         flag, mult,
                                          div);

        return hw;
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 66da02b..775d54f 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -311,8 +311,9 @@ struct clk_hw *zynqmp_clk_register_divider(const char *=
name,

        init.name =3D name;
        init.ops =3D &zynqmp_clk_divider_ops;
-       /* CLK_FRAC is not defined in the common clk framework */
-       init.flags =3D nodes->flag & ~CLK_FRAC;
+
+       init.flags =3D zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
        init.parent_names =3D parents;
        init.num_parents =3D 1;

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 92f449e..d188924 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -302,7 +302,9 @@ struct clk_hw *zynqmp_clk_register_pll(const char *name=
, u32 clk_id,

        init.name =3D name;
        init.ops =3D &zynqmp_pll_ops;
-       init.flags =3D nodes->flag;
+
+       init.flags =3D zynqmp_clk_map_common_ccf_flags(nodes->flag);
+
        init.parent_names =3D parents;
        init.num_parents =3D 1;

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
