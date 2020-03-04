Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1613C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABADD21739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YucU2i/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgCDF4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:56:16 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:5792
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbgCDF4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:56:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1dvHuYg6sCQgjvEJoJq0G2tvzWs52aKVfzVGOF8VyDl/jSHof/EqZ+jYAy/TeW0mjgKFj91SSRYhglEr2S4IP3PpUxXjsYJC/Iki7RbVjUn/bNEsdRsvINL6ZRVymKBlrFyeK7Yf4inEzyJWKCpH7I3+TwIjpZOe0fViFaGU5XyfejOFz+YKhpePom+utUXvrHSSsgEsclm7oqvdscbJkJrgQtfmwXJ80eyWsfDtd8PF85VX65ceYKuXUV5yqDIdcGRdTyN7XySXLuCVOWxr9m9/pIuWaJlj3Qe1R3oC42M9VL8AVsTqeOBlxeXK472fy03aF7cIBhoEbhTK2kRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVJ+o0DDdIR8cs2sO5pisK+82naQ1GUXow/ghLdblbI=;
 b=NTVoZzQVJ0lZYvmvGkfLiLrJA8t09IKYiWietOT0iQF2F36Rfyvf0BTNxGnyyh3csCk6VfsgOjogGMGcNBwig4s1ZLRmOh2koUpMNNs+3Kb09t2dhdOdwOGsaRecQDLwUvjC2f0Xh4pXGEaZX1V/r0GYU5vHO9nwUVMo2Go8MH8g0Zmwh1OobrEBrk9lfCiYX2X7LOhUQgWaIng+TpwLjhHK4vlGwmIusUs3ddlkB28xi8dRKCskmY9zLu1RZoUs3yJVmoiYRPoNKhCevu1u1gwoUUn89KQO7n6PBYuF2M7kpj3unn5zxcM6ZwxYBFIJEgmdRCzZ1F+HvrQebR92dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVJ+o0DDdIR8cs2sO5pisK+82naQ1GUXow/ghLdblbI=;
 b=YucU2i/TptxfXW0labh96eGedTYl+1iuyI6oZnbGYhDLStj4DEQSYclVn7l2rA095zG559ex75FNk1wbHkrgD3kz4PF64H3p7fTyXNm4g+1MR7dOd4Yijah4V8oDpaPlnBc1RQcOMXbypuiBb9qIAio0+2gh0ees9QwZhZdjKHE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4947.eurprd04.prod.outlook.com (20.177.40.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Wed, 4 Mar 2020 05:56:08 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 05:56:08 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 3/4] mailbox: imx: add SCU MU support
