Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53052C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2711120787
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Y/w7mHMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEBEhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:37:21 -0400
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:2218
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbgEBEhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkv6oHWcch+de6AT0OgGx/Kd3fegtFq7Sbjdl0Pfdb1rhSwxjcy88C1aBZn1lgnih9JeoxZ23AQiKrmRvWOmGqRbOmrAQXRlomceUZTCOyOFuy7hLPfOz5s9HuQiv6NICvCvySCKccOQRLNcNSH9vD6M4uqwPBYJUmHi34kVoGBWKSkzQl//V/h0smyKMadLHQ+JMRC0nrJ+DQtjzHRAW5suTlih2abhPE+5virib+GOwO23B1fYAi1UAu6U/1dhqiEWgTTypW7VDYvOiSh2TvuaaKzSndLs3NEi6pubtsWD1MHPRr0YK4boawf1hIoMdbMdvnBudhw3uWDnNtf7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFW+sZ97pk318n1f+mkbIXH+i8bPBM38JXpPDKlTtLo=;
 b=mpWwCCMrEe4ohbewUjQODpFWeCLIoX93JIvETFAVnN2UVQxW4uuIihhuonJtpAvln2L2gGlOXkuo2PVqZ1DuEycEKZrxCGP1pDJhGuRIMBEWrf8ivwWT0BCBk6VcGiVJ7xPr0L059JAAM6k3EWwbifrMiOqdliG7pfjc3ZNpUDtuwtfkHOG/JnDSll7CUf9MYTzF0X62eIGSXi2ZqXsl/AVpB01X+c8znje0z3h7KauduqtYJrg+H3WavRUWgmCPO0NretWCUDOd7yBTOUiCYYGwjGxNKfHHc980Kh3oPcATe+UevPKpwzPUTmhqH+SfQdRvY7hG5YlxYRteEPJnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=windriver.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFW+sZ97pk318n1f+mkbIXH+i8bPBM38JXpPDKlTtLo=;
 b=Y/w7mHMe9c0GlUpWUB83YNopiY9yWnwonP5j2/vEnqs3b94dxq3S5YsofIXP7meeipMTY5iw9Bpikb/Vl037X9Q2Hi+CEZ6mXNK3cXkUo5OZOPvaoD1Q9Y6n4CYuX6vJ1uDB6N7jBEIYpjbYieLcZjYJZDn16MdcNK8AiyPmg+c=
Received: from DM5PR04CA0041.namprd04.prod.outlook.com (2603:10b6:3:12b::27)
 by BYAPR02MB4278.namprd02.prod.outlook.com (2603:10b6:a03:55::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Sat, 2 May
 2020 04:37:15 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::7d) by DM5PR04CA0041.outlook.office365.com
 (2603:10b6:3:12b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 04:37:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 04:37:14
 +0000
Received: from [149.199.38.66] (port=34443 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjtn-0002fh-Ab; Fri, 01 May 2020 21:37:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjtp-0004eZ-Qu; Fri, 01 May 2020 21:37:13 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0424b5w6003806;
        Fri, 1 May 2020 21:37:05 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjth-0004de-CA; Fri, 01 May 2020 21:37:05 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 4/4] drivers: clk: zynqmp: fix memory leak in zynqmp_register_clocks
Date:   Fri,  1 May 2020 21:37:03 -0700
Message-Id: <1588394223-257635-5-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588394223-257635-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1588394223-257635-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966005)(356005)(186003)(7696005)(478600001)(4326008)(47076004)(8936002)(2906002)(8676002)(9786002)(36756003)(70586007)(70206006)(316002)(336012)(26005)(54906003)(426003)(2616005)(107886003)(82740400003)(5660300002)(82310400002)(81166007)(505234006);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c2b5b7f-ed94-48f0-01a2-08d7ee527c95
X-MS-TrafficTypeDiagnostic: BYAPR02MB4278:
X-Microsoft-Antispam-PRVS: <BYAPR02MB42789FE67DEDB3787E0F2B4CA7A80@BYAPR02MB4278.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbohDhpLvJWSByfP6tNuwIuZeLyHXYXE2mAzga8ITUBeb9Szhvhb/iy/CCy91k3evFXrt3sdMLXB2IxlXFAYsg+0oU7U9YEm6nUlKV0YlE/2YzHE0y6R/hmbcRsUOLiRpIUiyXvkceSyGxGHxa0AVLyAGfmeF4zfm5wgGmT+KhgGummX0DXkWJjmVTwCY+qjmPpzH4zzt3Wz68r6qzi9CDxxutaVC9160i2jdlIwUJRM3lMyC2Ypl/PiNcRG5nLlqsQngP1zP9He2P8d/5iF4OGw+VbgUWgQG4chRfziApGfixDuWaqS6pE3SBkCMRHxZ77pBiu1v0TdxxWYYvvhSiAOkX1YQEoA00nI99Rb9KerUbvwuoOxFOyrKa+GNFv8An6Pn+HCrq7Cx/2KlW0PEtgFPAk/TyAPX6ki/8H5mbxLmKLjGASMbHqCgclVd5XCVqLycNgWSHaHOrz8yufw5ENvOrO0VAiLZ9eGfLSl9i7qsI6XMz2Q3+wwp440Pb40IDWEGpwXsn+XorxUBpfZcvs2Ab+SughANlT8tq0dXoI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 04:37:14.0973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2b5b7f-ed94-48f0-01a2-08d7ee527c95
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

