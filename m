Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F3DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2157020656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EyXNAWiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGHHgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:36:40 -0400
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:42049
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726306AbgGHHgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:36:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+qpoLtFeRc8IWJ9kwp0cYCv3SDfu11u+tZGh7r4qLZTfgQu8+SvnerpG1KxWVIpUhxCA8O+07UmFU+Uc1YpfFNA2t9oqBuKlvT1ApAsyNRXXJMhzrE7I6rrprdLqlfxEvFz9OL8cPSZ+7sFlzGpF3/2bXdUZhn2AlzxCqlolCW0Lg+qFVKz4C1X1Bllhj3o8IZ30udUbjMZxyAwttStxbrLNxaq31KFcpLq4EhLE3Kc7bx6dz+9cBf1hD0DwDxeCqR2UDuBdkM4UMTSi2yiThEwnlAZW6RQe0OxzyxVbPCRfNc3MM9BEX0m43IlLGtREYl+twuQBdFGRmoCKrz2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx+fvUeueNs7OsvsFQZr7T8aAABL4CCpTJI7Pg02XHA=;
 b=KiKgB/AWh/20WVfn/CTNyDV0XU2f/RD1h639/QB5n+wy/61A2hOj5Xq750/olln19JILWHjcnp17hBZZuK7L+wY44IQNAqvfYJhvgbkXMMktQI+9Rwe69vCS1peRDYE6SNt3UDNKV9bDPvyfOuIYq+0yYMTEjJrwQOcQ7XBcIoQjKj3r+F1YciXkfKWpXeEbl5tTKinzEUJqcTOgIut9arazUJ3pbvibhXTG+GNANV12zuHC7/VLS59kmVyRwyx9gyjaZIesephqe4EUhLO7iTJ8cy5JUa4eHEeb2LebOsHX9jatpQU3ZrhQxl9H2OFKKINZ9yMluDnr4oaLejFSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx+fvUeueNs7OsvsFQZr7T8aAABL4CCpTJI7Pg02XHA=;
 b=EyXNAWiUubtnd9azdK/AIjhpyrCjc1U5fdPD/NDerC9frQJp6SNRy9smJbA6BATfYZX6HkrmoKKJTTXY75TUooL4KDjG2HGrUnyr4ZyiQhCCcbNoXyzsGt1C5JOxIC9J/8QAu2WEinMkwq95WLW/50HT0Vca9M/IUluslbQmuCM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VE1PR04MB6734.eurprd04.prod.outlook.com
 (2603:10a6:803:121::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 07:36:31 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 07:36:31 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org, kernel@pengutronix.de
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux@rempel-privat.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] firmware: imx-dsp: Export functions to request/free channels
Date:   Wed,  8 Jul 2020 10:35:56 +0300
Message-Id: <20200708073556.19188-4-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708073556.19188-1-daniel.baluta@oss.nxp.com>
References: <20200708073556.19188-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::20) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Wed, 8 Jul 2020 07:36:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83be978c-7aad-4f9a-ff30-08d82311a1c0
X-MS-TrafficTypeDiagnostic: VE1PR04MB6734:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB67345392D9932881906E9A32B8670@VE1PR04MB6734.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CHu0demtKQnLWfIRI8TKRFC1yIp2v3cjs3whQTmJY3YidIUmK6gEnx8Y6F2v1mcR6asgXFjaiEdnHQS40JqBgZiBPq6JgI9u0P59TSNb5iFuk8JrJeaYTJPqgdq52qcXMXjnx8+OJigi2c67eTdWAJUnJ6D4g9WoY+PDXjoQBHonmHbBfXEoS5oMrofJDJeeaEBByQ2AGWTCGLx+1+wSHoodrsIyd7zsUhz3WwX6ZWjAUGe34eAIHpysQ/xuQoxLbSKvHXtPdnm8aZFRvrnmW5aPd1Tx4P9A+X5RMmpXZ8Z1lMjPhzO9cUmZSiJhSlqEtNV377zk7g+OGAQt3ka5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(83380400001)(26005)(8936002)(4326008)(186003)(6512007)(16526019)(86362001)(8676002)(66476007)(66556008)(6506007)(6486002)(52116002)(478600001)(316002)(66946007)(1076003)(6666004)(44832011)(956004)(2616005)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 18jxE88tqGKa6ukKk65SMz37trM+A/pr+lQiX7sVmRXGewXHG8WSDgKZ/8Rdq9otcj0PCrAF3eppq90MC4MsiFWuo8jozcGPTL0cq9jXYSXpKnf7BTD9LnTqqHO0EFri/GzPPVEYYdJsOX53jyljj3InsDSZFsi7c0LWDit6lfi1hCOPmuI/og+Qn+7+OA/l6DfnP3Wk6oYm4I/G68d7araNnUIKj4pPgWggwAtLkxVvQ1QCwmWpTZlzpCv5+W4ac9N66IurZIALUdTDWD+mDqeeOMqTnfhBCKT+SQi7TvTTx9LDE2T0ZYSkSvCesB4hO6C/W9dZOXxodb1+JM7q3PO6wFpdL5FnKdtBELNmB2XSx9k0ELTMPcsHfw7kUJlAzI+bnSnbe/Obe2ssvz3TY//yLeJKuFh3IaUq8bsaHaT2yDR36qOgaWcYekBU5Ln1xVkrz/tNY29Cyal7VO2enVEkuhGMprK4I4K11vMuexQ=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83be978c-7aad-4f9a-ff30-08d82311a1c0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 07:36:31.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8MFjRQctFMtIEig/WPBv3HN1OIJbAaRzB9wX3yjnDvqrraWjTLLubqLHFTL606FLygPCQGljN6DOabST7K4mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

