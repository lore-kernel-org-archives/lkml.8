Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400BBC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8B0206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a6DDg61Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgGVGz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:55:56 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:20832
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728338AbgGVGzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:55:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyL3DaHeB/B6gIr7fESuYOinXwjJVj9bBTcITvy3ohXlpGmN8SwKyw06aDDPSnMTeNTV4IC5jh8EXQFd4tTuMbDGJHbXyR/GlS249JCcFNJ65yEhh+2fZFW/VWVjRwHc3+ZgEwGBnVlQX2OEr4VB2KyYq3zZr2ZmMVSbZICyZOetPdXR1KLcP3p8wy5otC+/EWUflCJkURl82Qu0A9M97jtds/+75EKoqASTAiOHq+P2CQm8vx/Nd745hEKLRNWEPaZS2PM2FaPdKNUeLaiM43ZxFWw1dFNE35/J3jrHrBhV0g/w38bEilmtKur7nk04T9dvaRCvEXryTZBIDBFBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSfJPHyHc6v3iZ6Kz19eqhR0ibZzTu1XSm0TObIkdWU=;
 b=CNqTMtA5FJ+AcOAVFqjOgCAMbu0VTumoi39yP+dlJbvHywC64Swm5ie4eXcw4VFKGPhZuFdhuwTuukiI3lskezovicFsX/i9Pcs+fb3EPwE5HUpfVyO74r++bcxkoPjHAk1xUWmeURuhGzol/SY6k79QqJAoIk5uiLSuUygnFHn00v3hUu71QHvPJ6xd9Zu5IRgKHfF2luWOlR4okkIfNimBM9+vPL4RxtYSFMCKK1R0cf61qgan7JTdATN0Mi6TaomS025al47IO/I0A6H5NcG05GasdSDlbcpAQ+hyr03go33KySgYIZzzvjU5uapLqWyVeLt5niO5b76LOxmDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSfJPHyHc6v3iZ6Kz19eqhR0ibZzTu1XSm0TObIkdWU=;
 b=a6DDg61Q+rnTTLnIzyyMCJnhHQ7SMsx5N62yKJ8ANY3u5LoR+KU7N0Af0OxL24gv38w5bnTkanhNJZn6NWlzGRneh/fLFB+yhkIRxlfPrO9atyCmez3OR1ciI0WJxffuRZyuupkyBpua+AiLGkQQLmZmhdOys9Ly33Xm6bxO+eQ=
