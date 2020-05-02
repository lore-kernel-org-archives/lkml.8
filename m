Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A204C47259
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2212421835
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="M7dryyk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEBAZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:25:33 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:23085
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbgEBAZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:25:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7gSR5f8RfnSFCVDniIuzd9gq5XpfODMuMWBZ+KiYIgTZk8+PlA9femqJOK468iOHpPgjJYPIZX38w1NKz5tlasCBDOrc8YuUXQRf3pJo45qami7anHnbsYe3LJ1x23Nb1ER93mh92B9mwSE0SaZZ3xMI6XkLNrSRZAjGXUko6cMk5v6P0k+QC1aWMXABiemLJIaTiufgxEgOOnkAq7N3ZHiIzQ2J/4IaVsbogWJoVMx7J7I7mZUrjdfbE5pOV7zbgtyp4qMSHJ40QpuCQaSWi/Ol6iT7d9r7R9HnLYQeJBPrUEzAJXYcp1EvVj37pwwTm7NbFz/8gnJ7voGFjCyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PC7PliTX3bo/m9tPyJRBqcDTrRdVemB+XWNYr9hFhQ=;
 b=JkeUPqyqq9VrRT5YTegT+g73kiqFwz5OpmHIPGdXV/CWVzo1I15iGMbkZTK6rqwV/TebPoJYa3Xy1E5Svas3udcctVtAGjMDM6ONUSJGVRmzG95EUIu+e/iOSiwYf/WQHowApmDNzF/3uclsMLXJtD4zrGbVbFDg9o2+AVaUoDZ0FSgEC7HKbu4FQVgTJUpVcVzgMkDi1fLg8X8f9oX0jXi9yfmQRy7jbZd++Lw+XVY9FBL8n59ZiXpkxlUwNYkTk6BkI0Qvdutq27tVhSfGpCPk50KqKb+5laDSsscG6XOPo7y0d0qLdLS0/rP3SmnkWwRpDqJ2H+LaOmokMtHgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PC7PliTX3bo/m9tPyJRBqcDTrRdVemB+XWNYr9hFhQ=;
 b=M7dryyk50bezlJIfVK01vDsnv3zhvGSMKHuvt7LRifMP3FN4WaSFs95p9WPMu/C98VqV/2esJH4g67BSILVvuWqZjQYLIIJPTsMYKNLe4JDqJ6rqdvyb0Wjwt3nQH4TlZfv+ArnLgjFwH0wcqqMjjYF7MjeofCKUuKeEl7x8xyQ=
Received: from MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33)
 by CY4PR02MB2742.namprd02.prod.outlook.com (2603:10b6:903:11a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 2 May
 2020 00:25:26 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23e:cafe::13) by MN2PR14CA0028.outlook.office365.com
 (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_2,
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
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 00:25:26
 +0000
Received: from [149.199.38.66] (port=38225 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfy7-0006Qm-F6; Fri, 01 May 2020 17:25:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfy9-0004NS-Nx; Fri, 01 May 2020 17:25:25 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0420PI8g027419;
        Fri, 1 May 2020 17:25:18 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfy2-0004Mq-3y; Fri, 01 May 2020 17:25:18 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tejas Patel <tejas.patel@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 2/2] drivers: clk: zynqmp: Update fraction clock check from custom type flags
Date:   Fri,  1 May 2020 17:25:17 -0700
Message-Id: <1588379117-254190-3-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588379117-254190-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1588379117-254190-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966005)(186003)(7696005)(36756003)(8676002)(2906002)(336012)(2616005)(15650500001)(426003)(316002)(82740400003)(478600001)(47076004)(70206006)(107886003)(5660300002)(70586007)(82310400002)(356005)(81166007)(26005)(8936002)(54906003)(9786002)(4326008)(42866002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a072d374-5adc-4fe1-cbc7-08d7ee2f4f85
X-MS-TrafficTypeDiagnostic: CY4PR02MB2742:
X-Microsoft-Antispam-PRVS: <CY4PR02MB274218081A6C7BB5EAA5C46AA7A80@CY4PR02MB2742.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDob+WFtFz5yZmQrvlILNCTF886rY4jBADn3U5/FkyjiTN+QJpoBoRxntPsPKno+2SgmgYLfet77RWqyJPxGkmicAahhkSQ4C0UE+HvW5sYBTLlXHKExZqldAopHlrDVf7pObxIo4X00D29Rp9OyTc/+sr0ikZN+ojuFQM1Mx+WvKIJz7MFNzIT0Mcx1PTGDGa2EokfjbLPY+i43WuPfReyeVRJclkW2ndd2vDiq2NT9zdc/OxGPxEiEVW39Rc3v2o+duisU8/L/yHzNyxeZeUzLd5rUujGAflll4k0eg6rqRJ8DCl1jCK6MKU/mxQDYifbTXaNEa4OQrHGFcMw4R5wh8nhySU4gq5nVNHjotQ7MiQf5wqxvl/vfOeVdgs4XtwLYzSEf1TbL+LPCHX+vpseq/WO4KUHE2m/HVgdQk1lu/N79hNIAxscND6mHJmDogt3PJ9zE3wAiF+qfZa75ku0n3Ts0d98Gc2AxgHf615pbqlombVPGclk0AGE+QM3rojsK7U4ryw1hLt4QKfSuXWvu5bPN4gpGkDGZu4Q8wUs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 00:25:26.1036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a072d374-5adc-4fe1-cbc7-08d7ee2f4f85
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Older firmware version sets BIT(13) in clkflag to mark a
divider as fractional divider. Updated firmware version sets BIT(4)
in type flags to mark a divider as fractional divider since
BIT(13) is defined as CLK_DUTY_CYCLE_PARENT in the common clk
framework flags.

To support both old and new firmware version, consider BIT(13) from
clkflag and BIT(4) from type_flag to check if divider is fractional
or not.

To maintain compatibility BIT(13) of clkflag in firmware will not be
used in future for any purpose and will be marked as unused.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 4be2cc7..d43c9dd 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -25,7 +25,8 @@
 #define to_zynqmp_clk_divider(_hw)             \
        container_of(_hw, struct zynqmp_clk_divider, hw)

-#define CLK_FRAC       BIT(13) /* has a fractional parent */
+#define CLK_FRAC               BIT(13) /* has a fractional parent */
+#define CUSTOM_FLAG_CLK_FRAC   BIT(0) /* has a fractional parent in custom=
 type flag */

 /**
  * struct zynqmp_clk_divider - adjustable divider clock
@@ -311,7 +312,8 @@ struct clk_hw *zynqmp_clk_register_divider(const char *=
name,
        init.num_parents =3D 1;

        /* struct clk_divider assignments */
-       div->is_frac =3D !!(nodes->flag & CLK_FRAC);
+       div->is_frac =3D !!((nodes->flag & CLK_FRAC) |
+                         (nodes->custom_type_flag & CUSTOM_FLAG_CLK_FRAC))=
;
        div->flags =3D nodes->type_flag;
        div->hw.init =3D &init;
        div->clk_id =3D clk_id;
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
