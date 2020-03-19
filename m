Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF8C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D322820870
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="M9u7vMU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgCSRnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:43:08 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:34119
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727253AbgCSRnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:43:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1D4W0e9d9j5YWVipgd65r2+kd1X8iqisX0/4c1rTsY/+dLeFEYb4Os2NgHC5ZCu/u70IcsXYoT4STx8sLwdzfrVj8bhmlBvZYeTawT3idQyHQsWGppR2TMAV9NMQoyuc7Y+C0A1expgdLtggVQdfuRJwq6KvMKRuweHkNmybEBAvLoYXaD1wzBfxjkcgmKA8337WMj4xrxV5A62DzXN79bGitipmZFAOsjv92BPVV8JtS1r47Agubd8eSjFuFcxbV6sY+yNTS5AgauX2AkZ22p5E348+OHEtRHBLu35WaPFVxaFCOD6uvjkCoIpD7an1y8nHbbeJDjoObkkQc9kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj8hc9LWlsG/ltZ3AWPCvjhf1ZAou6l637POdDVCkLQ=;
 b=VJYlnLoR7r2ePk44ok3NHkE1XyuWk03axPLSM1mTTAQkmhZqM5pUVOnIIfaEs+2uqRYOdBe3EBoIECEHtXYDzluqSQ5HArb0FMrtp0SuTZhXdGBQuFrvG7090dTq+g7qQ/FXW3epu7ZbXsBbRhwMgBUuUQxlg/r+vPj2LlgdvjSWRmglRj6Ho5rK/k1Br7CFuBqUvjQNI/3YEloWZjFNIalG48954ZI9NmSgvH7iq4n61mrUKmfR+cL2YFsJH61l9MMaYnyzjnvrjfj224DvAhphd4GUPncBqRD7cDgMFHUqWva1Mp2hRV0Bg9WOCDVXcjuzQ0TO1oKvpFrw5AaXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj8hc9LWlsG/ltZ3AWPCvjhf1ZAou6l637POdDVCkLQ=;
 b=M9u7vMU7VmC+VCiQgD21WPamfo77EAVoNpfZw6M5wslVR2E6laxhHqnnXlWFWGwgXGFzYGUJ7a0YCG/ONUouUhIz2VZ1u9aNjX++TRGeWaTCOJg3onWIijJ5BgvANqU83gq8fz0fAHnWhbH+ArNwWdYAcbRDgFWbK0g/TqrIrBM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3646.eurprd04.prod.outlook.com (52.134.13.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Thu, 19 Mar 2020 17:43:03 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0%7]) with mapi id 15.20.2835.017; Thu, 19 Mar 2020
 17:43:03 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     rdunlap@infradead.org
Cc:     leonard.crestez@nxp.com, aisheng.dong@nxp.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] mailbox: Add dummy mailbox API implementation
Date:   Thu, 19 Mar 2020 19:42:29 +0200
Message-Id: <20200319174229.18663-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0149.eurprd04.prod.outlook.com (2603:10a6:207::33)
 To VI1PR0402MB3839.eurprd04.prod.outlook.com (2603:10a6:803:21::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM3PR04CA0149.eurprd04.prod.outlook.com (2603:10a6:207::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 17:43:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6201f99-be79-4e3c-6142-08d7cc2cf921
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3646:|VI1PR0402MB3646:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB364663C2E37A9E1899BEFCA3B8F40@VI1PR0402MB3646.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(44832011)(956004)(6506007)(52116002)(6486002)(6916009)(81166006)(8936002)(81156014)(86362001)(66946007)(66476007)(6512007)(66556008)(8676002)(316002)(4326008)(2616005)(26005)(2906002)(16526019)(186003)(6666004)(5660300002)(1076003)(478600001)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3646;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWk8LyCwMi20HigIJJ6Qozx5B+BNDWeqp3adNLDljMn8xo5KH+MpghoYuVrA4CT5B3OE5qL7Gm/hjl/PSwlepz5DBDv+rdAjXkGHE8tTZJW4hMn7b3M3MqXf+JcW+DU/9Ye7EWRsMIls8REZRY5yEPscaYNF/n4ET1mAWgPHBfWwRCa5sNC91RN084rtbVWFdGiT75JtZUKUraHouLQhF4ODMbzhB5Yke31ZdjSUp2hNf1cIKqCVbrl9FwF6IJB9P0fp3GJkSDqvzsLiA9zoxOhWP6QEH2qRCkeQPu0t2hkolZohLFSsjWdJj3BvFb9rsz9F6PQ5Q8SSBlRyBeDhEXCJp358nK4nqEeXVAexkdeGVttBft8v/79Lg8Woeq1RhKaeSuFwzjj/v2sKvRa0rmWdfEJALZPB40KHkcz+KlembZ3myWDhBjp8DKcmhttF
X-MS-Exchange-AntiSpam-MessageData: 4HyJw0i2MWIpQPqA9wIjLMXgpTMhjI8TScoGG3jlyGSpGiLK54vj60EaI7CaKGJihXo2GQhI3jCrPbfDAbqo9vmU+/1T4WWb9tTW8hm27EtX57epKnbwltFrTVJG99MCPbqCZkRQC0kFsRdN6UPWiw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6201f99-be79-4e3c-6142-08d7cc2cf921
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 17:43:03.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzoacF6ZiX/uU3Twdi3xw37UefJHbDCSpvhW27JTDNk5wEF3OEXDgcurf4xNbuy97AQp0urTozgRRW4vBdOjOw==
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

