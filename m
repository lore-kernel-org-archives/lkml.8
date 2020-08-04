Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A45C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5847120781
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZZgkRbOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgHDGpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:45:04 -0400
Received: from mail-eopbgr700048.outbound.protection.outlook.com ([40.107.70.48]:46817
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgHDGoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbh9cwOxtY1R/0UfVNiFpmRZN5xdkDrGZYudkePCtIG2J6uOtJ+GpA246+PIqnSb1b1jnwIrH5BW0HBMLLY6B3Cx6tXtmNF5ibJ4dHoaDtExRkt/+wZotBdwhaCCyfqiIKdRnC1oM0auopf3H9rOuRqEtJLRHPtsPQVpcd8/BB3x+N+3iu2G70YRuAWwSajNI34K4ltlQ9LbktuxgCIr/EmllImUIPD67IMT8z+6RNfcdsD1RGPlowR82uSgFVvxVfeEHdeFWHWLCRQHCKcAM9DQUxeH6gsgfbfpUMqZBbXD9Xl4lOI6CEnILh5yYj/W68cPsDKvH5Vt/SSxz5F8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grZ2h29+pNMEeD3NYoIZV0pqnIdp5O4ban4Jmv40nqI=;
 b=HZ5pF96VvdOv7io1ZPhBgZ4h9XyMVRGZ8WQ0fR1XOxUyA6KGgqTaOSdz+hNcAFf/5tvvsSCDkSDwR14Y8h0y+wxqRddsVQHSquNnA9l9klsOkE/XXlsClztcPKTLE12QFeHe2NEIjGCNXizPnv6u7QeVepJuFpj/k7OYApKfSU0sbEM5eqFOpcp4sCl1LxsRhJuflWwiggyzCHUbaGpn301lQs23d2o4Qw+ias2JLy1nhu1FwXKkCxpdEUpEVeWkoaXKmUpJAGak+vGX/+13ZmqIJOtQwZ2OfoL4AU5JJjWP8I837Wrj6vz/EKjupPfI4+hl6ON6ycl9uk+EP1Xt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grZ2h29+pNMEeD3NYoIZV0pqnIdp5O4ban4Jmv40nqI=;
 b=ZZgkRbOvXniX6xs4dA/8AQF+kknQsQ5SHDSot0p9Z/2oGqeFe+HAZp4dby3bgKaFdPN0j42RTmaT23VtMI03WXd8WxPIDZzffXfQx/t70Teps1jSUotxrJlI1XIaIGEiUFRFp8l8NCMBOEhIys8yX5e8DPuMrnxFTdYUV7lWpjg=
Received: from MN2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:208:15e::15)
 by SN6PR02MB5087.namprd02.prod.outlook.com (2603:10b6:805:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Tue, 4 Aug
 2020 06:44:51 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:15e:cafe::1f) by MN2PR17CA0002.outlook.office365.com
 (2603:10b6:208:15e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19 via Frontend
 Transport; Tue, 4 Aug 2020 06:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 06:44:50
 +0000
Received: from [149.199.38.66] (port=42207 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgp-00022V-60; Mon, 03 Aug 2020 23:44:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgs-0007mp-6h; Mon, 03 Aug 2020 23:44:50 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgl-0007l0-85; Mon, 03 Aug 2020 23:44:43 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v3 1/3] clk: zynqmp: Use firmware specific common clock flags
Date:   Mon,  3 Aug 2020 23:44:15 -0700
Message-Id: <1596523457-40465-2-git-send-email-amit.sunil.dhamne@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: 71a405e3-a4e9-425e-bea6-08d83841e324
X-MS-TrafficTypeDiagnostic: SN6PR02MB5087:
X-Microsoft-Antispam-PRVS: <SN6PR02MB508714C680963F3DC4050193A74A0@SN6PR02MB5087.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSBTwUzTYR8FiGVfc01+/IuTOTEmSFVngRrpdfWmJCMJAp2XJIVPtSlBNvJzl6jNXngsuKwKSn9QZznHu9y/AbNBV9NOo7xoD2BsT1jt1MSgtQIziUxuhk19Q59sjBbcrLPEEMwk/JUm3RVcehC3wZG0HyoIewmjmV7AvKsSnN/ed3P4ZZXbib2o+o9oRSYdu4VP4rAqusfbxs8SjHLDdos11JkKIiS5n0yhuZrm1pLy2OaX//pj1H3KdambC3dBbskU4vCO033oDEB/hHAGczcP9Rt8GZkn8/Dd+fgCz/SjW6UIIzNN8FnK7B1GhQZOuMuLKcRJeWSiS43v6RrJMj9LITc8HGnonpWFJzbtHKaRoioUe7rAvEKu/czfV7YDlvxPk/cQVONyNYHq0Ye5iw==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(39860400002)(346002)(46966005)(8676002)(70586007)(478600001)(6666004)(9786002)(36756003)(2906002)(8936002)(107886003)(70206006)(83380400001)(186003)(4326008)(26005)(336012)(47076004)(2616005)(426003)(5660300002)(82740400003)(316002)(54906003)(7696005)(81166007)(356005)(82310400002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 06:44:50.7701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a405e3-a4e9-425e-bea6-08d83841e324
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5087
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
 drivers/clk/zynqmp/clkc.c            | 32 +++++++++++++++++++++++++++++++-
 drivers/clk/zynqmp/divider.c         |  5 +++--
 drivers/clk/zynqmp/pll.c             |  4 +++-
 6 files changed, 67 insertions(+), 6 deletions(-)

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
index db8d0d7..d813c34 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -271,6 +271,33 @@ static int zynqmp_pm_clock_get_topology(u32 clock_id, =
u32 index,
        return ret;
 }

+unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag)
+{
+       unsigned long ccf_flag =3D 0;
+
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_GATE) ?
+                     CLK_SET_RATE_GATE : 0;
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_PARENT_GATE) ?
+                     CLK_SET_PARENT_GATE : 0;
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_PARENT) ?
+                     CLK_SET_RATE_PARENT : 0;
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_IGNORE_UNUSED) ?
+                     CLK_IGNORE_UNUSED : 0;
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_GET_RATE_NOCACHE) ?
+                     CLK_GET_RATE_NOCACHE : 0;
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_NO_REPARENT) ?
+                     CLK_SET_RATE_NO_REPARENT : 0;
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_GET_ACCURACY_NOCACHE) ?
+                     CLK_GET_ACCURACY_NOCACHE : 0;
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_RECALC_NEW_RATES) ?
+                     CLK_RECALC_NEW_RATES : 0;
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_SET_RATE_UNGATE) ?
+                     CLK_SET_RATE_UNGATE : 0;
+       ccf_flag |=3D (zynqmp_flag & ZYNQMP_CLK_IS_CRITICAL) ?
+                     CLK_IS_CRITICAL : 0;
+       return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_fixed_factor() - Register fixed factor with the
  *                                     clock framework
@@ -292,6 +319,7 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const c=
har *name, u32 clk_id,
        struct zynqmp_pm_query_data qdata =3D {0};
        u32 ret_payload[PAYLOAD_ARG_CNT];
        int ret;
+       unsigned long flag;

        qdata.qid =3D PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
        qdata.arg1 =3D clk_id;
@@ -303,9 +331,11 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const =
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
