Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA0DC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546A02074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o0awVNa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgGXHn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:43:58 -0400
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:26464
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbgGXHnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:43:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qct0S3GJG6MZiot8qDwOKQRlMDN2X8+Re8FsJreACPW77xgb7a9Kax55fvPaHuF4c4IJ5EfuSgn1wPZ9ONAwxeOVRbAV8L7iCVZKAx93PlzHzqD6zZEAiqY8oarYGIFDwF0v1tHa92PG0g5Agwo7+ha8YsTqadAScgNcn//CrT6rkIronWoOoQcYIIJ/xXVPGTZSh6/vXU7o00jLJ/QHdd9gaGKId4QXRt5K5PlUI5dxHdh6pKqtxByGPhBnxWlgb9mUf7QQAsIWSar4vr64vmv8bQTUJd+SA15FEwFZcm3pMvef88hUi1F+L4ZbiHQO0Wwioiph4S5m6DRDCnt6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhuUE7ee1k1h3yS9lk8HoshtF1lfSheIfdm5bhrs3BA=;
 b=hJ9F4qO0Y8ZvwKOHI+o58Y0PUz2JpQrlxupP0W0Vu4oaKhf7buOVEvquZBFbivPRbAv3gn14wEhjDtrUWbuIcyNbXggkBftfNNdWp2MAazIXE0DNbXltMKRYGoJ5NkurdneFKQEtYAZNsbreCmK0HHq721wjf40M6ibwXsZdLP/JKp1IlhMvUzy9ByBfOdiDerFc+ydx4MHKbXJoSXafROeQH4+RQTzs6tLYNd4744U0SKXJeChA28H0lrVlh+rj3QSFOldmKQjFL5HcK7hlFvj59UrmNmlHsVWGl870pkjW2eSKKsMfhk94YO0DsHjoe88luV7ctHccB90jL+lPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhuUE7ee1k1h3yS9lk8HoshtF1lfSheIfdm5bhrs3BA=;
 b=o0awVNa5CAtDIrLXr21g09y9uLrZnH6kLUYd8Q5AikCMsqW7qKnnunAhw9c3U5sLnHO5D3bO2hMfl4NAWOXXAjulNCWNF4J5cFmkTGkoQ1j3S4jrhC4nHyW91kUCJ1P0LPAqR+NPCRBCnHSWDqDvoY9DzyxU2VoDHRu3WK3Nq8U=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 07:43:50 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:43:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 05/10] remoteproc: imx_rproc: make clk optional
Date:   Fri, 24 Jul 2020 16:08:08 +0800
Message-Id: <20200724080813.24884-6-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:43:46 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69227ae4-e128-4523-1ee0-08d82fa54e2b
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB685800E838050355A1EB8AA788770@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gx3o/Z9ptJH9ZZJXcPUIqNGvsZcl4mcpdDx+O5JQ2xhXLmK2JpIS8o9fpbrFLcYPVOsc00k8h+uQ6bq+NF6GTlG3apgzQf+k4+VwuEFJW0iiKUeIMuyRvjiYITeaLViun+v9ZRCs4Oqv8Wktwb8+0+nKm3bl5/pCPUwwDmIgCU5bPX8SAilzwBEfWEUU/5y4saSEaXzIZtFM6AtlOhwigrOHQNa2tQ7USa0tUxBT2pumaVRwU7Qs7amTMAvEhB4PUBii+RkdRCZhSvR+9P1dPIzHgpOFmY1zYdUM2p7o9kXaRpSoVKcxL5yMQOilvOvEc7Wa6CcvTI6ejNXhe76naQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(52116002)(36756003)(83380400001)(478600001)(1076003)(2906002)(6666004)(16526019)(186003)(26005)(6506007)(44832011)(956004)(2616005)(86362001)(6486002)(66946007)(316002)(8936002)(7416002)(6512007)(66476007)(66556008)(4326008)(8676002)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mGUoIIONerSKVNR6TzwjYXhQ1cHC7L0471RTG3Mt83uiq/OxOW9k8aG4bBMZDlBWvjsV3wdevyntf9m3Hsh18EqY8oDiyCE4vb2OKv5DGooPDgz8HIvfXBqbsz00r37l9oKd/jd1mjAkdUeV6V/z3LwfJ29cRT4ZBueNpOF8ctcFerXJlRIg4J6KtpucDrBgVDCesSOpzlH+3uSeOB8QuoNcMeNlc05V+OEUuDYvzph41tN9sYsbzKdgtY076DXb5i/mzODlVNA+ex+/lV7yB3kg2Ip1r4HOG2CaLq0hA9I7xYOFQdMZd/xWHYuTIaLLeLdPT+b78BGN2hwYelb9sJir5dIFdKBRs2wAIqxBSA/FU41/IQuvIZiFt03Dqq3nX2c71mr0vmqsHFLarzz4hXoofXTqpDPgqvRe/QMUjgKKKIpHe/IC0J4b4M/YMcA0KX4sryIwWmpsUo7UoCfp6+syTrp0lgFtXCxt+1DNjeIEmSTmqVgAnkb1fXB274oN
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69227ae4-e128-4523-1ee0-08d82fa54e2b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:43:50.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQgTwVvXQin7F2MExJ4LBtUPuqXN1vacCUX8B609N4vsYb/zfoxvgdPk7GOI7tp+TPALHutUkbN7zXWFhl8+Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To i.MX7ULP Dual Boot, M4 is the master to control everything,
so it not need clk from A7.

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 4fad5c0b1c05..aee790efbf7b 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -362,7 +362,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		goto err_put_rproc;
 	}
 
-	priv->clk = devm_clk_get(dev, NULL);
+	priv->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "Failed to get clock\n");
 		ret = PTR_ERR(priv->clk);
-- 
2.16.4

