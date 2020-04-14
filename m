Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0164C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D02B20575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eLYqT4XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbgDNNa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:30:58 -0400
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:38305
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387532AbgDNNac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:30:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfnyIPOjnS+K2eAH6k8e0Jy8YR42Hdw8TdVuRgvODbpRP8zDv57V7N7gdg8bCbnJ2viL7DhHrBFEP2kXknQKjZCxGpI7vcAnWoGLtBGiTuyBQF+8/Nk9BeK70is3JnTcX3zldiiSwzffYg3Wq+B2WrZDKMJRqMmz5LsEo0ZBgMQAB6DKKaLehHVXnTblmd++fOtF9KFxGgJVb5mvdQlYuE52KSXBbq/X67YpAupAkQcCTI3bHifm5YvwFF90ExoHzWm7ECLPaUki7asWcMBTvX5MR/ews/JoTkdczta4Jv0FpmJFfhQISpWce2LcwnRZrmo7sDa3hx63Nez4FkglIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uAdGOsTQb5zinhomZH/5peXtSCeeLOAzBrSdfh6ujs=;
 b=if3ZtJPpxn3rjjHqTfie2rPdDB/FxqIF/UP4TVcXXKtdVadIgrb1pIsL6u0jEr23Q6k1D+Qgz+R6w8rgWvEENOcBwMt2TjBnKmebypW1V5WJwO7XZ/WYL0WhDzT8R5l+PxhqHgXcL94q7EbDNH45hSw75XdF7oJ7xmDeXR83aZ5YLkThb2qGyOTqN6284lgBEQv8XxPJb4sqr6LtFMilFTvpwohxY5Bz5Bl4CdVUCDsLM5rJJ1b+dJ8mVe18ru/5LcjxA5PDHgFesnrZtk10UWbvMFBZln64d4Y54nYUpQDkVWYQl56bd6LoV6fpib4H19BqxofkgfL9Gy06bNp8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uAdGOsTQb5zinhomZH/5peXtSCeeLOAzBrSdfh6ujs=;
 b=eLYqT4XJRFwtbr/Dak8BI7jxuextEBk7m8HIN+P/KP32be8djthM2CJx/y9hRSpeYwV0HKZ5tPQm+rVOPYCnZxOSI0fgTuSi0EkqJDS+mx2ep1hHPkeV0gOcoCjvMIt1bk5Hg4nBg6gumMaeV+5kJWN2JIMtdOLm96dwE1Ok53E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB5233.eurprd04.prod.outlook.com (2603:10a6:208:c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Tue, 14 Apr
 2020 13:30:29 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 13:30:29 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] mailbox: imx-mailbox: fix scu msg header size check
Date:   Tue, 14 Apr 2020 21:21:15 +0800
Message-Id: <1586870475-32532-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR01CA0133.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 13:30:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff06ce7e-f123-417a-a65a-08d7e077ff89
X-MS-TrafficTypeDiagnostic: AM0PR04MB5233:|AM0PR04MB5233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB52331721C07079D1D540407E88DA0@AM0PR04MB5233.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(2906002)(4326008)(52116002)(15650500001)(81156014)(5660300002)(8936002)(186003)(8676002)(956004)(478600001)(2616005)(86362001)(66556008)(66476007)(66946007)(9686003)(6506007)(16526019)(6512007)(36756003)(69590400007)(6486002)(316002)(26005)(6666004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJSqiALtYWp+iqIvwD3xgYJMDYFdk2TPQSC/6j1/gEY6xQWCnkau0KFLJXEzws1uA6CrIeEeMXw7C/YXIRDDFbF4GGm2dBgsmRC5sIS8i8nGi6cAetzFLlqaGKCopKAknSDRrlp79nSrqQ/Wx5VrkEvQbFX1VK+pdZLGYNs7sGhVZkOnRUzIKhQ4egfFdCSBwUocXG49AyRWP3s7cp5fUFYOG7M84luKUXUSz2UV+bc47a57GnqAvybA9YgsgEG+XPTD/ndm6uBuoe0GQu8AzWgzHchxieTPU7yhfHq6gD4Yv8BROpXQob6OjXqxcqBQPThdRUl4C+BiSfxGbxKbbRSpF/MXSLM/vY77Ql3C+8D6Ylz9CrmGqPe8IMDsEG9Fw3Tw9cTvBgRAXi7ki27R3noXKU9ryjURGaF7jKEknMulN+P0CPQbcYBRVRnxt9CnlBLCsW449fQcS7EQ3CHzo5CechaWw6YfWrO337msSjsTADpNPY9mNUHlEqt0ohbQ
X-MS-Exchange-AntiSpam-MessageData: oZ4lEdn8uSStdAGhjvX50PMJk8kHFCbLAEvrVEg15cnSJvrlCgpjRedwStrkJsh6/BVUhN0at8GqI6/K3xn5WAdwn4e5a2pIXwmA96T7E69bVk4WZM+97ifx2oBOjp/sKIkdWkdtjqJJ0Sq6xMRkCQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff06ce7e-f123-417a-a65a-08d7e077ff89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 13:30:29.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BT95VsShvhH1jVK09PR3bwFcVYp6JOQDEZ6fnhi4r9y98QaU/EYKZWRUKpruK0QM4GRqGiZ1pNBHWMsPIDOsbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8 SCU message header size is the number of "u32" elements,
not "u8", so fix the check.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1461658 ("Memory - corruptions")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Drop parenthesis, add comment, update err msg.

 drivers/mailbox/imx-mailbox.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 7906624a731c..fd3a9a60416d 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -154,12 +154,17 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
-		if (msg->hdr.size > sizeof(*msg)) {
+		/*
+		 * msg->hdr.size specifies the number of u32 words while
+		 * sizeof yields bytes.
+		 */
+
+		if (msg->hdr.size > sizeof(*msg) / 4) {
 			/*
 			 * The real message size can be different to
 			 * struct imx_sc_rpc_msg_max size
 			 */
-			dev_err(priv->dev, "Exceed max msg size (%zu) on TX, got: %i\n", sizeof(*msg), msg->hdr.size);
+			dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on TX; got: %i bytes\n", sizeof(*msg), msg->hdr.size << 2);
 			return -EINVAL;
 		}
 
@@ -198,9 +203,8 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
 	*data++ = imx_mu_read(priv, priv->dcfg->xRR[0]);
 
-	if (msg.hdr.size > sizeof(msg)) {
-		dev_err(priv->dev, "Exceed max msg size (%zu) on RX, got: %i\n",
-			sizeof(msg), msg.hdr.size);
+	if (msg.hdr.size > sizeof(msg) / 4) {
+		dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on RX; got: %i bytes\n", sizeof(msg), msg.hdr.size << 2);
 		return -EINVAL;
 	}
 
-- 
2.16.4

