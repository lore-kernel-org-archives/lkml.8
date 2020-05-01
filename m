Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A276DC47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4AE20787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AT/wJl2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgEAXn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:43:56 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:46273
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbgEAXnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csxw6GaveqYkFlWmPFM+MDPEihDwRAb9YToWcH/qqgcwje1bZdGc0HdXM+bHj5o2TxgaWsjzxjGTXhiTio/c7BHmPjO+rhwprdH5gRW05/F3tachebjeU+6hCTzSvHDQxjlVejk6oZzwaoNC7IQ18GoYzUCyvmQARdLOnoPtSaxwX2/UwIYS8vOUxxOop2FO36nVjSKGMUblQM/wqupAm2Nk6tEJHNGlr+pRJx2xP9pPnMsnS0ASpXmkvVphAZ+n3MTy+GSMWaRna58ALle82x6UHoTJnjdZEBDyN+5cZcwj9GOd0PmtiX9ofsOAQ3uW17UE2atPXTB2ps7Icj6vuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ+0Yya6Zh3QNFdgQ32NxswT2FmGYZJlfGAnmOhYjC0=;
 b=Do5WMEXy2CD0m/OelG8XGt6qk7af5UbRB9Uss/ldcyMjVabNSWeofIfFR1hS7lbC0X/NAxcKx8obGgytJNBtmPi5AiYs6/FGeWc0pc5ZxV+qW9YecHmriCGV9LvK3tYEirgz1Nh73Ci83UqzXae3sL5POeKWr+qE7C4SRAq8famivoVJI7cz31V7nsHa5BiQlXNAcUj00ZA4zcoSISqF8/p22pA2KFqCMVyNSFM9cp07BoeytjaFotH7i9ZlDgvzf8gWW0a6jcDK4ZqqvzmyUFEh2zpF+jzw/vK8UnM/PV2wgec8Q1fwF2sOUlN+26hFV5Dq1w2JiQtifzfxXzvh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ+0Yya6Zh3QNFdgQ32NxswT2FmGYZJlfGAnmOhYjC0=;
 b=AT/wJl2fOPU67sa/7VjMPW6XWV9KpLXrQkNBOJAvWgv3eDNCBygyopsa8EdXzF+RfKC0GgpnUBXXovMSUbNh6iheAUS8NyjR2J+baJdWFy5mYE/MyECQD7x03oXWqRh2B8pG622X4IkuvxyFJv+mj0YuxMKXqIelLlzJY0JmCrw=
Received: from SN4PR0201CA0018.namprd02.prod.outlook.com
 (2603:10b6:803:2b::28) by MN2PR02MB6240.namprd02.prod.outlook.com
 (2603:10b6:208:1bd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 1 May
 2020 23:43:49 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2b:cafe::43) by SN4PR0201CA0018.outlook.office365.com
 (2603:10b6:803:2b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Fri, 1 May 2020 23:43:48 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Fri, 1 May 2020 23:43:48
 +0000
Received: from [149.199.38.66] (port=36404 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfJp-0005UU-Ot; Fri, 01 May 2020 16:43:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfJs-0001S2-0C; Fri, 01 May 2020 16:43:48 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfJn-0001RY-1q; Fri, 01 May 2020 16:43:43 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@codeaurora.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 1/2] drivers: clk: zynqmp: Add support for custom type flags
Date:   Fri,  1 May 2020 16:43:29 -0700
Message-Id: <1588376610-253693-2-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588376610-253693-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1588376610-253693-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966005)(9786002)(26005)(5660300002)(82310400002)(478600001)(4326008)(316002)(107886003)(186003)(2906002)(82740400003)(7696005)(6666004)(54906003)(356005)(47076004)(81166007)(36756003)(70206006)(70586007)(8936002)(2616005)(426003)(8676002)(63350400001)(336012);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e811cc73-72da-4c79-fb65-08d7ee297eb5
X-MS-TrafficTypeDiagnostic: MN2PR02MB6240:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6240219E3C1B9F594CAE01B8A7AB0@MN2PR02MB6240.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfSCZcJ/ovko00h4hSMSi2gouUvRjU0UJ9J9xr33GLtVTpWZv+X5qgzC9kQ/WfbG8eauuNWlf8MaB4GUenauTguzs5jK+11AfQ9R+udldAXIwluVBNERQBn7IsmhIrWUmA+cjPMSkkr3Z1pEJegAFxtPRvkjBGJUSzYWwVydGfpFoMCmsBwHn0hwFvkRFpJQoquux1rXBwqvxaEXqsyx0tpddGGiAcwJfkdX1DASVe6NKYwNlrBfDy8vpM9lQmmTAFe83cA45WpI5p+ZQpByBLe3iHgRR065bh5xOS6pUstc2Jvi5lAWCxKnY25mE8sVxn3MQ5M48F0HYg9x8aoA2c9jkRwjAmpEPHB+PdmnyJkIb2Mm4rxxYcMHOXBDJUQZ+Wey4I3Zu/hVWJ4jr7Juul1z5QkBbrn7DXkKiberyV5dRtmm+SRZH5L18MXc5FBOUp7wUm2q8cQQrkMGi7TGoqK31DNOJhBavBuNv0tchU6Bpo8Lb4kpDRqjItUee2vY8dpW4Nx317tsGHB/455fAw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:43:48.3049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e811cc73-72da-4c79-fb65-08d7ee297eb5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Store extra custom type flags received from firmware.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/clk-zynqmp.h | 1 +
 drivers/clk/zynqmp/clkc.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqm=
p.h
index fec9a15..5beeb41 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -30,6 +30,7 @@ struct clock_topology {
        u32 type;
        u32 flag;
        u32 type_flag;
+       u8 custom_type_flag;
 };

 struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index 10e89f2..4dd8413 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -84,6 +84,7 @@ struct name_resp {

 struct topology_resp {
 #define CLK_TOPOLOGY_TYPE              GENMASK(3, 0)
+#define CLK_TOPOLOGY_CUSTOM_TYPE_FLAGS GENMASK(7, 4)
 #define CLK_TOPOLOGY_FLAGS             GENMASK(23, 8)
 #define CLK_TOPOLOGY_TYPE_FLAGS                GENMASK(31, 24)
        u32 topology[CLK_GET_TOPOLOGY_RESP_WORDS];
@@ -396,6 +397,9 @@ static int __zynqmp_clock_get_topology(struct clock_top=
ology *topology,
                topology[*nnodes].type_flag =3D
                                FIELD_GET(CLK_TOPOLOGY_TYPE_FLAGS,
                                          response->topology[i]);
+               topology[*nnodes].custom_type_flag =3D
+                       FIELD_GET(CLK_TOPOLOGY_CUSTOM_TYPE_FLAGS,
+                                 response->topology[i]);
                (*nnodes)++;
        }

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
