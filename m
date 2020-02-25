Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2477DC35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED5924653
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HxeCbEeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgBYDXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:23:38 -0500
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:49061
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728011AbgBYDXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:23:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy30nSkpBXm6PhPwzs9jIkEyb6Tmt/J3qU6v8nkNhYjdwvPukWBa2MJyEkbMgSEJ2L32hsRvhjP4+jWTEWGI6vE09tzDWIfAzUHtcH5Go74Jm4fRgcAmgz/LgfCK3numGqgexiE/7UlTOCVdzBeiorp33FZYs5Ed2jcOdoLOGzPPn2WUxH5WEQ88iPJrUVHdZq3q9ndMjhv6AyThCzaJICR51HIciqq6lyHotoWLSq+UX6DiTSO5iyC44GPO2+g5m9LLpvhNOwyHuL0glh9bP9qaRIdrGAKV3UbHWeZm86wbRt6J1g1JWuQJdrvZX65M6luIf3rBcHDY3xjqUeS37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fJyU8zrMqOjpeQFbAy7mevrx8zFjHvNVX5MfodSa2Y=;
 b=TtOhHe5NXRb6897P8jojUFoPbAcAcV/FCqVAAcALFsp5GdHKmuhNMlzXfJzmwzJqd36g4aUBTZvnWEg/Np6FKN9OG2/lXELkpbuTb6V0pXIedyS8o+iJOPynOf84sIUqbd9TcyU9KTy729nH4qkW9wNfG4uvTgolhN6fFNCBRfQ5tOWAM+S4iQrg2/lD5SKY7yVOIuec+UrDXOqhYNcgyy19wYgNrJykhFQJg5vNv84omfZ4BtkF52uorSeX9IUl0L+lA3zExVvjQRhC2a59za4C1d1IzOVnktMi0iz2PFXUjTmhdFWzgkaBSHwUfG/12E8wzUvQxLRZjCfAX3gB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fJyU8zrMqOjpeQFbAy7mevrx8zFjHvNVX5MfodSa2Y=;
 b=HxeCbEeAfiBXUMCTE9B9/K+gqIGWV1gtp927h/HivhHESWEKQ0ISswC5D7pr1NRhG0MvZuaJH6cXjmUjnLARRLRGzM8UBR8yt8YjpHmyW+Sts4em/DyWkYpzSKKEqXGhA0XLp3V7Br1/rwjkTBoyk347Yz1Uqcq6bp6CgDE1/pI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5938.eurprd04.prod.outlook.com (20.178.112.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Tue, 25 Feb 2020 03:23:31 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 03:23:30 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] mailbox: imx: support SCU channel type