In order to save power, we only need to request a channel
when the communication with the DSP active.

For this we export the following functions:
	- imx_dsp_request_channel, gets a channel with a given index
	- imx_dsp_free_channel, frees a channel with a given index

Notice that we still request channels at probe to support devices
that do not have PM callbacks implemented.

More explanations about why requesting a channel has an effect
on power savings:
 - requesting an mailbox channel will call mailbox's startup
   function.
 - startup function calls pm_runtime_get_sync which increments device
   usage count and will keep the device active. Specifically, mailbox
   clock will be always ON when a mailbox channel is requested.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/imx-dsp.c   | 25 +++++++++++++++++++++++++
 include/linux/firmware/imx/dsp.h | 10 ++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index b6e95d6d34c0..a6c06d7476c3 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -60,6 +60,31 @@ static void imx_dsp_handle_rx(struct mbox_client *c, void *msg)
 	}
 }
 
+struct mbox_chan *imx_dsp_request_channel(struct imx_dsp_ipc *dsp_ipc, int idx)
+{
+	struct imx_dsp_chan *dsp_chan;
+
+	if (idx >= DSP_MU_CHAN_NUM)
+		return ERR_PTR(-EINVAL);
+
+	dsp_chan = &dsp_ipc->chans[idx];
+	dsp_chan->ch = mbox_request_channel_byname(&dsp_chan->cl, dsp_chan->name);
+	return dsp_chan->ch;
+}
+EXPORT_SYMBOL(imx_dsp_request_channel);
+
+void imx_dsp_free_channel(struct imx_dsp_ipc *dsp_ipc, int idx)
+{
+	struct imx_dsp_chan *dsp_chan;
+
+	if (idx >= DSP_MU_CHAN_NUM)
+		return;
+
+	dsp_chan = &dsp_ipc->chans[idx];
+	mbox_free_channel(dsp_chan->ch);
+}
+EXPORT_SYMBOL(imx_dsp_free_channel);
+
 static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 {
 	struct device *dev = dsp_ipc->dev;
diff --git a/include/linux/firmware/imx/dsp.h b/include/linux/firmware/imx/dsp.h
index 7562099c9e46..4f7895a3b73c 100644
--- a/include/linux/firmware/imx/dsp.h
+++ b/include/linux/firmware/imx/dsp.h
@@ -55,6 +55,9 @@ static inline void *imx_dsp_get_data(struct imx_dsp_ipc *ipc)
 
 int imx_dsp_ring_doorbell(struct imx_dsp_ipc *dsp, unsigned int chan_idx);
 
+struct mbox_chan *imx_dsp_request_channel(struct imx_dsp_ipc *ipc, int idx);
+void imx_dsp_free_channel(struct imx_dsp_ipc *ipc, int idx);
+
 #else
 
 static inline int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc,
@@ -63,5 +66,12 @@ static inline int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc,
 	return -ENOTSUPP;
 }
 
+struct mbox_chan *imx_dsp_request_channel(struct imx_dsp_ipc *ipc, int idx)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+void imx_dsp_free_channel(struct imx_dsp_ipc *ipc, int idx) { }
+
 #endif
 #endif /* _IMX_DSP_IPC_H */
-- 
2.17.1

