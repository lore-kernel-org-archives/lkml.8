Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A34C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360B5207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pwSS3oiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGPLbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:31:35 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:60039
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbgGPLbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToHjxCe4xN4KTb6Iodio4iWbY4NSCxAuGnMmpOINQDRadML0LnnWTOc8VVB9uio3uPGMQ9bddKAh2r8jpGrXNNm+DTQVvlrKnWLzb+DfDj+RIfIYgZ3p0gcGYW+38DfvrWFZhlsSFqxJQ8OypyKHjSEXqNhWUTk9Cn7q4/YUHpTUsp9ov057MjHXU5/v3ru7ZP5LN3KjKlseANhPUhWsa8EFOwMKYC9MKRphK7NR54NMalNPnf97FWDti7MaeD+c/GiJbfOPJH4HcmKT5QabMIkD7Cdu4+1o5rK0TcHzFINOblKJo1LSERRjIJ3q5PXt0QKrMs6Pbq6ro1HPYLJd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE8l35cyNsnbpzPvyXV6zCiLtCcoMryNErNyopbZbt0=;
 b=MBK4SK/hlEwfYyRbJynGTWlW9FOCZWqtuTnMK6THCdvZfwpScQpa8oZC3hcz3BBM/XZLPLCLzeRnW2o34sa4Yr+N69YcqPLkjBrqM+9+h+rVKteCWYyTlgJpxImDsKAqFFya92mLRi8/pEQa9ASUUIxHVVQaxDE48ldAwMGuoO5+jfxZgpEMmYkbkKC6muXNdjNZ8IRoo7ZuNEAJcbPP9dtf2sNd1NKLLCVeOHw17Mrcnacb/ytx8eKe0x1tCnFBkciL3KuuNEbe3prpfY41X9CjsMGaaC0UQ7OT2tjUrglKQkMhe6euHSWqTZ8U4VfdTcl0TiYVRjkLAqhPU+CMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE8l35cyNsnbpzPvyXV6zCiLtCcoMryNErNyopbZbt0=;
 b=pwSS3oiS0EumRNXsQ7rvjtYVNMQiQkG8FPKhVqTUN/GsRpExRh9AKGgCHc5Cb+Yz2wzcM6tODLhi7YjJcoNI0ZB1MWEEEp2mY5DZQUFxpjH3BrIYzQgze4Yhe+sWMWV/jPg+WccF4M/SnH+ywIWHY0UbGUU6NcF2k2Y98a1E+jU=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB3PR0402MB3708.eurprd04.prod.outlook.com (2603:10a6:8:d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 11:31:31 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066%9]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 11:31:31 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.or
Subject: [PATCH 0/2] irqchip: imx-intmux: add PM support
Date:   Fri, 17 Jul 2020 03:32:42 +0800
Message-Id: <20200716193244.31090-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0223.apcprd06.prod.outlook.com (2603:1096:4:68::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 11:31:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e319000f-24ae-4f3a-2fb9-08d8297bc979
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3708994E308DADF944CEB256E67F0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /03FiOBOfstzOxPOftCULiFooB5SwoNC9cP7ZPtCealNyNiOuRYUNYlGSZ6/oh32cuTnjWjw9hvCiME359oBb3fuKgAzFlIxVF43SYZnmxtZmVxKOBHaEAYLIzoIoRt6WFOX38l2EQMh/8kqeoTUqUohPB86VYClX08fV1ckefns4LZNWZw9ODCkdCFa+W4gRgeukwSR0A2JlqSeGAcUWu2OG34xMc7l5Xx4D9dHM2FL8rth9Kc/EyYrM802uWe9BST9wYYDvM6Fok0rR69RmFa0fautyky6f6E5HmlOTqeL1lQsytEYnn5XbZKJiIL0+MwT/7PJKzrduy/4MINFaVkHS7V7OU7sb+RJ7lfx/gYprJiDaHKpOJj+lSh8tqdM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(1076003)(8936002)(8676002)(6512007)(558084003)(4326008)(6666004)(66476007)(52116002)(66556008)(66946007)(956004)(2616005)(5660300002)(83380400001)(6506007)(478600001)(6486002)(2906002)(36756003)(86362001)(316002)(186003)(26005)(69590400007)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hmZ/m4hSEPux5i3iD4ZoB37wQFhfIA6rk/QmIV2gmThn2a2oggAwQdjjT14jkWLiXOT8xl3CHu6vT571cL315tWvulHTROpEh772DCPApYJuuD3BOA650Mql+3Wl1mIY25gOf9zKk5gZxjwnIawCNtci2jEWWGTTqmkv3O3YOterDr8bUTrf2vyBv5y2q2q+TPgdQMK0uycQ3GJ00yoyPRCe7lLyKAuHLvQuLhPHhvsbV+wXQCHuRfabsV/poE0WYjRHt5DzWvAA/vE8pe4tvCVmANb1U/50XhIvPAbBO6F9Fc71W2O0wwJfHRnAMaQ03rgbL83DYrh0ynNlVl3qt7QyW9+NcsyHd2tukeHozgvwKxNEJpN8lDt5IeADN2QtgPNu96U92abveb+RONOXnc1cRb+vLWyEXECfq02ZQMZfdYB4m/YBiNC5Luk9ktEciT4MrzmRoC2md4XhNpCvPUPYZ8uV1PeUWK8iqeCTcWg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e319000f-24ae-4f3a-2fb9-08d8297bc979
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 11:31:31.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Is2BzpkVHE96SA9CtirsztaRPShARp5zxfaGP9QQ/OURqc7aoRg9yw4U7V1O/pbcUCsH0aBY4g+FiQGzn0Z5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system and runtime PM support for intmux irqchip.

Joakim Zhang (2):
  irqchip: imx-intmux: add system PM support
  irqchip: imx-intmux: add runtime PM support

 drivers/irqchip/irq-imx-intmux.c | 82 +++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

-- 
2.17.1

