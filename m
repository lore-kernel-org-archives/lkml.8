Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0112C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EFB20674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q86YZ1/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCLK14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:27:56 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:31459
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgCLK14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcDd2t09izFCcH9I67h1HgzboBE2oCHM72QuOhI96RpIO+3/8HdpAPuBchNelwDWvrHDRAjTzCASNC3B/7Cvf7QT+4FJTl+JPWJwR9+/5aGriEvqBpB7YOgd+L1B8pVZ68nQKKwx3fKCVx0mgB8pb6j0nRzXhlKyx4YwdaW/ghWOHKfubdSfYs53nSR/c4zVrjp78oybJVWP1/dIlN4gDY0dQogoPPmsVuxe+e4q44PCfxMLQkSvE8RrIOuvbzvAWEqZjUut37EN7flrJ0aXayXx6tsJdu0ht9EYku5Jwb0LzKPWEd6itmJDRSLUTJ1QTn842WYCo06HCotFdEzNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EljY0FWhHlEllJ6pMGD86Wxc13bUKI5lPzJCtzYU8G8=;
 b=byk3kcT8xxwN2hTsic9pmTlcaGsMwMmAd6jx++ZHc4DrJHOr6qi2bfIKx3+FdeA0bwHJKOfh1wgakierooqRkT4LFV4PEN2GoNzumL43S1M/JFAKq6QyQU7oGL89s4Ozj4UjyMcKhpncgceiHeg7SmAcweC85Clp9NfGtBSmRer5B45+Q1OFjM3vRPBEQPawBwcnoIQ79SbAadnNFTM5hGV1+s4p08LWbjYoZf6k8hJtKaL4aKZCPJvYHKCox0d2cVOxD43givR+7qonQMmm0ilrBEi0ounhjDMSvzY+/OomMUbvhS6v8ixlEp7RiSw61a3QLoE8A0m558NsQTOsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EljY0FWhHlEllJ6pMGD86Wxc13bUKI5lPzJCtzYU8G8=;
 b=q86YZ1/exHwgypyzgPz28f3xp2nBay/3eY6lbbVbL9RBlYq4rwrpJ+mhcIRsuwvplo53pH21bmfpG1l10Ech1TC3zY5fY72svCq3joI0s4kEuDtvnftEPpg76V/LGAWIY4Ef2U5sFBA318YYh2WKDBzDAmrcjp7a/I4g3LcPKk4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4195.eurprd04.prod.outlook.com (52.134.92.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 10:27:19 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 10:27:17 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        leonard.crestez@nxp.com, sboyd@kernel.org, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anson.Huang@nxp.com, daniel.baluta@nxp.com, aford173@gmail.com,
        ping.bai@nxp.com, jun.li@nxp.com, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com, agx@sigxcpu.org, angus@akkea.ca,
        heiko@sntech.de, fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Date:   Thu, 12 Mar 2020 18:19:41 +0800
Message-Id: <1584008384-11578-8-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0113.apcprd03.prod.outlook.com (2603:1096:4:91::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 10:27:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e6fa2aa-f208-4245-7a3a-08d7c66ff08c
X-MS-TrafficTypeDiagnostic: AM0PR04MB4195:|AM0PR04MB4195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB41950C2CA74470653812FC2988FD0@AM0PR04MB4195.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(956004)(26005)(6512007)(9686003)(2616005)(86362001)(8676002)(186003)(6506007)(81166006)(6666004)(8936002)(7416002)(6486002)(478600001)(52116002)(69590400007)(316002)(66946007)(66476007)(16526019)(5660300002)(66556008)(36756003)(81156014)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4195;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJH3ywXWElwcKMuYOPOiYElwmohfFCNiEKiuWYyYEM7zxYMsmiWTPKqxAf3wCD5bCNJRLUo4vicsbXF82d1uVQVaZ/0m/7uLfhoBAGfVbSLAcVXL8E2UjLdw7FBlrJChkfzMzHKtNmT4pLCPUZMeJ3Hp3u8duoSxBlXXtYbKZxTMCYFqD3v0CCtCwIC+UYKJF6FZ6vzdMplGDzYJKal1x6ILyBNR7oTk1X3+fwl7bho/FrpPMvBmxeLijtTvDKmP136jrm5Bf7HwivadwC1l8doqsgd6VJz0HEargDZWN4p7U80DnPxTV3N3DWosERJro77IYYGshb7ePEswfWIIj018AhDQxwaQYCg35aF+DduM+b1NdJbAreFvs3Jz1LccH9Z8XxY8UuSOoJx/itUYg67EFZXoDRus2gSeZCSuI9aDJ+sNIIlvVRHkXDxJhowd4tjUZjfK28M+jcrA/TT4CJc8euEU/tNpAORr1e7EZvH60lMdQ5A/yBpJgSNtsLr3
X-MS-Exchange-AntiSpam-MessageData: zi9ta0sO6kQkT7aOAmPf2PPw56d+UDcFMltGbOwxd95S54fpwN4vFRGOGoeg0x9g8jqaAuH7fbi9mncQCfadg2P1I0/4UOMdwHAF9SMtU73TeIWlp9XOPRrr3WRhB7lYjeC82PZMs6PS04ZbnYEK8A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6fa2aa-f208-4245-7a3a-08d7c66ff08c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:27:17.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7L0bcg45ke21QCeffyrCm8g0zIl5Ff/a4oiHqyNY/94HoPfyvY9tNdpVPxxFLeLZ/r2TWyBxHWbIJST3NCGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The CORE/BUS root slice has following design, simplied graph:
The difference is core not have pre_div block.
A composite core/bus clk has 8 inputs for mux to select, saying clk[0-7].

            SEL_A  GA
            +--+  +-+
            |  +->+ +------+
CLK[0-7]--->+  |  +-+      |
       |    |  |      +----v---+    +----+
       |    +--+      |pre_diva+---->    |  +---------+
       |              +--------+    |mux +--+post_div |
       |    +--+      |pre_divb+--->+    |  +---------+
       |    |  |      +----^---+    +----+
       +--->+  |  +-+      |
            |  +->+ +------+
            +--+  +-+
            SEL_B  GB

There will be system hang, when doing the following steps:
1. switch mux from clk0 to clk1
2. gate off clk0
3. swtich from clk1 to clk2, or gate off clk1

Step 3 triggers system hang.

If we skip step2, keep clk0 on, step 3 will not trigger system hang.
However we have CLK_OPS_PARENT_ENABLE flag, which will unprepare disable
the clk0 which will not be used.

To address this issue, we could use following simplied software flow:
After the first target register set
wait the target register set finished
set the target register set again
wait the target register set finished

The upper flow will make sure SEL_A and SEL_B both set the new mux,
but with only one path gate on.

And there will be no system hang anymore with step3.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Drop wait after write, add one line comment for write twice.

 drivers/clk/imx/clk-composite-8m.c | 62 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 99773519b5a5..eae02c151ced 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -24,6 +24,12 @@
 
 #define PCG_CGC_SHIFT		28
 
+#define PRE_REG_OFF		0x30
+#define PRE_MUXA_SHIFT		24
+#define PRE_MUXA_MASK		0x7
+#define PRE_MUXB_SHIFT		8
+#define PRE_MUXB_MASK		0x7
+
 static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
@@ -124,6 +130,57 @@ static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.set_rate = imx8m_clk_composite_divider_set_rate,
 };
 
+static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	u32 val;
+
+	val = readl(mux->reg) >> mux->shift;
+	val &= mux->mask;
+
+	return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
+}
+
+static int imx8m_clk_composite_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	u32 val = clk_mux_index_to_val(mux->table, mux->flags, index);
+	unsigned long flags = 0;
+	u32 reg;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+
+	reg = readl(mux->reg);
+	reg &= ~(mux->mask << mux->shift);
+	val = val << mux->shift;
+	reg |= val;
+	/* write twice to make sure SEL_A/B point the same mux */
+	writel(reg, mux->reg);
+	writel(reg, mux->reg);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+
+	return 0;
+}
+
+static int
+imx8m_clk_composite_mux_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+
+	return clk_mux_determine_rate_flags(hw, req, mux->flags);
+}
+
+
+const struct clk_ops imx8m_clk_composite_mux_ops = {
+	.get_parent = imx8m_clk_composite_mux_get_parent,
+	.set_parent = imx8m_clk_composite_mux_set_parent,
+	.determine_rate = imx8m_clk_composite_mux_determine_rate,
+};
+
 struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
@@ -136,6 +193,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 	struct clk_gate *gate = NULL;
 	struct clk_mux *mux = NULL;
 	const struct clk_ops *divider_ops;
+	const struct clk_ops *mux_ops;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -157,10 +215,12 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 		div->shift = PCG_DIV_SHIFT;
 		div->width = PCG_CORE_DIV_WIDTH;
 		divider_ops = &clk_divider_ops;
+		mux_ops = &imx8m_clk_composite_mux_ops;
 	} else {
 		div->shift = PCG_PREDIV_SHIFT;
 		div->width = PCG_PREDIV_WIDTH;
 		divider_ops = &imx8m_clk_composite_divider_ops;
+		mux_ops = &clk_mux_ops;
 	}
 
 	div->lock = &imx_ccm_lock;
@@ -176,7 +236,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 	gate->lock = &imx_ccm_lock;
 
 	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
-			mux_hw, &clk_mux_ops, div_hw,
+			mux_hw, mux_ops, div_hw,
 			divider_ops, gate_hw, &clk_gate_ops, flags);
 	if (IS_ERR(hw))
 		goto fail;
-- 
2.16.4

