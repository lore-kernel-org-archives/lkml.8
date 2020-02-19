Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D018C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1FE2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UH/m6Hkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgBSIGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:53 -0500
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:19013
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbgBSIGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sls1BjaDYpTjS4jLn5S4DNKDk3//061JBVCQG8yIQVTWRnw03tLeFO2GIWRiC3JrJ81KaMhLwhSb1bLWLn5f/BFFOW7xWNG/l+0PoqUmit6pzjqScfXe8wicH0bZ//TicrLyynjpRDx4GzewzAL3wtZ7LsaqexwFWMQdmn/TOTSuxo4gN89IKoI4nDjsoujKrlplYD+8DWJ+4WO47Ae8KaVJ3P3Moh7428legVP7c/z8fhhEUoyHuz6TcIhd1lEjlrp65cAj0IC7ROSmF0Fhmz9KUTWE9NOuK0LH8NMfs9AZXW6zEg9HJ6rorB7RVtabMRi0L4Vz3b0ynXb2amocKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r7WCLHcLFoWwVpV/BiXpejvT75R7f1kQDkx6C1M2tg=;
 b=LV26fxUnSfhBjBIHoInk10VAClcwHVRzQLPAGnz6QR0YIxyOQOrTO+hNe+FkYaCsahMdAhZrhHRKpDTnH03/Fyp3MFyPd+efWaNmPefARbsHtV6C/M55LAmJ93G00CRys14io03wtu5CinH2Xi90uqCBI/gQozALQ18JLPmojNkYYEXo6uNy3aaU5lh1p/RCbnntMgK4bjiT7jE2Qhah20vZuv0VuNd2tZ4dYFgBRs+zkW/6+MuX5sY14GFrvBUUwg6yFFZo7lCMYjMD2o8NtrPpam5yVjZERVCcKusC5uT3lViwkOA8Wf6ROwFt4JOXMYovrTwyMhhC2hZIXgCjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r7WCLHcLFoWwVpV/BiXpejvT75R7f1kQDkx6C1M2tg=;
 b=UH/m6HkxqPNChT7oy7I/lP0OQSsKDjRwmiVa7IJM1naeLPdXxPH4wGXu37sePgTxl1dNMdBBQKH4a792llLtxt6J0aqOrt7Z69mPr6RIm2Qga4bSaqesqqtWCWjoYoofqWi1NF7Yz/tJhkSCnLOEir0g2v4aM3NeUOP/wUIamMI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4132.eurprd04.prod.outlook.com (52.134.94.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:45 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:45 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 10/14] cpufreq: dt: Allow platform specific intermediate callbacks
Date:   Wed, 19 Feb 2020 15:59:53 +0800
Message-Id: <1582099197-20327-11-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5902c768-1b67-498f-3e68-08d7b512a95b
X-MS-TrafficTypeDiagnostic: AM0PR04MB4132:|AM0PR04MB4132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4132D27315568A9B5826BD1388100@AM0PR04MB4132.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(9686003)(6666004)(2906002)(6486002)(6512007)(316002)(478600001)(69590400006)(2616005)(66476007)(8936002)(86362001)(8676002)(36756003)(81156014)(186003)(7416002)(81166006)(52116002)(5660300002)(66946007)(4326008)(6506007)(16526019)(26005)(956004)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4132;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1K7IRFX4w4fYMdwS1znpcJVk1Bl7ifCqzur54bBHl4h4VuLZSLNCKXGjGtMXSE+SMBmMsiX4xpOpJrjNKCAYCqBXV8mDfexvc3cRDggQsda8k4NdYVzLyxVBxOoQNhl5prZRKvYh/bZTmeZ+pAb2SLD9bQCW3nl5ZVwJMes+KIeWuAMFkU7tTtam1TvlwzKRgaTTNZZJZAI6gsnULIR6+2hUOCDKyiJI5congpnRnOE/aAeZle2ylZnVCOXzZkQ1OApQ+Cwr109bs49/6vnzxMLbLRqMOwtJ7WQfQPegoZ4agBiJgNq+eaOmEXre4BXxPCym0F+v83hYk435g+3hP55FmhW95oRZUhX7JVtjYxWxiXEWO2HIKCSWcMqMOhr9jdvIkpjdchJJBmAAaJq29z9yfcKYJuB372B7cEtky4ai2oJ/vozDz7dyUZEYbtzO+QUYq35/ug96ngy+ORo8yM37jmnJXGaxLCFQUIP72G45nGSxeHvXrU4WPG83bI7GNf2nvnfAqt+utMS41BfOiAreRZRQBq4yVKTLPD+TvQ=
X-MS-Exchange-AntiSpam-MessageData: SpsyFl3uGQJx8LZxofr0nAuaFq0RgZvkF25ytLd347yPD6TAtqMdDatzN2HbfPfsVAfegizawR21JfNGiBb+C/k0bCC8ASmHiHZ7LPFKHh8GKzzjp1OFWDUfAAD3COA877mlvert2GVMYMeFPrIskg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5902c768-1b67-498f-3e68-08d7b512a95b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:45.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMmSl0QvVuUwQ8nMI4B0kTGdQhk7IKn+f+J5U9bYnaUNJn4644w8VWcGpA3Oma0yfWmHVuKP36n68MNV/DkwbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Platforms may need to implement platform specific get_intermediate and
target_intermediate hooks.

Update cpufreq-dt driver's platform data to contain those for such
platforms.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/cpufreq/cpufreq-dt.c | 4 ++++
 drivers/cpufreq/cpufreq-dt.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index d2b5f062a07b..26fe8dfb9ce6 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -363,6 +363,10 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 		dt_cpufreq_driver.resume = data->resume;
 		if (data->suspend)
 			dt_cpufreq_driver.suspend = data->suspend;
+		if (data->get_intermediate) {
+			dt_cpufreq_driver.target_intermediate = data->target_intermediate;
+			dt_cpufreq_driver.get_intermediate = data->get_intermediate;
+		}
 	}
 
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
diff --git a/drivers/cpufreq/cpufreq-dt.h b/drivers/cpufreq/cpufreq-dt.h
index a5a45b547d0b..28c8af7ec5ef 100644
--- a/drivers/cpufreq/cpufreq-dt.h
+++ b/drivers/cpufreq/cpufreq-dt.h
@@ -14,6 +14,10 @@ struct cpufreq_policy;
 struct cpufreq_dt_platform_data {
 	bool have_governor_per_policy;
 
+	unsigned int	(*get_intermediate)(struct cpufreq_policy *policy,
+					    unsigned int index);
+	int		(*target_intermediate)(struct cpufreq_policy *policy,
+					       unsigned int index);
 	int (*suspend)(struct cpufreq_policy *policy);
 	int (*resume)(struct cpufreq_policy *policy);
 };
-- 
2.16.4

