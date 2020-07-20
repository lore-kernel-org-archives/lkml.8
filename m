Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C70C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E26A2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NwwtsqB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgGTJGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:06:34 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:23200
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbgGTJGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:06:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt1iIUkDz0/TsvrW5TtEWU0kPwChapEJuyFoywka4PVPzGFsnbT8gWGQD7U07j0ZOuKvx54HtkLpKZQ60bna7ISBWeoX1AeTBC51fC8idgvVoXc5+ww8BqlghdnThU4Y5qCo3TL3FuFeNKjRAx5QWwy7yHO3RqoOHAfIY83ZCx0EePxVFxcRR7BEAIe5TBHN9eDGwi3IKrHR7g/97eX/rWmsdGYgDebEDq1g3KWg6+SWIeGwMd171MSqOJOypqOFXPzfgrPnm5bbLFa0OOVMqgUVZL4TrkmqDUfFipkPQP5r5EuOpGQRbzL28c23Qda85se/Q5XAaehaujez1A0PKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrPiTVb1vGryBFBTYH45biIiK7E240tUrHbMmUIxdUM=;
 b=VM0RgNawR4vAP0qQy56kkqCDGCc4Q4slr2Sx/dqCcHUBB75YHWfmDvyF1fhxKVRK6Yu1n1x900yakTnapyLUWpMlsrlzxQeV7H7QQosXyeRa2Qf+tyP/jhYNbkOGUcuJnwBSamYZ6290joEzi7BdGx8bHxU07yYh8EfPQ9PZVO5YL0et80o+UboYrvljfV5ZsWnD4gDEqSpbpTNIBSsK7VMSKIszSM1BfOTnrsfnl4tDaL3fssa9YjeQabxrk5KYxEuBa8tLvDaHT/fY0rWTpIUUFcaXIeVQOGAJU/hFrj8M1DyOyTHxM3rG4pSegQud+JX2E/Gc7L+pkmESGw1BVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrPiTVb1vGryBFBTYH45biIiK7E240tUrHbMmUIxdUM=;
 b=NwwtsqB8G7bmBTRtpCd+GTe2FehX1iqXK0BkjTlp1CwOw0Ccp9qmbnO9IjzsHAgKysifVg0wcoE2BqlexqAWfY0y3spxH8XUsXhTmqWFzi32v3idS5z+qpfRR2elGxR4ZQ4pbWcLTO2Nh23hTOP/QsgMPV7hf5PRl3XXImm5mno=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR0402MB3762.eurprd04.prod.outlook.com
 (2603:10a6:208:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 09:06:21 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:06:21 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH 2/7] firmware: imx: scu: Support reception of messages of any size