Received: from SN6PR16CA0055.namprd16.prod.outlook.com (2603:10b6:805:ca::32)
 by BYAPR02MB5624.namprd02.prod.outlook.com (2603:10b6:a03:9c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 06:55:42 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::fa) by SN6PR16CA0055.outlook.office365.com
 (2603:10b6:805:ca::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Wed, 22 Jul 2020 06:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 06:55:41
 +0000
Received: from [149.199.38.66] (port=59664 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8dR-00024p-Bk; Tue, 21 Jul 2020 23:53:49 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8fF-00037V-Gu; Tue, 21 Jul 2020 23:55:41 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06M6tZ6m007793;
        Tue, 21 Jul 2020 23:55:35 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8f9-00036T-49; Tue, 21 Jul 2020 23:55:35 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@codeaurora.org, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v2 1/3] clk: zynqmp: Use firmware specific common clock flags
Date:   Tue, 21 Jul 2020 23:55:30 -0700
Message-Id: <1595400932-303612-2-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(136003)(346002)(39860400002)(396003)(376002)(46966005)(8676002)(26005)(82740400003)(7696005)(54906003)(478600001)(186003)(2616005)(70206006)(70586007)(83380400001)(4326008)(47076004)(82310400002)(5660300002)(2906002)(36756003)(316002)(8936002)(426003)(6666004)(336012)(107886003)(81166007)(356005)(9786002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 366b99a6-6e53-4013-e466-08d82e0c3fd1
X-MS-TrafficTypeDiagnostic: BYAPR02MB5624:
X-Microsoft-Antispam-PRVS: <BYAPR02MB562494E2EB52508FEEDF25DBA7790@BYAPR02MB5624.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8t1mGzEFPvzGAH1wKXHueFPtKsppvtstSvNTQamqk94OuBUEkUtd+9UReBG35/Q0Tf6Gjy5w+btvoDmrIKHEs1Y/Rhk0KHJnk/3TdVZih3Gpxoq+PFB5MAHT1DyEcgBFl1FofjjUrI9v1UbJzUecummmTko8JfUwbX8lo6MzkiRIUekc9XeC8s1BFzbefkaCtY4begCRsVdDyVuR5lBfpB6M/Y1j9elX8WD/DLk8cMon9EXQN9XgDrk8yj9Fwbf9kjvchtSexedEbgAJvPyx5gxRKYk/ymOGWpCiZWez136R295IwZ93kFUjcZXI5bzOTOYxDho56T62Ud0UemjU6yljhTfVEr6QOiMFRZDkPg1vCG0Bh3TycqxQqt6VULd7375uqJKy05BENPnqdyNEmQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 06:55:41.8010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366b99a6-6e53-4013-e466-08d82e0c3fd1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5624
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
 drivers/clk/zynqmp/clk-zynqmp.h      | 25 +++++++++++++++++++++++++
 drivers/clk/zynqmp/clkc.c            | 31 ++++++++++++++++++++++++++++++-
 drivers/clk/zynqmp/divider.c         |  5 +++--
 drivers/clk/zynqmp/pll.c             |  4 +++-
 6 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-=
gate-zynqmp.c
index 10c9b88..bcabebf 100644
--- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -121,7 +121,9 @@ struct clk_hw *zynqmp_clk_register_gate(const char *nam=
e, u32 clk_id,

        init.name =3D name;
        init.ops =3D &zynqmp_clk_gate_ops;
-       init.flags =3D nodes->flag;
+
+       zynqmp_clk_map_common_ccf_flags(nodes->flag, &init.flags);
+
        init.parent_names =3D parents;
        init.num_parents =3D 1;

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-m=
ux-zynqmp.c
index 0619414..1dc17a0 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -120,7 +120,9 @@ struct clk_hw *zynqmp_clk_register_mux(const char *name=
, u32 clk_id,
                init.ops =3D &zynqmp_clk_mux_ro_ops;
        else
                init.ops =3D &zynqmp_clk_mux_ops;
-       init.flags =3D nodes->flag;
+
+       zynqmp_clk_map_common_ccf_flags(nodes->flag, &init.flags);
+
        init.parent_names =3D parents;
        init.num_parents =3D num_parents;
        mux->flags =3D nodes->type_flag;
diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index 5beeb41..3cb6149 100644
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
@@ -33,6 +55,9 @@ struct clock_topology {
        u8 custom_type_flag;
 };

+void zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag,
+                                    unsigned long *ccf_flag);
+
 struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
                                       const char * const *parents,
                                       u8 num_parents,
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index db8d0d7..11351f6 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -271,6 +271,32 @@ static int zynqmp_pm_clock_get_topology(u32 clock_id, =
u32 index,
        return ret;
 }

+void zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag,
+                                    unsigned long *ccf_flag)
+{
+       *ccf_flag =3D 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_GATE) ?
+                     CLK_SET_RATE_GATE : 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_PARENT_GATE) ?
+                     CLK_SET_PARENT_GATE : 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_PARENT) ?
+                     CLK_SET_RATE_PARENT : 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_IGNORE_UNUSED) ?
+                     CLK_IGNORE_UNUSED : 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_GET_RATE_NOCACHE) ?
+                     CLK_GET_RATE_NOCACHE : 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_NO_REPARENT) ?
+                     CLK_SET_RATE_NO_REPARENT : 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_GET_ACCURACY_NOCACHE) ?
+                     CLK_GET_ACCURACY_NOCACHE : 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_RECALC_NEW_RATES) ?
+                     CLK_RECALC_NEW_RATES : 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_UNGATE) ?
+                     CLK_SET_RATE_UNGATE : 0;
+       *ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_IS_CRITICAL) ?
+                     CLK_IS_CRITICAL : 0;
+}
+
 /**
  * zynqmp_clk_register_fixed_factor() - Register fixed factor with the
  *                                     clock framework
@@ -292,6 +318,7 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const c=
har *name, u32 clk_id,
        struct zynqmp_pm_query_data qdata =3D {0};
        u32 ret_payload[PAYLOAD_ARG_CNT];
        int ret;
+       unsigned long flag;

        qdata.qid =3D PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
        qdata.arg1 =3D clk_id;
@@ -303,9 +330,11 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const =
char *name, u32 clk_id,
        mult =3D ret_payload[1];
        div =3D ret_payload[2];

+       zynqmp_clk_map_common_ccf_flags(nodes->flag, &flag);
+
        hw =3D clk_hw_register_fixed_factor(NULL, name,
                                          parents[0],
-                                         nodes->flag, mult,
+                                         flag, mult,
                                          div);

        return hw;
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 66da02b..3ab57d9 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -311,8 +311,9 @@ struct clk_hw *zynqmp_clk_register_divider(const char *=
name,

        init.name =3D name;
        init.ops =3D &zynqmp_clk_divider_ops;
-       /* CLK_FRAC is not defined in the common clk framework */
-       init.flags =3D nodes->flag & ~CLK_FRAC;
+
+       zynqmp_clk_map_common_ccf_flags(nodes->flag, &init.flags);
+
        init.parent_names =3D parents;
        init.num_parents =3D 1;

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 92f449e..1b7e231 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -302,7 +302,9 @@ struct clk_hw *zynqmp_clk_register_pll(const char *name=
, u32 clk_id,

        init.name =3D name;
        init.ops =3D &zynqmp_pll_ops;
-       init.flags =3D nodes->flag;
+
+       zynqmp_clk_map_common_ccf_flags(nodes->flag, &init.flags);
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
