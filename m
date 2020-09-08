Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A4FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A473421741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QGTi26q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgIHJVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:21:25 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:46734
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728556AbgIHJVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:21:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li4o5Tof4axTSqe4YWwxob7A4IWIFvrAnzn4ouMqdMP+KX0ya1uvSBq15itxSYYc6qpuICMROYSFI6NHVwiYSEwpuD30tqFGEiNWTFlhDC78AkgwpCz3Acpe6dc35Uxy3CBy47Vn52Xz/DDWt6swhn3Ml1LBtGQp8NM6L/u4gixRMFv3ntXlHV2QBB5fIh02k9+x6K0KeJOqRiUB1ksJwA1ZLZOtAs65QVRsAVVeL9CPpJBfI/jI5IAabmieFyaySu4JOvsUqaCBO0vowaj6YQ6d0JMpLbQ6JwOfiInHGNpnYXaE6FGP7bkpNnnkovtxhjA8CBTu+VVak7TIpS9g2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwC+CLnLZujvR+x644yqOwTf8zKz86MxU3oi5BhmBfg=;
 b=IkFN0BckljdauLp3P3APka5CBrhDOWZLxxL2MiQrYhd/ACkkqhjfxVkoG09hrGVWqYm6PwQUfNiaowca+hRH1/MKqMYjc37vaIelesSHL5WI27r2Rz4DPZkV8JFj7JbUthe2Agf31gelAu1tr7Xmr35tBkx8lbsVY/evy7ABensbMLP26LPBEEcHA6fCDuEYAWabdcd9bUwVBG5NJlLoFifK26WH8GgaTiPuvhrpxJnXmTPm5jGRvhomLxfGOPJghjBbrFB3VJsTWDvk0f9lhWw08qVrzYvwcL7HCOuLaQ367SJsZ5xFrnzSgSHbLZ4Kt82QIhcKyx5kjKqXPzOv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwC+CLnLZujvR+x644yqOwTf8zKz86MxU3oi5BhmBfg=;
 b=QGTi26q9CL6YLdxt2raigSb0sZ1/FTo0LCDqoUw2Iw8VrJxIM92KJkzwiMz+JqKUHryEtPnGhZOEMI+YQpnnSL9NuooCAFQKmQu6J0fLLgIJ3Q8hByMRy8S4MPo1tLDhPM1LSBBqQktzXyaF7erkKo46XGqQ0WZ2gbXGDbj3sw0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4937.eurprd04.prod.outlook.com (2603:10a6:10:18::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 09:21:16 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 09:21:16 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: lpcg-scu: SW workaround for errata (e10858)
Date:   Tue,  8 Sep 2020 17:14:47 +0800
Message-Id: <1599556487-31364-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.66) by SG2PR02CA0003.apcprd02.prod.outlook.com (2603:1096:3:17::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 09:21:12 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe998cae-0d69-49f9-a8ac-08d853d88967
X-MS-TrafficTypeDiagnostic: DB7PR04MB4937:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4937F4D53A56D1DBEB3C6AEC88290@DB7PR04MB4937.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGM7MJ5Fn8qh97WIYvIeId0dnNQH3O3ycA06OWblaO9Sk8Wy25t4PGVYnVXxxtk9POylBZ2KeWcldSUAQ9knP6AbJQaDzy1O7B+mfIjuoXGbEp/lA3gPqrWnaADjXxT3cDALcgb62qxPtXc1qLgomn0gZy0l9bqB/MA7hSyRRokAWAXGd/+yNKadcNXKjXXruP4UZlvhPcPbfmHOT6Md3eykSX7OaocR2N/OUGy8Y/hZOIzTOcI/iP6QzGokd6biyS0rZ/wtkfH+ajCFMcKr/rdoWrZhH+FCwcauzmIn4etXXrVNLaMK4W8KLaD/ZcxIE7cdPklP9FjUZlNuOt5lzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(956004)(52116002)(16526019)(4326008)(5660300002)(66946007)(2906002)(6486002)(16576012)(8936002)(36756003)(478600001)(26005)(6666004)(66476007)(86362001)(2616005)(186003)(9686003)(316002)(66556008)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: p7jEZWPUxybH5aOvBeLrIQD4rjLQ4qUAoazdRy81D7EGOiaLuDToFt90DTuit4eACs49nAvC9xGa7qBbaENVVtgKUZWX/VOBFKptGz02S26L4Kq4eKH4V2dQ01bUU1U7xCB4qMcntsn+i1gAKW5Qi1at5snOxAdl8hVseTUK8z+GICvDZlTKmfuJ+3QsAEyi6VVjnE4V/a0Ts3v3UNT1tgLeVYYcb3KHHo+8LRjWAmuGyX0NSDBui0uIM8XUilUNcCKr/8ltKR3P8OT54VCTzUGDZrpQTbAAL0ptYSxqOlcqWwG3vF9OgSGlhPxXTV89RHNYv+Xc5agK++qHl2QzrTHbrrjxmJC8mviFg07JDrlSYrcsFUYVlKlE762gKSA1eB0EssGsNAWf0Wl8U5MhapIxzYmnrO5xVAjHSx/BWHGFaPR0lYwwpXCziLqcitPrxFJOhGXcyt1teT3dESyrAQoOdxohw5y3qs3/YIK0boUC6YmPk5BeJU5hJFBYN9jv+Lk5FFKHFe46hAXPjlgSAkXkB6ce5j+ULG5SVM2Kp2sURjUThlhPvOVGLFZMsSmKgO6D6PN3oUuxTmSGeo5qjs7oh8PaboaoVxv3jiMDjJyn0gzLZ+veQeCUyISZCaL37pcSzWsRThOoU8pxNpvhbw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe998cae-0d69-49f9-a8ac-08d853d88967
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 09:21:15.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd+NMvzmdMmk1TR48p2GhGIsrGuyGK9yQWbskAq+W86OeaaaY4Z93tmT9EfRTmpwXWgustiJt2USu2Pm3T66Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Back-to-back LPCG writes can be ignored by the LPCG register due to
a HW bug. The writes need to be separated by at least 4 cycles of
the gated clock.

The workaround is implemented as follows:
1. For clocks running greater than or equal to 24MHz, a read
followed by the write will provide sufficient delay.
2. For clocks running below 24MHz, add a delay of 4 clock cylces
after the write to the LPCG register.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-lpcg-scu.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index 1f0e44f921ae..6ee9d2caedf2 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -6,6 +6,7 @@
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -38,6 +39,31 @@ struct clk_lpcg_scu {
 
 #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
 
+/* e10858 -LPCG clock gating register synchronization errata */
+static void do_lpcg_workaround(u32 rate, void __iomem *reg, u32 val)
+{
+	writel(val, reg);
+
+	if (rate >= 24000000 || rate == 0) {
+		u32 reg1;
+
+		/*
+		 * The time taken to access the LPCG registers from the AP core
+		 * through the interconnect is longer than the minimum delay
+		 * of 4 clock cycles required by the errata.
+		 * Adding a readl will provide sufficient delay to prevent
+		 * back-to-back writes.
+		 */
+		reg1 = readl(reg);
+	} else {
+		/*
+		 * For clocks running below 24MHz, wait a minimum of
+		 * 4 clock cycles.
+		 */
+		ndelay(4 * (DIV_ROUND_UP(1000000000, rate)));
+	}
+}
+
 static int clk_lpcg_scu_enable(struct clk_hw *hw)
 {
 	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
@@ -54,7 +80,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
 		val |= CLK_GATE_SCU_LPCG_HW_SEL;
 
 	reg |= val << clk->bit_idx;
-	writel(reg, clk->reg);
+
+	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 
@@ -71,7 +98,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
 
 	reg = readl_relaxed(clk->reg);
 	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
-	writel(reg, clk->reg);
+	do_lpcg_workaround(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 }
-- 
2.28.0

