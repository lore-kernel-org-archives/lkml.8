Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40490C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C2D20732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4pE8X5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCSH6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:58:16 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:29872
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgCSH6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:58:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjwSrYuNqMqgwcguziTKK639e6ajSS8SVbWd6I7YFJwEsFtfjPKi2B5LRdjN7GA+7em9LhDkNeZTMFMlzDAJHE/z0FXxsPuL75FS0phIzHs90WwbidiJ6fZWBNlwO4aOQTkebT3hlsvUEoyzS/vesLZf5aotwqZxEhGcHyaC2NYeE9AniLv/pNdJ8l7vz5Cga3pyh0zZ8yOHOffYqGM9W2tyCcV4GgQf5iazrPtFqHd7mWXbFc2YsnhYDi8rz6PiMQhEWGqruiLFVmQyWU65xtgcOA1M9yXzPphURItWwCLyjMiBwiMViP8uRTGw9HLJMiNDhrhDnQUstuh/7y6PVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7buiXnKm/D+xO/GO2VsXzVG3Yx3wmEXN9nDB+aq8Y8=;
 b=fqydm1YRrSHk4FsQjIEVv/gvabv+iuzKYp68B1pUZ+B5jawjV3c3J7KMkolwLkj7KO6kptBlyC+Fqc+p9ip5jTEtHBWpwL919b3N3tt6b7oJySQOLn8plaK4yXzjwqnzsWE0dOeeUVz6alSxzLD6rQN7eTnGuUlVCb4RLS1UY0aTxk95HXski2Wlz2oFDWyqvDWg6I1zaff/Yl4mKymRL77fgGm/XZK8asNllaCZLUNcZfixIxWKQCvpWjaNvQlqNkrNIVBjnIolFJlC+aD1JdRzgLuBjZK1XVUe3B4nDLw78ilEu/bs2Ogh5OcskYMpPJqQCYWV9VEbZQwSiGZUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7buiXnKm/D+xO/GO2VsXzVG3Yx3wmEXN9nDB+aq8Y8=;
 b=R4pE8X5kr9qv1BAAESaMMZCF0ApbY1GSPw8/kkU3nKxSlvh/dD3gV4P8AunpgewLCzZ/aQJdcUTiSDmORaxOBFc5jSVpWCD0DzmgwQbroHZ9tdOWLea9gQ8stAvrtF6HXvDZ0pc3y355CAA4HsCl8+/49rcz5GxrHkeDOJUAph0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5780.eurprd04.prod.outlook.com (20.178.118.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Thu, 19 Mar 2020 07:57:36 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 07:57:36 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 4/4] firmware: imx-scu: Support one TX and one RX