Date:   Tue, 25 Feb 2020 11:17:06 +0800
Message-Id: <1582600627-28415-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582600627-28415-1-git-send-email-peng.fan@nxp.com>
References: <1582600627-28415-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0089.apcprd04.prod.outlook.com
 (2603:1096:202:15::33) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0089.apcprd04.prod.outlook.com (2603:1096:202:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 03:23:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bbf50ae-d00e-458a-389b-08d7b9a21658
X-MS-TrafficTypeDiagnostic: AM0PR04MB5938:|AM0PR04MB5938:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5938A654659B20DF1A819E6988ED0@AM0PR04MB5938.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(6486002)(8676002)(81156014)(81166006)(316002)(15650500001)(66476007)(66556008)(52116002)(66946007)(5660300002)(8936002)(186003)(478600001)(9686003)(6512007)(36756003)(86362001)(6506007)(2616005)(6666004)(2906002)(956004)(4326008)(26005)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5938;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAVqp6hIVt5F0OgAcvvWui3qFgzrTtWKwIQYOpP14/YTGfYY1GWWwpljjZNGpwghHk2qDxbE+SmyYCb54i4dWaD85C+Wx+fzdtYyizf65Fj7VypQ6hG8MmTvs7b0IIrWroCqUnpLEp43ABw6wEaLS3KwvPfZkG7a9TxD0sbrWTmyOt0fEAQq8FZi3k54d7PEMUTKs40pUD2V4MEXAd9PHonavoMUwq8CrzTcu8eRT5UaPPK14QYznsxxWMdPLsN7fW2F10nM2MElpweWjjB9txLPKzCQLoonwNkeugcGp1ljPeaZlSv7OY0CqH9QThXHp1PCxm0uJtTWwXzBnX4yUETANUvnb7IFIueEbFuEOIVxGUb9tPvVhAWpBnLLwFl2cTTy0m6UevGGf1IsYIkkBP0Bx6/QfX0vL08jmTj8q0x8HStH8Elim3vpt27cBHzX
X-MS-Exchange-AntiSpam-MessageData: iT5NzbdOgzmd/q0UzGekSMlkemNb7UNPu+FAAso8Ktiy+fr1I4xaFopHMHjQo1ksArVQI0R9ZPExdpQitMYCnmI+ymQCWmRav4YRKK21c03booVwXueeysUcI78jgwl9jBoFMe6Cbnmz6ZuA68j2GQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbf50ae-d00e-458a-389b-08d7b9a21658
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 03:23:30.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYWj8a0Po92+wAI1JKyJ5WmGqZssnHHwg5IvbGWdbVkZ1TyxAbChVa8WPSDzQHVvxjctXKs0+qAomrQQV0e1eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5938
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per i.MX8QXP Reference mannual, Chapter "12.9.2.3.2 Messaging Examples",
 Passing short messages: Transmit register(s) can be used to pass
 short messages from one to four words in length. For example, when
 a four-word message is desired, only one of the registers needs to
 have its corresponding interrupt enable bit set at the receiver side;
 the message’s first three words are written to the registers whose
 interrupt is masked, and the fourth word is written to the other
 register (which triggers an interrupt at the receiver side).

i.MX8/8X SCU firmware IPC is an implementation of passing short
messages. But current imx-mailbox driver only support one word
message, i.MX8/8X linux side firmware has to request four TX
and four RX to support IPC to SCU firmware. This is low efficent
and more interrupts triggered compared with one TX and
one RX.

To make SCU channel type work,
  - parse the size of msg.
  - Only enable TR0/RR0 interrupt for transmit/receive message.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 46 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 2cdcdc5f1119..0b4a33254114 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/firmware/imx/ipc.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -65,8 +66,14 @@ struct imx_mu_priv {
 	int			irq;
 
 	bool			side_b;
+	bool			scu;
 };
 
+struct imx_sc_rpc_msg_max {
+	struct imx_sc_rpc_msg hdr;
+	u32 data[7];
+} __packed __aligned(4);;
+
 static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
 	.xTR	= {0x0, 0x4, 0x8, 0xc},
 	.xRR	= {0x10, 0x14, 0x18, 0x1c},
@@ -123,7 +130,10 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 	struct mbox_chan *chan = p;
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
+	struct imx_sc_rpc_msg_max msg;
+	u32 *p_msg = (u32 *)&msg;
 	u32 val, ctrl, dat;
+	int i;
 
 	ctrl = imx_mu_read(priv, priv->dcfg->xCR);
 	val = imx_mu_read(priv, priv->dcfg->xSR);
@@ -152,8 +162,19 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
 		mbox_chan_txdone(chan, 0);
 	} else if (val == IMX_MU_xSR_RFn(cp->idx)) {
-		dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
-		mbox_chan_received_data(chan, (void *)&dat);
+		if (!priv->scu) {
+			dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
+			mbox_chan_received_data(chan, (void *)&dat);
+		} else {
+			imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
+			*p_msg++ = imx_mu_read(priv, priv->dcfg->xRR[0]);
+			for (i = 1; i < msg.hdr.size; i++) {
+				*p_msg++ = imx_mu_read(priv,
+						       priv->dcfg->xRR[i % 4]);
+			}
+			imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);
+			mbox_chan_received_data(chan, (void *)&msg);
+		}
 	} else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
 		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), priv->dcfg->xSR);
 		mbox_chan_received_data(chan, NULL);
@@ -169,11 +190,20 @@ static int imx_mu_send_data(struct mbox_chan *chan, void *data)
 {
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
+	struct imx_sc_rpc_msg_max *msg = data;
 	u32 *arg = data;
+	int i;
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
-		imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
+		if (priv->scu) {
+			for (i = 0; i < msg->hdr.size; i++) {
+				imx_mu_write(priv, *arg++,
+					     priv->dcfg->xTR[i % 4]);
+			}
+		} else {
+			imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
+		}
 		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
 		break;
 	case IMX_MU_TYPE_TXDB:
@@ -259,6 +289,7 @@ static const struct mbox_chan_ops imx_mu_ops = {
 static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
 				       const struct of_phandle_args *sp)
 {
+	struct imx_mu_priv *priv = to_imx_mu_priv(mbox);
 	u32 type, idx, chan;
 
 	if (sp->args_count != 2) {
@@ -270,7 +301,9 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
 	idx = sp->args[1]; /* index */
 	chan = type * 4 + idx;
 
-	if (chan >= mbox->num_chans) {
+	/* For TX/RX SCU, only one channel supported */
+	if ((chan >= mbox->num_chans) ||
+	    (priv->scu && type < 1 && idx >= 1)) {
 		dev_err(mbox->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n", chan, type, idx);
 		return ERR_PTR(-EINVAL);
 	}
@@ -341,6 +374,11 @@ static int imx_mu_probe(struct platform_device *pdev)
 	}
 
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx-scu");
+	if (np) {
+		priv->scu = true;
+		of_node_put(np);
+	}
 
 	spin_lock_init(&priv->xcr_lock);
 
-- 
2.16.4