This is detected by kmemleak running on zcu102 board:

unreferenced object 0xffffffc877e48180 (size 128):
comm "swapper/0", pid 1, jiffies 4294892909 (age 315.436s)
hex dump (first 32 bytes):
64 70 5f 76 69 64 65 6f 5f 72 65 66 5f 64 69 76 dp_video_ref_div
31 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1...............
backtrace:
[<00000000c9be883b>] __kmalloc_track_caller+0x200/0x380
[<00000000f02c3809>] kvasprintf+0x7c/0x100
[<00000000e51dde4d>] kasprintf+0x60/0x80
[<0000000092298b05>] zynqmp_register_clocks+0x29c/0x398
[<00000000faaff182>] zynqmp_clock_probe+0x3cc/0x4c0
[<000000005f5986f0>] platform_drv_probe+0x58/0xa8
[<00000000d5810136>] really_probe+0xd8/0x2a8
[<00000000f5b671be>] driver_probe_device+0x5c/0x100
[<0000000038f91fcf>] __device_attach_driver+0x98/0xb8
[<000000008a3f2ac2>] bus_for_each_drv+0x74/0xd8
[<000000001cb2783d>] __device_attach+0xe0/0x140
[<00000000c268031b>] device_initial_probe+0x24/0x30
[<000000006998de4b>] bus_probe_device+0x9c/0xa8
[<00000000647ae6ff>] device_add+0x3c0/0x610
[<0000000071c14bb8>] of_device_add+0x40/0x50
[<000000004bb5d132>] of_platform_device_create_pdata+0xbc/0x138

This is because that when num_nodes is larger than 1, clk_out is
allocated using kasprintf for these nodes but only the last node's
clk_out is freed.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/clkc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index 3e83c51..e8b2cf2 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -558,7 +558,7 @@ static struct clk_hw *zynqmp_register_clk_topology(int =
clk_id, char *clk_name,
 {
        int j;
        u32 num_nodes, clk_dev_id;
-       char *clk_out =3D NULL;
+       char *clk_out[MAX_NODES];
        struct clock_topology *nodes;
        struct clk_hw *hw =3D NULL;

@@ -572,16 +572,16 @@ static struct clk_hw *zynqmp_register_clk_topology(in=
t clk_id, char *clk_name,
                 * Intermediate clock names are postfixed with type of cloc=
k.
                 */
                if (j !=3D (num_nodes - 1)) {
-                       clk_out =3D kasprintf(GFP_KERNEL, "%s%s", clk_name,
+                       clk_out[j] =3D kasprintf(GFP_KERNEL, "%s%s", clk_na=
me,
                                            clk_type_postfix[nodes[j].type]=
);
                } else {
-                       clk_out =3D kasprintf(GFP_KERNEL, "%s", clk_name);
+                       clk_out[j] =3D kasprintf(GFP_KERNEL, "%s", clk_name=
);
                }

                if (!clk_topology[nodes[j].type])
                        continue;

-               hw =3D (*clk_topology[nodes[j].type])(clk_out, clk_dev_id,
+               hw =3D (*clk_topology[nodes[j].type])(clk_out[j], clk_dev_i=
d,
                                                    parent_names,
                                                    num_parents,
                                                    &nodes[j]);
@@ -590,9 +590,12 @@ static struct clk_hw *zynqmp_register_clk_topology(int=
 clk_id, char *clk_name,
                                     __func__,  clk_dev_id, clk_name,
                                     PTR_ERR(hw));

-               parent_names[0] =3D clk_out;
+               parent_names[0] =3D clk_out[j];
        }
-       kfree(clk_out);
+
+       for (j =3D 0; j < num_nodes; j++)
+               kfree(clk_out[j]);
+
        return hw;
 }

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
