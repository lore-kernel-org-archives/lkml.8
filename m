Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E9C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89AD2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fWenbjiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgBXMVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:21:15 -0500
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:4353
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbgBXMVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:21:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFXyIJsanEnr34HT+yjQYfFZyuzdYVOqLE3d1nVGA7+s5iX2RQVqcQ8MCI7fm1eI+Dhz2/coJAsnQAkHp32S6i2PAIFEdrO5Y5BN5Hl2EPLTblGyM6JhDO7aGEgiGbV0us7xq+fOlYb+3Jsakz8xSjlezRPJYLzrfo6XqN8HbPU+zisaq81R7QAX/0kbe2zMIjEeRO2DXhmwTo2byUcxbaoLBvHPIxlkpfmzt81JWKqT6HfJgH0uWPu16vF6lezwoxd/ygKs4ct9ZBFd1Rta/iDDPBf9+sqTLetBNDGliRYVHEuxs1fCVQ+QyBaAlbOaaheGsLCjTPxytDbad29Whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b0P30RauOuxXqIFF2yZYxrPdIhC11iMBQNzcj1LzhI=;
 b=J2z704t5+4z8gCmbtnjTDfnxYwFH1/WxET1ugDR2/MB7gslnkUPwbQx2VfUxd1+LBYS2ZDxAgGmA0AdEnUyAZoWi1/enkAqdm2iEoORW/jYM88XioCllNi08T24nBt0xlScr8t6ygZmOXoH6y4PWcb4S9EQLhev9ThR9eBPECW/Hynx+Xcu35VTAcxf3l2iWWLjOn+cLWVHBvHw4sl9e7ngDiun1um7xzh/Ux6Kc0CLzNXr8boswRLzHl+kQGD/MIkD7Uc1qeZT1KB6Jlgsx6S3O6Bv1U2an/wMqotMYlBfNvBbh2MVmG2VfTJ5m1EwGBzG9wBe4pcwB/IwONr6+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b0P30RauOuxXqIFF2yZYxrPdIhC11iMBQNzcj1LzhI=;
 b=fWenbjiVzs6ivFDTaMbRbkHyTDP2WicEe5axfAJ4KlgMCnMdRKNl9tD/WzHc1RJGcAgcV7mmV/AWCEnkB+YVOQtxsoOR3xDxQyjFuCxAjvh2B2dUP60tHszTI/aZO/sIJcF5FRc2DZAKtRNrnf+qJBXZLvgcdPYKPbwdDat62TU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6289.eurprd04.prod.outlook.com (20.179.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 12:21:03 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 12:21:03 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, leonard.crestez@nxp.com,
        o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        m.felsch@pengutronix.de, hongxing.zhu@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] mailbox: imx: support SCU channel type
Date:   Mon, 24 Feb 2020 20:14:33 +0800
Message-Id: <1582546474-21721-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582546474-21721-1-git-send-email-peng.fan@nxp.com>
References: <1582546474-21721-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0077.apcprd04.prod.outlook.com
 (2603:1096:202:15::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0077.apcprd04.prod.outlook.com (2603:1096:202:15::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 12:20:59 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7c1b406-8124-4a06-16ec-08d7b92403fa
X-MS-TrafficTypeDiagnostic: AM0PR04MB6289:|AM0PR04MB6289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB628928806CB311BD43CE940788EC0@AM0PR04MB6289.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(2616005)(6506007)(9686003)(6512007)(15650500001)(26005)(86362001)(81166006)(52116002)(6666004)(8936002)(7416002)(8676002)(81156014)(5660300002)(66556008)(316002)(16526019)(6486002)(4326008)(66946007)(36756003)(186003)(66476007)(478600001)(2906002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6289;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0Uup3zogofMY+mV/Pd7c9AyaCwiCpwnh9OuJbDecdPdrioLnQgM/Xjvv1lC9KM5ghyjdmM+mtWciVpIgCs9yvNcPUTmJQj/hq4IYvRrjbperU+ufzJ1LQz7YyXlpMq+3bMfKJIRB+o2Emn1jX1rvESm2aHNqL56QwdPhFsxl6RTwGPDcpSuRwMrMJmPSPSCfApV/WqKzGer7TnrCCfbPaDZ9aBgZ8kBXBZodgmmFjYE7DXYLX8BcmlhSGOL7Zk2lZB8q+F1USaK21V6W7e0qdBciXn3JzMpMSNuJyT9WawUmKCJGrFopafSRuzBJmiNR8Y9j67QVnNLy4XHM6RQTK+QqdyYmIGYMXklhjf0UwnVAuv0NV5SynAu33C5U4/mybM2J55/zs7YwnWHYHEf+hVFlYoj4ESrCwkf0dAPtMNL7x88dd9QoEA46dLcmkuT
X-MS-Exchange-AntiSpam-MessageData: a2QNxPD6ST0y7CWQ3SXTPwJoIFh/iuwDu+GHG+zOdVtFTKhOmN9GzWRnH+WS03rZ6ttZOob9vYCwNXebpx8E38m+RSTibayOpNMnfMDCOpmzP9jVdP8VYZbb2L0DzdOeaH2+nbh5Cnq1htlagVJBxg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c1b406-8124-4a06-16ec-08d7b92403fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 12:21:03.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LonljUA3DzE9+ZpRB8VIoqmc0sp727zxwoXcsXslMU2+h0WNZ2RXW1kYvo0yeCL9poHxPgQlyOYmvH6UmL5S/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6289
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
 drivers/mailbox/imx-mailbox.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 2cdcdc5f1119..7d9aafff5f6d 100644
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
@@ -341,6 +374,7 @@ static int imx_mu_probe(struct platform_device *pdev)
 	}
 
 	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
+	priv->scu = of_property_read_bool(np, "fsl,scu");
 
 	spin_lock_init(&priv->xcr_lock);
 
-- 
2.16.4

