Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33CDC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8AC21D6C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a3QwWiSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgIIUpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:45:14 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:52270
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729992AbgIIUpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8aI0AeZyNTpLM71m85C71Q6EcboDOhBCdwIXtW6xncEATeZtNCEn0uCuiW3vzeT0gqNlsGK6cwxinSiORIVGP78S7opL+eWLs8uqTG3FIEZkZ25MJ4LzOdY84ghYJSieatQKdKWnUV4daHpjKTGchoYwdZMd3kCXPvS7yIS+3L4Yh0cZK9ScKQYylMlbxfPQHDoOBvElbP9xv6AkZydfIYex4G1eppVrP6S+iw4lBFRrghvt66Iw1Adn7AGrF+kKzkBA7jdrkYVin30/fPg6+IpUXcGXPp4MbLoNCGN+bcn2l5RXz/J7NdWfvoGlbPOvl0ntxY7rM1nCgOrym55OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+2KOMwY5wmlKbRnYeS1i3/CewJ6egRkFbSWXAdbvWg=;
 b=U+zqj5bxoshgimCswGQYCAWNxICdRUirpM0vg8KfN6V9NAl9lM5ZRSi4ZhOu0nJrJZZ5eO5yufyOVWbBaYvH/41PpPWwEGOU0AzvwR/kGIpWBp718pU8sM0+h21GvxPrzlsrTLiLjCx3DqYRrXbvC9zwFb3RwvbmneR/Ei2oiiLC4ALxLmXoI5hjP64568ZJNnoCQTFgAX7L3L/2gTrC+S2xJCOoKDyMdJEehCXZKOQ82Wy3fJ2VRYkPc1Cc3C69Ffx1ZkxD/+KBIo9sqQiKvRAaXf5rL79y6kVgsbkM67MCIpIHxGg0cUy4+y2No77u0y7lyv2n63ja7D2SkTqcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+2KOMwY5wmlKbRnYeS1i3/CewJ6egRkFbSWXAdbvWg=;
 b=a3QwWiSZZa0vVJUulOLVOux6o3cwJbXTDJ5pe70FzwFZ7DTGkPk72Kt1mKBOQCFP6qlc/lDc59NgAzePPKmFteeSMyjoSbUoYoOYjCdDFM/fO0T7Ls5AQeD5spXNjldiMru33S2urFdROcxwSIn1q/HjCg23hb5o9FJl9PbKPUA=
Received: from MN2PR19CA0065.namprd19.prod.outlook.com (2603:10b6:208:19b::42)
 by DM5PR02MB3670.namprd02.prod.outlook.com (2603:10b6:4:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 20:45:01 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:19b:cafe::fd) by MN2PR19CA0065.outlook.office365.com
 (2603:10b6:208:19b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 20:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 20:45:01
 +0000
Received: from [149.199.38.66] (port=53391 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xP-0001xX-Nj; Wed, 09 Sep 2020 13:44:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xf-0007dx-V5; Wed, 09 Sep 2020 13:45:00 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 089KisMZ028430;
        Wed, 9 Sep 2020 13:44:54 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xa-0007dJ-CQ; Wed, 09 Sep 2020 13:44:54 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v4 3/3] clk: zynqmp: Use firmware specific mux clock flags
Date:   Wed,  9 Sep 2020 13:44:48 -0700
Message-Id: <1599684288-20917-4-git-send-email-amit.sunil.dhamne@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1c991082-c092-4d43-0d78-08d8550138dd
X-MS-TrafficTypeDiagnostic: DM5PR02MB3670:
X-Microsoft-Antispam-PRVS: <DM5PR02MB36706EF3078831490D72F137A7260@DM5PR02MB3670.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l798Zs6l7FTqI6g07g8hyEuRm7n2nkpS0zLg6jDhix4vbInwWohVgj0GbkEHxoWAXHErL98Z3n8e8/Pz/TGgTNQE1CtspvLJYatvaCM3Y4NHvEkYdF2gMBV092uYIZQ49VxZ0bKTBeegXPGJQVmGwa/WjbOVDH87obgvFDXrPEK7pOvSjJua9wZkUSBpzdM8t1N8efacGkS1VSKjYDTiWgi4e4oin51IhClyjIHIKth9HIHx+NXxse7q7lGymzBj67XiVh/HZa6NmkzjJgyBZNvgJYrLl68EVPaCygQ/eGH22TuuumGYFFLq2QO60cVL0takyrDZNF9Il7LsDRYSpI9lFp5HwM2U7MFRExGQuwBw86OIr9+0+cqnsjbXBgObI7C5F22P459iBRZIW7L0O2q2JVBfHlae2RLEU0pUdj8=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(46966005)(5660300002)(8936002)(70206006)(70586007)(6666004)(356005)(2906002)(7696005)(336012)(107886003)(81166007)(82740400003)(36756003)(26005)(426003)(4326008)(47076004)(186003)(2616005)(54906003)(8676002)(83380400001)(316002)(478600001)(9786002)(82310400003)(42866002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 20:45:01.0164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c991082-c092-4d43-0d78-08d8550138dd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3670
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
 drivers/clk/zynqmp/clk-mux-zynqmp.c | 23 ++++++++++++++++++++++-
 drivers/clk/zynqmp/clk-zynqmp.h     |  8 ++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-m=
ux-zynqmp.c
index a49b1c5..4c28b4d 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -90,6 +90,27 @@ static const struct clk_ops zynqmp_clk_mux_ro_ops =3D {
        .get_parent =3D zynqmp_clk_mux_get_parent,
 };

+static inline unsigned long zynqmp_clk_map_mux_ccf_flags(
+                                      const u32 zynqmp_type_flag)
+{
+       unsigned long ccf_flag =3D 0;
+
+       if (zynqmp_type_flag & ZYNQMP_CLK_MUX_INDEX_ONE)
+               ccf_flag |=3D CLK_MUX_INDEX_ONE;
+       if (zynqmp_type_flag & ZYNQMP_CLK_MUX_INDEX_BIT)
+               ccf_flag |=3D CLK_MUX_INDEX_BIT;
+       if (zynqmp_type_flag & ZYNQMP_CLK_MUX_HIWORD_MASK)
+               ccf_flag |=3D CLK_MUX_HIWORD_MASK;
+       if (zynqmp_type_flag & ZYNQMP_CLK_MUX_READ_ONLY)
+               ccf_flag |=3D CLK_MUX_READ_ONLY;
+       if (zynqmp_type_flag & ZYNQMP_CLK_MUX_ROUND_CLOSEST)
+               ccf_flag |=3D CLK_MUX_ROUND_CLOSEST;
+       if (zynqmp_type_flag & ZYNQMP_CLK_MUX_BIG_ENDIAN)
+               ccf_flag |=3D CLK_MUX_BIG_ENDIAN;
+
+       return ccf_flag;
+}
+
 /**
  * zynqmp_clk_register_mux() - Register a mux table with the clock
  *                            framework
@@ -125,7 +146,7 @@ struct clk_hw *zynqmp_clk_register_mux(const char *name=
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
