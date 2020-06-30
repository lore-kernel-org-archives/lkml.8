Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEF4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6AE206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WpX0/lZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgF3AaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:30:24 -0400
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:28351
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbgF3AaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLgrorKw+fI8lkJIARp7z0Ip7ruBg0k9CuV8RcCCMVqEdLYKsHpbEJf8YckfvtwbA20uwjyQiKWng32oo1C8JM5MyW+gcjvk9+IK9nA+RCAwZjLxe8kAg/OESs93+8OVOMSVRGeKCDaJzskKTsFLPWz+hEkh5Yrw+w5NZw2OPF9uctpg/mvIygbBPI8D1nmX5nwmDr8RmNeyAlcAn4yiRPJXtvvFqBBx+jS2fJeZcaKRjIbLFiMgHx75obyWNAMdPdY9v1YUFKaMtUDfymRiPJHdKoLL3v0ikdK9yi8U3JmwR+hTvc0ux4h7wMR0Rso3jlXC2XX8ZWTHAYZmQKBk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq97uSY24/s3n9GLi1syZaj2AvxWx0VoENMXQlmug6c=;
 b=J/Hr1U1/xPupkG/NPf7paTZ7aU4SqJ+FpHJhC8ko0+fFTXNemg4UlNHu/NYbBZf/ZiMIFMO9keL1Y2FF3YRVjYrXzdeevLCTQZerm+ipEs1KwpNO9/VFZOc5YRRY3CGliJVwIZZ/Gmcz4ceaP4AfdfAYr/IC3hfeBzbgCAmsfd5M3IlcCpG/+qf8a88QfvtgHkpvE1NtnLNTuCADTfpu2OlrTc0KophuqBhFSbG1DWpC1QjGT5pmuZICC3hoZmy7+GDJ2qpdcnhP3mQMI1qtLBeV0dSQvTZo3pcyV/pp/nPUjmFRMBTzm7IYNfqrW2+FkS7iBBaP1J1M78IjM0/ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq97uSY24/s3n9GLi1syZaj2AvxWx0VoENMXQlmug6c=;
 b=WpX0/lZKoaHtU99e32+/X4SAmma0OWD+kGUzYNYk6AZnzzbTlNERZW8OvdM5t1UpUyYnSeojICZawZqo40Qh87rqBqco0MLmtmawr2L8l90aat4hMZXOFCWBGPTJHL4sSTdZ9xKzq4f/NTwnCMYx6dzeyX368ZpS9EpPbajSGa4=