Date:   Thu, 19 Mar 2020 15:49:53 +0800
Message-Id: <1584604193-2945-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
References: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0118.apcprd02.prod.outlook.com (2603:1096:4:92::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 07:57:32 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd907a9a-b7c9-4d08-c9e0-08d7cbdb300b
X-MS-TrafficTypeDiagnostic: AM0PR04MB5780:|AM0PR04MB5780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB57800951561E41CBAEC008F888F40@AM0PR04MB5780.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(6666004)(66946007)(36756003)(66476007)(6486002)(5660300002)(478600001)(6512007)(9686003)(69590400007)(16526019)(4326008)(81166006)(81156014)(52116002)(6506007)(8676002)(66556008)(316002)(2906002)(8936002)(2616005)(186003)(86362001)(956004)(26005)(83323001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5780;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKpOXp8fUFYya7fUY+34cP8TqvkZ2rImNGsCZJeb+ZhcOBWGTeFbRdy4+ABo4dsciwrYkSQn1DSIgpkP4TaFO8y2KUU3r11nBZ2clV3ETKnu1Y2E3CigHgKJRa2Rz4TuSJkzX0Or9LIjZ7h2+hk9w2pfSBeXo6fL7nFojvLxFnhbAawSrBV6P6EoXyltDewdl/uE0Y3ms//jfNLPz9hXSsrzVRrgNuJhpe+ypIOQhhTcEQ5daatijAWPv3kYLFgs0jkSrdG3lXTIk6WCQMa3eTk0m5krLlr773qXiG/n7MyK/qMf2Gjtx113KrTT31VGfeCK02nkkjkWUsRpAhXtqHqcEUUSVmw8epfWEe3S/SFqnQB53kxtBpJrmkeKXGyzqZeeYe+OS9TCMSQzVoFalm2pKhu2YTPiUEH7q8TXQg7s7ZqRg4MTntyW3TsOIqc7bWUmlXDXCGRIQYMelBvYiHFVzYKyp+DgvXdMbLQVkSVF13Tg3aeliOLyYuLJzBweGkH9rFXyvh0aQTmeZRkqXw==
X-MS-Exchange-AntiSpam-MessageData: 6Q/5LCl6M7t4KAoloNX/iC6P8lq4mN0qJxaGXArWgiNWb1RMo5IOMqs+e/aGuoica6HG9fQWJ7EHYld12EZPaeOlTYyItNnd4Vh0VrvRrro98/YdK0XQXHZ5Xn5RmKFnSHRNfTclV1RmCUldzCXNpw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd907a9a-b7c9-4d08-c9e0-08d7cbdb300b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 07:57:36.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlF+kiLF9lkgYxDEZph8N3/w7jZybQjsIjXh9uS7dI2b7o32+LG/V1Xmugp8z4mTMs3HTYcr926UKClMBtUHuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Current imx-scu requires four TX and four RX to communicate with
SCU. This is low efficient and causes lots of mailbox interrupts.

With imx-mailbox driver could support one TX to use all four transmit
registers and one RX to use all four receive registers, imx-scu
could use one TX and one RX.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V7:
 None
V6:
 None
V5:
 None
V4:
 None
V3:
 Check mbox fsl,imx8-mu-scu for fast_ipc

 drivers/firmware/imx/imx-scu.c | 54 +++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index f71eaa5bf52d..e94a5585b698 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -38,6 +38,7 @@ struct imx_sc_ipc {
 	struct device *dev;
 	struct mutex lock;
 	struct completion done;
+	bool fast_ipc;
 
 	/* temporarily store the SCU msg */
 	u32 *msg;
@@ -115,6 +116,7 @@ static void imx_scu_rx_callback(struct mbox_client *c, void *msg)
 	struct imx_sc_ipc *sc_ipc = sc_chan->sc_ipc;
 	struct imx_sc_rpc_msg *hdr;
 	u32 *data = msg;
+	int i;
 
 	if (!sc_ipc->msg) {
 		dev_warn(sc_ipc->dev, "unexpected rx idx %d 0x%08x, ignore!\n",
@@ -122,6 +124,19 @@ static void imx_scu_rx_callback(struct mbox_client *c, void *msg)
 		return;
 	}
 
+	if (sc_ipc->fast_ipc) {
+		hdr = msg;
+		sc_ipc->rx_size = hdr->size;
+		sc_ipc->msg[0] = *data++;
+
+		for (i = 1; i < sc_ipc->rx_size; i++)
+			sc_ipc->msg[i] = *data++;
+
+		complete(&sc_ipc->done);
+
+		return;
+	}
+
 	if (sc_chan->idx == 0) {
 		hdr = msg;
 		sc_ipc->rx_size = hdr->size;
@@ -147,6 +162,7 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
 	struct imx_sc_chan *sc_chan;
 	u32 *data = msg;
 	int ret;
+	int size;
 	int i;
 
 	/* Check size */
@@ -156,7 +172,8 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
 	dev_dbg(sc_ipc->dev, "RPC SVC %u FUNC %u SIZE %u\n", hdr->svc,
 		hdr->func, hdr->size);
 
-	for (i = 0; i < hdr->size; i++) {
+	size = sc_ipc->fast_ipc ? 1 : hdr->size;
+	for (i = 0; i < size; i++) {
 		sc_chan = &sc_ipc->chans[i % 4];
 
 		/*
@@ -168,8 +185,10 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
 		 * Wait for tx_done before every send to ensure that no
 		 * queueing happens at the mailbox channel level.
 		 */
-		wait_for_completion(&sc_chan->tx_done);
-		reinit_completion(&sc_chan->tx_done);
+		if (!sc_ipc->fast_ipc) {
+			wait_for_completion(&sc_chan->tx_done);
+			reinit_completion(&sc_chan->tx_done);
+		}
 
 		ret = mbox_send_message(sc_chan->ch, &data[i]);
 		if (ret < 0)
@@ -246,6 +265,8 @@ static int imx_scu_probe(struct platform_device *pdev)
 	struct imx_sc_chan *sc_chan;
 	struct mbox_client *cl;
 	char *chan_name;
+	struct of_phandle_args args;
+	int num_channel;
 	int ret;
 	int i;
 
@@ -253,11 +274,20 @@ static int imx_scu_probe(struct platform_device *pdev)
 	if (!sc_ipc)
 		return -ENOMEM;
 
-	for (i = 0; i < SCU_MU_CHAN_NUM; i++) {
-		if (i < 4)
+	ret = of_parse_phandle_with_args(pdev->dev.of_node, "mboxes",
+					 "#mbox-cells", 0, &args);
+	if (ret)
+		return ret;
+
+	sc_ipc->fast_ipc = of_device_is_compatible(args.np, "fsl,imx8-mu-scu");
+
+	num_channel = sc_ipc->fast_ipc ? 2 : SCU_MU_CHAN_NUM;
+	for (i = 0; i < num_channel; i++) {
+		if (i < num_channel / 2)
 			chan_name = kasprintf(GFP_KERNEL, "tx%d", i);
 		else
-			chan_name = kasprintf(GFP_KERNEL, "rx%d", i - 4);
+			chan_name = kasprintf(GFP_KERNEL, "rx%d",
+					      i - num_channel / 2);
 
 		if (!chan_name)
 			return -ENOMEM;
@@ -269,13 +299,15 @@ static int imx_scu_probe(struct platform_device *pdev)
 		cl->knows_txdone = true;
 		cl->rx_callback = imx_scu_rx_callback;
 
-		/* Initial tx_done completion as "done" */
-		cl->tx_done = imx_scu_tx_done;
-		init_completion(&sc_chan->tx_done);
-		complete(&sc_chan->tx_done);
+		if (!sc_ipc->fast_ipc) {
+			/* Initial tx_done completion as "done" */
+			cl->tx_done = imx_scu_tx_done;
+			init_completion(&sc_chan->tx_done);
+			complete(&sc_chan->tx_done);
+		}
 
 		sc_chan->sc_ipc = sc_ipc;
-		sc_chan->idx = i % 4;
+		sc_chan->idx = i % (num_channel / 2);
 		sc_chan->ch = mbox_request_channel_byname(cl, chan_name);
 		if (IS_ERR(sc_chan->ch)) {
 			ret = PTR_ERR(sc_chan->ch);
-- 
2.16.4

