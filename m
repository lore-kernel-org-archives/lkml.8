Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347B6C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7F2206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cSdsJ8iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgGVGzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:55:53 -0400
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:33952
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728049AbgGVGzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:55:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWpsXV6rvd5L5gsml8aGSMUzTIay51XtX+QJNpttfgIZg/u6Oh4rMI7/JrD96l8Abnnd4gti5vzSoru6w8xx/t1COnKYZUrIByw+L5ItJ4OZeze3csQ15fUGh4Wxqf5zsXZBdJpDPrghhA4MJ4y8kBa3iFGosx/6A9NZrJCFCKFabY2FtkwEF5Co1NmUGkt8PsgeJ1mId0d4YPpk+2H+fbebS2Kpk4Kh8s+h99QN2Pn4TzkSkueNxz6Dn/xTcEKA4BTGCbyquZatnNVvYM9uYoq+cCa6POLoz8VPBWGvhsuWfj1YbMpy9KwNsxNLECd0PTBTRR0jZN0dLdXlO5BvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGrJeUW5L2amVzh3hcIbNcJh2OPrCFtHka13VmFnbJY=;
 b=aRvxXEKVOn3hjSabY+dBYaIt1+Lhku6GAnGD7ZpE1ObK872gYvXsF5mEx9idvJ4t8aBayUj9MRBBUcdWgxJw5RsEr7j/Q5BwiZtUP9sDIhFcc05Jjn9jGX500tWP48aK3lnuDXic8oOo8JDPv8soOfMhw01u7XaGnp+p+v/KGabdc8JXLIUQzlcH1EcMr26Kodo2lPwW+Rt94+wD667hbsCi1m2n0AMueVI8dxz9V3AP8zh+yh831jGYxsvQlG1KgjqXT6L4gJb8SxaIcBh7sB3SpHFaof8XkM7X5sy14BglSJbTjpuW0ZtldNwJSWblKdcusasjAss4JiRoUSCSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGrJeUW5L2amVzh3hcIbNcJh2OPrCFtHka13VmFnbJY=;
 b=cSdsJ8iULL+0IIyOp6XLDIHMpFn8LpsSAwoWDrpeHacRoP6lS25ZKNOajEIsRZkpGNRUyo0TqwZD0MgjqYNReMEJOVMUotWoxf7bY+lNJzkiBjfe82DI4KLmUbz7bNgNeEHvfIBcUVjMsK2QyegLbdS6xCJQ8Jpn7FdgFvGCjHQ=
Received: from MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11) by
 DM6PR02MB6714.namprd02.prod.outlook.com (2603:10b6:5:214::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Wed, 22 Jul 2020 06:55:42 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23f:cafe::a) by MN2PR01CA0042.outlook.office365.com
 (2603:10b6:208:23f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Wed, 22 Jul 2020 06:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 06:55:41
 +0000
Received: from [149.199.38.66] (port=59649 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8dR-00024j-3n; Tue, 21 Jul 2020 23:53:49 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8fF-00037V-90; Tue, 21 Jul 2020 23:55:41 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06M6tZdj007795;
        Tue, 21 Jul 2020 23:55:35 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8f9-00036T-8C; Tue, 21 Jul 2020 23:55:35 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@codeaurora.org, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v2 3/3] clk: zynqmp: Use firmware specific mux clock flags
Date:   Tue, 21 Jul 2020 23:55:32 -0700
Message-Id: <1595400932-303612-4-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39850400004)(396003)(376002)(136003)(346002)(46966005)(8936002)(5660300002)(8676002)(9786002)(6666004)(426003)(356005)(316002)(70206006)(336012)(2616005)(83380400001)(54906003)(7696005)(47076004)(81166007)(2906002)(36756003)(4326008)(478600001)(70586007)(82740400003)(26005)(107886003)(186003)(82310400002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7be4bd13-ca13-4e44-a596-08d82e0c3fb7
X-MS-TrafficTypeDiagnostic: DM6PR02MB6714:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6714C47642D4E3252D8BEF6FA7790@DM6PR02MB6714.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnKkeypNtFqiuQm5SeBP1USzxIlOKrKH99Kad0WXSJyaF1EeF2R17LYcWI0Pt9+/BD/wfDe9bMEeFnOmlyjorH0jPi+Oy+GVHJ81iHWyg+nxpUE89KOVYRu+9TbODbSr/Z+09EIRPlrpehQFH2VWBgbkAKiMEaQ0dmSVoxfr8ins3CTGmX/1MKK66hU+k9KTwclH9GNlMuvw+Ql9/7uRW0B0B1lhnwjc0ag8Sg9OYvjNbrmdPKW3yE3lTSJ7woFcJ3Lu7daA2qJ8mqdds1AqrL/7eF1j6aE1N2tZ6ZGl5QMMsoox6D34fTWMmpilDLRCxYU0+1ASN03x5uTXHvTfkc/XtPqv78CqAY6OfsYUnpafXQ/+uyFVcYaPSJg1oHniKqTGQO6wBHT7ES0sH85hIA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 06:55:41.6290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be4bd13-ca13-4e44-a596-08d82e0c3fb7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6714
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
 drivers/clk/zynqmp/clk-mux-zynqmp.c | 14 +++++++++++++-
 drivers/clk/zynqmp/clk-zynqmp.h     |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-m=
ux-zynqmp.c
index 1dc17a0..10cf021 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -125,7 +125,19 @@ struct clk_hw *zynqmp_clk_register_mux(const char *nam=
e, u32 clk_id,

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
index ec33525..b1ac7e8 100644
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
