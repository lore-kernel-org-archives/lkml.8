Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A345CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D88F2177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P1YE/ZZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgGTClj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 22:41:39 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:60999
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTCli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:41:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK0QheB+YkCxR3QRkltz6rLcjvSeJVJpSz1oZxGtcZ9dv2SNHyYfKcVB0YkxmcMIt/Ej/nNXKYw/0R5m10CXSfGOib6wNHUJ0rRiEPQvlww+n6YIT99Ld4a+dqVNTm8ZDUHtZ5n16RpvZbMpcl+4zFbIKJt4OKLOLPxdNA9t/wc++0oTL9k0bjUPtvp0spUcbAnL3Unr7HMGRzFyy1pyWirP9E4u1O9eUFhqaKvs4ZOofUK4L8rwYfovOexQDmm/W5lnpuK7EC2/II+XjM01RBVY98pTk1gnJ7N7rjQcHEmMqkWqVBp1CnrkG/1NViPKg7A37No7yU2o71rjEke1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfUI7vV3z3lKlxBkLkVl9wVItVJTuUe69HaeCXZq4QE=;
 b=a11sZUcm0f9gZmUryUN8NP+qtcsxYPcurvcRszqhVj8RzL4ybwtHI9KTI6LpTTXuqs49ezc57W1T+1I3wKdwlRcFfKvHKEyfAcq3r1UNbQYHLL37/96sHE8AtRx4rWkhIAFg3Quqn4OnK1RZgDdZsWw1X+tamrObSNWTM4By8gjSRrvsKdMWf28Zdayi+HIHse92HqioNl3kJF5+0SMbgdjRSlpSwSazEi5RqyaicTdg9H67YA8O+lDA+4cg2Kz9ayqCSTVr0NISgYZvkDn02fyhONs2smT7nunamb60QusL8CVLtApUTcKp6cLQfhWNSlTruoyJ65hjZsfqtgWSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfUI7vV3z3lKlxBkLkVl9wVItVJTuUe69HaeCXZq4QE=;
 b=P1YE/ZZ8WGlXaA0EjpF9c5a9x8yLPQOpD6xNeWhWRwZfoHnaGD6alUBOd4X6goP2et4lMVnhi0JoyyCd3yrR+rV8JH7DV9VlSBn7aSMn9WD2NfBQ9QV5sx/WM87vw2i/31CMIJZLrDjJlN6ziNPRz/ezbzt8Mtvp4VbN5uXiGRc=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5884.eurprd04.prod.outlook.com (2603:10a6:10:b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 02:41:35 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066%9]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 02:41:35 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/1] irqchip: intmux: implement intmux PM
Date:   Mon, 20 Jul 2020 18:42:36 +0800
Message-Id: <20200720104237.13119-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:3:1::11) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0001.apcprd04.prod.outlook.com (2603:1096:3:1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 02:41:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b562c09-c399-429d-0977-08d82c566b67
X-MS-TrafficTypeDiagnostic: DB8PR04MB5884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5884F5EDF0495465665AC6F9E67B0@DB8PR04MB5884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:281;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0Lx0rftwQddw7g9Z029t9ZZ2sJATZInGHM0vfXmA3NImH1GbcJTHacrLb+y6aYlWAN6WsczVjCecVylj2rYDxL/NAinsAMdj2KUMOEIuuaWf5V8NZXoR25BmpmQ283hc/CceGyW6vRFEnX7ZI0CjxrnLTaTna0SZEHg+eWKlKuSNdvGTj6aFTcso+eGxEUliO1J+2WwqjqrPMaU+Oo5Ss9kqsfsmxX82ueHzNljypGlJcol+bLfUXUp4WD6CephnlV0Gy0/wJFXp9bvbMOtFKEWES51iTDDAXK+h1iMa59XFhZedV2h4ijt0j/PWiqA6Zw8L91kYGpimtaRn8YzaEQUcDjM1B1XXYP3AiO73KAU+ivCfB9TAZu/txi9djMS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(36756003)(86362001)(2906002)(5660300002)(316002)(6486002)(66556008)(26005)(478600001)(186003)(66476007)(8676002)(16526019)(6506007)(8936002)(1076003)(52116002)(66946007)(2616005)(956004)(83380400001)(69590400007)(6512007)(4744005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2R9XdLvdOhbuXegP/xYoUAySAq7glQX3tEsmAYdm//RXHfrHGWb5KzTqwWue4Zr81yY0NXahMt0SwRlCiojJVJfUMfOYll0sMdl1BRqXUvKB4eL8eKAjPpDVTUDU31P5JtcNpd56FFZ/O9f4B5SnXRTURr5rZf9uPmPr3NOZDkdG/hbuxIeGEAL13lKCygPAHhV3T7tZTRX8YT4my5V+udtusEB/g6iy1y2cxRKCCRjsI1FBXzeKiWkQHGt0ywE8f8sGhBuTFVT4CdF9Vtucs4Kff46+GnKyG5a0Ad2agJyFpHFkk9c4K3K0hzEK48aDHxIZQEI7gjKroOrcZ66HaqzNxAsViQciPWGMuzJVoqCQrFqY4J//6uIMo5YNqfU5Hpxfr92IwQCfTYEfBvf4wQzuSc1wfLLDVGtmHB3iiftt3k4L0oasT/2K31TcRSJLQEi05ei/pNmbAgzSbt1S2ca2yRdrRTFwYIYqYFbswRE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b562c09-c399-429d-0977-08d82c566b67
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 02:41:35.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZznigJBl2M2sZ4gwwxLYzE9Z9qqsmM30MbZt9lGfIjkBYsEoX19/85MUQBmzrURh4mnM3iCErJ4w1QFl9D05A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch intends to implement intmux PM.

ChangeLogs:
V1->V2:
	1. add more detailed commit message.
	2. use u32 for 32bit HW registers.
	3. fix kbuild failures.
	4. move trivial functions into their respective callers.
	5. squash two patches together.

Joakim Zhang (1):
  irqchip: imx-intmux: implement intmux PM

 drivers/irqchip/irq-imx-intmux.c | 70 +++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

-- 
2.17.1