Received: from DM6PR17CA0010.namprd17.prod.outlook.com (2603:10b6:5:1b3::23)
 by BL0PR02MB4548.namprd02.prod.outlook.com (2603:10b6:208:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 00:30:19 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::20) by DM6PR17CA0010.outlook.office365.com
 (2603:10b6:5:1b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Tue, 30 Jun 2020 00:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 00:30:18
 +0000
Received: from [149.199.38.66] (port=58378 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq48u-00054F-Vc; Mon, 29 Jun 2020 17:28:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq4AE-0005bY-BZ; Mon, 29 Jun 2020 17:30:18 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jq4AC-0005YJ-5q; Mon, 29 Jun 2020 17:30:16 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@codeaurora.org, sboyd@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH 1/3] clk: zynqmp: Use firmware specific common clock flags
Date:   Mon, 29 Jun 2020 17:30:12 -0700
Message-Id: <1593477014-18443-2-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593477014-18443-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1593477014-18443-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39860400002)(396003)(46966005)(82740400003)(26005)(47076004)(54906003)(107886003)(4326008)(8936002)(336012)(478600001)(5660300002)(186003)(36756003)(9786002)(70586007)(7696005)(82310400002)(2616005)(70206006)(426003)(6666004)(83380400001)(316002)(8676002)(81166007)(2906002)(356005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 59ca9531-1f97-4b4e-16eb-08d81c8cc44b
X-MS-TrafficTypeDiagnostic: BL0PR02MB4548:
X-Microsoft-Antispam-PRVS: <BL0PR02MB45489FE63FD6A84A8DD3B706A76F0@BL0PR02MB4548.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DkHlMf8802nPnvTxSuE86zb5Ob5rXthdv+105A/bjMS1d6BEPOZe9I7Huhv5ZbR4jr9xHaOHBvUbPNArhmbYRA95IdylY+YYUUpXf8wz2iMXxOnOrsoy9WkQfnPEkgL6zHcLCeahp6IsJ4jKpMZCNGesIggn3C8XsKQEUyZ2z7pOudCCJj7Qa8PWyKjdq026oKKvnti+0aUS9ASObgG3ZZRrlTTTlLbhcH8gP9yDLEQkM/JK8XMFopWI9pqwBcSyzznQdgkw0ptB2VLxeD5HDdBdFe9WxBAHilh8Q2VR3CMmIbYXjIwR6QQj5r9IRQS/U3ZlJkAJpPgRZB3v1onGRe/m9vWkcJOp1cSmW+K0RcdKA2kHP09pJOQ2mN/L3n8AbLeYM8Ujf3T+jfwPeXjpA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 00:30:18.6899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ca9531-1f97-4b4e-16eb-08d81c8cc44b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4548
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
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/clk-zynqmp.h | 22 ++++++++++++++++++++++
 drivers/clk/zynqmp/clkc.c       | 25 +++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index 5beeb41..d8e580b 100644
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
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index db8d0d7..8663587 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -385,14 +385,35 @@ static int __zynqmp_clock_get_topology(struct clock_t=
opology *topology,
 {
        int i;
        u32 type;
+       u32 flag;

        for (i =3D 0; i < ARRAY_SIZE(response->topology); i++) {
                type =3D FIELD_GET(CLK_TOPOLOGY_TYPE, response->topology[i]=
);
                if (type =3D=3D TYPE_INVALID)
                        return END_OF_TOPOLOGY_NODE;
                topology[*nnodes].type =3D type;
-               topology[*nnodes].flag =3D FIELD_GET(CLK_TOPOLOGY_FLAGS,
-                                                  response->topology[i]);
+               flag =3D FIELD_GET(CLK_TOPOLOGY_FLAGS, response->topology[i=
]);
+               topology[*nnodes].flag =3D 0;
+               topology[*nnodes].flag |=3D (flag & ZYNQMP_CLK_SET_RATE_GAT=
E) ?
+                                          CLK_SET_RATE_GATE : 0;
+               topology[*nnodes].flag |=3D (flag & ZYNQMP_CLK_SET_RATE_PAR=
ENT) ?
+                                          CLK_SET_RATE_PARENT : 0;
+               topology[*nnodes].flag |=3D (flag & ZYNQMP_CLK_IGNORE_UNUSE=
D) ?
+                                          CLK_IGNORE_UNUSED : 0;
+               topology[*nnodes].flag |=3D (flag & ZYNQMP_CLK_GET_RATE_NOC=
ACHE) ?
+                                          CLK_GET_RATE_NOCACHE : 0;
+               topology[*nnodes].flag |=3D (flag &
+                                          ZYNQMP_CLK_SET_RATE_NO_REPARENT)=
 ?
+                                          CLK_SET_RATE_NO_REPARENT : 0;
+               topology[*nnodes].flag |=3D (flag &
+                                          ZYNQMP_CLK_GET_ACCURACY_NOCACHE)=
 ?
+                                          CLK_GET_ACCURACY_NOCACHE : 0;
+               topology[*nnodes].flag |=3D (flag & ZYNQMP_CLK_RECALC_NEW_R=
ATES) ?
+                                          CLK_RECALC_NEW_RATES : 0;
+               topology[*nnodes].flag |=3D (flag & ZYNQMP_CLK_SET_RATE_UNG=
ATE) ?
+                                          CLK_SET_RATE_UNGATE : 0;
+               topology[*nnodes].flag |=3D (flag & ZYNQMP_CLK_IS_CRITICAL)=
 ?
+                                          CLK_IS_CRITICAL : 0;
                topology[*nnodes].type_flag =3D
                                FIELD_GET(CLK_TOPOLOGY_TYPE_FLAGS,
                                          response->topology[i]);
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
