Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF8C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA07A2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QabxsoiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGTJGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:06:37 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:23200
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTJGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:06:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7jg0KldnLkHrvv3VP5lBHPe1MF6kc+AHYUgdtg/t1c8Bm9cmgyWT6/dX8OQIw4zlWrNjM3gsdbgGze9OOT10gTkQbnYva1hXE9WjDpGIwh4ZuG+GUtTjbMERIyRYNOmmM4yo+4obisB7TnpafEtt0gc7S6BUWgTG32Q7TCiK2wFjy3h1+skAUN9FbWur0XRCQvFc/3qSb00t5XkhZVqsMtMfX2/IMNxkTRzNmu0Z97G2xvEb3gmMDPCTBvsv+P9R+aSTXTfy4dPO9FgIJkU0eeE75yjWlzt/OEY3qzZ9Q/WG5GFfsonrnPs5QzDOrAQ/uaB5TJja/mZmQnZqyWZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4tkTVJhaQJgyRDVhhwmuMUkig9/nJ7H48p80baDRGc=;
 b=XJQABKjdEHJhDQRbQqMj1sCg/16OiSnaI+SeZG4XTl6V0qZeC/yAL2d3AFKZbFyJqcSaM+yVyx3GixAtCDruhKkoLvCPVVxj+DM/x7W2Xpa/HEJXklFWAiQndB+7oMpb4/b/ZAEyPmcisxFEIPU3fT+YR/rS+ouv52FgyLHtq72U3dOBKQ0oGf+TFogZ4mqAkRUYfkMO16/nLzepZ1ZF8ceGS3YYA3wZb20QColfOInVhpFGfkNkwUd2bZObnSo1AGHCfuZUcYth7Bdt8nkTwGib6BJ0ZUQJmXHPduImIsUxrjiONBcY1a6feLSESkbl30Tp0Ad3NbrZgTgsGQhLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4tkTVJhaQJgyRDVhhwmuMUkig9/nJ7H48p80baDRGc=;
 b=QabxsoiYGK70lQzUMszk09vUPynH+YORHHdIDXbH1cA760pzOD2ilAStrRcaZ3P9J/fDlX+sM920dy/y08rzBY9N3pvfPFSlDAW0DhxdNcqFBO0CglcHbzCoAZu9VSv0WgaUzsFTNK++IZSQKmpmAQ0PeTJHIQH4N9qYtTdyCT0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR0402MB3762.eurprd04.prod.outlook.com
 (2603:10a6:208:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 09:06:23 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:06:23 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH 4/7] firmware: imx: scu-irq: Add API to retrieve status of IRQ
Date:   Mon, 20 Jul 2020 11:06:14 +0200
Message-Id: <1595235977-106241-5-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 09:06:22 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc80cd42-f709-4a1d-f569-08d82c8c2ce8
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3762B03B98484BD381E977C6D37B0@AM0PR0402MB3762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEHLTrrlNKfq1NOWiYa+vBxcQ8ZrfATja6z3ezsRH0v0+yxeaOYtsleTIKUqrGNfPJQwfgkiPRxn5fmuctYfJcpoPWdrGczxY6RjanMgAH5145ygYvHqJajAdWndyz4Vz6O4vl6wrddwp63hvVcD4X8IbNNKQvv4mKB8eTOEV6h1B6nCtHXNxMfQkxw7IwrFBOJB2zmoelrQIHEpaIwGyWueddRVyMMT/OZJZt99nS2IYJv1cO+kTYyiAqt6rIqSfjRXQjQ6vPJ3cy7glKt5D4a0cotcIG3Emz3ZiCgQUe8uY3+ACBjXqDuE2u6Aac32NJzc1qCwjUFGKCWTtKXjJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(6512007)(316002)(66476007)(66946007)(66556008)(2906002)(6666004)(9686003)(8676002)(8936002)(86362001)(83380400001)(5660300002)(26005)(186003)(16526019)(2616005)(6506007)(956004)(6486002)(478600001)(52116002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: a3ltl6OX+LAOv9PblBoivGfdt9iqntoQ5pfFK7qU2O3s7EimLyXyMphGbNC5PXB3bNs0LEHx/RtNY1t6ttKna36uyjrDTcsFgNqPJyPnoLuQ33WbXGxa2BtcauYxdVTR4LFa9xQQzsWDb5fNYBFw8r70gqNGXMmg5IdWkqZBvhX0VeBSZYDOS4wDY78GuuGCAaxFtNtC5RawaH9JpDnaTrg5EeK5UltJHofFu1901vOKPWeyHqqJvjdiXdgkePhIMY4/lAlKWBdbkTGrTlEYbaseJGNHaL4oFtDowu3KIbcVK8gci/AhQ4Zjk9E20FX+OmDvSZkCXcHl1a2Nv9v8aja6yJ0IIZ2TPossg7JrZMJevDe3JcDu6qn25TQIAKg2vWYhIbP4SbTk5JTw6HeRmxeWwLC0tLfYEnbtYwGhNZjG0o8qNR1Kp86SDhwpTshR3UZXs3hTHTNin7rviU2zCDqQn+0euqZ3GNRV/sNCLjw=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc80cd42-f709-4a1d-f569-08d82c8c2ce8
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:06:23.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpQ52HhxwrSck5wTO6Emz/tdHrdX1PGv042EyER7fwvqI0PiHWMlRRW+xZL+/xn+Z9/M8l6ihX5YayicQzGps21C6b7EEWMJ88fRRO3Nx/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3762
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
index db655e8..4de6486 100644
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
@@ -95,6 +95,41 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
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
index 97245e5..a27d069 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -17,8 +17,12 @@
 #include <linux/firmware/imx/svc/rm.h>
 #include <linux/firmware/imx/svc/seco.h>
 
+#define IMX_SC_IRQ_GROUP_WAKE       3U /* Wakeup interrupts */
+#define IMX_SC_IRQ_SECVIO            BIT(6)    /* Security violation */
+
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
+int imx_scu_irq_get_status(u8 group, u32 *irq_status);
 #endif /* _SC_SCI_H */
-- 
2.7.4

