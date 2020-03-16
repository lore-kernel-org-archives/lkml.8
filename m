Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870FEC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568FA20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NIjuoNhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgCPJCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:02:40 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:23307
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730152AbgCPJCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:02:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgq/Sa2/ffztvPXhoQr+mcp2/tUTZ+GMAseQSNvjm0yLS6B8erAlsFzvb10oworc146FGmu0cAwjWdvctUqRo8U3RG9UDtFD+RsxZ6lVS6px9bTP9ifUH6pvW45KC8IBHHbKV/K73YsHo1PJzA0nM+7Sz2hREpmV1f3AMA7fP5IHpg8uIBLMr5o0Zr5HnjGSyy5x+30N23Zr+3ZsEJrsfUI1aGOkm7w2wRADojNz1ptUx8Soaq5Cv1Hs3EmiV88d5nsZFGlAVduPi8PJ8q59nFwncRs1IRFRDIX41xxnFkiCrHtjR7LYedq7l233huNCQM9ptGZ4+C9SGibrJ0EcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpd9L9SgSY1N3Zm6JZQ454retwPpG5K8MbfRs+j/FuY=;
 b=R023f4xHzUbNO/0Y1VdiZSzy/cFI/qi7hDi5xCEpkkn3ikbOyAJ3ZzKtgjZrB0+oP7gkCEBMHPmeW/wteV/bksul8SwQx4R9iLQKQzynkN9n9gOFd77Hpf/m1OEA/1y9EasoR/4Ld20e+yHRsLIOfukimSR7EpshaWW2isIKU+Gy1ggRQgbQ0rulAPnbyNlG2sYLnqv49JrDzoJz12oGxyUm6+YbVdOE9WcgZ+krZuMS1mR1s7Mxgmkes0+ARCGxTkOeSyuu+K0Df0mzhTZl3+74DxHJuor9FnzAO7GqqNY/OFZNI4IEbiXpr6z674iZTgbMzM9bk8gHi8R95SwM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpd9L9SgSY1N3Zm6JZQ454retwPpG5K8MbfRs+j/FuY=;
 b=NIjuoNhna9xJCfOQhDizp8hL1MYks+dQhvKD/U0apdLbYldc1Pluooq4R79o+of08L6isk9ugW9sfM3rLAjhtNmz+63TeT7/Ny0FGt+Zr3GZGyNNJiQeN7NnH41KnLi/HG4GWKgcvodJIFWR/w6eBoLyZqVrWcAqlpOZvB0RaT0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7169.eurprd04.prod.outlook.com (10.186.130.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Mon, 16 Mar 2020 09:02:35 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 09:02:35 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/4] ARM: imx7ulp: support HSRUN mode
Date:   Mon, 16 Mar 2020 16:55:40 +0800
Message-Id: <1584348944-19633-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0126.apcprd06.prod.outlook.com
 (2603:1096:1:1d::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0126.apcprd06.prod.outlook.com (2603:1096:1:1d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.18 via Frontend Transport; Mon, 16 Mar 2020 09:02:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b632aa70-847c-4022-a731-08d7c988c48f
X-MS-TrafficTypeDiagnostic: AM0PR04MB7169:|AM0PR04MB7169:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB716949DCF5AFE2B1BD39B9C088F90@AM0PR04MB7169.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(9686003)(6512007)(4326008)(16526019)(8936002)(81156014)(81166006)(8676002)(2906002)(86362001)(316002)(26005)(186003)(956004)(2616005)(69590400007)(6666004)(36756003)(4744005)(6506007)(66946007)(66556008)(66476007)(478600001)(966005)(5660300002)(52116002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7169;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5U+lBGTBdnXM/g33M1YNLpVc0O3okTjM813cg4FIqcrPcupVPbFE1FPMIhKPjyCQKIZyGeufFo+IAzHTELjvJCI+Wx0gfNxbgsTDe87IT/PhgqKJWarT15vy4C7GDqpPl10HeDiOerGe4xATOzZRPnPAYOzGj6MIux2TobKGmvPMwzHMobeeg9Rw1h7QpafgI9OZk3tchKkAns2pVX6Fr1ZUkDH+EJBEy85WQWv/fLZaS4T5reMOyJu738YlpHX/TuB/ckWbiERUfqOioYyytdLJw/hIPYqqRkQgXzwFu2WYZxhJN+EVfR5VbjflKenhwcbywWEm8iMsR7SLjgjpk39/UGc1LDcWNRUHGfCbbs/15wGvdlSnyWAQjO8ljyl/dI3mEmUTUcwAa5Qs+Kg3gLBe3gb32kHQNGxlp0HcXCcuIZH/T2VkbqqkQquhALuE1kl7w30JFXzp9tNUYAC4O51Czs3RP+sfvcAGt+FgFsgiIZ44yqUBlYb7Dziu+kvEuk5gYyJ4k+goqZ+mHSIFTJNYK3R3l+wH26AbiA3ogv73wplCrnOhSOQGkQWpwunFA8Nxg6tK1tu6Or+zhd0qRA==
X-MS-Exchange-AntiSpam-MessageData: fUIn+BwH9ZDk0DuRYFaeGbFcLI6X+Vphwdx0wIXcaBUPm2425lkJZeYXAm608rYqCi0K0Lm5LY9hj0JeMteWV42GG4uYx00oIbRDuSTvcUr/fR0adGqLPGt3UDI7yXZbn1IdJGMm2MydFiXbO5byWA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b632aa70-847c-4022-a731-08d7c988c48f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 09:02:35.0016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXyfJexwOW2brU/+gXztr9VtRckGFAeQstLzgxeiCyVYpaXZfvEzaK8LTnozKy9rF1ILPGI8jS04UAWiCYUEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is a splitted part from V2: 
ARM: imx7ulp: add cpufreq using cpufreq-dt
https://patchwork.kernel.org/cover/11390589/
Nothing changed


The original V2 patchset is to support i.MX7ULP cpufreq,
still waiting the virtual clk being accepted. so to decouple,
this patchset only takes the run mode part.


Peng Fan (4):
  dt-bindings: fsl: add i.MX7ULP PMC binding doc
  ARM: dts: imx7ulp: add pmc node
  ARM: imx: imx7ulp: support HSRUN mode
  ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN

 .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/imx7ulp.dtsi                     | 10 +++++++
 arch/arm/mach-imx/common.h                         |  1 +
 arch/arm/mach-imx/cpuidle-imx7ulp.c                | 14 ++++++++--
 arch/arm/mach-imx/pm-imx7ulp.c                     | 25 +++++++++++++++++
 5 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml

-- 
2.16.4

