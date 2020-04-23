Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB3C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAD721569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YrOYNPBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgDWHIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:08:19 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:41583
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbgDWHIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvhlERXeRZdraXgxVHAwsZVM4AU6DVw9X/JP75DOLp5J0rvaf3A61qe9Gg7GAoKRpvn/d5WApofhnBamorqKddLM2brsr+QITCLh7L2BgQqfzT3qIi2QCR/xjQkzKHrwFIJxPFopEwe815aJtW5dNIQqCKADY2rz6dgFuaRPLpMV3fK/Qp/xl47FjbBEXde9KM/ZYlanrzjFvGNFMVmrgkxA7wj7SfvbGcYFxS4gVq1KxxtLH/bObS28vHh1/HEMncb4TSVotyZWj76SIWEcUXGg3RnekoC4ARG5g2bEBj35udDF0+jUAdeItkrzk8Iz6Fj+lEL6/xe9/lUgBlpDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhit6daLgvESWY1lrdlhIsSktyAJRnbDk/MGaZUCvhs=;
 b=W4h76e1AtEfIlwMVnje8h8DKW5Snu5POo/eqr/ewbQKqAmQmnYNttUSxXIGH3BXVisdJwJdDZRXLoAmLbr8eFSle16H2eV6AhH9eC32oPrjEW+UGjHAYBFh2c1IlpLqImpNINm8e0lz6tocLaoT39MAbnSdW8C4pjYBLS0ck+IRRdOOJj5xvBgrGviOl18N7FthMeWXZ9zbtP6xnbxGcdt7YWR+aKKhr0JhSQgLY5UuZYDANocWDntjRZHX2RStB+Xn5kjeTYbz0cl5K1ig6XXSrGh4kf5CStPINKMD0z+o+ffWHLvxqHbmw77M0jYev2BDlNyMnX1A9qRTMPIWybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhit6daLgvESWY1lrdlhIsSktyAJRnbDk/MGaZUCvhs=;
 b=YrOYNPBuayxsrKGJ3IlQA2mF4vImy5aAyxNjTuni1a0kgsA+qD4gpSlE0XE+3nSe8q/e4ceYPCuMTXEX2Fr0J2odPeRFm6VTQxPVAbeesXrOUZrEcYWR7iEBDEuADmjOqYD91uj6MKXPwBdSFbyq/q+GNkd4R2K4NfZplcRjQlw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2855.eurprd04.prod.outlook.com (2603:10a6:4:98::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 07:08:16 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:08:16 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/4] firmware: imx: fix/update cm4 and add resource check
Date:   Thu, 23 Apr 2020 14:59:30 +0800
Message-Id: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0149.apcprd04.prod.outlook.com
 (2603:1096:3:16::33) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR04CA0149.apcprd04.prod.outlook.com (2603:1096:3:16::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 07:08:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fac8b1e-7964-4b18-05d9-08d7e7551811
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2855:|DB6PR0402MB2855:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2855FB28E991D7D7EFB1E59B88D30@DB6PR0402MB2855.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(26005)(66946007)(4326008)(6512007)(9686003)(66476007)(4744005)(6486002)(66556008)(69590400007)(6666004)(5660300002)(86362001)(8676002)(81156014)(6506007)(52116002)(15650500001)(16526019)(8936002)(2616005)(316002)(2906002)(478600001)(186003)(956004)(36756003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWu0appVmtPulYUS7mE+yZVKOJwig2OWwJcRSV7HZbjj/4//MJSxlo1Um/NTCxSru01mMq4/wwcd606+nZXc12mdCWGk1OEBCNKzjK2iXKV+dpQ19vF9NELH1REBeVzYD6mwFY+EDT0cj+2lO94vy9+qRwgl664rYbVCNXYJ0MvvFQaeIqdrBMkdUmiF96rGmPE5aWe0OFyJCAe8MRwcx9nlw8ZoIBbQ+jU5Sa7Pf7klNEuk8+Pdhu1wKYLnvq6cjiKd5DTYNepC/HKhKbuNVxCdb+TP1cZjsSAtaJlLkc9je4Xsx2pfOruAsY/7ZP+RKew04AcXFuQQTeZcSfEQhAOCU7FFjMyXZ5yYMU31wdPU+Whs83JubKyECCEFUF9VP3LxuMslFfDVj1bPexYfIOTPrbZVHZU0MGHkQ1sFB9aOtUrN9X2Qls1shzLRNlZBxuV9VxCXY0nhjy2enueZOxuq4UTqEjIl5G9a02Pp/7QGfj8Nx0mhkF1UrOlLWiLp
X-MS-Exchange-AntiSpam-MessageData: JqbybHz4PQJWJHGSe1r8qWKsH4tOQS5AdAMt9GdRidEqYdZRd010Ra/Dz78aUqUN6+oQdFdv7ZUrAnhtZiUW8dwLKZZqhJetxawnEWrdgRxI4U9Mvg07lxZxLPhGHYvPKO8QoxMpDZpJ17GcoRR1Lg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fac8b1e-7964-4b18-05d9-08d7e7551811
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:08:16.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uI76JPivXexzYeFYPtWsm3KCi9tcWt+M2IQLbPfn6DQJ5aKVwlgNPqbCLN24skUpNALPIwggkcaQ/zoRH/BwuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Fix cm40 power domain, update to add more cm4 resources
Add resource owner check, to not register if not owned by Linux.

Peng Fan (4):
  firmware: imx: scu-pd: fix cm40 power domain
  firmware: imx: add resource management api
  firmware: imx: scu-pd: ignore power domain not owned
  firmware: imx: scu-pd: add more cm4 resources

 drivers/firmware/imx/Makefile       |  2 +-
 drivers/firmware/imx/rm.c           | 40 +++++++++++++++++++++
 drivers/firmware/imx/scu-pd.c       | 18 ++++++++--
 include/linux/firmware/imx/sci.h    |  1 +
 include/linux/firmware/imx/svc/rm.h | 69 +++++++++++++++++++++++++++++++++++++
 5 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100644 drivers/firmware/imx/rm.c
 create mode 100644 include/linux/firmware/imx/svc/rm.h

-- 
2.16.4

