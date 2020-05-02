Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF6BC47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3372184D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fWeXntUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgEBAZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:25:36 -0400
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:6260
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727113AbgEBAZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:25:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMnGop6OdwN4Y0DPc9SDhpV1VmNWR/BaCOMG7ngV8Iy1SQaQhiw4/qBZnQ6y3AjGrrpFK5ivEVkqGCH3VP5+A7JAyTjiunQ2OI6lWoUCfIh9tBYGWGFKoil6/oliYRG6xLFfbJJTPgmbDTyrlftSje8Lj7X6O6C/dYsxYCBHdOsnENG5qPKeReJo/9bktTGIdX4AOnFyGg0L/NOoVslfuO8KiMiN338N9bN3xsTljvcNbYlQPRYgujdDUTiKppfQ1kXj60e9CWLQnKnm4a2U9iInw2Fg0gcPZlM3kd8BonVTFdmIQJw2v3spI4F9+HcJXngxUEp4rcoBZJGbtZBzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ+0Yya6Zh3QNFdgQ32NxswT2FmGYZJlfGAnmOhYjC0=;
 b=Q4M/ZcEIsRvnFSHB8if8B2sJxT5cJGS4+yMAkHZqru8Y9I9RLQ9Jju+e5EHAlW7q/UKv2jSXz3ZFfAaDJdDdRD6YtQusdjjpmU7mhzHQ4uT86MNuCbjMxxeTLeL9evJosQSe9mjXAsf6yXj0GYRyRIc6HDrqtyt7MyB3I26AqPvXqhq33egYPtfgPKJIo+kSc5YWMKJrHXCNxWQWl9ESlJpnCE6DmPr/DfsGDybmuSYP5HQ16XXaJwN/Iyn1N9nwkmexnA/gB6kOSNFH8SVv68UzR43v1rEScJZwo+0w5ZEoLrDOOCUm+TFlRqIppVnPdT3YqY57n5sfXkSU5yurBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ+0Yya6Zh3QNFdgQ32NxswT2FmGYZJlfGAnmOhYjC0=;
 b=fWeXntUR9N1Ha3wE+oQz0xeZonAbolycOt8FfQHy6KOjoVTFEJvxNZ45BdNV5S2M2VKb+rCWqYLUkg3DKqXp5PDyoMdHQZ6QWrant0/0zG0CaXk8JqY3AQipg3UCVb+7ETcxzDqn4Lo+zCBUjg5PKbn23YMpvfDlJHjHEVOaObw=
Received: from MN2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:208:1b4::31)
 by SN6PR02MB4176.namprd02.prod.outlook.com (2603:10b6:805:2e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sat, 2 May
 2020 00:25:26 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1b4:cafe::1) by MN2PR15CA0018.outlook.office365.com
 (2603:10b6:208:1b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 00:25:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 00:25:26
 +0000
Received: from [149.199.38.66] (port=38220 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfy7-0006Qj-C1; Fri, 01 May 2020 17:25:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfy9-0004NS-Ka; Fri, 01 May 2020 17:25:25 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0420PI69027415;
        Fri, 1 May 2020 17:25:18 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfy2-0004Mq-2A; Fri, 01 May 2020 17:25:18 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 1/2] drivers: clk: zynqmp: Add support for custom type flags
Date:   Fri,  1 May 2020 17:25:16 -0700
Message-Id: <1588379117-254190-2-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588379117-254190-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1588379117-254190-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(9786002)(4326008)(107886003)(81166007)(316002)(7696005)(426003)(26005)(54906003)(336012)(2906002)(356005)(70586007)(82310400002)(70206006)(8676002)(47076004)(5660300002)(186003)(82740400003)(478600001)(36756003)(8936002)(2616005);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ad18674-00bd-4545-3687-08d7ee2f4f79
X-MS-TrafficTypeDiagnostic: SN6PR02MB4176:
X-Microsoft-Antispam-PRVS: <SN6PR02MB41768D6F0B8B5433BE547901A7A80@SN6PR02MB4176.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fj3XhqG1ClH9Sk9MaWHQ354FjwFpSxIiBaISvrR+XODVxk117JPLrDExfz4KtGw0z5wFhC3W1tPXHHO7ke41zMUN62BXMgX3BXA6sgbShogYXcPFn7FQ7QgtRy7Xdm81plLBdZddy3B5lWGEI1hJw63aJy1aJDbM93xijw+6y8qQbQl5DxnoIiJDg7Ou1yIFouQ08o5qnfVYE6+NAQUpHdg2qKWIMtMCG50uTb1AeGYAI8TDIXKSJ2bM2SVUizMVH0Tpt1WzZZw+g2ZzVuL08NQmLo704VnpupeeePQkE+GG4VM1PjaSQw507q3BEBbsoV0KKklXJJetUm/NpzCHxTkC3iR5GQ/K6M9hl2H0h9rNcZwmtUJzElRaX5CvjpgQT3vfTUUU33KXHLyFaMBdyxLePSJ/Egu6mBNSyY0uf6UQ0ZKw0ie+Mq9L7fYGPldtbAEWVD0obgUtuKTqpTIs0hE4CeebE3U8OtIx4L8BRxoUQt5JhqgIjQvOly0wV6jKU8aKZdxZuiRj6xuCXZrYgA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 00:25:26.0342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad18674-00bd-4545-3687-08d7ee2f4f79
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4176
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
