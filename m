Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAE6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6073920787
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JNbEwey/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgEBEhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:37:25 -0400
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com ([40.107.236.69]:20001
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727849AbgEBEhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:37:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es4sb/7OtxH3inq8y9bAezto4W/cSs2H4vh8pCcUCXUsJtRzstFVIKZwD3DsVfohFoxwaXsTE612e1KFIOF0Un0MGGtAJk9/9F/qtdwF5eJ2dXfgPJI64mjSWTCsXemMWTuu2Dl8PpFzcCQvtKNxzFlupoTK9UCfa8t2JNJPld5dSWFCizQ5NnOjCwjyVzR6ueSTMumISGDN1YelYMx0x7AZXA22JRodI/ai55Kt/BvhovS9ecr/DkeaFvfivR9adTiHwB2yXafBpPzaM/Pz82Lc+XY0DS8Ld8D+/7i40EFV/2rQ5+ttQmIyE2KweX1c3WR7EM2x0IV2hFe8XF9Dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCr9dneKr8K0zpMeL2RfEvUHMH4ZBnuGYw9BtKB3dNo=;
 b=TbbJiRv7/NJe6g8U1wxAcjsh17v3DUaaLa0AKcnQc+IFbsFmPSKOETzek4Nm/koVI+QuGH1ysMMVgcEiuIme8DE1sTxcJ8iSbltyTA2vadPIVIlFHfo5hvShV8yKqo2n1D5IdCVeIpCEQ7WRMI76GjqL3aV6/Vx7+7e8V0DZNtHyStwrv1n+CyMOsGXSFiGAuuWd5iUWZDHe2+EbOGwywdzqyZY3JZZu77vqM72cKshAmFzKg0Bn4uu20M/yLcTXe/NEHaAqrtjdwnGcQbpbH3KWuNmxNhP5xvvkUoByH9gTNCzleCqTHwvfCfl5Q65hEU2Wnj4p2Q7ncpRyq52pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCr9dneKr8K0zpMeL2RfEvUHMH4ZBnuGYw9BtKB3dNo=;
 b=JNbEwey/J4+wgoxheCo8xwpOzqUFR5r8g0bxDZIgJkwZvRPcLdhG5WbyPlgm8DfMpq53Hp9gh5fZZXGNTA7OMu7qqgJhfAJ/c96ND6hrorcswAdA8307w8S9aYeFnjJW5OPFFh/MqQnKh3AJnVZN9adn/dhrbVjx8r33U0GAbRA=
Received: from DM6PR06CA0026.namprd06.prod.outlook.com (2603:10b6:5:120::39)
 by BL0PR02MB4851.namprd02.prod.outlook.com (2603:10b6:208:5b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 04:37:14 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::b8) by DM6PR06CA0026.outlook.office365.com
 (2603:10b6:5:120::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 04:37:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 04:37:13
 +0000
Received: from [149.199.38.66] (port=34433 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjtn-0002fe-61; Fri, 01 May 2020 21:37:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjtp-0004eZ-MS; Fri, 01 May 2020 21:37:13 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0424b5cx002108;
        Fri, 1 May 2020 21:37:05 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjth-0004de-8R; Fri, 01 May 2020 21:37:05 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 2/4] drivers: clk: zynqmp: Fix divider2 calculation
Date:   Fri,  1 May 2020 21:37:01 -0700
Message-Id: <1588394223-257635-3-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588394223-257635-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1588394223-257635-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(54906003)(82310400002)(316002)(356005)(9786002)(478600001)(81166007)(426003)(70206006)(336012)(70586007)(82740400003)(47076004)(7696005)(2906002)(36756003)(6666004)(4326008)(2616005)(8936002)(186003)(26005)(5660300002)(107886003)(8676002)(42866002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd6d44c-de79-47cc-c50a-08d7ee527c84
X-MS-TrafficTypeDiagnostic: BL0PR02MB4851:
X-Microsoft-Antispam-PRVS: <BL0PR02MB48519D7BC381FEE9EF7285BDA7A80@BL0PR02MB4851.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4MtmYydD23J4tuT4C2IE+WteW5bGGqChUpYFQlGc4engh8AqVPEm6T0v56kyzTun4J7oerbQzHdgvTKk7nx2eagmb2b/offG5Ps1vFr5V4OFiygnE6xO3U0/r73xCELQint9iiNaoh6rwHS3nRJr6pKy5jwmIWcY0idQzv9Vzn14M2a7ymDiZ9ggNWmS8shhmRk4mWAXoBrWDfhBaRSHIAT5wP+osjniTZKLH2itMDyPR6F6AmIHHhig8Sqs9rHmyV2hClBikUDdJUKLla5J+BlChQIZ+utiXc66+js6eydVgLDe6E8CdXq4iXtPmXUSyLdCJ47k+ZHHRhvAxSTPZuw4qSmix7id56vVUKQBU6kHxA1sFCmpdrUUxK7xdmq5gvPf7oEjgkqbM50jpM9CxzGmsvWbMl0/PfgRi/xWQMlfMQH+5oNZy3SWaNn5l/uy2aLcjJaxcBk8o68XhtKUJIwuZjL7nm3CrJSUCqPaBQyOGkuZZz6ba6fU2VMhbrIES6p2DVJJ5GRH9tjC3dsGfCZx3mGh9V0fF/nQ0MO0wQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 04:37:13.9744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd6d44c-de79-47cc-c50a-08d7ee527c84
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

zynqmp_get_divider2_val() calculates, divider value of type DIV2 clock,
considering best possible combination of DIV1 and DIV2.

To find best possible values of DIV1 and DIV2, DIV1's parent rate
should be consider and not DIV2's parent rate since it would rate of
div1 clock. Consider a below topology,

        out_clk->div2_clk->div1_clk->fixed_parent

where out_clk =3D (fixed_parent/div1_clk) / div2_clk, so parent clock
of div1_clk (i.e. out_clk) should be divided by div1_clk and div2_clk.

Existing code divides parent rate of div2_clk's clock instead of
div1_clk's parent rate, which is wrong.

Fix the same by considering div1's parent clock rate.

Fixes: 4ebd92d2e228 ("clk: zynqmp: Fix divider calculation")
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 5c41ddb..f7b3545 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -111,23 +111,30 @@ static unsigned long zynqmp_clk_divider_recalc_rate(s=
truct clk_hw *hw,

 static void zynqmp_get_divider2_val(struct clk_hw *hw,
                                    unsigned long rate,
-                                   unsigned long parent_rate,
                                    struct zynqmp_clk_divider *divider,
                                    int *bestdiv)
 {
        int div1;
        int div2;
        long error =3D LONG_MAX;
-       struct clk_hw *parent_hw =3D clk_hw_get_parent(hw);
-       struct zynqmp_clk_divider *pdivider =3D to_zynqmp_clk_divider(paren=
t_hw);
+       unsigned long div1_prate;
+       struct clk_hw *div1_parent_hw;
+       struct clk_hw *div2_parent_hw =3D clk_hw_get_parent(hw);
+       struct zynqmp_clk_divider *pdivider =3D
+                               to_zynqmp_clk_divider(div2_parent_hw);

        if (!pdivider)
                return;

+       div1_parent_hw =3D clk_hw_get_parent(div2_parent_hw);
+       if (!div1_parent_hw)
+               return;
+
+       div1_prate =3D clk_hw_get_rate(div1_parent_hw);
        *bestdiv =3D 1;
        for (div1 =3D 1; div1 <=3D pdivider->max_div;) {
                for (div2 =3D 1; div2 <=3D divider->max_div;) {
-                       long new_error =3D ((parent_rate / div1) / div2) - =
rate;
+                       long new_error =3D ((div1_prate / div1) / div2) - r=
ate;

                        if (abs(new_error) < abs(error)) {
                                *bestdiv =3D div2;
@@ -192,7 +199,7 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw=
 *hw,
         */
        if (div_type =3D=3D TYPE_DIV2 &&
            (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
-               zynqmp_get_divider2_val(hw, rate, *prate, divider, &bestdiv=
);
+               zynqmp_get_divider2_val(hw, rate, divider, &bestdiv);
        }

        if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_fra=
c)
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
