Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A738CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7968F20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gcd2iVHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgG0GQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:16:50 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:13454
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgG0GQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:16:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQZR8LquwqhuRiW3iya00q0l4huXo+8XoJlsNsGcYE3LVVrzrTAX4kqIniR3350jqyxsBq8QK5FNXjJJviu4U0jJ5gIKd1ZINP3ujWlZJE5ABz+3fPMTvbgpEbsDmy08ZDlAmUrus5hwLRYdcnFJ14IbT1qWooJ/txYQKee0OhW9cR2BbwZjUi1fMUpJssiphfAN4qSdFZdfL8tOmKUIjPafA5a5Tvviwuk6Ephy1oa+Y1ly7mwxXtfEYk+Vi7SrarOlhgN4FhTK0BLtkv/M5bN/e4b+r79v89HEpb43+AAPynk5CugxPth8jD9A9o2KIWsI8LetmmArhR13j9/4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hjtqlH5NIw2Y7cHHIzmSwDeTeNJ+cNmaTGoJtTKFbg=;
 b=Ed3vcfvMl7T0SU/ftDCgkB5EAVc0XIWbzKEJxs5e4wnYs6cF/8pqR3xzYRwaTwncd7dvnSdDZNZdYHRdd4p7ICxtoYTiTBlVcTa3InFxKaNBOOzh10I3/C7F2K0E0ozvJH6IRl0TEg1if5NQ8KS3UYPLxlaMrOjbVUoinVFslND27SIhzOiikzmf5bYzx+GncPlCRuFpuOYpKVJa6VdCTHtaM1oSV802lcGrEZUdpVuJinOxxgeywdRXVBSzWJrYQmly1i25Pi0X1EOgRS6g/Vf+J1NBiWSMn0b/b7adPO9b6/ocGQsCWnI6WBH3iQOGOAlMMswmdVv77VvWsl8PKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hjtqlH5NIw2Y7cHHIzmSwDeTeNJ+cNmaTGoJtTKFbg=;
 b=gcd2iVHUPUjKMC+ylmV/JiQvDhucMhPJEQzCZn0wXdlIfl/hpBtNEFl2UR/7GKojTD3yk815A/KygfOt7WboDV7mjGKo0SMSKv2o674jmyvVsUeTTQRY7mbTUWWhOcx4YyCbkQvhbQ3F5ZF6ZMsjs1g5dZLtv1cocqA3KCsHguI=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5305.eurprd04.prod.outlook.com (2603:10a6:10:22::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 06:16:45 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6dce:e74b:4350:1be5]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6dce:e74b:4350:1be5%9]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 06:16:45 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/1] irqchip: intmux: implement intmux PM
Date:   Mon, 27 Jul 2020 22:17:33 +0800
Message-Id: <20200727141734.24890-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0139.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 06:16:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 925b2bb1-5d5e-440d-9b27-08d831f4a353
X-MS-TrafficTypeDiagnostic: DB7PR04MB5305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB53059A4577873E5F3FDEEDB0E6720@DB7PR04MB5305.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:217;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lM/inzeI/sImCG6MR3FBX41nfIxzqpsIIUzFg39KF49zPPI/hy2U2A5/NW8E7zbGsQyUPFrps2RrzMhTRs1JMYyw4eAwti4cDMQoGu+KoBOEBJuKFMaK39WkEMqxweSm416aEx1kYs65XfX77RAEiC/N1cBzo0RJchj9rP1UNxqk1AodfXr5uG4I3TT55YmQJtAGWgZZXg05q+FygZnY9hASuF++5uAbv6vT/37iXl2kFVltM2HwOkpza7OQpaUr2oKU/XHX6PK14ShIFSIdEPi4khvJSzCl3jF97XBzx+QydRH6gMTtjL7L1nVW8REVuF9dRDN3rYQ1vlU1elmYvlllYzoSDKx4JZ1qDd5WJf3Cw5gUQb4OHHi3JHbEPog
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(16526019)(6506007)(4744005)(186003)(52116002)(956004)(1076003)(2616005)(26005)(66476007)(66556008)(8936002)(66946007)(6486002)(6512007)(5660300002)(8676002)(316002)(83380400001)(86362001)(69590400007)(4326008)(2906002)(36756003)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xyeb3fID0VlryShbPoZi9OIXwF0yq5XN9h1zpXIVbKbfSPZR2uJgOOFXWsCXkn+jUQhU61ixjgLHbW1z1LnNVkrG8XKqNKKt3RRRYpnxtAKGR38mej7iQ0Q52mQvDBV20Wrj5IswukziRrbf1ihq7O0HLuuSxTvedSWPriQSBXJL4Dit0DSLalu2FxF6lTbmzbPoTp1z3YI7VBpfjtb2uA+w0Wm/WLm8Tb1dxmNQibb7+CPGupfBIFJ1/oN/aGadyOt20oBrpJuR+O/rUEIlPZMKMY3ez+eoHFkkQflkpj2rQtQ4MYeJD0YzFDIeuQeV7I7WPLlhb7uBeR1H7UiUZyr+acD8vAPrAtwv8znz2bQOmlYza15w7zqJHusvFuHgvKfLTE1m3+oUHXgHpRZQcgERnVawZ1eYzcRfmtIXGQSTagXPnXJzMxLoM3Qmthal2sxjDS32luPtz8g2qhyD++D1CuMDGV+izvT6VsYRXvo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925b2bb1-5d5e-440d-9b27-08d831f4a353
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 06:16:45.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btTwSd034meZP661nMFydbm59sVVxcaM9kHWIAJnz7RX7OcvBCYPifH8Q1SVgF/xcOlMbGFhYwQIkKjcRvulKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5305
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch intends to implement intmux PM.

ChangeLogs:
V2->V3:
	1. allocate u32 saved_reg for a per channel.

V1->V2:
	1. add more detailed commit message.
	2. use u32 for 32bit HW registers.
	3. fix kbuild failures.
	4. move trivial functions into their respective callers.
	5. squash two patches together.

Joakim Zhang (1):
  irqchip: imx-intmux: implement intmux PM

 drivers/irqchip/irq-imx-intmux.c | 67 +++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

-- 
2.17.1

