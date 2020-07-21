Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915B2C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AB620771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k7BJmxtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgGUPUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:20:49 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:28932
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729956AbgGUPUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhJSuvQzAQQwOp0I6qJOjjjiKfQKm1fGLZSJBb/MLf8gDKaIvHjKYSffPlsNNzZYqIeRQbBbWi5zZlxaB/t3JdUI2kBN8tT3G/7s8udfkLtKL8bVl3OqSSgXgjYbDS4m5I9rYAl9Y3ZepJeAZAzkv1s1P2BzPRB+HjzD87oqtJV5DH9tsv+Rgk7mEdgBN9kSz3fK0GiUw7+hjCmRxSwJxwOVbByksdc1r6RW2DRioP0J1y+E628XkwpDAwikOZKUC+Ilf/PNCtziu6Z6K2JUBWgUaxZ1L5tnma3fquJSvuDwEi3sT7H3NsbvS0vvf4ueluHxKwQRBqxruhxAxnP29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ajs6yQuOneFx93R2iCmlcyF8vfv3RlN+QzGOvp0UJD0=;
 b=U7gbDc6y8Wb5BQnmW9aEdLAbnOM4j7HHBTtfmOyIlcfmReYjr0rG2RaM/IJp7UZegDz1ClaoL5zOQUMtbo0HpvoEZTBdpEsmt17lIL9JgRbO/k4YPtLGCVGeytFzGRlqTKD4eZgwNjlvfbH/twLQJSVaiog9hKKUtUMOhp4jd5RDVSJfMqh908oeTw3Jd4I0lpxSQsACB1sNYWWhHgtBlz3tedXlid6w8yCOJXEwtN3gf0BVkQT/11IQFuEm9geQV1Pnzvy2Ff8C9lH1WFFQGcIv9WmeiPTHHSMxQ5eJG+CynJi4+hngcvmyV8UW92Wjf5q+q5CO4NEB7YN+iMDLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ajs6yQuOneFx93R2iCmlcyF8vfv3RlN+QzGOvp0UJD0=;
 b=k7BJmxtJzeo5jQp5Yz8+wDaPxaulIdAidmRQtKz7bv6aqYilSTcdiBLCWCcWWKM41I6/YVTdm5AEQt3/7qmK6/R6BKwALovfYYjIIqHsBi6UO3dA5AEKmaxHIq0Jj0xX1s/CiN3Ol2Rau8dlU7nbwQyKxgjaauRZOwPO2wsY7to=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB6212.eurprd04.prod.outlook.com
 (2603:10a6:208:148::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 15:20:39 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 15:20:39 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v2 2/5] firmware: imx: scu-irq: Add API to retrieve status of IRQ
Date:   Tue, 21 Jul 2020 17:20:32 +0200
Message-Id: <1595344835-67746-3-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.21 via Frontend Transport; Tue, 21 Jul 2020 15:20:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: affcb39f-3f6d-4aae-65f8-08d82d89a029
X-MS-TrafficTypeDiagnostic: AM0PR04MB6212:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6212239BFC20BFCAAA9C53D9D3780@AM0PR04MB6212.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJMoTBcjdzis6JnQ57yk4xdFZDbfao2BVwEUyuuNG3YMWvN3YopxUVzYZqO4yNocGs+ORKNuyr2C5RnTT8sD6x36DtC6R/NkKoeda2KHE/lkzbKHNIquyNsWq80R5fx2aWSz0WpEzkUuexyWT09zn47Tb19JasCxk50O4KaB9nYzVXDBthDibWCi1yb3CgXEkajSqIBa9pku1+SpvJor/g9b2s5ta5JZquqhMWMNe/MQD4UAPRcCVObuKg7nuS1d0i3u4T4V0toqMP37SVrcdksJ96y1wx/gCDk6bQkzNDc0h6MpeFIRhgpvyHkRRuO1h2TK7PteDnOh038GT4QvnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(2906002)(8936002)(8676002)(86362001)(66476007)(66556008)(316002)(6506007)(66946007)(52116002)(186003)(26005)(6486002)(4326008)(2616005)(956004)(6666004)(9686003)(6512007)(478600001)(83380400001)(16526019)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PzY/h5EZjQS8TFX4SxQR1SoUhOsVGbrq6ubY+SWG9mGHIgB2HRA2MtPlGuHJS1ksosecGqmeyjdEj7O/9NYAf+qW4aRi+8F5gEaCROSnzxbD2E7VV/NGEzT6JQ/xe7SIK1w2BzIzK7FJrov+i+csIJw3/LMpTVC6Dh4S/qWcV9I0SE4hCm7PL6uwo94k3/BOsV1qhmuiOz4TA96dXt47kPq+wlWh83QSEpy21zVL8KpTA1LqlqI1lHnXj8T/db6rYTX6yYgQddxBJpaGCzEmIqDvu0N0bQHmvge+fWX/H34kcJbDNHcMbFe5lWc9iuw+ZnV96hzUv1zat0idIEYRa4Ud7sADinpcYYp6d5e7++N/k2FOV7GgUVSo2BD6XrjYErHnEKTcgcKEYGZETF6kL2GXDFxXIPiEXGhOmLgAhgZYkAxnrSjsVxugCxwgTwEssZP9rr6PB4HFOwvHbYvsTkMWza5FfrKJB9BYIJce4X4=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affcb39f-3f6d-4aae-65f8-08d82d89a029
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 15:20:39.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeguVWufMgbJa3wKl3CSeJwZQgKu8ZhQKiK0okKne65HwdmkC16vFmdESJkS33vz9IDHEuNfzyVaybqcSHSgA7IojKlaJBAgEVR99frihrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

This patch adds the API to retrieve the status of an IRQ.

It also adds values used to process SECVIO IRQ from the SCU.

Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 37 ++++++++++++++++++++++++++++++++++++-
 include/linux/firmware/imx/sci.h   |  4 ++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index d9dcc20..d31d600 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2019 NXP
+ * Copyright 2019-2020 NXP
  *
  * Implementation of the SCU IRQ functions using MU.
  *
@@ -97,6 +97,41 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
 	}
 }
 
+/**
+ * imx_scu_irq_get_status() - Get the status of the IRQs of a group
+ *
+ * @group: The group of IRQ to retrieve status
+ * @irq_status: Status of the IRQs retrieved
+ *
+ * Return:
+ * 0 - OK
+ * < 0 - error.
+ */
+int imx_scu_irq_get_status(u8 group, u32 *irq_status)
+{
+	struct imx_sc_msg_irq_get_status msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_IRQ;
+	hdr->func = IMX_SC_IRQ_FUNC_STATUS;
+	hdr->size = 2;
+
+	msg.data.req.resource = mu_resource_id;
+	msg.data.req.group = group;
+
+	ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
+	if (ret)
+		return ret;
+
+	if (irq_status)
+		*irq_status = msg.data.resp.status;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_scu_irq_get_status);
+
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 {
 	struct imx_sc_msg_irq_enable msg;
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 914dce1..20a16a7 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -17,9 +17,13 @@
 #include <linux/firmware/imx/svc/rm.h>
 #include <linux/firmware/imx/svc/seco.h>
 
+#define IMX_SC_IRQ_GROUP_WAKE       3U /* Wakeup interrupts */
+#define IMX_SC_IRQ_SECVIO            BIT(6)    /* Security violation */
+
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
 int imx_scu_soc_init(struct device *dev);
+int imx_scu_irq_get_status(u8 group, u32 *irq_status);
 #endif /* _SC_SCI_H */
-- 
2.7.4