Date:   Mon, 20 Jul 2020 11:06:12 +0200
Message-Id: <1595235977-106241-3-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 09:06:20 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2a9ba40-6bf9-4b21-4f43-08d82c8c2b9c
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB376296F981C33601A5C5A276D37B0@AM0PR0402MB3762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kVYznJj8mOsE89UdUTWC8/xf8QXKHfEMFgnmaJcd54UGhwiB9jCWvSomLMiWHrFV+G5HfWdHpXG/jG30wGEGFV8Gldnlgl1rDkgMjFjtI8J/O8to34uhPuUy75IdBnFQYUn6TZLHYnik8495yTeNIn3WYsJ8OqVx3Eikm14YNPddFa8IP59UC8lHUtvtFA86teX3xPepUC6AwO0TZpWOIr+A84QEuxxkvi1gi3JnCbGRAvxdLs5L6lVHZFz7nDpI5G2i7Ko9xZU8Iq0XHhTmerEN47kGDhIT4Z7hpsqAas5B2mPBOXbpUYaVT+pgzRgjttqvC449qHnD/zxfpC+aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(6512007)(316002)(66476007)(66946007)(66556008)(2906002)(6666004)(9686003)(15650500001)(8676002)(8936002)(86362001)(83380400001)(5660300002)(26005)(186003)(16526019)(2616005)(6506007)(956004)(6486002)(478600001)(52116002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uiLxsUrlBwrIx9kv6vYWTCoCtISn2PzqHsjJBUdd+M5ncQ02r2JUeR9a/BHGnxX4GePJfye8zNpLw30NL34nu+xGpTSGVtA1MhkegrGTU6dBOUXj1hDzwwQsk7GkWY0Gwz1FM0MAtfET6lSTfxMx9SP+VLPtuN4EGaCkFiHT/kvyQ6iG4QFUx9lWSSz3I6CgLkq6C62Q2ZKStNrScEXEfuLG2uXeAhi6EIMq9EOwiDSSFksBrsWNu3VEScRS3HeslB07uM3mgMYnN/tG/PIeGcMVIhnaoApO1Up7tG0rebij9XxOoAnJ67g4ynnCj4LbXr4zJJiSx8r/BzmnR2ziKcTa9NIA3jJQXJCQMHuuhh+yMx9CO+89W8x5EbKb2CMqgv4hmvnI3da7qRaKDEBG9+MfZnhsWN82katfAgh0HMFu5KVFL8ydQAXDGPNkKCmDgHHmvIW1J49nU85hcFeS3Ff6FZLF1CbOfYfcjCNq9h0=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a9ba40-6bf9-4b21-4f43-08d82c8c2b9c
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:06:21.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2S0ANp9As7EYF0qiseZy4LaU3xUBnazUmoCDaoWkN/X7OLOrHg7r77GXlT4GL8PziD+ve1hcswlOzjJjwjE4RzA50iDL9VlXs6Miiukf2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@nxp.com>

The word of a message can arrive in any order and the current driver
cannot receive more than 4-word message.

To fix this, a new variable rx_pos is added to imx_sc_chan structure
to save the position at which the word receive must be stored.

The position is initialized by the index of the channel.

The position is incremented by SCU_MU_RX_CHAN_NUM each time a word
is received on the channel.

This allow the words to be received in any order and be stored in
the expected order.

Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 2ab0482..7c13595 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2018 NXP
+ * Copyright 2018,2020 NXP
  *  Author: Dong Aisheng <aisheng.dong@nxp.com>
  *
  * Implementation of the SCU IPC functions using MUs (client side).
@@ -19,6 +19,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#define SCU_MU_TX_CHAN_NUM		4
+#define SCU_MU_RX_CHAN_NUM		4
 #define SCU_MU_CHAN_NUM		8
 #define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
 
@@ -29,6 +31,7 @@ struct imx_sc_chan {
 	struct mbox_chan *ch;
 	int idx;
 	struct completion tx_done;
+	u8 rx_pos;
 };
 
 struct imx_sc_ipc {
@@ -136,16 +139,14 @@ static void imx_scu_rx_callback(struct mbox_client *c, void *msg)
 		return;
 	}
 
-	if (sc_chan->idx == 0) {
+	if (sc_chan->rx_pos == 0) {
 		hdr = msg;
 		sc_ipc->rx_size = hdr->size;
 		dev_dbg(sc_ipc->dev, "msg rx size %u\n", sc_ipc->rx_size);
-		if (sc_ipc->rx_size > 4)
-			dev_warn(sc_ipc->dev, "RPC does not support receiving over 4 words: %u\n",
-				 sc_ipc->rx_size);
 	}
 
-	sc_ipc->msg[sc_chan->idx] = *data;
+	sc_ipc->msg[sc_chan->rx_pos] = *data;
+	sc_chan->rx_pos += SCU_MU_RX_CHAN_NUM;
 	sc_ipc->count++;
 
 	dev_dbg(sc_ipc->dev, "mu %u msg %u 0x%x\n", sc_chan->idx,
@@ -205,6 +206,7 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 	uint8_t saved_svc, saved_func;
 	struct imx_sc_rpc_msg *hdr;
 	int ret;
+	int i;
 
 	if (WARN_ON(!sc_ipc || !msg))
 		return -EINVAL;
@@ -212,6 +214,13 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 	mutex_lock(&sc_ipc->lock);
 	reinit_completion(&sc_ipc->done);
 
+	/* Set the indexes for the reception chans */
+	for (i = SCU_MU_TX_CHAN_NUM; i < SCU_MU_CHAN_NUM; i++) {
+		struct imx_sc_chan *sc_chan = &sc_ipc->chans[i];
+
+		sc_chan->rx_pos = sc_chan->idx;
+	}
+
 	if (have_resp) {
 		sc_ipc->msg = msg;
 		saved_svc = ((struct imx_sc_rpc_msg *)msg)->svc;
-- 
2.7.4

