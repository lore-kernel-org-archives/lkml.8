Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC9C3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08B024680
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="drMS6vTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCCB7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:59:34 -0500
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:55607
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbgCCB7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:59:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biwYjjqF/1g3h6/yM7Pf6uw/OiPcW79BOnnhLTdUOw2dvh8VbYPzq3zJZ1CyO+xVK9vzXKtnauHByHzfFFM4W89pj6ytPw34mugxtGkrj0IRp+9jrL6NduFqZdw4wuSiIsne6dW4JPOOyu4DHYrKZEBptGCl2Ji8RLJInBPwgGw4FNelVsBUjCFnJVNhAuUpsz0oSKGOAmWLtYtuq/I3D3kvF+VEPzatbWHsYSo8TYKCO5+c3khRxnO7lWo9hqU/+YsAp5icm1VfeCPz5HugEEwogPXYF0OJ67V88FmuGywUHxOQwoMQz8qMPSJEiMkosdUZyhrOZYvJ2cfERrIOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60ZizmtAEIKQLjv6E0CJQAJdVGhHruo6JrucSzfgi6c=;
 b=ImE9bELW1cpDrZee+iClvtajPSxNyXjHQ1suoUJeVNg7Bv6PXKEi3Ml+3HJaMZ0f131LV7LysxnR2ZoczfcezQXSvJMGAAnh2mte0r0tc7KF9B4JOcONdL9gzGQXA0ZXn4Ng5189zAGfInNV4oMhWOKET8BGfZabQSYx3HUP/hUW7nPWyBiH3kAOOvPucQBkzLH9lTO6pMLGbgQYUPjAuKG7/xs69PGsklXb5k89bqT64KDZV9YwTKb5cP6qAKvDwtPX+9GA3H8A4FtFE50k5VcEJmiYS7ZIxO5OYYTjkzBhniD7aTJoNEQYBS8yi1UU4IcswfEDnRyCxTMCsWveaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60ZizmtAEIKQLjv6E0CJQAJdVGhHruo6JrucSzfgi6c=;
 b=drMS6vTcG3eKsujqqQoAwzPx5XFeqFT4CLNArecAjM4Gu86BFJ3K9//ANDIc4UamXZMnS0YGb30U6oZjoU1nSy2LKHCqyIWjCekCvdHItsBaOMbGzHDsCMw6ViJzYMd3EfFabXQYUE7l4pDWwlrIztOHNmIz1SPVmzE4k173cUM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7057.eurprd04.prod.outlook.com (10.186.131.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 01:59:30 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 01:59:30 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/4] mailbox: imx: add SCU MU support
Date:   Tue,  3 Mar 2020 09:52:59 +0800
Message-Id: <1583200380-15623-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583200380-15623-1-git-send-email-peng.fan@nxp.com>
References: <1583200380-15623-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0147.apcprd04.prod.outlook.com
 (2603:1096:3:16::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR04CA0147.apcprd04.prod.outlook.com (2603:1096:3:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.18 via Frontend Transport; Tue, 3 Mar 2020 01:59:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8a712f1-770e-45da-6e22-08d7bf1682c5
X-MS-TrafficTypeDiagnostic: AM0PR04MB7057:|AM0PR04MB7057:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB70570C6C043BF1148EA931D388E40@AM0PR04MB7057.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(9686003)(6512007)(2906002)(15650500001)(6666004)(6506007)(26005)(956004)(81156014)(81166006)(8936002)(52116002)(186003)(6486002)(2616005)(4326008)(16526019)(66946007)(66476007)(8676002)(478600001)(66556008)(86362001)(36756003)(316002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7057;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYSON2gPvSmTZnRPm1TeJQgSZ0cHMiGW2ra/ZBPUBCXHfsQCwVIiDjjkNhDFXD3uQjthvm60u3l/1GuZm/yP/uxWS8oowLmKW03pcVtto7yPLHqTVSanPZG7+nAc+XpRw7V7s/D4/KDDCeXPMzEM4gQBoRnIzez2usldPOJwVf01fT+EKwoH88yhMGQLdJY0MRb3VhcDl+bqY1m6tnfMrX/3TUkTYFFBViDhw/A947azECBrx1qfjfREaKcnAKR31IuJDTlPZM3njTB2HzcNi1H0VIvPgV76aG8AU50t4SzCqhEEnS0AXi23wREQR68YGpWV9DuSPOjgc/wVR+i1zeMjrLC/DPMpq7djw9UEFID187EEaOA7HzKDV6asInvdN/FPlJyfVlay3D8TEYmw1hk2SqeGDqCa1jfJc4ZDDEa6TLKlOpuX0cynhSTzzR4Z
X-MS-Exchange-AntiSpam-MessageData: 7BRbnQOXxbT3QIUBD2lUPjYGTNuB61WH+v0yJviYPzjmBEyQgV5wtWie96wbqC0dEztwMuU2OaNfsufnU5xRJSckLGIgX1bgNj5uLVcYMio5gXVkCa30ibMltGcjbhErwuS0sk6TSOX6CaJokcDWDA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a712f1-770e-45da-6e22-08d7bf1682c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 01:59:30.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4DEzeYI1SH4iAzPN6CBMhm05FG235kEicXdkZizGM/oaieLccuX7vr7va3kgjCmC4ur+hQa1214f0NW1qL3Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7057
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
V4:
 Added separate chans init and xlate function for SCU MU
 Limit chans to TX0/RX0/RXDB[0-3], max 6 chans.
 Santity check to msg size

V3:
 Added scu type tx/rx and SCU MU type

 drivers/mailbox/imx-mailbox.c | 128 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index e98f3550f995..fbdcd68d8490 100644
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
@@ -39,6 +42,11 @@ enum imx_mu_chan_type {
 struct imx_mu_priv;
 struct imx_mu_con_priv;
 
+struct imx_sc_rpc_msg_max {
+	struct imx_sc_rpc_msg hdr;
+	u32 data[7];
+} __packed __aligned(4);
+
 struct imx_mu_dcfg {
 	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
 	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
@@ -136,6 +144,56 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
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
+		if (msg->hdr.size > sizeof(struct imx_sc_rpc_msg_max)) {
+			dev_err(priv->dev, "Exceed max msg size\n");
+			return -EINVAL;
+		}
+		for (i = 0; i < msg->hdr.size; i++) {
+			imx_mu_write(priv, *arg++,
+				     priv->dcfg->xTR[i % 4]);
+		}
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
+	if (msg.hdr.size > sizeof(struct imx_sc_rpc_msg_max)) {
+		dev_err(priv->dev, "Exceed max msg size\n");
+		return -EINVAL;
+	}
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
@@ -265,6 +323,39 @@ static const struct mbox_chan_ops imx_mu_ops = {
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
+		chan = type;
+		break;
+	case IMX_MU_TYPE_RXDB:
+		chan = 2 + idx;
+		break;
+	default:
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
@@ -312,6 +403,28 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
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
@@ -355,7 +468,10 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
 
-	imx_mu_init_generic(priv);
+	if (of_device_is_compatible(np, "fsl,imx8-mu-scu"))
+		imx_mu_init_scu(priv);
+	else
+		imx_mu_init_generic(priv);
 
 	spin_lock_init(&priv->xcr_lock);
 
@@ -396,9 +512,19 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.xCR	= 0x64,
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
+	.tx	= imx_mu_scu_tx,
+	.rx	= imx_mu_scu_rx,
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

