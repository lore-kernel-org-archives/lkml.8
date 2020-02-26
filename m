Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A6BC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBE521927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZqSRDzuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgBZErA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:47:00 -0500
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:23620
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgBZEq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:46:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMCDSwzt0M5pNHZXnnasY/K7dTcn3huf1VuTkezFPO9tjaeYwd9pRgV1wU7dI1NvbaMmdNxx2mbkiEnh6OH7qMjhk7qaSYqIMIeQLxLAOn0iNfBwZW5jPDeFW6w2/Ah/uE645SM/YCv0gf7WlxQbLq85yvCKpxdBSfQSAoRg9AQMc62CH8clCV6D0eMYnCgX+hhfyxPrWp1yLtOGyTOYmRqLjpTy7e/D2OdQZUXfRXIL2Rv2rVeV0rtNDKYX6vrWMyj79ag491v0SOIIJyOUM6VgD/gYgv7ofqcnVQN+McQ1i7j2rXLhjO6MgYRdT8tMCi/ts+uM6Q96Dd1fWQvcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gleWzQx7a+SjOSuQKkgrChtOnBD5CaVd4900zhgJXGQ=;
 b=km/iXULzYfxxHCRbHMXJqJZB70/TuORvTZzsfbK++J6UGm9SvpekvNiY5+twzNYfXJqJvr1lgbwCJqkz1idUmZjMzjfp6WbnYQx9k/Ix5bKGDUaynv4AxI/zU4g/ER/XSN5uZP/adkjB3euy57FYhhgAlgE5JcCyMqSQBwBHxoGK+bx3ZfkqNtOSbVID7BRvbJ5UtDpqAy9HGngWz0DqaYYvh0Kq8ndkq9KKJjUnIb4Bok8RToljoxzlvPDv7ulXfTfHr8mikK42IPUbClYqZ8/Rc7iiDnORtR+Kzpm4o78gaNptEybmJVsMoMdIR2CIMHxiHgbNmsIZpXbABqcwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gleWzQx7a+SjOSuQKkgrChtOnBD5CaVd4900zhgJXGQ=;
 b=ZqSRDzuXaw2t/jMEgai9Bs/oJzs7RR8FNXPnDwOQi9SKCRqYO3cCn3LPNJBhrH+92K0FOGglFEYw1kZZyNfO+AXUC75//XCkDj+hoUuTbNtY2SHYd0PfCJlNPU3pE87iUArs9y61xn8uJkrbp3KOUqUXf6aCvy3rkqc2lYYcZ3E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (52.134.126.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 26 Feb 2020 04:46:56 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 04:46:56 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/4] mailbox: imx: add SCU MU support
Date:   Wed, 26 Feb 2020 12:40:42 +0800
Message-Id: <1582692043-683-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582692043-683-1-git-send-email-peng.fan@nxp.com>
References: <1582692043-683-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0135.apcprd06.prod.outlook.com
 (2603:1096:1:1f::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0135.apcprd06.prod.outlook.com (2603:1096:1:1f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 04:46:52 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c42446d6-bbf6-4f42-6527-08d7ba76e802
X-MS-TrafficTypeDiagnostic: AM0PR04MB4291:|AM0PR04MB4291:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB42915D7719A1CAE319A17E9388EA0@AM0PR04MB4291.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(6486002)(6666004)(316002)(6512007)(9686003)(86362001)(8936002)(2906002)(36756003)(4326008)(8676002)(81156014)(5660300002)(15650500001)(81166006)(52116002)(478600001)(66946007)(956004)(2616005)(66476007)(66556008)(186003)(16526019)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PniXC5+6E01ItSs5sdyU5k3E1VdH+/ujp6xiQBgJR+xnR6M1UOlHsNncjOkheTRs2I/+dXhI6ffB0JSO4VhE6Jbx6WubtbX2B1xaPmS628mAF6EaY3bf/pOTzaA5w778SPTcSja6BmhXj2CFNoeAmEWQF2Ytyfh6L1eILEj8sZsixCX3ZbGCrWR3HBeW24F2fMn353TQQcTIgIc+HV85A7Rl04dVMq+cV5cDbzo0esonaokXsTse+Mq+woakxBg0LmmLHrF+40RFaGuqwzNYhgo48g5sBHUy+ptN2TmvEXWa0lq36iEf5m9rvVSjBzojuThBL/8IAkaKQWbFwrtB9JULFa+/WlCCqurP4IzY4Aq5pDPWPOLSB5l320abtqHdwJNuMTKlhOLGlB5pLv0PYaIxmxweCEFuMNyTzeA3r0XthN1zME1sTq87TbP6hji
X-MS-Exchange-AntiSpam-MessageData: +jy7j8OatKuy0q0mLBAuAMZAH0a5PJ9P5WGe1NNEQuoGP7iFwR9c+UmjglaVrnEY5r67MiA2LGC+FxfnfMKmvPkBJjNSCk6GsYHwG5fZpAOTXvD4rmqKjzp2CsSxGyoqTaTTROfYvDFI+GtrbNvGcg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42446d6-bbf6-4f42-6527-08d7ba76e802
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 04:46:55.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lRtG69iHgeE0nO4c2ZT7rkrF2FOJxR9SlmFVseOWp3TueD6FsXIf5JLq3f4cYe1hBU0gvRMxOwarNCb8xrhrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
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

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Added scu type tx/rx and SCU MU type

 drivers/mailbox/imx-mailbox.c | 65 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 901a3431fdb5..41664a64c5fd 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/firmware/imx/ipc.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -38,11 +39,17 @@ enum imx_mu_chan_type {
 
 enum imx_mu_type {
 	IMX_MU_TYPE_GENERIC,
+	IMX_MU_TYPE_SCU,
 };
 
 struct imx_mu_priv;
 struct imx_mu_con_priv;
 
+struct imx_sc_rpc_msg_max {
+	struct imx_sc_rpc_msg hdr;
+	u32 data[7];
+} __packed __aligned(4);;
+
 struct imx_mu_dcfg {
 	enum imx_mu_type type;
 	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
@@ -141,6 +148,48 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
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
@@ -274,6 +323,7 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
 				       const struct of_phandle_args *sp)
 {
 	u32 type, idx, chan;
+	struct imx_mu_priv *priv = to_imx_mu_priv(mbox);
 
 	if (sp->args_count != 2) {
 		dev_err(mbox->dev, "Invalid argument count %d\n", sp->args_count);
@@ -284,7 +334,9 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
 	idx = sp->args[1]; /* index */
 	chan = type * 4 + idx;
 
-	if (chan >= mbox->num_chans) {
+	if (chan >= mbox->num_chans ||
+	    (priv->dcfg->type == IMX_MU_TYPE_SCU &&
+	     type < IMX_MU_TYPE_TXDB && idx > 0)) {
 		dev_err(mbox->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n", chan, type, idx);
 		return ERR_PTR(-EINVAL);
 	}
@@ -401,9 +453,20 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.xCR	= 0x64,
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
+	.type	= IMX_MU_TYPE_SCU,
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

