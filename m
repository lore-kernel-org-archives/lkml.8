Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E01C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25B42072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BzVpY7uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgCSRtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:49:45 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:30743
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbgCSRtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:49:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyRj3AdO73FguaAdYWBsvIVeYOO7Pc+PgxB9xHq9e5abbb+BG/owQzLAdrpaUweeQmIhxX1cd9hEnUDMBB6HHk1BoYN/JNZ8LVK1FebCMXvIoPaAR1JqyDGoNnP2lpAihYbnUDa3LGgpWtQH+XA+Z7xYi4je/q6JnLg2GUB5Y4CD6kWCnCmARtsBEeFJHfEkjLJmf/gjB+kdHwGIRPncs1Wb3mUQbkFXrFcN5wCpKUsfDnqPXgTM0sRUGhSO6rHacmelhtT752dbLBxUhGKDxWHCSuUEkx2tmbotIaL3LisvSideTAaxjQF8tQSIL0uinSBll/ZMQB7Ase+RFCVqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXhzLOLUU6LYrtW9uKKeLd3cEojRIkU1ublRUAXSu4w=;
 b=HdYpqfHX7AfVrokWgs/UJVKpMoNarbI2oryYYgLjJ7GGn6emPhwoDg8jRlgya/93Lza4VotEeKJtFI11Q2bU0IQyQDxMiBzzcs8N87Z+WXWTSXkYnUCE3z9ONa/C3wQZbEMMi5rhkJjE2Ln51uh4zZvxBjqZGFUKyvPUmMgxM6QC8R387rDBZ/i2+cQt2wOa3mSA7nn5osTh/4a6piN1Y56bJ0WPIFY1JjUQQm6kHj4jp7XBtLYiEqA5YeNeTlOeVFFQAh/PA/OJ8q7j1y2m+0A/5GGLzr5+s3+wNaBmkGbNIQ1icCAcJkVs6uEkaZBLRnkh8VtVXYU+WQyqNU6Ewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXhzLOLUU6LYrtW9uKKeLd3cEojRIkU1ublRUAXSu4w=;
 b=BzVpY7uz5TXTjeq5+xPvoR5mqT4cdu4ENwbiDnzsEqw8wYOCXZp7GNgzQMAlVFV7taR6Af3PJOf09+bCV1tokWY/dyoHMisKcZsUXsW/jwtayQvet07onay+lynyNjkrWwxNrr3ARviIUiVakX62IOYFxbKaL3iGlEWPE6J9m4I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3646.eurprd04.prod.outlook.com (52.134.13.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Thu, 19 Mar 2020 17:49:36 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0%7]) with mapi id 15.20.2835.017; Thu, 19 Mar 2020
 17:49:36 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     rdunlap@infradead.org, jassisinghbrar@gmail.com
Cc:     leonard.crestez@nxp.com, aisheng.dong@nxp.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND PATCH] mailbox: Add dummy mailbox API implementation
Date:   Thu, 19 Mar 2020 19:49:21 +0200
Message-Id: <20200319174921.18787-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0011.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::24) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM0PR07CA0011.eurprd07.prod.outlook.com (2603:10a6:208:ac::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.8 via Frontend Transport; Thu, 19 Mar 2020 17:49:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5d5b01e-2eb6-4b4a-8c58-08d7cc2de381
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3646:|VI1PR0402MB3646:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB364682EBE244D45B1771FA9EB8F40@VI1PR0402MB3646.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(4326008)(2906002)(2616005)(26005)(15650500001)(5660300002)(16526019)(186003)(6666004)(478600001)(1076003)(6486002)(956004)(44832011)(52116002)(6506007)(316002)(66476007)(6512007)(66556008)(8676002)(66946007)(8936002)(81166006)(86362001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3646;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2DDavcVYXZOmgYJ7klRgLgL/vehGt43Oyoe6qrcK6mCdQBUe+6S80k6DF7SKsyxvzseeldqcb+OrKA/2oB2y180fBekqseTfGY+KzAtNjOZ+90WogPNOdp9vPIBxPlvrf3NqeFzCGaGr7sm7YE12dNwgmsReRuajPM+x0bsGjouZQtQDsroZYZMOSD/CRfVHIlzqxKtnAUtpVd5mr+Z3Ay+0d8m59Ee9ju0rqRLALRiFa20LWp/Pj6zJsVLEs0OR1kgtlx9zCUAEoXfMLS3eYofpfye6XZ3iX5GjGjgWtuwQ5yZrxbn1mSI7D00gNp90NNK1NBwGcD2z7zb35iqYT5gzReiz0N7ae4WOWp9s1vW1UMWyCHWvrp7nB+AmLf7V0EYhUs8cE6kllACTGsxRbnNnQbny0CGcBaan0rGS5QrBMnu1CSOKag539ls3ZCpr
X-MS-Exchange-AntiSpam-MessageData: 8zAYQIrMopdAsBMlxcpJxilwHjuma7zFu9wPD2aN5SVdkJGJ22NmXB4djjVW+ka7ffmeA1HRGxQZXTA/HUmCucWpGQwtbHP2Liw40MRmJd7JGVEP4k5dnUe5jeGg8npViwJvye+GQJesCxH/v3DHnQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d5b01e-2eb6-4b4a-8c58-08d7cc2de381
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 17:49:36.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGeN4wfo5+TY5L2W7aeuc7ty/otiPgk+loNJ5ijzze+MDlxoZ9+PuQhh8Oamr6tSnHZlpEMO+m7HBqJwEdjzSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3646
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

There are users of mailbox API that could be enabled
via COMPILE_TEST without select CONFIG_MAILBOX.

In such cases we got compilation errors, like these:

ld: drivers/firmware/imx/imx-scu.o: in function `imx_scu_probe':
imx-scu.c:(.text+0x25e): undefined reference to
`mbox_request_channel_byname'
ld: drivers/firmware/imx/imx-scu.o: in function `imx_scu_call_rpc':
imx-scu.c:(.text+0x4b8): undefined reference to `mbox_send_message'
ld: drivers/firmware/imx/imx-scu-irq.o: in function
`imx_scu_enable_general_irq_channel':
imx-scu-irq.c:(.text+0x34d): undefined reference to
`mbox_request_channel_byname'

Fix this by implementing dummy mailbox API when CONFIG_MAILBOX is not
set.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
resend adding Jassi's email

 include/linux/mailbox_client.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 65229a45590f..ab5d130f0b5c 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -37,6 +37,7 @@ struct mbox_client {
 	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
 };
 
+#ifdef CONFIG_MAILBOX
 struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 					      const char *name);
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
@@ -46,4 +47,37 @@ void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
 bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
 void mbox_free_channel(struct mbox_chan *chan); /* may sleep */
 
+#else
+static inline
+struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
+					      const char *name)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline
+struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline int mbox_send_message(struct mbox_chan *chan, void *mssg)
+{
+	return -ENOTSUPP;
+}
+
+static inline int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
+{
+	return -ENOTSUPP;
+}
+
+static inline void mbox_client_txdone(struct mbox_chan *chan, int r) { }
+
+static inline bool mbox_client_peek_data(struct mbox_chan *chan)
+{
+	return false;
+}
+
+static inline void mbox_free_channel(struct mbox_chan *chan) { }
+#endif
 #endif /* __MAILBOX_CLIENT_H */
-- 
2.17.1

