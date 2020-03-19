Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D836FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB672072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V18KhIop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCSH6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:58:10 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:29872
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgCSH6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKY85IksxSYDU56kShlJ8t5trlQk4586eXT6ZFMA4auca+R49jflGyGuJcDsJvdIfDIIdyEqoTvSYJmMQZrtD8p4OuQSq/B5aQIZRgFk4zc5VSHSLJLPNI8NZpvcXsk+8ye/SZe3oEBfewimiD1hW1bZSN6NqoO8TjT4v+XOH3lT1Gei/sPpjPBeN3EggSoFYKEjFzyFk1/fKcaU53g/V5C/W/Pn+PRLUM+a0jsCEL6p1XpA5c8GwW6jK+mjlB0oNmyb+idSlUum9oRJtz8YJUU/kkLeySJnW8MFYwzCpK0dB5wEfTxgzEctYTO9q3ebVV7r/Gkp9Xg+5FqV2O0Abw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8Jitof5CZyR3TGtnOCtcpPBUxbRnj8xqRLimxDM7aE=;
 b=n15K3f8iBXOYDLUaz96z8LBUQLImGEMh+Orm+CEvKaIOGkj1c1a0fCNgi3TS72FTTH7rzv86ZMrHfEU/fivArPPHGPkQmPmB0UmarR51RNK4NtHfm9zRxVzrIdjtG9fkkk2Clw6EAMB33WjcHSfiGD/jk4ae3xEqnjFUV89PqDp5zqYh5sq6ZN0TJBJJdNCqlLMxQJ2gK2EwFXo21xczIOTZ1CqRuUJ9PKF1h+f5rD/ShEcJq9ge0fDt8DojYDprGsJUX+0yU+YD7k77e1SXGjtsMp8eqL/e8u/OcS0ddMtHw1bsOKilU5aYlgF75geqAjSzU5pfAyGVTxifss5gxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8Jitof5CZyR3TGtnOCtcpPBUxbRnj8xqRLimxDM7aE=;
 b=V18KhIopQ14oNSf6kCGfhvNaWDi5akhxub+BUbvm0EIunf0BJkglICYWRfewWE4BXtc8SEIrqCkMxaGi++PqVDZ5Rp45MWFOAKVUOR++7VNqvzqoECQqDLztNcSVk8eokQOohthyI6x65nMcdKHawAOoKhLOMJrF6IVbQ9QaXxQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5780.eurprd04.prod.outlook.com (20.178.118.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 19 Mar 2020 07:57:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 07:57:32 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 3/4] mailbox: imx: add SCU MU support
Date:   Thu, 19 Mar 2020 15:49:52 +0800
Message-Id: <1584604193-2945-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
References: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0118.apcprd02.prod.outlook.com (2603:1096:4:92::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 07:57:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7188d80-5df7-4f26-1054-08d7cbdb2d71
X-MS-TrafficTypeDiagnostic: AM0PR04MB5780:|AM0PR04MB5780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5780FA37C693DEE370C3ABB088F40@AM0PR04MB5780.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(6666004)(66946007)(36756003)(66476007)(15650500001)(6486002)(5660300002)(478600001)(6512007)(9686003)(16526019)(4326008)(81166006)(81156014)(52116002)(6506007)(8676002)(66556008)(316002)(2906002)(8936002)(2616005)(186003)(86362001)(956004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5780;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSPTA6E2wEEyQfx8PHCerS5O7iDNP02lXkMHix81se9Rm5M40dxqrmD8TlT2VN4fwuBxSVJGuWcPUf/AuNsTuAWMK35lS8jpIhVkFg/V0fgGuBFtrey6cQsszS6w/oI7WmkidRIAWhHPKPQyDC/Jl5ft5nuaP/RWzAmplwc6yT9jKMtnTQMvqWcpPgGlYbCkMRkRqk9ufnx3zufUSx5eqSAMF5tl+2s2afXchFUm+UR4CGO3QIX/w6Z2WfG7M7DyfBVGlgytX7e4XBYCowOTN5eN4cCnnYlPvaIC9bHxP8YybUN8qLWuVEkfnuBU8+gq8Hft1vnz+yucuDecYvSkRfS6vQWiepu/mqHYjG2fOHi1gT2p8JecJVylHEqVyNVE7+6ht3I+g8Fj7V3SVfcr3HaspvryG4eTMkpBmHGBV0DnwYk40Uibvy6kc/GdL+rZ
X-MS-Exchange-AntiSpam-MessageData: j/dvqPFx+aySpYpJb8GKqa8szNe6UMOGpsnbu7HpjOLDNM2uzyiaZbwznbvbbzF4lvaHZ9ydlgLHstQrh35EI6bQ3Zaa0BJhBQvDt82EaTEdHRXH4QZb4uQOTODdmNnw4RzIEVUS5adBJbAOEt0qSA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7188d80-5df7-4f26-1054-08d7cbdb2d71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 07:57:32.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFf7kw3gHQkWmpnN2HDIhdotsd4HVAWGMbbyHepHWs85rNDvbjpuU9gfRdN572hEExidATvWUJLdOpxnkxTE7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5780
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
V7:
 Add TE/RE check

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

 drivers/mailbox/imx-mailbox.c | 155 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index df6c4ecd913c..7906624a731c 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -4,8 +4,10 @@
  */
 
 #include <linux/clk.h>
+#include <linux/firmware/imx/ipc.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
@@ -27,6 +29,8 @@
 #define IMX_MU_xCR_GIRn(x)	BIT(16 + (3 - (x)))
 
 #define IMX_MU_CHANS		16
+/* TX0/RX0/RXDB[0-3] */
+#define IMX_MU_SCU_CHANS	6
 #define IMX_MU_CHAN_NAME_SIZE	20
 
 enum imx_mu_chan_type {
@@ -36,6 +40,11 @@ enum imx_mu_chan_type {
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
@@ -134,6 +143,83 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
 	return 0;
 }
 
+static int imx_mu_scu_tx(struct imx_mu_priv *priv,
+			 struct imx_mu_con_priv *cp,
+			 void *data)
+{
+	struct imx_sc_rpc_msg_max *msg = data;
+	u32 *arg = data;
+	int i, ret;
+	u32 xsr;
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
+		for (i = 0; i < 4 && i < msg->hdr.size; i++)
+			imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
+		for (; i < msg->hdr.size; i++) {
+			ret = readl_poll_timeout(priv->base + priv->dcfg->xSR,
+						 xsr,
+						 xsr & IMX_MU_xSR_TEn(i % 4),
+						 0, 100);
+			if (ret) {
+				dev_err(priv->dev, "Send data index: %d timeout\n", i);
+				return ret;
+			}
+			imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
+		}
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
+	int i, ret;
+	u32 xsr;
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
+	for (i = 1; i < msg.hdr.size; i++) {
+		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR, xsr,
+					 xsr & IMX_MU_xSR_RFn(i % 4), 0, 100);
+		if (ret) {
+			dev_err(priv->dev, "timeout read idx %d\n", i);
+			return ret;
+		}
+		*data++ = imx_mu_read(priv, priv->dcfg->xRR[i % 4]);
+	}
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
@@ -263,6 +349,42 @@ static const struct mbox_chan_ops imx_mu_ops = {
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
@@ -310,6 +432,28 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
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
@@ -396,9 +540,20 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
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

