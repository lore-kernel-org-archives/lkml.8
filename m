Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBECC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B064821741
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QABnGxlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgCCHtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:49:25 -0500
Received: from mail-db8eur05on2043.outbound.protection.outlook.com ([40.107.20.43]:6145
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727732AbgCCHtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:49:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0F1j6bKQ5CSdPFekC0wp+cu5XKaKIn4xcHjBWEksQir7RM745nDfdmnkkEXEnpRByPZtWTkL5rszdUGspYVB42UdnNRts1fM+ItF3a8T+OPE8G1/63tdi8jyX2AWNXu/TOklzb+tAYi9JMZJHWoc6veMqR7kkPeLqCm7EKkQDOZVq0yOsCODsrtVWdYqi69BZeiYA3ZUZROu4bZH4IE2hSIVXthJvcotM+VJe9fHQm2ZEgJ7dDgoar/PNi3GJLV9m14lUQKq25mw0oZuu48UT2Za1DXilJudiqQuuk6JXSBG1rCHIP9opzLl8C/bfpxTbB6W6R4k7FeCuYNCKutbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR6NoMNKXabg6OTqBIWDJz+MgXVJhEXf5bMTknGSLRU=;
 b=HgRWNpOWuZGLnHqRXqEh87lLDxM1EuMjQqHF3K+NJYk/CGCPp9SlZ3n7wHSxACBn25fFez1HTQw/GJavXmlX9KcBzKXf9p9K1/GTDNH3hEAh7bXnjxZzfRus5B8GB7hFBcEAqyJDXDPbYKHdZryARM+Wl7A5cxj0RErkJOenDCxYBDw/mklzNiIXG9Gip6d2+kqFhwu2ZHAAzDKEqecZfcqwfL3DRI5Spi0eLtqRjiRGgA4PgfbVa6I5LwUTB9uwpVKyDN/nisoDp8jEH+90YA9zDuPjIjDiXD1XuA1wRZejgmoJ9cDD1b4dRjwt/XigKJ1CEvVjZ8ZiRY4hV4ksHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR6NoMNKXabg6OTqBIWDJz+MgXVJhEXf5bMTknGSLRU=;
 b=QABnGxlBJK2A4v774WrKNdbWayoaf3G80gt1J3IVei2un2hsocsfRTbkg1IH7RdmYWo5Bf1M3a91dHQWz25rAPUWYS+TsxER/c7DIHNWuDlp+hr3gW6/D9BcPK5k41OPg3F6kEbMUud/ilGY2snHBKMifNlrq7YXbmzQlsYsBgE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4114.eurprd04.prod.outlook.com (52.134.94.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Tue, 3 Mar 2020 07:49:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 07:49:18 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 3/4] mailbox: imx: add SCU MU support
Date:   Tue,  3 Mar 2020 15:42:38 +0800
Message-Id: <1583221359-9285-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583221359-9285-1-git-send-email-peng.fan@nxp.com>
References: <1583221359-9285-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0250.apcprd06.prod.outlook.com (2603:1096:4:ac::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 07:49:14 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eba23cdc-e7be-4d11-2127-08d7bf47608d
X-MS-TrafficTypeDiagnostic: AM0PR04MB4114:|AM0PR04MB4114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB411475123A8C1827313B5FE788E40@AM0PR04MB4114.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(189003)(8936002)(52116002)(9686003)(6486002)(5660300002)(6512007)(8676002)(66946007)(81166006)(66556008)(66476007)(81156014)(26005)(36756003)(6666004)(956004)(478600001)(86362001)(4326008)(2906002)(2616005)(316002)(16526019)(6506007)(186003)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4114;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5tuPIka5EBUfwgiWsvrjFtN7iSN1gUjd5euljJSNWmFN11hLUdQf/4YmISDwpHWA75LPxb7l9oONj1ZPPXk4FXHYL+A4HzjE5k9ceEPoDTwb/y4y6hzUoS6GTVcslbyXG+KyYyroUpStR2vWZMqWTLnX//byzsquA43aDIl04Sk5FP2cwxkSWPmOE887R9E+fi1z1nA2TBbpKmiDkn4TjyxlFc/9X7RUGQgwhDd6j6zM/xPMLbV16m4zCtZN9OrugRot9UFM/a6XJfVazUe/vFv5hfZ3X9zHSL3+d1LMn6sFrXYpM3ClunlFZsVGEmVrUSFDqK1YSnlxf3eVp/bXNSHWHsN9DFVdAUVKsHRL4A2wx0iJHgCCyGoKkgZCisl7d/renIAvzUknonVQ5GGuJFdlmVXsbQl8xXxq21VS/c2tzUQ1QDKxysF3964QNFB
X-MS-Exchange-AntiSpam-MessageData: 4Qdfr70ELA/DqyljOSEeIg8deOIpV8pSvruWs52zL+sSnyc+ZwiKmY/gFtG4UN6oaxC1wsjbIEQDaG06wu/nM6kMMz1fUPA3KIHl7sqoh9OsVw1lv8HMUCFjdx2UzlXn0SdFCDCQk0t9J0pd964KpQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba23cdc-e7be-4d11-2127-08d7bf47608d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 07:49:18.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSjg2JG8k68XlImRQ76fKYx5c4VsW42EP8Gtmz0euIVl0yXe2PSrnrncO0ve5gvsYcLflLGILz+/DzX5IGq6iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4114
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

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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
index df6c4ecd913c..3f28c769a1c1 100644
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
+			dev_err(priv->dev, "Exceed max msg size (%li) on TX, got: %i\n", sizeof(*msg), msg->hdr.size);
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
+		dev_err(priv->dev, "Exceed max msg size (%li) on RX, got: %i\n",
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

