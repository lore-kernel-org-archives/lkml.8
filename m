Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D0C2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZSEvaURB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgCCHtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:49:33 -0500
Received: from mail-db8eur05on2078.outbound.protection.outlook.com ([40.107.20.78]:6126
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727552AbgCCHtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:49:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaeBM7ih6PD2wpxf6GHyGoRniTqB/xnjBxcPLAj6ZQU66hYmK8FQ4XpRXhgYM4U+zXn0tR5kIq07i934HMnZvQqNLoewLh9b0QftRMb/LMSW46NUHQhkfX7cL5PD8qJ3SHwl86dyvjQJvTw5yllnC3PxeSSBMNo7BHp2769gvqcGjNpyXlJEn9LI2mTbJ+ldN1MvX/fjAwtrevg5VtPhBcUSQvRleWmgLWDGS58mUij0MyixVVJJgHF9TabzPPbrJCwU914t78AYOTAx7c4XrRg0Qwl38WX/3gg3B2Y0nTX+ojftRDKhG5VlUCXBuFG6yZdhl+mMnIxZ+lpBKcjG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTh1fa/8iZntB+c8DdyJjM+yT5Mzn4MmJJ6QW5rB08w=;
 b=GIARLsriA4exJ/0EekhwBfqBnv8kIUixWyWofrCx/0CfpVY+130Sfz/eSwNImzbR8dTB5TLaNKUXps9S1mxzBEKuP1k3lEW1kwMAVhOjNcMKOIqiTOnZDbU+xUPMFjT0cd0EMQADRWvREpYzQB0mCPAt8vGsITyeBvXxf3JxfGRecREXdHqOhEXyOaajulcIP+m0QX2eNhlS65crp0dWhYPjO3HxjTDnHCfwttU8RA97mSq2j+TkPnVKQZoVl+1VtkaQ6MjbGjSbbu2rD5NyvI6p7A3tENzxIsseCpEBNK5nbvUOjSpTINNcSSAh+jJTI6SSQCiFE2Dh2zsuBNLEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTh1fa/8iZntB+c8DdyJjM+yT5Mzn4MmJJ6QW5rB08w=;
 b=ZSEvaURBzplglAlK/NQbVVveAzyGltMy4knQuKuXD+s0W6xUpkUbWYQfs2C8ilpKcLask7TpPenDLiG1IkZX2p2yKfrLPqtgTlQrRXDnSKU3oXn0vgZJ5GsIWtwk2B9XCw5qVuYD96PN6SF3k5i3l5jmFWMfxTUYTN0Jgt/CQkg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4114.eurprd04.prod.outlook.com (52.134.94.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Tue, 3 Mar 2020 07:49:22 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 07:49:22 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 4/4] firmware: imx-scu: Support one TX and one RX
Date:   Tue,  3 Mar 2020 15:42:39 +0800
Message-Id: <1583221359-9285-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583221359-9285-1-git-send-email-peng.fan@nxp.com>
References: <1583221359-9285-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0250.apcprd06.prod.outlook.com (2603:1096:4:ac::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 07:49:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b54005e-cd5a-4a6d-36ee-08d7bf476322
X-MS-TrafficTypeDiagnostic: AM0PR04MB4114:|AM0PR04MB4114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4114395B1C58B437C6909CD988E40@AM0PR04MB4114.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(189003)(8936002)(69590400007)(52116002)(9686003)(6486002)(5660300002)(6512007)(8676002)(66946007)(81166006)(66556008)(66476007)(81156014)(26005)(36756003)(6666004)(956004)(478600001)(86362001)(4326008)(2906002)(2616005)(316002)(16526019)(6506007)(186003)(83323001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4114;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gz9I8vCn3QstAUt8VuA19Q/9xLBMCs7YnZzgD8EHh4r+xdc86j40m7n4xFaAapzG7ToB3ko1OpSmdJibE0aAmBmY3ANjenCSnbDWjR4/Vp6emo1U6+wvb5hHD2eBsVYPG3E7oDTisoHbA3EGbd2wySwiSL03m9DlP1gXDNJ1Sr75ARMRPxyMuOrgldMUdwKvwKnwNJTI69HsfufuvU7qqMFiz7XPNckGd1Nnr39ayYq3rwtIdQnKPLCKu6Ri+k+NkjLQXsEKog4cUKz8qwlitowRXdLn+P00i+VktP2nhLHhfn/VLLu16iuZ0Osx/LcKsZ3dJhs0fCsp7hsO0Tqk9+D+4q7fX3uhznInybYxMKUBzz9d1mCJD9nazwtVvzh8dtAWEusYxc4TIUJBxkXw8pCFncobKq1E6OMF51i6z9eoZoGIoo9f+grc6wph+pV+PhA/i5YJ8d2BC0pYEMzpQjZSKTWk0b4CvyUokqBZ8fHX/LR1iTPXUVdFL4L8F9AGsAQpl6JWXhoZ/ubfM2a/9Q==
X-MS-Exchange-AntiSpam-MessageData: BK2MOtM9yLWw3tcKUDAuVQHblGEx6plMnSqe0pdPDAdXBsLqHSYEbZVs9c2VkR0rgTqTBsQQGBaOt5noOIDo9t5EZ7JlGMRUSBIuYyCGXIKbV577wS6D0FowtbGWM775B6/utyMfgbApnCHXDcR9iw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b54005e-cd5a-4a6d-36ee-08d7bf476322
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 07:49:22.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgzQwxPgVZePptcwG/Fp6Xbhk3aGa1nbOxGD6c+5FTan93+0yDJqwl+XTjryFZxcbuhiKYaBBAdJ6kY+c7Ma5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4114
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