Date:   Wed,  4 Mar 2020 13:49:36 +0800
Message-Id: <1583300977-2327-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
References: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:3:1::20) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:3:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 05:56:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b14e196-e09f-4fa0-fb88-08d7c000baf8
X-MS-TrafficTypeDiagnostic: AM0PR04MB4947:|AM0PR04MB4947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB494721007866EB40E30032AA88E50@AM0PR04MB4947.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(189003)(199004)(52116002)(66556008)(66476007)(316002)(478600001)(66946007)(2906002)(81166006)(8676002)(6506007)(956004)(2616005)(81156014)(4326008)(6512007)(9686003)(6486002)(5660300002)(26005)(36756003)(15650500001)(16526019)(6666004)(8936002)(186003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4947;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQblMPl/+gjZ6VjnbOfZR2mQs23rxB2eNyD6IumybVyjc8SnqTcCAi98W8+cuT6PM7pOitXZfoZJGI5lpvwdX3DzzthPMZSR05ILMNoOgw2pqHFBpjQZ2qhD2rfafnXWvQndP4Osv2Pt4AGffIlcDIPm/x5HnsruZgLBYuFz0f7LpDjO2kINzgFrUY7OfARa6+e+W/7EEEvg1YudOHMscsSVf/yzvjeZfpqxrKmwARaI/egw5FTNomZg7+b2tbPijQivwvEuR99wyeiCWYMxUGp2OMNYHEvsT7d+C875/LZods0nTem15E90pSFL4AKm9k3IA7zPodAdWap90a78QwztHldXPM36bNCO2zDY2VbMUZiqEvTa2lCbUZ3iH4bzCnmE6+0+OCwgkhejRidiRjqHt+qD82EvjgmYU2LT+9UEbjxjsq+rr0SkQESao0TG
X-MS-Exchange-AntiSpam-MessageData: Q+2kc2JhhZCGuVusILQrLFUcM2ewMUCntHjvERTTrT0WsCbZiwDMR22yb46nWSa1hmAnTNOEeCc3MUgyCW0iQvKr2TSjPWIB0+oo/dA0BNpiWqNHksa1smyO3saPftYXoB1FvmCFgCgO7DL3mVlOpQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b14e196-e09f-4fa0-fb88-08d7c000baf8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 05:56:07.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3CYbacTHAMHvd+C4OyLM4NrFfiFkrPHUGXhiA10Y3fA41fl7YBK3Hz3DcHHbL2g46WEwqgkhGS5lGazWmRarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8/8X SCU MU is dedicated for communication between SCU and Cortex-A
cores from hardware design, and could not be reused for other purpose.

Per i.MX8/8X Reference mannual, Chapter "12.9.2.3.2 Messaging Examples",
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

To make SCU MU work,
  - parse the size of msg.
  - Only enable TR0/RR0 interrupt for transmit/receive message.
  - For TX/RX, only support one TX channel and one RX channel
  - For RX, support receive msg larger than 4 u32 words.
  - Support 6 channels, TX0/RX0/RXDB[0-3], not support TXDB.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V6:
 Add R-b tag
 Use %zu for printk sizeof

V5:
 Code style cleanup
 Add more debug msg
 Drop __packed aligned
 idx santity check in scu xlate

V4:
 Added separate chans init and xlate function for SCU MU
 Limit chans to TX0/RX0/RXDB[0-3], max 6 chans.
 Santity check to msg size

V3:
 Added scu type tx/rx and SCU MU type

 drivers/mailbox/imx-mailbox.c | 134 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index df6c4ecd913c..0895ccd23d17 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/firmware/imx/ipc.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -27,6 +28,8 @@
 #define IMX_MU_xCR_GIRn(x)	BIT(16 + (3 - (x)))
 
 #define IMX_MU_CHANS		16
+/* TX0/RX0/RXDB[0-3] */
+#define IMX_MU_SCU_CHANS	6
 #define IMX_MU_CHAN_NAME_SIZE	20
 
 enum imx_mu_chan_type {
@@ -36,6 +39,11 @@ enum imx_mu_chan_type {
 	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
 };
 
+struct imx_sc_rpc_msg_max {
+	struct imx_sc_rpc_msg hdr;
+	u32 data[7];
+};
+
 struct imx_mu_con_priv {
 	unsigned int		idx;
 	char			irq_desc[IMX_MU_CHAN_NAME_SIZE];
@@ -134,6 +142,63 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
 	return 0;
 }
 
+static int imx_mu_scu_tx(struct imx_mu_priv *priv,
+			 struct imx_mu_con_priv *cp,
+			 void *data)
+{
+	struct imx_sc_rpc_msg_max *msg = data;
+	u32 *arg = data;
+	int i;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		if (msg->hdr.size > sizeof(*msg)) {
+			/*
+			 * The real message size can be different to
+			 * struct imx_sc_rpc_msg_max size
+			 */
+			dev_err(priv->dev, "Exceed max msg size (%zu) on TX, got: %i\n", sizeof(*msg), msg->hdr.size);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < msg->hdr.size; i++)
+			imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
+
+		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
+		break;
+	default:
+		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_scu_rx(struct imx_mu_priv *priv,
+			 struct imx_mu_con_priv *cp)
+{
+	struct imx_sc_rpc_msg_max msg;
+	u32 *data = (u32 *)&msg;
+	int i;
+
+	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
+	*data++ = imx_mu_read(priv, priv->dcfg->xRR[0]);
+
+	if (msg.hdr.size > sizeof(msg)) {
+		dev_err(priv->dev, "Exceed max msg size (%zu) on RX, got: %i\n",
+			sizeof(msg), msg.hdr.size);
+		return -EINVAL;
+	}
+
+	for (i = 1; i < msg.hdr.size; i++)
+		*data++ = imx_mu_read(priv, priv->dcfg->xRR[i % 4]);
+
+	imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);
+	mbox_chan_received_data(cp->chan, (void *)&msg);
+
+	return 0;
+}
+
 static void imx_mu_txdb_tasklet(unsigned long data)
 {
 	struct imx_mu_con_priv *cp = (struct imx_mu_con_priv *)data;
@@ -263,6 +328,42 @@ static const struct mbox_chan_ops imx_mu_ops = {
 	.shutdown = imx_mu_shutdown,
 };
 
+static struct mbox_chan *imx_mu_scu_xlate(struct mbox_controller *mbox,
+					  const struct of_phandle_args *sp)
+{
+	u32 type, idx, chan;
+
+	if (sp->args_count != 2) {
+		dev_err(mbox->dev, "Invalid argument count %d\n", sp->args_count);
+		return ERR_PTR(-EINVAL);
+	}
+
+	type = sp->args[0]; /* channel type */
+	idx = sp->args[1]; /* index */
+
+	switch (type) {
+	case IMX_MU_TYPE_TX:
+	case IMX_MU_TYPE_RX:
+		if (idx != 0)
+			dev_err(mbox->dev, "Invalid chan idx: %d\n", idx);
+		chan = type;
+		break;
+	case IMX_MU_TYPE_RXDB:
+		chan = 2 + idx;
+		break;
+	default:
+		dev_err(mbox->dev, "Invalid chan type: %d\n", type);
+		return NULL;
+	}
+
+	if (chan >= mbox->num_chans) {
+		dev_err(mbox->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n", chan, type, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &mbox->chans[chan];
+}
+
 static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
 				       const struct of_phandle_args *sp)
 {
@@ -310,6 +411,28 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 	imx_mu_write(priv, 0, priv->dcfg->xCR);
 }
 
+static void imx_mu_init_scu(struct imx_mu_priv *priv)
+{
+	unsigned int i;
+
+	for (i = 0; i < IMX_MU_SCU_CHANS; i++) {
+		struct imx_mu_con_priv *cp = &priv->con_priv[i];
+
+		cp->idx = i < 2 ? 0 : i - 2;
+		cp->type = i < 2 ? i : IMX_MU_TYPE_RXDB;
+		cp->chan = &priv->mbox_chans[i];
+		priv->mbox_chans[i].con_priv = cp;
+		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
+			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);
+	}
+
+	priv->mbox.num_chans = IMX_MU_SCU_CHANS;
+	priv->mbox.of_xlate = imx_mu_scu_xlate;
+
+	/* Set default MU configuration */
+	imx_mu_write(priv, 0, priv->dcfg->xCR);
+}
+
 static int imx_mu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -396,9 +519,20 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.xCR	= 0x64,
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
+	.tx	= imx_mu_scu_tx,
+	.rx	= imx_mu_scu_rx,
+	.init	= imx_mu_init_scu,
+	.xTR	= {0x0, 0x4, 0x8, 0xc},
+	.xRR	= {0x10, 0x14, 0x18, 0x1c},
+	.xSR	= 0x20,
+	.xCR	= 0x24,
+};
+
 static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
+	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
-- 
2.16.4

